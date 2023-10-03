<#
 .Synopsis
  Merges two arrays into one new array

 .Description
  This function merges two arrays into one new one.
  The values in the Merge array are overwriting any existing
  values in the Reference array.

 .Parameter Reference
  The Reference array that is used as the starting point

 .Parameter Merge
  The Merge array that will be merged into the Reference array.

 .Example
   # Merges the Merge array into the Reference array
   $reference = @(1,2,3,4,5,6,7,8,9,10)
   $merge = @(11,12,13,14,15,16,17,18,19,20)

   Merge-Array -Reference $reference -Merge $merge
#>
function Merge-Array
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Array]
        $Reference,

        [Parameter(Mandatory = $true)]
        [System.Array]
        $Merge
    )

    $script:level++
    Write-LogEntry -Message "Processing array: $($Merge.Count) items" -Level $script:level

    foreach ($item in $Merge)
    {
        switch ($item.GetType().FullName)
        {
            'System.Collections.Hashtable'
            {
                $refItem = $Reference | Where-Object -FilterScript {
                    ($_.ContainsKey('UniqueId') -and $_.UniqueId -eq $item.UniqueId) -or `
                    ($_.ContainsKey('Identity') -and $_.Identity -eq $item.Identity) -or `
                    ($_.ContainsKey('NodeName') -and $_.NodeName -eq $item.NodeName)
                }

                if ($null -eq $refItem)
                {
                    # Add item
                    Write-LogEntry -Message "  Hashtable doesn't exist in Reference. Adding." -Level $script:level
                    $Reference += $item
                }
                else
                {
                    # Compare item
                    $script:level++
                    Write-LogEntry -Message 'Hashtable exists in Reference. Merging.' -Level $script:level
                    $refItem = Merge-Hashtable -Reference $refItem -Merge $item
                    $script:level--
                }
            }
            Default
            {
                if ($Reference -notcontains $item)
                {
                    $Reference += $item
                }
            }
        }
    }
    $script:level--

    return $Reference
}
