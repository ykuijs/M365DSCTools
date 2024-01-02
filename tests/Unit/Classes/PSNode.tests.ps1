$ProjectPath = "$PSScriptRoot\..\..\.." | Convert-Path
$ProjectName = (Get-ChildItem $ProjectPath\*\*.psd1 | Where-Object {
        ($_.Directory.Name -match 'source|src' -or $_.Directory.Name -eq $_.BaseName) -and
        $(try { Test-ModuleManifest $_.FullName -ErrorAction Stop }catch{$false}) }
    ).BaseName

Import-Module $ProjectName

InModuleScope $ProjectName {
    Describe PSNode {
        Context 'Type creation' {
            It 'Has created a type named PSNode' {
                'PSNode' -as [Type] | Should -BeOfType [Type]
            }
        }

        Context 'Constructors' {
            It 'Has a default constructor with hashtable' {
                $instance = [PSNode]::new(@{Test2=2;Test1=1})
                $instance | Should -Not -BeNullOrEmpty
                $instance.GetType().Name | Should -Be 'PSNode'
            }

            It 'Has a default constructor with array' {
                $instance = [PSNode]::new(@(1,2,3,4,5,6,7,8,9,10))
                $instance | Should -Not -BeNullOrEmpty
                $instance.GetType().Name | Should -Be 'PSNode'
            }

            It 'Has a default constructor with PSCustomObject' {
                $object = [PSCustomObject]@{Test2=2;Test1=1}
                $instance = [PSNode]::new($object)
                $instance | Should -Not -BeNullOrEmpty
                $instance.GetType().Name | Should -Be 'PSNode'
            }
        }

        Context 'Methods' {
            BeforeEach {
                $instance = [PSNode]::new(@{Test2=2;Test1=1})
                $objInstance = [PSNode]::new([PSCustomObject]@{Test2=2;Test1=1})
            }

            It 'Test GetPath method' {
                $instance.GetItemNode('Test1').GetPath() | Should -Be 'Test1'
            }

            It 'Test GetPathName method' {
                $instance.GetItemNode('Test1').GetPathName() | Should -Be '.Test1'
            }

            It 'Test Contains method' {
                $instance = [PSNode]::new(@{Test2=2;Test1=1})
                $instance.Contains('Test1') | Should -Be $true
                $instance.Contains('Test3') | Should -Be $false
            }

            It 'Test Get method' {
                $instance.Get('Test1') | Should -Be 1

                $objInstance.Get('Test1') | Should -Be 1
            }

            It 'Test Set method' {
                $instance.Set('Test1',3)
                $instance.Get('Test1') | Should -Be 3

                $objInstance.Set('Test1',3)
                $objInstance.Get('Test1') | Should -Be 3
            }

            It 'Test GetItemNode method' {
                $item = $instance.GetItemNode('Test1')
                $item.MaxDepth | Should -Be 10
                $item.Key | Should -Be 'Test1'
                $item.Depth | Should -Be 1
                $item.Parent | Should -Not -BeNullOrEmpty
                $item.Value | Should -Be 1
                $item.Construction | Should -Be 'Scalar'

                $item2 = $objInstance.GetItemNode('Test1')
                $item2.MaxDepth | Should -Be 10
                $item2.Key | Should -Be 'Test1'
                $item2.Depth | Should -Be 1
                $item2.Parent | Should -Not -BeNullOrEmpty
                $item2.Value | Should -Be 1
                $item2.Construction | Should -Be 'Scalar'
            }

            It 'Test GetItemNodes method' {
                $items = $instance.GetItemNodes()
                $items[0].MaxDepth | Should -Be 10
                $items[0].Key | Should -Be 'Test1'
                $items[0].Depth | Should -Be 1
                $items[0].Parent | Should -Not -BeNullOrEmpty
                $items[0].Value | Should -Be 1
                $items[0].Construction | Should -Be 'Scalar'

                $items2 = $objInstance.GetItemNodes()
                $items2[0].MaxDepth | Should -Be 10
                $items2[0].Key | Should -Be 'Test2'
                $items2[0].Depth | Should -Be 1
                $items2[0].Parent | Should -Not -BeNullOrEmpty
                $items2[0].Value | Should -Be 2
                $items2[0].Construction | Should -Be 'Scalar'
            }

            It 'Test get_Count method' {
                $instance.get_Count() | Should -Be 2
            }

            It 'Test get_Keys method' {
                $instance.get_Keys() | Should -Be @('Test1', 'Test2')
            }

            It 'Test get_Values method' {
                $instance.get_Values() | Should -Be @(1,2)
            }
        }

        Context 'Properties' {
            BeforeEach {
                $instance = [PSNode]::new(@{Test2=2;Test1=1})
            }

            It 'Has a Type property' {
                $instance.Type.ToString() | Should -Be 'System.Collections.Hashtable'
            }
        }
    }
}
