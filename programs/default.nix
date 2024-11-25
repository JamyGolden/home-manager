{ ... }:
{
  home-manager = {
    enable = true;
  };

  zsh.enable = true;

  vim = import ./vim.nix;
  # starship = import ./starship.nix;
}