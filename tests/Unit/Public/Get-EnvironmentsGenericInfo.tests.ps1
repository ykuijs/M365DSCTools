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

Describe Get-EnvironmentsGenericInfo {
    BeforeAll {
        Mock -CommandName Test-Path -MockWith { return $true }

        Mock -CommandName Get-ChildItem -MockWith {
            return @(
                @{
                    Directory = @{
                        BaseName = 'TestEnv'
                    }
                    FullName = 'C:\Temp\Environments\TestEnv\TestEnv#Generic.psd1'
                }
            )
        }

        Mock -CommandName Import-PowerShellDataFile -MockWith {
            return @{
                NonNodeData = @{
                    Environment = @{
                        CICD = @{
                            DependsOn = 'TestDependsOn'
                            UseCodeBranch = 'TestBranch'
                            Approvers = 'TestApprovers'
                        }
                    }
                }
            }
        }

        Mock -CommandName Write-Log -MockWith {}
    }

    Context 'Test function Get-EnvironmentsGenericInfo' {
        It 'Should collect the data successfully' {
            $result = Get-EnvironmentsGenericInfo -Path 'C:\Temp\Environments'
            $result.ContainsKey('TestEnv') | Should -Be $true
            $result['TestEnv'].DependsOn | Should -Be 'TestDependsOn'
            $result['TestEnv'].Branch | Should -Be 'TestBranch'
            $result['TestEnv'].Approvers | Should -Be 'TestApprovers'
        }

        It 'Should fail because path does not exist' {
            Mock -CommandName Test-Path -MockWith { return $false }

            $result = Get-EnvironmentsGenericInfo -Path 'C:\Temp\Environments'
            $result.Count | Should -Be 0
        }

        It 'Should fail because path does not exist' {
            Mock -CommandName Get-ChildItem -MockWith {
                return @()
            }

            $result = Get-EnvironmentsGenericInfo -Path 'C:\Temp\Environments'
            $result.Count | Should -Be 0
        }
    }
}

