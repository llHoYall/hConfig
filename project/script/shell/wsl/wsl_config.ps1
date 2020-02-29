<# Install WSL ---------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "WSL"
If (Get-Command wsl -errorAction SilentlyContinue) {
	Write-Host "     Already installed."
} Else {
  choco install -y wsl
}

<# Ubuntu v18.04 #>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Ubuntu (on WSL)"
If (choco list --localonly | grep wsl-ubuntu) {
	Write-Host "     Already installed."
} Else {
  choco install -y wsl-ubuntu-1804
}
