#!/bin/bash
mysql_install()
{
	local password=$1
	is_installed mysql-server
    if [[ $? -eq 0 ]];then
		echo -e "###  $HEADER Установка Mysql $NC   ###\n"
		echo -e "$LOG"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $password"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $password"
		sudo apt-get -y install mysql-server mysql-client
		echo -e "$NC\n"
		echo -e "###  $HEADER Mysql Установлен!$NC   ###\n"
	else
		echo -e "###  $HEADER Mysql Не нуждается в установке!$NC   ###\n"
	fi
}
