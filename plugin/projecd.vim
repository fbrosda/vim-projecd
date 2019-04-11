" Location: plugin/projecd.vim
" Author:   Fabian Brosda
" Version:  0.1

if exists("g:loaded_projecd") 
  finish
endif
let g:loaded_projecd = 1
let s:plugindir = expand('<sfile>:p:h:h')

if !exists("g:projecd_dbfile")
  let g:projecd_dbfile = s:plugindir . '/.data/projecd_list'
endif

if !exists("g:projecd_rootcmd")
  let g:projecd_rootcmd = "git -C {} rev-parse --show-toplevel"
endif

function! s:get_command(cmd)
    return substitute(a:cmd, "{}", expand("%:h"), "")
endfunction

function! s:get_path()
    let ret = system(s:get_command(g:projecd_rootcmd))
    return substitute(ret, '\n\+$', '', '')
endfunction

function! s:get_projects()
    try
        let content = readfile( g:projecd_dbfile )
    catch /./
        let content = []
    endtry
    return content
endfunction

function! s:store_path()
    let path = s:get_path()
    let content = s:get_projects() + [path]
    let content = filter(copy(content), 'index(content, v:val, v:key+1)==-1')

    call writefile( content, g:projecd_dbfile)
endfunction

function! s:cd_path()
    let projects = s:get_projects()
    call fzf#run({'source': reverse( projects ), 'sink': 'cd', 'down': '20%'})
endfunction

" TODO make this optional
autocmd BufRead * call s:store_path()

" TODO add CdAdd command, to cd somewhere and add root to list
command! Cd call s:cd_path()

