#!/bin/bash
include install_config
include apache2
include mysql
include php5
include php7
include phpmyadmin

lamp()
{
	local action=$1
	case $action in
		install ) lamp_install;;
		*) echo -e "$WARNING Команда $action не найдена $NC";exit 1;;
    esac
}

lamp_install()
{
	install_config
	apache2_install
	############################
	case $config_php_version in
		0 ) php5_install;;
		1 ) php7_install;;
    esac
    ############################
    mysql_install $config_mysql_pass
    ############################
    if [[ $config_phpmyadmin -eq 1 ]];then
    	phpmyadmin_install
    fi
    ############################

   
}
