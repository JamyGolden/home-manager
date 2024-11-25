{
  homeDirectory,
  paths,
  pkgs,
  stateVersion,
  system,
  username,
}:

let
  packages = import ../packages.nix { inherit pkgs; };
  modules = import ../modules/home-manager { inherit paths pkgs; };
  programs = import ../programs { inherit paths; };
in
{
  imports = [
    modules
  ];

  xdg = {
    enable = true;
    configFile = true;
    dataFile = true;
  };

  targets.genericLinux.enable = true;

  home = {
    inherit homeDirectory packages stateVersion username;

    # Named `aaaSetup` for alphabetical order priority to erase
    # initScript before anything else writes to it
    #activation.aaaSetup = ''
    #  rm -f "${paths.initRcScript}"

    #  cat > "${paths.initEnvScript}" <<EOF
    #    #!/usr/bin/env sh
    #    PATH="\$HOME/.nix-profile/bin:\$HOME/.nix-profile/sbin:/nix/var/nix/profiles/default/bin:\$PATH"
    #    export IS_NIX_INIT=1
    #    export XDG_CACHE_HOME="${paths.xdgCacheHome}"
    #    export XDG_CONFIG_HOME="${paths.xdgConfigHome}"
    #    export XDG_DATA_HOME="${paths.xdgDataHome}"
    #    export XDG_STATE_HOME="${paths.xdgStateHome}"
    #    export XDG_BIN_HOME="${paths.xdgBinHome}"
    #    export XDG_INCLUDE_HOME="${paths.xdgIncludeHome}"
    #    XDG_DATA_DIRS="$HOME/.nix-profile/share:\$XDG_DATA_DIRS"
    #  EOF
    #  '';
  };

  # Define session variables (environment variables)
  home.sessionVariables = {
    # Uncomment and set your preferred editor
    # EDITOR = "vim";
    # PROJECTS_PATH = paths.projects;
    # DOTFILES_REPO_PATH = paths.dotfilesRepo;
    XDG_CONFIG_HOME = paths.xdgConfigHome;
    XDG_DATA_HOME = paths.xdgDataHome;
    XDG_CACHE_HOME = paths.xdgCacheHome;
    XDG_STATE_HOME = paths.xdgStateHome;
    XDG_BIN_HOME = paths.xdgBinHome;
    XDG_INCLUDE_HOME = paths.xdgIncludeHome;
  };

  # shellAliases = {
  #     cd = "z";
  #     cat = "bat";
  #     diff = "difft";
  #     du = "dust";
  #     ls = "eza";
  #     ps = "procs";
  #     rm = "trash-put";
  #     top = "bottom";
  # };

  # Enable Home Manager
  programs = programs;
}