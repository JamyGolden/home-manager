{
  config,
  email,
  fullName,
  homeDirectory,
  lib,
  paths,
  pkgs,
  stateVersion,
  username,
  ...
}:

let
  packageGroup = import ./packages { inherit config lib pkgs; };
in
{
  imports = [];

  xdg = {
    enable = true;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Fira Mono"];
      emoji = ["Noto Color Emoji"];
    };
  };

  home = {
    inherit homeDirectory stateVersion username;
    packages = packageGroup.packages;

    file = {
      ".editorconfig".source = ../.editorconfig;
      ".zsh_functions".source = ../config/zsh/zsh_functions;
      "${config.xdg.configHome}/alacritty/alacritty.toml".source = ../config/alacritty/alacritty.toml;
      "${paths.xdgBinHome}/parallel-commands".source = ../bin/parallel-commands;
      "${paths.xdgBinHome}/tmux-sessionizer".source = ../bin/tmux-sessionizer;
    } // packageGroup.files;
  };

  home.activation = lib.mkMerge [
    packageGroup.activation
  ];

  home.sessionVariables = {
    PROJECTS_PATH = paths.projects;
    DOTFILES_REPO_PATH = paths.dotfilesRepo;
    XDG_BIN_HOME = paths.xdgBinHome;
    PATH = "${config.xdg.dataHome}/cargo/bin:$PATH";
  };

  programs = import ./programs { inherit config email fullName paths pkgs; };
}