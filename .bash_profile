# enable terminal colors
export CLICOLOR=1
export TERM=xterm-256color

# make sure we use homebrew packackes first
export PATH=/usr/local/bin:$PATH

# show git branch in prompt
source ~/.git-prompt.sh
PS1="\[\033[0;32m\]\t\[\033[0;31m\]-\[\033[0;33m\]\w\[\033[m\]\[\033[0;31m\]\$(__git_ps1)\[\033[0;37m\]\$ "

alias vim='nvim'
alias gst='git status'
alias gap='git add -p'
alias gc='git branch | cut -c 3- | fzf | xargs git checkout'
alias gl='git lg'
alias c=clear
alias git-remove-merged-branches='git branch --merged | tail -r | tail -n +2 | xargs git branch -d'
alias ls='ls -ll'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

stty -ixon

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export ANDROID_HOME=~/Library/Android/sdk
