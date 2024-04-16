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

Describe Test-IfModulesInBlobStorage {
    BeforeAll {
        Mock -CommandName Write-Log -MockWith { }
        Mock -CommandName Get-AzStorageAccount -MockWith {
            return @{
                Context = 'Context'
            }
        }
    }

    Context 'Sanity Check' {
        It 'Help' {
            Test-IfModulesInBlobStorage -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Function retrieves blob successfully' {
        BeforeEach {
            Mock -CommandName Get-AzStorageBlob -MockWith {
                return @{
                    Name = 'Blob'
                }
            } -RemoveParameterType Context
        }

        It 'Returns true because item was found' {
            Test-IfModulesInBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' -Version '1.23.530.1' | Should -Be $true
            Should -Invoke 'Get-AzStorageBlob' -ModuleName 'M365DSCTools' -Times 1
        }
    }

    Context 'Dependencies file does not exist' {
        BeforeEach {
            Mock -CommandName Get-AzStorageBlob -MockWith { } -RemoveParameterType Context
        }

        It 'Returns false because item was not found' {
            Test-IfModulesInBlobStorage -ResourceGroupName 'M365DscResources' -StorageAccountName 'M365DscStorageAccount' -ContainerName 'M365DscContainer' -Version '1.23.530.1' | Should -Be $false
            Should -Invoke 'Get-AzStorageBlob' -ModuleName 'M365DSCTools' -Times 1
        }
    }
}

