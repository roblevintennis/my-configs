:colorscheme koehler
set ruler
set incsearch
set guifont=Droid\ Sans\ Mono:h12
" Uncomment to show tabs, etc., explicitly
"set list
":set listchars=tab:>-,trail:-
let c_space_errors=1
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

function! CapitalizeCenterAndMoveDown()
   s/\<./\u&/g   "Built-in substitution capitalizes each word
   center        "Built-in center command centers entire line
   +1            "Built-in relative motion (+1 line down)
endfunction
nmap <silent>  \C  :call CapitalizeCenterAndMoveDown()<CR>


function! MyFunc()
    let m = visualmode()
    if m ==# 'v'
        echo 'character-wise visual'
    elseif m == 'V'
        echo 'line-wise visual'
    elseif m == "\<C-V>"
        echo 'block-wise visual'
    endif
endfunction

function PrintDetails(name, title, email)
    echo 'Name:   '  a:title  a:name
    echo 'Contact:'  a:email
endfunction

function Capitalize()
    echo 'Capitalize called...'
    :s/\<\(.\)\([A-Za-z]*\)\>/\u\1\L\2/g
endfunction

" To make below: Cntl-v Cntl-W :!cp -pf % %~Cntl-v than ENTER :w Cntl-v than ENTER
" This expands to copying the file to file~
map  :!cp -pf % %~:w

" :ab 123 onetwothree
" :g/^Section/s//As you recall, in^M&/

" type Command-8 then f to get a function skeleton:
map! <D-8>f foo() {    var foo;};3kwdwi

" type mogff to get a function skeleton like Mog.foo = function() {...
map! <D-8>ff Mog.= function () {};2k0wli

" type mogif to get an if skeleton
map! <D-8>if if() {}kllli

" No tabs in the source file.
" All tab characters are 4 space characters.
:set tabstop=4
:set shiftwidth=4
:set expandtab

:set tags=./tags,tags,~/commontags

function DeAmperfy()
    "Get current line...
    let curr_line   = getline('.')

    "Replace raw ampersands...
    let replacement = substitute(curr_line,'&\(\w\+;\)\@!','&amp;','g')

    "Update current line...
    call setline('.', replacement)
endfunction

function DeAmperfyAll() range
    "Step through each line in the range...
    for linenum in range(a:firstline, a:lastline)
        "Replace loose ampersands (as in DeAmperfy())...
        let curr_line   = getline(linenum)
        let replacement = substitute(curr_line,'&\(\w\+;\)\@!','&amp;','g')
        call setline(linenum, replacement)
    endfor

    "Report what was done...
    if a:lastline > a:firstline
        echo "DeAmperfied" (a:lastline - a:firstline + 1) "lines"
    endif
endfunction


function! AlignAssignments ()
    " Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'

    " Locate block of code to be considered (same indentation, no blanks)...
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    " Decompose lines at assignment operators...
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        if len(fields) 
            call add(lines, {'lval':fields[1], 'op':fields[2], 'rval':fields[3]})
        else
            call add(lines, {'text':linetext,  'op':''                         })
        endif
    endfor

    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val.op)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val.lval)') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val.op)'  ) )

    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        let newline = empty(line.op)
        \ ? line.text
        \ : printf("%-*s%*s%s", max_lval, line.lval, max_op, line.op, line.rval)
        call setline(linenum, newline)
        let linenum += 1
    endfor
endfunction

nmap <silent>  ;=  :call AlignAssignments()<CR>

function! Uniq () range
    " Nothing unique seen yet...
    let have_already_seen = {}
    let unique_lines = []

    " Walk through the lines, remembering only the hitherto-unseen ones...
    for original_line in getline(a:firstline, a:lastline)
        let normalized_line = '>' . original_line 
        if !has_key(have_already_seen, normalized_line)
            call add(unique_lines, original_line)
            let have_already_seen[normalized_line] = 1
        endif
    endfor

    " Replace the range of original lines with just the unique lines...
    exec a:firstline . ',' . a:lastline . 'delete'
    call append(a:firstline-1, unique_lines)
endfunction

nmap ;u :%call Uniq()<CR>

