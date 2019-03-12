#!/bin/bash

basic(){
echo " 修改密码"
sudo passwd

echo " 更新"
sudo apt update
sudo apt upgrade -y

echo "安装vim"
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo chmod -R 777 ~/.vim
sudo apt install vim-gnome #支持clipboard

echo " 安装zsh "
sudo apt install zsh -y

sudo chsh -s /bin/zsh

echo " 安装git"
sudo apt install git -y

echo " 安装 oh-my-zsh"
sudo apt install curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo " 安装 autojump"

sudo apt install autojump -y

echo " 安装 tmux"

sudo apt install tmux -y
echo " 安装 gcc g++"

sudo apt install gcc -y
sudo apt install g++ -y


echo " 安装pip"
sudo apt install python-pip python-dev python3-pip python3-dev build-essential -y 
sudo pip install --upgrade pip 
sudo pip3 install --upgrade pip3

echo " 切换python版本"
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
# update-alternatives --list python
# update-alternatives --list python
# update-alternatives --remove python /usr/bin/python2.7

echo " 安装vim-plug"

sudo curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo " 安装xsel (配合.vimrc中设置,防止vim退出后剪切板清空)"
sudo apt install xsel


echo "安装bbr"
# wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh

# chmod +x bbr.sh
sudo chmod 777  ~/Server_Initer/bbr.sh
~/Server_Initer/bbr.sh

rm -rf ~/Server_Initer/bbr.sh

echo "修改系统locale"
sudo mv ~/Server_Initer/locale /etc/default/locale 

echo "设置zsh"
mv ~/Server_Initer/.zshrc ~/.zshrc

echo "设置tmux"
mv ~/Server_Initer/.tmux.conf ~/.tmux.conf

echo "设置vim"
mv ~/Server_Initer/.vimrc ~/.vimrc

echo "安装iftop"
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

client(){
	echo "nothing"
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
	3. Client (GUI)
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
elif [ "$mode" = "3" ] ; then
	echo "Gui"
	basic
	client
	v2ray
else
	echo "Exit"
fi

end

}

main
