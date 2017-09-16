# random-desktop-wallpaper
Are not you tired of using the same wallpaper? Now you have a script that does this automatically for you.


# Installation
```sh
$ sudo wget link -O /usr/local/bin/change-wallpaper
$ sudo chown $USER /usr/local/bin/change-wallpaper
$ sudo chgrp $USER /usr/local/bin/change-wallpaper
$ sudo chmod -c 700 /usr/local/bin/change-wallpaper
```

# Configuration
You can change config follow to `/home/$USER/.change-wallpaper/config'`.

###### Note
You want to old wallpaper save when you changed your desktop wallpaper. You must change configration `CW_SAVE_OLD_WALLPAPER=1` 
If you lost old wallpapers, you can read your log to find them. `/home/$USER/.change-wallpaper/log`

`CW_DIRECTORY=/home/username/wallpaper`   // this value should be full path.
`CW_SAVE_OLD_WALLPAPER=0` // alternative value: 1
`CW_SCREEN_SIZE=1024x728` // this value is set as automatic for your screen if you don't change it.
`CW_NOTIFY_WHEN_CHANGED=1`    // alternative value:0

# Using
### Example 1
```sh
$ change-wallpaper
```

### Example 2
```sh
$ change-wallpaper developer
```
This command will choose wallpaper about developer.

### Example 3
```sh
$ change-wallpaper "natural,water"
```
This command will choose wallpaper about natural and water.

# Author
Türkalp Burak KAYRANCIOĞLU
[Github](https://github.com/bkayranci)
[Twitter](https://twitter.com/bkayranci)
[Telegram](https://t.me/bkayranci)

# License
GNU General Public License v3.0
