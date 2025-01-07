{
  paths,
  pkgs,
  xdg,
  ...
}:
{
  atuin = import ./atuin.nix;
  direnv = import ./direnv.nix;
  eza = import ./eza.nix;
  fd = import ./fd.nix;
  fzf = import ./fzf.nix;
  gradle = import ./gradle.nix;
  java = import ./java.nix { inherit pkgs; };
  lazygit = import ./lazygit.nix;
  starship = import ./starship.nix;
  tmux = import ./tmux.nix { inherit xdg paths pkgs; };
  zoxide = import ./zoxide.nix;
}
