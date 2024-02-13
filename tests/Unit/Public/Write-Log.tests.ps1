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

Describe Write-Log {
    BeforeAll {
        $global:OutString = ''

        Mock -CommandName Write-Host -MockWith { $global:OutString += $Object }
        Mock -CommandName Write-Error -MockWith { $global:OutString += $Object }
        Mock -CommandName Add-Content -MockWith { }
        Mock -CommandName Out-File -MockWith { }
    }

    Context 'Test function Write-Log' {
        It 'Should successfully write a log entry' {
            $global:OutString = ''
            Write-Log -Object 'This is a test entry!'
            Should -Invoke Write-Host -Times 5
        }

        It 'Should successfully write a failure log entry' {
            $global:OutString = ''
            Write-Log -Object 'This is a test failure entry!' -Failure
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[FAILURE]*'
        }

        It 'Should successfully write a warning log entry' {
            $global:OutString = ''
            Write-Log -Object 'This is a test warning entry!' -Warning
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[WARNING]*'
        }

        It 'Should successfully write a log entry and save to file' {
            $global:OutString = ''
            Write-Log -Object 'This is a test entry!' -Path 'C:\Temp\test.log'
            Should -Invoke Write-Host -Times 5
            Should -Invoke Add-Content
        }

        It 'Should successfully write a verbose log entry' {
            $VerbosePreference = 'Continue'
            $global:OutString = ''
            Write-Log -Object 'This is a test entry!' -Verbose
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[VERBOSE]*'
        }

        It 'Should successfully write a debug log entry' {
            $DebugPreference = 'Continue'
            $global:OutString = ''
            Write-Log -Object 'This is a test entry!' -Debug
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[DEBUG]*'
        }

        It 'Should successfully write an error log entry' {
            $global:OutString = ''
            try
            {
                throw "test"
            }
            catch
            {
                $err = $_
            }

            Write-Log -Object $err
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[ERROR]*'
        }

        It 'Should successfully write a whatif log entry' {
            $WhatIfPreference = $true
            $global:OutString = ''
            Write-Log -Object "Test"
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*[WHATIF]*'
        }

        It 'Should show that no error is found' {
            $DebugPreference = 'Continue'
            $global:OutString = ''
            Write-Log -Failure
            Should -Invoke Write-Host -Times 5
            $global:OutString | Should -BeLike '*<No error found>*'
        }

    }

    Context 'Test function Write-Log (Legacy)' {
        It 'Should successfully write a log entry' {
            $global:OutString = ''
            Write-Log -Message 'This is a test entry!' -LogType INFO
            Should -Invoke Write-Host -Times 2
            $global:OutString | Should -BeLike '*[INFO   ]*'
        }

        It 'Should successfully write a warning log entry' {
            $global:OutString = ''
            Write-Log -Message 'This is a test entry!' -LogType WARNING
            Should -Invoke Write-Host -Times 2
            $global:OutString | Should -BeLike '*[WARNING]*'
        }

        It 'Should successfully write a error log entry' {
            $global:OutString = ''
            Write-Log -Message 'This is a test entry!' -LogType ERROR
            Should -Invoke Write-Host -Times 1
            $global:OutString | Should -BeLike '*[ERROR  ]*'
        }

        It 'Should successfully write a log entry' {
            $global:OutString = ''
            Write-Log -Message 'This is a debug test entry!' -LogType INFO -FilePath 'C:\Temp\test.log'
            Should -Invoke -CommandName Out-File -Times 1
        }
    }
}

