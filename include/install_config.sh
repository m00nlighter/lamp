#!/bin/bash
php_config()
{
	local message='Выберите версию php для установки'
	local variants=('PHP5' 'PHP7')
	local default=${#variants[@]}-1
	display_menu 
	get_input "config_php_version"
	check_input $config_php_version
	if [[ $? -eq 0 ]];then
    	php_config
    fi
}
phpmyadmin_config()
{
	local message='Установить phpmyadmin ?'
	local variants=('no' 'yes')
	local default=${#variants[@]}-1
	display_menu 
	get_input "config_phpmyadmin"
	check_input $config_phpmyadmin
	if [[ $? -eq 0 ]];then
    	phpmyadmin_config
    fi
}
mysql_pass_config(){
	echo -e "###  $HEADER Введите пароль для пользователя root Mysql: $NC   ###"
	while :; do echo
	    read -p ":" config_mysql_pass
	    break;
	done
}
install_config()
{
	php_config
	mysql_pass_config
	phpmyadmin_config
}



check_input()
{
	local input=$1
	local choice=${variants[$input]}
	if [ -z $choice ];then
		return 0
	else
		return 1
	fi
}