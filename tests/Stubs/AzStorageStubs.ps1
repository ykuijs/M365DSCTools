function Disable-AzStorageSoftDelete
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(HelpMessage = 'Display DeleteRetentionPolicyProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Enable-AzStorageSoftDelete
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Sets the number of retention days for the DeleteRetentionPolicy.')]
        [Alias('Days')]
        [int]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Display DeleteRetentionPolicyProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzDatalakeGen2FileSystem
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName')]
    param(
        [Parameter(ParameterSetName = 'ContainerName', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'ContainerPrefix', Mandatory = $true, HelpMessage = 'Container Prefix')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Prefix},

        [Parameter(HelpMessage = 'The max count of the containers that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [object]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'Include deleted containers, by default list containers won''t include deleted containers')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeDeleted},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageContainerAcl
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName')]
    param(
        [Parameter(ParameterSetName = 'ContainerName', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'ContainerPrefix', Mandatory = $true, HelpMessage = 'Container Prefix')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Prefix},

        [Parameter(HelpMessage = 'The max count of the containers that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [object]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'Include deleted containers, by default list containers won''t include deleted containers')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeDeleted},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzDatalakeGen2FileSystem
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Position = 1, HelpMessage = 'Permission string Off/Blob/Container')]
        [Alias('PublicAccess')]
        [System.Nullable[object]]
        ${Permission},

        [Parameter(ParameterSetName = 'EncryptionScope', Mandatory = $true, HelpMessage = 'Default the container to use specified encryption scope for all writes.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DefaultEncryptionScope},

        [Parameter(ParameterSetName = 'EncryptionScope', Mandatory = $true, HelpMessage = 'Prevent override of encryption scope from the container default.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PreventEncryptionScopeOverride},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzDataLakeGen2ItemAclObject
{
    [CmdletBinding()]
    param(
        [Parameter(HelpMessage = 'The user or group identifier. It is omitted for entries of AccessControlType "mask" and "other". The user or group identifier is also omitted for the owner and owning group.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EntityId},

        [Parameter(HelpMessage = 'Set this parameter to indicate the ACE belongs to the default ACL for a directory; otherwise scope is implicit and the ACE belongs to the access ACL.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${DefaultScope},

        [Parameter(Mandatory = $true, HelpMessage = 'The permission field is a 3-character sequence where the first character is ''r'' to grant read access, the second character is ''w'' to grant write access, and the third character is ''x'' to grant execute permission. If access is not granted, the ''-'' character is used to denote that the permission is denied. The sticky bit is also supported and its represented either by the letter t or T in the final character-place depending on whether the execution bit for the others category is set or unset respectively, absence of t or T indicates sticky bit not set.')]
        [ValidatePattern('[r-][w-][xtT-]')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'If input the PSPathAccessControlEntry[] object, will add the new ACL entry as a new element of the input PSPathAccessControlEntry[] object. If an ACL entry when same AccessControlType, EntityId, DefaultScope exist, will update permission of it.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${InputObject},

        [Parameter(Mandatory = $true, HelpMessage = 'There are four types: "user" grants rights to the owner or a named user, "group" grants rights to the owning group or a named group, "mask" restricts rights granted to named users and the members of groups, and "other" grants rights to all users not found in any of the other entries.')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('User', 'Group', 'Mask', 'Other')]
        [Azure.Storage.Files.DataLake.Models.AccessControlType]
        ${AccessControlType})


}


function Remove-AzDatalakeGen2FileSystem
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to remove the container and all content in it')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Return whether the specified container is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Start-CopyAzureStorageBlob
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('SrcICloudBlob', 'SrcCloudBlob', 'ICloudBlob', 'SourceICloudBlob', 'SourceCloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [Alias('SourceCloudBlobContainer')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Alias('SourceBlob')]
        [string]
        ${SrcBlob},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source Container name')]
        [Alias('SourceContainer')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcContainer},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source share name')]
        [Alias('SourceShareName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcShareName},

        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source share')]
        [Alias('SourceShare')]
        [ValidateNotNull()]
        [object]
        ${SrcShare},

        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Source file directory')]
        [Alias('SourceDir')]
        [ValidateNotNull()]
        [object]
        ${SrcDir},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source file path')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source file path')]
        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Source file path')]
        [Alias('SourceFilePath')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcFilePath},

        [Parameter(ParameterSetName = 'FileInstance', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Source file')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Source file')]
        [Alias('SourceFile')]
        [ValidateNotNull()]
        [object]
        ${SrcFile},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob uri')]
        [Alias('SrcUri', 'SourceUri')]
        [string]
        ${AbsoluteUri},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'FileInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Alias('DestinationContainer')]
        [string]
        ${DestContainer},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ShareName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ShareInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'DirInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'FileInstance', HelpMessage = 'Destination blob name')]
        [Alias('DestinationBlob')]
        [string]
        ${DestBlob},

        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, HelpMessage = 'Destination CloudBlob object')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', Mandatory = $true, HelpMessage = 'Destination CloudBlob object')]
        [Alias('DestICloudBlob', 'DestinationCloudBlob', 'DestinationICloudBlob')]
        [object]
        ${DestCloudBlob},

        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Premium Page Blob Tier')]
        [object]
        ${PremiumPageBlobTier},

        [Parameter(HelpMessage = 'Block Blob Tier, valid values are Hot/Cool/Archive. See detail in https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StandardBlobTier},

        [Parameter(HelpMessage = 'Block Blob RehydratePriority. Indicates the priority with which to rehydrate an archived blob. Valid values are High/Standard.')]
        [ValidateSet('Standard', 'High')]
        [object]
        ${RehydratePriority},

        [Parameter(HelpMessage = 'Blob Tags')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        ${Tag},

        [Parameter(ParameterSetName = 'ContainerName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ContainerInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'DirInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'FileInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Source Azure Storage Context Object')]
        [Alias('SrcContext', 'SourceContext')]
        [object]
        ${Context},

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination Storage context object')]
        [Alias('DestinationContext')]
        [object]
        ${DestContext},

        [Parameter(HelpMessage = 'Optional Query statement to apply to the Tags of the Destination Blob. The blob request will fail when the destiantion blob tags not match the given tag conditions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestTagCondition},

        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Stop-CopyAzureStorageBlob
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('ICloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Force to stop the current copy task on the specified blob')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Copy Id')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${CopyId},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Add-AzRmStorageContainerLegalHold
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(Mandatory = $true, HelpMessage = 'Container LegalHold Tags')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${Tag},

        [Parameter(HelpMessage = 'When enabled, new blocks can be written to both ''Appened and Block Blobs'' while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.')]
        [bool]
        ${AllowProtectedAppendWriteAll},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Add-AzRmStorageContainerLegalHold', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Add-AzStorageAccountManagementPolicyAction
{
    [CmdletBinding(DefaultParameterSetName = 'BaseBlob')]
    param(
        [Parameter(ParameterSetName = 'BaseBlob', Mandatory = $true, HelpMessage = 'The management policy action for baseblob.')]
        [Parameter(ParameterSetName = 'BaseBlobLastAccessTime', Mandatory = $true, HelpMessage = 'The management policy action for baseblob.')]
        [Parameter(ParameterSetName = 'BaseBlobCreationTime', Mandatory = $true, HelpMessage = 'The management policy action for baseblob.')]
        [ValidateSet('Delete', 'TierToArchive', 'TierToCool')]
        [string]
        ${BaseBlobAction},

        [Parameter(ParameterSetName = 'Snapshot', Mandatory = $true, HelpMessage = 'The management policy action for snapshot.')]
        [ValidateSet('Delete', 'TierToArchive', 'TierToCool')]
        [string]
        ${SnapshotAction},

        [Parameter(ParameterSetName = 'BlobVersion', Mandatory = $true, HelpMessage = 'The management policy action for blob version.')]
        [ValidateSet('Delete', 'TierToArchive', 'TierToCool')]
        [string]
        ${BlobVersionAction},

        [Parameter(ParameterSetName = 'Snapshot', Mandatory = $true, HelpMessage = 'Integer value indicating the age in days after creation.')]
        [Parameter(ParameterSetName = 'BlobVersion', Mandatory = $true, HelpMessage = 'Integer value indicating the age in days after creation.')]
        [Parameter(ParameterSetName = 'BaseBlobCreationTime', Mandatory = $true, HelpMessage = 'Integer value indicating the age in days after creation.')]
        [ValidateNotNullOrEmpty()]
        [int]
        ${DaysAfterCreationGreaterThan},

        [Parameter(ParameterSetName = 'BaseBlob', Mandatory = $true, HelpMessage = 'Integer value indicating the age in days after last modification.')]
        [ValidateNotNullOrEmpty()]
        [int]
        ${DaysAfterModificationGreaterThan},

        [Parameter(ParameterSetName = 'BaseBlobLastAccessTime', Mandatory = $true, HelpMessage = 'Integer value indicating the age in days after last blob access. This property can only be used in conjuction with last access time tracking policy.')]
        [ValidateNotNullOrEmpty()]
        [int]
        ${DaysAfterLastAccessTimeGreaterThan},

        [Parameter(ParameterSetName = 'BaseBlob', HelpMessage = 'Integer value indicating the age in days after last blob tier change time. This property is only applicable for tierToArchive actions. It requires daysAfterModificationGreaterThan to be set for baseBlobs based actions, or daysAfterModificationGreaterThan to be set for snapshots and blob version based actions.')]
        [Parameter(ParameterSetName = 'Snapshot', HelpMessage = 'Integer value indicating the age in days after last blob tier change time. This property is only applicable for tierToArchive actions. It requires daysAfterModificationGreaterThan to be set for baseBlobs based actions, or daysAfterModificationGreaterThan to be set for snapshots and blob version based actions.')]
        [Parameter(ParameterSetName = 'BlobVersion', HelpMessage = 'Integer value indicating the age in days after last blob tier change time. This property is only applicable for tierToArchive actions. It requires daysAfterModificationGreaterThan to be set for baseBlobs based actions, or daysAfterModificationGreaterThan to be set for snapshots and blob version based actions.')]
        [ValidateNotNullOrEmpty()]
        [int]
        ${DaysAfterLastTierChangeGreaterThan},

        [Parameter(ParameterSetName = 'BaseBlobLastAccessTime', HelpMessage = 'Enables auto tiering of a blob from cool to hot on a blob access. It only works with TierToCool action and DaysAfterLastAccessTimeGreaterThan.')]
        [switch]
        ${EnableAutoTierToHotFromCool},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'If input the ManagementPolicy Action object, will set the action to the input action object. If not input, will create a new action object.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Add-AzStorageAccountManagementPolicyAction', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Add-AzStorageAccountNetworkRule
{
    [CmdletBinding(DefaultParameterSetName = 'NetWorkRuleString', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'IpRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule IPRules.')]
        [object[]]
        ${IPRule},

        [Parameter(ParameterSetName = 'NetworkRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule VirtualNetworkRules.')]
        [object[]]
        ${VirtualNetworkRule},

        [Parameter(ParameterSetName = 'ResourceAccessRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule ResourceAccessRules.')]
        [object[]]
        ${ResourceAccessRule},

        [Parameter(ParameterSetName = 'IpRuleString', Mandatory = $true, HelpMessage = 'Storage Account NetworkRule IPRules IPAddressOrRange in string.')]
        [string[]]
        ${IPAddressOrRange},

        [Parameter(ParameterSetName = 'NetWorkRuleString', Mandatory = $true, HelpMessage = 'Storage Account NetworkRule VirtualNetworkRules VirtualNetworkResourceId in string.')]
        [Alias('SubnetId', 'VirtualNetworkId')]
        [string[]]
        ${VirtualNetworkResourceId},

        [Parameter(ParameterSetName = 'ResourceAccessRuleString', Mandatory = $true, HelpMessage = 'Storage Account ResourceAccessRule TenantId  in string.')]
        [string]
        ${TenantId},

        [Parameter(ParameterSetName = 'ResourceAccessRuleString', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account ResourceAccessRule ResourceId  in string.')]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Add-AzStorageAccountNetworkRule', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Close-AzStorageFileHandle
{
    [CmdletBinding(DefaultParameterSetName = 'ShareNameCloseAll', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareNameCloseAll', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share which contains the files/directories to closed handle.')]
        [Parameter(ParameterSetName = 'ShareNameCloseSingle', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share which contains the files/directories to closed handle.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'ShareCloseAll', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share which contains the files/directories to closed handle.')]
        [Parameter(ParameterSetName = 'ShareCloseSingle', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share which contains the files/directories to closed handle.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'DirectoryCloseAll', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the base folder which contains the files/directories to closed handle.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(ParameterSetName = 'FileCloseAll', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile object indicated the file to close handle.')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(ParameterSetName = 'ShareNameCloseAll', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [Parameter(ParameterSetName = 'ShareCloseAll', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [Parameter(ParameterSetName = 'DirectoryCloseAll', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ShareNameCloseSingle', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The File Handle to close.')]
        [Parameter(ParameterSetName = 'ShareCloseSingle', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The File Handle to close.')]
        [ValidateNotNull()]
        [object]
        ${FileHandle},

        [Parameter(ParameterSetName = 'ShareNameCloseAll', HelpMessage = 'Closed handles Recursively. Only works on File Directory.')]
        [Parameter(ParameterSetName = 'ShareCloseAll', HelpMessage = 'Closed handles Recursively. Only works on File Directory.')]
        [Parameter(ParameterSetName = 'DirectoryCloseAll', HelpMessage = 'Closed handles Recursively. Only works on File Directory.')]
        [switch]
        ${Recursive},

        [Parameter(ParameterSetName = 'ShareNameCloseAll', Mandatory = $true, HelpMessage = 'Force close all File handles.')]
        [Parameter(ParameterSetName = 'ShareCloseAll', Mandatory = $true, HelpMessage = 'Force close all File handles.')]
        [Parameter(ParameterSetName = 'DirectoryCloseAll', Mandatory = $true, HelpMessage = 'Force close all File handles.')]
        [Parameter(ParameterSetName = 'FileCloseAll', Mandatory = $true, HelpMessage = 'Force close all File handles.')]
        [switch]
        ${CloseAll},

        [Parameter(ParameterSetName = 'ShareNameCloseSingle', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareNameCloseAll', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'Return the count of closed file handles.')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Copy-AzStorageBlob
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Alias('SourceBlob')]
        [string]
        ${SrcBlob},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source Container name')]
        [Alias('SourceContainer')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcContainer},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob uri')]
        [Alias('SrcUri', 'SourceUri')]
        [string]
        ${AbsoluteUri},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Alias('DestinationContainer')]
        [string]
        ${DestContainer},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Destination blob name')]
        [Alias('DestinationBlob')]
        [string]
        ${DestBlob},

        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Destination blob type')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination blob type')]
        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Destination blob type')]
        [ValidateSet('Block', 'Page', 'Append')]
        [string]
        ${DestBlobType},

        [Parameter(HelpMessage = 'Block Blob Tier, valid values are Hot/Cool/Archive. See detail in https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StandardBlobTier},

        [Parameter(HelpMessage = 'Block Blob RehydratePriority. Indicates the priority with which to rehydrate an archived blob. Valid values are High/Standard.')]
        [ValidateSet('Standard', 'High')]
        [object]
        ${RehydratePriority},

        [Parameter(HelpMessage = 'Encryption scope to be used when making requests to the dest blob.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(ParameterSetName = 'ContainerName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Source Azure Storage Context Object')]
        [Alias('SrcContext', 'SourceContext')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'Destination Storage context object')]
        [Alias('DestinationContext')]
        [object]
        ${DestContext},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Disable-AzStorageBlobDeleteRetentionPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Disable-AzStorageBlobDeleteRetentionPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Disable-AzStorageBlobLastAccessTimeTracking
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Disable-AzStorageBlobLastAccessTimeTracking', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Disable-AzStorageBlobRestorePolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Disable-AzStorageBlobRestorePolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Disable-AzStorageContainerDeleteRetentionPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Disable-AzStorageContainerDeleteRetentionPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Disable-AzStorageDeleteRetentionPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(HelpMessage = 'Display DeleteRetentionPolicyProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Disable-AzStorageStaticWebsite
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Enable-AzStorageBlobDeleteRetentionPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(Mandatory = $true, HelpMessage = 'Sets the number of retention days for the DeleteRetentionPolicy.')]
        [Alias('Days')]
        [int]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Allow deletion of the soft deleted blob versions and snapshots.')]
        [switch]
        ${AllowPermanentDelete},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Enable-AzStorageBlobDeleteRetentionPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Enable-AzStorageBlobLastAccessTimeTracking
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Enable-AzStorageBlobLastAccessTimeTracking', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Enable-AzStorageBlobRestorePolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(Mandatory = $true, HelpMessage = 'Sets the number of days for the blob can be restored..')]
        [Alias('Days')]
        [int]
        ${RestoreDays},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Enable-AzStorageBlobRestorePolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Enable-AzStorageContainerDeleteRetentionPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(Mandatory = $true, HelpMessage = 'Sets the number of retention days for the DeleteRetentionPolicy.')]
        [Alias('Days')]
        [int]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Enable-AzStorageContainerDeleteRetentionPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Enable-AzStorageDeleteRetentionPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Sets the number of retention days for the DeleteRetentionPolicy.')]
        [Alias('Days')]
        [int]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Display DeleteRetentionPolicyProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Enable-AzStorageStaticWebsite
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Position = 0, HelpMessage = 'The name of the index document in each directory.')]
        [ValidateNotNull()]
        [string]
        ${IndexDocument},

        [Parameter(Position = 1, HelpMessage = 'the path to the error document that should be shown when a 404 is issued (meaning, when a browser requests a page that does not exist.)')]
        [ValidateNotNull()]
        [string]
        ${ErrorDocument404Path},

        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzDataLakeGen2ChildItem
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be retrieved. Can be a directory In the format ''directory1/directory2/'', Skip set this parameter to list items from root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Fetch the datalake item properties and ACL.')]
        [Alias('FetchPermission')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${FetchProperty},

        [Parameter(HelpMessage = 'Indicates if will recursively get the Child Item. The default is false.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${Recurse},

        [Parameter(HelpMessage = 'The max count of the blobs that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [string]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'If speicify this parameter, the user identity values returned in the owner and group fields of each list entry will be transformed from Azure Active Directory Object IDs to User Principal Names. If not speicify this parameter, the values will be returned as Azure Active Directory Object IDs. Note that group and application Object IDs are not translated because they do not have unique friendly names.')]
        [Alias('UserPrincipalName')]
        [switch]
        ${OutputUserPrincipalName},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzDataLakeGen2DeletedItem
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be retrieved. Can be a directory In the format ''directory1/directory2/'', Skip set this parameter to list items from root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'The max count of the blobs that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [string]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzDataLakeGen2Item
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be retrieved. Can be a file or directory In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to get the root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzDataLakeGen2ItemContent
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be get content from. Must be a file.In the format ''directory/file.txt''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Item Object to download.')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Destination local file path.')]
        [string]
        ${Destination},

        [Parameter(HelpMessage = 'check the md5sum')]
        [switch]
        ${CheckMd5},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzRmStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Include deleted containers, by default list containers won''t include deleted containers')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeDeleted},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzRmStorageContainer', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzRmStorageContainerImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N')]
        [string]
        ${ContainerName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(HelpMessage = 'Immutability policy etag.')]
        [Alias('IfMatch')]
        [string]
        ${Etag},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzRmStorageContainerImmutabilityPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzRmStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'AccountNameSingle')]
    param(
        [Parameter(ParameterSetName = 'AccountNameSingle', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountNameSingle', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObjectSingle', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ShareResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a File Share Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(ParameterSetName = 'AccountObjectSingle', Mandatory = $true, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'AccountNameSingle', HelpMessage = 'Share Name')]
        [Alias('N', 'ShareName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObjectSingle', HelpMessage = 'Share SnapshotTime')]
        [Parameter(ParameterSetName = 'AccountNameSingle', HelpMessage = 'Share SnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[datetime]]
        ${SnapshotTime},

        [Parameter(ParameterSetName = 'AccountObjectSingle', HelpMessage = 'Specify this parameter to get the Share Usage in Bytes.')]
        [Parameter(ParameterSetName = 'AccountNameSingle', HelpMessage = 'Specify this parameter to get the Share Usage in Bytes.')]
        [Parameter(ParameterSetName = 'ShareResourceId', HelpMessage = 'Specify this parameter to get the Share Usage in Bytes.')]
        [switch]
        ${GetShareUsage},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Include deleted shares, by default list shares won''t include deleted shares')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Include deleted shares, by default list shares won''t include deleted shares')]
        [switch]
        ${IncludeDeleted},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Include share snapshots, by default list shares won''t include share snapshots.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Include share snapshots, by default list shares won''t include share snapshots.')]
        [switch]
        ${IncludeSnapshot},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzRmStorageShare', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageAccount
{
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'ResourceGroupParameterSet', Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNameParameterSet', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'BlobRestoreStatusParameterSet', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountNameParameterSet', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'BlobRestoreStatusParameterSet', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountNameParameterSet', HelpMessage = 'Get the GeoReplicationStats of the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeGeoReplicationStats},

        [Parameter(ParameterSetName = 'BlobRestoreStatusParameterSet', Mandatory = $true, HelpMessage = 'Get the BlobRestoreStatus of the Storage account.')]
        [switch]
        ${IncludeBlobRestoreStatus},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageAccount', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageAccountKey
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Lists the Kerberos keys (if active directory enabled) for the specified storage account.')]
        [switch]
        ${ListKerbKey},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageAccountKey', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageAccountManagementPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageAccountManagementPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageAccountNameAvailability
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageAccountNameAvailability', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageAccountNetworkRuleSet
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageAccountNetworkRuleSet', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageBlob
{
    [CmdletBinding(DefaultParameterSetName = 'BlobName')]
    param(
        [Parameter(ParameterSetName = 'BlobName', Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'SingleBlobSnapshotTime', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'SingleBlobVersionID', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'BlobPrefix', HelpMessage = 'Blob Prefix')]
        [string]
        ${Prefix},

        [Parameter(ParameterSetName = 'BlobName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Parameter(ParameterSetName = 'BlobPrefix', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Parameter(ParameterSetName = 'SingleBlobSnapshotTime', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Parameter(ParameterSetName = 'SingleBlobVersionID', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(ParameterSetName = 'BlobName', HelpMessage = 'Include deleted blobs, by default get blob won''t include deleted blobs')]
        [Parameter(ParameterSetName = 'BlobPrefix', HelpMessage = 'Include deleted blobs, by default get blob won''t include deleted blobs')]
        [Parameter(ParameterSetName = 'SingleBlobSnapshotTime', HelpMessage = 'Include deleted blobs, by default get blob won''t include deleted blobs')]
        [Parameter(ParameterSetName = 'SingleBlobVersionID', HelpMessage = 'Include deleted blobs, by default get blob won''t include deleted blobs')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeDeleted},

        [Parameter(ParameterSetName = 'BlobPrefix', HelpMessage = 'Blob versions will be listed only if this parameter is present, by default get blob won''t include blob versions.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeVersion},

        [Parameter(HelpMessage = 'Include blob tags, by default get blob won''t include blob tags.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeTag},

        [Parameter(ParameterSetName = 'SingleBlobSnapshotTime', Mandatory = $true, HelpMessage = 'Blob SnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${SnapshotTime},

        [Parameter(ParameterSetName = 'SingleBlobVersionID', Mandatory = $true, HelpMessage = 'Blob VersionId')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VersionId},

        [Parameter(HelpMessage = 'The max count of the blobs that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [object]
        ${ContinuationToken},

        [Parameter(ParameterSetName = 'BlobName', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'SingleBlobSnapshotTime', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'SingleBlobVersionID', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageBlobByTag
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Filters the result set to only include blobs whose tags match the specified expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/find-blobs-by-tags#remarks.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagFilterSqlExpression},

        [Parameter(HelpMessage = 'The max count of the blobs that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [object]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'As the blobs get by tag don''t contain blob proeprties, specify tis parameter to get blob properties with an additional request on each blob.')]
        [switch]
        ${GetBlobProperty},

        [Parameter(HelpMessage = 'Container name, specify this parameter to only return all blobs whose tags match a search expression in the container.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageBlobContent
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Blob Object')]
        [Alias('ICloudBlob')]
        [ValidateNotNull()]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'BlobPipeline', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Container Object')]
        [ValidateNotNull()]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'File Path.')]
        [Alias('Path')]
        [string]
        ${Destination},

        [Parameter(ParameterSetName = 'ReceiveManual', HelpMessage = 'check the md5sum')]
        [Parameter(ParameterSetName = 'BlobPipeline', HelpMessage = 'check the md5sum')]
        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'check the md5sum')]
        [switch]
        ${CheckMd5},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Blob uri to download from.')]
        [Alias('Uri', 'BlobUri')]
        [string]
        ${AbsoluteUri},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageBlobCopyState
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('ICloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Wait for copy task complete')]
        [switch]
        ${WaitForComplete},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageBlobInventoryPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageBlobInventoryPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageBlobQueryResult
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobContainerClient Object')]
        [Azure.Storage.Blobs.BlobContainerClient]
        ${BlobContainerClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'Blob SnapshotTime')]
        [Parameter(ParameterSetName = 'NamePipeline', HelpMessage = 'Blob SnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${SnapshotTime},

        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'Blob VersionId')]
        [Parameter(ParameterSetName = 'NamePipeline', HelpMessage = 'Blob VersionId')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VersionId},

        [Parameter(Mandatory = $true, HelpMessage = 'Query string, see more details in: https://learn.microsoft.com/en-us/azure/storage/blobs/query-acceleration-sql-reference')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${QueryString},

        [Parameter(Mandatory = $true, HelpMessage = 'Local file path to save the query result.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResultFile},

        [Parameter(HelpMessage = 'The configuration used to handled the query input text.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputTextConfiguration},

        [Parameter(HelpMessage = 'The configuration used to handled the query output text.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${OutputTextConfiguration},

        [Parameter(HelpMessage = 'Return whether the specified blob is successfully queried.')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageBlobServiceProperty
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageBlobServiceProperty', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageBlobTag
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName')]
    param(
        [Parameter(ParameterSetName = 'ContainerName', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'ContainerPrefix', Mandatory = $true, HelpMessage = 'Container Prefix')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Prefix},

        [Parameter(HelpMessage = 'The max count of the containers that can return.')]
        [System.Nullable[int]]
        ${MaxCount},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [object]
        ${ContinuationToken},

        [Parameter(HelpMessage = 'Include deleted containers, by default list containers won''t include deleted containers')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${IncludeDeleted},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageContainerStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [string]
        ${Policy},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageCORSRule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageEncryptionScope
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'Azure Storage EncryptionScope name')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScopeName},

        [Parameter(HelpMessage = 'The maximum number of encryption scopes that will be included in the list response')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[int]]
        ${MaxPageSize},

        [Parameter(HelpMessage = 'The filter of encryption scope name. When specified, only encryption scope names starting with the filter will be listed. The filter must be in format: startswith(name, <prefix>)')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Filter},

        [Parameter(HelpMessage = 'Optional, when specified, will list encryption scopes with the specific state. Defaults to All.')]
        [ValidateSet('All', 'Enabled', 'Disabled')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Include},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageEncryptionScope', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageFile
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the files/directories would be listed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the files/directories would be listed.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the base folder where the files/directories would be listed.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Not include extended file info like timestamps, ETag, attributes, permissionKey in list file and Directory.')]
        [switch]
        ${ExcludeExtendedInfo},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageFileContent
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the file would be downloaded.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the file would be downloaded.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the cloud directory where the file would be downloaded.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile object indicated the cloud file to be downloaded.')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Path to the cloud file to be downloaded.')]
        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 1, HelpMessage = 'Path to the cloud file to be downloaded.')]
        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 1, HelpMessage = 'Path to the cloud file to be downloaded.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ShareName', Position = 2, HelpMessage = 'Path to the local file or directory when the downloaded file would be put.')]
        [Parameter(ParameterSetName = 'Share', Position = 2, HelpMessage = 'Path to the local file or directory when the downloaded file would be put.')]
        [Parameter(ParameterSetName = 'Directory', Position = 2, HelpMessage = 'Path to the local file or directory when the downloaded file would be put.')]
        [Parameter(ParameterSetName = 'File', Position = 1, HelpMessage = 'Path to the local file or directory when the downloaded file would be put.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Destination},

        [Parameter(HelpMessage = 'check the md5sum')]
        [switch]
        ${CheckMd5},

        [Parameter(HelpMessage = 'Returns an object representing the downloaded cloud file. By default, this cmdlet does not generate any output.')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageFileContent', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageFileCopyState
{
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Target share name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Target file path')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FilePath},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Target file instance')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(HelpMessage = 'Indicates whether or not to wait util the copying finished.')]
        [switch]
        ${WaitForComplete},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageFileHandle
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsPaging = $true)]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the files/directories would list File Handles.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the files/directories would list File Handles.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the base folder where the files/directories would list File Handles.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile object indicated the file to list File Handles.')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(ParameterSetName = 'ShareName', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [Parameter(ParameterSetName = 'Directory', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [Parameter(ParameterSetName = 'Share', Position = 1, HelpMessage = 'Path to an existing file/directory.')]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'List handles Recursively. Only works on File Directory.')]
        [switch]
        ${Recursive},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageFileServiceProperty
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'FileServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a File service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageFileServiceProperty', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageLocalUser
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserName},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageLocalUser', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageLocalUserKey
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserName},

        [Parameter(ParameterSetName = 'UserObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'Local User Object to get Keys.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageLocalUserKey', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageObjectReplicationPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(HelpMessage = 'Object Replication Policy Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${PolicyId},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageObjectReplicationPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Get-AzStorageQueue
{
    [CmdletBinding(DefaultParameterSetName = 'QueueName')]
    param(
        [Parameter(ParameterSetName = 'QueueName', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue name')]
        [Alias('N', 'Queue')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'QueuePrefix', Mandatory = $true, HelpMessage = 'Queue Prefix')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Prefix},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageQueueStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Queue},

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [string]
        ${Policy},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageServiceLoggingProperty
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageServiceMetricsProperty
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Azure storage service metrics type(Hour, Minute).')]
        [object]
        ${MetricsType},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageServiceProperty
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'MatchingPrefix')]
    param(
        [Parameter(ParameterSetName = 'Specific', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share to be received.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'MatchingPrefix', Position = 0, HelpMessage = 'A prefix of the file shares to be listed.')]
        [string]
        ${Prefix},

        [Parameter(ParameterSetName = 'Specific', Position = 1, HelpMessage = 'SnapshotTime of the file share snapshot to be received.')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${SnapshotTime},

        [Parameter(ParameterSetName = 'MatchingPrefix', HelpMessage = 'Include deleted shares, by default get share won''t include deleted shares')]
        [switch]
        ${IncludeDeleted},

        [Parameter(ParameterSetName = 'MatchingPrefix', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'Specific', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageShareStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [string]
        ${Policy},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Get-AzStorageTable
{
    [CmdletBinding(DefaultParameterSetName = 'TableName')]
    param(
        [Parameter(ParameterSetName = 'TableName', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table name')]
        [Alias('N', 'Table')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'TablePrefix', Mandatory = $true, HelpMessage = 'Table Prefix')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Prefix},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageTableStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Table},

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [string]
        ${Policy},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Get-AzStorageUsage
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Accounts Location.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Location},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Get-AzStorageUsage', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Invoke-AzRmStorageContainerImmutableStorageWithVersioningMigration
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [Alias('Container')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Invoke-AzRmStorageContainerImmutableStorageWithVersioningMigration', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Invoke-AzStorageAccountFailover
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Force to Failover the Account')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Invoke-AzStorageAccountFailover', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Invoke-AzStorageAccountHierarchicalNamespaceUpgrade
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(Mandatory = $true, HelpMessage = 'The HierarchicalNamespaceUpgrade requestType  to run: Validation: Validate if the account can be upgrade to enable HierarchicalNamespace. Upgrade: Upgrade the storage account to enable HierarchicalNamespace.')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Validation', 'Upgrade')]
        [string]
        ${RequestType},

        [Parameter(HelpMessage = 'Force to upgrade the Account')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Invoke-AzStorageAccountHierarchicalNamespaceUpgrade', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Lock-AzRmStorageContainerImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N')]
        [string]
        ${ContainerName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Alias('IfMatch')]
        [string]
        ${Etag},

        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'ImmutabilityPolicy Object to Remove')]
        [Alias('ImmutabilityPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Force to remove the ImmutabilityPolicy.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Lock-AzRmStorageContainerImmutabilityPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Move-AzDataLakeGen2Item
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be move from. Can be a file or directory. In the format ''directory/file.txt'' or ''directory1/directory2/''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Item Object to move from.')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(Mandatory = $true, HelpMessage = 'Dest FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestFileSystem},

        [Parameter(Mandatory = $true, HelpMessage = 'Dest item path')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestPath},

        [Parameter(HelpMessage = 'Force to over write the destination.')]
        [switch]
        ${Force},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzDataLakeGen2Item
{
    [CmdletBinding(DefaultParameterSetName = 'File', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be create. Can be a file or directory In the format ''directory/file.txt'' or ''directory1/directory2/''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, HelpMessage = 'Indicates that this new item is a directory and not a file.')]
        [switch]
        ${Directory},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Specify the local source file path which will be upload to a Datalake Gen2 file.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Source},

        [Parameter(HelpMessage = 'When creating New Item and the parent directory does not have a default ACL, the umask restricts the permissions of the file or directory to be created. The resulting permission is given by p & ^u, where p is the permission and u is the umask. Symbolic (rwxrw-rw-) is supported.')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('([r-][w-][x-]){3}')]
        [string]
        ${Umask},

        [Parameter(HelpMessage = 'Sets POSIX access permissions for the file owner, the file owning group, and others. Each class may be granted read, write, or execute permission. Symbolic (rwxrw-rw-) is supported. The sticky bit is also supported and its represented either by the letter t or T in the final character-place depending on whether the execution bit for the others category is set or unset respectively, absence of t or T indicates sticky bit not set.')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('([r-][w-][x-]){2}([r-][w-][xtT-])')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Specifies properties for the created directory or file. The supported properties for file are: CacheControl, ContentDisposition, ContentEncoding, ContentLanguage, ContentMD5, ContentType.The supported properties for directory are: CacheControl, ContentDisposition, ContentEncoding, ContentLanguage.')]
        [hashtable]
        ${Property},

        [Parameter(HelpMessage = 'Specifies metadata for the created directory or file.')]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzDataLakeGen2SasToken
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be retrieved. Can be a file or directory In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to get the root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Item Object to remove.')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Permissions for a blob. Permissions can be any not-empty subset of "racwdlmeop".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[Azure.Storage.Sas.SasProtocol]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[System.DateTimeOffset]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[System.DateTimeOffset]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Encryption scope to use when sending requests authorized with this SAS URI.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzRmStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNameEncryptionScope', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNameEncryptionScope', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectEncryptionScope', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountNameEncryptionScope', Mandatory = $true, HelpMessage = 'Default the container to use specified encryption scope for all writes.')]
        [Parameter(ParameterSetName = 'AccountObjectEncryptionScope', Mandatory = $true, HelpMessage = 'Default the container to use specified encryption scope for all writes.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DefaultEncryptionScope},

        [Parameter(ParameterSetName = 'AccountNameEncryptionScope', Mandatory = $true, HelpMessage = 'Block override of encryption scope from the container default.')]
        [Parameter(ParameterSetName = 'AccountObjectEncryptionScope', Mandatory = $true, HelpMessage = 'Block override of encryption scope from the container default.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PreventEncryptionScopeOverride},

        [Parameter(HelpMessage = 'Container PublicAccess')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${PublicAccess},

        [Parameter(HelpMessage = 'Container Metadata')]
        [AllowEmptyCollection()]
        [ValidateNotNull()]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Sets reduction of the access rights for the remote superuser. Possible values include: ''NoRootSquash'', ''RootSquash'', ''AllSquash''')]
        [ValidateSet('NoRootSquash', 'RootSquash', 'AllSquash')]
        [string]
        ${RootSquash},

        [Parameter(HelpMessage = 'Enable object level immutability at the container level.')]
        [switch]
        ${EnableImmutableStorageWithVersioning},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzRmStorageContainer', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzRmStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(Mandatory = $true, HelpMessage = 'Azure File share name')]
        [Alias('N', 'ShareName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Share Quota in Gibibyte.')]
        [Alias('Quota')]
        [int]
        ${QuotaGiB},

        [Parameter(HelpMessage = 'Share Metadata')]
        [AllowEmptyCollection()]
        [ValidateNotNull()]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Access tier for specific share. StorageV2 account can choose between TransactionOptimized (default), Hot, and Cool. FileStorage account can choose Premium.')]
        [ValidateSet('TransactionOptimized', 'Premium', 'Hot', 'Cool')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${AccessTier},

        [Parameter(HelpMessage = 'Create a snapshot of existing share with same name.')]
        [switch]
        ${Snapshot},

        [Parameter(HelpMessage = 'Sets protocols for file shares. It cannot be changed after file share creation. Possible values include: ''SMB'', ''NFS''')]
        [ValidateSet('NFS', 'SMB')]
        [string]
        ${EnabledProtocol},

        [Parameter(HelpMessage = 'Sets reduction of the access rights for the remote superuser. Possible values include: ''NoRootSquash'', ''RootSquash'', ''AllSquash''')]
        [ValidateSet('NoRootSquash', 'RootSquash', 'AllSquash')]
        [string]
        ${RootSquash},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzRmStorageShare', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccount
{
    [CmdletBinding(DefaultParameterSetName = 'AzureActiveDirectoryDomainServicesForFile')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Mandatory = $true, Position = 2, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Sku Name.')]
        [Alias('StorageAccountType', 'AccountType', 'Type')]
        [ValidateSet('Standard_LRS', 'Standard_ZRS', 'Standard_GRS', 'Standard_RAGRS', 'Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', 'Standard_RAGZRS')]
        [string]
        ${SkuName},

        [Parameter(Mandatory = $true, Position = 3, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Location.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Location},

        [Parameter(HelpMessage = 'Storage Account Kind.')]
        [ValidateSet('Storage', 'StorageV2', 'BlobStorage', 'BlockBlobStorage', 'FileStorage')]
        [string]
        ${Kind},

        [Parameter(HelpMessage = 'Storage Account Access Tier.')]
        [ValidateSet('Hot', 'Cool')]
        [string]
        ${AccessTier},

        [Parameter(HelpMessage = 'Storage Account Custom Domain.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${CustomDomainName},

        [Parameter(HelpMessage = 'To Use Sub Domain.')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[bool]]
        ${UseSubDomain},

        [Parameter(HelpMessage = 'Storage Account Tags.')]
        [Alias('Tags')]
        [ValidateNotNull()]
        [hashtable]
        ${Tag},

        [Parameter(HelpMessage = 'Storage Account EnableHttpsTrafficOnly.')]
        [bool]
        ${EnableHttpsTrafficOnly},

        [Parameter(HelpMessage = 'Generate and assign a new Storage Account Identity for this storage account for use with key management services like Azure KeyVault. If specify this paramter without "-IdentityType", will use system assigned identity.')]
        [switch]
        ${AssignIdentity},

        [Parameter(HelpMessage = 'Set resource ids for the the new Storage Account user assigned Identity, the identity will be used with key management services like Azure KeyVault.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserAssignedIdentityId},

        [Parameter(HelpMessage = 'Set the new Storage Account Identity type, the idenetity is for use with key management services like Azure KeyVault.')]
        [ValidateSet('SystemAssigned', 'UserAssigned', 'SystemAssignedUserAssigned', 'None')]
        [string]
        ${IdentityType},

        [Parameter(HelpMessage = 'Set resource id for user assigned Identity used to access Azure KeyVault of Storage Account Encryption, the id must in UserAssignIdentityId.')]
        [ValidateNotNull()]
        [string]
        ${KeyVaultUserAssignedIdentityId},

        [Parameter(HelpMessage = 'Set ClientId of the multi-tenant application to be used in conjunction with the user-assigned identity for cross-tenant customer-managed-keys server-side encryption on the storage account.')]
        [ValidateNotNull()]
        [string]
        ${KeyVaultFederatedClientId},

        [Parameter(HelpMessage = 'Storage Account encryption keySource KeyVault KeyName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyName},

        [Parameter(HelpMessage = 'Storage Account encryption keySource KeyVault KeyVersion')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyVersion},

        [Parameter(HelpMessage = 'Storage Account encryption keySource KeyVault KeyVaultUri')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyVaultUri},

        [Parameter(HelpMessage = 'Storage Account NetworkRule')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${NetworkRuleSet},

        [Parameter(HelpMessage = 'Enable Secure File Transfer Protocol for the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableSftp},

        [Parameter(HelpMessage = 'Enable local users feature for the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableLocalUser},

        [Parameter(HelpMessage = 'Enable HierarchicalNamespace for the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableHierarchicalNamespace},

        [Parameter(ParameterSetName = 'AzureActiveDirectoryDomainServicesForFile', HelpMessage = 'Enable Azure Files Azure Active Directory Domain Service Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableAzureActiveDirectoryDomainServicesForFile},

        [Parameter(HelpMessage = 'Indicates whether or not the storage account can support large file shares with more than 5 TiB capacity. Once the account is enabled, the feature cannot be disabled. Currently only supported for LRS and ZRS replication types, hence account conversions to geo-redundant accounts would not be possible. Learn more in https://go.microsoft.com/fwlink/?linkid=2086047')]
        [switch]
        ${EnableLargeFileShare},

        [Parameter(HelpMessage = 'Indicates whether microsoft routing storage endpoints are to be published')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PublishMicrosoftEndpoint},

        [Parameter(HelpMessage = 'Indicates whether internet  routing storage endpoints are to be published')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PublishInternetEndpoint},

        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', Mandatory = $true, HelpMessage = 'Enable Azure Files Active Directory Domain Service Kerberos Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableAzureActiveDirectoryKerberosForFile},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Enable Azure Files Active Directory Domain Service Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableActiveDirectoryDomainServicesForFile},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the primary domain that the AD DNS server is authoritative for. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', HelpMessage = 'Specifies the primary domain that the AD DNS server is authoritative for. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryDomainName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the NetBIOS domain name. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryNetBiosDomainName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory forest to get. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryForestName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the domain GUID. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', HelpMessage = 'Specifies the domain GUID. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryDomainGuid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the security identifier (SID). This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryDomainSid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the security identifier (SID) for Azure Storage. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryAzureStorageSid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory SAMAccountName for Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectorySamAccountName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory account type for Azure Storage. Possible values include: ''User'', ''Computer''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryAccountType},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'Set the Encryption KeyType for Table. -Account, Table will be encrypted with account-scoped encryption key. -Service, Table will always be encrypted with Service-Managed keys. The default value is Service.')]
        [ValidateSet('Service', 'Account')]
        [string]
        ${EncryptionKeyTypeForTable},

        [Parameter(HelpMessage = 'Set the Encryption KeyType for Queue. -Account, Queue will be encrypted with account-scoped encryption key. -Service, Queue will always be encrypted with Service-Managed keys. The default value is Service.')]
        [ValidateSet('Service', 'Account')]
        [string]
        ${EncryptionKeyTypeForQueue},

        [Parameter(HelpMessage = 'The service will apply a secondary layer of encryption with platform managed keys for data at rest.')]
        [switch]
        ${RequireInfrastructureEncryption},

        [Parameter(HelpMessage = 'The SAS expiration period of this account, it is a timespan and accurate to seconds.')]
        [timespan]
        ${SasExpirationPeriod},

        [Parameter(HelpMessage = 'The Key expiration period of this account, it is accurate to days.')]
        [int]
        ${KeyExpirationPeriodInDay},

        [Parameter(HelpMessage = 'Allow public access to all blobs or containers in the storage account. The default interpretation is true for this property.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowBlobPublicAccess},

        [Parameter(HelpMessage = 'The minimum TLS version to be permitted on requests to storage. The default interpretation is TLS 1.0 for this property.')]
        [ValidateSet('TLS1_0', 'TLS1_1', 'TLS1_2')]
        [string]
        ${MinimumTlsVersion},

        [Parameter(HelpMessage = 'Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is null, which is equivalent to true.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowSharedKeyAccess},

        [Parameter(HelpMessage = 'Enable NFS 3.0 protocol support if sets to true')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableNfsV3},

        [Parameter(HelpMessage = 'Gets or sets allow or disallow cross AAD tenant object replication. The default interpretation is true for this property.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowCrossTenantReplication},

        [Parameter(HelpMessage = 'Default share permission for users using Kerberos authentication if RBAC role is not assigned.')]
        [ValidateSet('None', 'StorageFileDataSmbShareContributor', 'StorageFileDataSmbShareReader', 'StorageFileDataSmbShareElevatedContributor')]
        [string]
        ${DefaultSharePermission},

        [Parameter(HelpMessage = 'Set the extended location name for EdgeZone. If not set, the storage account will be created in Azure main region. Otherwise it will be created in the specified extended location')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EdgeZone},

        [Parameter(HelpMessage = 'Allow or disallow public network access to Storage Account. Possible values include: ''Enabled'', ''Disabled''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${PublicNetworkAccess},

        [Parameter(HelpMessage = 'Enables account-level immutability, then all the containers under this account will have object-level immutability enabled by default.')]
        [switch]
        ${EnableAccountLevelImmutability},

        [Parameter(HelpMessage = 'The immutability period for the blobs in the container since the policy creation in days. This property can only be only be specified with ''-EnableAccountLevelImmutability''.')]
        [int]
        ${ImmutabilityPeriod},

        [Parameter(HelpMessage = 'The mode of the policy. Possible values include: ''Unlocked'', ''Disabled. Disabled state disablesthe policy. Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states.This property can only be specified with ''-EnableAccountLevelImmutability''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ImmutabilityPolicyState},

        [Parameter(HelpMessage = 'Set restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values include: ''PrivateLink'', ''AAD''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${AllowedCopyScope},

        [Parameter(HelpMessage = 'Specify the type of endpoint. Set this to AzureDNSZone to create a large number of accounts in a single subscription, which creates accounts in an Azure DNS Zone and the endpoint URL will have an alphanumeric DNS Zone identifier. Possible values include: ''Standard'', ''AzureDnsZone''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DnsEndpointType},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'Routing Choice defines the kind of network routing opted by the user. Possible values include: ''MicrosoftRouting'', ''InternetRouting''')]
        [ValidateSet('MicrosoftRouting', 'InternetRouting')]
        [string]
        ${RoutingChoice})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageAccount', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccountKey
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Mandatory = $true, Position = 2, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Key.')]
        [ValidateSet('key1', 'key2', 'kerb1', 'kerb2')]
        [string]
        ${KeyName},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageAccountKey', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccountManagementPolicyBlobIndexMatchObject
{
    [CmdletBinding()]
    param(
        [Parameter(HelpMessage = 'Gets or sets this is the filter tag name, it can have 1 - 128 characters')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Gets or sets this is the filter tag value field used for tag based filtering, it can have 0 - 256 characters.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Value},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageAccountManagementPolicyBlobIndexMatchObject', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccountManagementPolicyFilter
{
    [CmdletBinding()]
    param(
        [Parameter(HelpMessage = 'An array of strings for prefixes to be match. A prefix string must start with a container name.')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PrefixMatch},

        [Parameter(HelpMessage = 'An array of strings for blobtypes to be match. Currently blockBlob supports all tiering and delete actions. Only delete actions are supported for appendBlob.')]
        [ValidateSet('blockBlob', 'appendBlob')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${BlobType},

        [Parameter(HelpMessage = 'An array of blob index tag based filters, there can be at most 10 tag filters.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${BlobIndexMatch},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageAccountManagementPolicyFilter', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccountManagementPolicyRule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'A rule name can contain any combination of alpha numeric characters. Rule name is case-sensitive. It must be unique within a policy.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'The rule is disabled if set it.')]
        [switch]
        ${Disabled},

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'An object that defines the action set. Get the Object with cmdlet Add-AzureStorageAccountManagementPolicyAction')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Action},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'An object that defines the filter set. Get the Object with cmdlet New-AzureStorageAccountManagementPolicyFilter')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Filter},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageAccountManagementPolicyRule', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageAccountSASToken
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Service type that this SAS token applies to.')]
        [object]
        ${Service},

        [Parameter(Mandatory = $true, HelpMessage = 'Resource type that this SAS token applies to.')]
        [object]
        ${ResourceType},

        [Parameter(HelpMessage = 'Permissions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Encryption scope to use when sending requests authorized with this SAS URI.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageBlobInventoryPolicyRule
{
    [CmdletBinding(DefaultParameterSetName = 'BlobRuleParameterSet')]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'A rule name can contain any combination of alpha numeric characters. Rule name is case-sensitive. It must be unique within a policy.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'The rule is disabled if set it.')]
        [switch]
        ${Disabled},

        [Parameter(Mandatory = $true, HelpMessage = 'The container name where blob inventory files are stored. Must be pre-created.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Destination},

        [Parameter(Mandatory = $true, HelpMessage = 'Specifies the format for the inventory files. Possible values include: ''Csv'', ''Parquet''')]
        [ValidateSet('Csv', 'Parquet')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Format},

        [Parameter(Mandatory = $true, HelpMessage = 'This field is used to schedule an inventory formation. Possible values include: ''Daily'', ''Weekly''')]
        [ValidateSet('Daily', 'Weekly')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Schedule},

        [Parameter(ParameterSetName = 'BlobRuleParameterSet', Mandatory = $true, HelpMessage = 'Specifies the fields and properties of the Blob object to be included in the inventory. Valid values include: Name, Creation-Time, Last-Modified, Content-Length, Content-MD5, BlobType, AccessTier, AccessTierChangeTime, Expiry-Time, hdi_isfolder, Owner, Group, Permissions, Acl, Metadata, LastAccessTime, AccessTierInferred, Tags, Etag, Content-Type, Content-Encoding, Content-Language, Content-CRC64, Cache-Control, Content-Disposition, LeaseStatus, LeaseState, LeaseDuration, ServerEncrypted, Deleted, RemainingRetentionDays, ImmutabilityPolicyUntilDateImmutabilityPolicyMode, LegalHold, CopyId, CopyStatus, CopySource, CopyProgress, CopyCompletionTime, CopyStatusDescription, CustomerProvidedKeySha256 RehydratePriority, ArchiveStatus, x-ms-blob-sequence-number, EncryptionScope, IncrementalCopy, DeletionId, DeletedTime, TagCount. ''Name'' is a required schemafield. Schema field values ''Expiry-Time, hdi_isfolder, Owner, Group, Permissions, Acl'' are valid only for Hns enabled accounts.''Tags'' field is only valid for non Hns accounts.''Tags, TagCount'' field is only valid for non Hns accounts. If specify ''-IncludeSnapshot'', will include ''Snapshot''  in the inventory.  If specify ''-IncludeBlobVersion'', will include ''VersionId, ''IsCurrentVersion'' in the inventory.')]
        [ValidateSet('Name', 'Creation-Time', 'Last-Modified', 'Content-Length', 'Content-MD5', 'BlobType', 'AccessTier', 'AccessTierChangeTime', 'Expiry-Time', 'hdi_isfolder', 'Owner', 'Group', 'Permissions', 'Acl', 'Metadata', 'LastAccessTime', 'AccessTierInferred', 'Tags', 'Etag', 'Content-Type', 'Content-Encoding', 'Content-Language', 'Content-CRC64', 'Cache-Control', 'Content-Disposition', 'LeaseStatus', 'LeaseState', 'LeaseDuration', 'ServerEncrypted', 'Deleted', 'RemainingRetentionDays', 'ImmutabilityPolicyUntilDate', 'ImmutabilityPolicyMode', 'LegalHold', 'CopyId', 'CopyStatus', 'CopySource', 'CopyProgress', 'CopyCompletionTime', 'CopyStatusDescription', 'CustomerProvidedKeySha256', 'RehydratePriority', 'ArchiveStatus', 'x-ms-blob-sequence-number', 'EncryptionScope', 'IncrementalCopy', 'DeletionId', 'DeletedTime', 'TagCount')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${BlobSchemaField},

        [Parameter(ParameterSetName = 'ContainerRuleParameterSet', Mandatory = $true, HelpMessage = 'Specifies the fields and properties of the container object to be included in the inventory. Valid values include: Name, Last-Modified, Metadata, LeaseStatus, LeaseState, LeaseDuration, PublicAccess, HasImmutabilityPolicy, HasLegalHold, Etag, DefaultEncryptionScope, DenyEncryptionScopeOverride, ImmutableStorageWithVersioningEnabled, Deleted, Version, DeletedTime, RemainingRetentionDays. ''Name'' is a required schemafield.')]
        [ValidateSet('Name', 'Last-Modified', 'Metadata', 'LeaseStatus', 'LeaseState', 'LeaseDuration', 'PublicAccess', 'HasImmutabilityPolicy', 'HasLegalHold', 'Etag', 'DefaultEncryptionScope', 'DenyEncryptionScopeOverride', 'ImmutableStorageWithVersioningEnabled', 'Deleted', 'Version', 'DeletedTime', 'RemainingRetentionDays')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${ContainerSchemaField},

        [Parameter(ParameterSetName = 'BlobRuleParameterSet', Mandatory = $true, HelpMessage = 'Sets the blob types for the blob inventory policy rule. Valid values include blockBlob, appendBlob, pageBlob. Hns accounts does not support pageBlobs.')]
        [ValidateSet('blockBlob', 'pageBlob', 'appendBlob')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${BlobType},

        [Parameter(HelpMessage = 'Sets an array of strings for blob prefixes to be matched.')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PrefixMatch},

        [Parameter(HelpMessage = 'Sets an array of strings with maximum 10 blob prefixes to be excluded from the inventory.')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${ExcludePrefix},

        [Parameter(ParameterSetName = 'BlobRuleParameterSet', HelpMessage = 'Includes blob snapshots in blob inventory')]
        [switch]
        ${IncludeSnapshot},

        [Parameter(ParameterSetName = 'BlobRuleParameterSet', HelpMessage = 'Includes blob versions in blob inventory.')]
        [switch]
        ${IncludeBlobVersion},

        [Parameter(ParameterSetName = 'BlobRuleParameterSet', HelpMessage = 'Includes deleted blob in blob inventory. When include delete blob, for ContainerSchemaFields, must include ''Deleted, Version, DeletedTime and RemainingRetentionDays''. For BlobSchemaFields, on HNS enabled storage accounts, must include ''DeletionId, Deleted, DeletedTime and RemainingRetentionDays'', and on Hns disabled accounts must include ''Deleted and RemainingRetentionDays'', else they must be excluded.')]
        [switch]
        ${IncludeDeleted},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageBlobInventoryPolicyRule', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageBlobQueryConfig
{
    [CmdletBinding(DefaultParameterSetName = 'Csv')]
    param(
        [Parameter(ParameterSetName = 'Csv', Mandatory = $true, Position = 0, HelpMessage = 'Indicate to create a Blob Query Configuration for CSV.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${AsCsv},

        [Parameter(ParameterSetName = 'Json', Mandatory = $true, Position = 0, HelpMessage = 'Indicate to create a Blob Query Configuration for Json.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${AsJson},

        [Parameter(ParameterSetName = 'Csv', HelpMessage = 'Optional. The string used to separate records.')]
        [Parameter(ParameterSetName = 'Json', HelpMessage = 'Optional. The string used to separate records.')]
        [string]
        ${RecordSeparator},

        [Parameter(ParameterSetName = 'Csv', HelpMessage = 'Optional. The string used to separate columns.')]
        [string]
        ${ColumnSeparator},

        [Parameter(ParameterSetName = 'Csv', HelpMessage = 'Optional. The char used to quote a specific field.')]
        [char]
        ${QuotationCharacter},

        [Parameter(ParameterSetName = 'Csv', HelpMessage = 'Optional. The char used as an escape character.')]
        [System.Nullable[char]]
        ${EscapeCharacter},

        [Parameter(ParameterSetName = 'Csv', HelpMessage = 'Optional. Indicate it represent the data has headers.')]
        [switch]
        ${HasHeader},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob})


}


function New-AzStorageBlobRangeToRestore
{
    [CmdletBinding()]
    param(
        [Parameter(HelpMessage = 'Specify the blob restore start range. Leave it as empty to restore from begining.')]
        [ValidateNotNull()]
        [string]
        ${StartRange},

        [Parameter(HelpMessage = 'Specify the blob restore End range. Leave it as empty to restore to the end.')]
        [ValidateNotNull()]
        [string]
        ${EndRange},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageBlobRangeToRestore', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageBlobSASToken
{
    [CmdletBinding(DefaultParameterSetName = 'BlobNameWithPermission', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipelineWithPolicy', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Parameter(ParameterSetName = 'BlobPipelineWithPermission', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('ICloudBlob')]
        [ValidateNotNull()]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'BlobPipelineWithPolicy', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [Parameter(ParameterSetName = 'BlobPipelineWithPermission', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'BlobNameWithPermission', Mandatory = $true, Position = 0, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'BlobNameWithPolicy', Mandatory = $true, Position = 0, HelpMessage = 'Container Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(ParameterSetName = 'BlobNameWithPermission', Mandatory = $true, Position = 1, HelpMessage = 'Blob Name')]
        [Parameter(ParameterSetName = 'BlobNameWithPolicy', Mandatory = $true, Position = 1, HelpMessage = 'Blob Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'BlobNameWithPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [Parameter(ParameterSetName = 'BlobPipelineWithPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'BlobNameWithPermission', HelpMessage = 'Permissions for a blob. Permissions can be any not-empty subset of "rwd".')]
        [Parameter(ParameterSetName = 'BlobPipelineWithPermission', HelpMessage = 'Permissions for a blob. Permissions can be any not-empty subset of "rwd".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(HelpMessage = 'Encryption scope to use when sending requests authorized with this SAS URI.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Position = 1, HelpMessage = 'Permission string Off/Blob/Container')]
        [Alias('PublicAccess')]
        [System.Nullable[object]]
        ${Permission},

        [Parameter(ParameterSetName = 'EncryptionScope', Mandatory = $true, HelpMessage = 'Default the container to use specified encryption scope for all writes.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DefaultEncryptionScope},

        [Parameter(ParameterSetName = 'EncryptionScope', Mandatory = $true, HelpMessage = 'Prevent override of encryption scope from the container default.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PreventEncryptionScopeOverride},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzStorageContainerSASToken
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'SasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'SasPermission', HelpMessage = 'Permissions for a container. Permissions can be any not-empty subset of "rwdl".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(HelpMessage = 'Encryption scope to use when sending requests authorized with this SAS URI.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageContainerStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier. Need to be unique in the Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a container. Permissions can be any subset of "racwdxlt", make the permission order also same as it')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzStorageContext
{
    [CmdletBinding(DefaultParameterSetName = 'OAuthAccount')]
    param(
        [Parameter(ParameterSetName = 'AccountNameAndKey', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'AccountNameAndKeyEnvironment', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'AnonymousAccount', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'AnonymousAccountEnvironment', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'SasToken', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'SasTokenWithAzureEnvironment', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'OAuthAccount', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'OAuthAccountEnvironment', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', Mandatory = $true, Position = 0, HelpMessage = 'Azure Storage Account Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountNameAndKey', Mandatory = $true, Position = 1, HelpMessage = 'Azure Storage Account Key')]
        [Parameter(ParameterSetName = 'AccountNameAndKeyEnvironment', Mandatory = $true, Position = 1, HelpMessage = 'Azure Storage Account Key')]
        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', Mandatory = $true, Position = 1, HelpMessage = 'Azure Storage Account Key')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountKey},

        [Parameter(ParameterSetName = 'SasToken', Mandatory = $true, HelpMessage = 'Azure Storage SAS Token')]
        [Parameter(ParameterSetName = 'SasTokenWithAzureEnvironment', Mandatory = $true, HelpMessage = 'Azure Storage SAS Token')]
        [Parameter(ParameterSetName = 'SasTokenServiceEndpoint', Mandatory = $true, HelpMessage = 'Azure Storage SAS Token')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SasToken},

        [Parameter(ParameterSetName = 'ConnectionString', Mandatory = $true, HelpMessage = 'Azure Storage Connection String')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ConnectionString},

        [Parameter(ParameterSetName = 'LocalDevelopment', Mandatory = $true, HelpMessage = 'Use local development storage account')]
        [switch]
        ${Local},

        [Parameter(ParameterSetName = 'AnonymousAccount', Mandatory = $true, HelpMessage = 'Use anonymous storage account')]
        [Parameter(ParameterSetName = 'AnonymousAccountEnvironment', Mandatory = $true, HelpMessage = 'Use anonymous storage account')]
        [Parameter(ParameterSetName = 'AnonymousAccountServiceEndpoint', Mandatory = $true, HelpMessage = 'Use anonymous storage account')]
        [switch]
        ${Anonymous},

        [Parameter(ParameterSetName = 'OAuthAccount', HelpMessage = 'Use OAuth storage account')]
        [Parameter(ParameterSetName = 'OAuthAccountEnvironment', HelpMessage = 'Use OAuth storage account')]
        [Parameter(ParameterSetName = 'OAuthAccountServiceEndpoint', HelpMessage = 'Use OAuth storage account')]
        [switch]
        ${UseConnectedAccount},

        [Parameter(ParameterSetName = 'AccountNameAndKey', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'AccountNameAndKeyEnvironment', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'AnonymousAccount', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'AnonymousAccountEnvironment', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'SasToken', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'OAuthAccount', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [Parameter(ParameterSetName = 'OAuthAccountEnvironment', HelpMessage = 'Protocol specification (HTTP or HTTPS), default is HTTPS')]
        [ValidateSet('Http', 'Https')]
        [string]
        ${Protocol},

        [Parameter(ParameterSetName = 'AccountNameAndKey', HelpMessage = 'Azure storage endpoint')]
        [Parameter(ParameterSetName = 'AnonymousAccount', HelpMessage = 'Azure storage endpoint')]
        [Parameter(ParameterSetName = 'SasToken', HelpMessage = 'Azure storage endpoint')]
        [Parameter(ParameterSetName = 'OAuthAccount', HelpMessage = 'Azure storage endpoint')]
        [string]
        ${Endpoint},

        [Parameter(ParameterSetName = 'AccountNameAndKeyEnvironment', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure environment name')]
        [Parameter(ParameterSetName = 'AnonymousAccountEnvironment', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure environment name')]
        [Parameter(ParameterSetName = 'SasTokenWithAzureEnvironment', Mandatory = $true, HelpMessage = 'Azure environment name')]
        [Parameter(ParameterSetName = 'OAuthAccountEnvironment', Mandatory = $true, HelpMessage = 'Azure environment name')]
        [Alias('Name', 'EnvironmentName')]
        [string]
        ${Environment},

        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', Mandatory = $true, HelpMessage = 'Azure storage blob service endpoint')]
        [Parameter(ParameterSetName = 'AnonymousAccountServiceEndpoint', HelpMessage = 'Azure storage blob service endpoint')]
        [Parameter(ParameterSetName = 'SasTokenServiceEndpoint', HelpMessage = 'Azure storage blob service endpoint')]
        [Parameter(ParameterSetName = 'OAuthAccountServiceEndpoint', HelpMessage = 'Azure storage blob service endpoint')]
        [string]
        ${BlobEndpoint},

        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', HelpMessage = 'Azure storage file service endpoint')]
        [Parameter(ParameterSetName = 'AnonymousAccountServiceEndpoint', HelpMessage = 'Azure storage file service endpoint')]
        [Parameter(ParameterSetName = 'SasTokenServiceEndpoint', HelpMessage = 'Azure storage file service endpoint')]
        [Parameter(ParameterSetName = 'OAuthAccountServiceEndpoint', HelpMessage = 'Azure storage file service endpoint')]
        [string]
        ${FileEndpoint},

        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', HelpMessage = 'Azure storage queue service endpoint')]
        [Parameter(ParameterSetName = 'AnonymousAccountServiceEndpoint', HelpMessage = 'Azure storage queue service endpoint')]
        [Parameter(ParameterSetName = 'SasTokenServiceEndpoint', HelpMessage = 'Azure storage queue service endpoint')]
        [Parameter(ParameterSetName = 'OAuthAccountServiceEndpoint', HelpMessage = 'Azure storage queue service endpoint')]
        [string]
        ${QueueEndpoint},

        [Parameter(ParameterSetName = 'AccountNameAndKeyServiceEndpoint', HelpMessage = 'Azure storage table service endpoint')]
        [Parameter(ParameterSetName = 'AnonymousAccountServiceEndpoint', HelpMessage = 'Azure storage table service endpoint')]
        [Parameter(ParameterSetName = 'SasTokenServiceEndpoint', HelpMessage = 'Azure storage table service endpoint')]
        [Parameter(ParameterSetName = 'OAuthAccountServiceEndpoint', HelpMessage = 'Azure storage table service endpoint')]
        [string]
        ${TableEndpoint})


}


function New-AzStorageDirectory
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the directory would be created.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the directory would be created.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the base folder where the new directory would be created.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Path of the directory to be created.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzStorageEncryptionScope
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(Mandatory = $true, HelpMessage = 'Azure Storage EncryptionScope name')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScopeName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Storage.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Storage.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${StorageEncryption},

        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${KeyvaultEncryption},

        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, HelpMessage = 'The key Uri ')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyUri},

        [Parameter(HelpMessage = 'The encryption scope will apply a secondary layer of encryption with platform managed keys for data at rest.')]
        [switch]
        ${RequireInfrastructureEncryption},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageEncryptionScope', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageFileSASToken
{
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'NameSasPermission', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'NameSasPolicy', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'NameSasPermission', Mandatory = $true, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Path to the cloud file to generate sas token against.')]
        [Parameter(ParameterSetName = 'NameSasPolicy', Mandatory = $true, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Path to the cloud file to generate sas token against.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'FileSasPermission', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile instance to represent the file to get SAS token against.')]
        [Parameter(ParameterSetName = 'FileSasPolicy', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile instance to represent the file to get SAS token against.')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(ParameterSetName = 'NameSasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [Parameter(ParameterSetName = 'FileSasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'NameSasPermission', HelpMessage = 'Permissions for a file. Permissions can be any subset of "rwd".')]
        [Parameter(ParameterSetName = 'FileSasPermission', HelpMessage = 'Permissions for a file. Permissions can be any subset of "rwd".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(ParameterSetName = 'NameSasPermission', ValueFromPipeline = $true, HelpMessage = 'Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'NameSasPolicy', ValueFromPipeline = $true, HelpMessage = 'Azure Storage Context Object')]
        [ValidateNotNull()]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageLocalUserPermissionScope
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Specify the permissions for the local user. Possible values include: Read(r), Write (w), Delete (d), List (l), and Create (c).')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(Mandatory = $true, HelpMessage = 'Specify the service used by the local user, e.g. blob, file.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Service},

        [Parameter(Mandatory = $true, HelpMessage = 'Specify the name of resource, normally the container name or the file share name, used by the local user.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceName},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageLocalUserPermissionScope', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageLocalUserSshPassword
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserName},

        [Parameter(ParameterSetName = 'UserObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'Local User Object to  Regenerate Password Keys.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageLocalUserSshPassword', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageLocalUserSshPublicKey
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Specify ssh public key, which is base64 encoded. The format should be: ''<keyType> <keyData>'', e.g. ssh-rsa AAAABBBB')]
        [ValidateNotNull()]
        [string]
        ${Key},

        [Parameter(HelpMessage = 'The description of the key. It is used to store the function/usage of the key.')]
        [ValidateNotNull()]
        [string]
        ${Description},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageLocalUserSshPublicKey', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageObjectReplicationPolicyRule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'The Source Container name to replicate from.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SourceContainer},

        [Parameter(Mandatory = $true, HelpMessage = 'The Destination Container name to replicate to.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestinationContainer},

        [Parameter(HelpMessage = 'Filters the results to replicate only blobs whose names begin with the specified prefix.')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PrefixMatch},

        [Parameter(HelpMessage = 'Blobs created after the time will be replicated to the destination..')]
        [ValidateNotNull()]
        [datetime]
        ${MinCreationTime},

        [Parameter(HelpMessage = 'Object Replication Rule Id.')]
        [string]
        ${RuleId},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\New-AzStorageObjectReplicationPolicyRule', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function New-AzStorageQueue
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue name')]
        [Alias('N', 'Queue')]
        [string]
        ${Name},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageQueueSASToken
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Queue')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'SasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'SasPermission', HelpMessage = 'Permissions for a container. Permissions can be any not-empty subset of "raup".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted from by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageQueueStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Queue},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier. Need to be unique in the Queue')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a queue. Permissions can be any not-empty subset of "arup".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Name of the file share to be created.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzStorageShareSASToken
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'SasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'SasPermission', HelpMessage = 'Permissions for a share. Permissions can be any subset of "rwdl".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [ValidateNotNull()]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageShareStoredAccessPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier. Need to be unique in the Share')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a share. Permissions can be any subset of "rwdl".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function New-AzStorageTable
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table name')]
        [Alias('N', 'Table')]
        [string]
        ${Name},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageTableSASToken
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Table')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'SasPolicy', Mandatory = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(ParameterSetName = 'SasPermission', HelpMessage = 'Permissions for a container. Permissions can be any not-empty subset of "audq".')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Protocol can be used in the request with this SAS token.')]
        [ValidateNotNull()]
        [System.Nullable[object]]
        ${Protocol},

        [Parameter(HelpMessage = 'IP, or IP range ACL (access control list) that the request would be accepted by Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${IPAddressOrRange},

        [Parameter(HelpMessage = 'Start Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [ValidateNotNull()]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Display full uri with sas token')]
        [switch]
        ${FullUri},

        [Parameter(HelpMessage = 'Start Partition Key')]
        [Alias('startpk')]
        [string]
        ${StartPartitionKey},

        [Parameter(HelpMessage = 'Start Row Key')]
        [Alias('startrk')]
        [string]
        ${StartRowKey},

        [Parameter(HelpMessage = 'End Partition Key')]
        [Alias('endpk')]
        [string]
        ${EndPartitionKey},

        [Parameter(HelpMessage = 'End Row Key')]
        [Alias('endrk')]
        [string]
        ${EndRowKey},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function New-AzStorageTableStoredAccessPolicy
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Table},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier. Need to be unique in the Table')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a table. Permissions can be any not-empty subset of "audqr".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzDataLakeGen2AclRecursive
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that to change Acl recursively. Can be a file or directory. In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to change Acl recursively from root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [string]
        ${ContinuationToken},

        [Parameter(Mandatory = $true, HelpMessage = 'The POSIX access control list to set recursively for the file or directory.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Acl},

        [Parameter(HelpMessage = 'Set this parameter to ignore failures and continue proceeing with the operation on other sub-entities of the directory. Default the operation will terminate quickly on encountering failures.')]
        [switch]
        ${ContinueOnFailure},

        [Parameter(HelpMessage = 'If data set size exceeds batch size then operation will be split into multiple requests so that progress can be tracked. Batch size should be between 1 and 2000. Default is 2000.')]
        [int]
        ${BatchSize},

        [Parameter(HelpMessage = 'Maximum number of batches that single change Access Control operation can execute. If data set size exceeds MaxBatchCount multiply BatchSize, continuation token will be return.')]
        [int]
        ${MaxBatchCount},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzDataLakeGen2Item
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be removed. Can be a file or directory In the format ''directory/file.txt'' or ''directory1/directory2/''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Item Object to remove.')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Force to remove the Item without any prompt.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'Return whether the specified FileSystem is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzRmStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [Alias('Container')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Force to remove the container and all content in it')]
        [switch]
        ${Force},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzRmStorageContainer', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzRmStorageContainerImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N')]
        [string]
        ${ContainerName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Alias('IfMatch')]
        [string]
        ${Etag},

        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'ImmutabilityPolicy Object to Remove')]
        [Alias('ImmutabilityPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzRmStorageContainerImmutabilityPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzRmStorageContainerLegalHold
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(Mandatory = $true, HelpMessage = 'Container LegalHold Tags')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${Tag},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzRmStorageContainerLegalHold', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzRmStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNameSnapshot', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNameSnapshot', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'AccountNameSnapshot', Mandatory = $true, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'AccountObjectSnapshot', Mandatory = $true, Position = 2, HelpMessage = 'Share Name')]
        [Alias('N', 'ShareName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectSnapshot', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ShareResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a File Share Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Share object')]
        [Alias('Share')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountNameSnapshot', Mandatory = $true, HelpMessage = 'Share SnapshotTime')]
        [Parameter(ParameterSetName = 'AccountObjectSnapshot', Mandatory = $true, HelpMessage = 'Share SnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[datetime]]
        ${SnapshotTime},

        [Parameter(HelpMessage = 'Force to remove the Share and all content in it')]
        [switch]
        ${Force},

        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Valid values are: snapshots, leased-snapshots, none. The default value is none. For ''snapshots'', the file share is deleted including all of its file share snapshots. If the file share contains leased - snapshots, the deletion fails.For ''leased-snapshots'', the file share is deleted included all of its file share snapshots(leased / unleased). For ''none'', the file share is deleted if it has no share snapshots.If the file share contains any snapshots(leased or unleased), the deletion fails.')]
        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Valid values are: snapshots, leased-snapshots, none. The default value is none. For ''snapshots'', the file share is deleted including all of its file share snapshots. If the file share contains leased - snapshots, the deletion fails.For ''leased-snapshots'', the file share is deleted included all of its file share snapshots(leased / unleased). For ''none'', the file share is deleted if it has no share snapshots.If the file share contains any snapshots(leased or unleased), the deletion fails.')]
        [Parameter(ParameterSetName = 'ShareResourceId', HelpMessage = 'Valid values are: snapshots, leased-snapshots, none. The default value is none. For ''snapshots'', the file share is deleted including all of its file share snapshots. If the file share contains leased - snapshots, the deletion fails.For ''leased-snapshots'', the file share is deleted included all of its file share snapshots(leased / unleased). For ''none'', the file share is deleted if it has no share snapshots.If the file share contains any snapshots(leased or unleased), the deletion fails.')]
        [Parameter(ParameterSetName = 'ShareObject', HelpMessage = 'Valid values are: snapshots, leased-snapshots, none. The default value is none. For ''snapshots'', the file share is deleted including all of its file share snapshots. If the file share contains leased - snapshots, the deletion fails.For ''leased-snapshots'', the file share is deleted included all of its file share snapshots(leased / unleased). For ''none'', the file share is deleted if it has no share snapshots.If the file share contains any snapshots(leased or unleased), the deletion fails.')]
        [ValidateSet('None', 'Snapshots', 'Leased-Snapshots')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Include},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzRmStorageShare', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageAccount
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to Delete the Storage Account')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageAccount', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageAccountManagementPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'Management Object to Remove')]
        [Alias('ManagementPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageAccountManagementPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageAccountNetworkRule
{
    [CmdletBinding(DefaultParameterSetName = 'NetWorkRuleString', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'IpRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule IPRules.')]
        [object[]]
        ${IPRule},

        [Parameter(ParameterSetName = 'NetworkRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule VirtualNetworkRules.')]
        [object[]]
        ${VirtualNetworkRule},

        [Parameter(ParameterSetName = 'ResourceAccessRuleObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule ResourceAccessRules.')]
        [object[]]
        ${ResourceAccessRule},

        [Parameter(ParameterSetName = 'IpRuleString', Mandatory = $true, HelpMessage = 'Storage Account NetworkRule IPRules IPAddressOrRange in string.')]
        [string[]]
        ${IPAddressOrRange},

        [Parameter(ParameterSetName = 'NetWorkRuleString', Mandatory = $true, HelpMessage = 'Storage Account NetworkRule VirtualNetworkRules VirtualNetworkResourceId in string.')]
        [Alias('SubnetId', 'VirtualNetworkId')]
        [string[]]
        ${VirtualNetworkResourceId},

        [Parameter(ParameterSetName = 'ResourceAccessRuleString', Mandatory = $true, HelpMessage = 'Storage Account ResourceAccessRule TenantId  in string.')]
        [string]
        ${TenantId},

        [Parameter(ParameterSetName = 'ResourceAccessRuleString', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account ResourceAccessRule ResourceId  in string.')]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageAccountNetworkRule', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageBlob
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('ICloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'BlobPipeline', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Only delete blob snapshots')]
        [switch]
        ${DeleteSnapshot},

        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'Blob SnapshotTime')]
        [Parameter(ParameterSetName = 'NamePipeline', HelpMessage = 'Blob SnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${SnapshotTime},

        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'Blob VersionId')]
        [Parameter(ParameterSetName = 'NamePipeline', HelpMessage = 'Blob VersionId')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VersionId},

        [Parameter(HelpMessage = 'Force to remove the blob and its snapshot')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Return whether the specified blob is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageBlobImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageBlobInventoryPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'BlobInventoryPolicy Object to Remove')]
        [Alias('BlobInventoryPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageBlobInventoryPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageContainer
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to remove the container and all content in it')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Return whether the specified container is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageContainerStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Return whether the specified policy is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageCORSRule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageDirectory
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the directory would be removed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the directory would be removed.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the base folder where the directory would be removed.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 1, HelpMessage = 'Path to the directory to be removed.')]
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Path to the directory to be removed.')]
        [Parameter(ParameterSetName = 'Directory', Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Path to the directory to be removed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Returns an object representing the removed directory. By default, this cmdlet does not generate any output.')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageFile
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the file would be removed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the file would be removed.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the cloud directory where the file would be removed.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFile object indicated the file to be removed.')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Path of the file to be removed.')]
        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 1, HelpMessage = 'Path of the file to be removed.')]
        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 1, HelpMessage = 'Path of the file to be removed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Returns an object representing the removed file. By default, this cmdlet does not generate any output.')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageLocalUser
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserName},

        [Parameter(ParameterSetName = 'UserObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'Local User Object to Remove')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageLocalUser', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageObjectReplicationPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Object Replication Policy Id.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Object Replication Policy Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${PolicyId},

        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Object Replication Policy object to Delete.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Remove-AzStorageObjectReplicationPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Remove-AzStorageQueue
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue name')]
        [Alias('N', 'Queue')]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to remove the queue and all content in it')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Return whether the specified queue is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzStorageQueueStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Queue},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Return whether the specified policy is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Name of the file share to be removed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'File share object to be removed.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Share', Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'File share Client to be removed.')]
        [ValidateNotNull()]
        [Azure.Storage.Files.Shares.ShareClient]
        ${ShareClient},

        [Parameter(HelpMessage = 'Remove File Share with all of its snapshots')]
        [switch]
        ${IncludeAllSnapshot},

        [Parameter(ParameterSetName = 'ShareName', ValueFromPipelineByPropertyName = $true, HelpMessage = 'SnapshotTime of the file share snapshot to be removed.')]
        [System.Nullable[System.DateTimeOffset]]
        ${SnapshotTime},

        [Parameter(HelpMessage = 'Force to remove the share with all its snapshots, and all content in them.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Returns an object representing the removed file share. By default, this cmdlet does not generate any output.')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageShareStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Return whether the specified policy is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Remove-AzStorageTable
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table name')]
        [Alias('N', 'Table')]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to remove the table and all content in it')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Return whether the specified table is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Remove-AzStorageTableStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Table},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Return whether the specified policy is successfully removed')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Rename-AzStorageDirectory
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the directory would be listed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'ShareClienr indicated the share where the directory would be listed.')]
        [ValidateNotNull()]
        [Azure.Storage.Files.Shares.ShareClient]
        ${ShareClient},

        [Parameter(ParameterSetName = 'DirecotryObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source directory instance')]
        [Azure.Storage.Files.Shares.ShareDirectoryClient]
        ${ShareDirectoryClient},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Path to an existing directory.')]
        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, Position = 1, HelpMessage = 'Path to an existing directory.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SourcePath},

        [Parameter(ParameterSetName = 'ShareName', Position = 2, HelpMessage = 'The destination path to rename the directory to.')]
        [Parameter(ParameterSetName = 'ShareObject', Position = 2, HelpMessage = 'The destination path to rename the directory to.')]
        [Parameter(ParameterSetName = 'DirecotryObject', Position = 2, HelpMessage = 'The destination path to rename the directory to.')]
        [string]
        ${DestinationPath},

        [Parameter(HelpMessage = 'If specified the permission (security descriptor) shall be set for the directory/file. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl.')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'Optional. Specifies whether the ReadOnly attribute on a preexisting destination file should be respected. If true, the rename will succeed, otherwise, a previous file at the destination with the ReadOnly attribute set will cause the rename to fail.')]
        [switch]
        ${IgnoreReadonly})


}


function Rename-AzStorageFile
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the file would be listed.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'FileObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source file instance')]
        [ValidateNotNull()]
        [Azure.Storage.Files.Shares.ShareFileClient]
        ${ShareFileClient},

        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'ShareClient indicated the share where the file would be listed.')]
        [ValidateNotNull()]
        [Azure.Storage.Files.Shares.ShareClient]
        ${ShareClient},

        [Parameter(ParameterSetName = 'DirecotryObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'ShareDirectoryClient indicated the share where the file would be listed.')]
        [ValidateNotNull()]
        [Azure.Storage.Files.Shares.ShareDirectoryClient]
        ${ShareDirectoryClient},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Path to an existing file.')]
        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, Position = 1, HelpMessage = 'Path to an existing file.')]
        [Parameter(ParameterSetName = 'DirecotryObject', Mandatory = $true, Position = 1, HelpMessage = 'Path to an existing file.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SourcePath},

        [Parameter(ParameterSetName = 'FileObject', Position = 1, HelpMessage = 'The destination path to rename the file to.')]
        [Parameter(ParameterSetName = 'ShareName', Position = 2, HelpMessage = 'The destination path to rename the file to.')]
        [Parameter(ParameterSetName = 'ShareObject', Position = 2, HelpMessage = 'The destination path to rename the file to.')]
        [Parameter(ParameterSetName = 'DirecotryObject', Position = 2, HelpMessage = 'The destination path to rename the file to.')]
        [string]
        ${DestinationPath},

        [Parameter(HelpMessage = 'Sets the MIME content type of the file. The default type is ''application/octet-stream''.')]
        [string]
        ${ContentType},

        [Parameter(HelpMessage = 'If specified the permission (security descriptor) shall be set for the directory/file. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl.')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'Optional. Specifies whether the ReadOnly attribute on a preexisting destination file should be respected. If true, the rename will succeed, otherwise, a previous file at the destination with the ReadOnly attribute set will cause the rename to fail.')]
        [switch]
        ${IgnoreReadonly})


}


function Restore-AzDataLakeGen2DeletedItem
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 1, ValueFromPipeline = $true, HelpMessage = 'The deleted item path in the specified FileSystem that should be restore. In the format ''directory/file.txt'' or ''directory1/directory2/''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 2, ValueFromPipeline = $true, HelpMessage = 'The deletion ID associated with the soft deleted path. You can get soft deleted paths and their assocaited deletion IDs with cmdlet ''Get-AzDataLakeGen2DeletedItem''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DeletionId},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Deleted Item Object to restore.')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Restore-AzRmStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Deleted Share object, which will be restored')]
        [Alias('Share')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Deleted Share Name, which will be restored.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Deleted Share Name, which will be restored.')]
        [Alias('N', 'ShareName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Deleted Share Version, which will be restored from.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Deleted Share Version, which will be restored from.')]
        [string]
        ${DeletedShareVersion},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Restore-AzRmStorageShare', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Restore-AzStorageBlobRange
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(Mandatory = $true, HelpMessage = 'The Time to Restore Blob.')]
        [ValidateNotNull()]
        [datetime]
        ${TimeToRestore},

        [Parameter(HelpMessage = 'The blob range to Restore.')]
        [ValidateNotNull()]
        [object[]]
        ${BlobRestoreRange},

        [Parameter(HelpMessage = 'Wait for Restore task complete')]
        [switch]
        ${WaitForComplete},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Restore-AzStorageBlobRange', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Restore-AzStorageContainer
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The name of the previously deleted container.')]
        [Alias('N', 'Container', 'DeletedContainerName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The version of the previously deleted container.')]
        [Alias('DeletedContainerVersion, ')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VersionId},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Revoke-AzStorageAccountUserDelegationKeys
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'The resource group name containing the storage account resource.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'The name of the storage account resource.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'A storage account object, returned by Get_AzStorageAccount, New-AzStorageAccount.')]
        [Alias('StorageAccount')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [Alias('StorageAccountResourceId')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Revoke-AzStorageAccountUserDelegationKeys', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzCurrentStorageAccount
{
    [CmdletBinding(DefaultParameterSetName = 'UsingResourceGroupAndNameParameterSet')]
    param(
        [Parameter(ParameterSetName = 'UsingStorageContext', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [object]
        ${Context},

        [Parameter(ParameterSetName = 'UsingResourceGroupAndNameParameterSet', Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'UsingResourceGroupAndNameParameterSet', Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzCurrentStorageAccount', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzDataLakeGen2AclRecursive
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that to change Acl recursively. Can be a file or directory. In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to change Acl recursively from root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [string]
        ${ContinuationToken},

        [Parameter(Mandatory = $true, HelpMessage = 'The POSIX access control list to set recursively for the file or directory.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Acl},

        [Parameter(HelpMessage = 'Set this parameter to ignore failures and continue proceeing with the operation on other sub-entities of the directory. Default the operation will terminate quickly on encountering failures.')]
        [switch]
        ${ContinueOnFailure},

        [Parameter(HelpMessage = 'If data set size exceeds batch size then operation will be split into multiple requests so that progress can be tracked. Batch size should be between 1 and 2000. Default is 2000.')]
        [int]
        ${BatchSize},

        [Parameter(HelpMessage = 'Maximum number of batches that single change Access Control operation can execute. If data set size exceeds MaxBatchCount multiply BatchSize, continuation token will be return.')]
        [int]
        ${MaxBatchCount},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Set-AzDataLakeGen2ItemAclObject
{
    [CmdletBinding()]
    param(
        [Parameter(HelpMessage = 'The user or group identifier. It is omitted for entries of AccessControlType "mask" and "other". The user or group identifier is also omitted for the owner and owning group.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EntityId},

        [Parameter(HelpMessage = 'Set this parameter to indicate the ACE belongs to the default ACL for a directory; otherwise scope is implicit and the ACE belongs to the access ACL.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${DefaultScope},

        [Parameter(Mandatory = $true, HelpMessage = 'The permission field is a 3-character sequence where the first character is ''r'' to grant read access, the second character is ''w'' to grant write access, and the third character is ''x'' to grant execute permission. If access is not granted, the ''-'' character is used to denote that the permission is denied. The sticky bit is also supported and its represented either by the letter t or T in the final character-place depending on whether the execution bit for the others category is set or unset respectively, absence of t or T indicates sticky bit not set.')]
        [ValidatePattern('[r-][w-][xtT-]')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'If input the PSPathAccessControlEntry[] object, will add the new ACL entry as a new element of the input PSPathAccessControlEntry[] object. If an ACL entry when same AccessControlType, EntityId, DefaultScope exist, will update permission of it.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${InputObject},

        [Parameter(Mandatory = $true, HelpMessage = 'There are four types: "user" grants rights to the owner or a named user, "group" grants rights to the owning group or a named group, "mask" restricts rights granted to named users and the members of groups, and "other" grants rights to all users not found in any of the other entries.')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('User', 'Group', 'Mask', 'Other')]
        [Azure.Storage.Files.DataLake.Models.AccessControlType]
        ${AccessControlType})


}


function Set-AzRmStorageContainerImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'ExtendAccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N')]
        [string]
        ${ContainerName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'ExtendAccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [Parameter(ParameterSetName = 'ExtendContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Container},

        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'ExtendImmutabilityPolicyObject', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('ImmutabilityPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ContainerObject', HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ExtendAccountObject', Mandatory = $true, HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ExtendContainerObject', Mandatory = $true, HelpMessage = 'Immutability period since creation in days.')]
        [Parameter(ParameterSetName = 'ExtendImmutabilityPolicyObject', Mandatory = $true, HelpMessage = 'Immutability period since creation in days.')]
        [Alias('ImmutabilityPeriodSinceCreationInDays')]
        [int]
        ${ImmutabilityPeriod},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'This property can only be changed for unlocked policies. When enabled, new blocks can be written to both ''Appened and Block Blobs'' while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. This property cannot be changed with ExtendImmutabilityPolicy API. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'This property can only be changed for unlocked policies. When enabled, new blocks can be written to both ''Appened and Block Blobs'' while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. This property cannot be changed with ExtendImmutabilityPolicy API. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'ContainerObject', HelpMessage = 'This property can only be changed for unlocked policies. When enabled, new blocks can be written to both ''Appened and Block Blobs'' while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. This property cannot be changed with ExtendImmutabilityPolicy API. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', HelpMessage = 'This property can only be changed for unlocked policies. When enabled, new blocks can be written to both ''Appened and Block Blobs'' while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. This property cannot be changed with ExtendImmutabilityPolicy API. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [bool]
        ${AllowProtectedAppendWriteAll},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'This property can only be changed for unlocked time-based retention policies. With this property enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'This property can only be changed for unlocked time-based retention policies. With this property enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'ContainerObject', HelpMessage = 'This property can only be changed for unlocked time-based retention policies. With this property enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [Parameter(ParameterSetName = 'ImmutabilityPolicyObject', HelpMessage = 'This property can only be changed for unlocked time-based retention policies. With this property enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. ''-AllowProtectedAppendWrites'' and ''-AllowProtectedAppendWritesAll'' are mutually exclusive.')]
        [bool]
        ${AllowProtectedAppendWrite},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ContainerObject', HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ExtendAccountObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Parameter(ParameterSetName = 'ExtendContainerObject', Mandatory = $true, HelpMessage = 'Immutability policy etag.')]
        [Alias('IfMatch')]
        [string]
        ${Etag},

        [Parameter(ParameterSetName = 'ExtendAccountName', Mandatory = $true, HelpMessage = 'Indicate ExtendPolicy to Extend an existing ImmutabilityPolicy.')]
        [Parameter(ParameterSetName = 'ExtendAccountObject', Mandatory = $true, HelpMessage = 'Indicate ExtendPolicy to Extend an existing ImmutabilityPolicy.')]
        [Parameter(ParameterSetName = 'ExtendContainerObject', Mandatory = $true, HelpMessage = 'Indicate ExtendPolicy to Extend an existing ImmutabilityPolicy.')]
        [Parameter(ParameterSetName = 'ExtendImmutabilityPolicyObject', Mandatory = $true, HelpMessage = 'Indicate ExtendPolicy to Extend an existing ImmutabilityPolicy.')]
        [switch]
        ${ExtendPolicy},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzRmStorageContainerImmutabilityPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageAccount
{
    [CmdletBinding(DefaultParameterSetName = 'StorageEncryption', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Force to Set the Account')]
        [switch]
        ${Force},

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Sku Name.')]
        [Alias('StorageAccountType', 'AccountType', 'Type')]
        [ValidateSet('Standard_LRS', 'Standard_ZRS', 'Standard_GRS', 'Standard_RAGRS', 'Premium_LRS', 'Standard_GZRS', 'Standard_RAGZRS')]
        [string]
        ${SkuName},

        [Parameter(HelpMessage = 'Storage Account Access Tier.')]
        [ValidateSet('Hot', 'Cool')]
        [string]
        ${AccessTier},

        [Parameter(HelpMessage = 'Storage Account Custom Domain.')]
        [ValidateNotNull()]
        [string]
        ${CustomDomainName},

        [Parameter(HelpMessage = 'To Use Sub Domain.')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[bool]]
        ${UseSubDomain},

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Tags.')]
        [Alias('Tags')]
        [AllowEmptyCollection()]
        [ValidateNotNull()]
        [hashtable]
        ${Tag},

        [Parameter(HelpMessage = 'Storage Account EnableHttpsTrafficOnly.')]
        [bool]
        ${EnableHttpsTrafficOnly},

        [Parameter(ParameterSetName = 'StorageEncryption', HelpMessage = 'Whether to set Storage Account Encryption KeySource to Microsoft.Storage or not.')]
        [switch]
        ${StorageEncryption},

        [Parameter(ParameterSetName = 'KeyvaultEncryption', HelpMessage = 'Whether to set Storage Account encryption keySource to Microsoft.Keyvault or not. If you specify KeyName, KeyVersion and KeyvaultUri, Storage Account Encryption KeySource will also be set to Microsoft.Keyvault weather this parameter is set or not.')]
        [switch]
        ${KeyvaultEncryption},

        [Parameter(ParameterSetName = 'KeyvaultEncryption', Mandatory = $true, HelpMessage = 'Storage Account encryption keySource KeyVault KeyName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyName},

        [Parameter(ParameterSetName = 'KeyvaultEncryption', HelpMessage = 'Storage Account encryption keySource KeyVault KeyVersion')]
        [ValidateNotNull()]
        [string]
        ${KeyVersion},

        [Parameter(ParameterSetName = 'KeyvaultEncryption', Mandatory = $true, HelpMessage = 'Storage Account encryption keySource KeyVault KeyVaultUri')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyVaultUri},

        [Parameter(HelpMessage = 'Generate and assign a new Storage Account Identity for this storage account for use with key management services like Azure KeyVault.')]
        [switch]
        ${AssignIdentity},

        [Parameter(HelpMessage = 'Set resource ids for the the new Storage Account user assignedd Identity, the identity will be used with key management services like Azure KeyVault.')]
        [ValidateNotNull()]
        [string]
        ${UserAssignedIdentityId},

        [Parameter(HelpMessage = 'Set resource id for user assigned Identity used to access Azure KeyVault of Storage Account Encryption, the id must in the storage account''s UserAssignIdentityId.')]
        [ValidateNotNull()]
        [string]
        ${KeyVaultUserAssignedIdentityId},

        [Parameter(HelpMessage = 'Set ClientId of the multi-tenant application to be used in conjunction with the user-assigned identity for cross-tenant customer-managed-keys server-side encryption on the storage account.')]
        [ValidateNotNull()]
        [string]
        ${KeyVaultFederatedClientId},

        [Parameter(HelpMessage = 'Set the new Storage Account Identity type, the idenetity is for use with key management services like Azure KeyVault.')]
        [ValidateSet('SystemAssigned', 'UserAssigned', 'SystemAssignedUserAssigned', 'None')]
        [string]
        ${IdentityType},

        [Parameter(HelpMessage = 'Storage Account NetworkRule')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${NetworkRuleSet},

        [Parameter(HelpMessage = 'Upgrade Storage Account Kind to StorageV2.')]
        [switch]
        ${UpgradeToStorageV2},

        [Parameter(ParameterSetName = 'StorageEncryption', HelpMessage = 'Enable Azure Files Azure Active Directory Domain Service Authentication for the storage account.')]
        [Parameter(ParameterSetName = 'KeyvaultEncryption', HelpMessage = 'Enable Azure Files Azure Active Directory Domain Service Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableAzureActiveDirectoryDomainServicesForFile},

        [Parameter(HelpMessage = 'Indicates whether or not the storage account can support large file shares with more than 5 TiB capacity. Once the account is enabled, the feature cannot be disabled. Currently only supported for LRS and ZRS replication types, hence account conversions to geo-redundant accounts would not be possible. Learn more in https://go.microsoft.com/fwlink/?linkid=2086047')]
        [switch]
        ${EnableLargeFileShare},

        [Parameter(HelpMessage = 'Indicates whether microsoft routing storage endpoints are to be published')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PublishMicrosoftEndpoint},

        [Parameter(HelpMessage = 'Indicates whether internet  routing storage endpoints are to be published')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${PublishInternetEndpoint},

        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', HelpMessage = 'Enable Azure Files Active Directory Domain Service Kerberos Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableAzureActiveDirectoryKerberosForFile},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', Mandatory = $true, HelpMessage = 'Enable Azure Files Active Directory Domain Service Authentication for the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableActiveDirectoryDomainServicesForFile},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the primary domain that the AD DNS server is authoritative for. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', HelpMessage = 'Specifies the primary domain that the AD DNS server is authoritative for. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [ValidateNotNull()]
        [string]
        ${ActiveDirectoryDomainName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the NetBIOS domain name. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryNetBiosDomainName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory forest to get. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryForestName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the domain GUID. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [Parameter(ParameterSetName = 'AzureActiveDirectoryKerberosForFile', HelpMessage = 'Specifies the domain GUID. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile or -EnableAzureActiveDirectoryKerberosForFile is set to true.')]
        [ValidateNotNull()]
        [string]
        ${ActiveDirectoryDomainGuid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the security identifier (SID). This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryDomainSid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the security identifier (SID) for Azure Storage. This parameter must be set when -EnableActiveDirectoryDomainServicesForFile is set to true.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryAzureStorageSid},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory SAMAccountName for Azure Storage.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectorySamAccountName},

        [Parameter(ParameterSetName = 'ActiveDirectoryDomainServicesForFile', HelpMessage = 'Specifies the Active Directory account type for Azure Storage. Possible values include: ''User'', ''Computer''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ActiveDirectoryAccountType},

        [Parameter(HelpMessage = 'Allow or disallow public access to all blobs or containers in the storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowBlobPublicAccess},

        [Parameter(HelpMessage = 'The minimum TLS version to be permitted on requests to storage.')]
        [ValidateSet('TLS1_0', 'TLS1_1', 'TLS1_2')]
        [string]
        ${MinimumTlsVersion},

        [Parameter(HelpMessage = 'Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is null, which is equivalent to true.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowSharedKeyAccess},

        [Parameter(HelpMessage = 'The SAS expiration period of this account, it is a timespan and accurate to seconds.')]
        [timespan]
        ${SasExpirationPeriod},

        [Parameter(HelpMessage = 'The Key expiration period of this account, it is accurate to days.')]
        [int]
        ${KeyExpirationPeriodInDay},

        [Parameter(HelpMessage = 'Gets or sets allow or disallow cross AAD tenant object replication. The default interpretation is true for this property.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${AllowCrossTenantReplication},

        [Parameter(HelpMessage = 'Default share permission for users using Kerberos authentication if RBAC role is not assigned.')]
        [ValidateSet('None', 'StorageFileDataSmbShareContributor', 'StorageFileDataSmbShareReader', 'StorageFileDataSmbShareElevatedContributor')]
        [string]
        ${DefaultSharePermission},

        [Parameter(HelpMessage = 'Allow or disallow public network access to Storage Account.Possible values include: ''Enabled'', ''Disabled''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${PublicNetworkAccess},

        [Parameter(HelpMessage = 'The immutability period for the blobs in the container since the policy creation in days. This property can only be changed when account is created with ''-EnableAccountLevelImmutability''.')]
        [int]
        ${ImmutabilityPeriod},

        [Parameter(HelpMessage = 'The mode of the policy. Possible values include: ''Unlocked'', ''Locked'', ''Disabled. Disabled state disablesthe policy. Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property. Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted. This property can only be changed when account is created with ''-EnableAccountLevelImmutability''.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ImmutabilityPolicyState},

        [Parameter(HelpMessage = 'Enable Secure File Transfer Protocol for the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableSftp},

        [Parameter(HelpMessage = 'Enable local users feature for the Storage account.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableLocalUser},

        [Parameter(HelpMessage = 'Set restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values include: ''PrivateLink'', ''AAD''')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${AllowedCopyScope},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'Routing Choice defines the kind of network routing opted by the user. Possible values include: ''MicrosoftRouting'', ''InternetRouting''')]
        [ValidateSet('MicrosoftRouting', 'InternetRouting')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${RoutingChoice})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageAccount', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageAccountManagementPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountNamePolicyRule', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObjectPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountResourceIdPolicyRule', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyObject', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Management Policy rules. Get the object with New-AzStorageAccountManagementPolicyRule cmdlet.')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Management Policy rules. Get the object with New-AzStorageAccountManagementPolicyRule cmdlet.')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Management Policy rules. Get the object with New-AzStorageAccountManagementPolicyRule cmdlet.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Rule},

        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Management Policy Object to Set')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Management Policy Object to Set')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Management Policy Object to Set')]
        [Alias('ManagementPolicy')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Policy},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageAccountManagementPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageBlobContent
{
    [CmdletBinding(DefaultParameterSetName = 'SendManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'SendManual', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'file Path.')]
        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'file Path.')]
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, Position = 0, HelpMessage = 'file Path.')]
        [Alias('FullName')]
        [string]
        ${File},

        [Parameter(ParameterSetName = 'SendManual', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [string]
        ${Container},

        [Parameter(ParameterSetName = 'SendManual', HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'ContainerPipeline', HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Blob Container Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Blob Object')]
        [Alias('ICloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(HelpMessage = 'Blob Type(''Block'', ''Page'', ''Append'')')]
        [ValidateSet('Block', 'Page', 'Append')]
        [string]
        ${BlobType},

        [Parameter(HelpMessage = 'Blob Properties')]
        [hashtable]
        ${Properties},

        [Parameter(HelpMessage = 'Blob Metadata')]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Blob Tags')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        ${Tag},

        [Parameter(HelpMessage = 'Premium Page Blob Tier')]
        [object]
        ${PremiumPageBlobTier},

        [Parameter(HelpMessage = 'Block Blob Tier, valid values are Hot/Cool/Archive. See detail in https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StandardBlobTier},

        [Parameter(HelpMessage = 'Encryption scope to be used when making requests to the blob.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScope},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageBlobImmutabilityPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Mandatory = $true, HelpMessage = 'Blob ImmutabilityPolicy ExpiresOn')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${ExpiresOn},

        [Parameter(HelpMessage = 'Blob ImmutabilityPolicy PolicyMode')]
        [ValidateSet('Unlocked', 'Locked', 'Mutable')]
        [string]
        ${PolicyMode},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageBlobInventoryPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountNamePolicyRule', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObjectPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'AccountResourceIdPolicyRule', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyObject', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'AccountNamePolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Blob Inventory  Policy rules. Get the object with New-AzStorageBlobInventoryPolicyRule cmdlet.')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Blob Inventory  Policy rules. Get the object with New-AzStorageBlobInventoryPolicyRule cmdlet.')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyRule', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'The Blob Inventory  Policy rules. Get the object with New-AzStorageBlobInventoryPolicyRule cmdlet.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Rule},

        [Parameter(ParameterSetName = 'AccountNamePolicyRule', HelpMessage = 'The Blob Inventory Policy is enabled by default, specify this parameter to disable it.')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyRule', HelpMessage = 'The Blob Inventory Policy is enabled by default, specify this parameter to disable it.')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyRule', HelpMessage = 'The Blob Inventory Policy is enabled by default, specify this parameter to disable it.')]
        [switch]
        ${Disabled},

        [Parameter(ParameterSetName = 'AccountNamePolicyObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Blob Inventory Policy Object to Set')]
        [Parameter(ParameterSetName = 'AccountObjectPolicyObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Blob Inventory Policy Object to Set')]
        [Parameter(ParameterSetName = 'AccountResourceIdPolicyObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Blob Inventory Policy Object to Set')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Policy},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageBlobInventoryPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageBlobLegalHold
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipelineEnable', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipelineEnable', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [Parameter(ParameterSetName = 'BlobPipelineDisable', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'NamePipelineEnable', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipelineDisable', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipelineEnable', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [Parameter(ParameterSetName = 'NamePipelineDisable', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(ParameterSetName = 'NamePipelineEnable', Mandatory = $true, HelpMessage = 'Enable LegalHold on the Blob.')]
        [Parameter(ParameterSetName = 'BlobPipelineEnable', Mandatory = $true, HelpMessage = 'Enable LegalHold on the Blob.')]
        [switch]
        ${EnableLegalHold},

        [Parameter(ParameterSetName = 'NamePipelineDisable', Mandatory = $true, HelpMessage = 'Disable LegalHold on the Blob.')]
        [Parameter(ParameterSetName = 'BlobPipelineDisable', Mandatory = $true, HelpMessage = 'Disable LegalHold on the Blob.')]
        [switch]
        ${DisableLegalHold},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageBlobTag
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Mandatory = $true, HelpMessage = 'Blob Tags')]
        [ValidateNotNull()]
        [hashtable]
        ${Tag},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageContainerAcl
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'Container')]
        [string]
        ${Name},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Permission string Off/Blob/Container')]
        [Alias('PublicAccess')]
        [object]
        ${Permission},

        [Parameter(HelpMessage = 'Display Container Information')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageContainerStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a container. Permissions can be any non-empty subset of "racwdxlt", make the permission order also same as it.')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Set StartTime as null for the policy')]
        [switch]
        ${NoStartTime},

        [Parameter(HelpMessage = 'Set ExpiryTime as null for the policy')]
        [switch]
        ${NoExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageCORSRule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(Mandatory = $true, HelpMessage = 'CorsRule instances to represent rules to be set.')]
        [ValidateNotNull()]
        [object[]]
        ${CorsRules},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageFileContent
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Name of the file share where the file would be uploaded to.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share where the file would be uploaded to.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(ParameterSetName = 'Directory', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileDirectory object indicated the cloud directory where the file would be uploaded.')]
        [Alias('CloudFileDirectory')]
        [ValidateNotNull()]
        [object]
        ${Directory},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Path to the local file to be uploaded.')]
        [Alias('FullName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Source},

        [Parameter(Position = 2, HelpMessage = 'Path to the cloud file which would be uploaded to.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Returns an object representing the downloaded cloud file. By default, this cmdlet does not generate any output.')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageFileContent', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageLocalUser
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(Mandatory = $true, HelpMessage = 'The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${UserName},

        [Parameter(HelpMessage = 'Local user home directory')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${HomeDirectory},

        [Parameter(HelpMessage = 'Local user ssh authorized keys for SFTP. Get the object with New-AzStorageLocalUserSshPublicKey cmdlet.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${SshAuthorizedKey},

        [Parameter(HelpMessage = 'The permission scopes of the local user. Get the object with New-AzStorageLocalUserPermissionScope cmdlet.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${PermissionScope},

        [Parameter(HelpMessage = 'Whether shared key exists. Set it to false to remove existing shared key.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${HasSharedKey},

        [Parameter(HelpMessage = 'Whether SSH key exists. Set it to false to remove existing SSH key.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${HasSshKey},

        [Parameter(HelpMessage = 'Whether SSH password exists. Set it to false to remove existing SSH password.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${HasSshPassword},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageLocalUser', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageObjectReplicationPolicy
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'PolicyObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Object Replication Policy Object to Set to the specified Account.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Object Replication Policy Id. It should be a GUID or ''default''. If not input the PolicyId, will use ''default'', which means to create a new policy and the Id of the new policy will be returned in the created policy.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Object Replication Policy Id. It should be a GUID or ''default''. If not input the PolicyId, will use ''default'', which means to create a new policy and the Id of the new policy will be returned in the created policy.')]
        [ValidatePattern('(\{|\()?[A-Za-z0-9]{4}([A-Za-z0-9]{4}\-?){4}[A-Za-z0-9]{12}(\}|\()?|default')]
        [string]
        ${PolicyId},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Object Replication Policy SourceAccount. It should be resource id if storage account property allowCrossTenantReplication set to false.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Object Replication Policy SourceAccount. It should be resource id if storage account property allowCrossTenantReplication set to false.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SourceAccount},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Object Replication Policy DestinationAccount, if SourceAccount is account name it should be account name, else should be account resource id. Default value will be the input StorageAccountName, or the resouceID of the account.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Object Replication Policy DestinationAccount, if SourceAccount is account name it should be account name, else should be account resource id. Default value will be the account name, or resource ID of the input account object.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestinationAccount},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Object Replication Policy Rules.')]
        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Object Replication Policy Rules.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Rule},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Set-AzStorageObjectReplicationPolicy', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Set-AzStorageQueueStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Queue Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Queue},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a queue. Permissions can be any not-empty subset of "arup".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Set StartTime as null for the policy')]
        [switch]
        ${NoStartTime},

        [Parameter(HelpMessage = 'Set ExpiryTime as null for the policy')]
        [switch]
        ${NoExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Set-AzStorageServiceLoggingProperty
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(HelpMessage = 'Logging version')]
        [System.Nullable[double]]
        ${Version},

        [Parameter(HelpMessage = 'Logging retention days. -1 means disable Logging retention policy, otherwise enable.')]
        [ValidateRange(-1, 365)]
        [System.Nullable[int]]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Logging operations. (All, None, combinations of Read, Write, Delete that are separated by semicolon.)')]
        [object[]]
        ${LoggingOperations},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Set-AzStorageServiceMetricsProperty
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Azure storage service metrics type(Hour, Minute).')]
        [object]
        ${MetricsType},

        [Parameter(HelpMessage = 'Metrics version')]
        [System.Nullable[double]]
        ${Version},

        [Parameter(HelpMessage = 'Metrics retention days. -1 means disable Metrics retention policy, otherwise enable.')]
        [ValidateRange(-1, 365)]
        [System.Nullable[int]]
        ${RetentionDays},

        [Parameter(HelpMessage = 'Metrics level.(None/Service/ServiceAndApi)')]
        [System.Nullable[object]]
        ${MetricsLevel},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Set-AzStorageShareQuota
{
    [CmdletBinding(DefaultParameterSetName = 'ShareName')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'Share', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudFileShare object indicated the share whose quota to set.')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${Share},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Share Quota')]
        [Alias('QuotaGiB')]
        [int]
        ${Quota},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageShareStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Share name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a share. Permissions can be any non-empty subset of "rwdl".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expiry Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Set StartTime as null for the policy')]
        [switch]
        ${NoStartTime},

        [Parameter(HelpMessage = 'Set ExpiryTime as null for the policy')]
        [switch]
        ${NoExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Set-AzStorageTableStoredAccessPolicy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Table Name')]
        [Alias('N', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Table},

        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Policy Identifier')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Policy},

        [Parameter(HelpMessage = 'Permissions for a table. Permissions can be any not-empty subset of "audqr".')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Start Time')]
        [System.Nullable[datetime]]
        ${StartTime},

        [Parameter(HelpMessage = 'Expirty Time')]
        [System.Nullable[datetime]]
        ${ExpiryTime},

        [Parameter(HelpMessage = 'Set StartTime as null for the policy')]
        [switch]
        ${NoStartTime},

        [Parameter(HelpMessage = 'Set ExpiryTime as null for the policy')]
        [switch]
        ${NoExpiryTime},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Start-AzStorageBlobCopy
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('SrcICloudBlob', 'SrcCloudBlob', 'ICloudBlob', 'SourceICloudBlob', 'SourceCloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'BlobBaseClient Object')]
        [ValidateNotNull()]
        [Azure.Storage.Blobs.Specialized.BlobBaseClient]
        ${BlobBaseClient},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [Alias('SourceCloudBlobContainer')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Alias('SourceBlob')]
        [string]
        ${SrcBlob},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source Container name')]
        [Alias('SourceContainer')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcContainer},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source share name')]
        [Alias('SourceShareName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcShareName},

        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source share')]
        [Alias('SourceShare')]
        [ValidateNotNull()]
        [object]
        ${SrcShare},

        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Source file directory')]
        [Alias('SourceDir')]
        [ValidateNotNull()]
        [object]
        ${SrcDir},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source file path')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source file path')]
        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Source file path')]
        [Alias('SourceFilePath')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcFilePath},

        [Parameter(ParameterSetName = 'FileInstance', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Source file')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Source file')]
        [Alias('SourceFile')]
        [ValidateNotNull()]
        [object]
        ${SrcFile},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob uri')]
        [Alias('SrcUri', 'SourceUri')]
        [string]
        ${AbsoluteUri},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'DirInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'FileInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Alias('DestinationContainer')]
        [string]
        ${DestContainer},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ShareName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ShareInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'DirInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'FileInstance', HelpMessage = 'Destination blob name')]
        [Alias('DestinationBlob')]
        [string]
        ${DestBlob},

        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, HelpMessage = 'Destination CloudBlob object')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', Mandatory = $true, HelpMessage = 'Destination CloudBlob object')]
        [Alias('DestICloudBlob', 'DestinationCloudBlob', 'DestinationICloudBlob')]
        [object]
        ${DestCloudBlob},

        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', HelpMessage = 'Premium Page Blob Tier')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Premium Page Blob Tier')]
        [object]
        ${PremiumPageBlobTier},

        [Parameter(HelpMessage = 'Block Blob Tier, valid values are Hot/Cool/Archive. See detail in https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StandardBlobTier},

        [Parameter(HelpMessage = 'Block Blob RehydratePriority. Indicates the priority with which to rehydrate an archived blob. Valid values are High/Standard.')]
        [ValidateSet('Standard', 'High')]
        [object]
        ${RehydratePriority},

        [Parameter(HelpMessage = 'Blob Tags')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        ${Tag},

        [Parameter(ParameterSetName = 'ContainerName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ContainerInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'DirInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'FileInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'FileInstanceToBlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Source Azure Storage Context Object')]
        [Alias('SrcContext', 'SourceContext')]
        [object]
        ${Context},

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = 'Destination Storage context object')]
        [Alias('DestinationContext')]
        [object]
        ${DestContext},

        [Parameter(HelpMessage = 'Optional Query statement to apply to the Tags of the Destination Blob. The blob request will fail when the destiantion blob tags not match the given tag conditions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestTagCondition},

        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Optional Query statement to apply to the Tags of the Blob. The blob request will fail when the blob tags not match the given tag conditions.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(HelpMessage = 'Force to overwrite the existing blob or file')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Start-AzStorageBlobIncrementalCopy
{
    [CmdletBinding(DefaultParameterSetName = 'ContainerInstance', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('SrcICloudBlob', 'SrcCloudBlob', 'ICloudBlob', 'SourceICloudBlob', 'SourceCloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [Alias('SourceCloudBlobContainer')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Blob name')]
        [Alias('SourceBlob')]
        [string]
        ${SrcBlob},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source Container name')]
        [Alias('SourceContainer')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcContainer},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Source Blob Snapshot Time')]
        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source Blob Snapshot Time')]
        [Alias('SourceBlobSnapshotTime')]
        [ValidateNotNullOrEmpty()]
        [System.Nullable[System.DateTimeOffset]]
        ${SrcBlobSnapshotTime},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob uri')]
        [Alias('SrcUri', 'SourceUri')]
        [string]
        ${AbsoluteUri},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'BlobInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Destination container name')]
        [Alias('DestinationContainer')]
        [string]
        ${DestContainer},

        [Parameter(ParameterSetName = 'UriPipeline', Mandatory = $true, HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'BlobInstance', HelpMessage = 'Destination blob name')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Destination blob name')]
        [Alias('DestinationBlob')]
        [string]
        ${DestBlob},

        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', Mandatory = $true, HelpMessage = 'Destination CloudBlob object')]
        [Alias('DestICloudBlob', 'DestinationCloudBlob', 'DestinationICloudBlob')]
        [object]
        ${DestCloudBlob},

        [Parameter(ParameterSetName = 'ContainerName', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'BlobInstanceToBlobInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ContainerInstance', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'UriPipeline', HelpMessage = 'Source Azure Storage Context Object')]
        [Alias('SrcContext', 'SourceContext')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'Destination Storage context object')]
        [Alias('DestinationContext')]
        [object]
        ${DestContext},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Start-AzStorageFileCopy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source blob name')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Source blob name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcBlobName},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Source container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcContainerName},

        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Source container instance')]
        [ValidateNotNull()]
        [object]
        ${SrcContainer},

        [Parameter(ParameterSetName = 'BlobInstanceFilePath', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob instance')]
        [Parameter(ParameterSetName = 'BlobInstanceFileInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source blob instance')]
        [Alias('ICloudBlob')]
        [ValidateNotNull()]
        [object]
        ${SrcBlob},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source file path')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source file path')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcFilePath},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Source share name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${SrcShareName},

        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Source share instance')]
        [Alias('CloudFileShare')]
        [ValidateNotNull()]
        [object]
        ${SrcShare},

        [Parameter(ParameterSetName = 'FileInstanceToFilePath', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source file instance')]
        [Parameter(ParameterSetName = 'FileInstanceToFileInstance', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source file instance')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${SrcFile},

        [Parameter(ParameterSetName = 'UriToFilePath', Mandatory = $true, HelpMessage = 'Source Uri')]
        [Parameter(ParameterSetName = 'UriToFileInstance', Mandatory = $true, HelpMessage = 'Source Uri')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${AbsoluteUri},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'BlobInstanceFilePath', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'FileInstanceToFilePath', Mandatory = $true, HelpMessage = 'Dest share name')]
        [Parameter(ParameterSetName = 'UriToFilePath', Mandatory = $true, HelpMessage = 'Dest share name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestShareName},

        [Parameter(ParameterSetName = 'ContainerName', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'ContainerInstance', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'BlobInstanceFilePath', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'ShareInstance', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'FileInstanceToFilePath', Mandatory = $true, HelpMessage = 'Dest file path')]
        [Parameter(ParameterSetName = 'UriToFilePath', Mandatory = $true, HelpMessage = 'Dest file path')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DestFilePath},

        [Parameter(ParameterSetName = 'BlobInstanceFileInstance', Mandatory = $true, HelpMessage = 'Dest file instance')]
        [Parameter(ParameterSetName = 'FileInstanceToFileInstance', Mandatory = $true, HelpMessage = 'Dest file instance')]
        [Parameter(ParameterSetName = 'UriToFileInstance', Mandatory = $true, HelpMessage = 'Dest file instance')]
        [ValidateNotNull()]
        [object]
        ${DestFile},

        [Parameter(ParameterSetName = 'ContainerName', ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Parameter(ParameterSetName = 'ShareName', ValueFromPipelineByPropertyName = $true, HelpMessage = 'Source Azure Storage Context Object')]
        [Alias('SrcContext')]
        [object]
        ${Context},

        [Parameter(ParameterSetName = 'ContainerName', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'ContainerInstance', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'BlobInstanceFilePath', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'ShareName', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'ShareInstance', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'FileInstanceToFilePath', HelpMessage = 'Destination Storage context object')]
        [Parameter(ParameterSetName = 'UriToFilePath', HelpMessage = 'Destination Storage context object')]
        [object]
        ${DestContext},

        [Parameter(HelpMessage = 'Force to overwrite the existing file.')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Stop-AzStorageAccountHierarchicalNamespaceUpgrade
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Force to Failover the Account')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Display the storage account.')]
        [switch]
        ${PassThru},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Stop-AzStorageAccountHierarchicalNamespaceUpgrade', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Stop-AzStorageBlobCopy
{
    [CmdletBinding(DefaultParameterSetName = 'NamePipeline', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'BlobPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlob Object')]
        [Alias('ICloudBlob')]
        [object]
        ${CloudBlob},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'CloudBlobContainer Object')]
        [object]
        ${CloudBlobContainer},

        [Parameter(ParameterSetName = 'ContainerPipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 0, HelpMessage = 'Blob name')]
        [string]
        ${Blob},

        [Parameter(ParameterSetName = 'NamePipeline', Mandatory = $true, Position = 1, HelpMessage = 'Container name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Container},

        [Parameter(HelpMessage = 'Force to stop the current copy task on the specified blob')]
        [switch]
        ${Force},

        [Parameter(HelpMessage = 'Copy Id')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${CopyId},

        [Parameter(HelpMessage = 'Optional Tag expression statement to check match condition. The blob request will fail when the blob tags does not match the given expression.See details in https://learn.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${TagCondition},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Stop-AzStorageFileCopy
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 0, HelpMessage = 'Target share name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ShareName},

        [Parameter(ParameterSetName = 'ShareName', Mandatory = $true, Position = 1, HelpMessage = 'Target file path')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FilePath},

        [Parameter(ParameterSetName = 'File', Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Target file instance')]
        [Alias('CloudFile')]
        [ValidateNotNull()]
        [object]
        ${File},

        [Parameter(HelpMessage = 'Copy Id')]
        [string]
        ${CopyId},

        [Parameter(HelpMessage = 'Whether to stop the copy when copy id is different with the one input.')]
        [switch]
        ${Force},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The server time out for each request in seconds.')]
        [Alias('ServerTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ServerTimeoutPerRequest},

        [Parameter(HelpMessage = 'The client side maximum execution time for each request in seconds.')]
        [Alias('ClientTimeoutPerRequestInSeconds')]
        [System.Nullable[int]]
        ${ClientTimeoutPerRequest},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'The total amount of concurrent async tasks. The default value is 10.')]
        [ValidateNotNull()]
        [ValidateRange(1, 1000)]
        [System.Nullable[int]]
        ${ConcurrentTaskCount})


}


function Update-AzDataLakeGen2AclRecursive
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(Position = 1, ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that to change Acl recursively. Can be a file or directory. In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to change Acl recursively from root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(HelpMessage = 'Continuation Token.')]
        [string]
        ${ContinuationToken},

        [Parameter(Mandatory = $true, HelpMessage = 'The POSIX access control list to set recursively for the file or directory.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Acl},

        [Parameter(HelpMessage = 'Set this parameter to ignore failures and continue proceeing with the operation on other sub-entities of the directory. Default the operation will terminate quickly on encountering failures.')]
        [switch]
        ${ContinueOnFailure},

        [Parameter(HelpMessage = 'If data set size exceeds batch size then operation will be split into multiple requests so that progress can be tracked. Batch size should be between 1 and 2000. Default is 2000.')]
        [int]
        ${BatchSize},

        [Parameter(HelpMessage = 'Maximum number of batches that single change Access Control operation can execute. If data set size exceeds MaxBatchCount multiply BatchSize, continuation token will be return.')]
        [int]
        ${MaxBatchCount},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Update-AzDataLakeGen2Item
{
    [CmdletBinding(DefaultParameterSetName = 'ReceiveManual', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ReceiveManual', Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'FileSystem name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${FileSystem},

        [Parameter(ParameterSetName = 'ReceiveManual', ValueFromPipeline = $true, HelpMessage = 'The path in the specified FileSystem that should be updated. Can be a file or directory In the format ''directory/file.txt'' or ''directory1/directory2/''. Skip set this parameter to update the root directory of the Filesystem.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Parameter(ParameterSetName = 'ItemPipeline', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Azure Datalake Gen2 Item Object to update')]
        [ValidateNotNull()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Sets POSIX access permissions for the file owner, the file owning group, and others. Each class may be granted read, write, or execute permission. Symbolic (rwxrw-rw-) is supported.The sticky bit is also supported and its represented either by the letter t or T in the final character-place depending on whether the execution bit for the others category is set or unset respectively, absence of t or T indicates sticky bit not set.Invalid in conjunction with ACL.')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('([r-][w-][x-]){2}[r-][w-][xtT-]')]
        [string]
        ${Permission},

        [Parameter(HelpMessage = 'Sets the owner of the item.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Owner},

        [Parameter(HelpMessage = 'Sets the owning group of the item.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Group},

        [Parameter(HelpMessage = 'Specifies properties for the directory or file. The supported properties for file are: CacheControl, ContentDisposition, ContentEncoding, ContentLanguage, ContentMD5, ContentType.The supported properties for directory are: CacheControl, ContentDisposition, ContentEncoding, ContentLanguage.')]
        [hashtable]
        ${Property},

        [Parameter(HelpMessage = 'Specifies metadata for the directory or file.')]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Sets POSIX access control rights on files and directories. Create this object with New-AzDataLakeGen2ItemAclObject.')]
        [ValidateNotNullOrEmpty()]
        [object[]]
        ${Acl},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}


function Update-AzRmStorageContainer
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Container Name')]
        [Alias('N', 'ContainerName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ContainerObject', Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage container object')]
        [Alias('Container')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Container PublicAccess')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${PublicAccess},

        [Parameter(HelpMessage = 'Container Metadata')]
        [AllowEmptyCollection()]
        [ValidateNotNull()]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Sets reduction of the access rights for the remote superuser. Possible values include: ''NoRootSquash'', ''RootSquash'', ''AllSquash''')]
        [ValidateSet('NoRootSquash', 'RootSquash', 'AllSquash')]
        [string]
        ${RootSquash},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzRmStorageContainer', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzRmStorageShare
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Share Name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 2, HelpMessage = 'Share Name')]
        [Alias('N', 'ShareName')]
        [string]
        ${Name},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'ShareResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a File Share Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(ParameterSetName = 'ShareObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage Share object')]
        [Alias('Share')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(HelpMessage = 'Share Quota in Gibibyte.')]
        [Alias('Quota')]
        [int]
        ${QuotaGiB},

        [Parameter(HelpMessage = 'Share Metadata')]
        [AllowEmptyCollection()]
        [ValidateNotNull()]
        [hashtable]
        ${Metadata},

        [Parameter(HelpMessage = 'Access tier for specific share. StorageV2 account can choose between TransactionOptimized (default), Hot, and Cool. FileStorage account can choose Premium.')]
        [ValidateSet('TransactionOptimized', 'Premium', 'Hot', 'Cool')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${AccessTier},

        [Parameter(HelpMessage = 'Sets reduction of the access rights for the remote superuser. Possible values include: ''NoRootSquash'', ''RootSquash'', ''AllSquash''')]
        [ValidateSet('NoRootSquash', 'RootSquash', 'AllSquash')]
        [string]
        ${RootSquash},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzRmStorageShare', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzStorageAccountNetworkRuleSet
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Storage Account Name.')]
        [Alias('StorageAccountName', 'AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(HelpMessage = 'Storage Account NetworkRule Bypass.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${Bypass},

        [Parameter(HelpMessage = 'Storage Account NetworkRule DefaultAction.')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${DefaultAction},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule IPRules.')]
        [object[]]
        ${IPRule},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule VirtualNetworkRules.')]
        [object[]]
        ${VirtualNetworkRule},

        [Parameter(ValueFromPipeline = $true, HelpMessage = 'Storage Account NetworkRule ResourceAccessRules.')]
        [object[]]
        ${ResourceAccessRule},

        [Parameter(HelpMessage = 'Run cmdlet in the background')]
        [switch]
        ${AsJob},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzStorageAccountNetworkRuleSet', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzStorageBlobServiceProperty
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'BlobServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a Blob service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Default Service Version to Set')]
        [ValidateNotNull()]
        [string]
        ${DefaultServiceVersion},

        [Parameter(HelpMessage = 'Enable Change Feed logging for the storage account by set to $true, disable Change Feed logging by set to $false.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableChangeFeed},

        [Parameter(HelpMessage = 'Indicates the duration of changeFeed retention in days. Minimum value is 1 day and maximum value is 146000 days (400 years). Never specify it when enabled changeFeed will get null value in service properties, indicates an infinite retention of the change feed.')]
        [ValidateNotNullOrEmpty()]
        [int]
        ${ChangeFeedRetentionInDays},

        [Parameter(HelpMessage = 'Gets or sets versioning is enabled if set to true.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${IsVersioningEnabled},

        [Parameter(HelpMessage = 'Specifies CORS rules for the Blob service.')]
        [ValidateNotNull()]
        [object[]]
        ${CorsRule},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzStorageBlobServiceProperty', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzStorageEncryptionScope
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'EncryptionScopeObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'EncryptionScope object')]
        [Parameter(ParameterSetName = 'EncryptionScopeObjectKeyVault', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'EncryptionScope object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${InputObject},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, HelpMessage = 'Azure Storage EncryptionScope name')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, HelpMessage = 'Azure Storage EncryptionScope name')]
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, HelpMessage = 'Azure Storage EncryptionScope name')]
        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, HelpMessage = 'Azure Storage EncryptionScope name')]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${EncryptionScopeName},

        [Parameter(ParameterSetName = 'AccountName', HelpMessage = 'Create encryption scope with keySource as Microsoft.Storage.')]
        [Parameter(ParameterSetName = 'AccountObject', HelpMessage = 'Create encryption scope with keySource as Microsoft.Storage.')]
        [Parameter(ParameterSetName = 'EncryptionScopeObject', HelpMessage = 'Create encryption scope with keySource as Microsoft.Storage.')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${StorageEncryption},

        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [Parameter(ParameterSetName = 'EncryptionScopeObjectKeyVault', Mandatory = $true, HelpMessage = 'Create encryption scope with keySource as Microsoft.Keyvault')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${KeyvaultEncryption},

        [Parameter(ParameterSetName = 'AccountNameKeyVault', Mandatory = $true, HelpMessage = 'The key Uri.')]
        [Parameter(ParameterSetName = 'AccountObjectKeyVault', Mandatory = $true, HelpMessage = 'The key Uri.')]
        [Parameter(ParameterSetName = 'EncryptionScopeObjectKeyVault', Mandatory = $true, HelpMessage = 'The key Uri.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${KeyUri},

        [Parameter(HelpMessage = 'Update encryption scope State, Possible values include: ''Enabled'', ''Disabled''.')]
        [ValidateSet('Enabled', 'Disabled')]
        [string]
        ${State},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzStorageEncryptionScope', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzStorageFileServiceProperty
{
    [CmdletBinding(DefaultParameterSetName = 'AccountName', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 0, HelpMessage = 'Resource Group Name.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'AccountName', Mandatory = $true, Position = 1, HelpMessage = 'Storage Account Name.')]
        [Alias('AccountName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${StorageAccountName},

        [Parameter(ParameterSetName = 'AccountObject', Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Storage account object')]
        [ValidateNotNullOrEmpty()]
        [object]
        ${StorageAccount},

        [Parameter(ParameterSetName = 'FileServicePropertiesResourceId', Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Input a Storage account Resource Id, or a File service properties Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(HelpMessage = 'Enable share Delete Retention Policy for the storage account by set to $true, disable share Delete Retention Policy  by set to $false.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableShareDeleteRetentionPolicy},

        [Parameter(HelpMessage = 'Sets the number of retention days for the share DeleteRetentionPolicy. The value should only be set when enable share Delete Retention Policy.')]
        [Alias('Days', 'RetentionDays')]
        [int]
        ${ShareRetentionDays},

        [Parameter(HelpMessage = 'Enable Multichannel by set to $true, disable Multichannel by set to $false. Applies to Premium FileStorage only.')]
        [ValidateNotNullOrEmpty()]
        [bool]
        ${EnableSmbMultichannel},

        [Parameter(HelpMessage = 'Gets or sets SMB protocol versions supported by server. Valid values are SMB2.1, SMB3.0, SMB3.1.1.')]
        [ValidateSet('SMB2.1', 'SMB3.0', 'SMB3.1.1')]
        [string[]]
        ${SmbProtocolVersion},

        [Parameter(HelpMessage = 'Gets or sets SMB authentication methods supported by server. Valid values are NTLMv2, Kerberos.')]
        [ValidateSet('Kerberos', 'NTLMv2')]
        [string[]]
        ${SmbAuthenticationMethod},

        [Parameter(HelpMessage = 'Gets or sets SMB channel encryption supported by server. Valid values are AES-128-CCM, AES-128-GCM, AES-256-GCM.')]
        [ValidateSet('AES-128-CCM', 'AES-128-GCM', 'AES-256-GCM')]
        [string[]]
        ${SmbChannelEncryption},

        [Parameter(HelpMessage = 'Gets or sets kerberos ticket encryption supported by server. Valid values are RC4-HMAC, AES-256.')]
        [ValidateSet('AES-256', 'RC4-HMAC')]
        [string[]]
        ${SmbKerberosTicketEncryption},

        [Parameter(HelpMessage = 'Specifies CORS rules for the File service.')]
        [ValidateNotNull()]
        [object[]]
        ${CorsRule},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext', 'AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


    dynamicparam
    {
        try
        {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Storage\Update-AzStorageFileServiceProperty', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0)
            {
                $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams)
                {
                    $param = $param.Value

                    if (-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                    {
                        $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        }
        catch
        {
            throw
        }
    }


}


function Update-AzStorageServiceProperty
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Azure storage service type(Blob, Table, Queue).')]
        [object]
        ${ServiceType},

        [Parameter(HelpMessage = 'Default Service Version to Set')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${DefaultServiceVersion},

        [Parameter(HelpMessage = 'Display ServiceProperties')]
        [switch]
        ${PassThru},

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Azure Storage Context Object')]
        [object]
        ${Context},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRmContext', 'AzureCredential')]
        [object]
        ${DefaultProfile})


}




