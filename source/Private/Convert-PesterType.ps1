function Convert-PesterType
{
<#
 .Synopsis
  Converts variable types used in DSC to types that can be used in Pester tests

 .Description
  This function converts types that are used in DSC to types that can be
  used in Pester tests. For example DSC supports an SInt32 type, which is
  unknown to Pester.

 .Parameter Type
  The Type that needs to be converted

 .Example
   Convert-PesterType -Type 'SInt32'
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Type
    )
    switch ($Type)
    {
        'SInt32'
        {
            return "should -match '^\d+$' -because ""Must be a positive Integer"""
        }
        'SInt64'
        {
            return "should -match '^\d+$' -because ""Must be a positive Integer"""
        }
        'UInt32'
        {
            return "should -BeOfType 'Int'"
        }
        'UInt64'
        {
            return "should -BeOfType 'Int'"
        }
        'StringArray'
        {
            return "should -BeOfType 'String'"
        }
        'Guid'
        {
            return "Test-IsGuid | should -Be 'True'"
        }
        default
        {
            return "should -BeOfType '$type'"
        }
    }
}
