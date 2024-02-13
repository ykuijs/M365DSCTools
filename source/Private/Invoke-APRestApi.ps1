function Invoke-APRestApi
{
<#
.SYNOPSIS
    Executes an API call to Azure DevOps.

.DESCRIPTION
    This function executes an API call to Azure DevOps using the provided method, headers, and body.

.PARAMETER Uri
    The URI to the Azure DevOps API.

.PARAMETER Method
    The HTTP method to be used for the API call.

.PARAMETER Headers
    The headers to be used for the API call.

.PARAMETER Body
    The body to be used for the API call.

.EXAMPLE
    $headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
    $authToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
    $headers.Add("Authorization", ("Basic {0}" -f $authToken))

    $devOpsOrgUrl = 'https://dev.azure.com/{0}' -f $Organization
    $devOpsProjectUrl = '{0}/{1}' -f $devOpsOrgUrl, $Project
    $apiVersionString = "api-version=$ApiVersion"
    $envUrl = '{0}/_apis/distributedtask/environments?{1}' -f $devOpsProjectUrl, $apiVersionString
    $currentEnvironments = Invoke-APRestApi -Uri $envUrl -Method 'GET' -Headers $headers
#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Uri,

        [Parameter(Mandatory = $true)]
        [ValidateSet('GET', 'POST', 'PATCH')]
        [System.String]
        $Method,

        [Parameter()]
        [System.Collections.Generic.Dictionary[[String], [String]]]
        $Headers,

        [Parameter()]
        [System.String]
        $Body

    )

    try
    {
        $params = @{
            Uri    = $Uri
            Method = $Method
        }

        if ($PSBoundParameters.ContainsKey('Headers'))
        {
            $params.Headers = $Headers
        }

        if ($PSBoundParameters.ContainsKey('Body'))
        {
            $params.Body = $Body
        }

        $result = Invoke-RestMethod @params
        return $result
    }
    catch
    {
        Write-Log -Object "[ERROR] Error occurred when connecting to Azure DevOps API: $($_.Exception.Message)" -Failure
        throw
    }
}
