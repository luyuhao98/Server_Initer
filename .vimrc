
" PPA :  https://launchpad.net/~jonathonf/+archive/ubuntu/vim

"utf-8
set encoding=utf-8

"  设置剪切板
set clipboard=unnamed
"  显示数字
set number
" 允许鼠标控制光标位置
set mouse=a

" 插件控制
call plug#begin('~/.vim/plugged')

" 文件栏
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" vim 主题
Plug 'flazz/vim-colorschemes'

" 状态栏

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 括号引号补齐
Plug 'Raimondi/delimitMate'

call plug#end()
""""""""""""""""""""

"""""""""""""""""" NerdTree"""""""""""""""""""""""""

" ALT+t 启动/关闭 NerdtreeToggle 
map <a-t> :NERDTreeToggle<CR>

" Open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Get NERDTree to show dot files
let NERDTreeShowHidden=1



""""""""""""""""""colorschemes"""""""""""""""""""""
" colorscheme molokai
" colorscheme BusyBee
" colorscheme jellybeans
" colorscheme SolarizedDark

"""""""""""""""""Airline""""""""""""""""""""""""""
" Smarter tab line
let g:airline#extensions#tabline#enabled = 1
" Tab separators  
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '♩'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" 关闭模式显示 (airline已经实现
set noshowmode
"""""""""""""""""""""""""""""""""""""""""""""""""""

"makes Alt Work in terminal in escape sequences way
let c='a'
while c <= 'z'
	  exec "set <A-".c.">=\e".c
	    exec "imap \e".c." <A-".c.">"
	      let c = nr2char(1+char2nr(c))
      endw
set timeout
set timeoutlen=200
set ttimeoutlen=0


"alt +j/k move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

"ctrl +h/j/k/l move in editormode
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

"空格 选中单词
nnoremap <SPACE> viw

"复制粘贴
vnoremap <C-y> "+y
vnoremap <c-p> "+p
vnoremap <c-x> "+x 
nnoremap <c-p> "+p

"撤销/恢复
vnoremap <a-u> <esc>u
inoremap <a-u> <esc>u
nnoremap <a-u> u
"全选
inoremap <a-a> <esc>ggVG
vnoremap <a-a> <esc>ggVG
nnoremap <a-a> ggVG

"n模式 回车 -> 插入换行符
nnoremap <CR> o<esc>

" 删除
inoremap <a-x> <BS>
" Oo
inoremap <a-o> <esc>o
inoremap <a-O> <esc>O

"  vim know my background is dark when used outside tmux, but it didn't get the information when used inside tmux.
" 解决tmux中vim发暗的问题
set background=dark

" 高亮查找
set hlsearch 

" 变输入边查找
set incsearch 


"搜索时忽略大小写
set ignorecase

" 自动格式化
set formatoptions=tcrqn 

" 切换buffer 
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" 关闭buffer
nnoremap <a-d> :bd<cr>

" Prevent vim from clearing the clipboard on exit
" **Before running, 'xsel' should be installed
"
"	sudo apt install xsel
"
autocmd VimLeave * call system("xsel -ib", getreg('+'))

