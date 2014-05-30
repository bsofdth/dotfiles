# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt incappendhistory nomatch correct_all
unsetopt beep
bindkey -v

zstyle :compinstall filename '/Users/drew/.zshrc'
autoload -Uz compinit
compinit

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

autoload -U colors && colors
# Have to reset color to cyan after the bold tags for some reason.
PROMPT="%{$fg[cyan]%}[%n@%M %B%1~%b%{$fg[cyan]%}]%# %{$reset_color%}"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

export EDITOR="mvim"
alias vim="mvim"
alias vimdiff="mvimdiff"

# OS X completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Set Home, End, Del, PgUp, PgDown keys to actually do something.
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
