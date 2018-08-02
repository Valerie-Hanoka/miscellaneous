"

" ------------------------- "
"        Functions
" ------------------------- "
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" ---------------------------------- "
"         Nothing but UTF-8
" ---------------------------------- "
set encoding=utf-8  " The encoding displayed
set fileencoding=utf-8  " The encoding written to file

" ---------------------------------- "
"             Pathogen
"https://github.com/tpope/vim-pathogen
" ---------------------------------- "
execute pathogen#infect()
execute pathogen#helptags()

" Being PEP8 compliant
let g:syntastic_python_checkers = ['pylint', 'perl']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
let g:syntastic_enable_perl_checker = 1

" Indent Guides Settings

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1

" ---------------------------------- "
"   Appearance & Syntax highlighting
" ---------------------------------- "
set t_Co=256         " force 256 colors on the terminal
if has('autocmd')
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
endif

" Custom color schemes must be placed in .vim/colors
colorscheme torte

syntax on          " activate syntaxic coloration
set cursorline
" highlight current line by changing background color
highlight CursorLine cterm=NONE ctermbg=234 ctermfg=NONE

" ---------------------------------- "
"         Basic Behaviour
" ---------------------------------- "

" Spaces, tabs, indentation...
set backspace=indent,eol,start " allow backspace in insert mode
set autoindent    " text indenting
set smartindent   " text indenting bis
set tabstop=4     " number of spaces in a tab
set softtabstop=4 " as above
set shiftwidth=4  " as above

if has('autocmd')
	" enable loading the indent file for specific file types
	filetype plugin indent on
	autocmd Filetype python setlocal expandtab
	autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

" Line lenght visual aid (PEP-8 recommandation)
if exists('+colorcolumn')
	set colorcolumn=80
	highlight ColorColumn ctermbg=234
else
	highlight OverLength ctermbg=234 ctermfg=139 guibg=34
	match OverLength /\%>80v.\+/
endif

set list  " shows tabs, trails, end of line...
set listchars=eol:⁖,tab:‣ ,trail:»,extends:↷,precedes:↶

" Search
set hlsearch
" highlight searched-for phrases
set incsearch       " highlight search as you type
set number          " show line numbers
set showmatch       " highlight matching [{()}]
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


" Other behaviours
set mouse=v         " enable the use of the mouse
set history=100     " lines of command history
set undolevels=500  " undo history
set showcmd         " show incomplete commands
set tabpagemax=15

" have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" ---------------------------------- "
"         NERDTREE #TODO
"https://github.com/scrooloose/nerdtree
" ---------------------------------- "

" ---------------------------------- "
"                XML
" ---------------------------------- "
if has("autocmd")
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
endif
" TODO

" ---------------------------------- "
"              LaTex
" ---------------------------------- "
" TODO
"
" ---------------------------------- "
"            Shortcuts
" ---------------------------------- "
" JSON formating
nmap ; :%!python -m json.tool<CR>

" Goto definition with F3
map <F3> :YcmCompleter GoTo<CR>

nmap <silent> ,/ :nohlsearch<CR>

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "
"
" Let YCM read tags from Ctags file
let g:ycm_collect_identifiers_from_tags_files = 1
" Default 1, just ensure
let g:ycm_use_ultisnips_completer = 1
" Completion for programming language's keyword
let g:ycm_seed_identifiers_with_syntax = 1
" Completion in comments
let g:ycm_complete_in_comments = 1
" Completion in string
let g:ycm_complete_in_strings = 1

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

