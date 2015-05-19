# enable terminal colors
export CLICOLOR=1
export TERM=xterm-256color

# make sure we use homebrew packackes first
export PATH=/usr/local/bin:$PATH

# show git branch in prompt
source ~/.git-prompt.sh
PS1="\[\033[0;32m\]\t\[\033[0;31m\]-\[\033[0;33m\]\w\[\033[m\]\[\033[0;31m\]\$(__git_ps1)\[\033[0;37m\]\$ "

alias gst='git status'
alias gap='git add -p'
alias gc='git branch | cut -c 3- | selecta | xargs git checkout'
alias c=clear
alias git-remove-merged-branches='git branch --merged | tail -r | tail -n +2 | xargs git branch -d'
stty -ixon
