BeforeAll {
    $script:moduleName = 'M365DSCTools'

    # If the module is not found, run the build task 'noop'.
    if (-not (Get-Module -Name $script:moduleName -ListAvailable))
    {
        # Redirect all streams to $null, except the error stream (stream 2)
        & "$PSScriptRoot/../../build.ps1" -Tasks 'noop' > $null
    }

    # Re-import the module using force to get any code changes between runs.
    Import-Module -Name $script:moduleName -Force -ErrorAction 'Stop'

    $PSDefaultParameterValues['InModuleScope:ModuleName'] = $script:moduleName
    $PSDefaultParameterValues['Mock:ModuleName'] = $script:moduleName
    $PSDefaultParameterValues['Should:ModuleName'] = $script:moduleName
}

AfterAll {
    $PSDefaultParameterValues.Remove('Mock:ModuleName')
    $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
    $PSDefaultParameterValues.Remove('Should:ModuleName')

    Remove-Module -Name $script:moduleName
}

Describe Test-M365PowershellDataFile {
    BeforeAll {
        Mock -CommandName Get-Module -MockWith { return @{ Path = 'C:\Temp\module.psd1'} }
        Mock -CommandName Import-PSDataFile -MockWith {
            return @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item1 = 'String | Required | Optional String'
                            Item2 = 'SInt32 | Optional | Optional SInt32'
                        }
                    }
                    'Teams' = @{
                        Resource2 = @(
                            @{
                                Item3 = 'Boolean | Required | Required Boolean'
                                Item4 = 'Guid | Optional | Optional Guid'
                            }
                        )
                    }
                }
            }
        } -RemoveParameterType 'Path'
    }

    Context 'Test function Test-M365PowershellDataFile' {
        It 'Should successfully test the inputted object' {
            $Object = @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item1 = 'String'
                            Item2 = 5
                        }
                    }
                    'Teams' = @{
                        Resource2 = @(
                            @{
                                UniqueId = "Test"
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                Item5 = "Test2"
                                Item6 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                        )
                    }
                }
            }

            # Mock Out-File to prevent an issue with an updated hashtable
            Mock -CommandName Out-File -MockWith {
                Add-Content -Value 'Write-Verbose "test"' -Path $FilePath
            }

            Test-M365PowershellDataFile -InputObject $Object
            Should -Invoke -CommandName Out-File
        }
    }
}

