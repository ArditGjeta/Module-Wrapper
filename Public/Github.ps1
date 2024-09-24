


function get-userHub {
    param (
        [string]$Username
    )

    $uri = "https://api.github.com/users/$Username"

    $header = @{ 
        
        #'Authorization:'='= Bearer ACCESS_TOKEN'
        'User-Agent' = 'PowerShell' 
    }

    $token = 'ACCESS_TOKEN'
    $tokenn = ConvertTo-SecureString $token -AsPlainText -Force

    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $header -Authentication Bearer -Token $tokenn
    $ref = "heaeds/main"
    
    # Get the SHA of the lates commit on the branch you want to update
    $branchUri = 'https://api.github.com/repos/$Username/PowerShell-app/git/$ref'
    
    $branch = Invoke-RestMethod -Uri $branchUri -Method Get
}