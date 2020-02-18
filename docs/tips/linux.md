# Tips: Linux

## ToC

* [Accounts](#Accounts)
* [Shell](#Shell)
* [Process Management](#Process-Management)
* [Create SSH Key](#Create-SSH-Key)
* [Signal](#Signal)
* [IPC](#IPC)

----

## [Accounts]

### Add User

* `useradd` : User 기본 설정을 자동으로 하지 않음.
* `adduser` : User 기본 설정을 자동으로 함.

### Change Password

* `passwd` : Login한 user ID의 password를 변경한다.

### Give the Privilege

> sudo vi /etc/sudoers

다음의 line을 찾아서 원하는 user를 추가한다.

```sh
# User privilege specification
root    ALL=(ALL:ALL) ALL
hoya    ALL=(ALL:ALL) ALL   # << Added
```

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

### Redirection

입출력 stream의 방향을 바꿔준다.

* `<` : stdin의 direction을 바꿔준다. (덮어쓰기)
* `>` : stdout의 direction을 바꿔준다. (덮어쓰기)
* `<<` : stdin의 direction을 바꿔준다. (붙여넣기)
* `>>` : stdout의 direction을 바꿔준다. (붙여넣기)

### Pipe

두 process 사이에서 앞 process의 stdout을 뒤 process의 stdin으로 사용한다.

## [Process Management]

* `ps` : 현재 작업중인 process를 보여준다.
* `jobs` : Background 실행 중이나 suspend 상태인 process를 보여준다.

### Process ID

Process ID의 최대값은 32768이다.

> /proc/sys/kernel/pid_max

### Terminate Process

> $ kill -9 PID

명시된 process를 끝낸다.

* `<CTRL> + z` : Foreground process를 suspend mode로 변경한다.
  + 가장 마지막에 suspend된 process는 `bg`명령으로 background process로 실행할 수 있다.
* `<CTRL> + c` : Process 종료.

* `exit()` system call
  + atexit()에 등록된 함수 실행
  + 열려있는 모든 입출력 stream buffer 삭제
  + Process가 오픈한 file을 모두 닫음
  + tmpfile() function을 통해 생성한 임시 file 삭제

### Background Process

* `&` : Command 끝에 `&`를 붙이면 background로 실행된다.

### Process Create

* `fork()`
  + 새로운 process 공간을 별도로 만들고, parent process 공간을 모두 복사한다.
* `exec()`
  + Parent process 공간의 TEXT, DATA, BSS 영역을 child process의 image로 덮어쓴다.

### Process Owner

> /etc/passwd

## [Create SSH Key]

사용자의 ssh 키들은 기본적으로 `~/.ssh` directory에 저장한다.

`~/.ssh` directory를 보면 `id_dsa.pub`나 `id_rsa.pub` file이 있는데, 이것이 공개키이고 `id_dsa`나 `id_rsa` file이 개인키이다.

만약 directory가 없거나 directory 안에 이런 file들이 없다면 만들어야 한다.

> $ ssh-keygen

MAC과 Linux에는 기본적으로 SSH package에 포함되어 있고, Windows의 경우 MSYS 등의 유틸리티를 설치하면 들어있다.

## [Signal]

Kernel or Process에서 다른 Process에 어떤 event가 발생되었는지를 알려주는 방법.

*  2 SIGINT : `<CTRL> + c`
*  9 SIGKILL
* 11 SIGSEGV
* 14 SIGALRM
* 18 SIGCONT
* 19 SIGSTOP : `<CTRL> + z`

## [IPC]

Inter-Process Communication

1. File
2. Message Queue
3. Shared Memory
4. Pipe
5. Signal
6. Semaphore
7. Socket
