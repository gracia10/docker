trap "exit" SIGINT
INTERVAL=${1}
echo "fortune evnery" ${INTERVAL} " seconds"
mkdir /var/htdocs
while :
do
 echo ${date} Writing fortune to /var/htdocs/index.html
 /usr/games/fortune > /var/htdocs/index.html
 sleep $INTERVAL
done