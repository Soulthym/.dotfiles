.dotfiles
=========
*This was tested on bash*  
how to use
----------
To initialise you local copy of the repo, use:
```bash
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'  
git init --bare $HOME/.dotfiles  
dotf config --local status.showUntrackedFiles no  
dotf remote add origin https://github.com/Soulthym/.dotfiles.git  
dotf pull origin x200t  
dotf branch x200t  
dotf branch --set-upstream-to=origin/x200t x200t  
```
Put this in your shell's rc, for example in ~/.bashrc I have:  
```bash
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'  
alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'  
```
Now you can use `d` or `dotf` as your dotfile manager and it works exactly like a git repo!
(without untracked files for clarity)

making your own
---------------
Init your repo with:  
```
git init --bare $HOME/.dotfiles
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotf config --local status.showUntrackedFiles no
```
To make the alias permanent, add the `alias` line 
to your shell's rc.

### usage:
```
    $YOURALIAS add <whatever file name>
    $YOURALIAS commit -m <whatever message commit>
    $YOURALIAS push
```
For example in my case, to `git add ~/.config/vim/vimrc`, I do:  
`d add ~/.config/vim/vimrc`
