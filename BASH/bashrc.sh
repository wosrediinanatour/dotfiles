# Merge histories when using TMUX
# https://unix.stackexchange.com/a/1292
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000 # default: 500
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
MANPAGER="sh -c 'col -bx | bat -l man -p'"

