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
}

AfterAll {
    $PSDefaultParameterValues.Remove('Mock:ModuleName')
    $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
    $PSDefaultParameterValues.Remove('Should:ModuleName')

    Remove-Module -Name $script:moduleName
}

Describe Import-PSDataFile {
    BeforeAll {
        $psd1File = "TestDrive:\reference.psd1"

        $psdContent = @"
@{
    Item1 = 'Value1'
    Item2 = 'Value2'
    Item3 = @{
        Item4 = 'Value4'
        Item5 = 'Value5'
    }
    Item6 = @(
        'Value6'
        'Value7'
    )
}
"@
        Out-File -FilePath $psd1File -InputObject $psdContent -Encoding 'UTF8' -Force
    }

    Context 'Test function Import-PSDataFile' {
        It 'Should import data files successfully' {
            $mergeResult = Import-PSDataFile -Path $psd1File

            $mergeResult | Should -BeOfType [System.Collections.Hashtable]
        }
    }
}

