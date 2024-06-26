function Test-M365MandatoryPowershellDataFile
{
    <#
 .Synopsis
  Tests the specified object against the information defined in the MandatoryObject

 .Description
  This function tests the specified object against the information defined in the
  Mandatory file. It creates a Pester test
  to check if the values are correct types are correct.

 .Parameter InputObject
  The object that contains the data object that needs to be tested

 .Parameter MandatoryObject
  The object that contains the mandatory data that is used for the tested

 .Parameter Keys
  Indentifier key for matching, default keys: 'UniqueId', 'Identity', 'NodeName', 'Id'

 .Parameter PesterScript
  Specify if the created Pester scripts will be displayed or not.

 .Parameter Verbosity
  Specify Output verbosity: 'None', 'Detailed', 'Diagnostic'

 .Parameter NotAllowedMandatory
  All items Mandatory object are not allowed in the input object.

 .Example
    Test-M365MandatoryPowershellDataFile -InputObject $M365DSCData -PesterScript

    $InputObject = Import-PSDataFile '%Filename%.psd1'
    $MandatoryObject = Import-PSDataFile '%Filename%.psd1'

    $InputObject | Test-M365MandatoryPowershellDataFile -MandatoryObject $MandatoryObject -PesterScript
   $InputObject | Test-M365MandatoryPowershellDataFile -MandatoryObject $MandatoryObject -NotAllowedMandatory -PesterScript
#>

    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
        $InputObject,

        [Parameter(Mandatory = $true)]
        $MandatoryObject,

        [Parameter(Mandatory = $False)]
        [Array]
        $Keys = @('UniqueId', 'Identity', 'NodeName', 'Id'),

        [Parameter(Mandatory = $False)]
        [ValidateSet('None', 'Detailed', 'Diagnostic')]
        [System.String]
        $Verbosity = 'Detailed',

        [Parameter(Mandatory = $False)]
        [Switch]
        $NotAllowedMandatory,

        [Parameter(Mandatory = $False)]
        [Switch]
        $PesterScript
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
        $Pester_Config = @(

            '#Requires -Modules Pester'
            "Describe '--- Check M365-DSC-Mandatory configuration settings ---' {"

            #NonNodeData
            $Node_Mandatory_NonNodeData = $MandatoryObject | Get-Node 'NonNodedata'
            ($Node_Mandatory_NonNodeData | Get-ChildNode).ForEach{
                "  Context '{0}' {{" -f $_.name
                ($_ | Get-ChildNode).ForEach{
                    "    It '{0}' {{" -f $_.name
                    # Get parrent Leaf nodes
                    $Nodes_Mandatory_Path = ($_ | Get-Node ~*=*..).Path

                    foreach ($Node_Mandatory_Path in $Nodes_Mandatory_Path)
                    {
                        #Leaf Siblings
                        $LeafCollection = $MandatoryObject | Get-Node $($Node_Mandatory_Path.ToString())
                        $LeafCollection_ChildNodes = $leafcollection | Get-ChildNode

                        $Indexer_Mandatory = $LeafCollection_ChildNodes | Where-Object { $Keys -contains $_.Name }
                        if ($Indexer_Mandatory)
                        {
                            '      # {0} = "{1}"' -f $Indexer_Mandatory.Name, $Indexer_Mandatory.Value
                        }

                        $LeafCollection_ChildNodes.ForEach{
                            if ($_.Name -notin $Keys)
                            {
                                [array]$Found = $InputObject | Get-Node $($_.Path.ToString() -Replace ('\[\d*\]', ''))

                                # Single Instance type en 1 node Found
                                if (-not $Indexer_Mandatory -and ($Found.Count -eq 1))
                                {
                                    if ($NotAllowedMandatory)
                                    {
                                        "      `$InputObject.{0} | Should -BeNullOrEmpty -Because '{1} is a Mandatory Setting and not allowed in the data file'" -f $_.Path, $_.Name
                                    }
                                    else
                                    {
                                        "      `$InputObject.{0} | Should -Be {1} -Because '{2} is a Mandatory Setting'" -f $_.Path, $_.Value, $_.Name
                                    }
                                }

                                if (-not $Indexer_Mandatory -and ($Found.Count -gt 1))
                                {
                                    '"   [-]  `$InputObject.{0} No index key sibling found in Mandatory: {1}"| write-host -ForegroundColor darkyellow' -f $($_.Path), $($Keys -join ';')
                                }

                                # Multiple Instance
                                if ($Indexer_Mandatory)
                                {
                                    $M_Index_Path = $Indexer_Mandatory.Path.ToString() -Replace ('\[\d*\]', '')
                                    $Leaf_node = $InputObject | Get-Node "$M_Index_Path=$($Indexer_Mandatory.Value)..$($_.Name)"

                                    # Multiple Instance Leaf node found with index
                                    if ($Leaf_node)
                                    {
                                        if ($NotAllowedMandatory)
                                        {
                                            "      `$InputObject.{0} | Should -BeNullOrEmpty -Because '{1} is a Mandatory Setting and not Allowed in the data file'" -f $Leaf_node.Path, $_.Name
                                        }
                                        else
                                        {
                                            "      `$InputObject.{0} | Should -Be {1} -Because '{2} is a Mandatory Setting'" -f $Leaf_node.Path, $($_.Value), $_.Name
                                        }
                                    }
                                    else
                                    {
                                        if (-not $NotAllowedMandatory)
                                        {
                                            "      `$InputObject.{0} | Should -Not -BeNullOrEmpty -Because '{1} is a Mandatory Setting'" -f $($_.Path.ToString()), $_.Name
                                        }
                                    }
                                }
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
                ErrorAction = 'continue'
            }
            Output = @{
                Verbosity           = $Verbosity
                StackTraceVerbosity = 'Firstline'
            }
        }

        $Result = Invoke-Pester -Configuration $Configuration

        # Clean temp file
        Remove-Item -Path $Pester_Script -Force -ErrorAction SilentlyContinue

        return $result
    }
}

