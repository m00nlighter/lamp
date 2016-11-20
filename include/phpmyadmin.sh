#!/bin/bash
echo "zlo"
phpmyadmin_install()
{
	is_installed phpmyadmin
    if [[ $? -eq 0 ]];then
    	echo -e "###  $HEADER Установка phpmyadmin $NC   ###\n"
		echo -e "$LOG"
		if [ -n $config_mysql_pass  ];then
	    	sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
			sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password $config_mysql_pass'
			sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password $config_mysql_pass'
			sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password $config_mysql_pass'
			sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿
	    fi
		sudo apt-get -y install phpmyadmin
		sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
		sudo a2enconf phpmyadmin.conf
		sudo systemctl restart apache2
		echo -e "$NC\n"
		echo -e "###  $HEADER phpmyadmin Установлен!$NC   ###\n"
	else
		echo -e "###  $HEADER phpmyadmin Не нуждается в установке!$NC   ###\n"
	fi
}
