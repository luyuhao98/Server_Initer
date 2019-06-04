" leader '\'
" PPA :  https://launchpad.net/~jonathonf/+archive/ubuntu/vim
" utf-8
set encoding=utf-8

"  设置剪切板
set clipboard=unnamed

set relativenumber

" 插入模式绝对行号，normal模式相对行号
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" 允许鼠标控制光标位置
set mouse=a

"" 插件控制
call plug#begin('~/.vim/plugged')

" 对齐插件
Plug 'junegunn/vim-easy-align'

" github访问
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }

"ctags管理
Plug 'ludovicchabant/vim-gutentags'

" 文件栏
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"YCM
Plug 'Valloric/YouCompleteMe'

"YCM 文件生成器
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

"项目编译
Plug 'skywind3000/asyncrun.vim'


" ALE 代码动态检查
Plug 'w0rp/ale'

" Gvim 主题
Plug 'flazz/vim-colorschemes'

" 状态栏

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 多行光标
"Plug 'terryma/vim-multiple-cursors'

" 修改比较
Plug 'mhinz/vim-signify'

" 参数提示
Plug 'Shougo/echodoc.vim'


" 括号引号补齐
Plug 'Raimondi/delimitMate'

" 快速注释
Plug 'scrooloose/nerdcommenter'

" 行位清空
Plug 'bronson/vim-trailing-whitespace'


" 插入代码片段

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'


" LeaderF 函数列表+文件切换
Plug 'Yggdroot/LeaderF'

" 缩进提示线
Plug 'Yggdroot/indentLine'

" 自动格式化python F8
Plug 'tell-k/vim-autopep8'

" 标记mark插件
Plug 'kshenoy/vim-signature'

" python <Leader-w>逐行执行
Plug 'sillybun/vim-repl', {'do': './install.sh'}
Plug 'sillybun/vim-async', {'do': './install.sh'}
Plug 'sillybun/zytutil'


"textobj
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java', 'python'] }
Plug 'sgur/vim-textobj-parameter'

"
"
" Format your C family code
Plug 'rhysd/vim-clang-format'


" 超级移动
Plug 'Lokaltog/vim-easymotion'

"大文件
Plug 'vim-scripts/LargeFile'
"""""""""""""""""""NewPlug""""""""""""""""""""""""""
" Initialize plugin system
Plug 'mileszs/ack.vim'
call plug#end()

""""""""""""""""""vim-easy-align""""""""""""""""""""

"" ga 对齐
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"""""""""""""""""""


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



""""""""""""""""""Ctags"""""""""""""""""""""""""


"""""""""""""""Vim-gutentags"""""""""""""""""""""""


" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 在本目录下生成.tags文件
let s:vim_tags = expand('.')
set tags=./.tags;,.tags

"(尝试失败,弃用) 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"""""""""""""""""""Asyncrun""""""""""""""""""""""""


" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 20

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 确定项目目录
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
" 设置 F5 编译项目
" 保存并编译
nnoremap <silent> <F5> :w<cr>:AsyncRun -cwd=<root> make <cr>
" 设置 F4 运行项目
" 保存并运行
nnoremap <silent> <F4> :w<cr>:AsyncRun -cwd=<root> make run <cr>

""""""""""""""""""colorschemes"""""""""""""""""""""
colorscheme molokai
" colorscheme BusyBee
" colorscheme jellybeans
" colorscheme SolarizedDark
""""""""""""""""""""YCM""""""""""""""""""""""""""""

" 默认两个字符以后自动弹出的是基于符号的补全,ycm基于语义的补全默认需要输入.或者->或者::才会弹出,因为以前ycm为半异步,语义比较卡所以这么设计
" 设置强制基于**语义**的补全快捷键ctrl+z
let g:ycm_key_invoke_completion = '<c-z>'

" Ycm现在已经支持全异步,语义补全不会卡用户.设置用户只需要输入符号的两个字母,即可自动语义补全
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

" 设置ycm白名单,避免分析类似txt这种非代码文件
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "javascript":1,
			\ "css":1,
			\ "python":1,
			\ "java":1,
			\ "go":1,
			\ "lua":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ "vimscript":1,
			\ }

" 配色 (注销因为colorschemes中包括了popmenu
" highlight PMenu ctermfg=0 ctermbg=30 guifg=black guibg=darkgrey
" highlight PMenuSel ctermfg=242 ctermbg=20 guifg=darkgrey guibg=black

" 屏蔽自动弹出函数原型预览窗口
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0

" 屏蔽诊断信息
let g:ycm_show_diagnostics_ui = 0

" 从注释和字符串中采集
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 补全字符串
let g:ycm_complete_in_strings=1

" 默认全局配置
let g:ycm_global_ycm_extra_conf = '/home/matrix98/.ycm_extra_conf.py'


" python地址

let g:ycm_python_binary_path  = '/home/matrix98/anaconda3/bin/python'

let g:ycm_server_python_interpreter = '/home/matrix98/anaconda3/bin/python'

