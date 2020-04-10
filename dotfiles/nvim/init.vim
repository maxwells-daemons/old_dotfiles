""" Begin with tpope's vim-sensible (already run in neovim config)
runtime! plugin/sensible.vim

" Add ~/.vim as a source path
set runtimepath+=~/.vim,~/.vim/after,~/.vim/autoload

" Core modifications are in ~/.vimrc
source ~/.vimrc

" Tags are stored locally
set tags=./tags

""" Aesthetics
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1  " Enable true-color support
set showmode! " Do not show current mode (overwrites vimrc default)
set signcolumn=yes  " Keep sign column open

""" Plugins
filetype off  " Temporarily disable filetype plugins
call plug#begin(stdpath('data') . '/plugged')
    " Editing
    Plug 'tpope/vim-sensible' " Sensible starting defaults
    Plug 'lambdalisue/suda.vim' " Read and write files with sudo
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
    Plug 'drmingdrmer/vim-toggle-quickfix' " Toggle quickfix and loclist
    Plug 'qpkorr/vim-bufkill' " :BD to close a buffer without closing the split
    Plug 'preservim/nerdtree' " Directory browser
    Plug 'Xuyuanp/nerdtree-git-plugin' " Integrate git with NERDTree
    Plug 'junegunn/fzf' " Fuzzy-finder
    Plug 'junegunn/fzf.vim' " Integrates fzf with vim

    " Tools
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'simnalamburt/vim-mundo' " Undo tree
    Plug 'liuchengxu/vista.vim' " Tag viewer
    Plug 'dense-analysis/ale' " Linting engine
    Plug 'vimwiki/vimwiki' " Personal wiki

    " Aesthetics
    Plug 'sheerun/vim-polyglot' " Language pack
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
    Plug 'mhinz/vim-signify' " See git changes in gutter and statusline
    Plug 'kshenoy/vim-signature' " Display marks in gutter
    Plug 'Yggdroot/indentLine' " See indentation levels
    Plug 'RRethy/vim-illuminate' " Highlight the word under the cursor

    " TODO: install and configure coc

    " Python
    " Semantic syntax highlighting
    Plug 'numirias/semshi', {'for': 'python', 'do': ':UpdateRemotePlugins'}
    " Better indentation
    Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
    " Text objects for classes (C), functions (f), and docstrings (d)
    Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python'}
    " Work with virtualenvs
    Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
    Plug 'petobens/poet-v', {'for': 'python'}

    " Dependencies
    Plug 'tpope/vim-repeat' " Enables repeating certain plugins with .
    Plug 'kana/vim-textobj-user' " Support for custom text objects
call plug#end()
filetype plugin indent on " Enable filetype plugins and indent files

""" Mappings (movement)
let g:targets_nl = 'nN' " Select next pair text object with n and last with N

""" Mappings (UI)
" ]b and [b move to next and previous buffers
noremap ]b :bn<CR>
noremap [b :bp<CR>

" <leader>c splits to the right
noremap <leader>c :vsp<CR>
" <leader>v splits below
noremap <leader>v :sp<CR>

" <leader>q toggles quickfix
noremap <leader>q :call togglequickfix#ToggleQuickfix()<CR>
" <leader>l toggles loclist
noremap <leader>l :call togglequickfix#ToggleLocation()<CR>

" <leader>n opens or closes NERDTree
noremap <leader>n :NERDTreeToggle<CR>

" fzf (fuzzy-finding)
" <leader>f searches all files
nnoremap <leader>f :Files<CR>
" <leader>F searches all Git files
nnoremap <leader>F :GFiles<CR>
" <leader>b searches all buffers
nnoremap <leader>b :Buffers<CR>

" <leader>t toggles Vista (a tag browser)
nnoremap <leader>t :Vista!!<CR>

" <leader>g toggles Git
nnoremap <leader>g :Git<CR>

" Disable bufkill mappings
let g:BufKillCreateMappings = 0

""" Configure suda
let g:suda_smart_edit = 1  " Allow automatically opening files with sudo

""" Configure better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave  " Strip whitespace on save
autocmd BufEnter * DisableWhitespace " Disable whitespace highlighting
let g:strip_whitespace_confirm = 0 " Do not ask before stripping whitespace
let g:show_spaces_that_precede_tabs = 1 " Show spaces around tabs

""" Configure sneak
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

" Set up Git symbols
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

""" Set up FZF colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'String'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Type'],
  \ 'info':    ['fg', 'Function'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Comment'],
  \ 'pointer': ['fg', 'Function'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

""" Configure Signify
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'

""" Configure Vista
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60

""" Configure Ale
" Only run linting on enter or save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

" Show linter information in error message
let g:ale_echo_msg_format = "%s [%linter%: %code%]"

" Run fixers on save
let g:ale_fix_on_save = 1

" Disable whitespace-related warnings
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0

""" Configure VimWiki
let g:vimwiki_list = [{
            \'path': '~/doc/notes/vimwiki/index.wiki',
            \'syntax': 'markdown',
            \'ext': '.md'}]

""" Configure Polyglot
let g:polyglot_disabled = ['python']  " Use Semshi for python

""" Configure Airline
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

""" Configure Signature
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

""" Configure Illuminate
let g:Illuminate_delay = 50 " Shorter delay before highlighting

" Exclude certain files from being illuminated
let g:Illuminate_ftblacklist = ['nerdtree']
