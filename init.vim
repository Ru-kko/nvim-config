call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline' " button bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code autocompletion
Plug 'mattn/emmet-vim' " emmet
Plug 'jacoborus/tender.vim' " theme
Plug 'preservim/nerdtree' " directories
Plug 'Yggdroot/indentLine' " Indent Line
Plug 'jiangmiao/auto-pairs' " Automatic close brakets
Plug 'preservim/nerdcommenter' " Line commeter
Plug 'christoomey/vim-tmux-navigator' " navigate betwen windows
Plug 'ryanoasis/vim-devicons' " Icons for nerdtree
Plug 'leafgarland/typescript-vim' " --⤵
Plug 'peitalin/vim-jsx-typescript' " Jsx and tsx syntax highlighting

call plug#end()

" config

" basic
set number
set tabstop=4
set ignorecase
set relativenumber
set numberwidth=1
set encoding=utf-8
set sw=4
set clipboard=unnamed
set autoindent
set showmatch
set splitright
set mouse=a
syntax on
set incsearch
set hlsearch
set inccommand=nosplit
set hidden
let mapleader="."

"" Find words
nmap <c-f> /
imap <c-f> <ESC>/

function GetVisualSelection()
  let raw_search = @"
  let @/=substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction

xnoremap <C-f> ""y:call GetVisualSelection()<bar>:set hls<cr>

xnoremap /s ""y:call GetVisualSelection()<cr><bar>:%s/

"" Save

nmap <C-s> :w <bar> :echom "Saved"<CR>
imap <C-s> <ESC>:w <bar> :echom "Saved"<CR>
vmap <C-s> <ESC>:w <bar> :echom "Saved"<CR>

"" Quit 
nmap <C-q> :q<CR>
imap <C-q> <ESC>:q<CR>
vmap <C-q> <ESC>:q<CR>

" emmet

let g:user_emmet_leader_key=','

" theme
if (has("termguicolors"))
 set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme tender
let g:airline_theme = 'tender'

" nerdtree
let NERDTreeShowHidden=1
let nerdtreeignore=['\\.git']
let NERDTreeShowLineNumbers=1

autocmd FileType nerdtree setlocal relativenumber
map <S-Tab> :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind 

" Coc
set nowritebackup
set nobackup
set cmdheight=2
set updatetime=300
set signcolumn=number

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
"" Comments in json
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END

" Enter to complete
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"" go to def

nmap <C-e> :call CocAction('jumpDefinition', 'vsplit')<CR> 

"" Prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

nmap <F13> :Prettier <CR>
imap <F13> <ESC>:Prettier<CR>:startinsert <CR>
vmap <F13> <ESC>:Prettier<CR>
