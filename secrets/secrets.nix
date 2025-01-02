let
  homeLinux = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJucsEn8lsQtk+z25zpUhBJGaeDSkNH0vlX+Uac1uYm+";
  personalMacBookPro = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPT8ziGG+XKIMstKMMiJ+cneNZn7RxxegtiTM3Sdjkyv";
  users = [ homeLinux personalMacBookPro ];
in
{
  "work-email.age".publicKeys = users;
  "work-dir-name.age".publicKeys = users;
  "work-artifactory-pwd.age".publicKeys = users;
}
