function Set-PipelineYaml
{
<#
.SYNOPSIS
    Updates the environments parameter in the pipeline Yaml with the provided environments info.

.DESCRIPTION
    This function updates the environments parameter in the provided pipeline Yaml
    with the provided environments info.

.PARAMETER YamlPath
    The path to the pipeline Yaml file that has to get updated.

.PARAMETER EnvironmentsInfo
    The environment details that is used to update the environments parameter.

.EXAMPLE
    $envInfo = @{
        Dev = @{
            DependsOn = ''
            Branch = 'dev'
        }
        Test = @{
            DependsOn = 'Dev'
            Branch = 'main'
        }
        Acceptance = @{
            DependsOn = 'Test'
            Branch = 'main'
        }
        Production = @{
            DependsOn = 'Acceptance'
            Branch = 'main'
        }
    }

    Set-PipelineYaml `
        -YamlPath 'C:\Source\Demo\Pipelines\template.yaml' `
        -EnvironmentsInfo = $envInfo
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $YamlPath,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $EnvironmentsInfo
    )

    if (Test-Path -Path $YamlPath)
    {
        $yamlContent = Get-Content -Path $YamlPath -Raw
        $yamlObj = ConvertFrom-Yaml -Yaml $yamlContent -Ordered

        if ($yamlObj.Keys -contains 'parameters')
        {
            $envParameter = $yamlObj.parameters | Where-Object -FilterScript { $_.Name -eq 'Environments' }
            if ($null -ne $envParameter)
            {
                $defaults = $envParameter.default

                if ($null -eq $defaults)
                {
                    $defaults = @()
                    $currentEnvs = @()
                }
                else
                {
                    $currentEnvs = $defaults.Name
                }
                [Array]$targetEnvs = $EnvironmentsInfo.Keys

                $diff = Compare-Object -ReferenceObject $currentEnvs -DifferenceObject $targetEnvs -IncludeEqual

                switch ($diff)
                {
                    { $_.SideIndicator -eq '=>' }
                    {
                        $envName = $_.InputObject
                        Write-Log -Object "Adding '$envName' to the pipeline Yaml file"
                        $dependsOn = $EnvironmentsInfo.$envName.DependsOn
                        if ([String]::IsNullOrEmpty($dependsOn))
                        {
                            $dependsOn = $null
                        }
                        $defaults += [Ordered]@{
                            Name      = $envName
                            DependsOn = $dependsOn
                            Branch    = $EnvironmentsInfo.$envName.Branch
                        }
                        continue
                    }
                    { $_.SideIndicator -eq '<=' }
                    {
                        $envName = $_.InputObject
                        Write-Log -Object "Removing '$envName' from the pipeline Yaml file"
                        $defaults = $defaults | Where-Object { $_.Name -ne $envName }
                        continue
                    }
                    { $_.SideIndicator -eq '==' }
                    {
                        $envName = $_.InputObject
                        Write-Log -Object "Updating '$envName' in the pipeline Yaml file"
                        $updateEnv = $defaults | Where-Object { $_.Name -eq $envName }
                        $dependsOn = $EnvironmentsInfo.$envName.DependsOn
                        if ([String]::IsNullOrEmpty($dependsOn))
                        {
                            $dependsOn = $null
                        }
                        $updateEnv.DependsOn = $dependsOn
                        $updateEnv.Branch = $EnvironmentsInfo.$envName.Branch
                        continue
                    }
                }

                $envParameter.default = $defaults
                if ($PSCmdlet.ShouldProcess($YamlPath, 'Update Yaml file'))
                {
                    ConvertTo-Yaml $yamlObj -OutFile $YamlPath -Force
                }
            }
            else
            {
                Write-Log "Specified Yaml '$YamlPath' does not have an 'Environments' parameter!" -Failure
                return $false
            }
        }
        else
        {
            Write-Log "Specified Yaml '$YamlPath' does not have a 'parameters' value!" -Failure
            return $false
        }
        return $true
    }
    else
    {
        Write-Log "Specified YamlPath '$YamlPath' does not exist!" -Failure
        return $false
    }
}
