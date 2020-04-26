""" Command templates:
" html5: --to=html --template=~/.config/nvim/pandoc-templates/template.html5
"       -Vlang="en" -Vauthor-meta="Aidan Swope"
"
" Run with: :Pandoc #html5

""" Mappings
let g:pandoc#keyboard#use_default_mappings = 0  " Disable default mappings
" Toggle emphasis with <C-i>
nmap <buffer> <C-i> <Plug>(pandoc-keyboard-toggle-emphasis)
vmap <buffer> <C-i> <Plug>(pandoc-keyboard-toggle-emphasis)
" Toggle bold with <C-b>
nmap <buffer> <C-b> <Plug>(pandoc-keyboard-toggle-strong)
vmap <buffer> <C-b> <Plug>(pandoc-keyboard-toggle-strong)
" Toggle verbatim with <C-v>
nmap <buffer> <C-v> <Plug>(pandoc-keyboard-toggle-verbatim)
vmap <buffer> <C-v> <Plug>(pandoc-keyboard-toggle-verbatim)
" Toggle superscript with <C-u>
nmap <buffer> <C-u> <Plug>(pandoc-keyboard-toggle-superscript)
vmap <buffer> <C-u> <Plug>(pandoc-keyboard-toggle-superscript)
" Toggle subscript with <C-d>
nmap <buffer> <C-d> <Plug>(pandoc-keyboard-toggle-subscript)
vmap <buffer> <C-d> <Plug>(pandoc-keyboard-toggle-subscript)
" Toggle checkbox with <C-space>
nmap <buffer> <C-space> <Plug>(pandoc-keyboard-toggle-cb)
vmap <buffer> <C-space> <Plug>(pandoc-keyboard-toggle-cb)

" List table of contents with <leader>t
nnoremap <silent> <leader>t :TOC<CR>

""" Pandoc settings
let g:pandoc#folding#fastfolds=1 " More efficient folding algorithm
let g:pandoc#folding#level=20 " Open folds by default"
let g:pandoc#folding#fdc=0 " Disable foldcolumn
let g:pandoc#compiler#arguments = "--standalone --mathjax"

" Disable unused modules (use Coc's spellchecking and completion)
let g:pandoc#spell#enabled=0
let g:pandoc#modules#disabled = ["completion", "spell"]

""" Goyo (distraction-free mode) settings
" See: https://github.com/junegunn/goyo.vim/wiki/Customization

" Toggle some settings along with Goyo
function! s:goyo_enter()
    Limelight " Enable paragraph highlighting
    CocDisable " Disable error-checking, highlighting, and completion
endfunction
function! s:goyo_leave()
    Limelight! " Disable paragraph highlighting
    CocEnable " Enable error-checking, highlighting, and completion
endfunction

let g:goyo_width = 125 " Goyo mode use 125 characters of width

" Set brightness of Limelight
let g:limelight_default_coefficient = 0.5

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

""" Aesthetics
let g:indentLine_enabled=0 " Disable indentLine conceal functionality
let g:indentLine_setColors=0 " Disable indentLine colors
setlocal conceallevel=2 " Enable conceal
setlocal concealcursor-=n " Disable conceal on the current line
setlocal colorcolumn=  " Disable color column

" Fix conceal color
hi! link conceal comment
