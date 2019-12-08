# Docker Commands

`Docker`의 명령은 `docker <command>`의 형식으로 사용한다. 또한, `docker` 명령은 root 권한으로 실행해야 한다.

## `search` - Image 검색

```sh
$ sudo docker search <image_name>
```

> Ex) $ sudo docker search ubuntu

## `pull` - Image 받기

```sh
$ sudo docker pull <image_name>:<tag>
```

> Ex) $ sudo docker pull ubuntu:latest

## `images` - Image 목록 출력

```sh
$ sudo docker images
```

## `run` - Container 생성

```
$ sudo docker run <option> <image_name> <command>
```

* `-d` : Run container in background
*	`--expose <list>` : Expose a port or a range of ports
*	`-i` : Interactive
*	`--link <list>` : Add link to another container
*	`--privileged` : Give extended privileges to this container
*	`-p <host port>:<container port>` : Publish a container's port to the host
*	`--rm` : Automatically remove the container when it exits
*	`-t` : Allocate pseudo-tty
*	`-v <list>` : Bind mount a volume
*	`--volumes-from <list>` : Mount volumes from the specified container
*	`--name <string>` : Container name

Ex) ubuntu image를 hello라는 이름의 container로 생성한 뒤, image 안의 `/bin/bash` 명령을 실행한다.

> Ex) $ sudo docker run -i -t --name hello ubuntu /bin/bash

Ex) hello:0.1 image를 hello-nginx라는 이름의 container로 생성한 뒤, background로 실행한다. container의 80 port를 host의 80 port와 연결하고, container의 /data directory를 host의 /root/data directory에 연결한다.

> Ex) $ sudo docker run --name hello-nginx -d -p 80:80 -v /root/data:/data hello:0.1

## `ps` - Container 목록 출력

```sh
$ sudo docker ps <option>
```

- `-a` : 정지된 container까지 출력한다.

> Ex) $ sudo docker ps -a

## `start` - Container 시작

```sh
$ sudo docker start <container_name>
```

> Ex) $ sudo docker start hello

## `restart` - Container 재시작

```sh
$ sudo docker restart <container_name>
```

> Ex) $ sudo docker restart hello

## `attach` - Container 접속

```sh
$ sudo docker attach <container_name>
```

> Ex) $ sudo docker attach hello

## `exec` - 외부에서 container 내부 명령 실행

```sh
$ sudo docker exec <container_name> <command> <arguments>
```

Ex) hello라는 이름의 container 안의 echo 명령을 "Hello World!" 인자와 함께 실행한다.

> $ sudo docker exec hello echo "Hello World!"

## `stop` - Container 정지

```sh
$ sudo docker stop <container_name>
```

> Ex) $ sudo docker stop hello

## `rm` - Container 삭제

```sh
$ sudo docker rm <container_name>
```

> Ex) $ sudo docker rm hello

## `rmi` - Image 삭제

```sh
$ sudo docker rmi <image_name>:<tag>
```

> Ex) $ sudo docker rmi ubuntu:latest

## `build` - Image 생성

```sh
$ sudo docker build <option> <Dockerfile path>
```

> Ex) $ sudo docker build --tag hello:0.1 .

## `history` - Image history 보기

```sh
$ sudo docker history <image_name>:<tag>
```

> Ex) $ sudo docker history hello:0.1

## `cp` - File 꺼내기

```sh
$ sudo docker cp <container_name>:<path> <host path>
```

Ex) 현재 directory에 nginx.conf file을 복사

> Ex) $ sudo docker cp hello-nginx:/etc/nginx/nginx.conf ./

## `commit` - Container의 변경사항을 image로 생성

```sh
$ sudo docker commit <option> <container_name> <image_name>:<tag>
```

* `-a <string>` : Author
* `-m <string>` : Commit message

> Ex) $ sudo docker commit -a "HoYa \<hoya128@gmail.com>" -m "add files" hello-nginx hello:0.2

## `diff` - Container에서 변경된 file 출력

```sh
$ sudo docker diff <container_name>
```

> Ex) $ sudo docker diff hello-nginx

## `inspect` - 세부 정보 출력

```sh
$ sudo docker inspect <image_name or container_name>
```

* `-f <string>` : Format the output using the given Go template

> Ex) $ sudo docker inspect hello-nginx

Ex) web container의 세부 정보에서 hosts file 경로를 구한 뒤 출력한다.

> Ex) $ cat \`sudo docker inspect -f "{{ .HostsPath }}" web\`