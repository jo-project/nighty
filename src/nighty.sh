#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/nighty-moon.tmuxtheme

main() {
    tmux set-option -g status "on"
    tmux set-option -g status-justify "left"
    tmux set-option -g status-left-length "100"
    tmux set-option -g status-right-length "100"
    tmux set-option -g status-style "fg=${thm_blue},bg=${thm_bg}"
    tmux set-option -g status-left-style NONE
    tmux set-option -g status-right-style NONE

    # Mode
    tmux set-option -g mode-style "fg=${thm_blue},bg=${thm_fg}"

    # Messages
    tmux set-option -g message-style "fg=${thm_blue},bg=${thm_fg}"
    tmux set-option -g message-command-style "fg=${thm_blue},bg=${thm_fg}"

    # Panes
    tmux set-option -g pane-border-style "fg=${thm_fg}"
    tmux set-option -g pane-active-border-style "fg=${thm_blue}"

    # Windows
    tmux set-option -g window-status-activity-style "underscore,fg=${thm_fgdark},bg=${thm_bg}"
    tmux set-option -g window-status-separator ""
    tmux set-option -g window-status-style "NONE,fg=${thm_fgdark},bg=${thm_bg}"
    tmux set-option -g window-status-format "#[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]"
    tmux set-option -g window-status-current-format "#[fg=${thm_bg},bg=${thm_fg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_fg},bold] #I  #W #F #[fg=${thm_fg},bg=${thm_bg},nobold,nounderscore,noitalics]"

    tmux set-option -g status-left "#[fg=${thm_bgdark},bg=${thm_blue},bold] #S #[fg=${thm_blue},bg=${thm_bg},nobold,nounderscore,noitalics]"

    tmux set-option -g status-right "#[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_bg}] #{prefix_highlight} #[fg=${thm_fg},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_fg}] %Y-%m-%d  %I:%M %p #[fg=${thm_blue},bg=${thm_fg},nobold,nounderscore,noitalics]#[fg=${thm_bgdark},bg=${thm_blue},bold]  #{b:pane_current_path} "

    tmux set-option -g @prefix_highlight_output_prefix "#[fg=${thm_yellow}]#[bg=${thm_bg}]#[fg=${thm_bg}]#[bg=${thm_yellow}]"
    tmux set-option -g @prefix_highlight_output_suffix ""
}

main