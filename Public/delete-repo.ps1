function delete-repo {
    param (
        
        [Parameter(Mandatory=$true)]
        [string] $owner,
        [Parameter(Mandatory=$true)]
        [string] $repo
        
    )

    $URI =  "https://api.github.com/repos/$owner/$repo"

    $token = "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"

    $header = @{

        Authorization = "Token $token"
        "User-Agent" = "PowerShell"
        "Content-Type"= "application/json"
    }

try{

    $response = Invoke-RestMethod -Method Delete -Uri $URI -Headers $header -Body $body
    Write-Host "New Repository [$owner] has been deleted successfully."
    return $response

} catch {
    Write-Host "An unexpected error happened. Try again later" -ForegroundColor Yellow
    Write-Host "Error message: $($_.Exception.Message)"
}

    
    
}