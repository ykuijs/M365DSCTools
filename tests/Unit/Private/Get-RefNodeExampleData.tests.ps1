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
    Describe Get-RefNodeExampleData {
        Context 'Test function Get-RefNodeExampleData' {
            It 'Retrieves information of the specified ' {
                $exampleData = @{
                    NonNodeData = @{
                        Office365 = @{
                            OrgSettings = @{
                                Test = "String | Optional | This is example data."
                                ToDoIsPushNotificationEnabled = "Boolean | Optional | To Do - Allow your users to receive push notifications."
                            }
                        }
                    }
                }

                Import-Module ObjectGraphTools -Global -Force

                $node = [PSNode]::ParseInput($exampleData, 20)
                $leafnode = $node._("NonNodeData")._("Office365")._("OrgSettings")._("ToDoIsPushNotificationEnabled")

                $result = Get-RefNodeExampleData -Node $leafnode -ReferenceObject $exampleData
                $result.Description | Should -Be "To Do - Allow your users to receive push notifications."
                $result.Type | Should -Be "Boolean"
                $result.Required | Should -Be "Optional"
            }
        }
    }
}

