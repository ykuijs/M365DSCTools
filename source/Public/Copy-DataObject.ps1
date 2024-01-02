function Copy-DataObject
{
<#
.SYNOPSIS
    Copy Data Object

.DESCRIPTION
    Recursively ("deep") copies a data object.

.PARAMETER InputObject
    The input object that will be recursively copied.

.PARAMETER ListAs
    If supplied, lists will be converted to the given type (or type of the supplied object example).

.PARAMETER DictionaryAs
    If supplied, dictionaries will be converted to the given type (or type of the supplied object example).
    This parameter also accepts the [`PSCustomObject`][1] types
    By default (if the [-DictionaryAs] parameters is omitted),
    [`Component`][2] objects will be converted to a [`PSCustomObject`][1] type.

.PARAMETER ExcludeLeafs
    If supplied, only the structure (lists, dictionaries, [`PSCustomObject`][1] types and [`Component`][2] types will be copied.
    If omitted, each leaf will be shallow copied

.PARAMETER MaxDepth
    The maximal depth to recursively compare each embedded property (default: 10).

.Example
    # Deep copy a complete data object into a new data object

        $NewDataObject = Copy-DataObject $DataObject

.Example
    # Copy (convert) an data object using common PowerShell arrays and PSCustomObjects

        $PSObject = Copy-DataObject $Object -ListAs [Array] -DictionaryAs PSCustomObject

.Example
    # Convert a Json string to an data object with (case insensitive) ordered dictionaries

        $PSObject = $Json | ConvertFrom-Json | Copy-DataObject -DictionaryAs ([Ordered]@{})

.LINK
    [1]: https://learn.microsoft.com/dotnet/api/system.management.automation.pscustomobject "PSCustomObject Class"
    [2]: https://learn.microsoft.com/dotnet/api/system.componentmodel.component "Component Class"
#>

    [CmdletBinding(DefaultParameterSetName = 'ListAs')]
    [OutputType([Object[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $True)]
        $InputObject,

        [Alias('ListsAs')]
        $ListAs,

        [Alias('DictionariesAs')]
        $DictionaryAs,

        [Switch]
        $ExcludeLeafs,

        [Alias('Depth')]
        [int]
        $MaxDepth = 10
    )

    begin
    {
        function StopError($Exception, $Id = 'IncorrectArgument', $Group = [Management.Automation.ErrorCategory]::SyntaxError, $Object)
        {
            if ($Exception -is [System.Management.Automation.ErrorRecord])
            {
                $Exception = $Exception.Exception
            }
            elseif ($Exception -isnot [Exception])
            {
                $Exception = [ArgumentException]$Exception
            }
            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new($Exception, $Id, $Group, $Object))
        }

        $ListNode = if ($PSBoundParameters.ContainsKey('ListAs'))
        {
            if ($ListAs -is [String] -or $ListAs -is [Type])
            {
                try
                {
                    [PSNode](New-Object -Type $ListAs)
                }
                catch
                {
                    StopError $_
                }
            }
            else
            {
                [PSNode]$ListAs
            }
        }

        $DictionaryNode = if ($PSBoundParameters.ContainsKey('DictionaryAs'))
        {
            if ($DictionaryAs -is [String] -or $DictionaryAs -is [Type])
            {
                try
                {
                    [PSNode](New-Object -Type $DictionaryAs)
                }
                catch
                {
                    StopError $_
                }
            }
            else
            {
                [PSNode]$DictionaryAs
            }
        }

        $ListStructure = if ($ListNode)
        {
            $ListNode.Structure
        }
        $DictionaryStructure = if ($DictionaryNode)
        {
            $DictionaryNode.Structure
        }
        if (($ListStructure -eq 'Dictionary' -and $DictionaryStructure -ne 'Dictionary') -or ($DictionaryStructure -eq 'List' -and $ListStructure -ne 'List'))
        {
            $ListNode, $DictionaryNode = $DictionaryNode, $ListNode
        }

        if ($ListNode -and $ListNode.Structure -ne 'List')
        {
            StopError 'The -ListAs parameter requires a string, type or an object example that supports a list structure'
        }
        if ($DictionaryNode -and $DictionaryNode.Structure -ne 'Dictionary')
        {
            StopError 'The -DictionaryAs parameter requires a string, type or an object example that supports a dictionary structure'
        }

        function CopyObject
        {
            [CmdletBinding()]
            [OutputType([Object[]],[System.Array])]
            param
            (
                [Parameter()]
                [PSNode]
                $Node,

                [Parameter()]
                [Type]
                $ListType,

                [Parameter()]
                [Type]
                $DictionaryType
            )

            if ($Node.Structure -eq 'Scalar')
            {
                if ($ExcludeLeafs -or $Null -eq $Node.Value)
                {
                    return $Node.Value
                }
                else
                {
                    $Node.Value.PSObject.Copy()
                }
            }
            elseif ($Node.Structure -eq 'List')
            {
                $Type = if ($Null -ne $ListType)
                {
                    $ListType
                }
                else
                {
                    $Node.Type
                }
                $Values = $Node.GetItemNodes().foreach{ CopyObject $_ -ListType $ListType -DictionaryType $DictionaryType }
                $Values = $Values -as $Type
                , $Values
            }
            elseif ($Node.Structure -eq 'Dictionary')
            {
                # This will convert a dictionary to a PSCustomObject
                $Type = if ($Null -ne $DictionaryType)
                {
                    $DictionaryType
                }
                else
                {
                    $Node.Type
                }
                $IsDirectory = $Null -ne $Type.GetInterface('IDictionary')
                if ($IsDirectory)
                {
                    $Dictionary = New-Object -Type $Type
                }
                else
                {
                    $Dictionary = [Ordered]@{}
                }
                $Node.GetItemNodes().foreach{ $Dictionary[$_.Key] = CopyObject $_ -ListType $ListType -DictionaryType $DictionaryType }
                if ($IsDirectory)
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
        $PSnode = [PSNode]::new($InputObject)
        $PSNode.MaxDepth = $MaxDepth
        CopyObject -Node $PSNode -ListType $ListNode.Type -DictionaryType $DictionaryNode.Type
    }
}
