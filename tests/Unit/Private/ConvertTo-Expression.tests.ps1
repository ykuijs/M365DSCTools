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
    Describe ConvertTo-Expression {
        Context 'Test function ConvertTo-Expression' {
            BeforeAll {
                $myObject = @{
                    NonNodeData = @{
                        Teams = @{
                            Resource2 = @{
                                IsSingleInstance = 'Yes'
                                Item2 = 1
                                Item1 = 'Test'
                            }
                        }
                        Exchange = @{
                            Resource1 = @{
                                Identity = 'Global'
                                Item4 = $false
                                Item3 = 'Test2'
                            }
                        }
                    }
                    AllNodes = @(
                        @{
                            CertificateThumbprint = '1234567890'
                            NodeName = 'localhost'
                        }
                    )
                }
            }
            It 'Converts hashtable object into a string' {
                $targetResult = @"
@{
    AllNodes = ,@{
        CertificateThumbprint = '1234567890'
        NodeName = 'localhost'
    }
    NonNodeData = @{
        Teams = @{Resource2 = @{
                Item2 = 1
                IsSingleInstance = 'Yes'
                Item1 = 'Test'
            }}
        Exchange = @{Resource1 = @{
                Item4 = `$False
                Item3 = 'Test2'
                Identity = 'Global'
            }}
    }
}
"@
                $result = ConvertTo-Expression -Object $myObject
                $result | Should -Be $targetResult
            }
        }
    }
}

