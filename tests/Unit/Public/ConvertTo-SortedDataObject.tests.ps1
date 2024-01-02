#Requires -Modules @{ModuleName="Pester"; ModuleVersion="5.0.0"}

[Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssignments', 'Object', Justification = 'False positive')]
param()

Describe 'ConvertTo-SortedDataObject' {
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
            Comment = 'Sample ObjectGraph'
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
            ConvertTo-SortedDataObject -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Scalar Array' {

        It 'Integer' {
            $Object = 3, 1, 2
            $Sorted = , $Object | ConvertTo-SortedDataObject
            $Sorted | Should -Be 1, 2, 3
            $Sorted = , $Object | ConvertTo-SortedDataObject -Descending
            $Sorted | Should -Be 3, 2, 1
        }

        It 'String' {
            $Object = 'c3', 'a1', 'b2'
            $Sorted = , $Object | ConvertTo-SortedDataObject
            $Sorted | Should -Be 'a1', 'b2', 'c3'
            $Sorted = , $Object | ConvertTo-SortedDataObject -Descending
            $Sorted | Should -Be 'c3', 'b2', 'a1'
        }
    }


    Context 'Dictionary' {
        $Dictionary = @{ c = 1; a = 3; b = 2 }
        $Sorted = $Dictionary | ConvertTo-SortedDataObject
        $Sorted | Should -BeOfType PSCustomObject
        $Sorted.PSObject.Properties.Name | Should -Be 'a', 'b', 'c'
        $Sorted.PSObject.Properties.Value | Should -Be 3, 2, 1
    }

    Context 'PSCustomObject' {
        $PSCustomObject = [PSCustomObject]@{ c = 1; a = 3; b = 2 }
        $Sorted = $PSCustomObject | ConvertTo-SortedDataObject
        $Sorted | Should -BeOfType PSCustomObject
        $Sorted.PSObject.Properties.Name | Should -Be 'a', 'b', 'c'
        $Sorted.PSObject.Properties.Value | Should -Be 3, 2, 1
    }

    Context 'Dictionary Array' {

        BeforeEach {
            $Object = @{
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
                        Name    = 'One'
                        Comment = 'Third item'
                    }
                )
            }
        }

        It 'Basic Sort' {
            $Sorted = $Object | ConvertTo-SortedDataObject
            $Sorted.Data.Index | Should -Be 1, 2, 3
            $Sorted.PSObject.Properties.Name | Should -Be 'Comment', 'Data'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Comment', 'Index', 'Name'
        }

        It 'Descending' {
            $Sorted = $Object | ConvertTo-SortedDataObject -Descending
            $Sorted.Data.Index | Should -Be 2, 3, 1
            $Sorted.PSObject.Properties.Name | Should -Be 'Data', 'Comment'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Index', 'Comment'
        }

        It 'By Name' {
            $Sorted = $Object | ConvertTo-SortedDataObject -By Name
            $Sorted.Data.Index | Should -Be 1, 3, 2
            $Sorted.PSObject.Properties.Name | Should -Be 'Comment', 'Data'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Comment', 'Index'
        }

        It 'By Name Descending' {
            $Sorted = $Object | ConvertTo-SortedDataObject -By Name -Descending
            $Sorted.Data.Index | Should -Be 2, 3, 1
            $Sorted.PSObject.Properties.Name | Should -Be 'Data', 'Comment'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Index', 'Comment'
        }
    }

    Context 'Object Array' {

        BeforeEach {
            $Object = @{
                Comment = 'Sample DataObject'
                Data    = @(
                    [PSCustomObject]@{
                        Index   = 1
                        Name    = 'One'
                        Comment = 'First item'
                    }
                    [PSCustomObject]@{
                        Index   = 2
                        Name    = 'Two'
                        Comment = 'Second item'
                    }
                    [PSCustomObject]@{
                        Index   = 3
                        Name    = 'One'
                        Comment = 'Third item'
                    }
                )
            }
        }

        It 'Basic Sort' {
            $Sorted = $Object | ConvertTo-SortedDataObject
            $Sorted.Data.Index | Should -Be 1, 2, 3
            $Sorted.PSObject.Properties.Name | Should -Be 'Comment', 'Data'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Comment', 'Index', 'Name'
        }

        It 'Descending' {
            $Sorted = $Object | ConvertTo-SortedDataObject -Descending
            $Sorted.Data.Index | Should -Be 2, 3, 1
            $Sorted.PSObject.Properties.Name | Should -Be 'Data', 'Comment'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Index', 'Comment'
        }

        It 'By Name' {
            $Sorted = $Object | ConvertTo-SortedDataObject -By Name
            $Sorted.Data.Index | Should -Be 1, 3, 2
            $Sorted.PSObject.Properties.Name | Should -Be 'Comment', 'Data'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Comment', 'Index'
        }

        It 'By Name Descending' {
            $Sorted = $Object | ConvertTo-SortedDataObject -By Name -Descending
            $Sorted.Data.Index | Should -Be 2, 3, 1
            $Sorted.PSObject.Properties.Name | Should -Be 'Data', 'Comment'
            $Sorted.Data[0].PSObject.Properties.Name | Should -Be 'Name', 'Index', 'Comment'
        }
    }

    Context 'Types' {

        It 'Type' {
            $Object = @{
                String           = 'String'
                HereString       = @'
Hello
World
'@
                Int              = 67
                Double           = 1.2
                Long             = 1234567890123456
                DateTime         = [DateTime]'1963-10-07T17:56:53.8139055'
                Version          = [Version]'1.2.34567.890'
                Guid             = [Guid]'5f167621-6abe-4153-a26c-f643e1716720'
                Script           = { 2 * 3 }
                Array            =
                'One',
                'Two',
                'Three',
                'Four'
                ByteArray        =
                1,
                2,
                3
                StringArray      =
                'One',
                'Two',
                'Three'
                EmptyArray       = @()
                SingleValueArray = , 'one'
                SubArray         =
                'One',
                (
                    'Two',
                    'Three'
                ),
                'Four'
                HashTable        = @{ Name = 'Value' }
                Ordered          = [Ordered]@{
                    One   = 1
                    Two   = 2
                    Three = 3
                    Four  = 4
                }
                Object           = [PSCustomObject]@{ Name = 'Value' }
                NullValue        = $null
            }

            { $Object | ConvertTo-SortedDataObject } | Should -Not -Throw
        }

        Context 'Issues' {

            It '#2: Merge-DataObject Bug' {
            }
        }

        Context 'Warning' {
            It 'Depth' {
                $Object = @{ Name = 'Test' }
                $Object.Parent = $Object
                $Records = ConvertTo-SortedDataObject $Object 3>&1
                $Records.where{ $_ -is [System.Management.Automation.WarningRecord] }.Message | Should -BeLike '*maximum depth*10*'
                $Records.where{ $_ -isnot [System.Management.Automation.WarningRecord] }.Name | Should -Be 'Test'
            }
        }

        Context 'Issues' {

            It '#12: Bug ConvertTo-SortedDataObject' {

                $Object = ConvertFrom-Json '
                {
                    "NonNodeData": {
                        "Teams": {
                            "AppSetupPolicies": [
                                {
                                    "Ensure": "Present",
                                    "Identity": "Global",
                                    "PinnedAppBarApps": [
                                        "86fcd49b-61a2-4701-b771-54728cd291fb",
                                        "42f6c1da-a241-483a-a3cc-4f5be9185951",
                                        "2a84919f-59d8-4441-a975-2a8c2643b741",
                                        "14d6962d-6eeb-4f48-8890-de55454bb136",
                                        "14072831-8a2a-4f76-9294-057bf0b42a68"
                                    ]
                                }
                            ]
                        }
                    }
                }'

                $Sorted = $Object | ConvertTo-SortedDataObject
                $Sorted.NonNodeData.Teams.AppSetupPolicies[0].PinnedAppBarApps[0] | Should -BeOfType String
                $Sorted.NonNodeData.Teams.AppSetupPolicies[0].PinnedAppBarApps[0].Length | Should -BeGreaterThan 1
            }
        }
    }
}
