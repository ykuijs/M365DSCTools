function ConvertTo-SortedDataObject
{
    <#
.SYNOPSIS
    Sort Data Object

.DESCRIPTION
    Recursively sorts a Data Object alphabetically.

.PARAMETER InputObject
    The input object that will be recursively sorted.

    > [!NOTE]
    > Multiple input object might be provided via the pipeline.
    > The common PowerShell behavior is to unroll any array (aka list) provided by the pipeline.
    > To avoid a list of (root) objects to unroll, use the **comma operator**:

        ,$InputObject | ConvertTo-SortedDataObject.

.PARAMETER PrimaryKey
    Any primary key defined by the [-PrimaryKey] parameter will be put on top of [-InputObject]
    independent of the (descending) sort order.

    It is allowed to supply multiple primary keys.

.PARAMETER MatchCase
    Indicates that the sort is case-sensitive. By default, sorts aren't case-sensitive.

.PARAMETER Descending
    Indicates that ConvertTo-SortedDataObject sorts the objects in descending order. The default is ascending order.

    > [!NOTE]
    > Primary keys (see: [-PrimaryKey]) will always put on top.

.PARAMETER MaxDepth
    The maximal depth to recursively compare each embedded property (default: 10).

.EXAMPLE
    ,$InputObject | ConvertTo-SortedDataObject
#>

    [Diagnostics.CodeAnalysis.SuppressMessage('PSUseLiteralInitializerForHashtable', '', Justification = 'Using case sensitive hashtable on purpose')]
    [Diagnostics.CodeAnalysis.SuppressMessage('PSUseApprovedVerbs', '')]
    [CmdletBinding()]
    [OutputType([Object[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $True)]
        $InputObject,

        [Alias('By')]
        [String[]]
        $PrimaryKey,

        [Switch]
        $MatchCase,

        [Switch]
        $Descending,

        [Alias('Depth')]
        [int]
        $MaxDepth = 10
    )

    begin
    {
        $Primary = @{}
        if ($PSBoundParameters.ContainsKey('PrimaryKey'))
        {
            for ($i = 0; $i -lt $PrimaryKey.Count; $i++)
            {
                if ($Descending)
                {
                    $Primary[$PrimaryKey[$i]] = [Char]254 + '#' * ($PrimaryKey.Count - $i)
                }
                else
                {
                    $Primary[$PrimaryKey[$i]] = ' ' + '#' * $i
                }
            }
        }

        function SortObject
        {
            [CmdletBinding()]
            [OutputType([Object[]])]
            param
            (
                [Parameter()]
                [PSNode]
                $Node,

                [Switch]
                $SortIndex
            )
            if ($Node.Structure -eq 'Scalar')
            {
                $SortKey = if ($Null -eq $($Node.Value))
                {
                    [Char]27 + '$Null'
                }
                elseif ($MatchCase)
                {
                    "$($Node.Value)".ToUpper()
                }
                else
                {
                    "$($Node.Value)"
                }
                $Output = @{ $SortKey = $($Node.Value) }
            }
            elseif ($Node.Structure -eq 'List')
            {
                # This will convert the list to an (fixed) array
                $Items = $Node.GetItemNodes().foreach{ SortObject $_ -SortIndex }
                $Items = $Items | Sort-Object -CaseSensitive:$MatchCase -Descending:$Descending { $_.Keys[0] }
                $String = [Collections.Generic.List[String]]::new()
                $List = [Collections.Generic.List[Object]]::new()
                foreach ($Item in $Items)
                {
                    $SortKey = $Item.GetEnumerator().Name
                    $String.Add($SortKey)
                    $List.Add($Item[$SortKey])
                }
                $Name = $String -Join [Char]255
                $Output = @{ $Name = @($List) }
            }
            elseif ($Node.Structure -eq 'Dictionary')
            {
                # This will convert a dictionary to a PSCustomObject
                $HashTable = [HashTable]::New(0, [StringComparer]::Ordinal)
                $Node.GetItemNodes().foreach{
                    $SortObject = SortObject $_ -SortIndex
                    $SortKey = $SortObject.GetEnumerator().Name
                    if ($Primary.Contains($_.Key))
                    {
                        $Key = $Primary[$_.Key]
                    }
                    else
                    {
                        $Key = $_.Key
                    }
                    $HashTable["$Key$([Char]255)$SortKey"] = @{ $_.Key = $SortObject[$SortKey] }
                }
                $SortedKeys = $HashTable.get_Keys() | Sort-Object -CaseSensitive:$MatchCase -Descending:$Descending
                $Properties = [System.Collections.Specialized.OrderedDictionary]::new([StringComparer]::Ordinal)
                @($SortedKeys).foreach{
                    $Item = $HashTable[$_]
                    $Name = $Item.GetEnumerator().Name
                    $Properties[$Name] = $Item[$Name]
                }
                $Name = $SortedKeys -Join [Char]255
                $Output = @{ $Name = [PSCustomObject]$Properties } # https://github.com/PowerShell/PowerShell/issues/20753
            }
            else
            {
                Write-Error 'Should not happen'
            }
            if ($SortIndex)
            {
                $Output
            }
            else
            {
                $Output.get_Values()
            }
        }
    }

    process
    {
        $PSnode = [PSNode]::new($InputObject)
        $PSNode.MaxDepth = $MaxDepth
        SortObject -Node $PSNode
    }
}

Set-Alias -Name 'Sort-DataObject' -Value 'ConvertTo-SortedDataObject' -Scope Global
