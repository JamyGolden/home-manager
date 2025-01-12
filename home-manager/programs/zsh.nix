{
  config,
  paths,
  pkgs,
  username,
}:
{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  plugins = [
    {
      name = "vi-mode";
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }
  ];

  shellAliases = {
    cd = "z"; # zoxide
    jq = "jaq";
    ps = "procs";
    switch = "home-manager switch --flake ${paths.dotfilesRepoAbs}#${username}";
    yarn = ''
      yarn --use-yarnrc "${config.xdg.configHome}/yarn/config";
    '';
  };

  initExtra = ''
    if [ -d "$CARGO_HOME/bin" ]; then
      PATH="$CARGO_HOME/bin:$PATH"
    fi

    if [ -e "${paths.dotfilesRepo}/config/zsh/zsh_functions" ]; then
      . "${paths.dotfilesRepo}/config/zsh/zsh_functions"
    fi

    if [ -f "$HOME/.asdf/asdf.sh" ]; then
      . "$HOME/.asdf/asdf.sh"
    fi
  '';

  # Content you want to include in ~/.zshenv
  envExtra = ''
    export PATH="${paths.xdgBinHome}:$PATH"

    if [[ $(uname -s) == "Darwin"* ]]; then
      export OS_TYPE="mac"
    elif [ -s "/etc/debian_version" ]; then
      export OS_TYPE="debian"
    else
      export OS_TYPE="unknown"
    fi
  '';
}
