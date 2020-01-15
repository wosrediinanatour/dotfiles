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
" COC
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


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

"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
" enable gtags module
"let g:gutentags_modules = ['ctags', 'gtags_cscope']
" config project root markers.
"let g:gutentags_project_root = ['.root']
" generate datebases in my cache directory, prevent gtags files polluting my project
"let g:gutentags_cache_dir = expand('~/.cache/tags')
" change focus to quickfix window after search (optional).
"let g:gutentags_plus_switch = 1

"Plug 'wellle/tmux-complete.vim' " <C-X><C-U>

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

" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>


" Lightline: Following code is from https://github.com/itchyny/lightline.vim 

Plug 'itchyny/lightline.vim'

let g:lightline = {
         \ 'colorscheme': 'landscape',
         \ 'active': {
         \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
         \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
         \ },
         \ 'component_function': {
         \   'fugitive': 'LightLineFugitive',
         \   'filename': 'LightLineFilename',
         \   'fileformat': 'LightLineFileformat',
         \   'filetype': 'LightLineFiletype',
         \   'fileencoding': 'LightLineFileencoding',
         \   'mode': 'LightLineMode',
         \   'ctrlpmark': 'CtrlPMark',
         \ },
         \ 'subseparator': { 'left': '|', 'right': '|' }
         \ }

function! LightLineModified()
   return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
   return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
   let fname = expand('%:t')
   return fname == 'ControlP' ? g:lightline.ctrlp_item :
            \ fname == '__Tagbar__' ? g:lightline.fname :
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
            \ fname == 'ControlP' ? 'CtrlP' :
            \ fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ fname =~ 'NERD_tree' ? 'NERDTree' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ &ft == 'vimshell' ? 'VimShell' :
            \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
   if expand('%:t') =~ 'ControlP'
      call lightline#link('iR'[g:lightline.ctrlp_regex])
      return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
               \ , g:lightline.ctrlp_next], 0)
   else
      return ''
   endif
endfunction

let g:ctrlp_status_func = {
         \ 'main': 'CtrlPStatusFunc_1',
         \ 'prog': 'CtrlPStatusFunc_2',
         \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
   let g:lightline.ctrlp_regex = a:regex
   let g:lightline.ctrlp_prev = a:prev
   let g:lightline.ctrlp_item = a:item
   let g:lightline.ctrlp_next = a:next
   return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
   return lightline#statusline(0)
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

nmap <F5> :execute "vimgrep /" . expand("<cword>") . "/j ./**/*.cpp ./**/*.h" <Bar> cw <CR>

nmap <F6> :execute "vimgrep /" . expand("<cword>") . "/j ~/Sources/officialSystemPlatform/Callisto_Evo_15_2_21_sipif_updated/**/*.cpp ~/Sources/officialSystemPlatform/Callisto_Evo_15_2_21_sipif_updated/**/*.h ~/Sources/officialSystemPlatform/Callisto_Evo_15_2_21_sipif_updated/**/*.c" <Bar> cw <CR>

nmap <F7> :TagbarToggle<CR>

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


