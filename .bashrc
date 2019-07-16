#shopt -s promptvars dotglob histappend no_empty_cmd_completion cdspell xpg_echo
 
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
		PS1+=" $_green("
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
			[[ -n $_git_remote ]] && PS1+="$_light_green$_git_remote"
		fi
		PS1+="$_green)"
	fi
	PS1+="$_white\$"
	PS1+="$_reset "
}
PROMPT_COMMAND='custom_prompt'
shopt -s autocd

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
PATH="$(du $HOME/.local/bin/ | cut -f2 | tr '\n' ':')$PATH"
export PATH=$PATH:$HOME/.scripts/
