#!/bin/bash
vhost()
{

    is_installed apache2
    if [[ $? -eq 0 ]];then
        echo -e "$WARNING Невозможно выполнить операцию, apache2 не установлен! $NC"
        exit 1 
    fi
    
    local action=$1
	local param=$2
    case $action in
        add ) vhost_add ${param};;
        list ) vhost_list;;
        del ) vhost_del ${param};;
        *) echo -e "$WARNING Команда $action не найдена $NC";exit 1;;
    esac
}
host_exist()
{
    local host=$1
    if [ -f /etc/apache2/sites-available/$1.conf ]; then
        return 1
    else
        return 0
    fi
}
vhost_del ()
{
    param_required 1 $#
    local host=$1

    host_exist $host
    
    if [[ $? -eq 0 ]];then
        echo -e "$WARNING Невозможно выполнить операцию, $host не сущуствует! $NC"
        exit 1 
    fi

    sudo a2dissite $host.conf
    sudo rm /etc/apache2/sites-available/$host.conf
    sudo sed -i -r "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+[[:space:]]+$host//"  /etc/hosts |sudo tee /etc/host
    echo -e "$WARNING Хост удален! Но файлы в /var/www/$host/public_html остались,хотите удалить? yes/no  $NC"
    while :; do echo
        read -p ":" input
        [ -z "$input" ] && input='no'
        break;
    done
    if [ $input == "yes" ];then
        sudo rm -R /var/www/$host
    fi
}
vhost_list ()
{
	sed -n -r -e 's/ServerAlias\s+(.*)/\1/p' -e 's/DocumentRoot\s+(.*)/\1/p'  /etc/apache2/sites-available/*.conf | awk 'BEGIN{printf ("%-50s %-50s\n%-50s %-50s\n","server name","website root","-----------","------------")}{printf("%-50s",$0);getline;printf $0"\n" }'
}

vhost_add ()
{
    param_required 1 $#
    local host=$1
    
    host_exist $host
    
    if [[ $? -eq 1 ]];then
        echo -e "$WARNING Невозможно выполнить операцию, $host уже сущуствует! $NC"
        exit 1 
    fi

    echo -e "###  $HEADER Создание хоста $host $NC   ###\n"
    echo -e "$LOG"
    mkdir -p /var/www/$host
    mkdir -p /var/www/$host/public_html
    echo "<!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>$host</title>
      </head>
      <body>
        <h1> Apache2 host $host install success
      </body>
    </html>" | tee /var/www/$host/public_html/index.html
    sudo echo "<VirtualHost *:80>
        ServerName $host
        ServerAlias www.$host
        DocumentRoot /var/www/$host/public_html
        DirectoryIndex index.php index.html index.htm
        <Directory /var/www/$host/public_html>
            Options +Includes -Indexes
            AllowOverride All
            Order Deny,Allow
            Allow from All
        </Directory>
    </VirtualHost>" | sudo tee /etc/apache2/sites-available/$host.conf
    sudo a2ensite $host.conf
    sudo sh -c "echo '127.0.0.1 $host' >> /etc/hosts"
    sudo systemctl restart apache2
}
