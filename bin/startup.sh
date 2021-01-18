#!/bin/bash

NAME=`echo $SETTINGS | jq -r .name`
USER=`echo $SETTINGS | jq -r .user`
PASSWORD=`echo $SETTINGS | jq -r .password`

export NAME
export USER
export PASSWORD

$BIN_DIR/$APP_NAME-install.sh

mysqld --user=root --console &

while [ true ];
do
	RESULT=`netstat -an|grep $PORT|grep LISTEN`
	
	if [ -z "$RESULT" ]; then
		sleep 1
	else
		break
	fi
done

$BIN_DIR/$APP_NAME-permissions.sh

if [ -f "$SQL_DIR/V1__init.sql" ]; then
	echo "Creating the database..."
	
	mysql -u $USER -p"$PASSWORD" $NAME < $SQL_DIR/V1__init.sql
	
	mv $SQL_DIR/V1__init.sql $SQL_DIR/V1__init.sql.applied
	
	mysql -u $USER -p"$PASSWORD" $NAME -e "drop table flyway_schema_history;"
	
	flyway -user="$USER" -password="$PASSWORD" baseline
	
	echo "Database created!"
fi

echo "Applying the database scripts..."

flyway -user="$USER" -password="$PASSWORD" migrate

echo "Database scripts applied!"