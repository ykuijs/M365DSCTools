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

Describe Copy-Object {
    BeforeAll {
        $hashtable = @{
            Item1 = 'Value1'
            Item2 = 'Value2'
            Item3 = @{
                Item4 = 'Value4'
                Item5 = 'Value5'
            }
            Item6 = @(
                'Value6'
                'Value7'
            )
        }
    }

    Context 'Test function Copy-Object' {
        It 'Should copy hashtables successfully' {
            $newObject = Copy-Object -Object $hashtable

            $newObject | Should -BeOfType [System.Collections.Hashtable]
            $newObject | Should -Not -Be $hashtable
        }
    }
}

