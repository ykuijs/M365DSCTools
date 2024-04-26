BeforeAll {
    $script:moduleName = 'M365DSCTools'

    # If the module is not found, run the build task 'noop'.
    if (-not (Get-Module -Name $script:moduleName -ListAvailable)) {
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

Describe Test-M365MandatoryPowershellDataFile {
    BeforeAll {
        Mock -CommandName Get-Module -MockWith { return @{ Path = 'C:\Temp\module.psd1' } }

        $PesterPreference = [PesterConfiguration]::Default
        #$PesterPreference.Run.PassThru = $True
        $PesterPreference.Output.Verbosity = 'Detailed'
        $PesterPreference.Output.Verbosity = 'Firstline'
        #$PesterPreference.Should = 'continue'

        $InputObject =  @{
            NonNodeData = @{
                Teams = @{
                    Resource2 = @(
                        @{ UniqueId = 'Test'; Item4 = 'c25d6579-be90-4484-81ef-9280d4817440' },
                        @{ UniqueID = 'Test2'; Item4 = 'A25d6579-be90-4484-81ef-9280d4817440' }
                    )
                }
                Exchange = @{
                    Resource1 = @{ Item2 = 5; Item1 = 'String' }
                }
            }
        }

        $Data1 = @{ NonNodeData=@{ Exchange=@{ Resource1=@{Item2=5 } } } }
        $Data2 = @{ NonNodeData = @{ Teams = @{ Resource2 = @(@{ UniqueID = 'Test2'; Item6 = 'c25d6579-be90-4484-81ef-9280d4817440' }) } } }
    }

    Context 'Pester Test-M365MandatoryPowershellDataFile' {
        It 'Should successfully: Test1: Mandatory correct value: [Hashtable]' {
            $Test1 = Test-M365MandatoryPowershellDataFile -InputObject $InputObject -MandatoryObject $Data1 -Verbosity None
            $Test1.result | Should -be 'passed'
        }
        It 'Should Failed:       Test2: Mandatory value with indexer and wrong value: [System.Object[Hashtable]]' {
            $Test2 = Test-M365MandatoryPowershellDataFile -InputObject $InputObject -MandatoryObject $Data2  -Verbosity None
            $Test2.result | Should -be 'Failed'
        }
        It 'Should Failed:       Test3: Mandatory key(s) found and is not allowed: ' {
            $Test3 = Test-M365MandatoryPowershellDataFile -InputObject $InputObject -MandatoryObject $Data2 -NotAllowedMandatory  -Verbosity None
            $Test3.result | Should -be 'Failed'
        }
    }
}


