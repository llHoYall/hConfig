# Powershell

## Profile Configuration

### Location of `Old` Version

> C:\Users\<UserName>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

### Location of `New` Version

> C:\Users\<UserName>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

## Module Configuration

### Check Module Path

> $Env:PSModulePash -Split ';'

```sh
# Old
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
# New
C:\<UserName>\1000263967\Documents\PowerShell\Modules
C:\Program Files\PowerShell\Modules
c:\program files\powershell\7-preview\Modules
```

### Install Modules

> $ Install-Module -Name \<ModuleName> -Scope \<AllUsers|CurrentUser> -Force

### Use Modules

> $ Import-Module -Name \<ModuleName>

### My Favorite Module

#### posh-git

This module helps using `git`. 현재 folder가 git repository인 경우 해당 정보가 prompt에 나타나고, 해당 정보를 편집도 가능하다.

#### PSColor

PowerShell에 색상을 입혀준다.

#### PSReadLine

v5까지는 설치를 해야했지만, v6부터는 기본적으로 포함이 되어 있어 따로 설치를 할 필요가 없다.

This module contains cmdlets that let you customize the command-line editing environment in PowerShell.
