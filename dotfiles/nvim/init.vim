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
"       - gp: Select last paste
"   - Ctrl: Advanced editing
"       - hjkl: Navigate splits (normal mode)
"       - j/k: Jump to next/previous snippet section
"       - c: Toggle comment
"       - a: Code action (UI)
"       - s: Refactor action (UI)
"       - d: Open documentation
"       - e: Rename a symbol
"       - /: Multi-search the current word
"       - f: Auto-format a block of text
"       - =/+: Increment or decrement a number, swap True/False, +/-, ...
"       - Space: toggle a checkbox
"       - l (in insert mode): insert a unicode character with Latex
"   - Leader: UI actions
"       - c/v: Open a horizontal/vertical split
"       - q/l: Toggle the quickfix/loclist windows
"       - n: Toggle the graphical directory viewer (NERDTree)
"       - /: Fuzzy-search for a word in this directory
"       - f/F: Fuzzy-search for files/Git files
"       - b/B: Fuzzy-search for buffers/windows
"       - e: Diagnostics
"       - t: Toggle the tag viewer (Vista)
"       - g: Open the Git wrapper (Fugitive)
"       - h: Toggle the undo history viewer (Mundo)
"       - Enter: Paste selected text in another terminal (vim-slime)
"       - w: Wiki actions
"           - ww: Open the default wiki index
"           - ws: Select and open a wiki index
"           - wd: Delete the current wiki file
"           - wr: Rename the current wiki file
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
"
" Useful ex-mode commands:
"   - CocCommand: Access extra functionality of Coc
"   - Dispatch: Run a shell command asynchronously
"   - Rg: Ripgrep for a word through FZF


" Begin with tpope's vim-sensible (already run in neovim config)
runtime! plugin/sensible.vim

" Add ~/.vim as a source path
set runtimepath+=~/.vim,~/.vim/after,~/.vim/autoload

" Core modifications are in ~/.vim/vimrc
source ~/.vim/vimrc

" Tags are stored locally
set tags=./tags

" Set up python path
let g:python3_host_prog = "$XDG_DATA_HOME/pyenv/versions/tools/bin/python"

" Treat all tex files as latex
let g:tex_flavor = "latex"

" Escape exits insert mode in terminal
tnoremap <Esc> <C-\><C-n>

""" Aesthetics
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1 " Enable true-color support
set showmode! " Do not show current mode (overwrites vimrc default)
set signcolumn=yes " Keep sign column open
set shortmess+=c " Squash completion-menu echoes
set concealcursor= " Disable all conceals on the cursor line
colorscheme base16-gigavolt " Set colorscheme

""" Plugins
filetype off " Temporarily disable filetype plugins
call plug#begin(stdpath('data') . '/plugged')
    """ Editing
    Plug 'tpope/vim-sensible' " Sensible starting defaults
    Plug 'lambdalisue/suda.vim' " Read and write files with sudo
    Plug 'ntpeters/vim-better-whitespace' " Whitespace stripping on save
    Plug 'Raimondi/delimitMate' " Autocomplete parentheses, etc
    Plug 'tpope/vim-surround' " Edit surrounding pairs
    Plug 'tpope/vim-commentary' " ctrl-c to toggle comments
    Plug 'justinmk/vim-sneak' " Motion to jump to a location, bound to s
    Plug 'Konfekt/vim-CtrlXA' " Allow 'incrementing/decrementing' many things
    Plug 'joom/latex-unicoder.vim' " C-l in insert mode to type unicode via latex

    """ Text objects
    Plug 'wellle/targets.vim' " Seek to text objects for pairs and separators
    Plug 'michaeljsmith/vim-indent-object' " Text object i for indentation level
    Plug 'kana/vim-textobj-entire' " Text object E for the entire buffer
    Plug 'glts/vim-textobj-comment' " Text object c for comments

    """ Window and file management
    Plug 'drmingdrmer/vim-toggle-quickfix' " Toggle quickfix and loclist
    Plug 'qpkorr/vim-bufkill' " :BD to close a buffer without closing the split
    Plug 'preservim/nerdtree' " Directory browser
    Plug 'Xuyuanp/nerdtree-git-plugin' " Integrate git with NERDTree
    Plug 'junegunn/fzf' " Fuzzy-finder
    Plug 'junegunn/fzf.vim' " Integrates fzf with vim

    """ Tools
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " Undo history viewer
    Plug 'liuchengxu/vista.vim' " Tag viewer
    " Completion, language client, and intellisense engine
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets' " Builtin snippets
    Plug 'godlygeek/tabular' " Line up text with :Tabularize
    Plug 'vimwiki/vimwiki' " Markdown wiki links & todolists
    Plug 'jpalardy/vim-slime' " Run commands in a terminal

    """ Aesthetics
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
    Plug 'mhinz/vim-signify' " See git changes in gutter and statusline
    Plug 'kshenoy/vim-signature' " Display marks in gutter
    Plug 'nathanaelkane/vim-indent-guides' " Display indent levels
    Plug 'RRethy/vim-illuminate' " Highlight the word under the cursor
    Plug 'romainl/flattened' " Solarized colorscheme

    """ Plaintext and Markdown
    Plug 'vim-pandoc/vim-pandoc', {'for': ['markdown', 'pandoc', 'vim', 'vimwiki']} " Document converter
    Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown', 'pandoc', 'vim', 'vimwiki']} " Highlighting for Pandoc markdown
    Plug 'junegunn/goyo.vim', {'for': ['markdown', 'pandoc', 'vim', 'vimwiki']} " Distraction-free mode
    Plug 'junegunn/limelight.vim', {'for': ['markdown', 'pandoc', 'vim', 'vimwiki']} " Paragraph highlighting

    """ Python
    Plug 'numirias/semshi', {'for': 'python', 'do': ':UpdateRemotePlugins'} " Semantic syntax highlighting
    Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python', 'vim']} " Better indentation
    Plug 'jeetsukumaran/vim-pythonsense', {'for': ['python', 'vim']} " Text objects for classes (C), functions (f), and docstrings (d)

    """ C & C++
    Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp', 'cuda']}

    """ Latex
    Plug 'lervag/vimtex', {'for': 'tex'}

    """ Completion sources
    Plug 'Shougo/neco-vim' " Vimscript
    Plug 'neoclide/coc-neco' " Integrate neco with coc

    """ Dependencies
    Plug 'tpope/vim-repeat' " Enables repeating certain plugins with .
    Plug 'kana/vim-textobj-user' " Support for custom text objects
    Plug 'tpope/vim-dispatch' " Async dispatch commands
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

" =/+ increment / decrement numbers and other recognized objects
nnoremap <silent><expr> = CtrlXA#SingleInc("\<C-A>")
nnoremap <silent><expr> + CtrlXA#SingleInc("\<C-X>")

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

" <leader>e opens a list of all diagnostics
nmap <silent> <leader>e :CocDiagnostics<CR>

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
" <leader>/ searches for words with ripgrep
nnoremap <leader>/ :Rg<CR>

" <leader>t toggles Vista (a tag browser)
nnoremap <silent> <leader>t :Vista!!<CR>

" <leader>g toggles Git
nnoremap <silent> <leader>g :Git<CR>

" <leader>h toggle Mundo (undo history viewer)
nnoremap <silent> <leader>h :MundoToggle<CR>

" Disable bufkill and Dispatch mappings
let g:BufKillCreateMappings = 0
let g:dispatch_no_maps = 1

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

" <C-s> performs arbitrary refactor actions
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

" <C-e> renames a symbol
nmap <C-e> <Plug>(coc-rename)

" <C-d> shows documentation in a preview window
" From: https://github.com/neoclide/coc.nvim
nnoremap <silent> <C-d> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Introduce function text object
" From: https://github.com/neoclide/coc.nvim
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

""" Configure suda
let g:suda_smart_edit = 1 " Allow automatically opening files with sudo

