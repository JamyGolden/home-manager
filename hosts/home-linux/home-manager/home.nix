{
  agenixPkg,
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
      agenixPkg
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
in
{
  imports = [];

  home = {
    inherit homeDirectory stateVersion username;
    packages = 
      sharedHome.home.packages
      ++ [ agenixPkg ];
    file = sharedHome.home.file;
    activation = sharedHome.home.activation;
    sessionPath = sharedHome.home.sessionPath;
    sessionVariables = sharedHome.home.sessionVariables // {
      # Secrets
      WORK_DIRECTORY = "${paths.projects}/$(cat ${config.age.secrets.workDirName.path})";
      ARTIFACTORY_USER = "$(cat ${config.age.secrets.workEmail.path})";
      ARTIFACTORY_PWD = "$(cat ${config.age.secrets.workArtifactoryPwd.path})";
      ARTIFACTORY_NPM_SECRET = "$(echo -n $(cat ${config.age.secrets.workEmail.path}):$(cat ${config.age.secrets.workArtifactoryPwd.path}) | base64 --wrap=0)";
      };
  };

  programs = sharedHome.programs;
}
