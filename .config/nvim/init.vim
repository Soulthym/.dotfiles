set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after
let &packpath = &runtimepath
"=== vimrc
" source ~/.config/vim/vimrc
set shell=/bin/bash           " required for use in non-POSIX compliant shells
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.config/vim/autorun/plugged')
Plug 'https://github.com/Konfekt/FastFold.git'
Plug 'https://github.com/fedorenchik/qt-support.vim.git'
Plug 'https://github.com/bfredl/nvim-ipy.git'
Plug 'https://github.com/vim-scripts/indentpython.vim.git'
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
Plug 'https://github.com/nvie/vim-flake8.git'
Plug 'https://github.com/fatih/molokai.git'
Plug 'https://github.com/maksimr/Lucius2.git'
Plug 'https://github.com/liuchengxu/space-vim-theme.git'
Plug 'https://github.com/ntk148v/vim-horizon.git'
Plug 'https://github.com/chase/focuspoint-vim.git'
Plug 'https://github.com/yous/vim-open-color.git'
Plug 'https://github.com/BarretRen/vim-colorscheme.git'
Plug 'https://github.com/jnurmine/Zenburn.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/jistr/vim-nerdtree-tabs.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/mbbill/undotree.git'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
call plug#end()
" FROM VUNDLE: set rtp+=~/.vim/bundle/Vundle.vim
" FROM VUNDLE: call vundle#begin()

" let Vundle manage Vundle, required
" Plug 'https://github.com/VundleVim/Vundle.vim.git'

" FROM VUNDLE: call vundle#end()            " required
" FROM VUNDLE: filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" === vimrc ===
set wildmenu
set mouse+=a
set splitright
set splitbelow
set number relativenumber
set nowrap
map <F10> :w! \| !./.compile.sh <c-r>%<CR>
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux or screen.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
" check and use tmux's 24-bit color support
" (http://sunaku.github.io/tmux-24bit-color.html#usage for more information.)
if empty($TMUX) && empty($STY)
  " See https://gist.github.com/XVilka/8346728.
  if $COLORTERM =~# 'truecolor' || $COLORTERM =~# '24bit'
    if has('termguicolors')
      " See :help xterm-true-color
      if $TERM =~# '^screen'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
      set termguicolors
    endif
  endif
endif

" fix xterm Ctrl+arrow keys
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Search highlight
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Folding
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let header = getline(v:foldstart)
    "let tailer = substitute(getline(v:foldend - 1),"^ *","",1)
    "let txt = header . '{ ' . tailer .' }' . ' --- ' . nl . ' lines'
    let txt = header . ' --- ' . nl . ' lines'
    return txt
endfunction
set foldtext=MyFoldText()
set foldmethod=manual
set viewoptions-=options
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"=== Qt section ==

"=== groff-ms section ==
au BufNewFile,BufRead *.ms
   \set tabstop=4       |
   \set softtabstop=4   |
   \set shiftwidth=4    |
   \set expandtab       |
   \set autoindent      |
   \set fileformat=unix
autocmd FileType ms set wrap
autocmd FileType ms nnoremap <Up> g<Up>
autocmd FileType ms nnoremap <Down> g<Down>
" autocmd FileType ms nnoremap <buffer> <F5> <Esc>:w<CR>:!clear;groff -ms % -T pdf > out.pdf<CR>
" autocmd Filetype ms noremap <F5> <Esc>:w! \| !compiler <c-r>%<CR>

"=== shell section ===
set tabstop=4
set softtabstop=0
set shiftwidth=4
set autoindent
set smarttab
set fileformat=unix
set expandtab

noremap <silent> <F9> <Esc>:!sh %<CR>

"=== vhdl section ===
" utf-8 support
au BufNewFile,BufRead *.vhd set encoding=utf-8

" format
au BufNewFile,BufRead *.vhd
   \set tabstop=4       |
   \set softtabstop=4   |
   \set shiftwidth=4    |
   \set expandtab       |
   \set autoindent      |
   \set fileformat=unix
"=== python section ===
" jupyter integration
" Plugin 'jupyter-vim/jupyter-vim'

