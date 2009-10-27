" Syntax highlighting seems to be working by default. But in case later not:
"if has("autocmd")
  " Drupal *.module and *.install files.
  "augroup module
  "  autocmd BufRead,BufNewFile *.module set filetype=php
  "  autocmd BufRead,BufNewFile *.install set filetype=php
    "autocmd BufRead,BufNewFile *.m set filetype=objc
    "autocmd BufRead,BufNewFile *.h set filetype=objc
    "autocmd BufRead,BufNewFile *.java set filetype=java
    "autocmd BufRead,BufNewFile *.jsp set filetype=java
  "augroup END
"endif
" Another option (if you know which language you want. Not very runtime savy ;)
":au Syntax java        
":runtime! syntax/java.vim
" Alternative below is xterm
filetype on  " Automatically detect file types.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!
 
" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
 
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

" ctags chokes on javascript
let g:rails_ctags_arguments='--exclude="*.js"'
"
" TagList settings
"
let Tlist_Auto_Open = 1       " always show the tag file
let Tlist_Exit_OnlyWindow = 1   " exit if taglist is last window open
let Tlist_Show_One_File = 1  " Only show tags for current buffer
let Tlist_Use_Right_Window = 1  " Open on right side
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
" let tlist_sql_settings = 'sql;P:package;t:table'
" let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'
" let Tlist_Ctags_Cmd = '/usr/bin/ctags' NO! I'm in /usr/local/bin/ctags for exuberant tags!!!
" let Tlist_WinWidth=40
" let Tlist_WinWidth=33
" let Tlist_File_Fold_Auto_Close = 1  " automatically fold hidden buffers
" let Tlist_Sort_Type = "name"   " default is sort by file order
" let Tlist_Display_Prototype = 1   " displays prototype

" :command -bar -nargs=1 OpenURL :!open -a firefox <args>
:command -bar -nargs=1 OpenURL :!open -a safari <args>

" Open firefox maps to <Option><Command>f
"map <M-D-f> :!/Applications/Firefox.app/Contents/MacOS/firefox-bin -no-remote -P dev
map <D-d><D-d> :!/Applications/Firefox.app/Contents/MacOS/firefox-bin -no-remote -P dev &^M

syntax enable
:syntax on
colorscheme desert
":colorscheme evening
set guifont=Droid\ Sans\ Mono\ 13
" set guifont=Bitstream\ Vera\ Sans\ Mono:h12
" set guifont=Monaco:h10
set guioptions-=m
set guioptions-=T
behave mswin
set selectmode=mouse  " Use mouse to select text
set number
set sts=4
set cindent
set shiftwidth=4
set hlsearch
set showmode
set showcmd
" set mouse=a
set incsearch
set backspace=eol,start,indent
set showmatch
set ruler
:abbreviate imp import java.
":abbreviate main public static void main (String [] args) {
:abbreviate sys System.out.println(
:abbreviate Sys System.out.println(
:abbreviate #b /************************************************
:abbreviate #e ************************************************/
@end erface MyObject: NSObject {> 
@endlementation MyObjectect.h" 
set nocompatible
set dictionary=/usr/dict/words
set noerrorbells
set noignorecase
set noinsertmode
set magic
set history=50
set nobackup
set undolevels=100
set bg=dark
set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
map <F5> :bp<CR>
map <F6> :b#<CR>
map <F7> :!java -cp %:p:h %:t:r<CR>
map <S-F5> :TlistToggle<CR>
map <S-F6> :NERDTree<CR>
map <F9> :make <CR>

