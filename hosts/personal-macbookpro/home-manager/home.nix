{
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
  sharedHome = import ../../../modules/home-manager/home.nix {
    inherit
      email
      fullName
      homeDirectory
      lib
      paths
      pkgs
      stateVersion
      username;

    xdg = {
      configHome = "${homeDirectory}/.config";
      dataHome = "${homeDirectory}/.local/share";
      stateHome = "${homeDirectory}/.local/state";
      cacheHome = "${homeDirectory}/.cache";
    };
  };
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    file = sharedHome.home.file;
    activation = sharedHome.home.activation;
    sessionPath = sharedHome.home.sessionPath;
    sessionVariables = sharedHome.home.sessionVariables;
    # specify my home-manager configs
    packages = with pkgs; [
      ripgrep
      fd
    ];
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
}
