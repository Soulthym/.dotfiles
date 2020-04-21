function! IsInTab(line)
    if match(getline(a:line), '^ *|.*') != -1
        return 1
    else
        return 0
    endif
endfunction

function! TabFormat() "TODO: extract the line format function from this code to allow automatic cell's size calculation
    if IsInTab('.')
        let s:currentlinenumber = line('.')
        let s:startline = s:currentlinenumber - 1
        while IsInTab(s:startline) && s:startline > 0 " Detect where the table starts
            let s:startline = s:startline - 1
        endwhile
        let s:startline = s:startline + 1
        let s:stopline = s:currentlinenumber + 1
        while IsInTab(s:stopline) && s:stopline <= line('$') " Detect where the table ends
            let s:stopline = s:stopline + 1
        endwhile
        let s:stopline = s:stopline - 1
        let s:indent = substitute(getline('.'), 
                    \'^\(\s*\)|.*', '\1', '') " extract the indentation
        let s:lines = []
        for s:linenumber in range(s:startline, s:stopline) " for all lines in the table
            let s:line = getline(s:linenumber)
            if match(s:line, '^[	 |:=-]*$') == -1 " if line isnt the header separator
                let s:line = substitute(s:line,
                            \'\s*|\s*', ' | ', 'g')  " only keep a space of one between the cell's content and the border
            else
                let s:line = substitute(s:line,
                            \'\s', '', 'g')          " but if it is a separator, delete all spaces
                let s:line = substitute(s:line,
                            \'\(-\|=\)*', '\1', 'g') " and delete all duplicates
            endif
            let s:line = substitute(s:line,
                        \'^ *|\|| *$', '|', 'g')    " remove un-necessary spaces and newlines at the end and beginning of the line
            call add(s:lines, s:indent . s:line)    " add indent and write the formatted line to the list
        endfor
        let s:lines = split(system('column -s "|" -o "|" -t', s:lines), '\n')
        let s:linenumbers = range(s:startline, s:stopline)
        for i in range(len(s:lines))
            call setline(s:linenumbers[i], s:lines[i])
        endfor
        " echom "Formatted Table"
    else
        echom "Not in a Table"
    endif
endfunction

nmap <leader>t :call TabFormat()<cr>
nmap <leader><leader> :s/ //g<cr>