let g:ycm_path_to_python_interpreter='/home/matrix98/anaconda3/bin/python'
""""""""""""""""""""""ALE""""""""""""""""""""""""""


"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'

" 保持侧边栏可见
let g:ale_sign_column_always = 1

" ALE只作用于ale_linters字典中所记录的语言
let g:ale_linters_explicit = 1

"ale支持语言
let g:ale_linters = {
			\   'cpp': ['gcc'],
			\   'c': ['gcc'],
			\   'python' : ['flake8'],
			\   'cuda' : ['nvcc'],
			\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines','trim_whitespace' ],
\   'python': ['autopep8']
\}

let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'

" airline 添加ale报错信息
let g:airline#extensions#ale#enabled = 1

" normal模式下文本修改与insert模式退出时触发linter,避免过于频繁.
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" gcc 选项
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" Gvim各种下划线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

"""""""""""""""""Airline""""""""""""""""""""""""""
" Smarter tab line
let g:airline#extensions#tabline#enabled = 1
" Tab separators
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '♩'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" 关闭模式显示 (airline已经实现
set noshowmode
""""""""""""""""NERDCommenter""""""""""""""""""""""
" 映射 c-/ 为智能注释or取消注释
" vim自身特性 c-/ 需要映射为c-_
" 此处若改为noremap 则失效,必须为map
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

""""""""""""""vim-trailing-whitespace""""""""""""""
map <leader><space> :FixWhitespace<cr>

""""""""""""""""""echodoc""""""""""""""""""""""""""
let g:echodoc#enable_at_startup=1
""""""""""""""""""leaderF""""""""""""""""""""""""""
" CTRL+P 在当前项目目录打开文件搜索，
" CTRL+N 打开 MRU搜索
" ALT+P 打开函数搜索
" ALT+N 打开 Buffer 搜索
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
""""""""""""""""""UltiSnips""""""""""""""""""""""""

" Trigger configuration.
let g:UltiSnipsExpandTrigger="<a-q>"
let g:UltiSnipsJumpForwardTrigger="<a-f>"
let g:UltiSnipsJumpBackwardTrigger="<a-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
""""""""""""""""""indentLine'"""""""""""""""""""""""
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

""""""""""""""""""vim-autopep8""""""""""""""""""""""

let g:autopep8_on_save = 0
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

""""""""""""""""""vim-repl""""""""""""""""""""""

"<Leader> r 打开REPLToggle.
"默认<Leader>w 将python代码传入REPLToggle执行

nnoremap <leader>r :REPLToggle<Cr>

let g:repl_program = {
            \   'python': 'python',
            \   'default': 'zsh'
            \   }
let g:repl_exit_commands = {
			\	"python": "quit()",
			\	"bash": "exit",
			\	"zsh": "exit",
			\	"default": "exit",
			\	}
autocmd Filetype python nnoremap <F8> <Esc>:REPLSendAll<Cr>

"0 represents bottom
"1 represents top
"2 represents left
"3 represents right
let g:repl_position = 0

""""""""""""""""vim-clang-format"""""""""""""""""""

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

""""""""""""""""vim-easymotion"""""""""""""""""""""


let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion


" 行级跳转
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

" 默认设置:
" 跳转到当前光标前后的位置(w/b)
" <leader><leader>w or <leader><leader>b
" 搜索跳转(s)
" <leader><leader>s


"""""""""""""""""""ACK.VIM"""""""""""""""""""""""""
if executable('ag')
	let g:ackprg='ag --vimgrep'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""End of Plug Settings"""""""""""""""
"makes Alt Work in terminal in escape sequences way
let c='a'
while c <= 'z'
	  exec "set <A-".c.">=\e".c
	    exec "imap \e".c." <A-".c.">"
	      let c = nr2char(1+char2nr(c))
      endw
set timeout
set timeoutlen=700
set ttimeoutlen=0


"alt +j/k move lines
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
inoremap <A-k> <Esc>:m-2<CR>==gi
nnoremap <A-j> :m+<CR>==
vnoremap <A-k> :m-2<CR>gv=gv

"ctrl +h/j/k/l move in editormode
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

"空格 选中单词
nnoremap <SPACE> i<space><Esc>

"复制粘贴
vnoremap <c-y> "+y
"事实上,作为粘贴,ctrl+shift+v还是更顺手一些.而且ctrl-p还有很多其他用处.所以废弃此用法
"vnoremap <c-p> "+p
"nnoremap <c-p> "+p

vnoremap <c-x> "+x
nnoremap <c-y><c-y> "+yy

"撤销/恢复
vnoremap <a-u> <esc>u
inoremap <a-u> <esc>u
nnoremap <a-u> u
"全选
inoremap <a-a> <esc>ggVG
vnoremap <a-a> <esc>ggVG
nnoremap <a-a> ggVG

"n模式 回车 -> O

nnoremap <CR> O<esc>j

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

" gj jk :当由于一行过长或窗口较小导致折行时,j,k会跳过整整一行,非常不方便.gj,gk便可以实现折行间上下移动光标.
" 同时有一个问题:当使用类似`10k`的方式来移动光标时,如果仅仅使用`nnoremap k gk`的方法来映射,会导致如果中间有折行,那么10k中将包括这些折行,导致10k!=上移10行号.
" 于是Reddit上有人就提出了如下的映射方式,完美的解决了这个问题.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" 行首H 行位L
nnoremap L $
nnoremap H I<esc>
vnoremap L $
vnoremap H I<esc>
inoremap <a-l> <esc>g$a
inoremap <a-h> <esc>g0i

" 取消高亮 alt+r
nnoremap <a-r> :nohl<cr>

" 到全文最后

inoremap <a-g> <esc>GA
nnoremap <a-g> G$
vnoremap <a-g> G$

" visual tab
vnoremap <tab> I<tab><esc>

"大十字光标
set cursorcolumn
set cursorline

"vim下出现一个新的shell
nnoremap <a-s> :rightb ter<cr>

set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" ctrl+enter,回车光标不移动。

nnoremap <leader><CR> i<CR><ESC>k$
inoremap <leader><CR> <CR><ESC>kA
