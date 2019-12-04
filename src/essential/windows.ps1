<# Install Chocolatey --------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Chocolatey"
If (Get-Command choco -errorAction SilentlyContinue) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor DarkYellow "Chocolatey"
	choco upgrade -y chocolatey
} Else {
  Set-ExecutionPolicy AllSigned -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

<# Install Fonts -------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Fonts"
<# Cascadia Code #>
If (Test-Path C:\Windows\Fonts\Cascadia.ttf) {
	Write-Host -NoNewline "  => Upgrade "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Cascadia Code "
	Write-Host font
  choco upgrade -y cascadiacode
} Else {
	Write-Host -NoNewline "  => Install "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Cascadia Code "
	Write-Host font
	choco install -y cascadiacode
}