$DSC_ExcludeKeys = @(
    'ResourceInstanceName',
    'ResourceName',
    'ApplicationId',
    'CertificateThumbprint',
    'TenantId',
    'IsSingleInstance',
    'CIMInstance',
    'Credential'
)

function Convert-M365DSCExportToPowerShellDataFile
{
<#
.SYNOPSIS
    Converts a Microsoft365DSC export into a PowerShell data file.

.DESCRIPTION
    This function converts a Microsoft365DSC export in .ps1 format into
    a PowerShell data file (.psd1) format that complies with the structure
    used in the M365DSC.CompositeResources module.

    It uses the function ConvertTo-DscObject to convert the export into a
    PowerShell object before converting it into a PowerShell data file.

.PARAMETER Workload
    The Workload for which you want to convert the export.

.PARAMETER SourceFile
    The file which contains the Microsoft365DSC export.

.PARAMETER ResultFile
    The file to which the converted file is written to.

.PARAMETER SkipPesterTests
    If specified, the Pester tests will not be run on the converted data.

.PARAMETER ShowPesterScripts
    If specified, the generated Pester scripts will be shown in the output.
    NOTE: Does require the use of the PowerShell ISE

.EXAMPLE
    Convert-M365DSCExportToPowerShellDataFile `
        -Workload Office365 `
        -SourceFile '.\Exports\O365\O365.ps1' `
        -ResultFile '.\Results\O365\O365.psd1'
#>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '', Scope = 'Function')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Azure', 'AzureAD', 'AzureDevOps',
                    'Commerce', 'Defender', 'Exchange',
                    'Fabric', 'Intune', 'Office365',
                    'OneDrive', 'Planner', 'PowerPlatform',
                    'SecurityCompliance', 'Sentinel', 'ServicesHub',
                    'SharePoint', 'Teams')]
        $Workload,

        [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
        $SourceFile,

        [Parameter(Mandatory = $true)]
        $ResultFile,

        [Parameter()]
        [Switch]
        $SkipPesterTests,

        [Parameter()]
        [Switch]
        $ShowPesterScripts
    )

    begin
    {
        # Test if the ObjectGraphTools module is loaded and the class is available
        if (-not ([System.Management.Automation.PSTypeName]'PSNode').Type)
        {
            Import-Module ObjectGraphTools -Force
        }

        class DSCConversion
        {
            [string]$Resource_Name
            [string]$Composite_Resource_Name
            [hashtable[]]$Resource_Objects
            [boolean]$IsCollection
            [boolean]$RequiresUniqueId
        }

        function ConvertFrom-HashTable
        {
            param
            (
                [Parameter(Mandatory, ValueFromPipeline)]
                [System.Collections.IDictionary]
                $HashTable
            )
            process
            {
                $NewObject = [ordered] @{}
                foreach ($entry in $HashTable.GetEnumerator())
                {
                    if ($entry.Value -is [System.Collections.IDictionary])
                    {
                        $NewObject[[object] $entry.Key] = ConvertFrom-HashTable -HashTable $entry.Value # NOTE: Casting to [object] prevents problems with *numeric* hashtable keys.
                    }
                    else
                    {
                        $NewObject[[object] $entry.Key] = $entry.Value
                    }
                }
                [PSCustomObject] $NewObject
            }
        }
    }

    process
    {
        # Placed this code here instead of the begin block to avoid issues breaking out of the begin block.
        '--- Checking Prerequisites ---' | Write-Log
        '- Checking Pester' | Write-Log
        $PesterModule = Get-Module Pester -ListAvailable | Sort-Object -Property Version | Select-Object -Last 1
        if ($null -eq $PesterModule)
        {
            'Pester module not found. Please install Pester!' | Write-Log -Failure
            return
        }
        else
        {
            if ($PesterModule.Version -lt [Version]'5.7.1')
            {
                'Pester version is lower than 5.7.1. Please update Pester!' | Write-Log -Failure
                return
            }
        }

        '- Checking M365DSC.CompositeResources' | Write-Log
        $M365DSCCRModule = Get-Module -ListAvailable M365DSC.CompositeResources | Sort-Object -Property Version | Select-Object -Last 1
        if ($null -eq $M365DSCCRModule)
        {
            'M365DSC.CompositeResources module not found. Please install M365DSC.CompositeResources!' | Write-Log -Failure
            return
        }

        '--- Create composite config for M365DSC ---' | Write-Log
        'Workload    : {0}' -f $Workload | Write-Log
        'SourceFile  : {0}' -f $SourceFile | Write-Log
        'ResultFile  : {0}' -f $ResultFile | Write-Log

        if ((Test-Path -Path $SourceFile) -eq $false)
        {
            Write-Error "Cannot find file specified in parameter Source: $SourceFile,. Please make sure the file exists!"
            return
        }

        if (Test-Path -Path $ResultFile)
        {
            "File '$ResultFile' already exists. File will be overwritten!" | Write-Log -Warning
        }
        else
        {
            $ParentPath = Split-Path -Path $ResultFile
            if ((Test-Path -Path $ParentPath) -eq $false)
            {
                "Specified path '$ParentPath' in ResultFile does not exist. Creating!" | Write-Log
                New-Item -Path $ParentPath -ItemType Directory -Force
            }
        }

        $fileContent = Get-Content $SourceFile -Raw
        try
        {
            $startPosition = $fileContent.IndexOf(' -ModuleVersion')
            if ($startPosition -gt 0)
            {
                $endPosition = $fileContent.IndexOf("`r", $startPosition)
                $fileContent = $fileContent.Remove($startPosition, $endPosition - $startPosition)
            }
        }
        catch
        {
            Write-Verbose 'Error trying to remove Module Version'
        }

        'Converting read data into object' | Write-Log
        if ($PSVersionTable.PSVersion -gt [Version]"7.0.0.0")
        {
            '** Using PowerShell v7+, proxying conversion via PowerShell v5.1 **' | Write-Log
            [Array]$parsedContent = Start-Job -ScriptBlock {
                [Array]$parsedContent = ConvertTo-DSCObject -Content $args[0]
                return $parsedContent
            } -ArgumentList $fileContent -PSVersion 5.1 | Wait-Job | Receive-Job
        }
        else
        {
            '** Using PowerShell v5.1 **' | Write-Log
            [Array]$parsedContent = ConvertTo-DSCObject -Content $fileContent
        }
        $Obj_Export = $parsedContent.ForEach{ $_ | ConvertFrom-HashTable }

        # Group Object
        $Obj_Export_Groups = $Obj_Export | Group-Object 'resourcename'
        'Found Grouped Items : {0}' -f $Obj_Export_Groups.Count | Write-Log

        # Load Example data from module M365DSC.CompositeResources
        'Looking for Example Data File' | Write-Log
        $Obj_M365DataExample = Import-PSDataFile -Path (Join-Path -Path ($M365DSCCRModule.Path | Split-Path) -ChildPath 'M365ConfigurationDataExample.psd1').ToString()

        'Processing exported resources' | Write-Log
        $Obj_Grouped = @(
            foreach ($Obj_Export_Group in $Obj_Export_Groups)
            {
                $Obj_Conversion = [DSCConversion]::New()
                $Obj_Conversion.Resource_Name = $Obj_Export_Group.Name
                $Composite_Resource = $Obj_M365DataExample.NonNodeData.$Workload.GetEnumerator() | Where-Object {
                    $_.Name -eq ($Obj_Export_Group.Name -replace "^$($Workload | Convert-M365WorkLoadName )")
                }

                if ($null -eq $Composite_Resource) { continue }

                $Obj_Conversion.Composite_Resource_Name = $Composite_Resource.Name
                $Obj_Conversion.IsCollection = $Composite_Resource.Value -is [System.Array]
                $Obj_Conversion.RequiresUniqueId = $Composite_Resource.Value.ContainsKey('UniqueId')

                foreach ($Group in $Obj_Export_Group.group)
                {
                    $Obj_Conversion.Resource_Objects += ($Group | Copy-ObjectGraph -MapAs hashtable )
                }

                #Filter
                if ($Obj_Conversion.Composite_Resource_Name)
                {
                    $Obj_Conversion
                }
            }
        )

        # Compose file
        'Converting exported resources' | Write-Log
        $Obj_Result = @{ NonNodeData = @{ $Workload = @{} } }

        foreach ($Collection in $Obj_Grouped)
        {
            if ($Collection.IsCollection)
            {
                $Obj_Result.NonNodeData.$workload += @{$Collection.Composite_Resource_Name = @() }
                foreach ($Resource in $Collection.Resource_Objects)
                {
                    $Obj_Result.NonNodeData.$workload.($Collection.Composite_Resource_Name) += $Resource
                }
                if ($Collection.RequiresUniqueId)
                {
                    foreach ($item in $Obj_Result.NonNodeData.$workload.($Collection.Composite_Resource_Name))
                    {
                        $item.UniqueId = $item.ResourceInstanceName
                    }
                }
            }
            else
            {
                $Obj_Result.NonNodeData.$workload.($Collection.Composite_Resource_Name) = $Collection.Resource_Objects[0]
            }
        }

        #  Get All leaf nodes
        $InputNode = $Obj_Result | Get-Node
        $LeafNodes = $InputNode | Get-ChildNode -Recurse -Leaf

        "Fixing data issues and removing excluded keys:" | Write-Log
        "  - $($DSC_ExcludeKeys -join ', ')" | Write-Log
        foreach ($leafNode in $LeafNodes)
        {
            if ($leafNode.Name -in $DSC_ExcludeKeys)
            {
                $leafNode.ParentNode.Value.Remove($leafNode.Name)
                continue
            }

            $leafNodeType = (Get-RefNodeExampleData -Node $leafNode -ReferenceObject $Obj_M365DataExample).Type

            if ($null -eq $leafNodeType)
            {
                $leafNode.ParentNode.Value.Remove($leafNode.Name)
                continue
            }

            if ($leafNodeType -in ('SInt32', 'UInt32', 'UInt64'))
            {
                $leafNode.Value = [int]$leafNode.Value
                continue
            }
        }

        'Adding UniqueId property where required' | Write-Log
        $nodes = ($InputNode | Get-ChildNode -Recurse).Where{ $_ -is [PSListNode] -and $_.Value[0] -is [Hashtable] }
        foreach ($node in $nodes)
        {
            $counter = 1
            foreach ($obj in $node.Value)
            {
                if ($obj.ContainsKey('UniqueId') -eq $false -and `
                    $obj.ContainsKey('Identity') -eq $false -and `
                    $obj.ContainsKey('Id') -eq $false)
                {
                    $uniqueName = "{0}_{1}" -f $node.Name,$counter
                    $obj.UniqueId = $uniqueName
                    $counter++
                }
            }
        }

        # Sort-object
        'Sorting converted data' | Write-Log
        $Obj_Result = $Obj_Result | Sort-ObjectGraph -PrimaryKey 'NodeName', 'Identity', 'UniqueId', 'SettingDefinitionId' -MaxDepth 20

        # Check if data is available
        if ($Obj_Result.NonNodeData.$Workload)
        {
            $expression = $Obj_Result | ConvertTo-Expression -Depth 20 -Expand 20

            # Fix for non-escaped single quotes that cause issues
            $fancySingleQuotes = '[\u2018\u2019]'
            $expression = $expression.ToString() -replace $fancySingleQuotes,"''"

            $expression | Out-File $ResultFile -Force -Confirm:$false -Encoding UTF8
            'Result Composite config created: {0}' -f $ResultFile | Write-Log
        }
        else
        {
            'No valid data in result ' | Write-Log -Failure
            return
        }

        if (-not $SkipPesterTests)
        {
            # Running tests on converted data
            'Running Type/Value tests on converted data ' | Write-Log
            $exportedData = Import-PSDataFile -Path $ResultFile.ToString()

            $includeRequired = @('UniqueId')
            $excludeAvailableAsResource = @('*UniqueId','*IsSingleInstance','NonNodeData.Environment.Tokens*')

            $params = @{
                Test                       = 'TypeValue'
                InputObject                = $exportedData
                IncludeRequired            = $includeRequired
                ExcludeAvailableAsResource = $excludeAvailableAsResource
                PesterOutputObject         = $true
            }
            if ($ShowPesterScripts)
            {
                $params.PesterShowScript = $true
            }
            $typeValueTestResults = Test-M365DSCPowershellDataFile @params

            'Running Required values tests on converted data ' | Write-Log
            $params = @{
                Test                       = 'Required'
                InputObject                = $exportedData
                ExcludeAvailableAsResource = $excludeAvailableAsResource
                PesterOutputObject         = $true
            }
            if ($ShowPesterScripts)
            {
                $params.PesterShowScript = $true
            }
            $requiredTestResults = Test-M365DSCPowershellDataFile @params
        }
    }

    end
    {
        if (-not $SkipPesterTests)
        {
            if ($typeValueTestResults.Result -ne 'Passed' -or $requiredTestResults.Result -ne 'Passed') {
                'Errors in converted data ' | Write-Log -Failure
            }
            else
            {
                'All tests passed' | Write-Log
            }
        }

        'Completed conversion DSC export to data file' | Write-Log
    }
}
