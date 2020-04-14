""" Main Neovim configuration.
" This config aims to use Neovim as a text editor that appropriately scales in
" complexity from a simple text editor to a full-fledged IDE while still
" loading and editing fast.
"
" Mapping groups:
"   - Unmodified: Motions and basic editing
"       - n/N: Modifies a pair text object to select next/previous
"       - s/S: Sneak forward/backward
"   - g: Jumps
"       - gd: Jump to definition
"       - gD: Jump to declaration
"       - gi: Jump to implementation
"       - gt: Jump to type definition
"       - gr: Jump to references (UI)
"   - Ctrl: Advanced editing
"       - hjkl: Navigate splits
"       - c: Toggle comment
"       - a: Code action (UI)
"       - s: Refactor action (UI)
"       - e: Rename a symbol
"       - /: Multi-search the current word
"       - f: Auto-format a block of text
"   - Leader: UI actions
"       - c/v: Open a horizontal/vertical split
"       - q/l: Toggle the quickfix/loclist windows
"       - n: Toggle the graphical directory viewer (NERDTree)
"       - f/F: Fuzzy-search for files/Git files
"       - b/B: Fuzzy-search for buffers/windows
"       - t: Toggle the tag viewer (Vista)
"       - g: Open the Git wrapper (Fugitive)
"       - h: Toggle the undo history viewer (Mundo)
"   - Brackets: paired movement
"       - ]b and [b: Switch to next/previous buffer
"       - ]e and [e: Jump to next/previous error or warning
"       - ]E and [E: Jump to next/previous error
"
" Text objects:
"   - E: Entire buffer
"   - c: Comments
"   - f: Functions
"   - In Python:
"       - d: docstrings
"       - C: classes
"   - n/N: Modifies a pair text object to select next/previous
"   - Vim-surround enables modifying surrounding pairs


" Begin with tpope's vim-sensible (already run in neovim config)
runtime! plugin/sensible.vim

" Add ~/.vim as a source path
set runtimepath+=~/.vim,~/.vim/after,~/.vim/autoload

" Core modifications are in ~/.vimrc
source ~/.vimrc

" Tags are stored locally
set tags=./tags

" Treat all tex files as latex
let g:tex_flavor = "latex"

" Escape exits insert mode in terminal
tnoremap <Esc> <C-\><C-n>

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
    Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'} " Directory browser
    Plug 'Xuyuanp/nerdtree-git-plugin' " Integrate git with NERDTree
    Plug 'junegunn/fzf' " Fuzzy-finder
    Plug 'junegunn/fzf.vim' " Integrates fzf with vim

    " Tools
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " Undo history viewer
    Plug 'liuchengxu/vista.vim' " Tag viewer
    Plug 'vimwiki/vimwiki' " Personal wiki
    " Completion, language client, and intellisense engine
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets' " Builtin snippets

    " Aesthetics
    Plug 'sheerun/vim-polyglot' " Language pack
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
    Plug 'mhinz/vim-signify' " See git changes in gutter and statusline
    Plug 'kshenoy/vim-signature' " Display marks in gutter
    Plug 'Yggdroot/indentLine' " See indentation levels
    Plug 'RRethy/vim-illuminate' " Highlight the word under the cursor

    " Python
    " Semantic syntax highlighting
    Plug 'numirias/semshi', {'for': 'python', 'do': ':UpdateRemotePlugins'}
    " Better indentation
    Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
    " Text objects for classes (C), functions (f), and docstrings (d)
    Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python'}

    " Latex
    Plug 'lervag/vimtex', {'for': 'tex'}

    " Completion sources
    Plug 'Shougo/neco-vim'  " Vimscript
    Plug 'neoclide/coc-neco' " Integrate neco with coc

    " Dependencies
    Plug 'tpope/vim-repeat' " Enables repeating certain plugins with .
    Plug 'kana/vim-textobj-user' " Support for custom text objects
call plug#end()
filetype plugin indent on " Enable filetype plugins and indent files

""" Mappings (movement and editing)
let g:targets_nl = 'nN' " Select next pair text object with n and last with N

" Toggle commenting with <C-c>
xmap <silent> <C-c> <Plug>Commentary
omap <silent> <C-c> <Plug>Commentary
" In normal mode, <C-c> toggles comments as an action
nmap <silent> <C-c> <Plug>Commentary
" <C-c><C-c> and <C-c>c toggle comments on this line
nmap <silent> <C-c><C-c> <Plug>CommentaryLine
nmap <silent> <C-c>c <Plug>CommentaryLine

