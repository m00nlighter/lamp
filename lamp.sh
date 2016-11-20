#!/bin/bash
include(){
    local include=$1
    if [[ -s /usr/local/bin/.lamp/include/${include}.sh ]];then
        . /usr/local/bin/.lamp/include/${include}.sh
    else
        echo -e "$danger Ошибка:usr/local/bin/.lamp/include/${include}.sh Не найден!$NC"
        exit 1
    fi
}
include aplication
include lamp_installer
include vhost

welcome()
{
	echo "########################################################################
###  Скрипт для быстрой установки LAMP на системах Ubuntu версия 0.0.1 бета    ###
###  Автор: Кулик Вадим xbyte.com.ua@gmail.com                       ###
########################################################################
########################################################################

Доступные команды:
lamp install            -> Автоматическая установка LAMP + phpmyadmin
lamp add доменное_имя   -> Добавит новый хост
lamp list               -> Выводит список хостов
lamp del доменное имя   -> Удаляет хост"

}
if [ $# -lt 1 ];then
    welcome
    exit 1
fi

action=$1
param=$2
case ${action} in
	install) lamp ${action} ;; 
    add)  vhost ${action} ${param} ;;
    list) vhost ${action} ;;
    del)  vhost ${action} ${param};;
    *) welcome ;;
esac



