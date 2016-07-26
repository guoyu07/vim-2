call plug#begin('~/.vim/plugged') " {{{
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'phpvim/phpcd.vim', { 'for': 'php', 'do':'composer update' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tomasr/molokai'
Plug 'Townk/vim-autoclose'
Plug 'majutsushi/tagbar'
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'vim-php/tagbar-phpctags.vim', { 'for': 'php' }
Plug 'ap/vim-css-color'
Plug 'othree/html5.vim'
Plug 'othree/html5-syntax.vim'
Plug 'groenewege/vim-less'
Plug 'ternjs/tern_for_vim'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent'
Plug 'mxw/vim-jsx'
Plug 'tomtom/tcomment_vim'
Plug 'phpvim/phpfold.vim', { 'for': 'php', 'do':'composer update' }
call plug#end() " }}}
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
" map
nnoremap <silent> <C-p> :FZF<cr>
nnoremap <silent> <C-u> :FZFMru<cr>
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeFind<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
" autocmd
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
autocmd FileType javascript nnoremap <C-]> :TernDef<cr>
autocmd CompleteDone * pclose " 补全完成后自动关闭预览窗口
" 将光标跳转到上次打开当前文件的位置 {{{
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
			\ execute "normal! g`\"" |
			\ endif " }}}
" 清理行尾空白字符，md 文件除外 {{{
autocmd BufWritePre * if &filetype != 'markdown' |
			\ :%s/\s\+$//e |
			\ endif " }}}
" fzf-ag {{{
function! s:ag_to_qf(line)
	let parts = split(a:line, ':')
	return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
				\ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
	if len(a:lines) < 2 | return | endif

	let cmd = get({'ctrl-x': 'split',
				\ 'ctrl-v': 'vertical split',
				\ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
	let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

	let first = list[0]
	execute cmd escape(first.filename, ' %#\')
	execute first.lnum
	execute 'normal!' first.col.'|zz'

	if len(list) > 1
		call setqflist(list)
		copen
		wincmd p
	endif
endfunction

function! s:ag_search(keyword)
	call fzf#run({
				\ 'source':  printf('ag --nogroup --column --color "%s"',
				\                   escape(empty(a:keyword) ? '^(?=.)' : a:keyword, '"\')),
				\ 'sink*':   function('s:ag_handler'),
				\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
				\            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
				\            '--color hl:68,hl+:110',
				\ 'down':    '10'
				\ })
endfunction

command! -nargs=* FZFAg call s:ag_search(<q-args>)
command! FZFAg call s:ag_search(expand('<cword>'))
" }}}

let g:ackprg = 'ag --vimgrep'
let g:neocomplete#enable_at_startup = 1
let g:fzf_mru_file_list_size = 100

" vim: foldmethod=marker:noexpandtab:ts=2:sts=2:sw=2
