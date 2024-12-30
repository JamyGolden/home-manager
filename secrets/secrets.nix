let
  linuxDesktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJucsEn8lsQtk+z25zpUhBJGaeDSkNH0vlX+Uac1uYm+";
  users = [ linuxDesktop ];
in
{
  "work-email.age".publicKeys = users;
  "work-dir-name.age".publicKeys = users;
  "work-artifactory-pwd.age".publicKeys = users;
}
