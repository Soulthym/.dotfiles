parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
shopt -s autocd

export PS1="\[$(tput setaf 70)\][\[$(tput setaf 45)\]\u\[$(tput setaf 33)\]@\[$(tput setaf 63)\]\h\[$(tput setaf 166)\] \W\[$(tput setaf 70)\]]\[$(tput setaf 166)\]\$(parse_git_branch)\[$(tput setaf 15)\]\$\[$(tput sgr0)\] "
export VISUAL="nvim"
export EDITOR="nvim"
export HISTSIZE=-1
export HISTFILESIZE=-1
# eval `dircolors ~/.dircolors`
alias ls="ls --color=auto"
alias la="ls -la"
alias l="ls -l"
alias tf="cd ~/code/python/3/tensorflow-tests/"
alias p4="cd ~/code/PST/4/"
alias ee="cd ~/code/PST/4/eureka-effect"
alias ic="vim ~/.config/i3/config"

alias inw="cd ~/inwibe"
alias ci="~/inwibe/connect-prod.sh"

alias com="git commit -m"
alias push="git push"
alias status="git status"
alias add="git add .;git add -u"
alias pull="git pull"

alias opy="optirun python"
alias py="python"
alias log1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias log2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias log="git log --all --decorate --oneline --graph"
### DOTFILES ###
# init your repo with:
#       git init --bare $HOME/.dotfiles
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#       source .bashrc
#       dotf config --local status.showUntrackedFiles no
# usage:
#       dotf add <whatever file name>
#       dotf commit -m <whatever message commit>
#       dotf push
#neofetch

#vim
alias vim=nvim
alias v=nvim

export QSYS_ROOTDIR="/home/soulthym/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/18.1/quartus/sopc_builder/bin"
