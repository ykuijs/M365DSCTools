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

    $stubPath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\Stubs\AzStorageStubs.psm1' -Resolve
    Import-Module $stubPath
}

AfterAll {
    $PSDefaultParameterValues.Remove('Mock:ModuleName')
    $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
    $PSDefaultParameterValues.Remove('Should:ModuleName')

    Remove-Module -Name $script:moduleName
}

Describe Add-ModulesToBlobStorage {
    BeforeAll {
        Mock -CommandName Write-LogEntry -MockWith { }
        Mock -CommandName Get-AzStorageAccount -MockWith {
            return @{
                Context = 'Context'
            }
        }
        Mock -CommandName Get-Module -MockWith {
            return @{
                Path    = 'C:\Program Files\WindowsPowerShell\Modules\Microsoft365Dsc\1.23.517.1'
                Version = '1.23.517.1'
            }
        }

        Get-Module -ListAvailable PowerShellGet

        Get-Command Save-Module

        Mock -CommandName Save-Module -MockWith { }
    }

    Context 'Function uploads blob successfully' {
        BeforeEach {
            Mock -CommandName Test-Path -MockWith {
                return $true
            }
            Mock -CommandName Import-PowerShellDataFile -MockWith {
                return @{
                    Dependencies = @(
                        @{
                            ModuleName      = 'DSCParser'
                            RequiredVersion = '1.3.0.9'
                        },
                        @{
                            ModuleName      = 'ExchangeOnlineManagement'
                            RequiredVersion = '3.1.0'
                        },
                        @{
                            ModuleName      = 'Microsoft.Graph.Applications'
                            RequiredVersion = '1.27.0'
                        }
                    )
                }
            }
            Mock -CommandName Get-AzStorageBlob -MockWith { } -RemoveParameterType Context
            Mock -CommandName Remove-AzStorageBlob -MockWith { } -RemoveParameterType Context
            Mock -CommandName Set-AzStorageBlobContent -MockWith { } -RemoveParameterType Context
            Mock -CommandName Remove-Item -MockWith { }
            Mock -CommandName Compress-Archive -MockWith { }
        }

        It 'Upload successful' {
            Add-ModulesToBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' | Should -Invoke 'Set-AzStorageBlobContent'
        }
    }

    Context 'Dependencies file does not exist' {
        BeforeEach {
            Mock -CommandName Test-Path -MockWith {
                return $false
            }
        }

        It 'File does not exist' {
            Add-ModulesToBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' | Should -Invoke 'Save-Module' -ModuleName 'M365DSCTools' -Times 0
        }
    }
}

