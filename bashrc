export LANG=C.UTF-8

## Fix XDG user environment variables missing on XMonad desktop
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

## -M or --LONG-PROMPT:
##      Most verbose prompt
## -i or --ignore-case:
##      Mase insensitive search, unless pattern contains uppercase
## -R or --RAW-CONTROL-CHARS:
##      For handling ANSI "color" escape sequences
## -S or --chop-long-lines
##      Disable long line text wrap
## -F or --quit-if-one-screen
##
## NOTE: Option ``-S, chop-long-lines`` may conflict with option
## ``-F, --quit-if-one-screen``. Truncating long text lines requires a
## pager. If both options are enabled, outputting long text lines will
## disable option ``-F`` to force outputting text thru pager.
##
## DO NOT ENABLE both ``-S`` and ``-F``. Choose only one or none.
export LESS='-MiRF'

## Disable useless ``~/.lesshst``
export LESSHISTFILE="/dev/null"

GIT_PROMPT='/etc/bash_completion.d/git-prompt.sh'
if [ -r ${GIT_PROMPT} ]; then
    source ${GIT_PROMPT}
    export PS1='\u@\h:\w$(__git_ps1 " (%s)")\n[\A] '
else
    export PS1='\u@\h:\w\n[\A] '
fi

## XXX: Disable screensaver, does not work for LXQT
xset -dpms s off

## Disable Xorg PC Speaker
xset -b

## Disable Software Pause Transmission
stty -ixon

## Undefine Stop/Start character
stty stop undef start undef

[ -r ${HOME}/.Xresources ] && xrdb -load ${HOME}/.Xresources
[ -r ${HOME}/.alias ] && source ${HOME}/.alias
