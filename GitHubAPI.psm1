$modulePublicPath = Join-Path $PSScriptRoot "Public"

Get-ChildItem -Path $modulePublicPath -Filter "*.ps1" | ForEach-Object {
    . $_.FullName

    $functionName = $_.BaseName
    Export-ModuleMember -Function $functionName
}