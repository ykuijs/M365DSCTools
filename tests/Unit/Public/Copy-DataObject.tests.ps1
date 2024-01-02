[Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssignments', 'Reference', Justification = 'False positive')]
param()

Describe 'Copy-DataObject' {
    BeforeAll {
        Set-StrictMode -Version Latest

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

        $Reference = @{
            Comment = 'Sample DataObject'
            Data    = @(
                @{
                    Index   = 1
                    Name    = 'One'
                    Comment = 'First item'
                }
                @{
                    Index   = 2
                    Name    = 'Two'
                    Comment = 'Second item'
                }
                @{
                    Index   = 3
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
    }

    AfterAll {
        $PSDefaultParameterValues.Remove('Mock:ModuleName')
        $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
        $PSDefaultParameterValues.Remove('Should:ModuleName')

        Remove-Module -Name $script:moduleName
    }

    Context 'Sanity Check' {

        It 'Help' {
            Copy-DataObject -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Copy' {

        It 'Copy Object' {
            $Copy = Copy-DataObject -InputObject $Reference

            $Copy.Comment | Should -Be $Reference.Comment
            $Copy.Data[0].Index | Should -Be $Reference.Data[0].Index
            $Copy.Data[0].Name | Should -Be $Reference.Data[0].Name
            $Copy.Data[0].Comment | Should -Be $Reference.Data[0].Comment
        }
    }
}
