" Location: plugin/projecd.vim
" Author:   Fabian Brosda
" Version:  0.1

if exists('g:loaded_projecd') 
  finish
endif
let g:loaded_projecd = 1
let s:plugindir = expand('<sfile>:p:h:h')

" Global Variables
if !exists('g:projecd_dbfile')
  let g:projecd_dbfile = s:plugindir . '/.data/projecd_list'
endif

if !exists('g:projecd_rootcmd')
  let g:projecd_rootcmd = 'git -C {} rev-parse --show-toplevel'
endif

if !exists('g:projecd_autosave')
  let g:projecd_autosave = 1
endif


" Private Functions
function s:get_command(cmd)
    return substitute(a:cmd, '{}', expand('%:h'), '')
endfunction

function s:get_path()
    let ret = system(s:get_command(g:projecd_rootcmd))
    if v:shell_error > 0
        return ''
    else
        return substitute(ret, '\n\+$', '', '')
    endif
endfunction

function s:get_projects()
    try
        let content = readfile( g:projecd_dbfile )
    catch /./
        let content = []
    endtry
    return content
endfunction

function s:store_path( path )
    if strlen(a:path)
        let content = s:get_projects() + [a:path]
        let content = filter(copy(content), 'index(content, v:val, v:key+1)==-1')

        call writefile( content, g:projecd_dbfile)
    endif
endfunction

function s:cd_path_fzf()
    let projects = s:get_projects()
    if exists("*FloatingFZF")
        call fzf#run({'source': reverse( projects ), 'sink': 'cd', 'down': '20%', 'window': 'call FloatingFZF()'})
    else
        call fzf#run({'source': reverse( projects ), 'sink': 'cd', 'down': '20%'})
    endif
endfunction

function s:cd_add( path ) abort
    execute 'cd' fnameescape( a:path )
    call s:store_path(substitute(system('pwd'), '\n\+$', '', ''))
endfunction

function! ProjeCdPathComplete(A, L, P)
    let projs = s:get_projects()
    call filter(projs, {idx, val -> val =~ a:A})
    return projs
endfunction


" Autocmds
if( g:projecd_autosave ) 
    autocmd BufRead * call s:store_path( s:get_path() )
endif


" Commands
" if exists('*fzf#run')
    command ProjeCd call s:cd_path_fzf()
" else
"     command -nargs=1 -complete=customlist,ProjeCdPathComplete D execute 'cd' fnameescape( <f-args> )
" endif
command -nargs=1 -complete=dir ProjCdAdd call s:cd_add(<f-args>)

