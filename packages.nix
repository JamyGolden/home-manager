{ pkgs }:

let
  nixTools = with pkgs; [
    # ===================
    # CLI
    # ===================
    asdf
    bat
    bottom
    difftastic
    dust
    eza
    jaq
    neovim
    procs
    rename
    ripgrep
    tealdeer
    trash-cli
    wget
    yarn

    # Package managers
    # ------------------
    # fnm
    # sdkman

    # Languages
    # ------------------
    go
    lua

    # rust
    # gcc
    rustup

    # ===================
    # GUI
    # ===================
    firefox
    vlc
    vscode
  ];
in nixTools