# enable terminal colors
export CLICOLOR=1
export TERM=xterm-256color
alias vim=nvim

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{green}${PWD/#$HOME/~}%f %F{yellow}(${vcs_info_msg_0_})%f %'

alias gst='git status'
alias gap='git add -p'
alias gc='git branch | cut -c 3- | fzf | xargs git checkout'
alias gl='git lg'
alias c=clear
alias git-remove-merged-branches='git branch --merged | tail -r | tail -n +2 | xargs git branch -d'
alias ls='ls -ll'

function tvim() {
    tmux new-session -A -s ${PWD##*/} "nvim $@"
}

stty -ixon

export ANDROID_HOME=~/Library/Android/sdk
