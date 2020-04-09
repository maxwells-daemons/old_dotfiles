""" Begin with tpope's vim-sensible (already run in neovim config)
runtime! plugin/sensible.vim

" Add ~/.vim as a source path
set runtimepath+=~/.vim,~/.vim/after,~/.vim/autoload

" Core modifications are in ~/.vimrc
source ~/.vimrc

""" Aesthetics
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1  " Enable true-color support
set showmode! " Do not show current mode (overwrites vimrc default)

""" Plugins
filetype off  " Temporarily disable filetype plugins
call plug#begin(stdpath('data') . '/plugged')
    " Editing
    Plug 'tpope/vim-sensible' " Sensible starting defaults
    Plug 'ntpeters/vim-better-whitespace' " Whitespace stripping on save
    Plug 'Raimondi/delimitMate' " Autocomplete parentheses, etc
    Plug 'tpope/vim-surround' " Edit surrounding pairs
    Plug 'tpope/vim-commentary' " gcc/gc to toggle comments
    Plug 'justinmk/vim-sneak' " Motion to jump to a location, bound to s

    " Text objects
    Plug 'wellle/targets.vim' " Seek to text objects for pairs and separators
    Plug 'michaeljsmith/vim-indent-object' " Text object i for indentation level
    Plug 'kana/vim-textobj-entire' " Text object e for the entire buffer
    Plug 'glts/vim-textobj-comment' " Text object c for comments

    " Window and file management
    Plug 'tpope/vim-unimpaired' " Paired actions like [q, [l, and [b
    Plug 'qpkorr/vim-bufkill' " :BD to close a buffer without closing the split
    Plug 'preservim/nerdtree' " Directory browser
    Plug 'Xuyuanp/nerdtree-git-plugin' " Integrate git with NERDTree
    Plug 'junegunn/fzf' " Fuzzy-finder
    Plug 'junegunn/fzf.vim' " Integrates fzf with vim

    " Tools
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'simnalamburt/vim-mundo' " Undo tree
    Plug 'liuchengxu/vista.vim' " Tag viewer

    " Aesthetics
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
    Plug 'mhinz/vim-signify' " See git changes in gutter and statusline
    Plug 'kshenoy/vim-signature' " Display marks in gutter
    Plug 'Yggdroot/indentLine' " See indentation levels

    " TODO: install and configure coc
    " TODO: install and configure Ale

    " Dependencies
    Plug 'tpope/vim-repeat' " Enables repeating certain plugins with .
    Plug 'kana/vim-textobj-user' " Support for custom text objects
call plug#end()
filetype plugin indent on " Enable filetype plugins and indent files

""" Mappings
" Disable <p mapping (from vim-unimpaired) in normal mode to regain left-shift
nunmap <

" <leader>n opens or closes NERDTree
noremap <leader>n :NERDTreeToggle<CR>

" targets-vim
let g:targets_nl = 'nN' " Select next text object with n and last with N

" fzf (fuzzy-finding)
" <leader>f searches all files
nnoremap <leader>f :Files<CR>
" <leader>F searches all Git files
nnoremap <leader>F :GFiles<CR>
" <leader>b searches all buffers
nnoremap <leader>b :Buffers<CR>
" <leader>t searches all tags in the current buffer
nnoremap <leader>t :BTags<CR>
" <leader>T searches all tags in the current project
nnoremap <leader>T :Tags<CR>

" <leader>v launches Vista (a tag browser)
nnoremap <leader>v :Vista!!<CR>

""" Configure vim-better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave  " Strip whitespace on save
autocmd BufEnter * DisableWhitespace " Disable whitespace highlighting
let g:strip_whitespace_confirm = 0 " Do not ask before stripping whitespace
let g:show_spaces_that_precede_tabs = 1 " Show spaces around tabs

""" Configure vim-sneak
let g:sneak#label = 1  " Label mode assigns a label to each match
highlight Sneak guifg=red guibg=none ctermfg=red ctermbg=none

""" Configure NERDTree
" If NERDTree is the only window open, close vim
" Source: https://github.com/preservim/nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \ b:NERDTree.isTabTree()) | q | endif

let NERDTreeAutoDeleteBuffer = 1 " When we delete a file, also close its buffer
let NERDTreeMinimalUI = 1 " Disable bookmark and help hints

" Ignore some files
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]']

" Set up git symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "!",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

""" Configure vim-signify
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'

""" Configure Vista
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60

""" Configure vim-airline
let g:airline_powerline_fonts = 1 " Preload powerline fonts
set laststatus=2 " Always show statusline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#wordcount#filetypes = ['txt', 'md']
let g:airline#extensions#wordcount#filetypes  = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail|vimwiki|pandoc'
let g:airline_detect_paste=0

" Only display git hunks if diff is nonzero
let g:airline#extensions#hunks#non_zero_only = 1

""" Configure vim-signature
let g:SignatureMap = {
\ 'Leader'             :  "m",
\ 'PlaceNextMark'      :  "m,",
\ 'ToggleMarkAtLine'   :  "m.",
\ 'PurgeMarksAtLine'   :  "m-",
\ 'DeleteMark'         :  "dm",
\ 'PurgeMarks'         :  "m<Space>",
\ 'PurgeMarkers'       :  "m<BS>",
\ 'GotoNextLineAlpha'  :  "']",
\ 'GotoPrevLineAlpha'  :  "'[",
\ 'GotoNextSpotAlpha'  :  "m]",
\ 'GotoPrevSpotAlpha'  :  "m[",
\ 'GotoNextLineByPos'  :  "]'",
\ 'GotoPrevLineByPos'  :  "['",
\ 'GotoNextSpotByPos'  :  "]`",
\ 'GotoPrevSpotByPos'  :  "[`",
\ 'GotoNextMarker'     :  "]-",
\ 'GotoPrevMarker'     :  "[-",
\ 'GotoNextMarkerAny'  :  "]=",
\ 'GotoPrevMarkerAny'  :  "[=",
\ 'ListBufferMarks'    :  "m/",
\ 'ListBufferMarkers'  :  "m?"
\ }
let g:SignatureMarkTextHL = "SignColumn"
