function Merge-DataObject
{
<#
.SYNOPSIS
    Merges two Data Objects into one

.DESCRIPTION
    Recursively merges two Data Object into a new Data Object.

.PARAMETER InputObject
    The input object that will be merged with the template object (see: [-Template] parameter).

    > [!NOTE]
    > Multiple input object might be provided via the pipeline.
    > The common PowerShell behavior is to unroll any array (aka list) provided by the pipeline.
    > To avoid a list of (root) objects to unroll, use the **comma operator**:

        ,$InputObject | Compare-DataObject $Template.

.PARAMETER Template
    The template that is used to merge with the input object (see: [-InputObject] parameter).

.PARAMETER PrimaryKey
    In case of a list of dictionaries or PowerShell objects, the PowerShell key is used to
    link the items or properties: if the PrimaryKey exists on both the [-Template] and the
    [-InputObject] and the values are equal, the dictionary or PowerShell object will be merged.
    Otherwise (if the key can't be found or the values differ), the complete dictionary or
    PowerShell object will be added to the list.

    It is allowed to supply multiple primary keys where each primary key will be used to
    check the relation between the [-Template] and the [-InputObject].

.PARAMETER MatchCase
    Indicates that the merge is case-sensitive. By default, merges aren't case-sensitive.

.PARAMETER MaxDepth
    The maximal depth to recursively compare each embedded property (default: 10).

.EXAMPLE
    ,$InputObject | Compare-DataObject $Template
#>

    [Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssignments', '', Scope = 'Function', Justification = 'False positive')]
    [Diagnostics.CodeAnalysis.SuppressMessage('PSReviewUnusedParameter', '', Scope = 'Function', Justification = 'Checking with Dev')]
    [CmdletBinding()]
    [OutputType([Object[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $True)]
        $InputObject,

        [Parameter(Mandatory = $true, Position = 0)]
        $Template,

        [String[]]
        $PrimaryKey,

        [Switch]
        $MatchCase,

        [Alias('Depth')]
        [int]
        $MaxDepth = 10
    )

    begin
    {
        $TemplateNode = [PSNode]::new($Template)
        $TemplateNode.MaxDepth = $MaxDepth
        function MergeObject
        {
            [CmdletBinding()]
            [OutputType([Object[]],[System.Array])]
            param
            (
                [Parameter()]
                [PSNode]
                $TemplateNode,

                [Parameter()]
                [PSNode]
                $ObjectNode
            )

            if ($ObjectNode.Structure -ne $TemplateNode.Structure)
            {
                return $ObjectNode.Value
            }
            elseif ($ObjectNode.Structure -eq 'Scalar')
            {
                return $ObjectNode.Value
            }
            elseif ($ObjectNode.Structure -eq 'List')
            {
                $FoundIndices = [System.Collections.Generic.HashSet[int]]::new()
                $Type = if ($ObjectNode.Value.IsFixedSize)
                {
                    [Collections.Generic.List[PSObject]]
                }
                else
                {
                    $ObjectNode.Value.GetType()
                }
                $Output = New-Object -TypeName $Type
                $ObjectItems = $ObjectNode.GetItemNodes()
                $TemplateItems = $TemplateNode.GetItemNodes()
                foreach ($ObjectItem in $ObjectItems)
                {
                    $FoundNode = $False
                    foreach ($TemplateItem in $TemplateItems)
                    {
                        if ($ObjectItem.Structure -eq $TemplateItem.Structure)
                        {
                            if ($ObjectItem.Structure -eq 'Scalar')
                            {
                                $Equal = if ($MatchCase)
                                {
                                    $TemplateItem.Value -ceq $ObjectItem.Value
                                }
                                else
                                {
                                    $TemplateItem.Value -eq $ObjectItem.Value
                                }
                                if ($Equal)
                                {
                                    $Output.Add($ObjectItem.Value)
                                    $FoundNode = $True
                                    $Null = $FoundIndices.Add($TemplateItem.Index)
                                }
                            }
                            elseif ($ObjectItem.Structure -eq 'Dictionary')
                            {
                                foreach ($Key in $PrimaryKey)
                                {
                                    if (-not $TemplateItem.Contains($Key) -or -not $ObjectItem.Contains($Key))
                                    {
                                        continue
                                    }
                                    if ($TemplateItem.Get($Key) -eq $ObjectItem.Get($Key))
                                    {
                                        $Item = MergeObject -Template $TemplateItem -Object $ObjectItem
                                        $Output.Add($Item)
                                        $FoundNode = $True
                                        $Null = $FoundIndices.Add($TemplateItem.Index)
                                    }
                                }
                            }
                        }
                    }
                    if (-not $FoundNode)
                    {
                        $Output.Add($ObjectItem.Value)
                    }
                }
                foreach ($TemplateItem in $TemplateItems)
                {
                    if (-not $FoundIndices.Contains($TemplateItem.Index))
                    {
                        $Output.Add($TemplateItem.Value)
                    }
                }
                if ($ObjectNode.Value.IsFixedSize)
                {
                    $Output = @($Output)
                }
                , $Output
            }
            elseif ($ObjectNode.Structure -eq 'Dictionary')
            {
                if ($ObjectNode.Construction -ne 'Object')
                {
                    $Dictionary = New-Object -TypeName $ObjectNode.Type
                }      # The $InputObject defines the dictionary (or PSCustomObject) type
                else
                {
                    $Dictionary = [System.Collections.Specialized.OrderedDictionary]::new()
                }
                foreach ($ObjectItem in $ObjectNode.GetItemNodes())
                {
                    if ($TemplateNode.Contains($ObjectItem.Key))
                    {
                        # The $InputObject defines the comparer
                        $Value = MergeObject -Template $TemplateNode.GetItemNode($ObjectItem.Key) -Object $ObjectItem
                    }
                    else
                    {
                        $Value = $ObjectItem.Value
                    }
                    $Dictionary.Add($ObjectItem.Key, $Value)
                }
                foreach ($Key in $TemplateNode.get_Keys())
                {
                    if (-not $Dictionary.Contains($Key))
                    {
                        $Dictionary.Add($Key, $TemplateNode.Get($Key))
                    }
                }
                if ($ObjectNode.Construction -ne 'Object')
                {
                    $Dictionary
                }
                else
                {
                    [PSCustomObject]$Dictionary
                }
            }
        }
    }
    process
    {
        MergeObject -TemplateNode $TemplateNode -ObjectNode $InputObject
    }
}
