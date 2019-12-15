#Requires -RunAsAdministrator

<# Install Meld --------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "Meld"
If (Get-Command meld -errorAction SilentlyContinue) {
  Write-Host -NoNewline "  => Upgrade "
	Write-Host -ForegroundColor DarkYellow "Meld"
	choco upgrade -y meld
} Else {
  choco install -y meld
}

<# Configure Meld ------------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor Yellow "Meld"
$AddingPath = "C:\Program Files (x86)\Meld\"
$RegPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPath = (Get-ItemProperty -Path $RegPath -Name PATH).Path
$NewPath= $OldPath + ";" + $AddingPath
Set-ItemProperty -Path $RegPath -Name PATH –Value $NewPath
