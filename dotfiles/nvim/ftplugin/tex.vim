""" Set up concealing
let g:indentLine_enabled=0 " Disable indentLine conceal functionality
let g:indentLine_setColors=0 " Disable indentLine colors
setlocal conceallevel=0 " Disable conceal

" Fix conceal color
hi! link conceal comment

""" Misc
let g:vimtex_view_method='zathura'  " Use Zathura to view compiled pdfs
let g:vimtex_compiler_progname = 'nvr' " Use neovim-remote for vimtex
