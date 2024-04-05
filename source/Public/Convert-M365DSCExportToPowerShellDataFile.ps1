$DSC_ExcludeKeys = @(
    'ResourceInstanceName',
    'ResourceName',
    'ApplicationId',
    'CertificateThumbprint',
    'TenantId',
    'IsSingleInstance'
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

    It uses the function New-M365DSCReportFromConfiguration to convert the
    export into JSON before converting it into a PowerShell data file.

.PARAMETER Workload
    The Workload for which you want to convert the export.

.PARAMETER SourceFile
    The file which contains the Microsoft365DSC export.

.PARAMETER ResultFolder
    The folder to which the converted file is written to.

.EXAMPLE
    Convert-M365DSCExportToPowerShellDataFile `
        -Workload Office365 `
        -SourceFile '.\Exports\O365\O365.ps1' `
        -ResultFolder '.\Results'
#>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '', Scope = 'Function')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet( 'AzureAD', 'Exchange', 'Intune', 'Office365', 'OneDrive', 'Planner', 'PowerPlatform', 'SecurityCompliance', 'SharePoint', 'Teams')]
        $Workload,

        [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
        $SourceFile,

        [Parameter(Mandatory = $true)]
        $ResultFolder
    )

    begin
    {
        # Test if the ObjectGraphTools module is loaded and the class is available
        if (-not ([System.Management.Automation.PSTypeName]'PSNode').Type)
        {
            Import-Module ObjectGraphTools -Force
        }

        Class DSCConversion
        {
            [string]$Resource_Name
            [string]$Composite_Resource_Name
            [hashtable[]]$Resource_Objects
        }

        # Fix bug second run
        Set-M365DSCTelemetryOption -Enabled $false
    }

    process
    {
        $SourceFile_BaseName = (Get-Item $SourceFile).BaseName
        $Path_JsonReport = '{0}_M365DSCReport.json' -f $( Join-Path -Path $ResultFolder -ChildPath $SourceFile_BaseName)
        $Path_CompositeConfig = '{0}.psd1' -f $( Join-Path -Path $ResultFolder -ChildPath $SourceFile_BaseName)

        New-Item -ItemType Directory -Force -Path $ResultFolder | Out-Null

        '--- Create composite config for M365 DSC ---' | Write-Log
        'Workload     : {0}' -f $Workload | Write-Log
        'SourceFile   : {0}' -f $SourceFile | Write-Log
        'ResultFolder : {0}' -f $ResultFolder | Write-Log


        # Create M365DSCReport
        $OriginalProgressPreference = $Global:ProgressPreference
        $Global:ProgressPreference = 'SilentlyContinue'
        New-M365DSCReportFromConfiguration -Type JSON -ConfigurationPath $SourceFile -OutputPath $Path_JsonReport
        $Global:ProgressPreference = $OriginalProgressPreference

        # load M365DSCReport
        $Obj_Export = Get-Content $Path_JsonReport | ConvertFrom-Json

        # Load Example data from module M365DSC.CompositeResources
        $M365DSCCRModule = Get-Module -ListAvailable M365DSC.CompositeResources | Sort-Object -Property Version | Select-Object -Last 1
        $Obj_M365DataExample = Import-PSDataFile -Path (Join-Path -Path ($M365DSCCRModule.Path | Split-Path) -ChildPath 'M365ConfigurationDataExample.psd1').ToString()

        # Group Object
        $Obj_Export_Groups = $Obj_Export | Group-Object 'resourcename'
        'Found Grouped Items : {0}' -f $Obj_Export_Groups.count | Write-Log

        $Obj_Grouped = @(
            foreach ($Obj_Export_Group in $Obj_Export_Groups)
            {
                $Obj_Conversion = [DSCConversion]::new()
                $Obj_Conversion.Resource_Name = $Obj_Export_Group.name
                $Composite_Resource = $Obj_M365DataExample.NonNodeData.$Workload.GetEnumerator() | Where-Object {
                    $_.Name -match [regex]('^{0}[s]*$' -f ($Obj_Export_Group.Name `
                                -replace "^$($Workload | Convert-M365WorkLoadName )" `
                                -replace '(?<!y)$', '[s]*' `
                                -replace 'y$', '(y|ies)' `
                                -replace 'Policy', 'Policies' `
                                -replace 'Profile', 'Profiles'
                        ) ) }
                $Obj_Conversion.Composite_Resource_Name = $Composite_Resource.Name

                Foreach ($Group in $Obj_Export_Group.group)
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
        $Obj_Result = @{NonNodeData = @{$Workload = @{} } }

        foreach ( $Collection in $Obj_Grouped )
        {
            $Obj_Result.NonNodeData.$workload += @{$Collection.Composite_Resource_Name = @() }
            foreach ($Resource in $Collection.Resource_Objects)
            {
                $Obj_Result.NonNodeData.$workload.($Collection.Composite_Resource_Name) += $Resource
            }
        }

        #  Get All leaf nodes
        $InputNode = $Obj_Result | Get-Node
        $LeafNodes = $InputNode | Get-ChildNode -Recurse -Leaf

        # Exclude Keys
        $LeafNodes.where{ $_.Name -in $DSC_ExcludeKeys }.foreach{ $_.ParentNode.value.remove($_.name) }
        $DSC_ExcludeKeys.foreach{ 'Remove excluded key: {0}' -f $_ | Write-Log }

        # Fix type Int after export ( bug? commandlet New-M365DSCReportFromConfiguration )
        $Int_Nodes = $LeafNodes.where{ (Get-RefNodeExampleData -Node $_ -ReferenceObject $Obj_M365DataExample).type -in ('SInt32', 'UInt32', 'UInt64') }
        $Int_Nodes.ForEach{ $_.Value = [int]$_.Value }

        # Sort-object
        $Obj_Result = $Obj_Result | Sort-ObjectGraph -PrimaryKey 'NodeName', 'Identity', 'UniqueId' -MaxDepth 20

        # Check if data is available
        if ($Obj_Result.NonNodeData.$Workload)
        {
            $Obj_Result | ConvertTo-Expression -Depth 20 -Expand 20 -IndentSize 4 | Out-File $Path_CompositeConfig -Force -Confirm:$false -Encoding ascii
            'Result Composite config created: {0}' -f $Path_CompositeConfig | Write-Log
        }
        else
        {
            'No valid data in result ' | Write-Log -Failure
        }
    }

    end
    {
        # Cleaning
        if (Test-Path -Path $Path_JsonReport)
        {
            Remove-Item $Path_JsonReport -Confirm:$false -Force
        }
    }
}
