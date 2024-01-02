[Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssignments', 'Reference', Justification = 'False positive')]
param()

Describe 'Compare-DataObject' {
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
            Compare-DataObject -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Compare' {

        It 'Equal (Do not match type)' {
            $Object = @{
                Comment = 'Sample DataObject'
                Data    = @(
                    @{
                        Index   = 1
                        Name    = 'One'
                        Comment = 'First item'
                    }
                    @{
                        Index   = '2'
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
            $Object | Compare-DataObject $Reference -IsEqual | Should -Be $True
            $Object | Compare-DataObject $Reference | Should -BeNullOrEmpty
        }

        It 'Different type' {
            $Object = @{
                Comment = 'Sample DataObject'
                Data    = @(
                    @{
                        Index   = 1
                        Name    = 'One'
                        Comment = 'First item'
                    }
                    @{
                        Index   = '2'
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
            $Object | Compare-DataObject $Reference -IsEqual -MatchType | Should -Be $false
            $Result = $Object | Compare-DataObject $Reference -MatchType
            @($Result).Count | Should -Be 1
            $Result.Path | Should -Be '.Data[1].Index'
            $Result.Discrepancy | Should -Be 'Type'
            $Result.InputObject.ToString() | Should -Be 'System.String'
            $Result.Reference.ToString() | Should -Be 'System.Int32'
        }

        It 'Different string value' {
            $Object = @{
                Comment = 'Something else'
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
            $Object | Compare-DataObject $Reference -IsEqual | Should -Be $False
            $Result = $Object | Compare-DataObject $Reference
            @($Result).Count | Should -Be 1
            $Result.Path | Should -Be '.Comment'
            $Result.Discrepancy | Should -Be 'Value'
            $Result.InputObject | Should -Be 'Something else'
            $Result.Reference | Should -Be 'Sample DataObject'
        }
    }

    It 'Missing entry' {
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
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $False
        $Result = $Object | Compare-DataObject $Reference
        $Result.Count | Should -Be 2
        $Result[0].Path | Should -Be '.Data'
        $Result[0].Discrepancy | Should -Be 'Size'
        $Result[0].InputObject | Should -Be 2
        $Result[0].Reference | Should -Be 3
        $Result[1].Path | Should -Be '.Data[2]'
        $Result[1].Discrepancy | Should -Be 'Exists'
        $Result[1].InputObject | Should -Be $False
        $Result[1].Reference | Should -Be $True
    }
    It 'Extra entry' {
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
                    Name    = 'Three'
                    Comment = 'Third item'
                }
                @{
                    Index   = 4
                    Name    = 'Four'
                    Comment = 'Forth item'
                }
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $False
        $Result = $Object | Compare-DataObject $Reference
        $Result.Count | Should -Be 2
        $Result[0].Path | Should -Be '.Data'
        $Result[0].Discrepancy | Should -Be 'Size'
        $Result[0].InputObject | Should -Be 4
        $Result[0].Reference | Should -Be 3
        $Result[1].Path | Should -Be '.Data[3]'
        $Result[1].Discrepancy | Should -Be 'Exists'
        $Result[1].InputObject | Should -Be $True
        $Result[1].Reference | Should -Be $False
    }
    It 'Different entry value' {
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
                    Name    = 'Zero'               # This is different
                    Comment = 'Third item'
                }
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $False
        $Result = $Object | Compare-DataObject $Reference
        @($Result).Count | Should -Be 1
        $Result[0].Path | Should -Be '.Data[2].Name'
        $Result[0].Discrepancy | Should -Be 'Value'
        $Result[0].InputObject | Should -Be 'Zero'
        $Result[0].Reference | Should -Be 'Three'
    }
    It 'Unordered array' {
        $Object = @{
            Comment = 'Sample DataObject'
            Data    = @(
                @{
                    Index   = 1
                    Name    = 'One'
                    Comment = 'First item'
                }
                @{
                    Index   = 3
                    Name    = 'Three'
                    Comment = 'Third item'
                }
                @{
                    Index   = 2
                    Name    = 'Two'
                    Comment = 'Second item'
                }
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $True
        $Object | Compare-DataObject $Reference -MatchObjectOrder -IsEqual | Should -Be $False
        $Result = $Object | Compare-DataObject $Reference -MatchObjectOrder
        $Result.Count | Should -Be 6
    }
    It 'Unordered (hashtable) reference' {
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
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $True

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
                    Comment = 'Second item'                     # Note:
                    Name    = 'Two'                                # These entries are swapped
                }
                [PSCustomObject]@{
                    Index   = 3
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
        $Object | Compare-DataObject $Reference -IsEqual | Should -Be $True
    }
    It 'Ordered (PSCustomObject) reference' {
        $Ordered = @{                                           # Redefine Reference with order Dictionary/PSCustomObject
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
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
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
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
        $Object | Compare-DataObject $Ordered -IsEqual | Should -Be $True

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
                    Comment = 'Second item'                     # Note:
                    Name    = 'Two'                                # These entries are swapped
                }
                [PSCustomObject]@{
                    Index   = 3
                    Name    = 'Three'
                    Comment = 'Third item'
                }
            )
        }
        $Object | Compare-DataObject $Ordered -IsEqual | Should -Be $False
    }

    Context 'Issues' {
        It 'Compare single discrepancies' {
            $Obj1 = ConvertFrom-Json '
                {
                    "NonNodeData": {
                        "Exchange": {
                            "AcceptedDomains": [
                                {
                                    "DomainType": "Authoritative",
                                    "Ensure": "PresentX",
                                    "MatchSubDomains": true,
                                    "OutboundOnly": true,
                                    "UniqueId": "Default"
                                }
                            ],
                            "ActiveSyncDeviceAccessRules": [],
                            "AddressBookPolicies": [],
                            "AddressLists": []
                        }
                    }
                }'
            $Obj2 = ConvertFrom-Json '
                {
                    "NonNodeData": {
                        "Exchange": {
                            "AcceptedDomains": [
                                {
                                    "DomainType": "Authoritative",
                                    "Ensure": "PresentY",
                                    "MatchSubDomains": true,
                                    "OutboundOnly": true,
                                    "UniqueId": "Default"
                                }
                            ],
                            "ActiveSyncDeviceAccessRules": [],
                            "AddressBookPolicies": [],
                            "AddressLists": []
                        }
                    }
                }'
            $Obj1 | Compare-DataObject $Obj2 -IsEqual | Should -Be $False
            $Result = $Obj1 | Compare-DataObject $Obj2
            @($Result).Count | Should -Be 1
            $Result[0].Path | Should -Be '.NonNodeData.Exchange.AcceptedDomains[0].Ensure'
            $Result[0].Discrepancy | Should -Be 'Value'
            $Result[0].InputObject | Should -Be 'PresentX'
            $Result[0].Reference | Should -Be 'PresentY'
        }
    }
}
