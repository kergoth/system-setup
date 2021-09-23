#!/bin/sh

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Change indexing order and don’t send search queries to Apple
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
	'{"enabled" = 1;"name" = "MESSAGES";}' \
	'{"enabled" = 1;"name" = "CONTACT";}' \
	'{"enabled" = 1;"name" = "EVENT_TODO";}' \
	'{"enabled" = 1;"name" = "IMAGES";}' \
	'{"enabled" = 1;"name" = "BOOKMARKS";}' \
	'{"enabled" = 1;"name" = "MUSIC";}' \
	'{"enabled" = 1;"name" = "MOVIES";}' \
	'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 1;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 1;"name" = "MENU_OTHER";}' \
	'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Prevent auto-mounting of remote-filesystems by Finder
duti -vs com.apple.Safari afp
duti -vs com.apple.Safari ftp
duti -vs com.apple.Safari nfs
duti -vs com.apple.Safari smb

# Set your screen to lock as soon as the screensaver starts:
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Expose hidden files and Library folder in Finder:
defaults write com.apple.finder AppleShowAllFiles -bool true
chflags nohidden ~/Library
xattr -d com.apple.FinderInfo ~/Library 2>/dev/null

# Show all filename extensions (so that "Evil.jpg.app" cannot masquerade easily).
defaults write -g AppleShowAllExtensions -bool true

# Don't default to saving documents to iCloud:
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Disable crash reporter (the dialog which appears after an application crashes and prompts to report the problem to Apple):
defaults write com.apple.CrashReporter DialogType none

# Enable Firewall
defaults write ~/Library/Preferences/com.apple.alf allowsignedenabled -bool false
defaults write ~/Library/Preferences/com.apple.alf globalstate -bool true

# Expand the save dialog by default in all applications
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Stop full names from copying with email addresses in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Always open everything in Finder's list view
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Enable quit menu item for Finder
defaults write com.apple.finder QuitMenuItem -bool true

# Enable text selection in quick look windows
defaults write com.apple.finder QLEnableTextSelection -bool true

# Remove autohide dock delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up autohide animation
defaults write com.apple.dock autohide-time-modifier -float 0.25

# Speed up mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.12

# Make hidden dock icons translucent
defaults write com.apple.dock showhidden -bool true

# Half-stars are great
defaults write com.apple.iTunes allow-half-stars -bool true

# Disable scroll gesture with modifier keys to zoom
defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -int 0

# Improve bluetooth audio quality over a2dp
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 40

## Personal preferences
# Autohide
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize 45

# Hide desktop icons completely
defaults write com.apple.finder CreateDesktop -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Restart Dock
killall Dock
