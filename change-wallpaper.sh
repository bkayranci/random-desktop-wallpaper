#!/bin/bash
export CW_DIRECTORY="/home/$USER/wallpaper"
export CW_SAVE_OLD_WALLPAPER=0
export CW_SCREEN_SIZE=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
export CW_FILE_NAME=`date +"wallpaper-%Y%m%d-%H%M%S.jpg"`
export CW_NOTIFY_WHEN_CHANGED=1

config_read_file() {
    
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-;

}

config_get() {
    
    val="$(config_read_file "/home/$USER/.change-wallpaper/config" "${1}")";
    
    if [ "${val}" = "__UNDEFINED__" ];
    then

        val="$(config_read_file "/home/$USER/.change-wallpaper/config" "${1}")";

    else

        export "${1}"="${val}"

    fi

}

config_get CW_SAVE_OLD_WALLPAPER
config_get CW_SCREEN_SIZE
config_get CW_DIRECTORY
config_get CW_NOTIFY_WHEN_CHANGED

if [ ! -f "/home/$USER/.change-wallpaper/config" ]
then
    if [ ! -d "/home/$USER/.change-wallpaper" ]
    then

        mkdir -p "/home/$USER/.change-wallpaper"

    fi

    echo \#CW_DIRECTORY=/home/$USER/wallpaper > /home/$USER/.change-wallpaper/config
    echo \#CW_SAVE_OLD_WALLPAPER=0 >> /home/$USER/.change-wallpaper/config
    echo \#CW_SCREEN_SIZE=$CW_SCREEN_SIZE >> /home/$USER/.change-wallpaper/config
    echo \#CW_NOTIFY_WHEN_CHANGED=1 >> /home/$USER/.change-wallpaper/config

fi

if [ ! -d $CW_DIRECTORY ]
then

    mkdir -p $CW_DIRECTORY

fi

export CW_IMAGE_URL="https://source.unsplash.com/$CW_SCREEN_SIZE/?$1";

wget "$CW_IMAGE_URL" --content-disposition -O "$CW_DIRECTORY/$CW_FILE_NAME" -a "$CW_DIRECTORY/log" &> /dev/null

if [[ "$?" != 0 ]];
then

    echo "Error occurred while wallpaper is downloading."

else

    if [[ "$CW_SAVE_OLD_WALLPAPER" != 1 ]];
        then
        
        OLD_WALLPAPER=$(gsettings get org.gnome.desktop.background picture-uri|cut -d "'" -f2|cut -c 8-)
        
        if [ -f $OLD_WALLPAPER ]
        then

            rm $OLD_WALLPAPER

        fi

    fi

    gsettings set org.gnome.desktop.background picture-uri "file://$CW_DIRECTORY/$CW_FILE_NAME"

    if [[ "$CW_SAVE_OLD_WALLPAPER" != 1 ]];
    then
        
        notify-send -i $CW_DIRECTORY/$CW_FILE_NAME "Desktop Wallpaper Changed" $CW_DIRECTORY/$CW_FILE_NAME

    fi
    
fi