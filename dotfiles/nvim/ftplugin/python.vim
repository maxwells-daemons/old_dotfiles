" Mappings
" Visual-mode <CR> runs a selection in the interpreter
vnoremap <CR> :CocCommand python.execSelectionInTerminal<CR>

" Use an 88-character colorcolumn
set colorcolumn=88

" Configure Semshi
let g:semshi#mark_selected_nodes = 0  " Use Illuminate to highlight matches
let g:semshi#update_delay_factor = 0.0001 " Delay parsing for big files
let g:semshi#error_sign = 0 " Do not display errors in the sign column

" Custom Semshi highlighting
function SemshiHighlights()
    " Yellow - builtins, global scope, and imports (bold)
    hi semshiBuiltin            guifg=#ffdc2d
    hi semshiGlobal             guifg=#ffdc2d
    hi semshiImported           guifg=#ffdc2d gui=bold

    " Blue - parameters (italic when unused) and nonlocal values (bold)
    hi semshiParameter          guifg=#6187ff
    hi semshiParameterUnused    guifg=#6187ff gui=italic

    " Red - nonlocal names
    hi semshiFree               guifg=#ff661a

    " Pink - attributes
    hi semshiAttribute          guifg=#fb6acb

    " Light blue - self
    hi semshiSelf               guifg=#cad3ff

    " Show unresolved names as regular text
    hi semshiUnresolved         guifg=#e9e7e1
endfunction
autocmd FileType python call SemshiHighlights()

" Explicitly refresh Semshi on save
autocmd BufWrite *.py :Semshi highlight

" Just use text objects from pythonsense
let g:is_pythonsense_suppress_motion_keymaps = 1

" Use capital C for class text objects
xmap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
omap <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
xmap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)
omap <buffer> iC <Plug>(PythonsenseInnerClassTextObject)

" Re-enable comment text object
xmap <buffer> ac <Plug>(textobj-comment-a)
omap <buffer> ac <Plug>(textobj-comment-a)
xmap <buffer> ic <Plug>(textobj-comment-i)
omap <buffer> ic <Plug>(textobj-comment-i)

" Auto-activate poet and pipenv environments
let g:poetv_auto_activate = 1

" When switching away, undo changes
let b:undo_ftplugin = "set colorcolumn=80"
