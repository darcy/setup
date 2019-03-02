set encoding=utf8
set shell=/bin/zsh
call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rails'
"Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-jdaddy'
Plug 'tomlion/vim-solidity'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
" Plug 'fsharpasharp/vim-dirvinist'
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'rking/ag.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'pangloss/vim-javascript'
"Plug 'neoclide/vim-jsx-improve'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'jreybert/vimagit'
Plug 'exu/pgsql.vim'
"Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tomtom/tcomment_vim'

" colorschemes
Plug 'mhartington/oceanic-next'
Plug 'mhinz/vim-janah'
Plug 'w0ng/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jnurmine/Zenburn'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install tern' }
"Plug 'Valloric/MatchTagAlways'
"
call plug#end()

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Let <Tab> also do completion
" inoremap <silent><expr> <Tab>  pumvisible() ? "\<C-n>" :  deoplete#mappings#manual_complete()

let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete

" configure syntastic syntax checking to check on open as well as save
"let g:syntastic_check_on_open=1
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
"let g:syntastic_eruby_ruby_quiet_messages =
"    \ {"regex": "possibly useless use of a variable in void context"}
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']


" Theme
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if has("termguicolors")
  set termguicolors
endif

set cursorline
"janah
  autocmd ColorScheme janah highlight Normal ctermbg=150
  set background=dark
  colorscheme OceanicNext
  colorscheme janah
  " highlight DiffDelete guifg=#ec5f67 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  " highlight DiffAdd guifg=#87ff5f ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  " highlight DiffChange guifg=#65737e ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  " highlight DiffText guifg=#6699cc ctermfg=68 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

"
" oceanic
"
" hybrid
  " let g:hybrid_custom_term_colors = 1
"   let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"  set background=dark
"  colorscheme hybrid
"
" onedark
"  set background=dark
"  colorscheme onedark


" " dracula
" colors dracula

" zenburn
" colors zenburn


let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
" colorscheme onedark
" " hi Normal ctermbg=none
" let g:airline_theme='onedark'
" " following is a workaround fix for airline bgterm issue
" autocmd VimEnter * hi Normal ctermbg=none
" " let g:airline_theme='sol'
"
  set clipboard+=unnamedplus
" Currently needed for neovim paste issue
  set pastetoggle=<f6>
  set nopaste
" Let airline tell me my status
  set noshowmode
  filetype on
  "set relativenumber number
  set number
  set numberwidth=3
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
" block select not limited by shortest line
  set virtualedit=
  set wildmenu
  set laststatus=2
  "set colorcolumn=100
  set wrap linebreak nolist
  set wildmode=full
  let mapleader = ','
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"
" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") && &filetype != "gitcommit" |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files
  autocmd BufRead * normal zz

" No need for ex mode
  nnoremap Q <nop>
" recording macros is not my thing
  map q <Nop>

nnoremap ; :

" Copy to osx clipboard
  " vnoremap <C-c> "*y<CR>
  " vnoremap y "*y<CR>
  " nnoremap Y "*Y<CR>
  " let g:multi_cursor_next_key='<c-n>'
  " let g:multi_cursor_prev_key='<c-p>'
  " let g:multi_cursor_skip_key='<c-x>'
  " let g:multi_cursor_quit_key='<esc>'

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  map <esc> :noh<cr>

" turn on spelling for markdown files
autocmd FileType markdown,text,html setlocal spell complete+=kspell
" highlight bad words in red
autocmd FileType markdown,text,html hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224

" " NERDTree --------------------------------------------
" "
" "autocmd StdinReadPre * let s:std_in=1
""  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" map <C-\> :NERDTreeToggle<CR>
" map <S-\> :NERDTreeToggle<CR>
" let g:nerdtree_tabs_autoclose=0
" " with NERDTree don't close all buffers
" " http://stackoverflow.com/questions/31805805/vim-close-buffer-with-nerdtree
" " nnoremap c :bp\|bd #<CR>
" " shift-w to close current buffer
" " nmap <S-w> :bd<CR>
" " nmap <S-w> :bp\|bd #<CR>
" " close NERDtree if last thing open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeAutoDeleteBuffer=1
"   " NERDTress File highlighting
"   function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"   exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"   exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"   endfunction
" " let NERDTreeShowHidden=1
"   call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
"   call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
"   call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('yml', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('erb', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('rb', 'green', 'none', '#94B9A0', 'none')
"   call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
"   call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
"   call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
"   call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
"   call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', 'none')
"   call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
"   call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
"   call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')

"}}}

" Trigger filesystem notifications so guard picks up
" set noswapfile

