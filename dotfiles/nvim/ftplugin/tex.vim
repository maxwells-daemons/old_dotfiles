""" Set up concealing
let g:indentLine_enabled=0 " Disable indentLine conceal functionality
let g:indentLine_setColors=0 " Disable indentLine colors
let g:tex_conceal='abdgms' " Enable all conceal groups
setlocal conceallevel=2 " Enable conceal
setlocal concealcursor-=n " Disable conceal on the current line

" Fix conceal color
hi! link conceal comment

""" Misc
let g:vimtex_view_method='zathura'  " Use Zathura to view compiled pdfs
