{
  paths, pkgs, xdg, ...
}:
{
  alacritty = import ./alacritty.nix { inherit xdg; };
  zsh = import ./zsh.nix { inherit paths pkgs; };
}
