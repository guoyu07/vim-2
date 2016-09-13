call plug#begin('~/.vim/plugged') " {{{
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin'|Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'solarnz/thrift.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Townk/vim-autoclose'
Plug 'tomtom/tcomment_vim'
Plug 'justmao945/vim-clang'
Plug 'phpvim/phpcd.vim', { 'for': 'php', 'do':'composer update' }
Plug 'phpvim/phpfold.vim', { 'for': 'php', 'do':'composer update' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'vim-php/tagbar-phpctags.vim', { 'for': 'php' }|Plug 'majutsushi/tagbar'
Plug 'jwalton512/vim-blade'
Plug 'tomasr/molokai'
Plug 'justinmk/vim-syntax-extra'
Plug 'ap/vim-css-color'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'othree/html5-syntax.vim', { 'for': 'html' }
Plug 'groenewege/vim-less'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'mxw/vim-jsx'
call plug#end() " }}}
" set {{{
color molokai
highlight Normal guibg=#000000 ctermbg=black " 纯黑背景，酷
set encoding=utf8
set laststatus=2
set cursorline
set hlsearch
set colorcolumn=80
set autoindent
set smartindent
set noswapfile
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set emoji
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif
set pastetoggle=<leader>p
" }}}
" map {{{
nnoremap <silent> <C-p> :FZF<cr>
nnoremap <silent> <C-u> :FZFMru<cr>
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeFind<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
"}}}
" autocmd {{{
func! ExpandTab(len)
	setlocal expandtab
	execute 'setlocal shiftwidth='.a:len
	execute 'setlocal softtabstop='.a:len
	execute 'setlocal tabstop='.a:len
endfunc
autocmd FileType html,css,less,javascript call ExpandTab(2)
autocmd FileType php,python,json,nginx call ExpandTab(4)
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
autocmd FileType php setlocal iskeyword-=$
autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<cr>
autocmd CompleteDone * pclose " 补全完成后自动关闭预览窗口
" 将光标跳转到上次打开当前文件的位置 {{{
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
			\ execute "normal! g`\"" |
			\ endif " }}}
" 清理行尾空白字符，md 文件除外 {{{
autocmd BufWritePre * if &filetype != 'markdown' |
			\ :%s/\s\+$//e |
			\ endif " }}}
" }}}
" command {{{
command -nargs=* -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" }}}
" plugin settings {{{
let g:ackprg = 'ag --vimgrep'
let g:neocomplete#enable_at_startup = 1
let g:fzf_mru_file_list_size = 100
" }}}

" vim: foldmethod=marker:noexpandtab:ts=2:sts=2:sw=2
