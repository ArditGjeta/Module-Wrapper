function update-git {
    param (
        
        [Parameter(Mandatory=$true)]
        [string] $name,
        [Parameter(Mandatory=$true)]
        [string] $repo,
        [string] $RepoNewName,
        [string] $desc
        
    )

    $URI =  "https://api.github.com/repos/$name/$repo"

    $token = $Env:GITHUB_TOKEN

    $header = @{

        Authorization = "Bearer $token"
        "User-Agent" = "PowerShell"
        "Content-Type"= "application/json"
    }

    $body = @{

        name = $RepoNewName
        description = $desc
        # private = $private This works for organization accounts only
        
        
    } | ConvertTo-Json

try{

    $response = Invoke-RestMethod -Method Patch -Uri $URI -Headers $header -Body $body
    Write-Host "New Repository [$name] has been updated successfully."
    return $response

} catch {
    Write-Host "An unexpected error happened. Try again later" -ForegroundColor Yellow
    Write-Host "Error message: $($_.Exception.Message)"
}

    
    
}