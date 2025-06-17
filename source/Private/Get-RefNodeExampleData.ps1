function Get-RefNodeExampleData
{
<#
 .Synopsis
  Retrieves the details of the requested item from the referenced example data

 .Description
  This function retrieves the details of the item from the referenced example data.

 .Parameter Node
  The Leafnode that needs to be retrieved

 .Parameter ReferenceObject
  The ReferenceObject that contains the example data

 .Example
   Get-RefNodeExampleData -Node $leafnode -ReferenceObject $exampleData
#>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $True)]
        $Node,

        [Parameter(Mandatory = $true)]
        $ReferenceObject
    )

    process
    {
        $ExecuteCommand = '$ReferenceObject.{0}' -f $($Node.Path -Replace '\[\d*\](?=(\.|$))')
        $Result = $($ExecutionContext.InvokeCommand.InvokeScript('{0}' -f $ExecuteCommand ))

        if ($result)
        {
            if ($Node.GetType().FullName -eq 'PSLeafNode')
            {
                if ($Result -is [System.String])
                {
                    $ArrayResult = $Result.Split('|').ForEach{ $_.Trim() }
                    $LeafNode = @{}
                    if ( $ArrayResult[0])
                    {
                        $LeafNode.Add('Type', $ArrayResult[0])
                    }
                    if ( $ArrayResult[1])
                    {
                        $LeafNode.Add('Required', $ArrayResult[1])
                    }
                    if ( $ArrayResult[2])
                    {
                        $LeafNode.Add('Description', $ArrayResult[2])
                    }
                    if ( $ArrayResult[3])
                    {
                        $LeafNode.Add('ValidateSet', "'" + ( $ArrayResult[3] -Replace '\s*\/\s*', "', '") + "'"  )
                    }
                    return $LeafNode
                }
                else
                {
                    Write-Warning "No data found for path: $($Node.Path)"
                    return $null
                }
            }
            else
            {
                return $Result
            }
            return $null
        }
    }
}
