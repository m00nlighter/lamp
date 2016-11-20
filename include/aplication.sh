#!/bin/bash

LOG='\033[0;100m'
HEADER='\033[0;42m'
NC='\033[0m' # No Color
WARNING='\033[0;43m'
DANGER='\033[0;41m'
SUCCESS='\033[0;44m'

#check if root
is_root(){
    if ! [[ $EUID -ne 0 ]]; then
        echo -e "$WARNING Ошибка: Скрипт должен быть запущен не из под root $NC" 1>&2
        exit 1
    fi
}
is_installed()
{
    dpkg -l $1 > /dev/null 2>&1
    INSTALLED=$?

    if [ $INSTALLED == '0' ]; then
        return 1
    else
        return 0
    fi
}
param_required()
{
    local required=$1
    local get=$2
    if [ $get -lt $required ];then
        welcome
        echo -e "$WARNING Вы упустили обязательный параметр $NC"
        exit 1
    fi

}
get_input()
{
    local input
    local store=$1
    while :; do echo
        read -p ":" input
        [ -z "$input" ] && input=$default
        break;
    done
    eval "$store=\$input"
}

display_menu()
{    
    echo -e "$HEADER ### $message (default: $SUCCESS${variants[$default]}$HEADER ) ### $NC"
    echo -e "$WARNING Введите только цифру из ${!variants[@]} $NC"

    for i in "${!variants[@]}"
    do
      echo "[$i] - ${variants[$i]}"
    done
}

init()
{
	is_root
}

init
