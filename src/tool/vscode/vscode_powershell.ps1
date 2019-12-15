<# Configure VSCode for Powershell -------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -NoNewline -ForegroundColor YELLOW "vscode"
Write-Host " for Powershell"

<# Extention - Powershell #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "Powershell"
If ((code --list-extensions | Select-String ms-vscode.powershell) -eq $False) {
	code --install-extension ms-vscode.powershell
}

<# Extention - Insert Unicode #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "Insert Unicode"
If ((code --list-extensions | Select-String brunnerh.insert-unicode) -eq $False) {
	code --install-extension brunnerh.insert-unicode
}
