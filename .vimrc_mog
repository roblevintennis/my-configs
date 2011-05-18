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
map! <D-8>f function foo() {    var foo;};3kwdwi




