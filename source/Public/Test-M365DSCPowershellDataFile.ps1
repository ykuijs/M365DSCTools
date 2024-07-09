Function Test-M365DSCPowershellDataFile {
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
    Specifies the type of tests to run. Allowed values are:
    'TypeValue', 'Required', 'Mandatory', 'TypeValue/Required', 'TypeValue/Mandatory', 'Required/Mandatory', 'TypeValue/Required/Mandatory'.

    .Parameter InputObject
    The object that contains the data object that needs to be tested.

    .Parameter MandatoryObject
    The object that contains the Mandatory data.

    .Parameter Exclude_AvailableAsResource
    All items that are available as a resource and have to be ignored.

    .Parameter Exclude_Required
    Required items have to be ignored.

    .Parameter Verbosity
    Specifies the verbosity level of the output. Allowed values are:
    None', 'Detailed', 'Diagnostic'. Default is 'Detailed'.

    .Parameter StackTraceVerbosity
    Specifies the verbosity level of the output. Allowed values are:
    'None', 'FirstLine', 'Filtered', 'Full'. Default is 'Firstline'.

    .Parameter PesterScript
    If specified, the generated Pester script will be opened in an editor.

    .Example
        $Result = Test-M365DSCPowershellDataFile -Test TypeValue/Required -InputObject $InputObject

    .Example
        $Result = Test-M365DSCPowershellDataFile -Test TypeValue/Required/Mandatory `
        -InputObject $InputObject `
        -MandatoryObject $MandatoryObject `
        -Exclude_AvailableAsResource *CimInstance, *UniqueID, *IsSingleInstance `
        -Exclude_Required *CimInstance, *UniqueID `
        -Verbosity Detailed `
        -StackTraceVerbosity None `
        -PesterScript `
        -Verbose

    .NOTES
        This function requires Modules: M365DSC.CompositeResources, ObjectGraphTools

    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '', Justification = 'Need Invoke Expression for performance, input is validated')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification = 'Bug powershell, Vars are declared')]

    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('TypeValue', 'Required', 'Mandatory', 'TypeValue/Required', 'TypeValue/Mandatory', 'Required/Mandatory', 'TypeValue/Required/Mandatory' )]
        [String]$Test,

        [Parameter(Mandatory = $False)]
        [ValidateSet('None', 'Detailed', 'Diagnostic')]
        [String]$Verbosity = 'Detailed',

        [Parameter(Mandatory = $False)]
        [ValidateSet('None', 'FirstLine', 'Filtered', 'Full')]
        [String]$StackTraceVerbosity = 'FirstLine',

        [Parameter(Mandatory = $False)]
        [Switch]$PesterScript
    )

    DynamicParam {
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        $AttributeCollection1 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $true
        $AttributeCollection1.Add($ParameterAttribute)

        $AttributeCollection2 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection2.Add($ParameterAttribute)

        if ($Null -ne $Test ) {
            $ParamName = 'InputObject'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [System.Object], $AttributeCollection1)
            $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)

            $ParamName = 'Exclude_AvailableAsResource'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [String[]], $AttributeCollection2)
            $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)
        }

        if ($Test -like '*Mandatory*') {
            $ParamName = 'MandatoryObject'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [System.Object], $AttributeCollection1)
            $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)
        }

        if ($Test -like '*Required*') {
            $ParamName = 'Exclude_Required'
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [String[]], $AttributeCollection2)
            $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)
        }

        return $RuntimeParameterDictionary
    }

    begin {

        $InputObject = $PSboundParameters['InputObject']
        $MandatoryObject = $PSboundParameters['MandatoryObject']
        $Exclude_AvailableAsResource = $PSboundParameters['Exclude_AvailableAsResource']
        $Exclude_Required = $PSboundParameters['Exclude_Required']

        # Test if the ObjectGraphTools module is loaded and the class is available
        if (-not ([System.Management.Automation.PSTypeName]'PSNode').Type) {
            Import-Module ObjectGraphTools -Force
        }

        Class M365DSC_Reference_Values {
            [string]$Type
            [string]$Required
            [String]$Description
            [String]$ValidateSet

            M365DSC_Reference_Values([string]$InputString) {
                [array]$Result = $InputString.split('|').foreach{ $_.trim() }
                $this.type = $Result[0]
                $this.Required = $Result[1]
                $this.Description = $Result[2]
                $This.ValidateSet = $Result[3].foreach{ "'" + ($Result[3] -Replace '\s*\/\s*', "', '") + "'" }
            }
        }
        function ShowElapsed {
            param( [Switch]$Reset )
            if ($Reset) {
                $script:TotalTime = get-date
                $script:ElapsedTime = get-date
            }
            if (-not $script:TotalTime ) { $script:TotalTime = get-date }
            if (-not $script:ElapsedTime ) { $script:ElapsedTime = get-date }
            $Result = '^ Elapsed: {0} TotalTime: {1} seconds' -f "$(($(get-date) - $ElapsedTime).TotalSeconds) Seconds".PadRight(30, " ") , ($(get-date) - $TotalTime).TotalSeconds
            $script:ElapsedTime = Get-date
            return $Result
        }

        Function Space {
            param([string]$Depth)
            if ($Depth -ge 3) { $Depth = 3 }
            Return " " * ($Depth)
        }

        function Test-IsGuid {
            [CmdletBinding()][OutputType([bool])]
            param([Parameter(Mandatory = $true, ValueFromPipeline = $True)][string]$StringGuid)
            process {
                try {
                    $ObjectGuid = [System.Guid]::Empty
                    return [System.Guid]::TryParse($StringGuid, [ref]$ObjectGuid)
                }
                catch {
                    Write-Error "An error occurred while checking the GUID format: $_"
                    return $false
                }
            }
        }

        function Pester_Type_Should_Command {
            [CmdletBinding()][OutputType([System.String])]
            param([Parameter(Mandatory = $true)][string]$Type)
            try {
                switch ($Type) {
                    'SInt32' { return "should -match '^\d+$' -because 'Must be a positive Integer'" }
                    'SInt64' { return "should -match '^\d+$' -because 'Must be a positive Integer'" }
                    'UInt32' { return "should -BeOfType 'Int'" }
                    'UInt64' { return "should -BeOfType 'Int'" }
                    'Guid' { return "Test-IsGuid | should -Be 'True'" }
                    default { return "should -BeOfType '$Type'" }
                }
            }
            catch {
                Write-Error "An error occurred while generating Pester 'should' assertion: $_"
                return $null
            }
        }

        Function Recursive_Node {
            param ([psnode]$InputObject)
            if ($InputObject.count -eq 0 ) { return }


            $Childs = $InputObject | Get-ChildNode
            # Required
            if ($Test -like '*Required*') {
                $LeafParent = $True
                $Childs.foreach{ if ( $_ -isnot [PSLeafNode]) { $LeafParent = $false } }
                if ($LeafParent) {
                    $RefChilds = Invoke-Expression  $('$Obj_M365DataExample.{0}' -f $($node.Path) -replace "\[\d+\]", '[0]' )
                    if ($RefChilds) {
                        $Required_Nodes = $RefChilds.GetEnumerator().Where{ $_.value -like '*| Required |*' }.name
                        foreach ($Required_Node in $Required_Nodes) {
                            $Exclude_R = $Exclude_Required | where-object { $('{0}.{1}' -f $Node.Path, $Required_Node) -like $_ } #Check if is Exclude
                            "     {0}{3}`$InputObject.{1}.{2} | should -not -BeNullOrEmpty -Because 'Required setting'" -f $(space $node.depth), $Node.path, $Required_Node, $(if ($Exclude_R.Length) { "#" })
                        }
                    }
                }
            }

            Foreach ($Node in $Childs) {
                [Bool]$IsHashTable = $False
                [bool]$IsArray = $False

                $Exclude_A = $Exclude_AvailableAsResource | where-object { $Node.path -like $_ } #Check if is Exclude
                $HashKey = if ($Exclude_A.Length) { "#" } else { "" }

                if ($Node.count -eq 0 ) { return }
                if ( $node.Depth -le 3 ) { '   {0}It "{1}" {2}{{' -f $(space $node.depth), $Node.path, $(if ($Exclude_A.Length) { "-skip" }   ) }


                if ((-not $IsArray) -and (-not $IsHashTable) -and ($Test -like "*TypeValue*")) {

                    [Bool]$IsHashTable = Invoke-Expression  $('$Obj_M365DataExample.{0} -is [HashTable]' -f $($node.Path) -replace "\[\d+\]", '[0]' )
                    if ($IsHashTable) { "     {0}{1}`$InputObject.{2} -is [HashTable] | should -BeTrue  " -f $(space $node.depth), $HashKey, $node.path }
                    else {
                        [bool]$IsArray = Invoke-Expression  $('$Obj_M365DataExample.{0} -is [Object[]]' -f $($node.Path) -replace "\[\d+\]", '[0]' )
                        if ($IsArray) { "     {0}{1}`$InputObject.{2} -is [Array] | should -BeTrue  " -f $(space $node.depth), $HashKey, $node.path }
                    }

                    $RefResult = Invoke-Expression  $('$Obj_M365DataExample.{0}' -f $($node.Path) -replace "\[\d+\]", '[0]' )
                    if ($RefResult -is [string]) {
                        $Obj_RefResult = [M365DSC_Reference_Values]::new($RefResult)
                        if ($Obj_RefResult.type) {
                            # Type Validation
                            "     {0}{1}`$InputObject.{2} | {3}" -f $(space $node.depth), $HashKey, $node.path , $(Pester_Type_Should_Command $Obj_RefResult.type)
                            if ($Obj_RefResult.ValidateSet) {
                                # ValidationSet Validation
                                "     {0}{1}`$InputObject.{2} | should -beIn {3}" -f $(space $node.depth), $HashKey, $node.path, $Obj_RefResult.ValidateSet
                            }
                        }
                    }
                    if ($null -eq $RefResult ) {
                        "     {0}{1}`$InputObject.{2} | should -BeNullOrEmpty -because 'Not available as Composite Resource'" -f $(space $node.depth), $HashKey , $node.path
                    }

                }

                if ($node -isnot 'PSLeafNode' ) { Recursive_Node $Node } # Recursive call
                if ( $Node.Depth -eq 3 ) { '   {0}}}' -f $(space $node.depth) }

            }
        }

        Function MandatoryObject {
            param ($Workload)
            if ($Test -like "*Mandatory*") {
                '      It "{0} test Mandatory settings" {{' -f $Workload.name
                $node_MandatoryObject = $MandatoryObject.NonNodeData.$($Workload.name) | Get-ChildNode -Leaf -Recurse
                $node_MandatoryObject.ForEach{
                    "        `$InputObject.NonNodeData.{0}.{1} | should -be '{2}'" -f $($Workload.name), $_.path, $_.value
                }
                '      }'
            }
        }

    }
    process {
        $script:TotalTime = get-date
        ShowElapsed  -Reset | out-null
        '-- Function Test-M365DSCPowershellDataFile ------------------------------ ' | Write-log
        'Tests selected: {0}' -f $Test | write-log
        'Exclude AvailableAsResource: {0}' -f ($Exclude_AvailableAsResource -join "; " ) | write-log
        'ExcludeRequired: {0}' -f ($Exclude_Required -join "; ") | write-log

        'Load InputObject as type [psnode]' | Write-log
        $Node_InputObject = $InputObject | get-node
        ShowElapsed | write-log -Verbose

        if ($MandatoryObject) {
            'Load MandatoryObject as type [psnode] ' | Write-log
            $Node_MandatoryObject = $MandatoryObject | get-node
            ShowElapsed | write-log -Verbose
        }

        'Load Example data from module M365DSC.CompositeResources' | Write-log
        $Obj_M365DataExample = @(
            if (Get-Module M365DSC.CompositeResources) {
                Import-PSDataFile -Path ((((Get-Module M365DSC.CompositeResources)).path | Split-Path) + '\M365ConfigurationDataExample.psd1')
            }
            else {
                Import-PSDataFile -Path (((Get-Module -ListAvailable M365DSC.CompositeResources).path | Split-Path) + '\M365ConfigurationDataExample.psd1')
            }
        )
        ShowElapsed | write-log -Verbose

        # Generate pesterscript
        'Generate pesterscript' | Write-Log
        $Pester_Config = @(
            "#Requires -Modules Pester"

            "Describe '--- Check M365-DSC-CompositeResources configuration ---' {"
            foreach ($Workload in $( $Node_InputObject | Get-node("NonNodeData") | Get-ChildNode)) {

                if ($Test -like "*TypeValue*" -or $Test -like "*Required*") {
                    "  Context 'Workload {0}' {{" -f $Workload.Name
                    "    Context 'Type/Validatieset/Required' {"
                    Recursive_Node -InputObject $($Workload | get-node)
                    "    }"
                }

                if ($Test -like "*Mandatory*") {
                    "    Context 'Mandatory' {"
                    MandatoryObject -Workload $($Workload)
                    "    }"
                }
                if ($Test -like "*TypeValue*" -or $Test -like "*Required*") { "  }" }
            }
            "}"
        )
        ShowElapsed | Write-Log -verbose

        try {
            # Ensure that $Pester_Config is defined
            if (-not $Pester_Config) { throw "The variable `\$Pester_Config` is not defined." }

            # Create a temporary Pester script file
            $PesterScriptPath = [System.IO.Path]::ChangeExtension((New-TemporaryFile).FullName, '.tests.ps1')
            $Pester_Config | Out-File -FilePath $PesterScriptPath -Force -Confirm:$false -Encoding ascii

            # Open the Pester script in VSCode
            if ($PesterScript) { psedit $PesterScriptPath }

            # Set parameters for the Pester container
            $PesterParams = [ordered]@{ Path = $PesterScriptPath }
            $PesterContainer = New-PesterContainer @PesterParams

            # Configure Pester settings
            $PesterConfiguration = [PesterConfiguration]@{
                Run    = @{ Container = $PesterContainer; PassThru = $true }
                Should = @{ ErrorAction = "Continue" }
                Output = @{ Verbosity = $Verbosity; StackTraceVerbosity = $StackTraceVerbosity }
            }

            # Execute Pester tests and store results
            'Execute pesterscript' | Write-Log
            $PesterResult = Invoke-Pester -Configuration $PesterConfiguration
            return $PesterResult
        }
        catch {
            Write-Error "An error occurred: $_"
        }
        finally {
            # Clean up the temporary file
            if (Test-Path -Path $PesterScriptPath) {
                Remove-Item -Path $PesterScriptPath -Force -ErrorAction SilentlyContinue
            }

            ShowElapsed | Write-Log -Verbose

            if ( $pesterResult.FailedCount -gt 0) { $Splat = @{ Failure = $true } } else { $Splat = @{} }
            'Pester[{0}]  Tests:{1}  Passed:{2}  Failed:{3} ' -f $PesterResult.version, $PesterResult.TotalCount, $PesterResult.PassedCount, $pesterResult.FailedCount | write-log @splat

            '-- End 2------------------------------------------------------------------ ' | Write-log
        }
    }
}
