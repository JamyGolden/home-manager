{ pkgs, xdg }:

let
  lua = import ./lua.nix { inherit pkgs; };
  nvim = import ./nvim.nix { inherit pkgs xdg; };
  readline = import ./readline.nix;

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
    # ----------------------------
    go
    pnpm
    yarn
  ];
in {
  packages = nixTools
    ++ lua.packages
    ++ nvim.packages;

  files = {}
    // lua.files
    // nvim.files
    // readline.files;
}
