"
" Config for 'fancy plaintext': pandoc, markdown, and vimwiki
"

""" Command templates:
" html5: --to=html --template=~/.config/nvim/pandoc-templates/template.html5
"       -Vlang="en" -Vauthor-meta="Aidan Swope"
"
" Run with: :Pandoc #html5

""" Use 2-space tabs
setlocal tabstop=2
setlocal shiftwidth=2

""" Allow 125-character lines
setlocal colorcolumn=
setlocal textwidth=125

""" Mappings
let g:pandoc#keyboard#use_default_mappings = 0  " Disable default mappings
" Toggle emphasis with <C-e>
nmap <buffer> <C-e> <Plug>(pandoc-keyboard-toggle-emphasis)
vmap <buffer> <C-e> <Plug>(pandoc-keyboard-toggle-emphasis)
" Toggle bold with <C-b>
nmap <buffer> <C-b> <Plug>(pandoc-keyboard-toggle-strong)
vmap <buffer> <C-b> <Plug>(pandoc-keyboard-toggle-strong)
" Toggle verbatim with <C-`>
nmap <buffer> <C-`> <Plug>(pandoc-keyboard-toggle-verbatim)
vmap <buffer> <C-`> <Plug>(pandoc-keyboard-toggle-verbatim)
" Toggle superscript with <C-x>
nmap <buffer> <C-x> <Plug>(pandoc-keyboard-toggle-superscript)
vmap <buffer> <C-x> <Plug>(pandoc-keyboard-toggle-superscript)
" Toggle subscript with <C-d>
nmap <buffer> <C-d> <Plug>(pandoc-keyboard-toggle-subscript)
vmap <buffer> <C-d> <Plug>(pandoc-keyboard-toggle-subscript)

" List table of contents with <leader>t
nnoremap <silent> <leader>t :TOC<CR>

""" Pandoc settings
let g:pandoc#compiler#arguments = "--standalone --mathjax"

" Hard wrap and autoformat as you type
let g:pandoc#formatting#mode='ha'

" Disable unused modules (use Coc's spellchecking and completion)
let g:pandoc#spell#enabled=0
let g:pandoc#modules#disabled = ["completion", "spell"]

" Set highlighted languages
let g:pandoc#syntax#codeblocks#embeds#langs = ["css", "svg", "bash", "python", "javascript"]

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

let g:goyo_width = 150 " Goyo mode use 150 characters of width

" Set brightness of Limelight
let g:limelight_default_coefficient = 0.5

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

""" Conceal settings
let g:pandoc#syntax#conceal#urls = 1 " Conceal URLs
let g:pandoc#syntax#conceal#blacklist = ["definition"] " Don't conceal definitions

" Fix conceal color
hi! link conceal comment

""" Fixes
" Manual fix for https://github.com/vim-pandoc/vim-pandoc-syntax/issues/338
syn match pandocAtxHeader /^\s*#\{1,6}.*\n/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,@Spell display
