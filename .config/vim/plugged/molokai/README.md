# Molokai Color Scheme for Vim

This is a fork of [tomasr/molokai](https://github.com/tomasr/molokai) with the following changes:

* `LineNr` color background is matched to `Normal`
* Revert `MatchParen` color changes for better readability ([pr](https://github.com/tomasr/molokai/pull/44))
* `VertSplit` line is dimmed and `set fillchars+=vert:│` has been set to remove the dashed vertical split line



## Installation

Use a plugin manager, i.e:

* [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'fatih/molokai'`


or copy the file on your .vim/colors folder.

## Settings

If you prefer the scheme to match the original monokai background color, put this in your .vimrc file: 
```
let g:molokai_original = 1
```

There is also an alternative scheme under development for color terminals which
attempts to bring the 256 color version as close as possible to the the default
(dark) GUI version. To access, add this to your .vimrc:
```
let g:rehash256 = 1
```

## Original Description

Molokai is a Vim port of the monokai theme for TextMate originally created by
Wimer Hazenberg. 

256-Color terminals are also supported, though there are some differences with
the Gui version. Only the dark gray background style is supported on terminal
vim at this time.
