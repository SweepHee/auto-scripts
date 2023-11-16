# 실행명령어 (반드시 루트계정)
# bash ./docker-install.sh 유저명

USER=$1
if [ ${USER} -z ];then
        echo "USER 이름을 입력해주세요"
        exit
fi

echo $USER

CHECK_USER=$(cat /etc/passwd | awk "/${USER}/")
if [ ${CHECK_USER} -z ];then
        echo "유저를 찾을 수 없습니다"
        exit
fi

apt-get update

# https관련 패키지 설치
apt install apt-transport-https ca-certificates curl software-properties-common -y

# docker repository 접근을 위한 gpg 키 설정
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# docker repository 등록
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y

apt update

# 도커 설치
apt install docker-ce -y

# 설치 확인
echo "=========docker install success...!========="
docker --version

# 도커 컴포즈 설치
curl -L https://github.com/docker/compose/releases/download/v2.1.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

echo "=========docker compose install success...!========="
docker-compose --version

usermod -aG docker $USER
echo "=========docker permission completed...!========="

echo "도커를 사용할 계정에서 id -nG"
