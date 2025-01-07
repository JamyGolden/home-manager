{
  email,
  fullName,
  homeDirectory,
  paths,
  pkgs,
  stateVersion,
  username,
  xdg,
  ...
}:

let
  packageGroup = import ../packages { inherit xdg pkgs; };
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    packages = packageGroup.packages;

    file = {
      ".editorconfig".source = ../../config/editorconfig/config;
      "${xdg.configHome}/tinted-theming/tinty/config.toml".source = ../../config/tinted-theming/tinty/config.toml;
      "${paths.xdgBinHome}/parallel-commands".source = ../../bin/parallel-commands;
      "${paths.xdgBinHome}/tmux-sessionizer".source = ../../bin/tmux-sessionizer;
    } // packageGroup.files;

    activation = {};

    sessionPath = [
      paths.xdgBinHome
      "$CARGO_HOME/bin"
    ];

    sessionVariables = {
      PROJECTS_PATH = paths.projects;
      EDITOR = "${pkgs.neovim}/bin/nvim";
      DVDCSS_CACHE = "${xdg.dataHome}/dvdcss";
      GNUPGHOME = "${xdg.dataHome}/gnupg";
      INPUTRC = "${xdg.configHome}/readline/inputrc";
      LESSHISTFILE = "${xdg.stateHome}/less/history";
      SCREENRC = "${xdg.configHome}/screen/screenrc";
      USERXSESSIONRC = "${xdg.cacheHome}/X11/xsessionrc";
      WINEPREFIX = "${xdg.dataHome}/wine";
      MYSQL_HISTFILE = "${xdg.dataHome}/mysql_history";
      RUSTUP_HOME = "${xdg.dataHome}/rustup";
      CARGO_HOME = "${xdg.dataHome}/cargo";

      # ZSH specific https://www.zsh.org/mla/workers/1998/msg01024.html
      WORDCHARS="*?.[]~=&;!#$%^(){}<>";
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  } // import ./programs {
    inherit email fullName paths pkgs username xdg;
  };
}
