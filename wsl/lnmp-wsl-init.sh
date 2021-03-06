#!/usr/bin/env bash

#
# init WSL
#

sudo sed -i "s#deb.debian.org#mirrors.ustc.edu.cn#g" /etc/apt/sources.list
sudo sed -i "s#security.debian.org#mirrors.ustc.edu.cn#g" /etc/apt/sources.list

sudo sed -i "s#archive.ubuntu.com#mirrors.ustc.edu.cn#g" /etc/apt/sources.list
sudo sed -i "s#security.ubuntu.com#mirrors.ustc.edu.cn#g" /etc/apt/sources.list

# conf wsl
sudo curl https://raw.githubusercontent.com/khs1994-docker/lnmp/master/wsl/config/wsl.conf -o /etc/wsl.conf

if [ -z $APP_ENV ];then
  echo "export APP_ENV=wsl" >> ~/.bash_profile
fi

if [ -z $WSL_HOME ];then
  echo "export WSL_HOME=/c/Users/90621" >> ~/.bash_profile
fi

if [ -z $COMPOSER_HOME ];then
  echo "export COMPOSER_HOME=/tmp" >> ~/.bash_profile
fi

sudo apt update && sudo apt -y install \
                            bash-completion \
                            vim \
                            git \
                            curl \
                            wget \
                            lsb-release \
                            python \
                            python-pip \
                            python3 \
                            python3-pip \
                            openssh-server \
                            apt-file \
                            man

# composer cn mirror

command -v /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.laravel-china.org

# lnmp-wsl-docker-cli.sh
# 18.03 +
sudo ln -sf "/c/Program Files/Docker/Docker/resources/bin/docker.exe" /usr/local/bin/docker
sudo ln -sf "/c/Program Files/Docker/Docker/resources/bin/docker-compose.exe" /usr/local/bin/docker-compose

# 命令行补全

if ! [ -d /etc/bash_completion.d ];then sudo mkdir -p /etc/bash_completion.d; fi

if ! [ -f /etc/bash_completion.d/docker ];then

sudo curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker

fi

# verify

docker --version
