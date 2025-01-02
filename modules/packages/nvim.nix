{ pkgs, xdg, ... }:

{
  packages = with pkgs; [
    neovim
  ];

  files = {
    "${xdg.configHome}/nvim/after".source = ../../config/nvim/after;
    "${xdg.configHome}/nvim/lua".source = ../../config/nvim/lua;
    "${xdg.configHome}/nvim/init.lua".source = ../../config/nvim/init.lua;
  };
}
