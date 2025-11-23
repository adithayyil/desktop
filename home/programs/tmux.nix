{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 10000;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    # Prefix key (default Ctrl-b)
    prefix = "C-a";

    extraConfig = ''
      # Enable true color support
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Enable focus events
      set-option -g focus-events on

      # Reduce escape time for better vim experience
      set-option -sg escape-time 10

      # Renumber windows when one is closed
      set-option -g renumber-windows on

      # Start pane numbering at 1
      set-window-option -g pane-base-index 1

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Vim-style pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Catppuccin Latte Theme
      # Base colors
      set-option -g status-style "bg=#eff1f5,fg=#4c4f69"

      # Window status
      set-window-option -g window-status-style "fg=#4c4f69,bg=#eff1f5"
      set-window-option -g window-status-current-style "fg=#eff1f5,bg=#7287fd,bold"

      # Pane borders
      set-option -g pane-border-style "fg=#9ca0b0"
      set-option -g pane-active-border-style "fg=#7287fd"
      set-option -g pane-border-lines heavy

      # Message style
      set-option -g message-style "bg=#7287fd,fg=#eff1f5"
      set-option -g message-command-style "bg=#7287fd,fg=#eff1f5"

      # Status bar
      set-option -g status-left "#[fg=#eff1f5,bg=#7287fd,bold] #S #[fg=#7287fd,bg=#eff1f5]"
      set-option -g status-right "#[fg=#7287fd,bg=#eff1f5]#[fg=#eff1f5,bg=#7287fd] #H "
      set-option -g status-left-length 20
      set-option -g status-right-length 50

      # Window status format
      set-window-option -g window-status-format " #I:#W "
      set-window-option -g window-status-current-format " #I:#W "

      # Copy mode colors
      set-window-option -g mode-style "bg=#7287fd,fg=#eff1f5"
    '';
  };
}
