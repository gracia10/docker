# docker

### 컨테이너 기반 가상화 플랫폼

- 프로그램, 실행환경을 '컨테이너'로 추상화  
- 컨테이너 단위로 프로그램 배포, 테스트  

### 배경  
* VMare, VirtualBOx  전체OS 가상화 -> 종속성 설치, 무겁고 느림   
* CPU 가상화 KVM, 반가상화 Xen    ->  여전한 성능문제  
* 프로세스 격리 방식 등장  
- 프로세스를 필요한 만큼 추가하고 격리함       

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

### 이미지 저장방식 - 레이어  

* 의존성 파일을 컴파일, 설치헤야 했음 -> 무거움  
* 각 이미지를 레이어로 구성. 합쳐서 하나의 파일시스템으로 사용  
- 특정 이미지 추가 + 수정시 해당 레이어만 추가 변경하면 됨   
- 최소한의 용량만 사용  
  
  
### 이미지 관리방식  
- url 방식으로 관리. AAA/BBB
- 태그를 붙일 수 있음. (테스트, 롤백 시 용이함)  
- [DockerFile] 이라는 파일에서 버전관리  

---
### 실전 (윈도우)  

0) 사전작업  
- 작업관리자 > 성능 > CPU >가상화 사용여부 확인  
- 제어판 > 프로그램 > window기능 켜기/끄기 > 가상플랫폼 기능 활성  
- 최신 OS , 최신 WSL2 linux kernel  

1) Docker for Windows파일 설치  
https://docs.docker.com/docker-for-windows/install/  

- shell > docker -v 체크  
 
2) Docker ID 생성 로그인  

<!> WSL 2 installation is imcomplete  - 커널 업데이트가 안되어 발생함 업데이트 하고 리스타트.

---
## docker 명령어  

docker -v                   - 한줄 요약 도커 정보     
docker version              - 자세한 도커 정보    

docker login                - Docker Hub 로그인  
docker search {imgae}       - Hub 이미지 조회  
docker pull {image:version} - Hub 이미지 다운  

docker images               - 도커 이미지 조회 (image list , image ls)    
docker image tag {old} {new}- 이미지 이름 변경   
docker build -t {name} .    - 이미지 빌드. Dockerfile 읽음. 어플배포  
docker rmi {image}          - 이미지 제거 (docker image rm) untaged vs deleted  

docker logs -f {conID}      - 컨테이너 로그 조회  
docker ps -a                - 컨테이너 조회   
docker ps                   - 실행중인 컨테이너 조회  

docker run                  - 컨테이너 실행
 --name {name}              - 컨테이너 네임 지정. container ID 대신 쉽게 접근  
 -p 80:80   
 -it                        - 컨테이너를 종료하지 않은체 컨테이너 쉘 접근. exit시 나가기. ctrl+p , ctrl+
 -d                         - 백그라운드  
{image}                       

docker rename {old} {new}   - 컨테이너 이름 변경
docker start {name}         - 컨테이너 실행. state up 
docker attach {name}        - 실행중인 컨테이너의 쉘 접속 
docker restart {name}       - 컨테이너 재실행
docker stop {name}          - 컨테이너 중단. state exited. state layer 유지 (디스크,메모리에 저장된 파일)
docker rm {name}            - 칸테이너 삭제. state layer 제거  

docker tag {image} {id/name:tag}  - 도커 허브에 올리기 위해 태그로 변경  
docker push {id/name:tag}         - 도커 허브에 등록 (tag 기본값 *latest)  


docker network create {name}      - 도커 네트워크. 컨테이너 끼리 통신하기 위한 논리적 네트워크 

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


docker tag {image} {DockerID/repository:tag} - 이미지 새이름으로 복사  
docker push {DockerID/repository:tag}   

---
## 컨테이너 파일시스템

- 각 컨테이너는 파일을 생성/수정/삭제 하는 'scratch space' 를 갖는다.  
- 컨테이너 생성시 스크래치 공간이 할당되고, 삭제시 스크래치는 제거된다.
- 각 컨테이너의 스크래치는 호스트로 이스케이프 되지 않는다.
- 동일한 이미지를 사용해도 다른 컨테이너에서 확인할 수 없다.
 
```
docker run -d {ubuntu} `
 bash -c "shuf -i 1-10000 -n 1 -o /data.txt && tail -f /dev/null" `

docker exec {conID} cat /data.txt       - 실행 컨테이너 커맨드로 접근
docker run -it {ubuntu} ls `
```

---
## 컨테이너간 데이터 유지, 리소스 공유 - Volumes  

Volumes  
- 컨테이너별 파일시스템 path 를 호스트에 연결한다.
- 볼륨 생성 후 데이터가 저장된 디렉토리를 연결(마운트)하면 캡쳐/데이터가 유지된다.
- Docker 엔진이 지원하는 주요 볼륨 유형
  - bind mounts     - 로컬 개발 설정에 사용. 
  - named volumes   

```
1) named volumes

docker volume create {volName}              - 볼륨생성
docker run -v {volName:/etc/todos} {image}  - 볼륨을 연결해 컨테이너 실행
docker volume inspect {volName}             - 데이터의 실 저장 정보 조회 (Mountpoint)

2) bind mounts 

docker run -dp 3000:3000 `          
     -w /app `                     - 'working directory' or 명령이 실행될 현재 디렉토리 설정
     -v "$(pwd):/app" `            - 컨테이너의 host에서 현재 디렉토리 마운트
     node:12-alpine `              - 사용할 이미지
     sh -c "yarn install && yarn run dev"   - sh 로 셸 스크립트 실행
```


  
---
> Docker Hub - the world’s largest library and community for container images  
  
> SQLite Database - relational database in which all of the data is stored in a single file.

> Scratch space - 임시 데이터 저장 목적 HDD or SSD 공간

> Container escape - 컨테이너 접근 권한이 있는 공격자가 컨테이너에서 탈출해 호스트로 접근 

> [Docker lab](https://labs.play-with-docker.com/)  

> [Docker error](/Docs/error.md)  

> [Docker wiki](https://github.com/gracia10/docker/wiki)
