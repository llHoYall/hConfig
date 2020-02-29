<# Configure VSCode for Powershell -------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -NoNewline -ForegroundColor YELLOW "vscode"
Write-Host " for Powershell"

<# Extention - Powershell #>
Write-Host -NoNewline "  => Config "
Write-Host -NoNewline -ForegroundColor DARKYELLOW "Powershell"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String ms-vscode.powershell)) {
	code --install-extension ms-vscode.powershell
}

<# Extention - Insert Unicode #>
Write-Host -NoNewline "  => Config "
Write-Host -NoNewline -ForegroundColor DARKYELLOW "Insert Unicode"
Write-Host " extension"
If ($null -eq (code --list-extensions | Select-String brunnerh.insert-unicode)) {
	code --install-extension brunnerh.insert-unicode
}
