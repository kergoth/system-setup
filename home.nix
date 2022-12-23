{ config, pkgs, ... }:

{
  # The home-manager manual is at:
  #
  #   https://rycee.gitlab.io/home-manager/release-notes.html
  #
  # Configuration options are documented at:
  #
  #   https://rycee.gitlab.io/home-manager/options.html
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    wget

    git
    git-lfs
    neovim
    ssh-copy-id
    tmux

    cargo
    (python310.withPackages (ps: with ps; [ pip ]))
    python310.pkgs.pipx
    go

    choose
    fd
    ripgrep
    zoxide
    sd
    sad

    # SCM & Related
    delta
    gh
    git-absorb
    git-branchless
    git-imerge
    git-revise
    patchutils
    peru
    sapling

    # Disk tools
    dua
    du-dust

    # Linting and formatting
    shellcheck
    shfmt

    # Bug tracking and workflow
    jira-cli-go

    # Nix tools
    nvd
  ] ++ lib.optionals stdenv.isDarwin [
    colima
    duti
    lima
    mas
    reattach-to-user-namespace
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Enable directly supported programs
    direnv.enable = true;
    # direnv.nix-direnv.enable = true;
    fzf.enable = true;
    jq.enable = true;
    bat.enable = true;
    exa.enable = true;
  };
}
