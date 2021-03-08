#!/bin/bash

USER=`echo $SETTINGS | jq -r .user.value`
PASSWORD=`echo $SETTINGS | jq -r .password.value`
DATABASE_NAME=`echo $SETTINGS | jq -r .databaseName.value`

export USER
export PASSWORD
export DATABASE_NAME

$BIN_DIR/child-install.sh

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

$BIN_DIR/child-permissions.sh

if [ -f "$SQL_DIR/V1__init.sql" ]; then
	echo "Creating the database..."
	
	mysql -u $USER -p"$PASSWORD" $DATABASE_NAME < $SQL_DIR/V1__init.sql
	
	mv $SQL_DIR/V1__init.sql $SQL_DIR/V1__init.sql.applied
	
	mysql -u $USER -p"$PASSWORD" $DATABASE_NAME -e "drop table flyway_schema_history;"
	
	flyway -user="$USER" -password="$PASSWORD" baseline
	
	echo "Database created!"
fi

echo "Applying the database scripts..."

flyway -user="$USER" -password="$PASSWORD" migrate

echo "Database scripts applied!"