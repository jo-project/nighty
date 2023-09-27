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

    set status "on"
    set status-justify "left"
    set status-left-length "100"
    set status-right-length "100"
    set status-style "fg=${thm_blue},bg=${thm_bgdark}"
    set status-left-style NONE
    set status-right-style NONE

    # Mode
    set mode-style "fg=${thm_blue},bg=${thm_bgdark}"

    # Messages
    set message-style "fg=${thm_blue},bg=${thm_bgdark}"
    set message-command-style "fg=${thm_blue},bg=${thm_bgdark}"

    # Panes
    set pane-border-style "fg=${thm_fg}"
    set pane-active-border-style "fg=${thm_blue}"

    # Windows
    setw window-status-activity-style "underscore,fg=${thm_fgdark},bg=${thm_bg}"
    setw window-status-separator ""
    setw window-status-style "NONE,fg=${thm_fgdark},bg=${thm_bg}"
    setw window-status-format "#[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]"
    setw window-status-current-format "#[fg=${thm_bg},bg=${thm_fg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_bgdark},bold] #I  #W #F #[fg=${thm_bgdark},bg=${thm_bg},nobold,nounderscore,noitalics]"

    set status-left "#[fg=${thm_bgdark},bg=${thm_blue},bold] #S #[fg=${thm_blue},bg=${thm_bg},nobold,nounderscore,noitalics]"

    set status-right "#[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_bg}] #{prefix_highlight} #[fg=${thm_bgdark},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_bgdark}] %Y-%m-%d  %I:%M %p #[fg=${thm_blue},bg=${thm_bgdark},nobold,nounderscore,noitalics]#[fg=${thm_bgdark},bg=${thm_blue},bold]  #{b:pane_current_path} "

    set @prefix_highlight_output_prefix "#[fg=${thm_yellow}]#[bg=${thm_bg}]#[fg=${thm_bg}]#[bg=${thm_yellow}]"
    set @prefix_highlight_output_suffix ""

    tmux "${tmux_commands[@]}"
}

main "$@"
