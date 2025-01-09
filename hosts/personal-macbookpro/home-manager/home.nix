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
  localPrograms = import ./programs { inherit paths pkgs xdg; };
in
{
  home = {
    inherit homeDirectory stateVersion username;
    file = sharedHome.home.file;
    # activation = sharedHome.home.activation;
    sessionPath = sharedHome.home.sessionPath;
    sessionVariables = sharedHome.home.sessionVariables // {
      LC_ALL = "en_US.UTF-8";
      LC_ADDRESS= "en_US.UTF-8";
      LC_NAME= "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
    # specify my home-manager configs
    packages = sharedHome.home.packages;
  };

  programs =
    sharedHome.programs
    // localPrograms;
}
