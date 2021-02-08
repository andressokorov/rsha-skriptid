#Apache install
#!/bin/bash
APACHE2=$(dpkg-query -W  -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $APACHE2 -eq 0 ]; then
	apt install apache2
	echo "Apache2 on paigaldatud"
elif [ $APACHE2 -eq 1 ]; then
	echo "Apache2 on juba installitud"
	service apache2 start
	service apache2 status
fi

