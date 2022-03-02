export EDITOR=vim
export DISPLAY=localhost:0
alias xps="ssh -p1122 soulthym@192.168.0.116"
alias pa='ssh pandastrobot@35.198.64.128'
alias venv='virtualenv -p=python3 .$(basename "$PWD")'
alias so='source .$(basename "$PWD")/bin/activate'
alias ll='ls -l'
alias la='ls -la'
alias brc='vim $HOME/.bashrc'
alias bso='source $HOME/.bashrc'
alias vrc='vim $HOME/.vim/vimrc'
alias trc='vim $HOME/.tmux.conf'
alias y='termux-clipboard-set'
alias yy='history|tail -n2|head -n1|sed "s/^ *[0-9]* *//"|tr -d "\n"|y'
alias p='termux-clipboard-get'

alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH]
# Only run tmux if it isn't already running,
# avoids recursive tmux sessions which can be tricky to manage
[ -v TMUX ] || tmux 
