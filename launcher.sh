#!/usr/bin/env bash
if [ "$(id -u)" = "0" ]; then
	echo "This script must be run as normal user" 1>&2
	exit 1
else
	#export LIBVA_DRIVER_NAME=i965 #fix intel hdmi grapics on pre broadwell cpus
	APP="/usr/share/spotify"
	#--force-device-scale-factor=1.2
 
	if ps ax | grep -v grep | grep $APP | grep renderer > /dev/null
	then
		echo "$APP application running, everything is fine" 1>&2
	else
		while ! ps ax | grep -v grep | grep $APP | grep renderer > /dev/null
		do
			killall -q spotify
			env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify &
			sleep 2
		done
		spotify_window_pid=$(ps ax | grep -v grep | grep $APP | grep -v type | awk '{print $1}')
		kdocker -o -x $spotify_window_pid -d 7 -i /usr/share/icons/hicolor/512x512/apps/spotify-client.png -q
	fi
fi
