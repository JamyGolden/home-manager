{
  config,
  homeDirectory,
  ...
}:
{
  age = {
    secrets = {
      workEmail = {
        file = ../../secrets/work-email.age;
      };
      workDirName = {
        file = ../../secrets/work-dir-name.age;
      };
      workArtifactoryPwd = {
        file = ../../secrets/work-artifactory-pwd.age;
      };
    };
    secretsDir = "${config.xdg.dataHome}/agenix/agenix";
    secretsMountPoint = "${config.xdg.dataHome}/agenix/agenix.d";
    identityPaths = [ "${homeDirectory}/.ssh/agenix_ed25519" ];
  };
}

