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
- Run ssh-add in powershell to add my key to the agent, if it exists
- Remove Edge, Store, Mail from the task bar pins.

## Apps Installed

### CLI apps installed

- wget
- git
- neovim

- rust
- go
- python
  - flake8 with pep8-naming and flake8-docstrings
- pipx

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

- ssh-copy-id
- tmux
- patchutils

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

- nix
- openssh
- pkgfile
- nss-mdns
- avahi

#### Windows

- winget
- scoop
- gow
- starship
- npiperelay

##### PowerShell Modules

- DirColors
- Recycle
- posh-alias

### GUI apps installed

#### Windows and macOS

- 1Password
- Discord
- IRCCloud
- Microsoft Teams
- Slack
- Visual Studio Code
- Vivaldi

#### macOS

- 1Password for Safari
- AdGuard for Safari
- Aerial
- Alfred
- AppCleaner
- Bear
- Brooklyn
- Calibre
- Carbon Copy Cloner
- CleanMyDrive 2
- Declutter
- DaisyDisk
- Deliveries
- Docker
- [DevDocs for macOS](https://github.com/dteoh/devdocs-macos): An unofficial [DevDocs API Documentation](https://devdocs.io/) viewer for macOS.
- git-credential-manager-core
- GoodLinks
- Hidden Bar
- Hush
- [Itsycal for Mac](https://www.mowglii.com/itsycal/): A tiny menu bar calendar.
- Karabiner Elements
- Keeping You Awake
- LilyView
- [LuLu](https://objective-see.org/products/lulu.html): The free, open-source firewall that aims to block unknown outgoing connections.
- Magnet
- MusicHarbor
- OmniOutliner
- Oversight
- Parallels Desktop 16 (Not the current version)
- PiPer
- PopClip
- Privacy Redirect
- Reeder
- Refined GitHub
- ReiKey
- Save to Matter
- SessionRestore
- Shut Up
- Social Fixer for Facebook
- Soulver 2
- Spark
- StopTheMadness
- swiftdefaultappsprefpane
- SyncThing
- Tampermonkey
- The Unarchiver
- Todoist
- Toolkit for YNAB
- Transmission Remote GUI
- uBlacklist for Safari
- UnPlugged
- Userscripts
- Vinegar
- VLC
- Vmware Horizon Client
- WhatsYourSign
- WiFi Explorer
- WiFi Signal

##### Fonts

- Fira Code (Nerd Font)
- Fira Mono (Nerd Font)
- Input
- JetBrains Mono

##### QuickLook Plugins

- [QLColorCode](https://github.com/anthonygelibert/QLColorCode): A Quick Look plug-in that renders source code with syntax highlighting
- QLMarkDown
- QLPrettyPatch
- QLStephen
- quicklook-csv
- quicklook-json
- WebPQuickLook

#### Windows

- 7-Zip
- AutoHotkey
- [Ditto](https://ditto-cp.sourceforge.io)
- HexChat
- Notepad++
- PowerShell
- PowerToys
- PuTTY
- QuickLook
- Rufus
- SyncTrayzor
- Windows Terminal

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

- Autoruns (from Sysinternals)
- Balena Etcher
- Paint.NET
- Process Explorer (from Sysinternals)
- Todoist
- WinDirStat
- WinSCP

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
