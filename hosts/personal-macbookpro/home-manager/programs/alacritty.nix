{
  xdg, ...
}:
{
  enable = true;
  settings = {
    font = {
      size = 16.0;
      bold = {
        family = "FiraMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "FiraMono Nerd Font";
        style = "Italic";
      };
      normal = {
        family = "FiraMono Nerd Font";
        style = "Medium";
      };
    };
    general = {
      import = ["${xdg.dataHome}/tinted-theming/tinty/tinted-alacritty-colors-256-file.toml"];
    };
  };
}
