{ paths, pkgs, ... }:
{
  home.packages = with pkgs; [
    fnm
  ];

  # home.activation.configureFnm = ''
  #   cat >> "${paths.initEnvScript}" <<EOF
  #   PATH="$HOME/.fnm/bin:\$PATH"
  #   EOF

  #   # fnm completions --shell zsh
  #   cat >> "${paths.initRcScript}" <<EOF
  #   if [ "\$(command -v 'fnm')" ]; then
  #     eval "\$(fnm env --use-on-cd --shell=zsh --fnm-dir=${paths.xdgDataHome}/fnm)"
  #   fi
  #   EOF
  # '';
}