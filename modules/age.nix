{
  homeDirectory,
  secretsDir,
  secretsMountPoint,
  ...
}:
{
  age = {
    inherit secretsDir secretsMountPoint;

    secrets = {
      workEmail = {
        file = ../secrets/work-email.age;
      };
      workDirName = {
        file = ../secrets/work-dir-name.age;
      };
      workArtifactoryPwd = {
        file = ../secrets/work-artifactory-pwd.age;
      };
    };
    identityPaths = [ "${homeDirectory}/.ssh/agenix_ed25519" ];
  };
}

