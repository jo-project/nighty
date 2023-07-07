#!/usr/bin/env bash

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_STATUS_LINE_FILE=src/default.conf

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

    source /dev/stdin <<<"$(sed -e "/^[^#].*=/s/^/local /" "${PLUGIN_DIR}/nighty-${theme}.tmuxtheme")"

    source "$PLUGIN_DIR/$DEFAULT_STATUS_LINE_FILE"

    set status "on"
    set status-justify "left"
    set status-left-length "100"
    set status-right-length "100"
    set status-style "fg=${thm_blue},bg=${thm_bg}"
    set status-left-style NONE
    set status-right-style NONE

    # Mode
    set mode-style "fg=${thm_blue},bg=${thm_fg}"

    # Messages
    set message-style "fg=${thm_blue},bg=${thm_fg}"
    set message-command-style "fg=${thm_blue},bg=${thm_fg}"

    # Panes
    set pane-border-style "fg=${thm_fg}"
    set pane-active-border-style "fg=${thm_blue}"

    # Windows
    setw window-status-activity-style "underscore,fg=${thm_fgdark},bg=${thm_bg}"
    setw window-status-separator ""
    setw window-status-style "NONE,fg=${thm_fgdark},bg=${thm_bg}"

    local window_status_format=$show_window_in_window_status
    local window_status_current_format=$show_window_in_window_status_current

    setw window-status-format "${window_status_format}"
    setw window-status-current-format "${window_status_current_format}"

    local status_left=$show_session
    local status_right=$show_directory

    set status-left "${status_left}"
    set status-right "#[fg=${thm_bg},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_bg}] #{prefix_highlight} #[fg=${thm_fg},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_blue},bg=${thm_fg}] %Y-%m-%d  %I:%M %p #[fg=${thm_blue},bg=${thm_fg},nobold,nounderscore,noitalics]${status_right}"

    local highlight_suf=$show_highlight_suffix
    local highlight_pref=$show_highlight_prefix

    set @prefix_highlight_output_prefix "${highlight_pref}"
    set @prefix_highlight_output_suffix "${highlight_suf}"

    tmux "${tmux_commands[@]}"
}

main "$@"
