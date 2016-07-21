call plug#begin('~/.vim/plugged')
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
call plug#end()

filetype plugin indent on
syntax on
set laststatus=2
set t_Co=256
color desert
highlight VertSplit ctermfg=240 ctermbg=232 cterm=bold

nnoremap <silent> <C-p> :FZF<cr>
nnoremap <silent> <C-u> :FZFMru<cr>
nnoremap <silent> <leader>e :NERDTreeToggle<cr>

