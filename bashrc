case $- in
  *i*) ;;
*) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='[\u@\h \W]\$ '
fi
unset color_prompt force_color_prompt

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# allow ctrl+S in vim to save files, ie pass the command to vim when vim is open.
export EDITOR="vim"
vim() {
  local STTYOPTS="$(stty --save)"
  stty stop '' -ixoff
  command vim --servername vim "$@"
  stty "$STTYOPTS"
}

export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin
export PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools
export PATH="$PATH:$HOME/.rvm/bin"

if [ -x /usr/bin/ssh-agent -a -z "$SSH_AUTH_SOCK" ]; then
  eval "$(keychain --eval -Q -q --agents ssh  `find $HOME/.ssh/*  ! -name '*.pub' ! -name 'config' ! -name 'known_hosts'`)"
fi
