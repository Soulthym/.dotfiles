set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let &packpath = &runtimepath
let g:python3_host_prog = '/usr/bin/python3'  " Python 3
let g:python_host_prog = '/usr/bin/python2'  " Python 2

set shell=/bin/bash           " required for use in non-POSIX compliant shells
set nocompatible              " be iMproved, required
filetype off                  " required
call plug#begin('~/.config/vim/autorun/plugged')
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()
"source ~/.config/vim.bk/vimrc
