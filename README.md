# .dotfiles
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'  
git init --bare $HOME/.dotfiles  
dotf config --local status.showUntrackedFiles no  
dotf remote add origin https://github.com/Soulthym/.dotfiles.git
dotf pull origin master  
dotf branch --set-upstream-to=origin/master master  
