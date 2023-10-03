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
    Describe Merge-Hashtable {
        Context 'Test function Merge-Hashtable' {
            BeforeAll {
                Mock -CommandName Write-LogEntry -MockWith { }
            }
            BeforeEach {
            }

            It 'Merges an hashtable into another hashtable' {
                $reference = @{
                    Identity = '1234'
                    Name     = 'Test'
                    Value    = 5
                }
                $merge = @{
                    Identity = '1234'
                    Name     = 'NewValue'
                    Value    = 10
                    NewKey   = 'NewValue'
                }

                $result = Merge-Array -Reference $reference -Merge $merge
                $result.Name | Should -Be 'NewValue'
                $result.Value | Should -Be 10
                $result.NewKey | Should -Be 'NewValue'
            }
        }
    }
}

