{ lib, pkgs, xdg }:

let
  google-cloud = import ./google-cloud.nix { inherit pkgs; };
  intellij-idea = import ./intellij-idea.nix { inherit pkgs; };
  lua = import ./lua.nix { inherit pkgs; };
  nvim = import ./nvim.nix { inherit pkgs xdg; };
  readline = import ./readline.nix;
  rustup = import ./rustup.nix { inherit lib pkgs; };

  nixTools = with pkgs; [
    # ===================
    # CLI
    # ===================
    asdf-vm
    bat
    bottom
    difftastic
    dust
    jaq
    neovim
    nix-prefetch
    nix-prefetch-git
    nodejs
    procs
    rename
    ripgrep
    tealdeer
    trash-cli
    wget
    xh

    # Languages / Package managers
    # ------------------
    go
    pnpm
    yarn

    # ===================
    # GUI
    # ===================
    bitwarden
    discord
    ferdium
    firefox
    google-chrome
    hexchat
    obsidian
    signal-desktop
    slack
    sublime-merge
    sublime3
    telegram-desktop
    vlc
    vscode
    zed-editor

    # ===================
    # Hardware
    # ===================
    amdgpu_top
    # openrazer-daemon
    # polychromatic

    # ===================
    # Fonts
    # ===================
    (pkgs.nerd-fonts.fira-mono)
    (pkgs.nerd-fonts.noto)
    (pkgs.noto-fonts-emoji)
  ];
in {
  packages = nixTools
    ++ google-cloud.packages
    ++ intellij-idea.packages
    ++ lua.packages
    ++ nvim.packages
    ++ rustup.packages;

  activation.setupRustup = rustup.activation;

  files =
    intellij-idea.files
    // lua.files
    // nvim.files
    // readline.files;
}
