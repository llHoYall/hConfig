# Tips: Linux

## ToC

* [Shell](#Shell)
* [Process Management](#Process-Management)
* [Create SSH Key](#Create-SSH-Key)

----

## [Shell]

### Running shell script

* Method 1 - Executing

> $ ./script.sh

A script will run the commands in a ***new*** shell process.

* Method 2 - Sourcing

> $ source ./script.sh
>
> or
>
> $ . ./script.sh

A script will run the commands in the ***current*** shell process.

## [Process Management]

> $ ps

현재 작업중인 process를 보여준다.

> $ kill -9 PID

명시된 process를 끝낸다.

## [Create SSH Key]

사용자의 ssh 키들은 기본적으로 `~/.ssh` directory에 저장한다.

`~/.ssh` directory를 보면 `id_dsa.pub`나 `id_rsa.pub` file이 있는데, 이것이 공개키이고 `id_dsa`나 `id_rsa` file이 개인키이다.

만약 directory가 없거나 directory 안에 이런 file들이 없다면 만들어야 한다.

> $ ssh-keygen

MAC과 Linux에는 기본적으로 SSH package에 포함되어 있고, Windows의 경우 MSYS 등의 유틸리티를 설치하면 들어있다.
