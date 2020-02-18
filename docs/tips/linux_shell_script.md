# Linux Shell Script

* Shebang으로 시작해야 한다.
  ```sh
  #!/bin/bash
  ```
* Shell script file은 실행 권한을 가지고 있어야 한다.
* 주로 `.sh`를 확장자로 갖는다.
* `$()` 문법으로 shell 명령을 실행한다.

## Standard I/O

```sh
# Standard Output
echo 'Hello Shell Script !!!'
```

## Variables

변수의 선언은 `variable_name=data`와 같이 한다. `=` 앞, 뒤에는 공백이 없어야 한다.

변수의 사용은 `$` 기호를 붙여준다.

```sh
var='test string'
echo $var
```

리스트 배열 변수의 선언은 `variable_name=(data1 data2 ...)`과 같이 한다.

리스트 배열 변수의 사용은 `${}` 기호를 붙여준다.

```sh
vars=("hello" "shell" "script")
echo ${vars[1]}   # shell
echo ${vars[*]}   # all datas
echo ${vars[@]}   # all datas
echo ${#vars[@]}  # 3 (Size)
```

내장 변수는 다음과 같다.

* `$$` : Shell의 process ID
* `$0` : Whell script의 이름
* `$1` ~ `$9` : Command line arguments
* `$*` : 모든 command line arguments (`$0` 제외)
* `$#` : Arguments 개수 (`$0` 제외)
* `$?` : 최근 실행한 명령의 종료 값
  + 0 : 성공
  + 1 ~ 125 : Error
  + 126 : 실행 불가능
  + 128 ~ 255 : Signal 발생

## Operator

Backtick과 `expr`를 사용하여 연산을 할 수 있다.

`*`와 `()`등은 escape를 해줘야 한다. 또한, 연산자와 숫자, 변수, 기호 사이에는 공백을 넣어야 한다.

```sh
num=`expr \( 3 \* 5 \) / 3 + 7`
echo $num
```

## Control Flow

조건문은 `if then ~ fi`를 사용한다.

```sh
if [ condition ]
then
  statement
fi
```

반복문은 `for in do ~ done`, `while do ~ done`을 사용한다.

```sh
for VARIABLE in VALUE1 VALUE2 ...
do
  statement
done

while [ CONDITION ]
do
  statement
done
```

## Condition

* `STR1 == STR2` : 일치하면 참
* `STR1 != STR2` : 일치하지 않으면 참
* `-z STR` : null string이면 참
* `-n STR` : null string이 아니면 참

* `VALUE1 -eq VALUE2` : 값이 일치하면 참
* `VALUE1 -ne VALUE2` : 값이 일치하지 않으면 참
* `VALUE1 -lt VALUE2` : VALUE1이 VALUE2보다 작으면 참
* `VALUE1 -le VALUE2` : VALUE1이 VALUE2보다 작거나 같으면 참
* `VALUE1 -gt VALUE2` : VALUE1이 VALUE2보다 크면 참
* `VALUE1 -ge VALUE2` : VALUE1이 VALUE2보다 크거나 같으면 참

* `-e FILE` : File이 존재하면 참
* `-d FILE` : Directory가 존재하면 참
* `-h FILE` : Symbolic liunk file이면 참
* `-f FILE` : 일반 file이면 참
* `-r FILE` : 읽기 가능한 file이면 참
* `-w FILE` : 쓰기 가능한 file이면 참
* `-x FILE` : 실행 가능한 file이면 참
* `-s FILE` : File size가 0이 아니면 참
* `-u FILE` : set-user-id가 설정된 file이면 참

* `CONDITION1 -a CONDITION2` : And 연산
* `CONDITION1 -o CONDITION2` : Or 연산
* `CONDITION1 && CONDITION2` : And 연산 (오동작 시 `[[]]` 사용)
* `CONDITION1 || CONDITION2` : Or 연산 (오동작 시 `[[]]` 사용)
* `!CONDITION` : Not 연산
* `true` : True
* `false` : False
