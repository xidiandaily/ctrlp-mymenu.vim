"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.10.30
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

if ( exists('g:loaded_ctrlp_mymenu') && g:loaded_ctrlp_mymenu )
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_mymenu = 1

" The main variable for this extension.
"
" The values are:
" + the name of the input function (including the brackets and any argument)
" + the name of the action function (only the name)
" + the long and short names to use for the statusline
" + the matching type: line, path, tabs, tabe
"                      |     |     |     |
"                      |     |     |     `- match last tab delimited str
"                      |     |     `- match first tab delimited str
"                      |     `- match full line like file/dir path
"                      `- match full line
let s:ctrlp_var = {
      \ 'init'  : 'ctrlp#mymenu#init()',
      \ 'accept': 'ctrlp#mymenu#accept',
      \ 'lname' : 'mymenu',
      \ 'sname' : 'mymenu',
      \ 'type'  : 'line',
      \ 'sort'  : 0,
      \ 'nolim' : 1,
      \ }

" Append s:ctrlp_var to g:ctrlp_ext_vars
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:ctrlp_var)
else
  let g:ctrlp_ext_vars = [s:ctrlp_var]
endif


" Provide a list of strings to search in
"
" Return: command
function! ctrlp#mymenu#init()
  return ctrlp#myutils#get_mymenu()
endfunction


" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
func! ctrlp#mymenu#accept(mode, str)
  call ctrlp#exit()
  let sname = split(a:str, "	")[0]
  call ctrlp#myutils#set_menu(sname)
  call ctrlp#init(ctrlp#mysubmenu#id())
endfunc


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#mymenu#id()
  return s:id
endfunction


" vim:fen:fdl=0:ts=2:sw=2:sts=2
