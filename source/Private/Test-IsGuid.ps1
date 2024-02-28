function Test-IsGuid
{
<#
 .Synopsis
  Tests is a string is a valid GUID

 .Description
  This function tests if a provided string is actually a valid GUID.

 .Parameter StringGuid
  String that needs to get tested if it is a valid GUID

 .Example
   Test-IsGuid -StringGuid '4756d311-220b-4e1d-ae47-8718a08ad16c'
#>
    [CmdletBinding()]
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $True)]
        [string]
        $StringGuid
    )

    process
    {
        $ObjectGuid = [System.Guid]::empty
        return [System.Guid]::TryParse($StringGuid,[System.Management.Automation.PSReference]$ObjectGuid) # Returns True if successfully parsed
    }
}