""" Configure better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave " Strip whitespace on save
autocmd BufEnter * DisableWhitespace " Disable whitespace highlighting
let g:strip_whitespace_confirm = 0 " Do not ask before stripping whitespace
let g:show_spaces_that_precede_tabs = 1 " Show spaces around tabs
let g:strip_whitelines_at_eof = 1 " Strip end-of-file whitespace

""" Configure sneak
let g:sneak#label = 1 " Label mode assigns a label to each match
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

" Ignore some files
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]']

" Move bookmarks to XDG_DATA_HOME
let NERDTreeBookmarksFile = "~/.local/share/NERDTreeBookmarks"

" Set up Git symbols
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" Use a floating window
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7}}

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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --ignore-file ~/.config/ignore'

""" Configure Signify
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'

""" Configure Vista
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60

""" Configure Coc
" Tab (S-Tab) tries to select the next (previous) completion item if possible,
" and otherwise inserts a regular tab.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ "\<Tab>"

inoremap <silent><expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ "\<S-Tab>"

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

" <CR> confirms the selected completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Coc colors
highlight CocErrorSign      guifg=#ff661a
highlight CocWarningSign    guifg=#ffdc2d
highlight CocInfoSign       guifg=#f2e6a9
highlight CocHintSign       guifg=#40bfff

""" Configure Airline
let g:airline_powerline_fonts = 1 " Preload powerline fonts
set laststatus=2 " Always show statusline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#wordcount#filetypes = ['txt', 'md']
let g:airline#extensions#wordcount#filetypes =
    \   '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail|vimwiki|pandoc'
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


""" Configure indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'vimwiki', 'fzf']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2d303d
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#2d303d

""" Configure vimwiki
" Use a markdown wiki that automatically updates tags and links
let g:vimwiki_list = [{'path': '~/media/documents/vimwiki/',
            \           'syntax': 'markdown',
            \           'ext': '.md',
            \           'auto_tags': 1,
            \           'auto_generate_tags': 1,
            \           'auto_generate_links': 1,
            \           'links_space_char': '-'}]
let g:vimwiki_filetypes = ['markdown', 'pandoc'] " Pandoc compatibility

" Configure styles for auto-generated headers
let g:vimwiki_markdown_header_style = 0
let g:vimwiki_tags_header = 'All Tags'
let g:vimwiki_tags_header_level = 2
let g:vimwiki_links_header = 'All Links'
let g:vimwiki_links_header_level = 2
let g:vimwiki_key_mappings = {'table_mappings': 0} " Keep tab mapping

""" Configure unicoder
" Cancel default mappings
let g:unicoder_no_map = 1
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1

" Bind <C-l> to unicoder in insert mode
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>

""" Configure vim-slime
let g:slime_target = "kitty"
let g:slime_no_mappings = 1
let g:slime_default_config = {"window_id": ""}
xmap <silent> <leader><CR> <Plug>SlimeRegionSend
nmap <silent> <leader><CR> <Plug>SlimeParagraphSend

function SlimeOverrideSend(config, text)
    call system("kitty @ --to $KITTY_LISTEN_ON send-text --match id:"
                \ . shellescape(a:config["window_id"]) . " " . shellescape(a:text))
endfunction
