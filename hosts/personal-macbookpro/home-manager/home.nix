{
  email,
  fullName,
  homeDirectory,
  paths,
  pkgs,
  stateVersion,
  username,
  ...
}:

let
  xdg = {
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
    cacheHome = "${homeDirectory}/.cache";
  };
  sharedHome = import ../../../modules/home-manager/home.nix {
    inherit
      email
      fullName
      homeDirectory
      paths
      pkgs
      stateVersion
      username
      xdg;

  };
  localPrograms = import ./programs { inherit xdg; };
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    file = sharedHome.home.file;
    # activation = sharedHome.home.activation;
    sessionPath = sharedHome.home.sessionPath;
    sessionVariables = sharedHome.home.sessionVariables;
    # specify my home-manager configs
    packages = sharedHome.home.packages;
  };

  programs =
    sharedHome.programs
    // localPrograms;
}
