# set locale
# export LANG=ja_JP.utf8

# http://journal.mycom.co.jp/column/zsh/001/index.html
autoload -U compinit
compinit

# http://0xcc.net/unimag/3/
# keybind like Emacs
bindkey -e

# http://0xcc.net/unimag/3/
zstyle ':completion:*:default' menu select=1

# customize history
# http://journal.mycom.co.jp/column/zsh/003/index.html

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
#setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# http://0xcc.net/unimag/3/#foottext-6
setopt extended_history
function history-all { history -E 1 }
function historyall  { history -E 1 }

# http://d.hatena.ne.jp/hayori/20071019/1192785576
# zshのデフォルトでは改行のない文字列を表示しない。
# 混乱のもとになるので無効にする。
unsetopt promptcr

# ディレクトリ名をうつだけでcdできる。
# ..で上へあがれて便利。
setopt auto_cd

# 右側プロンプトはコピペするときに邪魔なのでやめる。
#RPROMPT="[%~]"

# Path
PATH=$PATH:/home/smd/bin:$HOME/bin:/usr/local/bin:$HOME/local/bin:/usr/local/heroku/bin:

[ -f ~/.awsrc ] && . ~/.awsrc
## alias

# ls
alias ls='ls -F -G'
alias ll='ls -laF --show-control-char --color=always'

# pager
alias -g M='| more'

# セッション保存先の設定
export SCREENDIR=~/.screens

# aliases for Git
# http://qiita.com/items/1f01aa09ccf148542f21
# http://qiita.com/items/6ebcce530d9530293fec
alias  st='git status --short --branch'
alias g='git'
alias gst='git status --short --branch'
alias ga='git add'
alias gb='git branch'
alias gci='git commit'
alias gcim='git commit -m'
alias gdi='git diff | colordiff'
alias gd='git diff | colordiff'
alias gdc="git diff --cached | colordiff"
alias gdw='git diff --word-diff'
alias gdw-regex="git diff --color-words --word-diff-regex='\\w+|[^[:space:]]'"
alias gbr='git branch'
alias gl='git log'
alias gl1='git log -1'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gf='git fetch'
alias gr='git rebase'
alias gp='pr && git push'
alias gpl='git pull --ff-only'
alias gpul='git pull --ff-only'
alias amend='git commit --amend'
alias amendc='git commit --amend --reuse-message=HEAD'
alias prune='git remote prune origin'
alias gs='git stash'
alias gsl='git stash list'
# alias的に使う関数群
gcm () { git commit -m "$*" }
gsp () { git stash pop stash@{"$*"} }
# review () { git diffw origin/trunk..."$1" }
pr () {
    # "組織名/プロジェクト名"を取得。e.g. sen-corporation/8122
    org_repo_name=$( git config --get remote.origin.url  | sed -e s#git@github.com:## | sed -e s#.git## )

    # カレントブランチ名を取得
    current_branch=$( git branch | grep '^*' | awk '{print $2}' )

    # プルリク用URLを生成
    echo https://github.com/$org_repo_name/pull/new/$current_branch
}

# colordiff
alias cdi='colordiff'
alias cdf='colordiff'
alias -g C='| colordiff'

# nkf
alias -g E='| nkf -Ew'
alias -g W='| nkf -w'
alias -g ECM='E C M'
alias -g WCM='W C M'
alias -g L='| less -R'
alias -g WCL='W C L'

# alias -s 拡張子から実行するコマンドを判断する
# 解凍
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract


# for Git
# http://d.hatena.ne.jp/mollifier/20100906/p1
# http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz is-at-least

autoload -Uz vcs_info
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}

# for screen
alias sc='screen'

#PROMPT="%n:%/%1(v|%F{green}%1v%f|)%% "


# プロンプトの色付けは下記記事がわかりやすい
# http://www.sakito.com/2011/11/zsh.html
PROMPT="%n%F{yellow}@%m%f:%/%1(v|%F{green}%1v%f|)%% "

# load nvm
[[ -s /home/prj01hon/.nvm/nvm.sh ]] && . /home/prj01hon/.nvm/nvm.sh

# rbenv用の設定を読み込む
[ -f ~/.zshrc_rbenv ] && . ~/.zshrc_rbenv

# XOFF を無効化
stty stop undef

cd $BASE

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
