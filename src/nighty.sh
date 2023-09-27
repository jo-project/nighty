#!/usr/bin/env bash

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
        echo "$value"
    else
        echo "$default"
    fi
}

set() {
    local option=$1
    local value=$2
    tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
    local option=$1
    local value=$2
    tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

main() {
    local theme
    theme="$(get_tmux_option "@nighty_flavour" "moon")"

    local tmux_commands=()

    source $current_dir/themes/nighty-$theme.tmuxtheme

    set  mode-style "fg=#89b4fa,bg=#3b4261"

    set  message-style "fg=#89b4fa,bg=#3b4261"
    set  message-command-style "fg=#89b4fa,bg=#3b4261"

    set  pane-border-style "fg=#3b4261"
    set  pane-active-border-style "fg=#89b4fa"

    set  status "on"
    set  status-justify "left"

    set  status-style "fg=#89b4fa,bg=#181825"

    set  status-left-length "100"
    set  status-right-length "100"

    set  status-left-style NONE
    set  status-right-style NONE

    set  status-left "#[fg=#1E1E2E,bg=#89b4fa,bold] #S #[fg=#89b4fa,bg=#181825,nobold,nounderscore,noitalics]"
    set  status-right "#[fg=#181825,bg=#181825,nobold,nounderscore,noitalics]#[fg=#89b4fa,bg=#181825] #{prefix_highlight} #[fg=#3b4261,bg=#181825,nobold,nounderscore,noitalics]#[fg=#89b4fa,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#89b4fa,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1E1E2E,bg=#89b4fa,bold]  #{b:pane_current_path} "

    setw  window-status-activity-style "NONE,fg=#cdd6f4,bg=#181825"
    setw  window-status-separator ""
    setw  window-status-style "NONE,fg=#cdd6f4,bg=#181825"
    setw  window-status-format "#[fg=#181825,bg=#181825,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#181825,bg=#181825,nobold,nounderscore,noitalics]"
    setw  window-status-current-format "#[fg=#181825,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#89b4fa,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#181825,nobold,nounderscore,noitalics]"

    # tmux-plugins/tmux-prefix-highlight support
    set  @prefix_highlight_output_prefix "#[fg=#ffc777]#[bg=#181825]#[fg=#181825]#[bg=#ffc777]"
    set  @prefix_highlight_output_suffix "" 

    tmux "${tmux_commands[@]}"
}

main "$@"