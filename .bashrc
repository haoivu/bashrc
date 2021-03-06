export EC_STORAGE=/home/haon/dev/tmp-storage
export EC_DATA=/home/haon/dev/glados-data
export EC_JOBS=/home/haon/dev/tmp-jobs
export EC_LOGS=/home/haon/dev/tmp-logs
export EC_CONFIGS=/home/haon/dev/tmp-configs

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;93m\]\u@\h\[\033[00m\]:\[\033[00;96m\]\w \[\033[95m\][\t]\[$(tput sgr0)\]\[\033[31m\]\$(parse_git_branch)\[\033[37m\] λ "




#	--------------------------------
#	1. MAKE TERMINAL BETTER
#	--------------------------------

alias cp='cp -iv'				# Preferred 'cp' implementation
alias mv='mv -iv'				# Preferred 'mv' implementation
alias l='ls -FGlAhp --group-directories-first'	# Preferred 'l' implementation
cd() { builtin cd "$@"; l; }			# Always list directory contents upon 'cd'
alias cd..='cd ../'				# Go back 1 directory level (for fast typers)
alias ..='cd ../'				# Go back 1 directory level
alias .2='cd ../../'				# Go back 2 directory level
alias ...='cd ../../'				# Go back 2 directory level
alias .3='cd ../../../'				# Go back 3 directory level
alias .4='cd ../../../../'			# Go back 4 directory level
alias .5='cd ../../../../../'			# Go back 5 directory level
alias .6='cd ../../../../../../'		# Go back 6 directory level
alias please='sudo $(history -p !-1)'		# Returns last command under sudo
alias reload='source ~/.bashrc'			# Reloads bashrc
alias ip='curl icanhazip.com'			# Your public IP addresswww
alias edit='atom'				# edit:		Opens any file in atom
alias f='xdg-open .'				# f:		Opens current directory in Files
alias ~='cd ~'					# ~:		Go Home
alias c='clear'					# c:		Clear terminal display
alias ip='curl icanhazip.com'			# Your public IP address
alias clear='printf "\033c"'			# clear:	Clear terminal scrollback history
alias s='sudo'					# s:		Sudo
alias which='type -all'				# which:	Find executables


#	--------------------------------
#	2. ENVIRONMENT CONFIGURATION
#	--------------------------------

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv

#source ~/.local/bin/virtualenvwrapper.sh

#	Change Promt
#	-------------------------------------------------------------------------
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#export PS1="\e[01;38;5;221m__________________________________________________________________________\n|\e[0m \e[38;5;201m\u\e[0m \e[38;5;219m\w\e[0m \e[38;5;225m[\t]\e[0m \e[38;5;214m\$(parse_git_branch)\e[0m \n\e[01;38;5;221m|\e[0m \e[01;38;5;005mλ\e[0m ${PYTHON_VIRTUALENV}"

export PS1="\[\e[0m\e[38;5;220m \u\e[0m\] \[\e[38;5;214m\w\e[0m\] \[\e[38;5;208m[\t]\e[0m\] \[\e[38;5;048m\$(parse_git_branch)\e[0m\] \n \[\e[01;38;5;087m\]λ \[\e[0m\]"
export SVGA_VGPU10=0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/haon/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/haon/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/haon/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/haon/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

