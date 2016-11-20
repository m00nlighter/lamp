#!/bin/bash
php5_install()
{
	is_installed php5.6
    if [[ $? -eq 0 ]];then
    	echo -e "###  $HEADER Установка PHP5 $NC   ###\n"
		echo -e "$LOG"
		echo -ne '\n' | sudo add-apt-repository ppa:ondrej/php
		sudo apt-get update
		sudo apt-get -y install php5.6 php5.6-mysql php5.6-mbstring libapache2-mod-php5.6 php5.6-curl php5.6-json
		sudo systemctl restart apache2
		echo -e "$NC\n"
		echo -e "###  $HEADER PHP5 Установлен!$NC   ###\n"
	else
		echo -e "###  $HEADER PHP5 Не нуждается в установке!$NC   ###\n"
	fi
}
