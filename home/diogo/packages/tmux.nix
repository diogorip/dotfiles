{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
    extraConfig = ''
      set -g mouse on
      set -s escape-time 0
      set -g default-terminal "tmux-256color"
      set -sa terminal-overrides ",xterm*:Tc"

      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded!"

      bind -n C-k send-keys C-l

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind v split-window -h
      bind n split-window -v
      bind x kill-pane

      bind w new-window -c "#{pane_current_path}"
      bind n next-window
      bind p previous-window

      set -g @catppuccin_flavor 'frappe'
      set -g @catppuccin_window_status_style "basic"
      set -g @catppuccin_window_number "#I"
      set -g @catppuccin_window_text " #{pane_current_command}"
      set -g @catppuccin_window_current_number "#[bold]#I"
      set -g @catppuccin_window_current_text " #{pane_current_command}"

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-style "bg=default"
      set -g status-left ""
      set -g status-right ""
    '';
  };
}
