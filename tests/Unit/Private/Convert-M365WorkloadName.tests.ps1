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
    Describe Convert-M365WorkloadName {
        Context 'Test function Convert-M365WorkloadName' {
            It 'Converts AzureAD to a short name' {
                $result = Convert-M365WorkloadName -Name 'AzureAD'
                $result | Should -Be 'AAD'
            }
        }
    }
}

