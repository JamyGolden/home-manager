{ pkgs, homeDirectory, username, ... }: {
  users.users.${username}.home = homeDirectory;
  # programs.zsh.enable = true;
  environment = {
    # shells = with pkgs; [ bash zsh ];
    # loginShell = pkgs.zsh;
    # systemPackages = [ pkgs.coreutils ];
    # systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # fonts.fontDir.enable = true; # Overrides manually installed fonts
  # fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Fira" "FiraMono" ]; }) ];
  # services.nix-daemon.enable = true;
  # system.defaults = {
  #   finder.AppleShowAllExtensions = true;
  #   finder._FXShowPosixPathInTitle = true;
  #   dock.autohide = false;
  #   NSGlobalDomain.AppleShowAllExtensions = true;
  #   NSGlobalDomain.InitialKeyRepeat = 14;
  #   NSGlobalDomain.KeyRepeat = 1;
  # };
  system.stateVersion = 4; # backwards compat; don't change
}
