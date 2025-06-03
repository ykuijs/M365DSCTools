@{
    PSDependOptions       = @{
        AddToPath  = $true
        Target     = 'output\RequiredModules'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    InvokeBuild           = '5.12.2' #'latest' (https://github.com/gaelcolas/Sampler/issues/509)
    PSScriptAnalyzer      = 'latest'
    Pester                = 'latest'
    ModuleBuilder         = '3.1.0' #'latest' (https://github.com/gaelcolas/Sampler/issues/509)
    ChangelogManagement   = 'latest'
    Sampler               = '0.118.1' #'latest' (https://github.com/gaelcolas/Sampler/issues/509)
    'Sampler.GitHubTasks' = 'latest'
    'PowerShellGet'       = 'latest'
    'powershell-yaml'     = 'latest'
    'ObjectGraphTools'    = @{
        RequiredVersion = '0.3.2-Preview3' # Make sure you also update the module manifest with the correct version ranges
        Parameters = @{
            AllowPrerelease = $true
        }
    }
}
