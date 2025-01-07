{ pkgs, homeDirectory, username, paths, ... }: {
  users.users.${username}.home = homeDirectory;
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bashInteractive zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" paths.xdgBinHome ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "Fira" "FiraMono" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.KeyRepeat = 1;
    dock.autohide = false;
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    trackpad.TrackpadThreeFingerDrag = true;
  };
  system.stateVersion = 5; # backwards compat; don't change
}
