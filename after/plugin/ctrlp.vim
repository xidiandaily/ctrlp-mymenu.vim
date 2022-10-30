"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.10.30
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

if !exists('g:loaded_ctrlp') || g:loaded_ctrlp == 0
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! CtrlPMyMenu call ctrlp#init(ctrlp#mymenu#id())
let &cpo = s:save_cpo
unlet s:save_cpo
