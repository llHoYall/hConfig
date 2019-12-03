<# Install Chocolatey --------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Chocolatey"
If (Get-Command choco -errorAction SilentlyContinue) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor Yellow "Chocolatey"
	choco upgrade -y chocolatey
} Else {
  Set-ExecutionPolicy AllSigned -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
