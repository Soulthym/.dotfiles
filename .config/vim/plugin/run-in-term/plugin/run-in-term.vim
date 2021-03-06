" This comes from this amazing comment on StackOverflow,
" from Peter Rincker (March 19th, 2018):
" https://stackoverflow.com/a/49366558/10264886
augroup send_to_term
  autocmd!
  autocmd TerminalOpen * if &buftype ==# 'terminal' |
        \   let t:send_to_term = +expand('<abuf>') |
        \ endif
augroup END


function! s:op(type, ...)
  let [sel, rv, rt] = [&selection, @@, getregtype('"')]
  let &selection = "inclusive"

  if a:0 
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  call s:send_to_term(@@)

  let &selection = sel
  call setreg('"', rv, rt)
endfunction

function! s:send_to_term(keys)
  let bufnr = get(t:, 'send_to_term', 0)
  if bufnr > 0 && bufexists(bufnr) && getbufvar(bufnr, '&buftype') ==# 'terminal'
    let keys = substitute(a:keys, '\n\+$', '', '')
    let endc = "\<cr>"
    if match(keys, '.*\n \+[^ ][^\n]*$') != -1
        let endc = endc . "\<cr>"
    endif
    call term_sendkeys(bufnr, keys . endc)
    echo "Sent " . len(keys) . " chars -> " . bufname(bufnr)
  else
    echom "Error: No terminal"
  endif
endfunction

command! -range -bar SendToTerm call s:send_to_term(join(getline(<line1>, <line2>), "\n"))
nmap <script> <Plug>(send-to-term-line) :<c-u>SendToTerm<cr>
nmap <script> <Plug>(send-to-term) :<c-u>set opfunc=<SID>op<cr>g@
xmap <script> <Plug>(send-to-term) :<c-u>call <SID>op(visualmode(), 1)<cr>
