#!/bin/bash

echo "Applying default permissions..."

SECURE_RANDOM=`etcdctl --endpoints $SETTINGS_URL get secureRandom | sed 's|secureRandom||g' | tr -d '\n'`

if [ -z "$SECURE_RANDOM" ]; then
	TIMESTAMP=`date +%s`
	SECURE_RANDOM=`md5 -q -s $TIMESTAMP`
	
	etcdctl --endpoints $SETTINGS_URL put secureRandom $SECURE_RANDOM
fi

echo "grant all on $NAME.* to '$USER'@'%' identified by '$PASSWORD';" > /tmp/permissions.sql
echo "grant all on $NAME.* to '$USER'@'localhost' identified by '$PASSWORD';" >> /tmp/permissions.sql
echo "grant all on *.* to 'root'@'%' identified by '$SECURE_RANDOM';" >> /tmp/permissions.sql
echo "grant all on *.* to 'root'@'localhost' identified by '$SECURE_RANDOM';" >> /tmp/permissions.sql
echo "delete from mysql.user where User = '';" >> /tmp/permissions.sql

mysql -u root -p"$SECURE_RANDOM" < /tmp/permissions.sql

echo "Default permissions applied!"