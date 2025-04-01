function Test-M365DSCPowershellDataFile
{
    <#
    .Synopsis
    Tests the specified object against the information defined in the ExampleData
    from the M365DSC.CompositeResources module.

    .Description
    This function tests the specified object against the information defined in the
    ExampleData from the M365DSC.CompositeResources module. It creates a Pester test
    to check if the specified data and types are correct, as specified in the example
    data.

    .Parameter Test
    Specifies the Tests. Allowed values are:
    'TypeValue','Required','Mandatory'

    .Parameter InputObject
    The object that contains the data object that needs to be tested.

    .Parameter MandatoryObject
    The object that contains the Mandatory data.

    .Parameter MandatoryAction
    Action Type for test Mandatory 'Present', 'Absent'

    .Parameter ExcludeAvailableAsResource
    All items that are available as a resource and have to be ignored.  ( wildcards can be used )

    .Parameter ExcludeRequired
    Required items have to be ignored. ( no wildcards )

    .Parameter IncludeRequired
    Required items that have to be checked. ( no wildcards )
    To be used for the TypeValue test, mostly for the UniqueId parameter.

    .Parameter PesterVerbosity
    Specifies the verbosity level of the output. Allowed values are:
    None', 'Detailed', 'Diagnostic'. Default is 'Detailed'.

    .Parameter PesterStackTraceVerbosity
    Specifies the verbosity level of the output. Allowed values are:
    'None', 'FirstLine', 'Filtered', 'Full'. Default is 'Firstline'.

    .Parameter PesterShowScript
    If specified, the generated Pester script will be opened in an editor.

    .Parameter PesterOutputObject
    If specified, the executed Pester script result will returned.

    .Example
    $InputObject = Import-PSDataFile -path '%Filename%.psd'

    Test-M365DSCPowershellDataFile -Test TypeValue, Required `
    -InputObject $InputObject `
    -ExcludeAvailableAsResource *CimInstance, *UniqueID, *IsSingleInstance `
    -ExcludeRequired CimInstance, UniqueID `
    -PesterShowScript

    .Example
    $InputObject = Import-PSDataFile -path '%Filename_InputObject%.psd1'
    $MandatoryObject = Import-PSDataFile -path '$Filename_MandatoryObject%.psd1'

    Test-M365DSCPowershellDataFile -Test TypeValue, Required, Mandatory `
    -InputObject $InputObject `
    -MandatoryObject $MandatoryObject `
    -MandatoryAction Present `
    -ExcludeAvailableAsResource *CimInstance, *UniqueID, *IsSingleInstance `
    -ExcludeRequired CimInstance, UniqueID `
    -PesterShowScript


    .NOTES
    This function requires Modules: M365DSC.CompositeResources, ObjectGraphTools
    #>

    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification = 'Bug powershell, Vars are declared')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Vars are used in sub functions')]

    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('TypeValue', 'Required', 'Mandatory')]
        [String[]]
        $Test,

        [Parameter(Mandatory = $true)]
        [System.Object]
        $InputObject,

        [Parameter()]
        [System.Object]
        $MandatoryObject,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [string]
        $MandatoryAction,

        [Parameter()]
        [String[]]
        $ExcludeAvailableAsResource,

        [Parameter()]
        [String[]]
        $ExcludeRequired,

        [Parameter()]
        [String[]]
        $IncludeRequired,

        [Parameter()]
        [ValidateSet('None', 'Detailed', 'Diagnostic')]
        [String]
        $PesterVerbosity = 'Detailed',

        [Parameter()]
        [ValidateSet('None', 'FirstLine', 'Filtered', 'Full')]
        [String]
        $PesterStackTraceVerbosity = 'FirstLine',

        [Parameter()]
        [Switch]
        $PesterShowScript,

        [Parameter()]
        [Switch]
        $PesterOutputObject
    )

    begin
    {
        # Test if the ObjectGraphTools module is loaded and the class is available
        if (-not ([System.Management.Automation.PSTypeName]'PSNode').Type)
        {
            Import-Module ObjectGraphTools -Force
        }

        # Function to display elapsed and total time
        function ShowElapsed
        {
            param
            (
                [Switch]
                $reset
            )

            if ($reset)
            {
                $script:totalTime = Get-Date; $script:elapsedTime = Get-Date
            }

            if (-not $script:totalTime)
            {
                $script:totalTime = Get-Date
            }

            if (-not $script:elapsedTime)
            {
                $script:elapsedTime = Get-Date
            }

            $result = '^ Elapsed: {0} TotalTime: {1} seconds' -f "$(($(Get-Date) - $elapsedTime).TotalSeconds) Seconds".PadRight(30, ' ') , ($(Get-Date) - $totalTime).TotalSeconds
            $script:elapsedTime = Get-Date

            return $result
        }

        # Function to test if a string is a valid GUID
        function Test-IsGuid
        {
            [CmdletBinding()]
            [OutputType([bool])]
            param
            (
                [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
                [string]
                $stringGuid
            )

            process
            {
                try
                {
                    $objectGuid = [System.Guid]::Empty
                    return [System.Guid]::TryParse($stringGuid, [ref]$objectGuid)
                }
                catch
                {
                    Write-Error "An error occurred while checking the GUID format: $_"
                    return $false
                }
            }
        }

        # Function to generate Pester "should" commands based on type
        function Pester_Type_Should_Command
        {
            [CmdletBinding()]
            [OutputType([System.String])]
            param
            (
                [Parameter(Mandatory = $true)]
                [string]
                $type
            )

            try
            {
                switch ($type) {
                    'SInt32' { return "Should -Match '^\d+$' -Because 'Must be a positive Integer'" }
                    'SInt64' { return "Should -Match '^\d+$' -Because 'Must be a positive Integer'" }
                    'UInt32' { return "Should -BeOfType 'Int'" }
                    'UInt64' { return "Should -BeOfType 'Int'" }
                    'Guid' { return "Test-IsGuid | Should -Be 'True'" }
                    default { return "Should -BeOfType '$type'" }
                }
            }
            catch
            {
                Write-Error "An error occurred while generating Pester 'should' assertion: $_"
                return $null
            }
        }

        # Class M365DSC reference values
        class M365DSC_Reference_Values
        {
            [string]$type
            [string]$required
            [String]$description
            [String]$validateSet

            M365DSC_Reference_Values([string]$inputString) {
                [array]$result = $inputString.split('|').foreach{ $_.trim() }
                $this.type = $result[0]
                $this.required = $result[1]
                $this.description = $result[2]
                $this.validateSet = $result[3].foreach{ "'" + ($result[3] -Replace '\s*\/\s*', "', '") + "'" }
            }
        }

        function Create_Pesternodes_Mandatory
        {
            param
            (
                [Parameter()]
                [psnode]
                $MandatoryObject
            )
            $MandatoryLeafs = $MandatoryObject | get-childnode -Recurse -Leaf
            $MandatoryLeafs.foreach{
                if ($MandatoryAction -eq 'Absent')
                {
                    "`$inputObject.{0} | Should -BeNullOrEmpty -Because 'Denied Mandatory Setting'" -f $_.Path
                }
                else
                {
                    "`$inputObject.{0} | Should -Be {1} -Because 'Mandatory Setting'" -f $_.Path, $_.Value
                }
            }
        }

        function Create_PesterNode
        {
            param
            (
                [Parameter()]
                [psnode]
                $nodeObject,

                [Parameter()]
                [switch]
                $recursive
            )

            $refNodePath = '{0}' -f $($nodeObject.Path) -replace '\[\d+\]', '[0]'
            $objRefNode = $ht[$refNodePath]

            # Exclude nodes that match the patterns defined in $excludeAvailableAsResource
            foreach ($Exclude in $excludeAvailableAsResource)
            {
                if ($nodeObject.Path -like $Exclude)
                {
                    "#`$inputObject.{0}" -f $nodeObject.Path
                    return
                }
            }

            # No Composite Resource available
            if ($null -eq $objRefNode)
            {
                "`$inputObject.{0} | Should -BeNullOrEmpty -Because 'Not available as Composite Resource'" -f $nodeObject.Path
                return
            }

            if ($nodeObject -is [psCollectionNode])
            {
                # Check Folder Type
                if ($Typevalue)
                {
                    [Bool]$isHashTable = $( $objRefNode.valueType.name -eq 'HashTable')
                    if ($isHashTable)
                    {
                        "`$inputObject.{0} -is [HashTable] | Should -BeTrue" -f $nodeObject.Path
                    }
                    else
                    {
                        "`$inputObject.{0} -is [Array] | Should -BeTrue " -f $nodeObject.Path
                    }
                }

                # Check for required parameters
                if ($Required -or $IncludeRequiredTest)
                {
                    $objRequiredNodes = $htRequired["$($refNodePath)"]
                    if ($objRequiredNodes)
                    {
                        foreach ($objRequiredNode in $objRequiredNodes)
                        {
                            if ($objRequiredNode.Path -eq 'NonNodeData.Environment.CICD.DependsOn')
                            {
                                # NonNodeData.Environment.CICD.DependsOn is required, but can be an empty value
                                "`$inputObject.{0}{1} | Should -Not -Be `$null -Because 'Required setting'" -f $nodeObject.Path, $(if ( $objRequiredNode.Name -ne 0 ) { ".$($objRequiredNode.Name)" })
                            }
                            else
                            {
                                if ($objRequiredNode.Name -notin $excludeRequired)
                                {
                                    "`$inputObject.{0}{1} | Should -Not -BeNullOrEmpty -Because 'Required setting'" -f $nodeObject.Path, $(if ( $objRequiredNode.Name -ne 0 ) { ".$($objRequiredNode.Name)" })
                                }
                                else
                                {
                                    "#`$inputObject.{0}{1} | Should -Not -BeNullOrEmpty -Because 'Required setting'" -f $nodeObject.Path, $(if ( $objRequiredNode.Name -ne 0 ) { ".$($objRequiredNode.Name)" })
                                }
                            }
                        }
                    }
                }

                # Recursively process child nodes if exsists
                $childs = $nodeObject | Get-ChildNode
                foreach ($node in $childs)
                {
                    if ($recursive)
                    {
                        Create_PesterNode -nodeObject $node -recursive
                    }
                }

            }
            else
            {
                # LeafNode
                if ($Typevalue)
                {
                    $objRefNodeValue = [M365DSC_Reference_Values]::new($objRefNode.Value)
                    # Type Validation
                    if ($objRefNodeValue.type)
                    {
                        "`$inputObject.{0} | {1}" -f $nodeObject.path , $(Pester_Type_Should_Command $objRefNodeValue.type)
                    }

                    # ValidationSet Validation
                    if ($objRefNodeValue.validateSet)
                    {
                        "`$inputObject.{0} | Should -BeIn {1}" -f $nodeObject.path, $objRefNodeValue.validateSet
                    }
                }
            }
        }
    }

    process
    {
        $Typevalue = $false
        $Required = $false
        $IncludeRequiredTest = $false
        $Mandatory = $false

        if ($Test -contains 'TypeValue')
        {
            $Typevalue = $true

            # Check if the IncludeRequired parameter is specified
            # If so, set the IncludeRequiredTest parameter to true
            if ($PSBoundParameters.ContainsKey('IncludeRequired'))
            {
                $IncludeRequiredTest = $true
            }
        }
        if ($Test -contains 'Required')
        {
            $Required = $true
        }
        if ($Test -contains 'Mandatory')
        {
            $Mandatory = $true
            if (-not $MandatoryObject -or -not $MandatoryAction)
            {
                throw 'Mandatory test needs the parameters MandatoryObject and MandatoryAction'
            }
        }

        ShowElapsed -Reset | Out-Null
        'Test(s) selected: {0}' -f $( $Test -join ', ') | Write-Log
        'Load Example data from module M365DSC.CompositeResources' | Write-Log

        $Module = Get-Module M365DSC.CompositeResources
        if ($null -eq $Module)
        {
            $Module = Get-Module -ListAvailable M365DSC.CompositeResources
            if ($null -eq $Module)
            {
                throw "Cannot find module 'M365DSC.CompositeResources'"
            }
        }
        if ($Module.Count -gt 1)
        {
            $Module = $Module | Sort-Object -Descending -Property Version | Select-Object -First 1
            "Multiple versions of module M365DSC.CompositeResources found. Using newest version: $($Module.Version)" | Write-Log
        }
        $pathM365DataExample = Join-Path -Path ($Module.path | Split-Path) -ChildPath 'M365ConfigurationDataExample.psd1'
        $objM365DataExample = Import-PSDataFile -path $pathM365DataExample.ToString()

        'Create Hashtables for reference data ' | Write-Log
        [hashtable]$ht = @{}
        [hashtable]$htRequired = @{}
        $nodeObject = $inputObject | Get-ChildNode
        foreach ($node in $nodeObject)
        {
            foreach ($node in $($node | Get-ChildNode))
            {
                # Create Hashtabel Exampledata
                $objM365DataExample | Get-node("$($node.path)") | Get-ChildNode -Recurse -IncludeSelf | ForEach-Object {
                    $ht["$($_.path)"] = $_
                    # Create HashTable Required
                    if ($Required)
                    {
                        if ($_ -is [PSLeafnode])
                        {
                            if ($_.Value -match '\| Required \|')
                            {
                                $parentPath = $_.ParentNode.Path.ToString()
                                if (-not $htRequired.Contains("$parentPath"))
                                {
                                    $htRequired["$parentPath"] = [System.Collections.Generic.List[psnode]]::new()
                                }
                                $htRequired["$parentPath"].add( $_ )
                            }
                        }
                    }

                    if ($Typevalue -and $IncludeRequiredTest)
                    {
                        # If IncludeRequired is specified, we should also check for the presence of UniqueId
                        # when executing the TypeValue check
                        if ($_ -is [PSLeafnode])
                        {
                            if ($_.Name -in $IncludeRequired -and $_.Value -match '\| Required \|')
                            {
                                $parentPath = $_.ParentNode.Path.ToString()
                                if (-not $htRequired.Contains("$parentPath"))
                                {
                                    $htRequired["$parentPath"] = [System.Collections.Generic.List[psnode]]::new()
                                }
                                $htRequired["$parentPath"].add( $_ )
                            }
                        }
                    }
                }
            }
        }

        'Create pester rules' | Write-Log

        $pesterConfig = @(
            '#Requires -Modules Pester'
            'Describe ''--- Check M365-DSC-CompositeResources configuration ---'' {'
            if ($Typevalue -or $Required)
            {
                '  Context ''AllNodes'' {'

                '  }'
                '  Context ''NonNodeData'' {'
                foreach ($workload in ($inputObject | Get-Node 'NonNodeData' | Get-ChildNode))
                {
                    '    Context ''{0}'' {{' -f $workload.Path
                    '      It ''{0}'' {{' -f $workload.Path
                    Create_PesterNode -nodeObject $workload | ForEach-Object { '        {0}' -f $_ }
                    '      }'
                    if ($workload -is [psCollectionNode])
                    {
                        foreach ($workloadFolder in ($workload | Get-ChildNode))
                        {
                            '      It ''{0}'' {{' -f $workloadFolder.Path
                            Create_PesterNode -nodeObject $workloadFolder -recursive | ForEach-Object { '        {0}' -f $_ }
                            '      }'
                        }
                    }
                    '    }'
                }
                '  }'
            }
            if ($Mandatory)
            {
                '  Context ''Mandatory'' {'
                '      It ''Mandatory'' {'
                Create_Pesternodes_Mandatory -MandatoryObject $($MandatoryObject | get-node) | ForEach-Object { '        {0}' -f $_ }
                '    }'
                '  }'
            }
            '}'
        )

        # Remove empty lines from the $pesterConfig variable
        $pesterConfig = $pesterConfig | Where-Object { $_.Trim() -ne '' }

        try
        {
            # Ensure that $pesterConfig is defined before continuing
            if (-not $pesterConfig)
            {
                throw "The variable `\$pesterConfig` is not defined."
            }

            # Create a temporary Pester script file for test execution
            $pesterScriptPath = [System.IO.Path]::ChangeExtension((New-TemporaryFile).FullName, '.tests.ps1')
            $pesterConfig | Out-File -FilePath $pesterScriptPath -Force -Confirm:$false -Encoding ascii

            # Open the generated Pester script in Visual Studio Code
            if ($pesterShowScript)
            {
                psedit $pesterScriptPath
            }

            # Set parameters for the Pester container that manages the test execution
            $pesterParams = [ordered]@{ Path = $pesterScriptPath }
            $pesterContainer = New-PesterContainer @pesterParams

            # Execute the Pester tests and store the results in the $pesterResult variable
            $pesterConfiguration = [PesterConfiguration]@{
                Run    = @{ Container = $pesterContainer; PassThru = $true }
                Should = @{ ErrorAction = 'Continue' }
                Output = @{ Verbosity = $pesterVerbosity ; StackTraceVerbosity = $pesterStackTraceVerbosity }
            }

            # Execute Pester tests and store results
            'Execute pesterscript' | Write-Log
            $pesterResult = Invoke-Pester -Configuration $pesterConfiguration
            if ($PesterOutputObject)
            {
                return $pesterResult
            }
        }
        catch
        {
            Write-Error "An error occurred: $_"
        }
        finally
        {
            # Remove the temporary Pester script file after the tests have been executed
            if (Test-Path -Path $pesterScriptPath)
            {
                Remove-Item -Path $pesterScriptPath -Force -ErrorAction SilentlyContinue
            }

            ShowElapsed | Write-Log -Verbose
            # Log the test results, with failure handling if any tests have failed
            if ($pesterResult.FailedCount -gt 0)
            {
                $splat = @{ Failure = $true }
            }
            else
            {
                $splat = @{}
            }
            'Pester[{0}]  Tests:{1}  Passed:{2}  Failed:{3} ' -f $pesterResult.version, $pesterResult.TotalCount, $pesterResult.PassedCount, $pesterResult.FailedCount | Write-Log @splat
        }
    }
}
