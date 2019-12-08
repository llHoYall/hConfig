# Docker

## Create Image

### Empty Base Image

`Docker`에서는 empty base image를 scratch image라고 한다.

`/dev/null` 장치를 이용하여 empty tar file을 만들어서 `docker`에 전달한다.

> $ tar cv --files-from /dev/null | sudo docker import - scratch

scratch image는 비어있기 때문에 container로 생성되지 않는다.

hello라는 C program을 만들어 scratch에 넣어보자. scratch image에는 아무런 library도 없으므로 static binary로 compile 해야한다.

> $ gcc hello.c -static -o hello

`Dockerfile`을 만든다.

```dockerfile
FROM scratch
ADD ./hello /hello
CMD ["/hello"]
```

Scratch image를 기반으로 새로운 image를 생성한다.

> $ sudo docker build --tag hello:0.1 .

hello:0.1 image로 container를 생성한다.

> $ sudo docker run --rm hello:0.1

C program이 구동되면 정상적으로 실행된 것이다.

## Dockerfile

`Dockerfile`은 `Docker` 이미지 설정 파일이다. `Dockerfile`에 설정된 내용대로 이미지를 생성한다.

예를 들면 다음과 같다.

```dockerfile
# Dockerfile
# Ubuntu 14.04를 기반으로 nginx server를 설치한 docker image를 생성.
FROM ubuntu:14.04
MAINTAINER llHoYall <hoya128@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

VOLUME ["/data", "/etc/nginx/site-enabled", "/var/log/nginx"]

WORKDIR /etc/nginx

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
```

위 `Dockerfile`로 이미지를 생성한 후 실행을 한다.

> $ sudo docker build --tag hello:0.1 .
>
> $ sudo docker run --name hello-nginx -d -p 80:80 -v /root/data:/data hello:0.1
