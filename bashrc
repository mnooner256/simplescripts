# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [[ $TERM == 'xterm' ]]; then
    export TERM=xterm-color
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

function ps? {
    ps auxwww | egrep "$1|PID" | grep -v grep
    return $?
}

export PATH=$HOME/.bin:$PATH
export PYTHONSTARTUP=$HOME/.python-startup.py
alias ll='ls -lh'

#Python virtualenv's prefix the prompt with (envname)
#This function detects this situation and puts the
#rest of the prompt on a new line
__prefix_on_own_line() {
    if [ "${PS1:0:1}" == '(' ] ; then
        #Move the cursor down one line
        tput cud1

        #Echo the reset character, this is
        #needed to actually start printing
        #on the next line
        echo -e '\e[0m'
    fi
}

#This function creates the PS1 prompt
#It is mostly used so the prompt has a readable format
make_prompt() {
    local TEAL='\[\e[1;36m\]'
    local PURPLE='\[\e[1;35m\]'
    local YELLOW='\[\e[1;33m\]'
    local RESET='\[\e[0m\]'

    export PS1="\$(__prefix_on_own_line)┌─[$TEAL\u@\h$RESET] [$PURPLE\w$RESET]\n│ [$YELLOW\t   \d$RESET]\n└─$ "
}
make_prompt
export PS2="└─> "

alias aptsearch='apt-cache search '
alias aptinstall='sudo apt-get -y install '
