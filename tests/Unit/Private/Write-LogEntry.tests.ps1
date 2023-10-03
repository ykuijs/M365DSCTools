$ProjectPath = "$PSScriptRoot\..\..\.." | Convert-Path
$ProjectName = ((Get-ChildItem -Path $ProjectPath\*\*.psd1).Where{
        ($_.Directory.Name -match 'source|src' -or $_.Directory.Name -eq $_.BaseName) -and
        $(try
            {
                Test-ModuleManifest $_.FullName -ErrorAction Stop
            }
            catch
            {
                $false
            } )
    }).BaseName


Import-Module $ProjectName

InModuleScope $ProjectName {
    Describe Write-LogEntry {
        Context 'Test function Write-LogEntry' {
            BeforeEach {
                Mock -CommandName Write-Host -MockWith { }
            }

            It 'Outputs a string to the console' {
                $msg = 'This is a log entry'
                Write-LogEntry -Message $msg | Should -Invoke Write-Host -ParameterFilter {
                    $Object -like "* - $msg"
                }
            }

            It 'Outputs a string to the console with indentation' {
                $msg = 'This is an indented log entry'
                Write-LogEntry -Message $msg -Level 1 | Should -Invoke Write-Host -ParameterFilter {
                    $Object -like "* -   $msg"
                }
            }
        }
    }
}

