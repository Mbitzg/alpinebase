####################################### SHELL PROFILE #########################################
#### Fall back profile for login shells [docker login, su - or *sh --login/-l and ssh login]. 
#### In bash or most desktop linux, this file will NOT be sourced during user login session
#### unless .bash_profile or .bash_login sources this file EXPLICITLY. We do it in .bash_profile.
#### This is a single user profile, global common profiles are stored in /etc/profile.d/

## Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return 

export PS1="\[\033[33m\][\u@\H:\[\033[32m\]\w\[\033[33m\]]\n$\[\033[0m\]"

# Don't check mail when opening terminal.
unset MAILCHECK
# Define some basic aliases and functions
unalias -a
# Enable aliases to be sudo’ed
alias sudo='sudo '
alias sux='su-exec '
alias su='su - '
alias mkdir='mkdir -p'
# Mv all current files and folders one dir up and omit the parent dir
alias what='type -a'
alias unsetall='unset all;set +o nounset'
alias cls='clear;set +o nounset'
alias clr='reset;clear;set +o nounset'
# List all files colorized in long format
alias ll="ls -lph --color"
alias lt='ll -t'
alias ls="command ls --color"
alias lu='du -ach -d 1'
alias memclr='free -mh;sync;echo 3 > /proc/sys/vm/drop_caches;free -mh'
alias path='echo -e ${PATH//:/\\n}'
###############################################################################################

