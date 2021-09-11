# Kergoth's System Setup Scripts

[![BlueOak 1.0.0 License](https://img.shields.io/pypi/l/system-setup)](https://spdx.org/licenses/BlueOak-1.0.0.html)

This project holds the consolidation of my various per-system setup script repositories into something more cohesive.

## Prerequisites

- Logged in as your already-configured user.
- On macOS, Command-Line Tools or XCode must be installed (See extras/ for scripts to install these).

## Usage

### Linux or macOS

```console
./setup
```

As user that can run sudo:

```console
./setup-admin
```

### Windows

In powershell:

```console
./setup.ps1
```

In an Administrative powershell:

```console
./setup-admin.ps1
```

## Background and Considerations

I have chosen to write these from scratch at this time for simplicity, and the limited support for Ansible on Windows without also having a Linux host nearby. I will continue to look into other options, but for now this should meet my needs.

## Limitations

Currently, these scripts do not fully handle all the setup I would like, such as system bootstrapping and early configuration.

## Help

Questions and comments are always welcome, please open an issue.

## Contributing

Contributions of all kinds, including feedback, are always welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for ways to get started.

Please adhere to this project's [Code of Conduct](CODE_OF_CONDUCT.md) and follow [The Ethical Source Principles](https://ethicalsource.dev/principles/).

## License

Distributed under the terms of the [Blue Oak Model License 1.0.0](LICENSE.md) license.

## See Also

### Superceded Projects

- [mac-setup](https://github.com/kergoth/mac-setup)
- [win-setup](https://github.com/kergoth/win-setup)
- [dotfiles/system-setup/scripts](https://github.com/kergoth/dotfiles/tree/master/system-setup/scripts)

### Partially Superceded Projects

- [arch-setup](https://github.com/kergoth/arch-setup): this also handles install/bootstrap
