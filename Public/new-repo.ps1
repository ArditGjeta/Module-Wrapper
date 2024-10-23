function new-repo {
    param (
        
        [Parameter(Mandatory=$true)]
        [string] $name,
        [string] $description,
        [string] $readme
    )

    $URI =  "https://api.github.com/user/repos"

    $token = "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"

    $header = @{

        Authorization = "Bearer $token"
        "User-Agent" = "PowerShell"
        "Content-Type"= "application/json"
    }

    $body = @{

        name = $name
        description = $description
        readme = $readme
        
    } | ConvertTo-Json

    try{

        $response = Invoke-RestMethod -Method Post -Uri $URI -Headers $header -Body $body
        Write-Host "New Repository [$name] has been created successfully."
        return $response
    
    } catch {
        Write-Host "An unexpected error happened. Try again later" -ForegroundColor Yellow
        Write-Host "Error message: $($_.Exception.Message)"
    }

    
    
}