" nmap <A-w> :bp\|bd #<CR>
nmap <expr> <silent> <C-w> len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1 ? ':bd<CR>' : ':bp<CR>:bd #<CR>'


" move tabs to the end for new, single buffers (exclude splits)
" autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

" trim whitespace on close for filetypes
"autocmd FileType rb,js,erb,html,css autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd BufWritePre * :%s/\s\+$//e

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Devicons https://github.com/ryanoasis/vim-devicons
let g:airline_powerline_fonts = 1
set guifont=Inconsolata\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11

" Y should yank to end of line
nmap Y y$

" don't force saving a file to change buffers
set hidden

"ctrl-space
"set nocompatible
" set showtabline=0
" if has("gui_running")
"     " Settings for MacVim and Inconsolata font
"     let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
" endif
" if executable("ag")
"     let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
" endif
" hi link CtrlSpaceNormal   PMenu
" hi link CtrlSpaceSelected PMenuSel
" hi link CtrlSpaceSearch   Search
" hi link CtrlSpaceStatus   StatusLine
" nnoremap <silent><C-p> :CtrlSpace O<CR>
" let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
" let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
" let g:CtrlSpaceSaveWorkspaceOnExit = 1
"
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = "ag --nogroup --column"

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --ignore .git --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" FZF ----------------------------
 map <c-p> :FZF<CR>
 tmap <c-p> <c-\><c-n>:FZF<CR>
 map <leader>a :Ag<CR>
 vmap <leader>aw y:Ag <C-r>0<CR>
 map <leader>h :History<CR>
 map <leader>l :Lines<CR>
 map <leader>m :MagitOnly<CR>

" Terminal -----------------------
" :tnoremap <Esc> <C-\><C-n> - this jacks with fzf closing window
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:tnoremap <A-Left> <C-\><C-n><C-w>h
:tnoremap <A-Down> <C-\><C-n><C-w>j
:tnoremap <A-Up> <C-\><C-n><C-w>k
:tnoremap <A-Right> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
:nnoremap <A-Up> <C-w>k
:nnoremap <A-Down> <C-w>j
:nnoremap <D-Left> <C-w>h
:nnoremap <D-Right> <C-w>l
:nnoremap <A-Left> <C-w>h
:nnoremap <A-Right> <C-w>l
:nmap <A-Left> :bprev<CR>
:nmap <A-Right> :bnext<CR>
:nmap <A-h> :bprev<CR>
:nmap <A-l> :bnext<CR>
:nmap <D-Left> :bprev<CR>
:nmap <D-Right> :bnext<CR>

:map <C-h> <C-w>h
:map <C-j> <C-w>j
:map <C-k> <C-w>k
:map <C-l> <C-w>l

" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>
"
" fugitive git bindings
set diffopt=filler,vertical
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gb :Gblame<CR>
"nnoremap <leader>ga :Git add %:p<CR><CR>
"nnoremap <leader>gs :Gstatus<CR>
"nnoremap <leader>gc :Gcommit -v -q<CR>
"nnoremap <leader>gt :Gcommit -v -q %:p<CR>
"nnoremap <leader>gd :Gdiff<CR>
"nnoremap <leader>ge :Gedit<CR>
"nnoremap <leader>gr :Gread<CR>
"nnoremap <leader>gw :Gwrite<CR><CR>
"nnoremap <leader>gp :Ggrep<Space>
"nnoremap <leader>gm :Gmove<Space>
"nnoremap <leader>gb :Git branch<Space>
"nnoremap <leader>go :Git checkout<Space>
"nnoremap <leader>gps :Dispatch! git push<CR>
"nnoremap <leader>gpl :Dispatch! git pull<CR>

let g:fzf_action = {
  \ 'ctrl-v': 'vsplit' }

let g:loaded_netrwPlugin = 1

hi DirvishGitModified guifg=#A3BE8C
hi DirvishGitUntracked guifg=#A4BE8C
"hi DirvishGitUntrackedDir guifg=#A4BE8C
" hi DirvishGitStaged guifg=#A3BE8C
" hi DirvishGitRenamed guifg=#EBCB8B
" hi DirvishGitUnmerged guifg=#BF616A
hi DirvishGitDeleted guifg=#BF616A
" hi DirvishGitIgnored guifg=NONE guibg=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
" hi DirvishGitUntracked guifg=NONE guibg=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
" " Untracked dir linked to Dirvish dir color
" hi link DirvishGitUntrackedDir DirvishPathTail

" allows incsearch highlighting for range commands
set nohlsearch
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

inoremap <esc> NO ESCAPE FOR YOU
inoremap jk <esc>
inoremap jj <esc>
inoremap kj <esc>
