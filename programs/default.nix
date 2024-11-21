{
  home-manager = {
    enable = true;
  };

  vim = import ./vim.nix;
  starship = import ./starship.nix;
}