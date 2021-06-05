#!/bin/bash
trap "exit" SIGINT
mkdir /var/htdocs
while :
do 
 echo ${date} Writing fortune to /var/htdocs/index.html
 /usr/games/fortune > /var/htdocs/index.html
 sleep S
done


# 5초 한번씩 명언을 출력하는 어플리케이션