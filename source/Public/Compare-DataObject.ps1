function Compare-DataObject
{
<#
.SYNOPSIS
    Compare Data Object

.DESCRIPTION
    Deep compares two Data Object and lists the differences between them.

.PARAMETER InputObject
    The input object that will be compared with the reference object (see: [-Reference] parameter).

    > [!NOTE]
    > Multiple input object might be provided via the pipeline.
    > The common PowerShell behavior is to unroll any array (aka list) provided by the pipeline.
    > To avoid a list of (root) objects to unroll, use the **comma operator**:

        ,$InputObject | Compare-DataObject $Reference.

.PARAMETER Reference
    The reference that is used to compared with the input object (see: [-InputObject] parameter).

.PARAMETER IsEqual
    If set, the cmdlet will return a boolean (`$true` or `$false`).
    As soon a Discrepancy is found, the cmdlet will immediately stop comparing further properties.

.PARAMETER MatchCase
    Unless the `-MatchCase` switch is provided, string values are considered case insensitive.

    > [!NOTE]
    > Dictionary keys are compared based on the `$Reference`.
    > if the `$Reference` is an object (PSCustomObject or component object), the key or name comparison
    > is case insensitive otherwise the comparer supplied with the dictionary is used.

.PARAMETER MatchType
    Unless the `-MatchType` switch is provided, a loosely (inclusive) comparison is done where the
    `$Reference` object is leading. Meaning `$Reference -eq $InputObject`:

        '1.0' -eq 1.0 # $false
        1.0 -eq '1.0' # $true (also $false if the `-MatchType` is provided)

.PARAMETER MatchObjectOrder
    Whether a list (or array) is treated as ordered is defined by the `$Reference`.
    Unless the `-MatchObjectOrder` switch is provided, the order of an object array (`@(...)` aka `Object[]`)
    is presumed unordered. This means that `Compare-DataObject` cmdlet will try to match each item of an
    `$InputObject` list which each item in the `$Reference` list.

    If there is a single discrepancy on each side, the properties will be compared deeper, otherwise a
    list with different items will be returned.

.PARAMETER IgnoreArrayOrder
    Whether a list (or array) is treated as ordered is defined by the `$Reference`.
    Unless the `-IgnoreArrayOrder` switch is provided, the order of an array (e.g. `[String[]]('a', b', 'c')`,
    excluding an object array, see: [-MatchObjectOrder]), is presumed ordered.

.PARAMETER IgnoreListOrder
    Whether a list is treated as ordered is defined by the `$Reference`.
    Unless the `-IgnoreListOrder` switch is provided, the order of a list
    (e.g. `[Collections.Generic.List[Int]](1, 2, 3)`), is presumed ordered.

.PARAMETER IgnoreDictionaryOrder
    Whether a dictionary is treated as ordered is defined by the `$Reference`.
    Unless the `-IgnoreDictionaryOrder` switch is provided, the order of a dictionary is presumed ordered.

    > [!WARNING]
    > A `[HashTable]` type is unordered by design and therefore the order of a `$Reference` hash table
    > in always ignored

.PARAMETER IgnorePropertyOrder
    Whether the properties are treated as ordered is defined by the `$Reference`.
    Unless the `-IgnorePropertyOrder` switch is provided, the property order is presumed ordered.

.PARAMETER MaxDepth
    The maximal depth to recursively compare each embedded property (default: 10).

.EXAMPLE
    ,$InputObject | Compare-DataObject $Reference
#>

    [Diagnostics.CodeAnalysis.SuppressMessage('PSUseLiteralInitializerForHashtable', '', Justification = 'Using case sensitive hashtable on purpose')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Still have to check with developer')]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $true)]
        $InputObject,

        [Parameter(Mandatory = $true, Position = 0)]
        $Reference,

        [Switch]
        $IsEqual,

        [Switch]
        $MatchCase,

        [Switch]
        $MatchType,

        [Switch]
        $MatchObjectOrder,

        [Switch]
        $IgnoreArrayOrder,

        [Switch]
        $IgnoreListOrder,

        [Switch]
        $IgnoreDictionaryOrder,

        [Switch]
        $IgnorePropertyOrder,

        [Alias('Depth')]
        [int]
        $MaxDepth = 10
    )
    begin
    {
        $ReferenceNode = [PSNode]::new($Reference)
        $ReferenceNode.MaxDepth = $MaxDepth
        function CompareObject()
        {
            [CmdletBinding()]
            [OutputType([System.Boolean])]
            param (
                [PSNode]
                $ReferenceNode,

                [PSNode]
                $ObjectNode,

                [Switch]
                $IsEqual = $IsEqual
            )

            if ($MatchType)
            {
                if ($ObjectNode.Type -ne $ReferenceNode.Type)
                {
                    if ($IsEqual)
                    {
                        return $false
                    }
                    [PSCustomObject]@{
                        Path        = $ObjectNode.GetPathName()
                        Discrepancy = 'Type'
                        InputObject = $ObjectNode.Type
                        Reference   = $ReferenceNode.Type
                    }
                }
            }
            if ($ObjectNode.Structure -ne $ReferenceNode.Structure)
            {
                if ($IsEqual)
                {
                    return $false
                }
                [PSCustomObject]@{
                    Path        = $ObjectNode.GetPathName()
                    Discrepancy = 'Structure'
                    InputObject = $ObjectNode.Structure
                    Reference   = $ReferenceNode.Structure
                }
            }
            elseif ($ObjectNode.Structure -eq 'Scalar')
            {
                $NotEqual = if ($MatchCase)
                {
                    $ReferenceNode.Value -cne $ObjectNode.Value
                }
                else
                {
                    $ReferenceNode.Value -cne $ObjectNode.Value
                }
                if ($NotEqual)
                {
                    # $ReferenceNode dictates the type
                    if ($IsEqual)
                    {
                        return $false
                    }
                    [PSCustomObject]@{
                        Path        = $ObjectNode.GetPathName()
                        Discrepancy = 'Value'
                        InputObject = $ObjectNode.Value
                        Reference   = $ReferenceNode.Value
                    }
                }
            }
            else
            {
                if ($ObjectNode.get_Count() -ne $ReferenceNode.get_Count())
                {
                    if ($IsEqual)
                    {
                        return $false
                    }
                    [PSCustomObject]@{
                        Path        = $ObjectNode.GetPathName()
                        Discrepancy = 'Size'
                        InputObject = $ObjectNode.get_Count()
                        Reference   = $ReferenceNode.get_Count()
                    }
                }
                if ($ObjectNode.Structure -eq 'List')
                {
                    $ObjectItems = $ObjectNode.GetItemNodes()
                    $ReferenceItems = $ReferenceNode.GetItemNodes()
                    $MatchOrder =
                    $ObjectNode.get_Count() -eq 0 -or $ReferenceNode.get_Count() -eq 0 -or
                        ($ObjectNode.get_Count() -eq 1 -and $ReferenceNode.get_Count() -eq 1) -or
                    $(
                        if ($ReferenceNode.Type.Name -eq 'Object[]')
                        {
                            $MatchObjectOrder
                        }
                        elseif ($ReferenceNode.Value -eq [Array])
                        {
                            -not $IgnoreArrayOrder
                        }
                        else
                        {
                            -not $IgnoreListOrder
                        }
                    )
                    if ($MatchOrder)
                    {
                        $Min = [Math]::Min($ObjectNode.get_Count(), $ReferenceNode.get_Count())
                        $Max = [Math]::Max($ObjectNode.get_Count(), $ReferenceNode.get_Count())
                        for ($Index = 0; $Index -lt $Max; $Index++)
                        {
                            if ($Index -lt $Min)
                            {
                                $Compare = CompareObject -Reference $ReferenceItems[$Index] -Object $ObjectItems[$Index] -IsEqual:$IsEqual
                                if ($Compare -eq $false)
                                {
                                    return $Compare
                                }
                                elseif ($Compare -ne $true)
                                {
                                    $Compare
                                }
                            }
                            elseif ($Index -ge $ObjectNode.get_Count())
                            {
                                if ($IsEqual)
                                {
                                    return $false
                                }
                                [PSCustomObject]@{
                                    Path        = $ReferenceItems[$Index].GetPathName() # ($ObjectItem doesn't exist)
                                    Discrepancy = 'Exists'
                                    InputObject = $false
                                    Reference   = $true
                                }
                            }
                            else
                            {
                                if ($IsEqual)
                                {
                                    return $false
                                }
                                [PSCustomObject]@{
                                    Path        = $ObjectItems[$Index].GetPathName()
                                    Discrepancy = 'Exists'
                                    InputObject = $true
                                    Reference   = $false
                                }
                            }
                        }
                    }
                    else
                    {
                        $ObjectLinks = [system.collections.generic.dictionary[int, int]]::new()
                        $ReferenceLinks = [system.collections.generic.dictionary[int, int]]::new()
                        foreach ($ObjectItem in $ObjectItems)
                        {
                            $Found = $Null
                            foreach ($ReferenceItem in $ReferenceItems)
                            {
                                if (-not $ReferenceLinks.ContainsKey($ReferenceItem.Index))
                                {
                                    $Found = CompareObject -Reference $ReferenceItem -Object $ObjectItem -IsEqual
                                    if ($Found)
                                    {
                                        $ReferenceLinks[$ReferenceItem.Index] = $ObjectItem.Index
                                        break # Link only one reference item
                                    }
                                }
                            }
                            if ($Found)
                            {
                                $ObjectLinks[$ObjectItem.Index] = $ReferenceItem.Index
                            }
                            elseif ($IsEqual)
                            {
                                return $false
                            }
                        }
                        $MissingObjects = $ObjectItems.get_Count() - $ObjectLinks.get_Count()
                        $MissingReferences = $ReferenceItems.get_Count() - $ReferenceLinks.get_Count()
                        $Equal = -not $MissingObjects -and -not $MissingReferences
                        if ($IsEqual)
                        {
                            return $Equal
                        }
                        elseif ($Equal)
                        {
                            return
                        }
                        if ($MissingObjects -eq 1 -and $MissingReferences -eq 1)
                        {
                            $ObjectExcept = ([int[]][Linq.Enumerable]::Except([int[]]$ObjectItems.Index, [int[]]$ObjectLinks.get_Keys()))[0]
                            $ReferenceExcept = ([int[]][Linq.Enumerable]::Except([int[]]$ReferenceItems.Index, [int[]]$ReferenceLinks.get_Keys()))[0]
                            CompareObject -Reference $ReferenceItems[$ReferenceExcept] -Object $ObjectItems[$ObjectExcept] -IsEqual:$IsEqual
                        }
                        else
                        {
                            $Max = [Math]::Max($ObjectNode.get_Count(), $ReferenceNode.get_Count())
                            for ($Index = 0; $Index -lt $Max; $Index++)
                            {
                                if ($Index -ge $ObjectItems.get_Count())
                                {
                                    [PSCustomObject]@{
                                        Path        = $ReferenceNode.GetPathName() + "[$Index]"
                                        Discrepancy = 'Exists'
                                        InputObject = $false
                                        Reference   = $true
                                    }
                                }
                                elseif ($Index -ge $ReferenceItems.get_Count())
                                {
                                    [PSCustomObject]@{
                                        Path        = $ObjectNode.GetPathName() + "[$Index]"
                                        Discrepancy = 'Exists'
                                        InputObject = $true
                                        Reference   = $false
                                    }
                                }
                                elseif ($Index -notin $ObjectLinks.get_Keys())
                                {
                                    [PSCustomObject]@{
                                        Path        = $ReferenceNode.GetPathName() + "[$Index]"
                                        Discrepancy = 'Linked'
                                        InputObject = $false
                                        Reference   = $ReferenceLinks[$Index]
                                    }
                                }
                                elseif ($Index -notin $ReferenceLinks.get_Keys())
                                {
                                    [PSCustomObject]@{
                                        Path        = $ObjectNode.GetPathName() + "[$Index]"
                                        Discrepancy = 'Linked'
                                        InputObject = $ObjectLinks[$Index]
                                        Reference   = $false
                                    }
                                }
                            }
                        }
                    }
                }
                elseif ($ObjectNode.Structure -eq 'Dictionary')
                {
                    $Found = [HashTable]::new() # (Case sensitive)
                    $MatchOrder = $ReferenceNode.Type.Name -ne 'HashTable' -and $(
                        if ($ReferenceNode.Construction -eq 'Object')
                        {
                            -not $IgnorePropertyOrder
                        }
                        else
                        {
                            -not $IgnoreDictionaryOrder
                        }
                    )
                    $Order = if ($MatchOrder)
                    {
                        [HashTable]::new()
                    }
                    $Index = 0
                    if ($MatchOrder)
                    {
                        $ReferenceNode.Get_Keys().foreach{ $Order[$_] = $Index++ }
                    }
                    $Index = 0
                    foreach ($ObjectItem in $ObjectNode.GetItemNodes())
                    {
                        if ($ReferenceNode.Contains($ObjectItem.Key))
                        {
                            $ReferenceItem = $ReferenceNode.GetItemNode($ObjectItem.Key)
                            $Found[$ReferenceItem.Key] = $true
                            if ($MatchOrder -and $Order[$ReferenceItem.Key] -ne $Index)
                            {
                                if ($IsEqual)
                                {
                                    return $false
                                }
                                [PSCustomObject]@{
                                    Path        = $ObjectItem.GetPathName()
                                    Discrepancy = 'Order'
                                    InputObject = $Index
                                    Reference   = $Order[$ReferenceItem.Key]
                                }
                            }
                            $Compare = CompareObject -Reference $ReferenceItem -Object $ObjectItem -IsEqual:$IsEqual
                            if ($Compare -eq $false)
                            {
                                return $Compare
                            }
                            elseif ($Compare -ne $true)
                            {
                                $Compare
                            }
                        }
                        else
                        {
                            if ($IsEqual)
                            {
                                return $false
                            }
                            [PSCustomObject]@{
                                Path        = $ObjectItem.GetPathName()
                                Discrepancy = 'Exists'
                                InputObject = $true
                                Reference   = $false
                            }
                        }
                        $Index++
                    }
                    $ReferenceNode.get_Keys().foreach{
                        if (-not $Found.Contains($_))
                        {
                            if ($IsEqual)
                            {
                                return $false
                            }
                            [PSCustomObject]@{
                                Path        = $ReferenceNode.GetItemNode($_).GetPathName()
                                Discrepancy = 'Exists'
                                InputObject = $false
                                Reference   = $true
                            }
                        }
                    }
                }
            }
            if ($IsEqual)
            {
                return $true
            }
        }
    }
    process
    {
        CompareObject -ReferenceNode $ReferenceNode -ObjectNode $InputObject
    }
}
