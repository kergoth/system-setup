#!/bin/sh

# Prevent auto-mounting of remote-filesystems by Finder
duti -vs com.apple.Safari afp
duti -vs com.apple.Safari ftp
duti -vs com.apple.Safari nfs
duti -vs com.apple.Safari smb

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

# Expand the print dialog by default in all applications
defaults write -g PMPrintingExpandedStateForPrint -bool true

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

# Do not display a warning when changing a file extension in the Finder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable text selection in quick look windows
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

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

# Do not autogather large files when submitting a report
defaults write com.apple.appleseed.FeedbackAssistant Autogather -bool false

# Do not prompt to use new external disks for Time Machine
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

## Safari & Webkit

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

## Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

## Personal preferences
# Autohide
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36

# Hide desktop icons completely
defaults write com.apple.finder CreateDesktop -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Move the Dock to the left
defaults write com.apple.dock orientation -string left

# Do not display recent apps in the Dock
defaults write com.apple.dock show-recents -bool false

# Scale minimize animation rather than Genie
defaults write com.apple.dock mineffect -string scale

# Move screenshots to ~/Pictures/Screenshots
# shellcheck disable=SC2088
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

# Default to plain text in TextEdit
defaults write com.apple.TextEdit RichText -bool false

# Trackpad: disable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Top right screen corner → Start screen saver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0

killall Dock
killall SystemUIServer
killall Finder
