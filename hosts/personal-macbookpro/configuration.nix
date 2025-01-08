{ pkgs, homeDirectory, username, paths, ... }: {
  users.users.${username}.home = homeDirectory;
  # programs = {
  #   zsh.enable = true;
  #   zsh.shellInit = ''
  #     export LANG=en_US.UTF-8
  #     export LC_ALL=en_US.UTF-8
  #   '';
  # };
  #   zsh.enableCompletion = true;
  #   zsh.variables = {
  #     LC_CTYPE = "en_GB.UTF-8";
  #     LC_ALL = "en_GB.UTF-8";
  #   };
  # };
  environment = {
    # shells = with pkgs; [ zsh bashInteractive ];
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" paths.xdgBinHome ];
    pathsToLink = [ "/Applications" ];
    variables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.packages = [
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.noto
    pkgs.noto-fonts-emoji
  ];
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
