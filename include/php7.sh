#!/bin/bash
php7_install()
{
	is_installed php7
    if [[ $? -eq 0 ]];then
    	echo -e "###  $HEADER Установка PHP7 $NC   ###\n"
		echo -e "$LOG"
		sudo apt-get -y install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0
		sudo systemctl restart apache2
		echo -e "$NC\n"
		echo -e "###  $HEADER PHP7 Установлен!$NC   ###\n"
	else
		echo -e "###  $HEADER PHP7 Не нуждается в установке!$NC   ###\n"
	fi
}

