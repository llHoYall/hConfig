<# Configure VSCode for AutoHotkey -------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -NoNewline -ForegroundColor YELLOW "vscode"
Write-Host " for AutoHotkey"

<# Extention - AutoHotkey #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "AutoHotkey"
If ((code --list-extensions | Select-String slevesque.vscode-autohotkey) -eq $False) {
	code --install-extension slevesque.vscode-autohotkey
}
