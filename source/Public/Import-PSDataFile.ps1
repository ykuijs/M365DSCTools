function Import-PSDataFile
{
<#
.SYNOPSIS
    Imports a PowerShell Data File, without restriction on the file size.

.DESCRIPTION
    This function imports PowerShell data files into a hashtable. It also
    validates the file to ensure that it is a valid PowerShell Data File.

    This function replaces the default Import-PowerShellDataFile function,
    since that has issues with files larger than 500 keys.

.PARAMETER Path
    The path to the PSD1 file that will be imported.

.EXAMPLE
    Import-PSDataFile -Path 'C:\Temp\reference.psd1'
#>
    [CmdletBinding()]
    [OutputType([System.Collections.HashTable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [Microsoft.PowerShell.DesiredStateConfiguration.ArgumentToConfigurationDataTransformation()]
        [System.Collections.HashTable]
        $Path
    )

    return $Path
}
