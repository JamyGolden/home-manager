{ lib, pkgs, xdg }:

let
  google-cloud = import ./google-cloud.nix { inherit pkgs; };
  intellij-idea = import ./intellij-idea.nix { inherit pkgs; };
  rustup = import ./rustup.nix { inherit lib pkgs; };

  nixTools = with pkgs; [
    # ===================
    # CLI
    # ===================
    bitwarden
    ferdium

    # ===================
    # GUI
    # ===================
    discord
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
    openrazer-daemon
    polychromatic

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
    ++ rustup.packages;

  activation.setupRustup = {}
    // rustup.activation;

  files = {}
    // intellij-idea.files;
}
