eval "$(direnv hook bash)"
export EDITOR=vim

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

export PS1='\[\e[36m\]\W\[\e[36m\]$(__git_ps1)\[\e[0m\]'

# alias
alias gg='git grep'
alias gc='git checkout'
alias re='git checkout release'
alias be='bundle exec'
alias rs='bundle exec rspec'
alias go='git push origin head'
alias fullreset=fullreset
alias quickrebase=quickrebase
alias switchbranch=switchbranch


function fullreset() {
  git add .
  git commit -m "a"
  git reset --hard head^
}

function quickrebase() {
  git add .
  git commit -m "a"
  git rebase -i head~2
}

function switchbranch() {
  current_branch=`git rev-parse --abbrev-ref HEAD`
  parent_branch=`git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'`
  echo $current_branch
  echo $parent_branch
  git diff --name-only $current_branch..$parent_branch
}
