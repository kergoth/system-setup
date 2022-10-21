# Christopher Larson's Personal System Setup Scripts

[![BlueOak 1.0.0 License](https://img.shields.io/badge/License-BlueOak%201.0.0-2D6B79.svg)](https://spdx.org/licenses/BlueOak-1.0.0.html)

This project holds the consolidation of my various per-system setup script repositories into something more cohesive.

## Prerequisites

- Logged in as your already-configured user.
- (On macOS) Command-Line Tools or XCode must be installed (See extras/ for scripts to install these).
- (On Linux hosts) Zsh is already installed.
- (On non-Arch Linux hosts, for now) Nix is already installed.

## Usage

### Linux or macOS

As a user that can run `sudo`:

```console
./setup-admin
```

As a non-root user:

```console
./setup
```

### Windows

In an Administrative PowerShell:

```console
./setup-admin.ps1
```

In powershell:

```console
./setup.ps1
```

## Manual Steps

### macOS

- Enable `secure keyboard entry` in Terminal
- `extras/enable-filevault`
- Run vscode, enable settings sync
- Run vivaldi, enable sync
- Run deliveries, click yes to import from iCloud
- Run musicharbor, click yes to import from iCloud
- Run appcleaner, preferences, enable smartdelete
- Run alfred, preferences, advanced, enable sync to `~/Sync/App Settings/Alfred`
- Safari
  - Change the default scale to 85%
  - Add site settings icon
  - Add cloud tabs icon
  - Rearrange icons
- Syncthing Shares
  - Sync/dotfiles-local
  - Sync/App Settings
  - Library/Fonts

### Windows

- Set up all my Syncthing shares
- Restore from backup:
  - `$USERPROFILE/Apps`
  - Vivaldi: `AppData/Local/Vivaldi/User Data/Default/`
  - HexChat: `AppData/Roaming/HexChat`
  - archwsl disk image
- Run QuickLook, right click its icon, click start at login
- Create link to CapsLockCtrlEscape.exe in Startup (win-r -> shell:startup)
- Install Fonts from Sync/Fonts
- Run vscode, enable settings sync
- Run an elevated WSL terminal, clone dotfiles into $USERPROFILE/dotfiles, and run:

```console
./script/install -d $USERPROFILE -f windows-terminal powershell git`
```

- Run `ssh-add` in powershell to add my key to the agent, if it exists
- Remove Edge, Store, Mail from the task bar pins.

## Apps Installed

### CLI apps installed

- [wget](https://www.gnu.org/software/wget/): A free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.
- [git](https://git-scm.com): A free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.
- [neovim](https://neovim.io): Hyperextensible Vim-based text editor.

- [rust](https://www.rust-lang.org): A multi-paradigm, general-purpose programming language.
- [go](https://go.dev): An open source programming language supported by Google
- [python](https://www.python.org): A programming language that lets you work quickly
and integrate systems more effectively.
  - [flake8](https://pypi.org/project/flake8/) with [pep8-naming](https://pypi.org/project/pep8-naming/) and [flake8-docstrings](https://pypi.org/project/flake8-docstrings/)
- [pipx](https://pypi.org/project/pipx/): Install and run python applications in isolated environments.

- [bat](https://github.com/sharkdp/bat): A cat(1) clone with syntax highlighting and Git integration.
- [choose](https://github.com/theryangeary/choose): A human-friendly and fast alternative to cut and (sometimes) awk.
- [exa](https://github.com/ogham/exa): A modern replacement for ls.
- [fd](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to 'find'.
- [fzf](https://github.com/junegunn/fzf): A command-line fuzzy finder.
- [ripgrep](https://github.com/BurntSushi/ripgrep): A line-oriented search tool that recursively searches the current directory for a regex pattern.
- [sd](https://github.com/chmln/sd): Intuitive find & replace CLI (sed alternative).
- [delta](https://github.com/dandavison/delta): A syntax-highlighting pager for git, diff, and grep output.
- [dua](https://github.com/Byron/dua-cli): View disk space usage and delete unwanted data, fast. This is a faster version of ncdu.
- [dust](https://github.com/bootandy/dust): A more intuitive version of du in rust.
- [shellcheck](https://github.com/koalaman/shellcheck): A static analysis tool for shell scripts.
- [shfmt](https://github.com/mvdan/sh#shfmt): Format shell programs.
- [git-imerge](https://github.com/mhagger/git-imerge): Incremental merge for git.
- [git-revise](https://github.com/mystor/git-revise): A handy tool for doing efficient in-memory commit rebases & fixups.
- [peru](https://github.com/buildinspace/peru): A generic package manager, for including other people's code in your projects.
- [jq](https://github.com/stedolan/jq): A lightweight and flexible command-line JSON processor.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command, inspired by z and autojump.

#### Linux and macOS

- [ssh-copy-id](https://www.openssh.com): Install your identity.pub in a remote machine’s authorized_keys.
- [tmux](https://github.com/tmux/tmux): An open-source terminal multiplexer.
- [patchutils](http://cyberelk.net/tim/software/patchutils/): A small collection of programs that operate on patch files.
- [git-absorb](https://github.com/tummychow/git-absorb): git commit --fixup, but automatic.
- [git-branchless](https://github.com/arxanas/git-branchless): High-velocity, monorepo-scale workflow for Git.
- [direnv](https://direnv.net): An extension for your shell which can load and unload environment variables depending on the current directory.
- [sad](https://github.com/ms-jpq/sad): CLI search and replace | Space Age seD.

#### macOS

- [lima](https://github.com/lima-vm/lima): Linux virtual machines, typically on macOS, for running containerd.
- [colima](https://github.com/abiosoft/colima): Container runtimes on macOS (and Linux) with minimal setup.
- [duti](https://github.com/moretension/duti): A command-line tool to select default applications for document types and URL schemes on Mac OS X.
- [mas](https://github.com/mas-cli/mas): Mac App Store command line interface.
- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard): Reattach to the per-user bootstrap namespace. This is needed for tools like tmux, though tmux 2.6+ apparently incorporates this functionality already.
- [trash](https://hasseg.org/trash/): A small command-line program for OS X that moves files or folders to the trash.

#### Linux

The intention is to incorporate the installation of Nix on all systems in time.

##### Arch Linux

- [nix](https://nixos.org): Nix is a tool that takes a unique approach to package management and system configuration.
- [openssh](https://www.openssh.com): The premier connectivity tool for remote login with the SSH protocol.
- [avahi](https://avahi.org): A system which facilitates service discovery on a local network via mDNS.
- [nss-mdns](http://0pointer.de/lennart/projects/nss-mdns/): A GNU Libc NSS module that provides mDNS host name resolution.

#### Windows

- [winget](https://github.com/microsoft/winget-cli): Windows Package Manager CLI.
- [scoop](https://scoop.sh): A command-line installer for Windows.
- [gow](https://github.com/bmatzelle/gow): Unix command line utilities installer for Windows.
- [starship](https://starship.rs): A cross-shell prompt.
- [npiperelay](https://github.com/jstarks/npiperelay): Access Windows named pipes from WSL.

##### PowerShell Modules

- [DirColors](https://www.powershellgallery.com/packages/DirColors): Provides dircolors-like functionality to all System.IO.FilesystemInfo formatters.
- [Recycle](https://www.powershellgallery.com/packages/Recycle): Deletes the file or folder as if it had been done via File Explorer, or restores a deleted file from the recycle bin.

### GUI apps installed

#### Windows and macOS

- [1Password](https://1password.com): A password manager developed by AgileBits.
- [Discord](https://discord.com): A VoIP and instant messaging social platform.
- [IRCCloud](https://www.irccloud.com/)
- [Microsoft Teams](https://www.microsoft.com/en-us/microsoft-teams/group-chat-software?ms.url=teamscom&rtc=1)
- [Slack](https://slack.com/)
- [Visual Studio Code](https://code.visualstudio.com)
- [Vivaldi](https://vivaldi.com/)

#### macOS

- [1Password for Safari](https://apps.apple.com/us/app/1password-for-safari/id1569813296?mt=12&uo=4&at=10l4tL)
- [AdGuard for Safari](https://apps.apple.com/us/app/adguard-for-safari/id1440147259?mt=12&uo=4&at=10l4tL)
- [Aerial](https://aerialscreensaver.github.io): A macOS screensaver that lets you play videos from Apple's tvOS screensaver.
- [Alfred](https://www.alfredapp.com)
- [AppCleaner](https://macpaw.com/how-to/best-mac-cleaner-software)
- [Bear](https://www.pcmag.com/reviews/bear-for-mac)
- [BlockBlock](https://objective-see.org/products/blockblock.html): Monitors common persistence locations and alerts whenever a persistent component is added.
- [Brooklyn](https://brooklyn99.fandom.com/wiki/Mac)
- [Calibre](https://en.wikipedia.org/wiki/Calibre_(software))
- [CleanMyDrive 2](https://apps.apple.com/us/app/cleanmydrive-2/id523620159?mt=12&uo=4&at=10l4tL)
- [Declutter](https://apps.apple.com/us/app/declutter-pro/id1187706662?mt=12&uo=4&at=10l4tL)
- [DevDocs for macOS](https://github.com/dteoh/devdocs-macos): An unofficial [DevDocs API Documentation](https://devdocs.io/) viewer for macOS.
- [GoodLinks](https://apps.apple.com/us/app/goodlinks/id1474335294?uo=4&at=10l4tL)
- [Hidden Bar](https://apps.apple.com/us/app/hidden-bar/id1452453066?mt=12&uo=4&at=10l4tL)
- [Hush](https://apps.apple.com/us/app/hush-nag-blocker/id1544743900?uo=4&at=10l4tL)
- [Itsycal for Mac](https://www.mowglii.com/itsycal/): A tiny menu bar calendar.
- [LilyView](https://apps.apple.com/us/app/lilyview/id529490330?mt=12&uo=4&at=10l4tL)
- [LuLu](https://objective-see.org/products/lulu.html): The free, open-source firewall that aims to block unknown outgoing connections.
- [Magnet](https://apps.apple.com/us/app/magnet/id441258766?mt=12&uo=4&at=10l4tL)
- [MusicHarbor](https://apps.apple.com/us/app/musicharbor-track-new-music/id1440405750?uo=4&at=10l4tL)
- [PiPer](https://apps.apple.com/us/app/piper/id1421915518?mt=12&uo=4&at=10l4tL)
- [PopClip](https://apps.apple.com/us/app/popclip/id445189367?mt=12&uo=4&at=10l4tL)
- [Privacy Redirect](https://apps.apple.com/us/app/privacy-redirect/id1578144015?uo=4&at=10l4tL)
- [SessionRestore](https://apps.apple.com/us/app/sessionrestore-for-safari/id1463334954?mt=12&uo=4&at=10l4tL)
- [Shut Up](https://apps.apple.com/us/app/shut-up-comment-blocker/id1015043880?uo=4&at=10l4tL)
- [Social Fixer for Facebook](https://apps.apple.com/app/social-fixer-for-facebook/id1562017526)
- [StopTheMadness](https://apps.apple.com/us/app/stopthemadness/id1376402589?mt=12&uo=4&at=10l4tL)
- [SwiftDefaultApps](https://github.com/Lord-Kamina/SwiftDefaultApps): A preference pane will let you view and change default application associations.
- [SyncThing](https://syncthing.net/)
- [Tampermonkey](https://www.onlinedown.net/soft/1229995.htm)
- [The Unarchiver](https://macpaw.com/download/the-unarchiver)
- [Todoist](https://todoist.com/app/)
- [Toolkit for YNAB](https://apps.apple.com/us/app/toolkit-for-ynab/id1592912837?mt=12&uo=4&at=10l4tL)
- [Transmission Remote GUI](https://github.com/transmission-remote-gui/transgui): A feature rich cross platform Transmission BitTorrent client. Faster and has more functionality than the built-in web GUI.
- [uBlacklist for Safari](https://apps.apple.com/us/app/ublacklist-for-safari/id1547912640?uo=4&at=10l4tL)
- [UnPlugged](https://apps.apple.com/us/app/unplugged/id423123087?mt=12&uo=4&at=10l4tL)
- [Userscripts](https://apps.apple.com/us/app/userscripts/id1463298887?uo=4&at=10l4tL)
- [Vinegar](https://apps.apple.com/us/app/vinegar-tube-cleaner/id1591303229?uo=4&at=10l4tL)
- [VLC](https://www.videolan.org/vlc/download-macosx.html)
- [WhatsYourSign](https://objective-see.org/products/whatsyoursign.html): Add a menu item to Finder to display a file's cryptographic information.
- [WiFi Explorer](https://apps.apple.com/us/app/wifi-explorer/id494803304?mt=12&uo=4&at=10l4tL)
- [WiFi Signal](https://apps.apple.com/us/app/wifi-signal-status-monitor/id525912054?mt=12&uo=4&at=10l4tL)

##### Fonts

- [Fira Code](https://github.com/tonsky/FiraCode) ([Nerd Font](https://github.com/ryanoasis/nerd-fonts))
- [Fira Mono](https://github.com/mozilla/Fira) ([Nerd Font](https://github.com/ryanoasis/nerd-fonts))
- [Input](https://input.djr.com)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)

##### QuickLook Plugins

- [QLColorCode](https://github.com/anthonygelibert/QLColorCode): A Quick Look plug-in that renders source code with syntax highlighting
- [QLMarkDown](https://github.com/toland/qlmarkdown)
- [QLPrettyPatch](https://github.com/atnan/QLPrettyPatch)
- [QLStephen](https://github.com/whomwah/qlstephen)
- [quicklook-csv](https://github.com/p2/quicklook-csv)
- [quicklook-json](http://www.sagtau.com/quicklookjson.html)
- [WebPQuickLook](https://github.com/emin/WebPQuickLook)

#### Windows

- [7-Zip](https://www.7-zip.org/)
- [AutoHotkey](https://www.autohotkey.com/)
- [Ditto](https://ditto-cp.sourceforge.io)
- [HexChat](https://hexchat.github.io)
- [Notepad++](https://notepad-plus-plus.org/)
- [PowerShell](https://learn.microsoft.com/en-us/powershell/)
- [PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/)
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
- [QuickLook](https://www.apple.com/mac/)
- [Rufus](https://rufus.ie/)
- [SyncTrayzor](https://github.com/canton7/SyncTrayzor)
- [Windows Terminal](https://apps.microsoft.com/store/detail/9N0DX20HK701?hl=en-us&gl=US)

## Apps I install on an as-needed basis

### CLI

- [broot](https://github.com/Canop/broot): A new way to see and navigate directory trees.
- [procs](https://github.com/dalance/procs): A modern replacement for ps written in Rust.
- [htop](https://htop.dev): An interactive process viewer.
- [pup](https://github.com/ericchiang/pup): A command line tool for processing HTML. Available via brew, nix, and go.
- [httpie](https://github.com/httpie/httpie): A command-line HTTP client. Available via brew, nix, and python.
- [hyperfine](https://github.com/sharkdp/hyperfine): A command-line benchmarking tool. Available via brew, nix, and cargo.
- [fclones](https://github.com/pkolaczk/fclones): Finds and removes duplicate files. Available via brew, nix, and cargo.
- [eva](https://github.com/nerdypepper/eva): A simple calculator REPL, similar to bc. Available via brew, nix, and cargo.
- [vivid](https://github.com/sharkdp/vivid): A generator for the LS_COLORS environment variable. Available via brew, nix, and cargo.
- [chars](https://github.com/antifuchs/chars). Tool to display names and codes for unicode codepoints. Available via brew, nix, and cargo.
- [hexyl](https://github.com/sharkdp/hexyl): A simple hex viewer for the terminal. Available via brew, nix, and cargo.
- [dog](https://github.com/ogham/dog): A command-line DNS client. Available via brew as `dog`, nix as `dogdns`, and cargo from the source.
- [titlecase](https://github.com/wezm/titlecase): A small tool that capitalizes English text. Available via cargo.
- [petname](https://github.com/dustinkirkland/petname): Generate human readable random names. Available via pypi and cargo.
- [huniq](https://github.com/koraa/huniq): Command line utility to remove duplicates from the given input. Available via nix and cargo. Uses less memory than awk/uniq-seen. Rarely needed.
- [csview](https://github.com/wfxr/csview): 📠 Pretty and fast csv viewer for cli with cjk/emoji support. Available via brew, nix, scoop, and cargo.
- [csvkit](https://github.com/wireservice/csvkit): A suite of utilities for converting to and working with CSV. Available via brew, nix, and python.
- [ffmpeg](https://ffmpeg.org): A complete, cross-platform solution to record, convert and stream audio and video. Available via brew, nix, and scoop.
- [flint](https://github.com/pengwynn/flint): Check your project for common sources of contributor friction. Available via brew as `flint-checker` and go.

#### On my NAS, to download what I own

- [lgogdownloader](https://github.com/Sude-/lgogdownloader): Unofficial downloader for GOG.com. Available via brew and nix.

#### To deal with icons and images

- [icoutils](https://www.nongnu.org/icoutils/): A set of command-line programs for extracting and converting images in Microsoft Windows(R) icon and cursor files. Available via brew and nix.
- [imagemagick](https://imagemagick.org): Create, edit, compose, or convert digital images. Available via brew, nix, and scoop.

#### For [beets](https://beets.io)

- [mp3val](https://mp3val.sourceforge.net): A small, high-speed, free software tool for checking MPEG audio files' integrity. Available via brew and nix. Also available as direct binary download for Windows.
- [par2cmdline](https://github.com/Parchive/par2cmdline): Available via brew as `par2`, nix, and scoop.

#### macOS

- [makeicns](http://www.amnoid.de/icns/makeicns.html): Create icns files from the command line. Available via brew.
- [terminal-notifier](https://github.com/julienXX/terminal-notifier): A command-line tool to send macOS User Notifications. Available via brew and nix.

### GUI

- [Battle.net](https://us.shop.battle.net/en-us?from=root): Blizzard games client. Available via brew as `battle-net`.
- [MusicBrainz Picard](https://picard.musicbrainz.org): A cross-platform music tagger. Available via brew as `musicbrainz-picard`, nix as `picard`, Microsoft Store, winget as `MusicBrainz.Picard`, and scoop as `picard`.
- [Steam](https://store.steampowered.com): A digital distribution platform. Available via brew, nix, and winget as `Valve.Steam`.
- [Tor Browser](https://www.torproject.org/): Browser with a focus on anonymity using the Tor Network. Available via brew as `tor-browser`, nix as `tor-browser-bundle-bin`, and winget as `TorProject.TorBrowser`.

#### macOS

- [Adapter](https://macroplant.com/adapter): Convert Video, Audio and Images. Available via brew as `adapter`.
- [Gemini 2](https://macpaw.com/gemini): The intelligent duplicate file finder. Available via brew as `gemini`.
- [Numbers](https://www.apple.com/numbers/): Create impressive spreadsheets. Available via Mac App Store.
- [Pages](https://www.apple.com/pages/): Documents that stand apart. Available via Mac App Store.
- [PhotoSweeper](https://overmacs.com): A fast & powerful duplicate photos cleaner for Mac. Available via brew as `photosweeper-x`.
- [Pixelmator](https://www.pixelmator.com/mac/): Powerful, full-featured image editor for Mac. Available via Mac App Store.
- [Wineskin](https://github.com/Gcenx/WineskinServer): A user-friendly tool used to make ports of Microsoft Windows software to macOS. Available via brew as `gcenx/wine/unofficial-wineskin`.

#### Windows (All are available via winget)

- [Autoruns](https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns) (from [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/))
- [Balena Etcher](https://www.balena.io/etcher/)
- [Paint.NET](https://getpaint.net)
- [Process Explorer](https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer) (from [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/))
- [Todoist](https://todoist.com/)
- [WinDirStat](https://windirstat.net/)
- [WinSCP](https://winscp.net/)

## Background and Considerations

I have chosen to write these from scratch at this time for simplicity, and the limited support for Ansible on Windows without also having a Linux host nearby. I will continue to look into other options, but for now, this should meet my needs.

## Limitations

Currently, these scripts do not fully handle everything I would like, such as system bootstrapping and early configuration.

## Help

Questions and comments are always welcome, please open an issue.

## Contributing

Contributions of all kinds, including feedback, are always welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for ways to get started.

Please adhere to this project's [Code of Conduct](CODE_OF_CONDUCT.md) and follow [The Ethical Source Principles](https://ethicalsource.dev/principles/).

## License

Distributed under the terms of the [Blue Oak Model License 1.0.0](LICENSE.md) license.

## See Also

### Superseded Projects

- [mac-setup](https://github.com/kergoth/mac-setup)
- [win-setup](https://github.com/kergoth/win-setup)
- [dotfiles/system-setup/scripts](https://github.com/kergoth/dotfiles/tree/master/system-setup/scripts)

### Partially Superseded Projects

- [arch-setup](https://github.com/kergoth/arch-setup)
