""""""""""""""""""""""""""""""""""""""""
" .vimrc
"
" (c) Zoran Zarić
""""""""""""""""""""""""""""""""""""""""

" # Grundeinstellungen"{{{1
"Disable vim's compatibility-mode
set nocompatible

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"When a file is changed form the outside re-read it
set autoread

set smartindent

set incsearch

set smartcase

set hlsearch

syntax on

set dir=~/tmp/vim
set backupdir=~/tmp/vim

"Allways enable mouse
set mouse=a

"Colors"{{{2
"colorscheme 256-jungle
"colorscheme blackboard
"colorscheme candycode
"colorscheme candyman
"colorscheme inkpot
"colorscheme ir_black
"colorscheme jammy
"colorscheme jellybeans
"colorscheme molokai
"colorscheme railscasts
"colorscheme symfony
"colorscheme twilight
"colorscheme vibrantink
"colorscheme wombat
":let g:zenburn_high_Contrast=1
colorscheme zenburn
"}}}2

" Settings for :TOhtml
let html_number_lines=1
let html_use_css=1
let use_xhtml=1

set scrolloff=5

"Enable the ruler with numbers
set number ruler

"Enable the cursorline
set cursorline

set tw=80
set colorcolumn=+1

"Custom statusline
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ %{(&fenc==\"\"?&enc:&fenc)}\ %{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")}\ %=%#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#statusline()}\ [POS=%04l,%04v]\ [LEN=%L]
set laststatus=2

"Remapping the leader-key
:let mapleader = ","

filetype plugin on
set ofu=syntaxcomplete#Complete
"
"Matching Brackets
set showmatch
set mat=5

"Tab settings
set ts=3 sts=3 sw=3 noexpandtab

" ## Whitespace"{{{2
"Show whitespace
set list
"
"Whitespace-characters
"set listchars=tab:▸\ ,trail:·,eol:¬
set listchars=tab:¦-,trail:·,eol:¬,extends:#

"Whitespace-character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"Shortcut for toggeling whitespace
nmap <leader>l :set list!<CR>

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/
"}}}2

vnoremap < <gv
vnoremap > >gv

" ## Shortcuts"{{{2
nnoremap <leader>sd :set spelllang=de spell<CR>
nnoremap <leader>se :set spelllang=en spell<CR>

nmap <leader>R :execute '!redo'<CR>
nmap <leader>Rt :execute '!redo test'<CR>

nnoremap <leader>g :execute "vimgrep " expand('<cword>') " **/*"<CR>:copen<CR>

nmap <leader>h :nohlsearch<CR>

"search+replace word under cursor
nnoremap <C-S> :,$s/\<<C-R><C-W>\>/

"Toggeling autoindent
nmap <leader>i :set autoindent!<CR>
"}}}2

" ## persistene undo "{{{2
if v:version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000
  set undoreload=10000
end
"#}}}2
"}}}1

" # Buffers"{{{1
"Enable switching away from changed buffers
set hidden

map <silent><C-H> :bp<CR>
map <silent><C-L> :bn<CR>
map <leader>bd :bd<CR>

map <leader>bc :call CleanClose(0)<CR>
map <leader>bC :call CleanClose(1)<CR>
" ## CleanClose"{{{2
function! CleanClose(tosave)
	if (a:tosave == 1)
		 w!
	endif
	let todelbufNr = bufnr("%")
	let newbufNr = bufnr("#")
	if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
		 exe "b".newbufNr
	else
		 bnext
	endif

	if (bufnr("%") == todelbufNr)
		 new
	endif
	exe "bd".todelbufNr
endfunction
"}}}2
"}}}1

" # Tabs"{{{1
map <silent><C-J> :tabprevious<CR>
map <silent><C-K> :tabnext<CR>
"Open a tag in a new tab
nmap <C-\> <C-w><C-]><C-w>T
"}}}1

" # Folding"{{{1
set foldenable
set foldmethod=marker
"
" ## Fold shortcuts"{{{2
nnoremap <leader>Fm :set foldmethod=marker<cr>
nnoremap <leader>Fs :set foldmethod=syntax<cr>
nnoremap <leader>Fi :set foldmethod=indent<cr>
"}}}2
"}}}1

" # Filetype-Shortcuts"{{{1
nmap <leader>fh :set filetype=html<CR>
nmap <leader>fp :set filetype=php<CR>
nmap <leader>fj :set filetype=java<CR>
nmap <leader>fjs :set filetype=javascript<CR>
nmap <leader>fts :set filetype=typoscript<CR>
"}}}1

" # Wrapping"{{{1
" toggle wrapping with \w
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call UnwrapIt()
  else
    echo "Wrap ON"
    call WrapIt()
  endif
endfunction
 
function WrapIt()
  set wrap linebreak
  "set virtualedit=
  set breakat=\ ^I!@*-+;:,./? " when wrapping, break at these characters (requires linbreak, see above)
  set showbreak=> " character to show that a line is wrapped
  setlocal display+=lastline
  noremap <buffer> <silent> k gk
  noremap <buffer> <silent> j gj
  noremap <buffer> <silent> <Up> gk
  noremap <buffer> <silent> <Down> gj
  noremap <buffer> <silent> <Home> g<Home>
  noremap <buffer> <silent> <End> g<End>
  inoremap <buffer> <silent> <Up> <C-o>gk
  inoremap <buffer> <silent> <Down> <C-o>gj
  inoremap <buffer> <silent> <Home> <C-o>g<Home>
  inoremap <buffer> <silent> <End> <C-o>g<End>
endfunction
 
function UnwrapIt()
  set nowrap
  "set virtualedit=all
  silent! nunmap <buffer> j
  silent! nunmap <buffer> k
  silent! nunmap <buffer> <Up>
  silent! nunmap <buffer> <Down>
  silent! nunmap <buffer> <Home>
  silent! nunmap <buffer> <End>
  silent! iunmap <buffer> <Up>
  silent! iunmap <buffer> <Down>
  silent! iunmap <buffer> <Home>
  silent! iunmap <buffer> <End>
endfunction
 
if &wrap
  call WrapIt()
endif
"}}}1

" # Plugins"{{{1
" ## Supertab"{{{2
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
"}}}2

" ## zencoding"{{{2
let g:user_zen_expandabbr_key = '<c-z>z'
let g:user_zen_leader_key = '<c-z>'
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {
\	'php' : {
\		'extends' : 'html',
\		'filters' : 'c',
\	}
\}
"}}}2

" ## Tlist"{{{2
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
nnoremap <leader>T :TlistToggle<CR>
"}}}2

" ## ragtag"{{{2
let g:ragtag_global_maps = 1 
"}}}2

" ## NERDTree"{{{2
noremap <leader>N :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc']
"}}}2

" ## latex-suite"{{{2
let g:tex_flavor='latex'
"}}}2

" ## tasklist"{{{2
map <leader>v <Plug>TaskList
"}}}2
"
" ## syntastic"{{{2
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
"}}}2

" ## cscope"{{{2
"if has("cscope")
"	set csprg=/usr/bin/cscope
"	set csto=0
"	set cst
"	set nocsverb
"	" add any database in current directory
"	if filereadable("cscope.out")
"			cs add cscope.out
"	" else add database pointed to by environment
"	elseif $CSCOPE_DB != ""
"			cs add $CSCOPE_DB
"	endif
"	set csverb
"	map <C-8> :cstag <C-R>=expand("<cword>")<CR><CR>
"	map <C-9> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"endif
"}}}2

" ## makegreen"{{{2
map <leader>r <Plug>MakeGreen
"}}}2

" ## showmarks"{{{2
let g:showmarks_enable=0
"}}}2

" ## vimwiki"{{{2
let g:vimwiki_list = [{'path' : '~/.vimwiki', 'path_html' : '~/.vimwiki_html'}]
let g:vimwiki_folding = 1
"}}}2

" ## gundo "{{{2
nnoremap <leader>G :GundoToggle<CR>
"}}}2

" ## indent guides "{{{
if !has("gui_running")
	let g:indent_guides_auto_colors = 0 
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#284f28 ctermbg=236
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3f4040 ctermbg=238
end
"}}}2
" }
"}}}1

" # Filetypes{{{1
" ## PHP"{{{2
function MapPHPLint()
	nnoremap <F12> :!php -l %<CR>
endfunction

function InitPHP()
	set foldmethod=indent
	set foldcolumn=12

	set omnifunc=phpcomplete#CompletePHP

	set keywordprg=~/.vim/php_doc

	:call MapPHPLint()
	nnoremap <leader>Lp :!php -l %<CR>
endfunction

let php_sql_query=1
let php_htmlInStrings=1

autocmd FileType php :call InitPHP()
"}}}2

" ## Python"{{{2
function MapRunPython()
	nnoremap <F11> :!python %<CR>
endfunction

function InitPython()
	:call MapRunPython()
	set ts=4 sts=4 sw=4 expandtab
endfunction

autocmd FileType python :call InitPython()
"}}}2

" ## Ruby"{{{2
function MapRubyLint()
	nnoremap <F12> :!ruby -c %<CR>
endfunction

function InitRuby()
	:call MapRubyLint()
	nnoremap <leader>Lr :!ruby -c %<CR>
endfunction
autocmd BufRead,BufNewFile *.rb :call InitRuby()
"}}}2

" ## JavaScript"{{{2
function MapJSLint()
	nnoremap <F12> :!js ~/workspaces/js/jslint.js < %<CR>
endfunction

function InitJS()
	:call MapJSLint()
	nnoremap <leader>Lj :!js ~/workspaces/js/jslint.js < %<CR>
endfunction
autocmd BufRead,BufNewFile *.js :call InitJS()
"}}}2

" ## VCL"{{{2
autocmd BufRead,BufNewFile *.vcl :set filetype=vcl
"}}}2

" ## JSON"{{{2
autocmd BufRead,BufNewFile *.json :set filetype=json
"}}}2

" ## Vimwiki"{{{2
function InitVimwiki()
	set ts=2 sts=2 sw=2 expandtab
endfunction

autocmd FileType vimwiki :call InitVimwiki()
"}}}2
"}}}1

" # Klammer-Geraffel"{{{1
inoremap ['      ['']<Left><Left>
inoremap [<Space> []<Left>
inoremap [	[
inoremap (<Space> ()<Left>
inoremap (      (
noremap ()      ()
inoremap {<Space> {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<Tab>
inoremap {     {
noremap {}     {}

inoremap /*          /**/<Left><Left>
inoremap /*<Space>   /*<Space><Space>*/<Left><Left><Left>
inoremap /*<CR>      /*<CR>*/<Esc>O
inoremap <Leader>/*  /*

"inoremap <?php<CR> <?php<CR>?><Esc>0<Tab>
"inoremap <?php     <?php
"noremap <?php<Space>?> <?php<Space>?>
"}}}1

" # GVIM"{{{1
if has("gui_running")
	set guioptions=
	colorscheme candymanzz
	set guifont=Terminus\ 10
end
"}}}1
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
