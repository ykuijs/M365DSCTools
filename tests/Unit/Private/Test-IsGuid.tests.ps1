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
    Describe Test-IsGuid {
        Context 'Test function Test-IsGuid' {
            It 'Provided string is GUID, return True' {
                Test-IsGuid -StringGuid '4756d311-220b-4e1d-ae47-8718a08ad16c' | Should -Be $true
            }

            It 'Provided string is NOT a GUID, return False' {
                Test-IsGuid -StringGuid 'Not a GUID' | Should -Be $false
            }
        }
    }
}

