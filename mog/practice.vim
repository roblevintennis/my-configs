" --------------- Random Vim Scripting Practice -------------- 
" Reference: http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html#Scripting in Insert mode
" To run:
" :so ~/.vim/practice.vim
" ------------------------------------------------------------
"
" echo \"\u263A\"
" to use above unescape the string \" to "
" let a=[1,2,3,4]
" echo a
" echo a[2]
" echo a['2']
" let dict={"foo":"val", "bar":{"baz":'bazzy','d':{"dazz":'dazzy'}}}
" echo dict
" echo dict.bar
" echo dict.bar.baz
let ident = 'Vim'
if ident == 0 "Always true (string 'vim' converted to num 0)
  echo "YUP"
endif

if ident == '0'
  echo "YUP2"
endif

if ident == 'Vim'
  echo "Of course!"
endif


"Create a text highlighting style that always stands out...
highlight STANDOUT term=bold cterm=bold gui=bold

"List of troublesome words...
let s:words = [
             \ "it's",  "its",
             \ "your",  "you're",
             \ "were",  "we're",   "where",
             \ "their", "they're", "there",
             \ "to",    "too",     "two"
             \ ]

"Build a Vim command to match troublesome words...
let s:words_matcher
\ = 'match STANDOUT /\c\<\(' . join(s:words, '\|') . '\)\>/'

function! Foo()
   let w:check_words = exists('w:check_words') ? !w:check_words : 1
   echo exists('w:check_words')

   if w:check_words
      echo 'check_words exists...'
   else 
      echo 'check_words NOT exists...'
   endif

   let s:test = "TESTING..."
   echo s:test

endfunction

"Toggle word checking on or off...
function! WordCheck ()
   "Toggle the flag (or set it if it doesn't yet exist)...
   let w:check_words = exists('w:check_words') ? !w:check_words : 1

   "Turn match mechanism on/off, according to new state of flag...
   if w:check_words
      exec s:words_matcher
   else
      match none
   endif
endfunction

"Use ;p to toggle checking...

"nmap <silent>  ;p  :call WordCheck()<CR>

imap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>
imap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>

function! Min(num1, num2)
   if a:num1 < a:num2
      let smaller = a:num1
   else
      let smaller = a:num2
   endif
   return smaller
endfunction

function! Count_words() range
  let lnum = a:firstline
  let n = 0
  while lnum <= a:lastline
    let n = n + len(split(getline(lnum)))
    " echo 'n: ' n
    let lnum = lnum + 1
  endwhile
  echo "found " . n . " words"
endfunction

function!  Number()
    echo "line " . line(".") . " contains: " . getline(".")
endfunction


try
  read ~/bogus_file
catch /E484:/
  echo "No bogus_file (duh!"
endtry



	
" This is an example of packing (usr_41.txt) the XXX package
if exists("XXX_loaded")
  delfun XXX_one
  delfun XXX_two
endif

function XXX_one(a)
  "... body of function ...
endfun

function XXX_two(b)
  "... body of function ...
endfun
	
let XXX_loaded = 1

