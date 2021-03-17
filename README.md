# motioneye_telegram_send
bash script for motioneye sending camera pictures to telegram

work by saving and sending photos from SNAPSHOT URL until motioneye modify stopfile time by touch command

1. copy SNAPSHOT URL from motioneye web-interface into script "link" variable
2. copy TELEGRAM BOT API Key from @BotFather to "api_token" variable
3. copy telegram chat_id or telegram user_id to "chatid" variable
4. MotionEye web interface section "Motion Notifications": set "Run a command" on and "Command" "<path_to_script>/motioneye_telegram.sh"
6. MotionEye web interface section "Motion Notifications": set "Run An End Command" On and Command "touch <path_to_script>/stopfile"
