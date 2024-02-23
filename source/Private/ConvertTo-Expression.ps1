using namespace System.Management.Automation

function ConvertTo-Expression
{
    <#
.SYNOPSIS
    Serializes an object to a PowerShell expression.

.DESCRIPTION
    The ConvertTo-Expression cmdlet converts (serializes) an object to a
    PowerShell expression. The object can be stored in a variable,  file or
    any other common storage for later use or to be ported to another
    system.

    An expression can be restored to an object using the native
    Invoke-Expression cmdlet:

        $Object = Invoke-Expression ($Object | ConverTo-Expression)

    Or Converting it to a [ScriptBlock] and invoking it with cmdlets
    along with Invoke-Command or using the call operator (&):

        $Object = &([ScriptBlock]::Create($Object | ConverTo-Expression))

    An expression that is stored in a PowerShell (.ps1) file might also
    be directly invoked by the PowerShell dot-sourcing technique,  e.g.:

        $Object | ConvertTo-Expression | Out-File .\Expression.ps1
        $Object = . .\Expression.ps1

    Warning: Invoking partly trusted input with Invoke-Expression or
    [ScriptBlock]::Create() methods could be abused by malicious code
    injections.

.INPUTS
    Any. Each objects provided through the pipeline will converted to an
    expression. To concatinate all piped objects in a single expression,
    use the unary comma operator,  e.g.: ,$Object | ConvertTo-Expression

.OUTPUTS
    String[]. ConvertTo-Expression returns a PowerShell [String] expression
    for each input object.

.PARAMETER Object
    Specifies the objects to convert to a PowerShell expression. Enter a
    variable that contains the objects,  or type a command or expression
    that gets the objects. You can also pipe one or more objects to
    ConvertTo-Expression.

.PARAMETER Depth
    Specifies how many levels of contained objects are included in the
    PowerShell representation. The default value is 9.

.PARAMETER Expand
    Specifies till what level the contained objects are expanded over
    separate lines and indented according to the -Indentation and
    -IndentChar parameters. The default value is equal to the -Depth value.

    A negative value will remove redundant spaces and compress the
    PowerShell expression to a single line (except for multi-line strings).

    Xml documents and multi-line strings are embedded in a "here string"
    and aligned to the left.

.PARAMETER Indentation
    Specifies how many IndentChars to write for each level in the
    hierarchy.

.PARAMETER IndentChar
    Specifies which character to use for indenting.

.PARAMETER Strong
    By default,  the ConvertTo-Expression cmdlet will return a weakly typed
    expression which is best for transfing objects between differend
    PowerShell systems.
    The -Strong parameter will strickly define value types and objects
    in a way that they can still be read by same PowerShell system and
    PowerShell system with the same configuration (installed modules etc.).

.PARAMETER Explore
    In explore mode,  all type prefixes are omitted in the output expression
    (objects will cast to to hash tables). In case the -Strong parameter is
    also supplied,  all orginal (.Net) type names are shown.
    The -Explore switch is usefull for exploring object hyrachies and data
    type,  not for saving and transfering objects.

.PARAMETER TypeNaming
    Specifies how the type names are documented. The default value is Auto.

.PARAMETER NewLine
    Character that is used for new lines. The default value is the
    [System.Environment]::NewLine.

.EXAMPLE

    PS> WinInitProcess = Get-Process WinInit | ConvertTo-Expression	# Convert the WinInit Process to a PowerShell expression

.EXAMPLE

    PS> Get-Host | ConvertTo-Expression -Depth 4	# Reveal complex object hierarchies
#>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Scope = 'Function')] # https://github.com/PowerShell/PSScriptAnalyzer/issues/1472
    [CmdletBinding()]
    [OutputType([scriptblock])]
    param
    (
        [Parameter(ValueFromPipeLine = $True)]
        [Alias('InputObject')]
        $Object,

        [Parameter()]
        [System.Int32]
        $Depth = 9,

        [Parameter()]
        [System.Int32]
        $Expand = $Depth,

        [Parameter()]
        [System.Int32]
        $Indentation = 4,

        [Parameter()]
        [System.String]
        $IndentChar = ' ',

        [Parameter()]
        [Switch]
        $Strong,

        [Parameter()]
        [Switch]
        $Explore,

        [Parameter()]
        [ValidateSet('Name', 'Fullname', 'Auto')]
        [System.String]
        $TypeNaming = 'Auto',

        [System.String]
        $NewLine = [System.Environment]::NewLine
    )

    begin
    {
        $ValidUnqoutedKey = '^[\p{L}\p{Lt}\p{Lm}\p{Lo}_][\p{L}\p{Lt}\p{Lm}\p{Lo}\p{Nd}_]*$'
        $ListItem = $Null
        $Tab = $IndentChar * $Indentation

        function Serialize ($Object, $Iteration, $Indent)
        {
            function Quote ([string]$Item)
            {
                "'$($Item.Replace('''',  ''''''))'"
            }
            function QuoteKey ([string]$Key)
            {
                if ($Key -cmatch $ValidUnqoutedKey)
                {
                    $Key
                }
                else
                {
                    Quote $Key
                }
            }

            function Here ([string]$Item)
            {
                if ($Item -match '[\r\n]')
                {
                    "@'$NewLine$Item$NewLine'@$NewLine"
                }
                else
                {
                    Quote $Item
                }
            }

            function Stringify ($Object, $Cast = $Type, $Convert)
            {
                $Casted = $PSBoundParameters.ContainsKey('Cast')
                function GetTypeName($Type)
                {
                    if ($Type -is [Type])
                    {
                        if ($TypeNaming -eq 'Fullname')
                        {
                            $Typename = $Type.Fullname
                        }
                        elseif ($TypeNaming -eq 'Name')
                        {
                            $Typename = $Type.Name
                        }
                        else
                        {
                            $Typename = "$Type"
                            if ($Type.Namespace -eq 'System' -or $Type.Namespace -eq 'System.Management.Automation')
                            {
                                if ($Typename.Contains('.'))
                                {
                                    $Typename = $Type.Name
                                }
                            }
                        }
                        if ($Type.GetType().GenericTypeArguments)
                        {
                            $TypeArgument = ForEach ($TypeArgument in $Type.GetType().GenericTypeArguments)
                            {
                                GetTypeName $TypeArgument
                            }
                            $Arguments = if ($Expand -ge 0)
                            {
                                $TypeArgument -join ', '
                            }
                            else
                            {
                                $TypeArgument -join ','
                            }
                            $Typename = $Typename.GetType().Split(0x60)[0] + '[' + $Arguments + ']'
                        }
                        $Typename
                    }
                    else
                    {
                        $Type
                    }
                }

                function Prefix ($Object, [switch]$Parenthesis)
                {
                    if ($Convert)
                    {
                        if ($ListItem)
                        {
                            $Object = "($Convert $Object)"
                        }
                        else
                        {
                            $Object = "$Convert $Object"
                        }
                    }
                    if ($Parenthesis)
                    {
                        $Object = "($Object)"
                    }
                    if ($Explore)
                    {
                        if ($Strong)
                        {
                            "[$(GetTypeName $Type)]$Object"
                        }
                        else
                        {
                            $Object
                        }
                    }
                    elseif ($Strong -or $Casted)
                    {
                        if ($Cast)
                        {
                            "[$(GetTypeName $Cast)]$Object"
                        }
                    }
                    else
                    {
                        $Object
                    }
                }

                function Iterate ($Object, [switch]$Strong = $Strong, [switch]$ListItem, [switch]$Level)
                {
                    if ($Iteration -lt $Depth)
                    {
                        Serialize $Object -Iteration ($Iteration + 1) -Indent ($Indent + 1 - [int][bool]$Level)
                    }
                    else
                    {
                        "'...'"
                    }
                }
                if ($Object -is [string])
                {
                    Prefix $Object
                }
                else
                {
                    $List, $Properties = $Null
                    $Methods = $Object.PSObject.Methods
                    if ($Methods['GetEnumerator'] -is [PSMethod])
                    {
                        if ($Methods['get_Keys'] -is [PSMethod] -and $Methods['get_Values'] -is [PSMethod])
                        {
                            $List = [Ordered]@{}
                            foreach ($Key in $Object.get_Keys())
                            {
                                $List[(QuoteKey $Key)] = Iterate $Object[$Key]
                            }
                        }
                        else
                        {
                            $Level = @($Object).Count -eq 1 -or ($Null -eq $Indent -and !$Explore -and !$Strong)
                            $StrongItem = $Strong -and $Type.Name -eq 'Object[]'
                            $List = @(foreach ($Item in $Object)
                                {
                                    Iterate $Item -ListItem -Level:$Level -Strong:$StrongItem
                                })
                        }
                    }
                    else
                    {
                        $Properties = $Object.PSObject.Properties | Where-Object { $_.MemberType -eq 'Property' }
                        if (!$Properties)
                        {
                            $Properties = $Object.PSObject.Properties | Where-Object { $_.MemberType -eq 'NoteProperty' }
                        }
                        if ($Properties)
                        {
                            $List = [Ordered]@{}
                            foreach ($Property in $Properties)
                            {
                                $List[(QuoteKey $Property.Name)] = Iterate $Property.Value
                            }
                        }
                    }
                    if ($List -is [array])
                    {
                        if (!$List.Count)
                        {
                            Prefix '@()'
                        }
                        elseif ($List.Count -eq 1)
                        {
                            if ($Strong)
                            {
                                Prefix "$List"
                            }
                            elseif ($ListItem)
                            {
                                "(,$List)"
                            }
                            else
                            {
                                ",$List"
                            }
                        }
                        elseif ($Indent -ge $Expand - 1 -or $Type.GetElementType().IsPrimitive)
                        {
                            $Content = if ($Expand -ge 0)
                            {
                                $List -join ', '
                            }
                            else
                            {
                                $List -join ','
                            }
                            Prefix -Parenthesis:($ListItem -or $Strong) $Content
                        }
                        elseif ($Null -eq $Indent -and !$Strong -and !$Convert)
                        {
                            Prefix ($List -join ",$NewLine")
                        }
                        else
                        {
                            $LineFeed = $NewLine + ($Tab * $Indent)
                            $Content = "$LineFeed$Tab" + ($List -join ",$LineFeed$Tab")
                            if ($Convert)
                            {
                                $Content = "($Content)"
                            }
                            if ($ListItem -or $Strong)
                            {
                                Prefix -Parenthesis "$Content$LineFeed"
                            }
                            else
                            {
                                Prefix $Content
                            }
                        }
                    }
                    elseif ($List -is [System.Collections.Specialized.OrderedDictionary])
                    {
                        if (!$Casted)
                        {
                            if ($Properties)
                            {
                                $Casted = $True
                                $Cast = 'pscustomobject'
                            }
                            else
                            {
                                $Cast = 'hashtable'
                            }
                        }
                        if (!$List.Count)
                        {
                            Prefix '@{}'
                        }
                        elseif ($Expand -lt 0)
                        {
                            Prefix ('@{' + (@(foreach ($Key in $List.get_Keys())
                                        {
                                            "$Key=" + $List[$Key]
                                        }) -join ';') + '}')
                        }
                        elseif ($List.Count -eq 1 -or $Indent -ge $Expand - 1)
                        {
                            Prefix ('@{' + (@(foreach ($Key in $List.get_Keys())
                                        {
                                            "$Key = " + $List[$Key]
                                        }) -join '; ') + '}')
                        }
                        else
                        {
                            $LineFeed = $NewLine + ($Tab * $Indent)
                            Prefix ("@{$LineFeed$Tab" + (@(foreach ($Key in $List.get_Keys())
                                        {
                                            if (($List[$Key])[0] -notmatch '[\S]')
                                            {
                                                "$Key =" + $List[$Key].TrimEnd()
                                            }
                                            else
                                            {
                                                "$Key = " + $List[$Key].TrimEnd()
                                            }
                                        }) -join "$LineFeed$Tab") + "$LineFeed}")
                        }
                    }
                    else
                    {
                        Prefix ",$List"
                    }
                }
            }

            if ($Null -eq $Object)
            {
                "`$Null"
            }
            else
            {
                $Type = $Object.GetType()
                if ($Object -is [Boolean])
                {
                    if ($Object)
                    {
                        Stringify '$True'
                    }
                    else
                    {
                        Stringify '$False'
                    }
                }
                elseif ($Type.IsPrimitive)
                {
                    Stringify "$Object"
                }
                elseif ($Object -is [string])
                {
                    Stringify (Here $Object)
                }
                elseif ($Type.Name -eq 'OrderedDictionary')
                {
                    Stringify $Object 'ordered'
                }
                elseif ($Object -is [ValueType])
                {
                    try
                    {
                        Stringify "'$($Object)'" $Type
                    }
                    catch [NullReferenceException]
                    {
                        Stringify '$Null' $Type
                    }
                }
                else
                {
                    Stringify $Object
                }
            }
        }
    }

    process
    {
        (Serialize $Object).TrimEnd()
    }

}
