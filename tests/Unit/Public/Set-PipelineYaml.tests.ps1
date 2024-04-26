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

Describe Set-PipelineYaml {
    BeforeAll {
        Mock -CommandName Write-Log -MockWith {}
    }

    Context 'Test function Set-PipelineYaml' {
        BeforeAll {

            Add-Type -TypeDefinition @"
            public enum SerializationOptions {
                None,
                Roundtrip,
                DisableAliases,
                EmitDefaults,
                JsonCompatible,
                DefaultToStaticType,
                WithIndentedSequences
            }
"@

            $envInfo = @{
                Dev = @{
                    DependsOn = ''
                    Branch = 'dev'
                }
                Test = @{
                    DependsOn = 'Dev'
                    Branch = 'main'
                }
                Acceptance = @{
                    DependsOn = 'Test'
                    Branch = 'main'
                }
                Production = @{
                    DependsOn = 'Acceptance'
                    Branch = 'main'
                }
            }

            Mock -CommandName Test-Path -MockWith { return $true }
            Mock -CommandName Get-Content -MockWith {}
            Mock -CommandName ConvertTo-Yaml -MockWith {}
            Mock -CommandName Out-File -MockWith {}
        }

        It 'Should create and configure all environments in ADO' {
            Mock -CommandName ConvertFrom-Yaml -MockWith {
                return @{
                    parameters = @(
                        @{
                            Name = 'Environments'
                            default = @(
                                @{
                                    Name = 'Dev'
                                    DependsOn = ''
                                    Branch = 'dev'
                                }
                                @{
                                    Name = 'Test'
                                    DependsOn = 'Dev'
                                    Branch = 'master'

                                }
                                @{
                                    Name = 'Acceptance'
                                    DependsOn = 'Dev'
                                    Branch = 'master'

                                }
                                @{
                                    Name = 'Production2'
                                    DependsOn = 'Acceptance'
                                    Branch = 'main'
                                }
                            )
                        }
                    )
                }
            }

            $results = Set-PipelineYaml -YamlPath 'C:\Source\Pipelines\template.yaml' -EnvironmentsInfo $envInfo
            $results | Should -Be $true
            Should -Invoke 'ConvertTo-Yaml'
        }

        It 'Should fail because specified Yaml path does not exist' {
            Mock -CommandName Test-Path -MockWith { return $false }

            $results = Set-PipelineYaml -YamlPath 'C:\Source\Pipelines\template.yaml' -EnvironmentsInfo $envInfo
            $results | Should -Be $false
        }

        It 'Should fail because specified Yaml path does not contain a parameters value' {
            Mock -CommandName ConvertFrom-Yaml -MockWith {
                return @{}
            }

            $results = Set-PipelineYaml -YamlPath 'C:\Source\Pipelines\template.yaml' -EnvironmentsInfo $envInfo
            $results | Should -Be $false
        }

        It 'Should fail because specified Yaml path does not contain a parameters value' {
            Mock -CommandName ConvertFrom-Yaml -MockWith {
                return @{                    parameters = @(
                        @{
                            Name = 'NotEnvironments'
                            default = @()
                        }
                    )
                }
            }

            $results = Set-PipelineYaml -YamlPath 'C:\Source\Pipelines\template.yaml' -EnvironmentsInfo $envInfo
            $results | Should -Be $false
        }
    }
}
