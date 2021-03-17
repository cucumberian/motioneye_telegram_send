#!/bin/bash

#telegram settings
# bot api token
api_token="<BOT_TOKEN>"
# chat id
chatid="<CHAT_ID_or_USER_ID"

# Snapshot URL link from motioneye webinterface at video streaming
link="<SNAPSHOT_URL_FROM_MOTIONEYE>"
message="alarm"


alarm_file="pic.jpg"		# file for temp image storing
stop_file="/scripts/motioneye_bot/stopfile"		# file for checking modification time

timeout=2		# default timeout in seconds

# sending mesage to chat
curl -F "chat_id=${chatid}" -F "text=${message}" \
https://api.telegram.org/bot${api_token}/sendmessage

start_time=$(date '+%s')	# getting current time

for ((i=1; i<100; i++)); do			# cycle of 100 sending photos

	curl -o ${alarm_file} ${link} &> /dev/null		# save image from SNAPSHOT_URL

	# sending image to telegram
	curl -F "chat_id=${chatid}" -F "photo=@${alarm_file}" \
		https://api.telegram.org/bot${api_token}/sendphoto

	sleep ${timeout}		# waiting

	if [[ -f ${stop_file} ]]; then	# checking for stopfile
	    
	    stop_time=$(ls -l --time-style='+%s' ${stop_file} | awk '{print $6}')		# getiing stopfile modofocation time

	    if [[ stop_time -gt start_time ]]; then		# if stopfile was modificated after program start - stop sending photos
			break
	    fi
	else		# if no stopfile - stop sending photos
	    break
	fi

done

echo

#curl -F "chat_id=${chatid}" -F "photo=@/scripts/motioneye_bot/pic.jpg" \
#https://api.telegram.org/bot${api_token}/sendphoto
