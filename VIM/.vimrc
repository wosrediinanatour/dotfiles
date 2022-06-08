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


" Statusline
set statusline=[%n]\ %<%F\ \ \ [%M%R%H%W%Y,%{&ff}]\ \ %=\ %l,%c\ \ \ %p%%\ \ \ 
set laststatus=2 " Always show the status line

"
" Plugins
"
call plug#begin('~/.vim/plugged')

" Syntax highlighting
"

Plug 'aklt/plantuml-syntax'

Plug 'bfrg/vim-cpp-modern'
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

"  ALE as linter (for Markdown install Pandoc) an language client (for C/C++ install CCLS)

Plug 'dense-analysis/ale'
let g:ale_c_build_dir = getcwd()."/build/"
let g:ale_linters = {'c': ['ccls'], 'cpp': ['ccls']}
let g:ale_cpp_cc_options = '-std=c++20 -Wall'

" https://github.com/MaskRay/ccls/wiki/Customization
" 
" Path problem: compile_commands.json generated in container, compiler and include files at the host
"
" Solution: configuration of CCLS
"
" - pathMappings are for mapping folders between container and host.
" - Note that we have also to consider clang's parameter '--gcc-toolchain'.
" - Since host uses a different C++ version, resourceDir has to be set to the host's include directory.
" - If you encounter errors, you have to enable logging of CCLS in VIM-ALE:
"    - ~/.vim/plugged/ale/ale_linters/cpp/ccls.vim:12 Add ' --log-file=/tmp/ccls.log -v=1' after %e  
"    - If you see errors in /tmp/ccls.log that a header is not found: install it on the host (e.g. openssl-devel for ssl.h)
"
let g:ale_cpp_ccls_init_options = {"cacheFormat": "json", "clang": {"resourceDir": "/usr/lib64/clang/13.0.0", "pathMappings": ["/repository/>".getcwd()."/", "/opt/rh/gcc-toolset-10/root>"], "clang.extraArgs": ["--gcc-toolchain=/opt/rh/gcc-toolset-10/root/usr"]}, "compilationDatabaseDirectory": getcwd()."/build/", "index": {"multiVersion": 1}}
let g:ale_fixers = {
         \   'cpp': ['clang-format'],
         \}
let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 1
let g:ale_virtualtext_cursor = 1
nn <silent> gd :ALEGoToDefinition<cr>
nn <silent> gt :ALEGoToTypeDefinition<cr>
nn <silent> gr :ALEFindReferences -relative -quickfix<cr>
nn <silent> gs :ALESymbolSearch -relative <query><cr>
nn <silent> gh :ALEHover<cr>
" Show the full linter message for the problem nearest to the cursor on the
" given line in the preview window.
nn <silent> ge :ALEDetail<cr>

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return printf(
     \   'W%d E%d',
     \   all_non_errors,
     \   all_errors
     \)
endfunction
set statusline+=%{LinterStatus()}\ 

" Support for .editorconfig 

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" CLAP: search for almost everything - buffers, files, regex in files, marks,...

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
let g:clap_theme = 'material_design_dark'
let g:clap_layout = { 'relative': 'editor' }
nmap <Leader>f :Clap gfiles<CR>
nmap <Leader>F :Clap files<CR>
nmap <Leader>b :Clap buffers<CR>
nmap <Leader>h :Clap history<CR>
nmap <Leader>' :Clap marks<CR>
nmap <Leader>H :Clap help_tags<CR>
nmap <Leader>c :Clap commits<CR>
nmap <Leader>gg :Clap grep2<CR>
nmap <Leader>gw :Clap grep2 ++query=<cword><CR>
nmap <Leader>r :Clap recent_files<CR>

" GITGUTTER: show git diff in the sign column

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
function! GitStatus()
   let [a,m,r] = GitGutterGetHunkSummary()
   return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" FUGITIVE: wrapper for GIT, i.e. use :Git

Plug 'tpope/vim-fugitive'
" Show commits for every source line
nnoremap <Leader>gbl :Git blame<CR>  " git blame

" Add plugins to &runtimepath
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""

" Highlight syntax inside Markdown
let g:markdown_fenced_languages = ['html', 'css', 'python', 'ruby', 'vim', 'bash=sh', 'sh', 'c', 'cpp', 'json=javascript', 'xml', 'javascript', 'plantuml']


" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Turn on the Wild menu
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
set updatetime=100

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

colorscheme gruvbox
set bg=dark


