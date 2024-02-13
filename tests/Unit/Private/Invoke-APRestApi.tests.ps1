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
    Describe Invoke-APRestApi {
        Context 'Test function Invoke-APRestApi' {
            BeforeEach {
                $uri = 'https://api.domain.com'
                $method = 'GET'

                $headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
                $headers.Add('Content-Type', 'application/json')

                $body = "[body]"

                Mock -CommandName Invoke-RestMethod -MockWith { "Called!" }
            }

            It 'Runs the function with mandatory params' {
                $result = Invoke-APRestApi -Uri $uri -Method $method
                $result | Should -Be "Called!"
            }

            It 'Runs the function with optional params' {
                $result = Invoke-APRestApi -Uri $uri -Method $method -Headers $headers -Body $body
                $result | Should -Be "Called!"
            }
        }
    }
}

