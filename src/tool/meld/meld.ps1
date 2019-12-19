#Requires -RunAsAdministrator

<# Install Meld --------------------------------------------------------------#>
function Meld_Install() {
  Write-Host -NoNewline " ==> Install "
  Write-Host -ForegroundColor Yellow "Meld"
  If (Get-Command meld -errorAction SilentlyContinue) {
    Write-Host -NoNewline "  => Upgrade "
    Write-Host -ForegroundColor DarkYellow "Meld"
    choco upgrade -y meld
  } Else {
    choco install -y meld
  }
}

<# Configure Meld ------------------------------------------------------------#>
function Meld_Config() {
  Write-Host -NoNewline " ==> Config "
  Write-Host -ForegroundColor Yellow "Meld"
  $AddingPath = "C:\Program Files (x86)\Meld\;C:\Program Files (x86)\Meld\lib"
  $RegPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
  $OldPath = (Get-ItemProperty -Path $RegPath -Name PATH).Path
  $NewPath= $OldPath + ";" + $AddingPath
  Set-ItemProperty -Path $RegPath -Name PATH –Value $NewPath
}

<# Run Script ----------------------------------------------------------------#>
Meld_Install
Meld_Config
