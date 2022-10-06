#!/bin/bash

set -euo pipefail

scriptdir="$(cd "$(dirname "$0")" && pwd -P)"
PATH="$scriptdir:$scriptdir/../scripts:$PATH"

app_path() {
    for dir in /Applications ~/Applications /Applications/Utility ~/Applications/Utility; do
        if [ -d "$dir/$1.sapp" ]; then
            echo "$dir/$1.app"
            return 0
        fi
    done
    return 1
}

app_installed_directly() {
    app_path "$1" >/dev/null
}

add_login() {
    osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$1\", hidden:false}"
}


if app_installed_directly "Path Finder"; then
    duti -vs com.cocoatech.PathFinder public.folder viewer
fi

if app_installed_directly "Send to Kindle"; then
    duti -vs com.amazon.SendToKindle .mobi viewer
    duti -vs com.amazon.SendToKindle .azw viewer
fi

if app_installed_directly "Transmission Remote GUI"; then
    duti -vs com.transgui .torrent viewer
fi

# Switch these associations from Archive Utility to The Unarchiver
duti-switch "/System/Library/CoreServices/Applications/Archive Utility.app" cx.c3.theunarchiver

# Open these apps so they set up auto-start for themselves
while read -r app; do
    if app_installed_directly "$app"; then
        open -ga "$app"
    fi
done <<END
1Password 7
Alfred 4
Hidden Bar
Karabiner-Elements
Magnet
OverSight
ReiKey
END

while read -r app; do
    app_file_path="$(app_path "$app")"
    if [ $? -eq 0 ]; then
        add_login "$app_file_path"
        open -ga "$app"
    fi
done <<END
BlockBlock Helper
coconutBattery
PopClip
Syncthing
UnPlugged
WiFi Signal
END

appcleaner="$(app_path "AppCleaner")"
if [ $? -eq 0 ]; then
    open -g "$appcleaner/Contents/Library/LoginItems/AppCleaner SmartDelete.app"
fi

ccc="$(app_path "Carbon Copy Cloner")"
if [ $? -eq 0 ]; then
    open -g "$ccc/Contents/Library/LoginItems/CCC Dashboard.app"
fi

oversight="$(app_path "OverSight")"
if [ $? -eq 0 ]; then
    add_login "$oversight/Contents/Library/LoginItems/OverSight Helper.app"
    mkdir -p ~/Library/Application\ Support/Objective-See/OverSight
    touch ~/Library/Application\ Support/Objective-See/OverSight/OverSight.log
fi

# Reload the Quick Look generators list
qlmanage -r
