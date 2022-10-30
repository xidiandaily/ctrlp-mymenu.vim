"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.10.30
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let s:builtins = [
      \ {'sname' : 'fil', 'lname' : 'files'},
      \ {'sname' : 'buf', 'lname' : 'buffers'},
      \ {'sname' : 'mru', 'lname' : 'mru files'},
      \ ]

fu! ctrlp#myutils#init_mymenu()
    let s:myextvars=map(copy(g:ctrlp_ext_vars), 'printf("%s", v:val.sname)')
    let s:mybuiltins=map(copy(s:builtins) , 'printf("%s", v:val.sname)')
    let s:ctrlp_mymenu_groups={
                \ 'menu': s:myextvars,
                \ 'base': s:mybuiltins
                \ }

    if exists('g:ctrlp_mymenu_ext_groups')
        call extend(s:ctrlp_mymenu_groups,g:ctrlp_mymenu_ext_groups,'force')
    endif
endfu


fu! ctrlp#myutils#get_mymenu()
    call ctrlp#myutils#init_mymenu()
    let s:tmp=values(map(copy(s:ctrlp_mymenu_groups),'printf("%s\t:%s",v:key,join(v:val,","))'))
    return s:tmp
endfu


fu! ctrlp#myutils#set_menu(str)
    let s:menu=a:str
endfu


fu! ctrlp#myutils#get_mysubmenu()
    let s:submenu=[]
    if !exists('s:menu')
        return s:submenu
    endif

    for key in keys(s:ctrlp_mymenu_groups)
        if key == s:menu
            for subkey in s:ctrlp_mymenu_groups[key]
                let target = filter(copy(g:ctrlp_ext_vars), 'v:val.sname ==# subkey')[0]
                call add(s:submenu,printf("%s\t:%s",subkey,target['lname']))
            endfor
            return s:submenu
        endif
    endfor
    return s:submenu
endfu

fu! ctrlp#myutils#accept_submenu(str)
  " builtins
  let sname=a:str
  let n = index(map(copy(s:builtins), 'v:val.sname'), sname)
  if n > -1
    call ctrlp#init(n)
    return
  endif
  " plugins
  let target = filter(copy(g:ctrlp_ext_vars), 'v:val.sname ==# sname')[0]
  if !empty(target)
    call ctrlp#init(call(substitute(target.accept, '#accept', '#id', ''),[]))
  endif
endfu
