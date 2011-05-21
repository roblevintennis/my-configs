" Rob Levin's personal Vim global plugin.
" Last Change:	2011 May 20
" Maintainer:	Rob Levin <roblevintennis@gmail.com>
" License:	This file is placed in the public domain.
" Usage:
" Just put this file in your ~/.vim/plugin/
" type:
"   \as To get the current song info
"
" Changelog:
"  0.0.1

"if v:version < 602 
"    finish
"endif

" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_AppName") || &cp
  finish
endif
let g:loaded_AppName= 123 " your version number

" Save the cpoptions so we can restore later
let s:save_cpo = &cpo
set cpo&vim

" Public Interface:
" AppFunction: is a function you expect your users to call
" AppFunc: some sequence of characters that will run your AppFunction
" Repeat these three lines as needed for multiple functions which will
" be used to provide an interface for the user
if !hasmapto('<Plug>AppFunction')
  map <unique> <Leader>MyApp <Plug>AppFunction
endif

" Global Maps:
"
map <silent> <unique> <script> <Plug>AppFunction
 \ :set lz<CR>:call <SID>AppFunction<CR>:set nolz<CR>


" Puts MyApp AppFunction in Plugin menu. Selecting will call AppFunction 
"noremap <unique> <script> <Plug>AppFunction  <SID>AppFunction
noremenu <script> Plugin.MyApp\ AppFunction :call <SID>AppFunction()<CR>


fun! s:AppFunction()
  echo "AppFunction called..."

  " your script function can set up maps to internal functions
  "nmap <silent> <Left> :set lz<CR>:silent! call <SID>AppFunction2<CR>:set nolz<CR>

  " your app can call functions in its own script and not worry about name
  " clashes by preceding those function names with <SID>
  call s:InternalAppFunction()
endfun

" ------------------------------------------------------------------------------
" s:InternalAppFunction: this function cannot be called from outside the
" script, and its name won't clash with whatever else the user has loaded
fun! s:InternalAppFunction()
  echo "InternalAppFunction called..."
endfun

" Adds the :MyApp command 
if !exists(":MyApp")
    command! -nargs=0 MyApp :call s:AppFunction()
    "command! -nargs=1  MyApp  :call s:AppFunction(<f-args>)
    "command! -nargs=1 SimpleNote :call <SID>SimpleNote(<f-args>)
endif

" ------------------------------------------------------------------------------
" Restores the user's original cpoptions
let &cpo = s:save_cpo
unlet s:save_cpo
