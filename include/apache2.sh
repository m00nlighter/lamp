#!/bin/bash
apache2_install()
{
	is_installed apache2
    if [[ $? -eq 0 ]];then
    	echo -e "###  $HEADER Apache2 $NC   ###\n"
		echo -e "$LOG"
		sudo apt-get -y install apache2
		sudo systemctl enable apache2
		sudo systemctl start apache2
		sudo adduser $USER www-data
		sudo chown -R $USER:www-data /var/www
		sudo chmod -R 755 /var/www
		sudo sh -c "echo '\n #LAMP HOSTS#\n' >> /etc/hosts"
		sudo a2enmod rewrite
		echo -e "$NC\n"
		echo -e "###  $HEADER Apache2 Установлен!$NC   ###\n"
	else
		echo -e "###  $HEADER Apache2 Не нуждается в установке!$NC   ###\n"
	fi
}

