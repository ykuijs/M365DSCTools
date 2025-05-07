BeforeAll {
    $script:moduleName = 'M365DSCTools'

    # If the module is not found, run the build task 'noop'.
    if (-not (Get-Module -Name $script:moduleName -ListAvailable))
    {
        # Redirect all streams to $null, except the error stream (stream 2)
        & "$PSScriptRoot/../../build.ps1" -Tasks 'noop' > $null
    }

    # Re-import the module using force to get any code changes between runs.
    Import-Module -Name $script:moduleName -Force -ErrorAction 'Stop'

    $PSDefaultParameterValues['InModuleScope:ModuleName'] = $script:moduleName
    $PSDefaultParameterValues['Mock:ModuleName'] = $script:moduleName
    $PSDefaultParameterValues['Should:ModuleName'] = $script:moduleName
}

AfterAll {
    $PSDefaultParameterValues.Remove('Mock:ModuleName')
    $PSDefaultParameterValues.Remove('InModuleScope:ModuleName')
    $PSDefaultParameterValues.Remove('Should:ModuleName')

    Remove-Module -Name $script:moduleName
}

Describe Convert-M365DSCExportToPowerShellDataFile {
    BeforeAll {
        $hashtable = @{
            Item1 = 'Value1'
            Item2 = 'Value2'
            Item3 = @{
                Item4 = 'Value4'
                Item5 = 'Value5'
            }
            Item6 = @(
                'Value6'
                'Value7'
            )
        }

        # Declare M365DSC functions, so they can be mocked
        function Global:Set-M365DSCTelemetryOption
        {
        }
        function Global:New-M365DSCReportFromConfiguration
        {
        }
        function Global:ConvertTo-DscObject
        {
        }

        Mock -CommandName Set-M365DSCTelemetryOption -MockWith {}
        Mock -CommandName New-M365DSCReportFromConfiguration -MockWith {}
        Mock -CommandName Write-Log -MockWith {}

        # Mock -CommandName Get-Item -MockWith {
        #     return @{
        #         BaseName = 'O365'
        #     }
        # }
        # Mock -CommandName New-Item -MockWith {}
        Mock -CommandName Out-File -MockWith {
            $sb = [scriptblock]::Create($InputObject)
            $global:ReturnedValue = $sb.Invoke()
        }
        Mock -CommandName Test-Path -MockWith { return $true }
        # Mock -CommandName Remove-Item -MockWith {}
        Mock -CommandName Get-Content -MockWith {
            return @'
# Generated with Microsoft365DSC version 1.25.326.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
)

Configuration MyConfig
{
    param (
    )

    $OrganizationName = $ConfigurationData.NonNodeData.OrganizationName

    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.25.326.1'

    Node localhost
    {
        O365OrgSettings "O365OrgSettings"
        {
            AdminCenterReportDisplayConcealedNames                = $True;
            AllowPlannerCopilot                                   = $True;
            ApplicationId                                         = $ConfigurationData.NonNodeData.ApplicationId;
            AppsAndServicesIsAppAndServicesTrialEnabled           = $False;
            AppsAndServicesIsOfficeStoreEnabled                   = $False;
            CertificateThumbprint                                 = $ConfigurationData.NonNodeData.CertificateThumbprint;
            CortanaEnabled                                        = $False;
            DynamicsCustomerVoiceIsInOrgFormsPhishingScanEnabled  = $True;
            DynamicsCustomerVoiceIsRecordIdentityByDefaultEnabled = $False;
            DynamicsCustomerVoiceIsRestrictedSurveyAccessEnabled  = $False;
            FormsIsBingImageSearchEnabled                         = $False;
            FormsIsExternalSendFormEnabled                        = $False;
            FormsIsExternalShareCollaborationEnabled              = $False;
            FormsIsExternalShareResultEnabled                     = $False;
            FormsIsExternalShareTemplateEnabled                   = $False;
            FormsIsInOrgFormsPhishingScanEnabled                  = $True;
            FormsIsRecordIdentityByDefaultEnabled                 = $False;
            InstallationOptionsAppsForMac                         = @("isMicrosoft365AppsEnabled");
            InstallationOptionsAppsForWindows                     = @("isVisioEnabled","isProjectEnabled","isMicrosoft365AppsEnabled");
            InstallationOptionsUpdateChannel                      = "semiAnnual";
            IsSingleInstance                                      = "Yes";
            M365WebEnableUsersToOpenFilesFrom3PStorage            = $False;
            PlannerAllowCalendarSharing                           = $False;
            TenantId                                              = $OrganizationName;
            ToDoIsExternalJoinEnabled                             = $True;
            ToDoIsExternalShareEnabled                            = $False;
            ToDoIsPushNotificationEnabled                         = $True;
            VivaInsightsDigestEmail                               = $False;
            VivaInsightsOutlookAddInAndInlineSuggestions          = $False;
            VivaInsightsScheduleSendSuggestions                   = $False;
            VivaInsightsWebExperience                             = $False;
        }
    }
}

MyConfig -ConfigurationData .\ConfigurationData.psd1
'@
        }
        Mock -CommandName ConvertTo-DSCObject -MockWith {
            return @(
                @{
                    AdminCenterReportDisplayConcealedNames                = $true
                    AllowPlannerCopilot                                   = $true
                    ApplicationId                                         = '$ConfigurationData.NonNodeData.ApplicationId'
                    AppsAndServicesIsAppAndServicesTrialEnabled           = $false
                    AppsAndServicesIsOfficeStoreEnabled                   = $false
                    CertificateThumbprint                                 = '$ConfigurationData.NonNodeData.CertificateThumbprint'
                    CortanaEnabled                                        = $false
                    DynamicsCustomerVoiceIsInOrgFormsPhishingScanEnabled  = $true
                    DynamicsCustomerVoiceIsRecordIdentityByDefaultEnabled = $false
                    DynamicsCustomerVoiceIsRestrictedSurveyAccessEnabled  = $false
                    FormsIsBingImageSearchEnabled                         = $false
                    FormsIsExternalSendFormEnabled                        = $false
                    FormsIsExternalShareCollaborationEnabled              = $false
                    FormsIsExternalShareResultEnabled                     = $false
                    FormsIsExternalShareTemplateEnabled                   = $false
                    FormsIsInOrgFormsPhishingScanEnabled                  = $true
                    FormsIsRecordIdentityByDefaultEnabled                 = $false
                    InstallationOptionsAppsForMac                         = @('isMicrosoft365AppsEnabled')
                    InstallationOptionsAppsForWindows                     = @('isVisioEnabled', 'isProjectEnabled', 'isMicrosoft365AppsEnabled')
                    InstallationOptionsUpdateChannel                      = 'semiAnnual'
                    IsSingleInstance                                      = 'Yes'
                    M365WebEnableUsersToOpenFilesFrom3PStorage            = $false
                    PlannerAllowCalendarSharing                           = $false
                    ResourceInstanceName                                  = 'O365OrgSettings'
                    ResourceName                                          = 'O365OrgSettings'
                    TenantId                                              = '$OrganizationName '
                    ToDoIsExternalJoinEnabled                             = $true
                    ToDoIsExternalShareEnabled                            = $false
                    ToDoIsPushNotificationEnabled                         = $true
                    VivaInsightsDigestEmail                               = $false
                    VivaInsightsOutlookAddInAndInlineSuggestions          = $false
                    VivaInsightsScheduleSendSuggestions                   = $false
                    VivaInsightsWebExperience                             = $false
                }
            )
        }
        Mock -CommandName Start-Job -MockWith {
            return @(
                @{
                    AdminCenterReportDisplayConcealedNames                = $true
                    AllowPlannerCopilot                                   = $true
                    ApplicationId                                         = '$ConfigurationData.NonNodeData.ApplicationId'
                    AppsAndServicesIsAppAndServicesTrialEnabled           = $false
                    AppsAndServicesIsOfficeStoreEnabled                   = $false
                    CertificateThumbprint                                 = '$ConfigurationData.NonNodeData.CertificateThumbprint'
                    CortanaEnabled                                        = $false
                    DynamicsCustomerVoiceIsInOrgFormsPhishingScanEnabled  = $true
                    DynamicsCustomerVoiceIsRecordIdentityByDefaultEnabled = $false
                    DynamicsCustomerVoiceIsRestrictedSurveyAccessEnabled  = $false
                    FormsIsBingImageSearchEnabled                         = $false
                    FormsIsExternalSendFormEnabled                        = $false
                    FormsIsExternalShareCollaborationEnabled              = $false
                    FormsIsExternalShareResultEnabled                     = $false
                    FormsIsExternalShareTemplateEnabled                   = $false
                    FormsIsInOrgFormsPhishingScanEnabled                  = $true
                    FormsIsRecordIdentityByDefaultEnabled                 = $false
                    InstallationOptionsAppsForMac                         = @('isMicrosoft365AppsEnabled')
                    InstallationOptionsAppsForWindows                     = @('isVisioEnabled', 'isProjectEnabled', 'isMicrosoft365AppsEnabled')
                    InstallationOptionsUpdateChannel                      = 'semiAnnual'
                    IsSingleInstance                                      = 'Yes'
                    M365WebEnableUsersToOpenFilesFrom3PStorage            = $false
                    PlannerAllowCalendarSharing                           = $false
                    ResourceInstanceName                                  = 'O365OrgSettings'
                    ResourceName                                          = 'O365OrgSettings'
                    TenantId                                              = '$OrganizationName '
                    ToDoIsExternalJoinEnabled                             = $true
                    ToDoIsExternalShareEnabled                            = $false
                    ToDoIsPushNotificationEnabled                         = $true
                    VivaInsightsDigestEmail                               = $false
                    VivaInsightsOutlookAddInAndInlineSuggestions          = $false
                    VivaInsightsScheduleSendSuggestions                   = $false
                    VivaInsightsWebExperience                             = $false
                }
            )
        }

        Mock -CommandName Test-M365DSCPowershellDataFile -MockWith {
            return @{
                Result = 'Passed'
            }
        }
        Mock -CommandName Get-Module -MockWith {
            return @{
                Path = 'C:\Temp\module.psd1'
                Version = [Version]'10.0.0.0'
            }
        }
        Mock -CommandName Import-PSDataFile -MockWith {
            return @{
                NonNodeData = @{
                    'Office365' = @{
                        OrgSettings = @{
                            PlannerAllowCalendarSharing                           = 'Boolean | Optional | Allow Planner users to publish their plans and assigned tasks to Outlook or other calendars through iCalendar feeds.'
                            ToDoIsExternalJoinEnabled                             = 'Boolean | Optional | To Do - Allow external users to join.'
                            ToDoIsExternalShareEnabled                            = 'Boolean | Optional | To Do - Allow sharing with external users.'
                            VivaInsightsScheduleSendSuggestions                   = 'Boolean | Optional | Specifies whether or not to allow users to have access to use the Viva Insights schedule send suggestions feature.'
                            VivaInsightsWebExperience                             = 'Boolean | Optional | Specifies whether or not to allow users to have access to use the Viva Insights web experience.'
                            VivaInsightsDigestEmail                               = 'Boolean | Optional | Specifies whether or not to allow users to have access to use the Viva Insights digest email feature.'
                            VivaInsightsOutlookAddInAndInlineSuggestions          = 'Boolean | Optional | Specifies whether or not to allow users to have access to use the Viva Insights Outlook add-in and inline suggestions.'
                            ToDoIsPushNotificationEnabled                         = 'Boolean | Optional | To Do - Allow your users to receive push notifications.'
                            InstallationOptionsAppsForMac                         = 'StringArray | Optional | Defines the apps users can install on Mac devices. | isSkypeForBusinessEnabled / isMicrosoft365AppsEnabled'
                            AdminCenterReportDisplayConcealedNames                = 'Boolean | Optional | Controls whether or not the Admin Center reports will conceale user, group and site names.'
                            InstallationOptionsUpdateChannel                      = 'String | Optional | Defines how often you want your users to get feature updates for Microsoft 365 apps installed on devices running Windows | current / monthlyEnterprise / semiAnnual'
                            InstallationOptionsAppsForWindows                     = 'StringArray | Optional | Defines the apps users can install on Windows and mobile devices. | isVisioEnabled / isSkypeForBusinessEnabled / isProjectEnabled / isMicrosoft365AppsEnabled'
                            MicrosoftVivaBriefingEmail                            = 'Boolean | Optional | Specifies whether or not to let people in your organization receive Briefing email from Microsoft Viva.'
                            DynamicsCustomerVoiceIsInOrgFormsPhishingScanEnabled  = 'Boolean | Optional | Automatically block any internal surveys that request confidential information. Admins will be notified in the Message Center when a survey is blocked.'
                            DynamicsCustomerVoiceIsRecordIdentityByDefaultEnabled = 'Boolean | Optional | Capture the first and last names of respondents in your organization that complete a survey. You can still change this for individual surveys.'
                            DynamicsCustomerVoiceIsRestrictedSurveyAccessEnabled  = 'Boolean | Optional | Capture the first and last names of respondents in your organization that complete a survey. You can still change this for individual surveys.'
                            CortanaEnabled                                        = 'Boolean | Optional | Allow Cortana in windows 10 (version 1909 and earlier), and the Cortana app on iOS and Android, to access Microsoft-hosted data on behalf of people in your organization.'
                            AppsAndServicesIsAppAndServicesTrialEnabled           = 'Boolean | Optional | Allow people in your organization to start trial subscriptions for apps and services that support trials. Admins manage licenses for these trials in the same way as other licenses in your organization. Only admins can upgrade these trials to paid subscriptions, so they won�??t affect your billing.'
                            AppsAndServicesIsOfficeStoreEnabled                   = 'Boolean | Optional | Allow people in your organization to access the Office Store using their work account. The Office Store provides access to apps that aren''t curated or managed by Microsoft.'
                            FormsIsBingImageSearchEnabled                         = 'Boolean | Optional | Allow YouTube and Bing.'
                            FormsIsInOrgFormsPhishingScanEnabled                  = 'Boolean | Optional | Phishing protection.'
                            FormsIsRecordIdentityByDefaultEnabled                 = 'Boolean | Optional | Record names of people in your org.'
                            M365WebEnableUsersToOpenFilesFrom3PStorage            = 'Boolean | Optional | Let users open files stored in third-party storage services in Microsoft 365 on the Web.'
                            FormsIsExternalShareTemplateEnabled                   = 'Boolean | Optional | External Sharing - Share the form as a template that can be duplicated.'
                            FormsIsExternalSendFormEnabled                        = 'Boolean | Optional | External Sharing - Send a link to the form and collect responses.'
                            FormsIsExternalShareCollaborationEnabled              = 'Boolean | Optional | External Sharing - Share to collaborate on the form layout and structure.'
                            FormsIsExternalShareResultEnabled                     = 'Boolean | Optional | External Sharing - Share form result summary.'
                        }
                    }
                }
            }
        } -RemoveParameterType 'Path'
    }

    Context 'Test function Convert-M365DSCExportToPowerShellDataFile' {
        It 'Should convert an export successfully' {
            Convert-M365DSCExportToPowerShellDataFile -Workload 'Office365' -SourceFile 'C:\Temp\O365.ps1' -ResultFile 'C:\Temp\O365.psd1'
            Should -Invoke Out-File
            $global:ReturnedValue.NonNodeData.Office365 | Should -BeOfType 'System.Collections.Hashtable'
            $global:ReturnedValue.NonNodeData.Office365.OrgSettings | Should -BeOfType 'System.Collections.Hashtable'
            $global:ReturnedValue.NonNodeData.Office365.OrgSettings.Count | Should -Be 26
        }
    }
}
