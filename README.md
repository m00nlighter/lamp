# Lamp
########################################################################
###  Скрипт для быстрой установки LAMP на системах Ubuntu версия 0.0.1 бета    ###
###  Автор: Кулик Вадим xbyte.com.ua@gmail.com                       ###
########################################################################
########################################################################
Доступные команды:
  - lamp install            -> Автоматическая установка LAMP + phpmyadmin
  - lamp add доменное_имя   -> Добавит новый хост
  - lamp list               -> Выводит список хостов
  - lamp del доменное имя   -> Удаляет хост

Установка:
  - wget --no-check-certificate -O lamp.zip https://github.com/m00nlighter/lamp/archive/master.zip
  - unzip lamp.zip
  - cd lamp-master
  - chmod +x *.sh
  - ./install.sh
  - cd ..
  - rm -R lamp-master
  - lamp
