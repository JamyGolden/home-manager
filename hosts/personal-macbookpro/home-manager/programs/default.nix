{
  xdg, ...
}:
{
  alacritty = import ./alacritty.nix { inherit xdg; };
}
