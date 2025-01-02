{
  paths,
  pkgs,
  xdg,
  ...
}:
{
  enable = true;
  clock24 = true;
  escapeTime = 0; # Address vim mode switching delay (http://superuser.com/a/252717/65504)
  focusEvents = true; # Focus events enabled for terminals that support them
  historyLimit = 50000;
  keyMode = "vi";
  secureSocket = true;
  sensibleOnTop = true;
  shell = "${pkgs.zsh}/bin/zsh";
  shortcut = "a";
  terminal = if pkgs.stdenv.hostPlatform.isDarwin then "screen-256color" else "tmux-256color";
  plugins = with pkgs; [
    tmuxPlugins.vim-tmux-navigator
  ];
  extraConfig = ''
    # Go to next and previous window with C-n and C-N
    bind-key N previous-window

    # Binding to reload config file, useful for tweaking tmux
    bind r source ${xdg.configHome}/tmux/tmux.conf \; display-message "Conf reloaded..."

    # Tmux 3.3a, currently on my mac machine
    # https://github.com/tinted-theming/base16-shell/issues/5
    set -g allow-passthrough on

    set -g set-clipboard on

    if-shell '[[ "$(uname -s)" == "Darwin" ]]' {
      # if having issues with your other programs dependent on TERM env variable
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

    } {
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel --input --clipboard"
    }

    # Allows displaying italics correctly
    # set -ga terminal-overrides ",*256col*:Tc"
    set -as terminal-overrides ",alacritty:Tc"

    # Rather than constraining window size to the maximum size of any client
    # connected to the session, constrain window size to the maximum size of any
    # client connected to that window
    setw -g aggressive-resize on

    # Activity monitoring, i.e. display "Activity in window #"
    setw -g monitor-activity on
    set -g visual-activity on

    # Better splitting
    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"

    bind-key -r f run-shell "tmux neww ${paths.xdgBinHome}/tmux-sessionizer"
    bind-key g new-window "lazygit"
  '';
}
