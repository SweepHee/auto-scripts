echo "hello world!"

docker-compose -f ./sentry.yml up -y
TEST=$(docker run --rm sentry-base config generate-secret-key)

#echo "??"
#echo $TEST
#TEST="HELLOWORLD..."
echo "test====${TEST}"

sed "s/\@secretKeyReplace\@/${TEST}/" sentry-default.env >> sentry.env

docker-compose run --rm sentry-base upgrade 

docker-compose up -d
