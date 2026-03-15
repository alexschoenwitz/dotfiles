{ pkgs, config, ... }:
let
  p = config.theme.palette;
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-ghostty";
    historyLimit = 100000;
    extraConfig = ''
      setenv -g COLORTERM "truecolor"

      set -g focus-events on
      set -g set-clipboard on

      # Status bar
      set -g status-position bottom
      set -g status-justify left
      set -g status-left-length 50
      set -g status-right-length 100
      set -g status-style bg=default,fg=#${p.base05}

      set -g status-left '#[fg=#${p.base0D},bold]#{session_name} #[fg=#${p.base05}]│ '
      set -g status-right '#[fg=#${p.base0E}]#(~/.config/tmux/kube-tmux.sh) #[fg=#${p.base05}]%Y-%m-%d #[fg=#${p.base0D},bold]%H:%M'

      set -g window-status-format '#[fg=#${p.base03}] #I:#W '
      set -g window-status-current-format '#[fg=#${p.base0C},bold] #I:#W#{?window_zoomed_flag,Z,} '
      set -g window-status-separator '''

      set -gu default-command
      set -s escape-time 10

      set-option -g repeat-time 1000
      setw -g mouse on

      set -g base-index 1
      setw -g pane-base-index 1

      set-option -g renumber-windows on

      set-option -g set-titles on
      set-option -g set-titles-string "#S / #W"

      set-option -g status-interval 1
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      set-option -g cursor-style blinking-block


      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

      # smart-splits.nvim integration
      bind-key -n C-h if -F "#{@pane-is-vim}" 'send-keys C-h' 'select-pane -L'
      bind-key -n C-j if -F "#{@pane-is-vim}" 'send-keys C-j' 'select-pane -D'
      bind-key -n C-k if -F "#{@pane-is-vim}" 'send-keys C-k' 'select-pane -U'
      bind-key -n C-l if -F "#{@pane-is-vim}" 'send-keys C-l' 'select-pane -R'

      bind u split-window -l 50% -v -c "#{pane_current_path}"
      bind i split-window -l 50% -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind o if-shell 'test $(tmux list-panes | wc -l) -gt 1' 'last-pane' 'last-window'
      bind s switch-client -p
      bind S switch-client -n
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R
      bind r source-file ~/.tmux.conf
      unbind C-z
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
    ];
  };

  xdg.configFile."tmux/kube-tmux.sh" = {
    source = ./kube-tmux.sh;
    executable = true;
  };
}
