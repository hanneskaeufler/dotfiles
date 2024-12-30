# enable terminal colors
# export CLICOLOR=1
# export TERM=iterm2
alias vim=nvim

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{green}${PWD/#$HOME/~}%f %F{yellow}(${vcs_info_msg_0_})%f %'

alias git='LANG=en_GB git'
alias gst='git status'
alias gap='git add -p'
alias gc='git branch | cut -c 3- | fzf | xargs git checkout'
alias gco='git commit'
alias gl='git lg'
alias gp='git push'
alias gd='git diff'
alias c=clear
alias git-remove-merged-branches='git branch --merged | tail -r | tail -n +2 | xargs git branch -d'
alias ls='ls -ll'
alias ll='ls -ll'

function tvim() {
    tmux new-session -A -s ${PWD##*/} "nvim $@"
}

stty -ixon
autoload -Uz compinit && compinit
