function Get-RefNodeExampleData
{
<#
 .Synopsis
  Retrieves the details of the requested item from the referenced example data

 .Description
  This function retrieves the details of the item from the referenced example data.

 .Parameter Node
  The Leadnode that needs to be retrieved

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
        $ExecuteCommand = '$ReferenceObject.{0}' -f $($Node.PathName -Replace '\[\d*\](?=(\.|$))')
        $Result = $($ExecutionContext.InvokeCommand.InvokeScript('{0}' -f $ExecuteCommand ))

        if ($result)
        {
            if ($Node.GetType().FullName -eq 'PSLeafNode')
            {
                $ArrayResult = $Result.split('|').foreach{ $_.trim() }
                $LeafNode = @{}
                if ( $ArrayResult[0])
                {
                    $LeafNode.add('Type', $ArrayResult[0])
                }
                if ( $ArrayResult[1])
                {
                    $LeafNode.add('Required', $ArrayResult[1])
                }
                if ( $ArrayResult[2])
                {
                    $LeafNode.add('Description', $ArrayResult[2])
                }
                if ( $ArrayResult[3])
                {
                    $LeafNode.add('ValidateSet', "'" + ( $ArrayResult[3] -Replace '\s*\/\s*', "', '") + "'"  )
                }
                return $LeafNode
            }
            else
            {
                return $Result
            }
            return $null
        }
    }
}
