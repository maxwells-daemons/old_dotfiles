" Define linters
let b:ale_linters = ['flake8', 'mypy']

" Run Black and Isort on save
let b:ale_fixers = ['black', 'isort']

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
map <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
map <buffer> iC <Plug>(PythonsenseInnerClassTextObject)

" Re-enable comment text object
map <buffer> ac <Plug>(textobj-comment-a)
map <buffer> ic <Plug>(textobj-comment-i)

" Auto-activate poet and pipenv environments
let g:poetv_auto_activate = 1
