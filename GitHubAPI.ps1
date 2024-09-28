function get-ref {
   param (
   [string]$RepOwner,
   [string]$RepoName,
   [string]$Path
   )
    
$uri = "https://api.github.com/repos/$RepOwner/$RepoName/contents/$Path"

if (-not $uri) {
    Write-Output " The Path is not correct!"
    return
}
$header = @{ "User-Agent" = "Powershell" }
try {
    $resp = Invoke-RestMethod -Uri $uri -Method Get -Headers $header
$base64String = $resp.content
$contentt = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($base64String))
$Shas = $resp.sha
}
catch {
    Write-Host "An unexpected error happend when getting API response from server. `nTry again later" -ForegroundColor Yellow
}


    $NewContent = Read-Host "Enter your update: "

    $enCode = $contentt + "`n" + $NewContent 

    $NewContentBytes = [System.Text.Encoding]::UTF8.GetBytes($enCode)
    $bytes = [Convert]::ToBase64String($NewContentBytes)

   # Remember, you have to set token as enviroment variable $env:GITHUB_TOKEN = "YOUR TOKEN"
   $token = $env:GITHUB_TOKEN

    

$header = @{
    

    Authorization = "Bearer $token"
    "User-Agent" = "PowerShell"
}

   
       $url = "https://api.github.com/repos/ArditGjeta/Powershell-app/contents/README.md"


    $body = @{
        
        message = "Updated README From Powershell API Module"
        content = $bytes
        sha = $Shas 
    
      } | ConvertTo-Json

        $respond = Invoke-RestMethod -Uri $url -Method Put -Body $body -Headers $header 
        return $respond
        if($respond){
            Write-Host "Request was Successful. Response received." -ForegroundColor Green
        } else {
            Write-Host "Request was successful but not response received" -ForegroundColor Yellow
        }
}


Write-Host "Welcome to GitHub API 1.0 Module Wrapper
`nBelow we will guide you on how to use the script"

$Username = Read-Host "Enter your Username: "
$Repos = Read-Host "Enter the name of Repository: "
$File = Read-Host "Enter the file or the path of the file: Format req. [folder/file.ps1] "
get-ref -RepOwner $Username -RepoName $Repos -Path $File
