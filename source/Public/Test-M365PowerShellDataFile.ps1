function Test-M365PowershellDataFile
{
<#
 .Synopsis
  Tests the specified object against the information defined in the ExampleData
  from the M365DSC.CompositeResources module.

 .Description
  This function tests the specified object against the information defined in the
  ExampleData from the M365DSC.CompositeResources module. It creates a Pester test
  to check if the specified data and types are correct, as specified in the example
  data.

 .Parameter InputObject
  The object that contains the data object that needs to be tested

 .Parameter PesterScript
  Specify if the created Pester scripts will be displayed or not.

 .Parameter Exclude_Required
  All required items that have to be ignored, for example the UniqueID parameter.

 .Parameter Exclude_AvailableAsResource
  All items that are available as a resource and have to be ignored.

 .Parameter IgnoreRequired
  Specifies that the Required parameters should not be checked. Used with the individual data files.

 .Example
   Test-M365PowershellDataFile -InputObject $M365DSCData -PesterScript

 .Example
   Test-M365PowershellDataFile -InputObject $M365DSCData -PesterScript -IgnoreRequired
#>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
        $InputObject,

        [Parameter()]
        [Switch]
        $PesterScript,

        [Parameter()]
        [System.Array]
        $Exclude_Required,

        [Parameter()]
        [System.Array]
        $Exclude_AvailableAsResource,

        [Parameter()]
        [Switch]
        $IgnoreRequired
    )

    begin
    {
        # Test if the ObjectGraphTools module is loaded and the class is available
        if (-not ([System.Management.Automation.PSTypeName]'PSNode').Type)
        {
            Import-Module ObjectGraphTools -Force
        }
    }

    process
    {
        $Leaf_Parents = [System.Collections.Generic.List[String]]::new()

        # Load Example data from module M365DSC.CompositeResources
        $Obj_M365DataExample = Import-PSDataFile -Path (((Get-Module -ListAvailable M365DSC.CompositeResources).path | Split-Path) + '\M365ConfigurationDataExample.psd1')

        $Node_Root = $InputObject | Get-Node
        $Pester_Config = @(

            '#Requires -Modules Pester'

            "Describe '--- Check M365-DSC-CompositeResources configuration ---' {"

            #NonNodeData
            $Node_NonNodeData = $Node_Root._('NonNodedata')
            ($Node_NonNodeData | Get-ChildNode).ForEach{
                "  Context '{0}' {{" -f $_.name
                ($_ | Get-ChildNode).foreach{
                    "    It '{0}' {{" -f $_.name

                    ($_ | Get-ChildNode -Recurse -Leaf).ForEach{

                        # First Time in this parent Leaf node
                        if ( $Leaf_Parents -notcontains ($_.parentnode.PathName) )
                        {
                            $Leaf_Parents.add($_.parentnode.PathName)

                            $Obj_Ref = Get-RefNodeExampleData -node $_.ParentNode -ReferenceObject $Obj_M365DataExample

                            if ($null -ne $Obj_Ref)
                            {
                                $Required = $Obj_Ref.GetEnumerator() | Where-Object { $_.value -like '*| Required |*' }
                                $Available = $_.parentnode.ChildNodes.name

                                foreach ( $Item in $Required.name )
                                {
                                    if ( $Available -notcontains $Item -and $Exclude_Required -notContains $item -and $PSBoundParameters.ContainsKey('IgnoreRequired') -eq $false )
                                    {
                                        "      `$InputObject.{0}.{1} | Should -Not -BeNullOrEmpty -Because 'parameter {1} is required for {0}'" -f $_.parentnode.pathname, $Item
                                    }
                                }
                            }
                        }

                        if ($_.value -and ($Exclude_AvailableAsResource -notcontains $_.name ))
                        {
                            $Obj_Ref = Get-RefNodeExampleData -node $_ -ReferenceObject $Obj_M365DataExample

                            # Type validation
                            if ($Obj_Ref.type)
                            {
                                "      `$InputObject.{0} | {1}" -f $_.Pathname, $(Convert-PesterType $Obj_Ref.type)
                            }
                            # validationSet validation
                            if ($Obj_Ref.ValidateSet)
                            {
                                "      `$InputObject.{0} | should -beIn {1}" -f $_.Pathname, $Obj_Ref.ValidateSet
                            }

                            # No Ref data
                            if (-not $Obj_Ref.type)
                            {
                                '"   [-] {0} [not availabe as a Composite Resource]"| write-host -ForegroundColor darkyellow' -f $_.Pathname
                            }
                        }

                    }

                    '    }'
                }
                '  }'
            }
            '}'
        )


        # Save for execute
        $Pester_Script = New-TemporaryFile | Rename-Item -NewName { [IO.Path]::ChangeExtension($_, '.tests.ps1') } -PassThru
        $Pester_Config | Out-File $Pester_Script -Force -Confirm:$false -Encoding:ascii

        # Show Result Pester Script in a VScode window
        if ($PesterScript)
        {
            psedit $Pester_Script
        }

        # Execute pester script
        $Params = [ordered]@{
            Path = $Pester_Script
        }

        $Container = New-PesterContainer @Params

        $Configuration = [PesterConfiguration]@{
            Run    = @{
                Container = $Container
                PassThru  = $true
            }
            Should = @{
                ErrorAction = "continue"
            }
            Output = @{
                Verbosity           = 'Detailed'
                StackTraceVerbosity = "Firstline"
            }
        }

        $result = Invoke-Pester -Configuration $Configuration

        # Clean temp file
        Remove-Item -Path $Pester_Script -Force -ErrorAction SilentlyContinue

        return $result
    }
}
