# bash ./disable-pem.sh 유저이름 비밀번호
echo "==== 반드시 root계정으로 실행 ===="

USER=$1
PASSWORD=$2

echo $USER
echo $PASSWORD

if [ -z $USER ];then
        echo "USER 이름(첫번째 파라미터)을 입력해주세요"
        exit
fi

if [ -z $PASSWORD ];then
        echo "비밀번호를(2번째파라미터) 입력해주세요"
        exit
fi

CHECK_USER=$(cat /etc/passwd | awk "/${USER}/")
if [[ -n $CHECK_USER ]];then
        echo "이미 유저가 존재합니다. 다른 유저명으로 만드세요"
        exit
fi

adduser --gecos "" --disabled-password ${USER}

# chpasswd가 오류가 있다면 echo "${USER}:${PASSWORD}" | chpasswd
chpasswd <<<"${USER}:${PASSWORD}"

echo "===== user create ${USER} ====="

chmod u+w /etc/sudoers
echo -e "\"${USER}\" ALL=(ALL:ALL) ALL" >> /etc/sudoers

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "===== sshd_config password authentication yes... ====="
service sshd restart
echo "sshd restart..."
echo "ssh 접속을 끊고 새로 생성한 계정으로 접속하세요"
