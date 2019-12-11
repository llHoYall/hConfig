<# Install Docker ------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Docker"
If (Get-Command docker -errorAction SilentlyContinue) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor DarkYellow "Docker"
	choco upgrade -y --pre docker-desktop
} Else {
	choco install -y --pre docker-desktop
}

<# Configure Docker ----------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor Yellow "Docker"
If (Get-Command docker -errorAction SilentlyContinue) {
	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}
