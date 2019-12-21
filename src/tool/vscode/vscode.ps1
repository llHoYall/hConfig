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
Write-Host -NoNewline -ForegroundColor DARKYELLOW "Git Lens"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String eamodio.gitlens)) {
	code --install-extension eamodio.gitlens
}

<# Extention - Git History #>
Write-Host -NoNewline "  => Config "
Write-Host -NoNewline -ForegroundColor DARKYELLOW "Git History"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String donjayamanne.githistory)) {
	code --install-extension donjayamanne.githistory
}

<# Extention - Highlight Words #>
Write-Host -NoNewline "  => Config "
Write-Host -NoNewline -ForegroundColor DARKYELLOW "Highlight Words"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String rsbondi.highlight-words)) {
	code --install-extension rsbondi.highlight-words
}

<# VSCode Configuration File #>
Copy-Item $PSScriptRoot/*.json -Destination "$env:APPDATA/Code/User"
