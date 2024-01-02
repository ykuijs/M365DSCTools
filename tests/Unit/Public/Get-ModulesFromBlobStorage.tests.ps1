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

Describe Get-ModulesFromBlobStorage {
    BeforeAll {
        Mock -CommandName Write-LogEntry -MockWith { }
        Mock -CommandName Get-AzStorageAccount -MockWith {
            return @{
                Context = 'Context'
            }
        }
        Mock -CommandName Test-Path -MockWith {
            return $true
        }
        Mock -CommandName Copy-Item -MockWith { }
        Mock -CommandName Get-ChildItem -MockWith {
            return @{
                Name = 'Microsoft365DSC'
            }
        }
    }

    Context 'Sanity Check' {
        It 'Help' {
            Get-ModulesFromBlobStorage -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Function retrieves blob successfully' {
        BeforeEach {
            Mock -CommandName Get-AzStorageBlob -MockWith {
                return @{
                    Name = 'Blob'
                }
            } -RemoveParameterType Context
            Mock -CommandName Get-AzStorageBlobContent -MockWith { } -RemoveParameterType Context
            Mock -CommandName Remove-Item -MockWith { }
            Mock -CommandName Expand-Archive -MockWith { }
        }

        It 'Returns a single object' {
            Get-ModulesFromBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' -Version '1.23.530.1' | Should -Invoke 'Copy-Item' -ModuleName 'M365DSCTools' -Times 1
        }
    }

    Context 'Dependencies file does not exist' {
        BeforeEach {
            Mock -CommandName Get-AzStorageBlob -MockWith { } -RemoveParameterType Context
        }

        It 'Returns a single object' {
            Get-ModulesFromBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' -Version '1.23.530.1' | Should -Invoke 'Copy-Item' -ModuleName 'M365DSCTools' -Times 0
        }
    }
}

