#Requires -Modules @{ModuleName="Pester"; ModuleVersion="5.0.0"}

Describe 'Merge-DataObject' {
    BeforeAll {
        Set-StrictMode -Version Latest

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

        $stubPath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\Stubs\AzStorageStubs.psm1' -Resolve
        Import-Module $stubPath

        $Reference = @{
            Comment = 'Sample DataObject'
            Data    = @(
                @{
                    Index   = 1
                    Name    = 'One'
                    Comment = 'First item'
                }
                @{
                    Index   = 2
                    Name    = 'Two'
                    Comment = 'Second item'
                }
                @{
                    Index   = 3
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
    }

    AfterAll {
        $PSDefaultParameterValues.Remove('Mock:ModuleName')
        $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
        $PSDefaultParameterValues.Remove('Should:ModuleName')

        Remove-Module -Name $script:moduleName
    }

    Context 'Sanity Check' {

         It 'Help' {
             Merge-DataObject -? | Out-String -Stream | Should -Contain SYNOPSIS
         }
    }

    Context 'Merge' {

        It 'Scalar Array' {
            ,@('a', 'b', 'c') | Merge-DataObject 'b', 'c', 'd' | Should -Be (,@('a','b','c','d'))
        }

        It 'Dictionary' {
            $InputObject = @{
                a = 1
                b = 2
                c = 3
            }

            $Template = @{
                b = 2
                c = 3
                d = 4
            }

            $Actual = $InputObject | Merge-DataObject $Template
            $Actual.Count | Should -Be 4
            $Actual.Keys | Should -Contain 'a'
            $Actual.Keys | Should -Contain 'd'
        }

        It 'Array of Dictionaries' {
            $InputObject = @(
                @{
                    Key = 'Key1'
                    a = 1
                    b = 2
                }
                @{
                    Key = 'Key2'
                    c = 3
                    d = 4
                }
            )

            $Template = @(
                @{
                    Key = 'Key2'
                    a = 1
                    b = 2
                }
                @{
                    Key = 'Key3'
                    c = 3
                    d = 4
                }
            )

            $Actual = ,$InputObject | Merge-DataObject $Template
            $Actual.Count | Should -Be 4
        }
    }

    It 'append Dictionaries items by Key' {
        $InputObject = @(
            @{
                Key = 'Key1'
                a = 1
                b = 2
            }
            @{
                Key = 'Key2'
                c = 3
                d = 4
            }
        )

        $Template = @(
            @{
                Key = 'Key2'
                a = 1
                b = 2
            }
            @{
                Key = 'Key3'
                c = 3
                d = 4
            }
        )

        $Actual = ,$InputObject | Merge-DataObject $Template -PrimaryKey Key
        $Actual.Count | Should -Be 3
        $Actual.where{ $_.Key -eq 'Key1' }[0].Count | Should -Be 3
        $Actual.where{ $_.Key -eq 'Key2' }[0].Count | Should -Be 5
        $Actual.where{ $_.Key -eq 'Key3' }[0].Count | Should -Be 3
    }

    It 'replace Dictionaries items by Key' {
        $InputObject = @(
            @{
                Key = 'Key1'
                a = 1
                b = 2
            }
            @{
                Key = 'Key2'
                c = 3
                d = 4
            }
        )

        $Template = @(
            @{
                Key = 'Key2'
                c = 1
                d = 2
            }
            @{
                Key = 'Key3'
                e = 3
                f = 4
            }
        )

        $Actual = ,$InputObject | Merge-DataObject $Template -PrimaryKey Key
        $Actual.Count | Should -Be 3
        $Actual.where{ $_.Key -eq 'Key1' }[0].Count | Should -Be 3
        $Actual.where{ $_.Key -eq 'Key2' }[0].Count | Should -Be 3
        $Actual.where{ $_.Key -eq 'Key3' }[0].Count | Should -Be 3
    }

    Context 'Warning' {

        It 'Depth' {
            $Template = @{ Name = 'Base' }
            $Template.Parent = $Template
            $InputObject = @{ Name = 'Test' }
            $InputObject.Parent = $InputObject
            $Records = $InputObject | Merge-DataObject $Template 3>&1
            $Records.where{$_ -is    [System.Management.Automation.WarningRecord]}.Message | Should -BeLike '*maximum depth*10*'
            $Records.where{$_ -isnot [System.Management.Automation.WarningRecord]}.Name    | Should -Be     'Test'
        }
   }

   Context 'Issues' {

        It '#2: Merge-DataObject Bug' {
            $Obj_1 = @{
                AllNodes = @(
                    @{
                        CertificateFile = '.\DSCCertificate.cer'
                        NodeName = 'localhost'
                    }
                )
            }

            $Obj_2 = @{
                NonNodeData = @{
                    OneDrive = @{
                        Settings = @{
                        }
                    }
                }
            }

            $Actual = Merge-DataObject -Template $Obj_1 -InputObject $Obj_2
            $Expected = @{
                    NonNodeData = @{OneDrive = @{Settings = @{}}}
                    AllNodes = ,@{
                        NodeName = 'localhost'
                        CertificateFile = '.\DSCCertificate.cer'
                    }
                }

            $Actual | Compare-DataObject $Expected -IsEqual | Should -Be $True
        }
    }

    It '[PSCustomObject]' {
        $Obj_1 = @{
            AllNodes = @(
                @{
                    CertificateFile = '.\DSCCertificate.cer'
                    NodeName = 'localhost'
                }
            )
        } | ConvertTo-Json -Depth 9 | ConvertFrom-Json

        $Obj_2 = @{
            NonNodeData = @{
                OneDrive = @{
                    Settings = @{
                    }
                }
            }
        } | ConvertTo-Json -Depth 9 | ConvertFrom-Json

        $Actual = Merge-DataObject -Template $Obj_1 -InputObject $Obj_2
        $Expected = @{
                NonNodeData = @{OneDrive = @{Settings = @{}}}
                AllNodes = ,@{
                    NodeName = 'localhost'
                    CertificateFile = '.\DSCCertificate.cer'
                }
            }

        $Actual | Compare-DataObject $Expected -IsEqual | Should -Be $True
    }
}
