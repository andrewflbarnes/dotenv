# Personal Theme
#
####################################################################################################
# Colors from bubble theme created by @embe221ed (https://github.com/embe221ed)
# colors are inspired by catppuccin palettes (https://github.com/catppuccin/catppuccin)
####################################################################################################

# COLORS

# background for frappe catppuccin terminal theme
# thm_bg="#303446"

# background for macchiato catppuccin terminal theme
thm_bg="#24273A"

thm_fg="#c6d0f5"
thm_cyan="#99d1db"
thm_black="#292c3c"
thm_gray="#414559"
thm_magenta="#ca9ee6"
thm_pink="#f4b8e4"
thm_blue="#8caaee"
thm_black4="#626880"
rosewater="#f2d5cf"
flamingo="#eebebe"
pink="#f4b8e4"
mauve="#ca9ee6"
red="#e78284"
maroon="#ea999c"
peach="#ef9f76"
yellow="#e5c890"
green="#a6d189"
teal="#81c8be"
sky="#99d1db"
sapphire="#85c1dc"
blue="#8caaee"
lavender="#babbf1"
text="#c6d0f5"
subtext1="#b5bfe2"
subtext0="#a5adce"
overlay2="#949cbb"
overlay1="#838ba7"
overlay0="#737994"
surface2="#626880"
surface1="#51576d"
surface0="#414559"
base="#303446"
mantle="#292c3c"
crust="#232634"
eggplant="#e889d2"
sky_blue="#a7c7e7"
spotify_green="#1db954"
spotify_black="#191414"

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

# See Color formatting section below for details on what colors can be used here.
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$thm_bg}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$thm_fg}
TMUX_POWERLINE_SEG_AIR_COLOR=$("${TMUX_POWERLINE_DIR_HOME}/segments/air.sh")

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# See `man tmux` for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveniences

# Additionally set the background to red when pane_synchronized
if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(format inverse)]" \
        "#{?pane_synchronized,#[bg=red],}" \
		#"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		" #I#F " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W " \
		"#[$(format regular)]" \
        "#{?pane_synchronized,#[fg=red],}" \
		#"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[$(format regular)]" \
		"  #I#{?window_flags,#F, } " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W "
	)
fi

# Format: segment_name background_color foreground_color [non_default_separator] [separator_background_color] [separator_foreground_color] [spacing_disable] [separator_disable]
#
# * background_color and foreground_color. Color formatting (see `man tmux` for complete list):
#   * Named colors, e.g. black, red, green, yellow, blue, magenta, cyan, white
#   * Hexadecimal RGB string e.g. #ffffff
#   * 'default' for the default tmux color.
#   * 'terminal' for the terminal's default background/foreground color
#   * The numbers 0-255 for the 256-color palette. Run `tmux-powerline/color-palette.sh` to see the colors.
# * non_default_separator - specify an alternative character for this segment's separator
# * separator_background_color - specify a unique background color for the separator
# * separator_foreground_color - specify a unique foreground color for the separator
# * spacing_disable - remove space on left, right or both sides of the segment:
#   * "left_disable" - disable space on the left
#   * "right_disable" - disable space on the right
#   * "both_disable" - disable spaces on both sides
#   * - any other character/string produces no change to default behavior (eg "none", "X", etc.)
#
# * separator_disable - disables drawing a separator on this segment, very useful for segments
#   with dynamic background colours (eg tmux_mem_cpu_load):
#   * "separator_disable" - disables the separator
#   * - any other character/string produces no change to default behavior
#
# Example segment with separator disabled and right space character disabled:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 33 0 right_disable separator_disable"
#
# Note that although redundant the non_default_separator, separator_background_color and
# separator_foreground_color options must still be specified so that appropriate index
# of options to support the spacing_disable and separator_disable features can be used

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info $blue $thm_bg" \
		#"date_day 235 136 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#"date 235 136 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#"time 235 136" \
		"hostname $thm_bg $eggplant ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#"mode_indicator 165 0" \
		#"ifstat 30 255" \
		#"ifstat_sys 30 255" \
		"lan_ip $thm_bg $sky_blue ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
        "#[$(format regular)]" \
		"wan_ip $thm_bg $sky_blue" \
		#"vcs_branch 29 88" \
		#"vcs_compare 60 255" \
		#"vcs_staged 64 255" \
		#"vcs_modified 9 255" \
		#"vcs_others 245 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		#"earthquake 3 0" \
		#"vcs_branch 29 88" \
		#"pwd 89 211" \
		#"macos_notification_count 29 255" \
		#"mailcount 9 255" \
		#"now_playing 234 37" \
		#"cpu 240 136" \
		#"load 237 167" \
		#"tmux_mem_cpu_load 234 136" \
		#"battery 137 127" \
		#"air ${TMUX_POWERLINE_SEG_AIR_COLOR} 255" \
		#"weather 37 255" \
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
		#"xkb_layout 125 117" \
		"date_day $thm_bg $teal" \
		"date $thm_bg $teal ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		"time $thm_bg $teal ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
fi
