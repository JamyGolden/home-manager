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
      "${config.xdg.configHome}/alacritty/alacritty.toml".source = ../config/alacritty/alacritty.toml;
      "${paths.xdgBinHome}/parallel-commands".source = ../bin/parallel-commands;
      "${paths.xdgBinHome}/tmux-sessionizer".source = ../bin/tmux-sessionizer;
    } // packageGroup.files;

    activation = lib.mkMerge [
      packageGroup.activation
    ];

    sessionVariables = {
      SECRETS_REPO_PATH = paths.secretsRepo;
      PROJECTS_PATH = paths.projects;
      EDITOR = "${pkgs.neovim}/bin/nvim";
      DVDCSS_CACHE = "${config.xdg.dataHome}/dvdcss";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      INPUTRC = "${config.xdg.configHome}/readline/inputrc";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      SCREENRC = "${config.xdg.configHome}/screen/screenrc";
      USERXSESSIONRC = "${config.xdg.cacheHome}/X11/xsessionrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      MYSQL_HISTFILE = "${config.xdg.dataHome}/mysql_history";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";

      # ZSH specific https://www.zsh.org/mla/workers/1998/msg01024.html
      WORDCHARS="*?.[]~=&;!#$%^(){}<>";
    };
  };

  programs = import ./programs { inherit config email fullName paths pkgs username; };
}