""" Mappings (UI)
" ]b and [b move to next and previous buffers
noremap <silent> ]b :bn<CR>
noremap <silent> [b :bp<CR>

" <leader>c splits horizontally
noremap <silent> <leader>c :sp<CR>
" <leader>v splits vertically
noremap <silent> <leader>v :vsp<CR>

" <leader>q toggles quickfix
noremap <silent> <leader>q :call togglequickfix#ToggleQuickfix()<CR>
" <leader>l toggles loclist
noremap <silent> <leader>l :call togglequickfix#ToggleLocation()<CR>

" <leader>n opens or closes NERDTree
noremap <silent> <leader>n :NERDTreeToggle<CR>

" fzf (fuzzy-finding)
" <leader>f searches all files
nnoremap <leader>f :Files<CR>
" <leader>F searches all Git files
nnoremap <leader>F :GFiles<CR>
" <leader>b searches all buffers
nnoremap <leader>b :Buffers<CR>
" <leader>B searches all windows
nnoremap <leader>B :Windows<CR>

" <leader>t toggles Vista (a tag browser)
nnoremap <silent> <leader>t :Vista!!<CR>

" <leader>g toggles Git
nnoremap <silent> <leader>g :Git<CR>

" <leader>h toggle Mundo (undo history viewer)
nnoremap <silent> <leader>h :MundoToggle<CR>

" Disable bufkill mappings
let g:BufKillCreateMappings = 0

""" Mappings (advanced editing)
" ]e and [e navigate next/previous errors and warnings
nmap <silent> ]e <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-prev)

" ]E and [E navigate next/previous errors only
nmap <silent> ]E <Plug>(coc-diagnostic-next-error)
nmap <silent> [E <Plug>(coc-diagnostic-prev-error)

" <C-a> performs arbitrary code actions
nmap <C-a> <Plug>(coc-codeaction)
vmap <C-a> <Plug>(coc-codeaction-selected)

" <C-s> performs arbitrary refactor actions (currently broken)
nmap <C-s> <Plug>(coc-refactor)

" <C-/> performs a multi-search on the current word
nmap <silent> <C-_> :CocCommand document.renameCurrentWord<CR>

" Jumps:
"   - gd -> definition
"   - gD -> declaration
"   - gi -> implementation
"   - gt -> type definition
"   - gr -> references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" <C-f> formats a block of text, and <C-f><C-f> formats the whole buffer
nmap <silent> <C-f> <Plug>(coc-format-selected)
vmap <silent> <C-f> <Plug>(coc-format-selected)
nmap <silent> <C-f><C-f> <Plug>(coc-format)

" <C-e> renames a symbol (currently broken)
nmap <C-e> <Plug>(coc-rename)

""" Configure suda
let g:suda_smart_edit = 1  " Allow automatically opening files with sudo

""" Configure better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave  " Strip whitespace on save
autocmd BufEnter * DisableWhitespace " Disable whitespace highlighting
let g:strip_whitespace_confirm = 0 " Do not ask before stripping whitespace
let g:show_spaces_that_precede_tabs = 1 " Show spaces around tabs
let g:strip_whitelines_at_eof = 1  " Strip end-of-file whitespace

""" Configure sneak
let g:sneak#label = 1  " Label mode assigns a label to each match
highlight Sneak guifg=red guibg=none ctermfg=red ctermbg=none

""" Rebind textobj-entire to use capital E
let g:textobj_entire_no_default_key_mappings = 1
xmap aE <Plug>(textobj-entire-a)
omap aE <Plug>(textobj-entire-a)
xmap iE <Plug>(textobj-entire-i)
omap iE <Plug>(textobj-entire-i)

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

""" Configure FZF
" Escape cancels FZF
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Set up colors
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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

""" Configure Signify
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'

""" Configure Vista
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60

""" Configure VimWiki
let g:vimwiki_list = [{
            \'path': '~/doc/notes/vimwiki/index.wiki',
            \'syntax': 'markdown',
            \'ext': '.md'}]

""" Configure Coc
" Completion:
" Tab tries to do the following things, in order:
"   - Select the first completion suggestion
"   - Jump to the next snippet block
"   - Act as a regular tab
" Shift-tab does the first two, navigating backwards.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<S-Tab>" :
      \ coc#refresh()

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" <CR> confirms the selected completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Coc colors
highlight CocErrorSign      guifg=#ff661a
highlight CocWarningSign    guifg=#ffdc2d
highlight CocInfoSign       guifg=#f2e6a9
highlight CocHintSign       guifg=#40bfff

""" Remove from Polyglot any language we have a dedicated config for
let g:polyglot_disabled = ['python', 'latex']

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
