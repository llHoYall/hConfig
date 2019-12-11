<# Install Git ---------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Git"
If (Get-Command git -errorAction SilentlyContinue) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor DarkYellow "Git"
	choco upgrade -y git
} Else {
	choco install -y git
}

<# Configure Git -------------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor Yellow "Git"

# color.ui
git config --global color.ui auto

# help.autocorrect
git config --global help.autocorrect 1

# pull.rebase
git config --global pull.rebase true

# push.default
git config --global push.default simple

# rerere.enabled
git config --global rerere.enabled true
