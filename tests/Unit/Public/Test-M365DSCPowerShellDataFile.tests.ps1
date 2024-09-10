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

Describe Test-M365DSCPowershellDataFile {
    BeforeAll {
        $PesterPreference = [PesterConfiguration]::Default
        $PesterPreference.Output.Verbosity = 'Detailed'
        $PesterPreference.Output.StackTraceVerbosity = "Firstline"

        Mock -CommandName Get-Module -MockWith { return @{ Path = 'C:\Temp\module.psd1'} }
        Mock -CommandName Write-Log -MockWith {}
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
                                UniqueId = 'String | Required | Required String'
                                Item3 = 'Boolean | Required | Required Boolean'
                                Item4 = 'Guid | Optional | Optional Guid'
                                Item5 = 'String | Required | Required String'
                            }
                        )
                    }
                }
            }
        } -RemoveParameterType 'Path'
    }

    Context 'Test function Test-M365DSCPowershellDataFile' {
        It 'Should successfully test of the inputted object - Testing type and value' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                Item3 = $false
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817441'
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test TypeValue -InputObject $Object -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Passed'
        }

        It 'Should fail test of the inputted object - Testing type and value' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                Item5 = $false
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test TypeValue -InputObject $Object -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Failed'
        }
        It 'Should successfully test of the inputted object - Testing Required' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                Item3 = $false
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817441'
                                Item5 = 'String'
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Required -InputObject $Object -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Passed'
        }

        It 'Should fail test of the inputted object - Testing Required' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                ItemUnknown = $false
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Required -InputObject $Object -pesterVerbosity None -pesterOutputObject
            $result.Result | Should -Be 'Failed'
        }
        It 'Should successfully test of the inputted object - Testing Mandatory (Present)' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                Item3 = $false
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817441'
                                Item5 = 'String'
                            }
                        )
                    }
                }
            }
            $MandatoryObject = @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item1 = 'String'
                        }
                    }
                    'Teams' = @{
                        Resource2 = @(
                            @{
                                UniqueId = "Test"
                                Item3 = $true
                            }
                            @{
                                UniqueId = "Test2"
                                Item5 = 'String'
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Mandatory -InputObject $Object -MandatoryObject $MandatoryObject -MandatoryAction 'Present' -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Passed'
        }

        It 'Should fail test of the inputted object - Testing Mandatory (Present)' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                ItemUnknown = $false
                            }
                        )
                    }
                }
            }
            $MandatoryObject = @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item1 = 'String'
                        }
                    }
                    'Teams' = @{
                        Resource2 = @(
                            @{
                                UniqueId = "Test"
                                Item3 = $false
                            }
                            @{
                                UniqueId = "Test2"
                                Item5 = 'StringWrong'
                            }
                        )
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Mandatory -InputObject $Object -MandatoryObject $MandatoryObject -MandatoryAction 'Present' -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Failed'
        }
        It 'Should successfully test of the inputted object - Testing Mandatory (Absent)' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                Item3 = $false
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817441'
                                Item5 = 'String'
                            }
                        )
                    }
                }
            }
            $MandatoryObject = @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item3 = 'String'
                        }
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Mandatory -InputObject $Object -MandatoryObject $MandatoryObject -MandatoryAction 'Absent' -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Passed'
        }

        It 'Should fail test of the inputted object - Testing Mandatory (Absent)' {
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
                                Item3 = $true
                                Item4 = 'c25d6579-be90-4484-81ef-9280d4817440'
                            }
                            @{
                                UniqueId = "Test2"
                                ItemUnknown = $false
                            }
                        )
                    }
                }
            }
            $MandatoryObject = @{
                NonNodeData = @{
                    'Exchange' = @{
                        Resource1 = @{
                            Item1 = 'String'
                        }
                    }
                }
            }

            $result = Test-M365DSCPowershellDataFile -Test Mandatory -InputObject $Object -MandatoryObject $MandatoryObject -MandatoryAction 'Absent' -PesterVerbosity None -PesterOutputObject
            $result.Result | Should -Be 'Failed'
        }
    }
}

