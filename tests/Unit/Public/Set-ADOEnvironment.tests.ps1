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

Describe Set-ADOEnvironment {
    BeforeAll {
        $environmentsConfig = @{
            'testenv' = @(
                @{
                    Principal = 'user@domain.com'
                    Type      = 'User'
                }
                @{
                    Principal = '[DevOps Project]\Project Administrators'
                    Type      = 'Group'
                }
            )
            'testenv2' = @(
                @{
                    Principal = 'admin@contoso.com'
                    Type      = 'User'
                }
                @{
                    Principal = '[DSC Project]\Project Administrators'
                    Type      = 'Group'
                }
            )
        }
        $env:SYSTEM_ACCESSTOKEN = 'test'

        Mock -CommandName Write-Log -MockWith {}
    }

    Context 'Test function Set-ADOEnvironment' {
        BeforeAll {
            # User API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        @{
                            PrincipalName = 'user@domain.com'
                            DisplayName = 'User'
                            descriptor = 'user'
                        }
                        @{
                            PrincipalName = 'admin@contoso.com'
                            DisplayName = 'Admin'
                            descriptor = 'admin'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://vssps.dev.azure.com/{0}/_apis/graph/users?{1}" -f 'DSC','api-version=7.1-preview.1') }

            # Group API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        @{
                            PrincipalName = '[DevOps Project]\Project Administrators'
                            DisplayName = 'Project Administrators DO'
                            descriptor = 'projadminDO'
                        }
                        @{
                            PrincipalName = '[DSC Project]\Project Administrators'
                            DisplayName = 'Project Administrators DSC'
                            descriptor = 'projadmindsc'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://vssps.dev.azure.com/{0}/_apis/graph/groups?{1}" -f 'DSC','api-version=7.1-preview.1') }

            # Storage key API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = 'descriptor'
                }
            } -ParameterFilter { $Uri -like ("https://vssps.dev.azure.com/{0}/_apis/graph/storagekeys/*?{1}" -f 'DSC','api-version=7.1-preview.1') }

            # Pipeline API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        @{
                            name = 'MyDSCPipeline'
                        }
                        @{
                            name = 'MyOtherPipeline'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/pipelines?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Env Checks retrieval API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return ,@()
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/checks/configurations?resourceType=environment&resourceId=*&{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Env Checks creation API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return $null
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/pipelines/checks/configurations?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Pipeline permissions API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    pipelines = @()
                }
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/pipelinepermissions/environment/*?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }
        }

        It 'Should create and configure all environments in ADO' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                if ($global:envHitCount -lt 2)
                {
                    $global:envHitCount++
                    return $null
                }
                else
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 2
                                Name = 'testenv2'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            $global:envHitCount = 0
            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $true
            Should -Invoke 'Invoke-APRestApi'
        }

        It 'Should create one and configure all environments in ADO' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                if ($global:envHitCount -lt 2)
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
                else
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 2
                                Name = 'testenv2'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            $global:envHitCount = 0
            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $true
            Should -Invoke 'Invoke-APRestApi'
        }

        It 'Should fail because approver cannot be found' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                if ($global:envHitCount -lt 2)
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
                else
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 2
                                Name = 'testenv2'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # User API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        @{
                            PrincipalName = 'user2@domain.com'
                            DisplayName = 'User'
                            descriptor = 'user'
                        }
                        @{
                            PrincipalName = 'admin@contoso.com'
                            DisplayName = 'Admin'
                            descriptor = 'admin'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://vssps.dev.azure.com/{0}/_apis/graph/users?{1}" -f 'DSC','api-version=7.1-preview.1') }

            $global:envHitCount = 0
            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $false
            Should -Invoke 'Invoke-APRestApi' -Times 6 -Exactly
        }

        It 'Should fail because storage key cannot be found' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                if ($global:envHitCount -lt 2)
                {
                    $global:envHitCount++
                    return $null
                }
                else
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 2
                                Name = 'testenv2'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Storage key API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return $null
            } -ParameterFilter { $Uri -like ("https://vssps.dev.azure.com/{0}/_apis/graph/storagekeys/*?{1}" -f 'DSC','api-version=7.1-preview.1') }


            $global:envHitCount = 0
            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $false
            Should -Invoke 'Invoke-APRestApi' -Times 6 -Exactly
        }

        It 'Should fail because approver cannot be found' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                if ($global:envHitCount -lt 2)
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
                else
                {
                    $global:envHitCount++
                    return @{
                        value = @(
                            [PSCustomObject]@{
                                id = 1
                                Name = 'testenv'
                            }
                            [PSCustomObject]@{
                                id = 2
                                Name = 'testenv2'
                            }
                            [PSCustomObject]@{
                                id = 3
                                Name = 'testenv3'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Group API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        @{
                            PrincipalName = '[DevOps Project]\Project Administrators2'
                            DisplayName = 'Project Administrators DO'
                            descriptor = 'projadminDO'
                        }
                        @{
                            PrincipalName = '[DSC Project]\Project Administrators'
                            DisplayName = 'Project Administrators DSC'
                            descriptor = 'projadmindsc'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://vssps.dev.azure.com/{0}/_apis/graph/groups?{1}" -f 'DSC','api-version=7.1-preview.1') }

            $global:envHitCount = 0
            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $false
            Should -Invoke 'Invoke-APRestApi' -Times 7 -Exactly
        }

        It 'Should update existing checks' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        [PSCustomObject]@{
                            id = 1
                            Name = 'testenv'
                        }
                        [PSCustomObject]@{
                            id = 2
                            Name = 'testenv2'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # All Env Checks retrieval API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @{
                        id = 1

                    }
                }
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/checks/configurations?resourceType=environment&resourceId=*&{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Specific Env Checks API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    Settings = @{
                        Instructions = 'test'
                        requesterCannotBeApprover = $true
                        executionOrder = 0
                        minRequiredApprovers = 1
                        timeout = 10
                        approvers = @(
                            @{
                                id = 'test'
                            }
                        )
                    }
                }
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/checks/configurations/*?`$expand=settings&{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') -and $Method -eq 'GET' }

            # Specific Env Checks API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return $null
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/checks/configurations/*?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') -and $Method -eq 'PATCH' }

            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $true
            Should -Invoke 'Invoke-APRestApi' -Times 19 -Exactly
        }

        It 'Should add pipeline to existing list of pipelines' {
            # Environment API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    value = @(
                        [PSCustomObject]@{
                            id = 1
                            Name = 'testenv'
                        }
                        [PSCustomObject]@{
                            id = 2
                            Name = 'testenv2'
                        }
                    )
                }
            } -ParameterFilter { $Uri -eq ("https://dev.azure.com/{0}/{1}/_apis/distributedtask/environments?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            # Pipeline permissions API call
            Mock -CommandName Invoke-APRestApi -MockWith {
                return @{
                    pipelines = @(
                        @{
                            id = 1
                            authorized = $false
                        }
                    )
                }
            } -ParameterFilter { $Uri -like ("https://dev.azure.com/{0}/{1}/_apis/pipelines/pipelinepermissions/environment/*?{2}" -f 'DSC','Deployment','api-version=7.1-preview.1') }

            $results = Set-ADOEnvironment -Organization 'DSC' -Project 'Deployment' -TargetEnvironments $environmentsConfig.Keys -Approvers $environmentsConfig -DeploymentPipeline 'MyDSCPipeline'
            $results | Should -Be $true
            Should -Invoke 'Invoke-APRestApi' -Times 17 -Exactly
        }
    }
}
