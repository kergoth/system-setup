#!/bin/sh

# shellcheck source=./common.sh
. "$(dirname "$0")/common.sh" || exit 1

need_sudo

# Enable Firewall
sudorun defaults write /Library/Preferences/com.apple.alf globalstate -bool true
sudorun defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

# Enable Stealth Mode
sudorun defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

# Disable Bonjour multicast advertisements:
sudorun defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES

# Don't show hostname at the login screen
sudorun defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo ""

# Disable Captive Portal
sudorun defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control.plist Active -bool false

# Crank up the max open files, etc
sudorun sh -c "echo kern.sysv.shmall=65536 >>/etc/sysctl.conf"
sudorun sh -c "echo kern.sysv.shmmax=16777216 >>/etc/sysctl.conf"
sudorun sh -c "echo kern.maxfiles=10485760 >>/etc/sysctl.conf"
sudorun sh -c "echo kern.maxfilesperproc=1048576 >>/etc/sysctl.conf"
sudorun sh -c "sort -u /etc/sysctl.conf >/tmp/foo && mv /tmp/foo /etc/sysctl.conf"
# shellcheck disable=SC2046
sudorun sysctl -w $(cat /etc/sysctl.conf)

# Silence Boot chime
sudorun nvram SystemAudioVolume=" "

# Load new spotlight settings before rebuilding the index
sudorun killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudorun mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudorun mdutil -E / > /dev/null
