FROM ubuntu:latest
RUN apt-get update; apt-get -y install fortune;
ADD fortuneloop.sh /bin/fortuneloop.sh
RUN chmod 755 /bin/fortuneloop.sh
ENTRYPOINT [ "/bin/fortuneloop.sh" ]
CMD [ "10" ]

# CMD [ "명령어" , "엔트리포인트 인자1", "인자2"]
# CMD [ "디폴트 인자1", "인자2"]   