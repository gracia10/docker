# Docker Error

### error during connect: This error may indicate that the docker daemon is not running.  
: Post "http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.24/containers/create"  
: open //./pipe/docker_engine: The system cannot find the file specified.  
  
- docker build , run 명령치니 발생  
- 해결 : docker 재실행  

### Error response from daemon: driver failed programming external connectivity on endpoint reverent_buck  
(6221bd9ebe7466d69ca5f3b42670f77fbda2e9fa6f2e680ecc51b54ceaea344c)  
: Bind for 0.0.0.0:3000 failed: port is already allocated.  

- 해당 포트로 다른 프로세스(컨테이터 포함)가 사용 중  
- 해결 : 이전 컨테이너 제거  
