#!/usr/bin/env bash
if [ "$(id -u)" = "0" ]; then
    echo "This script must be run as normal user" 1>&2
    exit 1
else

APP="/usr/share/spotify"
 
if ps ax | grep -v grep | grep $APP | grep renderer > /dev/null
    then
        echo "$APP application running, everything is fine" 1>&2
    else
        while ! ps ax | grep -v grep | grep $APP | grep renderer > /dev/null
        do
            killall spotify
            env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify &
            sleep 2
        done
        kdocker -o -n Spotify -d 5 -i /usr/share/icons/hicolor/512x512/apps/spotify-client.png -q 
    fi
fi
