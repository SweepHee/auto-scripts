isGit=$(git --version | awk "command not found")
isDocker=$(docker --version | awk "command not found")

if [ $isGit ];then
        echo "깃을 먼저 설치해주세요"
        exit
fi

if [ $isDocker ];then
  echo "도커를 먼저 설치해주세요"
  exit
fi


git clone https://github.com/pinpoint-apm/pinpoint-docker.git
cd ./pinpoint-docker/
# rm -rf pinpoint-agent pinpoint-agent-attach-example pinpoint-quickstart // 지워도 됨. docker-compose에서도 지워야 됨

isPort=$(netstat -tnlp | grep 8080)

if [ $isPort == "" ];then
  echo "8080포트를 사용중입니다. "
  echo ".env 파일의 WEB_SERVER_PORT=8080 을 사용하지 않는 포트번호로 변경해주세요"
  exit
fi


dockerComposeType=$(docker-compose --version | grep "command not found")

# docker-compose 일때
if [ dockerComposeType ]
  echo "docker-compose not found..."
  dockerComposeType=$(docker compose version | grep "command not found")
else
  docker-compose up -d --build
fi

# docker compose 일때
if [ dockerComposeType ]
  echo "docker compose not found..."
  exit
else
  docker compose up -d --build
fi

