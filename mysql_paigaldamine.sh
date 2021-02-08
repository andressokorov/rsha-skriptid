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