" ipython integration
" Plugin 'ivanov/vim-ipython'
"Doc : https://github.com/bfredl/nvim-ipy
let g:nvim_ipy_perform_mappings = 0
let g:ipy_celldef = '^##'
let g:ipy_truncate_input = 2
"
autocmd Filetype python map <silent> <F3> <Esc>:IPython<CR>
autocmd Filetype python map <silent> <F4> <Plug>(IPy-Run)
autocmd Filetype python map <silent> <F5> <Plug>(IPy-RunCell)
" autocmd Filetype python map <silent> <F10> <Plug>(IPy-RunAll)
autocmd Filetype python imap <silent> <c-n> <Plug>(IPy-Complete)
autocmd Filetype python map <silent> <F2> <Plug>(IPy-WordObjInfo)
autocmd Filetype python map <silent> <F9> <Plug>(IPy-Interrupt)
autocmd Filetype python map <silent> <F12> <Plug>(IPy-Terminate)

" utf-8 support
au BufNewFile,BufRead *.py set encoding=utf-8

" PEP8
au BufNewFile,BufRead *.py
   \set tabstop=4       |
   \set softtabstop=4   |
   \set shiftwidth=4    |
   \set textwidth=79    |
   \set expandtab       |
   \set autoindent      |
   \set fileformat=unix

" Better indentation
" Plugin 'tmhedberg/SimpylFold'
" let g:SimpylFold_docstring_preview=1
" let g:SimpylFold_fold_docstring=1
" let b:SimpylFold_fold_docstring=1
" let g:SimpylFold_fold_import=1
" let b:SimpylFold_fold_import=1
" autocmd FileType python set foldmethod=indent
" autocmd FileType python set foldnestmax=1
autocmd FileType python set foldcolumn=1

" Should flag trailing whitespaces
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Auto-complete
" Plugin 'Valloric/YouCompleteMe'
" Need to compile upon updates to their API:
" cd ~/.vim/bundle/YouCompleteMe/
" python3 install.py [--clang-completer]
" # See README.md for more informations on the supported languages
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"" Syntax Checking
"Plugin 'vim-syntastic/syntastic'

" PEP8 Checking

" Color-Scheme
if has('gui_running')
  colorscheme open-color
else
  "colorscheme molokai
  "colorscheme PaperColor
  "colorscheme lucius
  "colorscheme space_vim_theme
  "colorscheme horizon
  colorscheme open-color
  "colorscheme focuspoint
  "colorscheme monokai
  "colorscheme zenburn
endif

" python pretty
let python_highlight_all=1
syntax on

" File browsing
nnoremap <C-n> :NERDTreeToggle<CR>
" same for tabs
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Super Searching

" Git integration

" Powerline
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Undo-tree
nnoremap <S-U> :UndotreeToggle<cr>
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.config/vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/.undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Async run
let g:asyncrun_status = "stopped"
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
" Plugin 'hauleth/asyncdo.vim'
let $PYTHONUNBUFFERED=1

" shared clipboard
set clipboard=unnamedplus

" Personal shortcuts
autocmd FileType python inoremap <c-Space> <Esc>/#++#<Enter>"_c4l
" autocmd FileType python nnoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
autocmd FileType python noremap <c-c> I#<Esc>
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" ipython-like
" autocmd FileType python noremap <F8> <Esc>o#BLOCK#<Esc>
" autocmd FileType python noremap <F20> <Esc>O#BLOCK#<Esc>
" autocmd FileType python noremap <F9> <Esc>?#BLOCK#<CR>V/#BLOCK#<CR>"py<ESC>:python3 << EOF<CR><C-r>p<CR>EOF<CR>

autocmd FileType tex set wrap
autocmd FileType tex nnoremap <Up> g<Up>
autocmd FileType tex nnoremap <Down> g<Down>
inoremap <S-Tab> <C-V><Tab>
autocmd FileType sh noremap <c-c> I#<Esc>

" filetype plugin indent on

" Bind F5 to save file if modified and execute python script in a buffer.
"autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:vert ter python3 "%"<CR>
"autocmd Filetype python vnoremap <buffer> <F5> :w<CR>:'<'>vert ter python3<CR>

function! Append(l1, l2, buffer)
  let currentBuffer = @%
  let currentRegister = @z
  execute a:l1 . "," . a:l2 . 'y z'
  execute "buffer " . a:buffer
  normal G"zp<C-O>
  let @z = currentRegister
  execute "buffer " . currentBuffer
endfunction

command! -nargs=1 -complete=buffer -range Append call Append(<line1>, <line2>, <f-args>)
" === end of vimrc
let g:python3_host_prog = '/usr/bin/python3'  " Python 3
let g:python_host_prog = '/usr/bin/python3'  " Python 3
