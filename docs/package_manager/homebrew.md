# Homebrew

MAC에서 사용되는 package manager이다.

* `cask`

Web site를 통해서 다운받는 Google Chrome과 같은 application을 설치할 수 있다.

* `mas`

App store를 통해서 다운받는 Kakao Talk과 같은 application을 설치할 수 있다.

## Installation

### Homebrew

> $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### cask

Homebrew 최신 version에 내장되어 있다.

### mas

> $ brew install mas

## Usage

### BrewFile

BrewFile에 설치하고 싶은 application의 목록을 저장한 후, 이를 한 번에 설치할 수 있다.

BrewFile의 예는 다음과 같다.

```sh
# BrewFile
brew "mas"
brew "git
cask "google-chrome"
cask "docker"
mas "KakaoTalk", id: 869223134
```

BrewFile이 저장된 folder로 이동한 후, 다음의 명령어를 입력하면 설치를 한다.

> $ brew bundle

현재 MAC에 설치된 application들을 BrewFile로 저장하려면 다음의 명령어를 입력한다.

> $ brew bundle dump

### Help

> $ brew help [command]

### List

> $ brew list

> $ brew cask list

### Search

> $ brew search \<name>

> $ mas search \<name>

### Install

> $ brew install [program]

### Link

> $ brew link --overwrite [program]

### Uninstall

> $ brew uninstall [program]
