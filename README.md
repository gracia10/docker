# docker

## 컨테이너 기반 가상화 플랫폼

- 프로그램, 실행환경을 '컨테이너'로 추상화  
- 컨테이너 단위로 프로그램 배포, 테스트  

## 배경 
* VMare, VirtualBOx  전체OS 가상화 -> 종속성 설치, 무겁고 느림.  
* CPU 가상화 KVM, 반가상화 Xen    ->  여전한 성능문제  
 
* 프로세스 격리 방식 등장  
- 프로세스를 필요한 만큼 추가하고 격리함 -> 손실제로  
- 컨테이너 별 yum , apt-get으로 설치 가능  

```
[이미지]  
- 컨테이너 실행에 필요한 파일과 설정값이 저장되어있다.  
- 상태값 없다. 변경되지 않는다.  
- 한 개의 이미지로 여러 컨테이너 생성 가능하다.  
- 이미지 관리 -> Docker hub , Docker Registry  

* mysql 이미지- mysql 실행을 위한 파일,명령어,포트 정보를 가짐  


[컨테이너]  
- 이미지를 실행한 상태.  
- 추가, 변경되는 값이 저장된다.  
- 호스트 컴퓨터의 프로세스와 격리된 프로세스  

```

## 이미지 저장방식 - 레이어  

* 의존성 파일을 컴파일, 설치헤야 했음 -> 무거움  
* 각 이미지를 레이어로 구성. 합쳐서 하나의 파일시스템으로 사용  
- 특정 이미지 추가 + 수정시 해당 레이어만 추가 변경하면 됨   
- 최소한의 용량만 사용  
  
  
## 이미지 관리방식  
- url 방식으로 관리.   
- 태그를 붙일 수 있음. (테스트, 롤백 시 용이함)  
- [DockerFile] 이라는 파일에서 버전관리  

---
## 실전 (윈도우)  

0) 사전작업  
- 작업관리자 >  가상화 사용여부 체크  
- 제어판 > window기능 켜기/끄기 > 가상플랫폼 기능 활성  
- 최신 OS , 최신 WSL2 linux kernel  

1) Docker for Windows파일 설치  
https://docs.docker.com/docker-for-windows/install/  

- shell > docker -v 체크  
 
2) Docker ID 생성 로그인  

---
## docker 명령어

docker -v           - 한줄 요약 도커 정보    
docker version      - 자세한 도커 정보  
docker image ls     - 도커 이미지 조회  

docker login -u {DockerID}                - Docker Hub 로그인  
docker tag {image name} {new image name}  - 이미지 새이름으로 복사  

---
## 어플 배포 - 컨테이너 이미지 생성  

Dockerfile 	        - 컨테이너 이미지 설정 스크립트  

docker build 	      - 컨테이너 이미지 생성 명령어. Dockerfile 읽음  
  -t {image Name}	  - 이미지 저장소, 이미지 이름 지정  
.	  	              - docker build 종료 명령어  

--- 
## 컨테이너 실행, 조회, 제거 

docker run -d -p 80:80 {imgae}         == -dp   
-d 	      - 백그라운드 실행  
-p 80:80	- 호스트 포트 80을 컨터이네 포트80에 매핑  
{imgae}	  - 사용할 이미지 이름  

docker ps             - 실행중인 컨테이너 조회  
docker stop {conID}   - 컨테이너 중지  
docker rm {conID}     - 컨테이너 제거 (중지된 상태만 제거가능)  
docker rm -f {conID}  - 컨테이너 즉시 제거  

---  
## 이미지 공유 & push  
   
- Docker 이미지는 Docker registry(* Docker Hub) 에서 공유한다   
- Docker Hub 로그인 -> registry 생성 -> registry 로 image push   

docker push {DockerID}/{registry Name}:tagname   
'{DockerID}/{registry Name}' 이미지를 찾음  
:tagname  이미지 이름의 태그 없을 경우 'latest' 호출  

---

  
---
> Docker Hub - the world’s largest library and community for container images  

> [Docker lab](https://labs.play-with-docker.com/)  

> [Docker error](/Docs/error.md)  
  
  

