TEST=docker run --rm sentry-base config generate-secret-key

sed -i "s/@secretKeyReplace@/${TEST}/" sentry.env

docker compose run --rm sentry-base upgrade 

docker compose up -d
