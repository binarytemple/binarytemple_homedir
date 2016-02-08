set nocompatible
syntax on

call pathogen#infect() 

colorscheme koehler

filetype plugin indent on

"Start http://nvie.com/posts/how-i-boosted-my-vim

set hidden        " Hide buffers instead of closing them

set tabstop=2     " a tab is four spaces
set expandtab
set softtabstop=2

set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

"End http://nvie.com/posts/how-i-boosted-my-vim

"Start Nerdtree

 "Nerdtree config
 "How can I open a NERDTree automatically when vim starts up?
 
 "Stick this in your vimrc: 
 
 "autocmd vimenter * NERDTree
 "How can I open a NERDTree automatically when vim starts up if no files were specified?
 
 "A. Stick this in your vimrc 
" autocmd vimenter * if !argc() | NERDTree | endif

 "Q. How can I map a specific key or shortcut to open NERDTree?
 "A. Stick this in your vimrc to open NERDTree with Ctrl+n (you can set whatever key you want): 
map <F4> :NERDTreeToggle<CR>

  "Q. How can I close vim if the only window left open is a NERDTree?
  "A. Stick this in your vimrc:

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"End NERDTree 

"Start Number

map <F3> :set invnumber <CR>

"End Number 


" MyNext() and MyPrev(): Movement between tabs OR buffers
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext!"
    endif
endfunction

function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev!"
    endif
endfunction

"Buffer and Tab navigation with the letters 'H' and 'L'
nnoremap H :call MyPrev()<CR>
nnoremap L :call MyNext()<CR>

" Always jump to the last buffer position

autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif


" Show a nice status line, with column position
" set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
"
"
set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)
set laststatus=2

"Markdown headers
"
map h1 yypVr=
map h2 yypVr-

"Ensure md files are loaded as markdown
"
"au BufRead,BufNewFile *.md set filetype=markdown
