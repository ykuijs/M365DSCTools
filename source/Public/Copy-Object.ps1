function Copy-Object
{
<#
.SYNOPSIS
    Creates a full copy of an object, like a hashtable.

.DESCRIPTION
    This function creates a full copy of an object like a hashtable,
    without it having any reference to the original object.

.PARAMETER Object
    The object to be copied.

.EXAMPLE
    Copy-Object -Object @{ 'Key' = 'Value' }
#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object]
        $Object
    )

    $memStream = New-Object IO.MemoryStream
    $formatter = New-Object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream, $Object)
    $memStream.Position = 0
    $result = $formatter.Deserialize($memStream)

    return $result
}
