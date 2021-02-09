#Apache install
#!/bin/bash
APACHE2=$(dpkg-query -W  -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $APACHE2 -eq 0 ]; then
	apt install apache2
	echo "Apache2 on paigaldatud"
elif [ $APACHE2 -eq 1 ]; then
	echo "Apache2 on juba installitud"
fi

#php installimiseks koostatud skript
#!/bin/bash
PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
if [ $PHP -eq 0 ]; then
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "PHP on paigaldatud"
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba paigaldatud"
	php --version
fi

#mysql serveri paigaldus skript

MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')
if [ $MYSQL -eq 0 ]; then
	#Automatiseerisin ka repository valimise
	wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
	dpkg -i mysql-apt-config*
	apt update
	apt install mysql-server
	rm -R mysql-apt-config*
	echo "MySQL on paigaldatud"
	touch $HOME/.my.cnf
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
elif [ $MYSQL -eq 1 ]; then
	echo "MySQL on juba paigaltatud"
	mysql --version
fi
