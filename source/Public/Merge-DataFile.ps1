function Merge-DataFile
{
<#
.SYNOPSIS
    Merges two PowerShell Data File hashtables

.DESCRIPTION
    This function merges two PowerShell Data file hashtables into one new
    one. The values in the Merge hashtable are overwriting any existing
    values in the Reference hashtable.

.PARAMETER Reference
    The Reference hashtable that is used as the starting point

.PARAMETER Merge
    The Merge hashtable that will be merged into the Reference hashtable.

.EXAMPLE
    # Merges the Merge file into the Reference file
    $reference = Import-PowerShellDataFile -Path 'reference.psd1'
    $merge = Import-PowerShellDataFile -Path 'merge.psd1'

    Merge-DataFile -Reference $reference -Merge $merge
#>
[CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Reference,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Merge
    )

    Begin
    {
        $script:level = 0

        Write-LogEntry -Message 'Starting Data Merge' -Level $script:level
        $ref = $Reference.Clone()
        $mer = $Merge.Clone()
    }

    Process
    {
        $result = Merge-Hashtable -Reference $ref -Merge $mer
    }

    End
    {
        Write-LogEntry -Message 'Data Merge Completed' -Level $script:level

        return $result
    }
}
