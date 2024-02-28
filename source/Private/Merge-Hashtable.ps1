function Merge-Hashtable
{
<#
 .Synopsis
  Merges two hashtables

 .Description
  This function merges two hashtables into one new one.
  The values in the Merge hashtable are overwriting any existing
  values in the Reference hashtable.

 .Parameter Reference
  The Reference hashtable that is used as the starting point

 .Parameter Merge
  The Merge hashtable that will be merged into the Reference hashtable.

 .Example
   # Merges the Merge file into the Reference file
   $reference = @{
         'Key1' = 'Value1'
         'Key2' = 'Value2'
         'Key3' = @{
              'Key3.1' = 'Value3.1'
              'Key3.2' = 'Value3.2'
         }
   }
   $merge = @{
         'Key1' = 'ValueNew'
         'Key3' = @{
              'Key3.2' = 'ValueNew'
              'Key3.3' = 'Value3.3'
         }
   }

   Merge-Hashtable -Reference $reference -Merge $merge
#>
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Reference,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Merge
    )

    $script:level++
    $items = $Merge.GetEnumerator()
    foreach ($item in $items)
    {
        $itemKey = $item.Key
        $itemData = $item.Value
        Write-LogEntry -Message "Processing: $itemKey" -Level $script:level
        switch ($itemData.GetType().FullName)
        {
            'System.Collections.Hashtable'
            {
                # Check if item exists in the reference
                if ($Reference.ContainsKey($itemKey) -eq $false)
                {
                    # item does not exist, add item
                    Write-LogEntry -Message '  Key missing in Merge object, adding key' -Level $script:level
                    $Reference.Add($itemKey, $itemData)
                }
                else
                {
                    $script:level++
                    Write-LogEntry -Message 'Key exists in Merge object, checking child items' -Level $script:level
                    $Reference.$itemKey = Merge-Hashtable -Reference $Reference.$itemKey -Merge $itemData
                    $script:level--
                }
            }
            'System.Object[]'
            {
                if ($null -eq $Reference.$itemKey -or $Reference.$itemKey.Count -eq 0)
                {
                    $Reference.$itemKey = $itemData
                }
                else
                {
                    $Reference.$itemKey = [Array](Merge-Array -Reference $Reference.$itemKey -Merge $itemData)
                }
            }
            Default
            {
                if ($Reference.$itemKey -ne $itemData)
                {
                    $Reference.$itemKey = $itemData
                }
            }
        }
    }
    $script:level--

    return $Reference
}
