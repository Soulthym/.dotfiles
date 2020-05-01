#shopt -s promptvars dotglob histappend no_empty_cmd_completion cdspell xpg_echo
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
function parse_git_dirty {
  echo -n $(git status 2>/dev/null | awk  '
BEGIN {
	state=""
	untracked=""
	changes=""
}
{ 
	if ($0 == "Changes to be committed:") {
  		state = "uncommitted"
	} else if ($0 == "Untracked files:") {
  		untracked = "new"
	} else if ($0 == "Changes not staged for commit:") {
		changes = "modified"
	}
}
END {
	printf "%s", state
	printf " %s", changes
	printf " %s", untracked
}
')
}
function parse_git_remote {
  echo -n $(git status 2>/dev/null | awk '/Your branch is (ahead|behind)/ { print $4 }')
}
function custom_prompt {
	local _green="\[$(tput setaf 70)\]"
	local _light_green="\[$(tput setaf 64)\]"
	local _light_blue="\[$(tput setaf 45)\]"
	local _electric_blue="\[$(tput setaf 33)\]"
	local _dark_blue="\[$(tput setaf 63)\]"
	local _orange="\[$(tput setaf 166)\]"
	local _white="\[$(tput setaf 15)\]"
	local _red="\[$(tput setaf 161)\]"
	local _reset="\[$(tput sgr0)\]"

	local _git_branch=$(git branch --no-color 2> /dev/null | awk '/\*/ {print $2}' | tr -d " ")
	local _git_dirty=$(parse_git_dirty)
	local _git_remote=$(parse_git_remote)

	PS1="$_green["
	PS1+="$_light_blue\u"
	PS1+="$_electric_blue@"
	PS1+="$_dark_blue\h "
	PS1+="$_orange\W"
	PS1+="$_green]"
	if [[ -n $_git_branch ]]; then
		PS1+="$_green("
		PS1+="$_light_blue$_git_branch"
		if [[ -n $_git_dirty$_git_remote ]]; then
			PS1+=$_electric_blue"=>"
			_sep=""
			if [[ $_git_dirty == *"uncommitted"* ]]; then
				PS1+=$_electric_blue"/"$_green"commit"
				_sep=$_electric_blue"-"
			fi
			if [[ $_git_dirty == *"modified"* ]]; then
				PS1+=$_sep$_red"mod"
				_sep=$_electric_blue"-"
			fi
			[[ $_git_dirty == *"new"* ]] && PS1+=$_sep$_dark_blue"new"
			[[ -n $_git_remote ]] && PS1+="$_light_green<$_git_remote>"
		fi
		PS1+="$_green)"
	fi
        PS1+="\n"
	PS1+="$_white>"
	PS1+="$_reset "
}
PROMPT_COMMAND='custom_prompt'
shopt -s autocd

export VISUAL="vim"
export EDITOR="vim"
export HISTCONTROL=ignoreboth
export HISTSIZE=-1
export HISTFILESIZE=-1
# eval `dircolors ~/.dircolors`
alias brc="vim ~/.bahsrc"
alias ls="ls --color=auto"
alias la="ls -lah"
alias ll="ls -l"
alias tf="cd ~/code/python/3/tensorflow-tests/"
alias p4="cd ~/code/PST/4/"
alias ee="cd ~/code/PST/4/eureka-effect"
alias 5a="cd ~/Documents/ESIEA/5A && ls"
alias pf="cd ~/code/PFE/ && ls"
alias p3="cd ~/code/python/3/ && ls"
alias pc="cd ~/code/python/3/discord-bot-principal-PC/ && ls"
alias ic="vim ~/.config/i3/config"
alias vc="cd ~/.config/vim/ && vim ."
alias inw="cd ~/inwibe"
alias ci="~/inwibe/connect-prod.sh"
alias "ys=xclip -selection clipboard"
alias "vs=xclip -o -selection clipboard"
alias "yc=history 2| head -2|head -1|sed 's/^ *[0-9]\+ *\(.*\)/\1/g' | tr -d '\n'|xclip -sel clip"

alias com="git commit -m"
alias push="git push"
alias status="git status"
#alias add="git add .;git add -u"
alias add="git add"
alias pull="git pull"

alias opy="optirun python"
alias py="python"
alias log1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias log2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias log="git log --all --decorate --oneline --graph"

alias momdoc="w3m https://schaffter.ca/mom/momdoc/toc.html"
alias co="cd ~/code/"

### DOTFILES ###
# init your repo with:
#       git init --bare $HOME/.dotfiles
alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#       source .bashrc
#       dotf config --local status.showUntrackedFiles no
# usage:
#       dotf add <whatever file name>
#       dotf commit -m <whatever message commit>
#       dotf push

#vim
alias evim='vim -u "$HOME"/.config/vim/embedded.vim --not-a-term'
alias nv=nvim

PATH="$(du $HOME/.local/bin/ | cut -f2 | tr '\n' ':')$PATH"
export PATH="${PATH}:${HOME}/.scripts/"
export PATH="${PATH}:${HOME}/.local/bin/"
shopt -s globstar

export QSYS_ROOTDIR="/home/soulthym/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/19.1/quartus/sopc_builder/bin"

# https://gitea.tfnux.org/adraenwan/keychain-wrapper
# persistent ssh-agent wrapper
eval $(keychain --eval --quiet)
ssh-add $(for f in ~/.ssh/*.pub; do echo ${f%\.pub}; done) > /dev/null 2>&1
alias ssh-login='ssh-add $(for f in ~/.ssh/*.pub; do echo ${f%\.pub}; done) > /dev/null 2>&1'
alias sl='ssh-add $(for f in ~/.ssh/*.pub; do echo ${f%\.pub}; done) > /dev/null 2>&1'
# Add these lines to your ssh_config (for example, ~/.ssh/config):
#
# "# when key is not loaded in ssh-agent"
# "# ask for passphrase and forward it to ssh-agent"
# "AddKeysToAgent yes"
