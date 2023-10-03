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
    Describe Merge-Array {
        Context 'Test function Merge-Array' {
            BeforeAll {
                Mock -CommandName Write-LogEntry -MockWith { }
            }

            It 'Simple array should be merged successfully' {
                $reference = @('a', 'b', 'c')
                $merge = @('c', 'd', 'e')

                $result = Merge-Array -Reference $reference -Merge $merge
                $result.Count | Should -Be 5
                Compare-Object -ReferenceObject $result -DifferenceObject @( 'a', 'b', 'c', 'd', 'e' ) | Should -BeNullOrEmpty
            }

            It 'More complex array should be merged successfully' {
                $reference = @(
                    @{
                        Identity = '1234'
                        Name     = 'Test'
                        Value    = 5
                    }
                )
                $merge = @(
                    @{
                        Identity = '1234'
                        Name     = 'NewValue'
                        Value    = 10
                    },
                    @{
                        Identity = '5678'
                        Name     = 'Test'
                        Value    = 5
                    }
                )

                $result = Merge-Array -Reference $reference -Merge $merge
                $result.Count | Should -Be 2

                $item = $result | Where-Object { $_.Identity -eq '1234' }
                $item.Name | Should -Be 'NewValue'
                $item.Value | Should -Be 10
            }
        }
    }
}

