call plug#begin('~/.vim/plugged')
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'phpvim/phpcd.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
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

set hlsearch

autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
func! ExpandTab(len)
	setlocal expandtab
	execute 'setlocal shiftwidth='.a:len
	execute 'setlocal softtabstop='.a:len
	execute 'setlocal tabstop='.a:len
endfunc
autocmd FileType html,css,scss,javascript call ExpandTab(2)
autocmd FileType php,python,json,nginx call ExpandTab(4)

autocmd FileType vim setlocal foldmethod=marker

" 将光标跳转到上次打开当前文件的位置 {{{
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
			\ execute "normal! g`\"" |
			\ endif " }}}
" 清理行尾空白字符，md 文件除外 {{{
autocmd BufWritePre * if &filetype != 'markdown' |
			\ :%s/\s\+$//e |
			\ endif " }}}
