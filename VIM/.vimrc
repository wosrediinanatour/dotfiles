"
" Copyright (c) 2019 Florian Xaver
"
" MIT License: see File LICENSE
"

if has('vim_starting')
   if &compatible
      set nocompatible               " Be iMproved
   endif
endif

" Required:
call plug#begin('~/.vim/plugged')

" Wimwiki: \ww for Wiki site. Enter on a word makes a link,
" double enter on a link creates a new page if necessary.
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"Plug 'ervandew/supertab'
" Colorful editor
"Plug 'itchyny/landscape.vim' 
" Plug 'jtratner/vim-flavored-markdown'

"
"  ALE and ccls
"

Plug 'dense-analysis/ale'
let g:ale_cpp_ccls_init_options = {
         \   'cache': {
         \       'directory': '/tmp/ccls/cache'
         \   }
         \ }
"let g:ale_linters = {'cpp': ['ccls']}
"let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 1
nn <silent> gd :ALEGoToDefinition<cr>
nn <silent> gt :ALEGoToTypeDefinition<cr>
nn <silent> gr :ALEFindReferences -relative<cr>
nn <silent> gs :ALESymbolSearch -relative <query><cr>
nn <silent> gh :ALEHover<cr>
" Show the full linter message for the problem nearest to the cursor on the
" given line in the preview window.
nn <silent> ge :ALEDetail<cr>

"
" FZF
"
"

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nmap <c-p> :FZF<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>H :Helptags!<CR>

"
" GIT plugins
"

Plug 'airblade/vim-gitgutter'
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk)  " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)   " git undo (chunk)

Plug 'jreybert/vimagit'
" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status
" Push to remote
nnoremap <leader>gP :! git push<CR>  " git Push
" Enable deletion of untracked files in Magit
let g:magit_discard_untracked_do_delete=1

Plug 'sodapopcan/vim-twiggy'
nnoremap <Leader>gbr :Twiggy<CR>  " git branches
Plug 'tpope/vim-fugitive'
" Show commits for every source line
nnoremap <Leader>gbl :Gblame<CR>  " git blame
" GIT commit browser
Plug 'junegunn/gv.vim'
nnoremap <Leader>gc :GV!<CR>  " git browse commits

"
" Lightline: Following code is from https://github.com/itchyny/lightline.vim 
"
"

Plug 'itchyny/lightline.vim'

let g:lightline = {
         \ 'colorscheme': 'landscape',
         \ 'active': {
         \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ],  
         \             [ 'cocstatus', 'currentfunction', 'readonly', 'modified' ] ],
         \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
         \ },
         \ 'component_function': {
         \   'fugitive': 'LightLineFugitive',
         \   'filename': 'LightLineFilename',
         \   'fileformat': 'LightLineFileformat',
         \   'filetype': 'LightLineFiletype',
         \   'fileencoding': 'LightLineFileencoding',
         \   'mode': 'LightLineMode',
         \   'cocstatus': 'coc#status',
         \   'currentfunction': 'CocCurrentFunction'
         \ },
         \ 'subseparator': { 'left': '|', 'right': '|' }
         \ }

function! CocCurrentFunction()
       return get(b:, 'coc_current_function', '')
endfunction

function! LightLineModified()
   return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
   return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
   let fname = expand('%:t')
   return fname == '__Tagbar__' ? g:lightline.fname :
            \ fname =~ '__Gundo\|NERD_tree' ? '' :
            \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
            \ &ft == 'unite' ? unite#get_status_string() :
            \ &ft == 'vimshell' ? vimshell#get_status_string() :
            \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ ('' != fname ? fname : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
   try
      if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
         let mark = ''  " edit here for cool mark
         let _ = fugitive#head()
         return strlen(_) ? mark._ : ''
      endif
   catch
   endtry
   return ''
endfunction

function! LightLineFileformat()
   return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
   return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
   return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
   let fname = expand('%:t')
   return fname == '__Tagbar__' ? 'Tagbar' :
            \ fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ fname =~ 'NERD_tree' ? 'NERDTree' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ &ft == 'vimshell' ? 'VimShell' :
            \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
   let g:lightline.fname = a:fname
   return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Add plugins to &runtimepath
call plug#end()



" Always show the status line
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Turn on the WiLd menu
set wildmenu


" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

set ignorecase
" ignorecase + smartcase: If a pattern contains an uppercase letter, it is
" case sensitive, otherwise, it is not.  
set smartcase
set smarttab
set expandtab
set tabstop=3
set shiftwidth=3

" Linebreak on 500 characters
set lbr
set tw=500

set cino={1s,}0s "indent of C/C++'s braces

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""" set t_Co=256
"" colorscheme landscape
"" colorscheme pablo

try
   colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
   set guioptions-=T
   set guioptions-=e
   set t_Co=256
   set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Force all *.md files to be markdown files.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Switch buffer without saving
set hidden

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
" set mouse=a

" make Vim show the absolute number for the current line, and relative numbers for other lines.
set number
set relativenumber
set ruler

" Update sign column every quarter second
set updatetime=250

" Vimdiff: ignore white spaces
set diffopt+=iwhite
set diffexpr=""

" Use RIPGREP as grep program
if executable('rg')
   set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
   let g:rg_derive_root='true'
endif

" Set language
set spell spelllang=en_us
set nospell

