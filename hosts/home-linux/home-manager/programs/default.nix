{
  email,
  fullName,
  paths,
  pkgs,
  username,
  xdg,
  ...
}:
{
  git = import ./git.nix { inherit email fullName paths; };
  zsh = import ./zsh.nix { inherit xdg paths pkgs username; };
}
