eval "$(direnv hook zsh)"
export EDITOR=vim

# たとえば oh-my-zsh テーマカラーを robbyrussell から変更する場合
ZSH_THEME="candy"

##### zsh の設定 #####

# すっきりしたプロンプト表示 (不要ならコメントアウト)
PROMPT=%{$bg[blue]%}%C:%{$reset_color%} 

# zsh-completions の設定。コマンド補完機能
autoload -U compinit && compinit -u

# git のカラー表示
git config --global color.ui auto


# 色を使用出来るようにする
autoload -Uz colors
colors

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# cd なしでもディレクトリ移動
setopt auto_cd

# ビープ音の停止
setopt no_beep

# ビープ音の停止(補完時)
setopt nolistbeep

# cd [TAB] で以前移動したディレクトリを表示
setopt auto_pushd

# ヒストリ (履歴) を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 同時に起動した zsh の間でヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# キーバインディングを emacs 風にする
bindkey -d
bindkey -e

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# [TAB] でパス名の補完候補を表示したあと、
# 続けて [TAB] を押すと候補からパス名を選択できるようになる
# 候補を選ぶには [TAB] か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# コマンドのスペルを訂正する
setopt correct

# cd した先のディレクトリをディレクトリスタックに追加する
# cd [TAB] でディレクトリのヒストリが表示されるので、選択して移動できる
# ※ ディレクトリスタック: 今までに行ったディレクトリのヒストリのこと
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 拡張 glob を有効にする
# 拡張 glob を有効にすると # ~ ^ もパターンとして扱われる
# glob: パス名にマッチするワイルドカードパターンのこと
# ※ たとえば mv hoge.* ~/dir というコマンドにおける * のこと
setopt extended_glob

# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものにしている
# ※ たとえば Ctrl-W でカーソル前の1単語を削除したとき / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# alias
alias gg='git grep'
alias ggsed=ggsed
alias gc='git checkout'
alias re='git checkout release'
alias tax='git checkout milestone-reduced-tax-rate'
alias be='bundle exec'
alias rs='bundle exec rspec'
alias ggo='git push origin head'
alias ggof='git push -f origin head'
alias bra="git for-each-ref --count=7 --format='%(refname:short) (%(authordate:relative))' --sort=-committerdate refs/heads"
alias fcon="git grep -l 'fcontext' | xargs sed -i '' -e 's/fcon/con/g'"
alias fdes="git grep -l 'fdescribe' | xargs sed -i '' -e 's/fdes/des/g'"
alias fullreset=fullreset
alias quickrebase=quickrebase
alias switchbranch=switchbranch
alias branchclean="git branch --merged|egrep -v '\*|release|master'|xargs git branch -d"
alias ridgepole='bundle exec ridgepole -c config/database.yml --apply -f db/Schemafile'

alias cas=castart
alias ivs=ivstart
alias iv='cd ~/app/rails/iv_web'
alias cof='cd ~/app/rails/coffret'
alias engine='cd /Users/kuriyama.reo/app/rails/iv_web/vendor/bundle/ruby/2.5.0/bundler/gems'
alias gc='gc'

function ggsed() {
  git grep -l "$1" | xargs sed -i '' -e "s/$1/$2/g"
}

function gc() { 
  echo $1
  branch_name=${1/ReoKuriyama:/}
  git checkout $branch_name;
}

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

function ivstart() {
  cd ~/app/rails/iv_web
  bundle exec rails s -p $IV_PORT
}

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
   if overridden; then return; fi
   cwd=${$(pwd)##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
