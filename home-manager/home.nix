{
  config,
  email,
  fullName,
  homeDirectory,
  inputs,
  lib,
  paths,
  pkgs,
  stateVersion,
  system,
  username,
  ...
}:

let
  packageGroup = import ./packages { inherit config lib pkgs; };
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    packages =
      packageGroup.packages
      ++ [ inputs.agenix.packages.${system}.agenix ];

    file = {
      ".editorconfig".source = ../.editorconfig;
      "${config.xdg.configHome}/alacritty/alacritty.toml".source = ../config/alacritty/alacritty.toml;
      "${config.xdg.configHome}/tinted-theming/tinty/config.toml".source = ../config/tinted-theming/tinty/config.toml;
      "${paths.xdgBinHome}/parallel-commands".source = ../bin/parallel-commands;
      "${paths.xdgBinHome}/tmux-sessionizer".source = ../bin/tmux-sessionizer;
    } // packageGroup.files;

    activation = lib.mkMerge [
      packageGroup.activation
    ];

    sessionVariables = {
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

      # Secrets
      WORK_DIRECTORY = "${paths.projects}/$(cat ${config.age.secrets.workDirName.path})";
      ARTIFACTORY_USER = "$(cat ${config.age.secrets.workEmail.path})";
      ARTIFACTORY_PWD = "$(cat ${config.age.secrets.workArtifactoryPwd.path})";
      ARTIFACTORY_NPM_SECRET = "$(echo -n $(cat ${config.age.secrets.workEmail.path}):$(cat ${config.age.secrets.workArtifactoryPwd.path}) | base64 --wrap=0)";
    };
  };

  programs = import ./programs { inherit config email fullName paths pkgs username; };
}
