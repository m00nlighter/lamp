#!/bin/bash
r_install()
{
	sudo chmod +x lamp.sh
	sudo chmod -R +x include/*.sh
	sudo mkdir /usr/local/bin/.lamp
	sudo mv include/ /usr/local/bin/.lamp/
	sudo mv lamp.sh /usr/local/bin/.lamp/
	sudo ln -s /usr/local/bin/.lamp/lamp.sh /usr/local/bin/lamp
	exit 1
}

r_install





