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

    age = config.age;
    xdg = config.xdg;
  };
  localPackages = import ../packages { inherit lib pkgs; xdg = config.xdg; };
  localPrograms = import ./programs {
    inherit
      email
      fullName
      paths
      pkgs
      username;

    xdg = config.xdg;
  };
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    packages = sharedHome.home.packages
      ++ localPackages.packages;
    file = sharedHome.home.file // localPackages.files // {
      "${config.xdg.configHome}/alacritty/alacritty.toml".source = ../../../config/alacritty/alacritty.toml;
    };
    activation = sharedHome.home.activation // localPackages.activation;
    sessionPath = sharedHome.home.sessionPath;
    sessionVariables = sharedHome.home.sessionVariables // {
      # Secrets
      WORK_DIRECTORY = "${paths.projects}/$(cat ${config.age.secrets.workDirName.path})";
      ARTIFACTORY_USER = "$(cat ${config.age.secrets.workEmail.path})";
      ARTIFACTORY_PWD = "$(cat ${config.age.secrets.workArtifactoryPwd.path})";
      ARTIFACTORY_NPM_SECRET = "$(echo -n $(cat ${config.age.secrets.workEmail.path}):$(cat ${config.age.secrets.workArtifactoryPwd.path}) | base64 --wrap=0)";
      };
  };

  programs = sharedHome.programs
    // localPrograms;
}
