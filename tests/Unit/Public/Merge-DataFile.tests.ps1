BeforeAll {
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

    function Test-IsPsCustomObject
    {
        [CmdletBinding()]
        param (
            [Parameter()]
            [System.Object]
            $v
        )
        $v.PSTypeNames -contains 'System.Management.Automation.PSCustomObject'
    }

    function Test-Equality
    {
        param
        (
            [Parameter()]
            [System.Object]
            $a,

            [Parameter()]
            [System.Object]
            $b
        )

        # recursive step for arrays
        if ($a -is [array] -and $b -is [array])
        {
            if ($a.Count -ne $b.Count)
            {
                return $false
            }
            $inequalIndexes = 0..($a.Count - 1) | Where-Object { -not (Test-Equality $a[$_] $b[$_]) }
            return $inequalIndexes.Count -eq 0
        }
        # recursive step for hashtables
        if ($a -is [hashtable] -and $b -is [hashtable])
        {
            $inequalKeys = $a.Keys + $b.Keys `
            | Sort-Object -Unique `
            | Where-Object { -not (Test-Equality $a[$_] $b[$_]) }
            return $inequalKeys.Count -eq 0
        }
        # recursive step for objects
        # use a helper function to circumvent this PowerShell bug:
        # https://github.com/PowerShell/PowerShell/issues/9557
        if ((Test-IsPsCustomObject -v $a) -and (Test-IsPsCustomObject -v $b))
        {
            $inequalKeys = $a.psobject.Properties + $b.psobject.Properties `
            | ForEach-Object Name `
            | Sort-Object -Unique `
            | Where-Object { -not (Test-Equality $a.$_ $b.$_) }
            return $inequalKeys.Count -eq 0
        }
        # base case
        return ($null -ne $a -or $null -ne $null) -and $a.GetType() -eq $b.GetType() -and $a -eq $b
    }
}

AfterAll {
    $PSDefaultParameterValues.Remove('Mock:ModuleName')
    $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
    $PSDefaultParameterValues.Remove('Should:ModuleName')

    Remove-Module -Name $script:moduleName
}

Describe Merge-DataFile {
    BeforeAll {
        $reference = @{
            NonNodeData = @{
                Exchange   = @{
                    Policies = @(
                        @{
                            UniqueId = 'ExPol1'
                            Name     = 'ExPol1'
                        }
                        @{
                            UniqueId = 'ExPol2'
                            Name     = 'ExPol2Old'
                        }
                    )
                }
                SharePoint = @{
                    Policies         = @(
                        @{
                            UniqueId = 'SpPol1'
                            Name     = 'SpPol1'
                        }
                    )
                    ReferenceSetting = $true
                    SettingsArray    = @(
                        'Test'
                    )
                }
                IntSetting = 0
                StrSetting = 'old'
            }
        }

        $merge = @{
            NonNodeData = @{
                Exchange    = @{
                    Policies = @(
                        @{
                            UniqueId = 'ExPol2'
                            Name     = 'ExPol2New'
                        }
                        @{
                            UniqueId = 'ExPol3'
                            Name     = 'ExPol3'
                        }
                    )
                }
                SharePoint  = @{
                    Policies                = @(
                        @{
                            UniqueId = 'SpPol2'
                            Name     = 'SpPol2'
                        }
                    )
                    Setting                 = $false
                    SettingsHash            = @{
                        Name = 'Test'
                    }
                    SettingsArray           = @(
                        'Test2'
                    )
                    AdditionalSettingsArray = @(
                        'Test'
                    )
                }
                IntSetting  = 1
                StrSetting  = 'new'
                IntSetting2 = 2
                StrSetting2 = 'new2'
            }
        }

        $desiredResult = @{
            NonNodeData = @{
                Exchange    = @{
                    Policies = @(
                        @{
                            UniqueId = 'ExPol1'
                            Name     = 'ExPol1'
                        }
                        @{
                            UniqueId = 'ExPol2'
                            Name     = 'ExPol2New'
                        }
                        @{
                            UniqueId = 'ExPol3'
                            Name     = 'ExPol3'
                        }
                    )
                }
                SharePoint  = @{
                    Policies                = @(
                        @{
                            UniqueId = 'SpPol1'
                            Name     = 'SpPol1'
                        }
                        @{
                            UniqueId = 'SpPol2'
                            Name     = 'SpPol2'
                        }
                    )
                    Setting                 = $false
                    ReferenceSetting        = $true
                    SettingsHash            = @{
                        Name = 'Test'
                    }
                    SettingsArray           = @(
                        'Test',
                        'Test2'
                    )
                    AdditionalSettingsArray = @(
                        'Test'
                    )
                }
                IntSetting  = 1
                StrSetting  = 'new'
                IntSetting2 = 2
                StrSetting2 = 'new2'
            }
        }

        Mock -CommandName Write-LogEntry -MockWith { }
    }

    Context 'Test function Merge-DataFile' {
        It 'Should merge data files successfully' {
            $mergeResult = Merge-DataFile -Reference $reference -Merge $merge

            Test-Equality -A $desiredResult -B $mergeResult | Should -Be $true
        }
    }
}

