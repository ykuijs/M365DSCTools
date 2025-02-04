@{
    PSDependOptions             = @{
        AddToPath  = $true
        Target     = 'output\RequiredModules'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    InvokeBuild                 = 'latest'
    PSScriptAnalyzer            = 'latest'
    Pester                      = 'latest'
    ModuleBuilder               = 'latest'
    ChangelogManagement         = 'latest'
    Sampler                     = '0.118.1'
    'Sampler.GitHubTasks'       = 'latest'
    'PowerShellGet'             = 'latest'
    'powershell-yaml'           = 'latest'
    'ObjectGraphTools'          = '0.2.1' # Make sure you also update the module manifest with the correct version ranges
}
