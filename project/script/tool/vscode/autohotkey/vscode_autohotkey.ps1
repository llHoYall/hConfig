<# Configure VSCode for AutoHotkey -------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -NoNewline -ForegroundColor YELLOW "vscode"
Write-Host " for AutoHotkey"

<# Extention - AutoHotkey #>
Write-Host -NoNewline "  => Config "
Write-Host -NoNewline -ForegroundColor DARKYELLOW "AutoHotkey"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String slevesque.vscode-autohotkey)) {
	code --install-extension slevesque.vscode-autohotkey
}
