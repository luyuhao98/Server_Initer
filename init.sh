#!/bin/bash

basic(){
echo "0 修改密码"
sudo passwd

echo "1 更新"
sudo apt update
sudo apt upgrade -y

echo "2 安装zsh "
sudo apt install zsh -y

chsh -s /bin/zsh

echo "3 安装git"
sudo apt install git -y

echo "4 安装 oh-my-zsh"

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "5 安装 autojump"

sudo apt install autojump -y

echo "6 安装 tmux"

sudo apt install tmux -y

echo "7 安装 gcc g++"

sudo apt install gcc -y
sudo apt install g++ -y


echo "8 安装pip"
sudo apt install python-pip python-dev python3-pip python3-dev build-essential -y 
sudo pip install --upgrade pip 
sudo pip3 install --upgrade pip3

echo "9切换python版本"
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
# update-alternatives --list python
# update-alternatives --list python
# update-alternatives --remove python /usr/bin/python2.7

echo "9 安装vim-plug"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "10 安装xsel (配合.vimrc中设置,防止vim退出后剪切板清空)"
sudo apt install xsel


echo "11安装bbr"
# wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh

# chmod +x bbr.sh
~/Server_Initer/bbr.sh

rm -rf ~/Server_Initer/bbr.sh

echo "12修改系统locale"
sudo mv ~/Server_Initer/locale /etc/default/locale 

echo "13设置zsh"
mv ~/Server_Initer/.zshrc ~/.zshrc

echo "14设置tmux"
mv ~/Server_Initer/.tmux.conf ~/.tmux.conf

echo "15设置vim"
mv ~/Server_Initer/.vimrc ~/.vimrc

echo "16安装iftop"
sudo apt install iftop
}


shadowsocks(){

echo "安装ss"
pip install setuptools
pip install shadowsocks
sudo apt install shadowsocks-libev -y

echo 'shadowsocks config'
vim ~/Server_Initer/shadowsocks.json
mv ~/Server_Initer/shadowsocks.json /etc/
ssserver -c /etc/shadowsocks.json -d restart

}


v2ray(){

bash <(curl -L -s https://install.direct/go.sh)
mv ~/Server_Initer/config.json /etc/v2ray/config.json
}

end(){

	echo "禁用密码登录ssh"
	sed -n 's/^.*PasswordAuthentication.*/PasswordAuthentication no/gp' /etc/ssh/sshd_config
	systemctl restart ssh.service

	rm -rf ~/Server_Initer
	echo "即将重启"
	sudo reboot
}

main(){



echo "Select a mode:
	0. basic
	1. shadowsocks
       	2. v2ray
	Else. exit
"

read  mode

if [ "$mode" = "0" ] ;then
	echo "basic"
	basic
elif [ "$mode" = "1" ] ; then
	echo "shadowsocks"
	basic
	shadowsocks
elif [ "$mode" = "2" ] ; then
	echo "v2ray"
	basic
	v2ray
else
	echo "Exit"

fi

end

}

main
