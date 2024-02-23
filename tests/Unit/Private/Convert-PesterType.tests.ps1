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
    Describe Convert-PesterType {
        Context 'Test function Convert-PesterType' {
            It 'Converts SInt32 to a Pester test string' {
                $result = Convert-PesterType -Type 'SInt32'
                $result | Should -Be "should -match '^\d+$' -because ""Must be a positive Integer"""
            }

            It 'Converts SInt64 to a Pester test string' {
                $result = Convert-PesterType -Type 'SInt64'
                $result | Should -Be "should -match '^\d+$' -because ""Must be a positive Integer"""
            }

            It 'Converts UInt32 to a Pester test string' {
                $result = Convert-PesterType -Type 'UInt32'
                $result | Should -Be "should -BeOfType 'Int'"
            }

            It 'Converts UInt64 to a Pester test string' {
                $result = Convert-PesterType -Type 'UInt64'
                $result | Should -Be "should -BeOfType 'Int'"
            }

            It 'Converts StringArray to a Pester test string' {
                $result = Convert-PesterType -Type 'StringArray'
                $result | Should -Be "should -BeOfType 'String'"
            }

            It 'Converts GUID to a Pester test string' {
                $result = Convert-PesterType -Type 'Guid'
                $result | Should -Be "Test-IsGuid | should -Be 'True'"
            }

            It 'Converts Boolean to a Pester test string' {
                $result = Convert-PesterType -Type 'Boolean'
                $result | Should -Be "should -BeOfType 'Boolean'"
            }
        }
    }
}

