<# Install VSCode ------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor YELLOW "vscode"
If (Get-Command code -errorAction SilentlyContinue) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor DarkYellow "vscode"
	choco upgrade -y vscode
} Else {
	choco install -y vscode
}

<# Configure VSCode ----------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor YELLOW "vscode"

<# Extention - Git Lens #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "Git Lens"
If ((code --list-extensions | Select-String eamodio.gitlens) -eq $False) {
	code --install-extension eamodio.gitlens
}

<# Extention - Git History #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "Git History"
If ((code --list-extensions | Select-String donjayamanne.githistory) -eq $False) {
	code --install-extension donjayamanne.githistory
}
