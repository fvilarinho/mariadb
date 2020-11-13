function getCredentials(){
	SETTINGS=
	CONT=0

	while [ true ];
	do
		SETTINGS=`etcdctl --endpoints=$SETTINGS_URL get $APP_NAME`
	
		if [ -z "$SETTINGS" ]; then
			sleep 1	
		
			if [ $CONT == 0 ]; then
				CONT=1
			fi
		else
			SETTINGS=`echo $SETTINGS | sed 's|'"$APP_NAME"'||g'`
			
			break
		fi
	done

	echo $SETTINGS
}