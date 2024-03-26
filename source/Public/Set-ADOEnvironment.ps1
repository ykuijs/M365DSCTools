function Set-ADOEnvironment
{
    <#
.SYNOPSIS
    Checks if specified environments exist in Azure DevOps and creates them if they don't.

.DESCRIPTION
    This function checks if the specified environments exist in Azure DevOps and creates
    them if they don't. It also checks if other configurations are set, like approvers
    pipeline permissions, etc.

.PARAMETER Organization
    The name of the DevOps organization.

.PARAMETER Project
    The name of the project in the DevOps organization.

.PARAMETER ApiVersion
    The name of the to be used API version.

.PARAMETER PAT
    The Personal Access Token to be used for authentication (if required).

.PARAMETER TargetEnvironments
    The list of environments that should exist in the DevOps project.

.PARAMETER Approvers
    The list of approvers for each environment.

.PARAMETER DeploymentPipeline
    The name of the pipeline that should be granted permissions to access
    the environment.

.EXAMPLE
    $environmentsConfig = @{
        'testenv' = @(
            @{
                Principal = 'user@domain.com'
                Type      = 'User'
            }
            @{
                Principal = '[DevOps Project]\Project Administrators'
                Type      = 'Group'
            }
        )
        'testenv2' = @(
            @{
                Principal = 'admin@contoso.com'
                Type      = 'User'
            }
            @{
                Principal = '[DSC Project]\Project Administrators'
                Type      = 'Group'
            }
        )
    }

    Set-ADOEnvironment `
        -Organization 'myorg' `
        -Project 'myproject' `
        -TargetEnvironments $environmentsConfig.Keys `
        -Approvers $environmentsConfig `
        -DeploymentPipeline 'mypipeline' `
        -PAT '<pat>'
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Organization,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Project,

        [Parameter()]
        [System.String]
        $ApiVersion = '7.1-preview.1',

        [Parameter()]
        [System.String]
        $PAT,

        [Parameter(Mandatory = $true)]
        [System.Array]
        $TargetEnvironments,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Approvers,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DeploymentPipeline
    )

    #region Variables
    $devOpsVsspsOrgUrl = 'https://vssps.dev.azure.com/{0}' -f $Organization
    $devOpsOrgUrl = 'https://dev.azure.com/{0}' -f $Organization
    $devOpsProjectUrl = '{0}/{1}' -f $devOpsOrgUrl, $Project
    $apiVersionString = "api-version=$ApiVersion"

    $default = @{
        ExecutionOrder            = 'anyOrder'
        Instructions              = 'Please approve if you agree with the deployment.'
        MinRequiredApprovers      = 1
        RequesterCannotBeApprover = $true
        Timeout                   = 14400
    }

    $approversDetails = @{}
    #endregion Variables

    #region Script
    Write-Log -Object 'Starting Pipeline Environments check'

    Write-Log -Object 'Creating Authorization token'
    $headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'

    if ($PSBoundParameters.ContainsKey('PAT'))
    {
        Write-Log -Object '  Parameter PAT is specified, using that to authenticate'
        $authToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
        $headers.Add('Authorization', ('Basic {0}' -f $authToken))
    }
    else
    {
        Write-Log -Object '  Parameter PAT is NOT specified, using environment variable SYSTEM_ACCESSTOKEN to authenticate'
        $headers.Add('Authorization', ('Bearer {0}' -f $env:SYSTEM_ACCESSTOKEN))
    }
    $headers.Add('Content-Type', 'application/json')

    # https://learn.microsoft.com/en-us/rest/api/azure/devops/distributedtask/environments/list?view=azure-devops-rest-7.1
    Write-Log -Object 'Retrieving all environments'
    $envUrl = '{0}/_apis/distributedtask/environments?{1}' -f $devOpsProjectUrl, $apiVersionString
    $currentEnvironments = Invoke-APRestApi -Uri $envUrl -Method 'GET' -Headers $headers

    $currentEnvironmentNames = $currentEnvironments.value | Select-Object -ExpandProperty Name

    Write-Log -Object "Check the differences between current ($($currentEnvironments.Count)) and target environments ($($TargetEnvironments.Count))"
    $createEnvironments = @()
    if ($null -eq $currentEnvironments -or $currentEnvironments.Count -eq 0)
    {
        $createEnvironments = $TargetEnvironments
    }
    else
    {
        $envDifferences = Compare-Object -ReferenceObject $TargetEnvironments -DifferenceObject $currentEnvironmentNames #-IncludeEqual
        switch ($envDifferences)
        {
            { $_.SideIndicator -eq '<=' }
            {
                $envName = $_.InputObject
                Write-Log -Object "Environment does not exist: $($envName)"
                $createEnvironments += $envName
            }
            { $_.SideIndicator -eq '=>' }
            {
                Write-Log -Object "Environment is not specified in target environments: $($_.InputObject)" -Warning
            }
        }
    }

    Write-Log -Object 'Creating all new environments'
    foreach ($environment in $createEnvironments)
    {
        Write-Log -Object "  Creating new environment: $environment"
        $obj = @{
            name        = $environment
            description = "Environment for $($environment)"
        }
        $requestBody = ConvertTo-Json -InputObject $obj -Depth 10

        if ($PSCmdlet.ShouldProcess($environment, 'Create Environment'))
        {
            $null = Invoke-APRestApi -Uri $envUrl -Method 'POST' -Headers $headers -Body $requestBody
        }
    }

    # https://learn.microsoft.com/en-us/rest/api/azure/devops/graph/users/list?view=azure-devops-rest-7.1
    Write-Log -Object 'Getting all users'
    $usersUrl = '{0}/_apis/graph/users?{1}' -f $devOpsVsspsOrgUrl, $apiVersionString
    $allUsers = Invoke-APRestApi -Uri $usersUrl -Method 'GET' -Headers $headers

    Write-Log -Object 'Getting all groups'
    $groupsUrl = '{0}/_apis/graph/groups?{1}' -f $devOpsVsspsOrgUrl, $apiVersionString
    $allGroups = Invoke-APRestApi -Uri $groupsUrl -Method 'GET' -Headers $headers

    Write-Log -Object 'Getting details of approvers'
    foreach ($environment in $Approvers.GetEnumerator())
    {
        Write-Log -Object "Processing approvers for environment: $($environment.Key)"
        $envApprovers = $environment.Value

        $approversDetails.$($environment.Key) = @()
        foreach ($approver in $envApprovers | Where-Object { $_.Type -eq 'User' })
        {
            Write-Log -Object "  Processing: '$($approver.Principal)'"
            $approveUser = $allUsers.value | Where-Object -FilterScript { $_.PrincipalName -eq $approver.Principal }
            if ($null -eq $approveUser)
            {
                Write-Log -Object "    Approval User '$($approver.Principal)' not found!" -Failure
                return $false
            }

            $userDisplayName = $approveUser.displayName

            $storagekeyUrl = '{0}/_apis/graph/storagekeys/{2}?{1}' -f $devOpsVsspsOrgUrl, $apiVersionString, $approveUser.descriptor
            $userStoragekey = Invoke-APRestApi -Uri $storagekeyUrl -Method 'GET' -Headers $headers

            if ($null -eq $userStoragekey)
            {
                Write-Log -Object '    User descriptor not found!' -Failure
                return $false
            }

            $approversDetails.$($environment.Key) += [PSCustomObject]@{
                DisplayName = $userDisplayName
                Descriptor  = $userStoragekey.value
            }
        }

        foreach ($approver in $envApprovers | Where-Object { $_.Type -eq 'Group' })
        {
            Write-Log -Object "  Processing: '$($approver.Principal)'"
            $approveGroup = $allGroups.value | Where-Object -FilterScript { $_.PrincipalName -eq $approver.Principal }
            if ($null -eq $approveGroup)
            {
                Write-Log -Object "    [ERROR] Approval Group '$($approver.Principal)' not found!" -Failure
                return $false
            }

            $groupDisplayName = $approveGroup.PrincipalName

            $storagekeyUrl = '{0}/_apis/graph/storagekeys/{2}?{1}' -f $devOpsVsspsOrgUrl, $apiVersionString, $approveGroup.descriptor
            $groupStoragekey = Invoke-APRestApi -Uri $storagekeyUrl -Method 'GET' -Headers $headers

            if ($null -eq $groupStoragekey)
            {
                Write-Log -Object '    Group descriptor not found!' -Failure
                return $false
            }

            $approversDetails.$($environment.Key) += [PSCustomObject]@{
                DisplayName = $groupDisplayName
                Descriptor  = $groupStoragekey.value
            }
        }
    }

    Write-Log -Object "Get Pipeline info for pipeline '$DeploymentPipeline'"
    $pipelineUrl = '{0}/_apis/pipelines?{1}' -f $devOpsProjectUrl, $apiVersionString
    $pipelines = $null
    $pipelines = Invoke-APRestApi -Uri $pipelineUrl -Method 'GET' -Headers $headers
    if ($null -eq $pipelines -or $pipelines.count -eq 0)
    {
        Write-Log -Object '    Pipeline not found' -Failure
        return $false
    }
    $pipeline = $pipelines.value | Where-Object { $_.name -eq $deploymentPipeline }

    # Retrieve all environments, including newly created ones.
    Write-Log -Object 'Refreshing all environments'
    $currentEnvironments = Invoke-APRestApi -Uri $envUrl -Method 'GET' -Headers $headers

    foreach ($environment in $currentEnvironments.value)
    {
        Write-Log -Object "Checking config for '$($environment.Name)'"
        $envId = $environment.id
        $envName = $environment.Name

        # https://learn.microsoft.com/en-us/rest/api/azure/devops/approvalsandchecks/check-configurations/get?view=azure-devops-rest-7.1
        $envChecksUrl = '{0}/_apis/pipelines/checks/configurations?resourceType=environment&resourceId={2}&{1}' -f $devOpsProjectUrl, $apiVersionString, $envId
        $envChecks = $null
        $envChecks = Invoke-APRestApi -Uri $envChecksUrl -Method 'GET' -Headers $headers

        if ($null -ne $envChecks)
        {
            if ($envChecks.Count -ne 0)
            {
                Write-Log -Object '  Approval configured, checking configuration.'
                $checkId = $envChecks.value.Id

                $checkUrl = "{0}/_apis/pipelines/checks/configurations/{2}?`$expand=settings&{1}" -f $devOpsProjectUrl, $apiVersionString, $checkId
                $checkInfo = Invoke-APRestApi -Uri $checkUrl -Method 'GET' -Headers $headers
                if ($null -ne $checkInfo)
                {
                    $settings = $checkInfo.settings
                    $obj = @{
                        id       = $checkId
                        type     = @{
                            id   = '8C6F20A7-A545-4486-9777-F762FAFE0D4D'
                            name = 'Approval'
                        }
                        settings = @{
                            approvers                 = @()
                            blockApprovers            = @()
                            executionOrder            = $default.ExecutionOrder
                            instructions              = $default.Instructions
                            minRequiredApprovers      = $default.MinRequiredApprovers
                            requesterCannotBeApprover = $default.RequesterCannotBeApprover
                        }
                        resource = @{
                            type = 'environment'
                            id   = $envId
                            name = $envName
                        }
                        timeout  = $default.Timeout
                    }
                    $updateCheck = $false

                    if ($settings.instructions -ne $default.Instructions)
                    {
                        Write-Log -Object "    Parameter Instructions changed, updating. Old: $($settings.instructions), New: $($default.Instructions)"
                        $updateCheck = $true
                    }

                    if ($settings.requesterCannotBeApprover -ne $default.RequesterCannotBeApprover)
                    {
                        Write-Log -Object "    Parameter RequesterCannotBeApprover changed, updating. Old: $($settings.requesterCannotBeApprover), New: $($default.RequesterCannotBeApprover)"
                        $updateCheck = $true
                    }

                    if ($settings.executionOrder -ne $default.ExecutionOrder)
                    {
                        Write-Log -Object "    Parameter ExecutionOrder changed, updating. Old: $($settings.executionOrder), New: $($default.ExecutionOrder)"
                        $updateCheck = $true
                    }

                    if ($settings.minRequiredApprovers -ne $default.MinRequiredApprovers)
                    {
                        Write-Log -Object "    Parameter MinRequiredApprovers changed, updating. Old: $($settings.minRequiredApprovers), New: $($default.MinRequiredApprovers)"
                        $updateCheck = $true
                    }

                    if ($checkInfo.timeout -ne $default.Timeout)
                    {
                        Write-Log -Object "    Parameter TimeOut changed, updating. Old: $($checkInfo.timeout), New: $($default.Timeout)"
                        $updateCheck = $true
                    }

                    if ($settings.approvers.Count -ne 0)
                    {
                        $approversDiff = Compare-Object -ReferenceObject $settings.approvers.id -DifferenceObject $approversDetails.$envName.Descriptor
                        if ($null -ne $approversDiff)
                        {
                            Write-Log -Object '    Approvers changed, updating.'
                            $updateCheck = $true
                        }
                    }
                    else
                    {
                        Write-Log -Object '    Approvers changed, updating.'
                        $updateCheck = $true
                    }

                    foreach ($approver in $approversDetails.$envName)
                    {
                        $obj.settings.approvers += @{
                            displayName = $approver.DisplayName
                            id          = $approver.Descriptor
                        }
                    }

                    if ($updateCheck -eq $true)
                    {
                        Write-Log -Object '    Updating check configuration'
                        $requestBody = ConvertTo-Json -InputObject $obj -Depth 10
                        Write-Log -Object "    DEBUG: $requestBody"

                        $configUrl = '{0}/_apis/pipelines/checks/configurations/{2}?{1}' -f $devOpsProjectUrl, $apiVersionString, $checkId
                        Write-Log -Object "    DEBUG: $configUrl"
                        if ($PSCmdlet.ShouldProcess('Configurations', 'Configure approvals'))
                        {
                            $null = Invoke-APRestApi -Uri $configUrl -Method 'PATCH' -Headers $headers -Body $requestBody
                        }
                    }
                }
                else
                {
                    Write-Log -Object '  No check information found!'
                }
            }
            else
            {
                Write-Log -Object '  No approval configured, configuring.'
                $obj = @{
                    type     = @{
                        id   = '8C6F20A7-A545-4486-9777-F762FAFE0D4D'
                        name = 'Approval'
                    }
                    settings = @{
                        approvers                 = @()
                        blockApprovers            = @()
                        executionOrder            = $default.ExecutionOrder
                        instructions              = $default.Instructions
                        minRequiredApprovers      = $default.MinRequiredApprovers
                        requesterCannotBeApprover = $default.RequesterCannotBeApprover
                    }
                    resource = @{
                        type = 'environment'
                        id   = $envId
                        name = $envName
                    }
                    timeout  = $default.Timeout
                }

                foreach ($approver in $approversDetails.$envName)
                {
                    $obj.settings.approvers += @{
                        displayName = $approver.DisplayName
                        id          = $approver.Descriptor
                    }
                }

                $requestBody = ConvertTo-Json -InputObject $obj -Depth 10

                Write-Log -Object '  Creating check'
                $configUrl = '{0}/_apis/pipelines/checks/configurations?{1}' -f $devOpsProjectUrl, $apiVersionString
                if ($PSCmdlet.ShouldProcess('Configurations', 'Create approvals'))
                {
                    $null = Invoke-APRestApi -Uri $configUrl -Method 'POST' -Headers $headers -Body $requestBody
                }
            }
        }
        else
        {
            Write-Log -Object '    Error while retrieving Environment Checks' -Failure
            return $false
        }

        Write-Log -Object '  Checking pipeline permissions to environment'
        $permissionsUrl = '{0}/_apis/pipelines/pipelinepermissions/environment/{2}?{1}' -f $devOpsProjectUrl, $apiVersionString, $envId
        $permissionsChecks = Invoke-APRestApi -Uri $permissionsUrl -Method 'GET' -Headers $headers

        if ($permissionsChecks.pipelines.count -eq 0)
        {
            Write-Log -Object '    Permissions not provided. Granting permissions!'
            $body = "{ 'pipelines':[{'id': $($pipeline.id), 'authorized': true}] }"
            if ($PSCmdlet.ShouldProcess($DeploymentPipeline, 'Granting pipeline permissions'))
            {
                $null = Invoke-APRestApi -Uri $permissionsUrl -Method 'PATCH' -Headers $headers -Body $body
            }
        }
        else
        {
            Write-Log -Object '    Permissions provided. Checking if correct pipeline!'
            foreach ($permission in $permissionsChecks.pipelines)
            {
                if ($permission.id -ne $pipeline.id -or $permission.authorized -ne $true)
                {
                    $body = "{ 'pipelines':[{'id': $($pipeline.id), 'authorized': true}] }"
                    if ($PSCmdlet.ShouldProcess($DeploymentPipeline, 'Granting pipeline permissions'))
                    {
                        $null = Invoke-APRestApi -Uri $permissionsUrl -Method 'PATCH' -Headers $headers -Body $body
                    }
                }
            }
        }
    }

    Write-Log -Object 'Completed Pipeline Environments check'
    return $true
    #endregion Script
}
