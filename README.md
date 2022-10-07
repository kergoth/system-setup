# Christopher Larson's Personal System Setup Scripts

[![BlueOak 1.0.0 License](https://img.shields.io/badge/License-BlueOak%201.0.0-2D6B79.svg)](https://spdx.org/licenses/BlueOak-1.0.0.html)

This project holds the consolidation of my various per-system setup script repositories into something more cohesive.

## Prerequisites

- Logged in as your already-configured user.
- On macOS, Command-Line Tools or XCode must be installed (See extras/ for scripts to install these).

## Usage

### Linux or macOS

As a non-root user:

```console
./setup
```

As a user that can run `sudo`:

```console
./setup-admin
```

### Windows

In powershell:

```console
./setup.ps1
```

In an Administrative PowerShell:

```console
./setup-admin.ps1
```

## Manual Steps to Take Next

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

## Details

### Apps installed

- bat
- exa
- fd
- fzf
- ripgrep
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command, inspired by z and autojump.
- sad
- sd

### Apps I install on an as-needed basis

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
