set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim' - tego sie nie dodaje, jak Vundle jest
" zainstalowany z repo (AUR)
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 31

Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode='d'
" ignore any directory that contains "build" in its name
let g:ctrlp_custom_ignore = {'dir': 'build'}

"Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/vim-lsp'
Plugin 'ycm-core/YouCompleteMe'

"let g:ycm_log_level = 'debug'

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.

"clangd w wersji 10 nie chce dzialac z YCM :( (bez ponizszej linijki bedzie uzyty wbudowany w YCM clangd)
"POPRAWKA ^^^^^ - clangd 10 jednak działa z YCM, ale potrzebny był fix w YCM, w pliku clangd_completer.py:

"def CheckClangdVersion( clangd_path ):
"       return True <------------------------------------- tu jest hak, który naprawia problem z clangd 10
"       version = GetVersion( clangd_path )
"       if version and version < MIN_SUPPORTED_VERSION:
"         return False
"       return True

let g:ycm_clangd_binary_path = exepath("clangd")

let g:ycm_clangd_args = ['--background-index=true', '--header-insertion=never']

set completeopt-=preview
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_error_symbol = '>'

Plugin 'derekwyatt/vim-fswitch'
let g:fsnonewfiles=1

Plugin 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ackhighlight = 1

"Plugin 'morhetz/gruvbox'
Plugin 'rafi/awesome-vim-colorschemes'

"Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'bfrg/vim-cpp-modern'
"let g:cpp_no_function_highlight=1

Plugin 'schickling/vim-bufonly'

Plugin 'huawenyu/neogdb.vim'

Plugin 'Townk/vim-autoclose'

Plugin 'chiedo/vim-case-convert'

Plugin 'chrisbra/unicode.vim'

Plugin 'cpiger/NeoDebug'
let g:neodbg_keymap_print_variable = '<Alt-P>'

"Plugin 'pacha/vem-tabline'

Plugin 'tpope/vim-surround'

"if executable('clangd')
    "augroup lsp_clangd
        "autocmd!
        "autocmd User lsp_setup call lsp#register_server({
                    "\ 'name': 'clangd',
                    "\ 'cmd': {server_info->['clangd']},
                    "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    "\ })
        "autocmd FileType c setlocal omnifunc=lsp#complete
        "autocmd FileType cpp setlocal omnifunc=lsp#complete
        "autocmd FileType objc setlocal omnifunc=lsp#complete
        "autocmd FileType objcpp setlocal omnifunc=lsp#complete
    "augroup end
"endif

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.dirty='⚡'

" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set termguicolors
set mouse=a
syntax on
set number
set relativenumber
set ignorecase
set smartcase
set signcolumn=yes

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set ffs=unix

set hidden

set scrolloff=10

set noswapfile

"ustawienia gruvboxa
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
highlight Normal guibg=none guifg=#faefca
highlight GruvboxRed guifg=#fe8019
highlight link cUserFunction GruvboxBlueBold

"podswietlanie trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=#e53a25
"match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction
" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
"au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" wyłącz automatyczne dodawanie komentarza przy wstawianiu nowej linii
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let mapleader = " "
inoremap jk <Esc>
inoremap JK <Esc>
noremap <leader>m :NERDTree<cr>
noremap <leader>c :NERDTreeClose<cr>
noremap <leader>f :NERDTreeFind<cr>
noremap <c-h> :bp<cr>
noremap <c-l> :bn<cr>
noremap <leader>Q :BufOnly<cr>
nnoremap <leader>q :bp<cr>:bd #<cr>
noremap <leader>o o<Esc>
noremap <leader>O O<Esc>

noremap <leader>g :YcmCompleter GoTo<cr>
noremap <leader>t :YcmCompleter GetType<cr>
noremap <leader>u :YcmCompleter GoToReferences<cr>
noremap <F4> :FSHere<cr>

nnoremap <leader>a :Ack!<space>

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P

noremap <leader>s :nohlsearch<cr>
nnoremap <leader>r :YcmCompleter RefactorRename<space>
noremap <leader>z :cclose<cr><C-w>10l
noremap <leader>Z :botright cwindow 16<cr>

noremap <leader>w :set list!<cr>

nnoremap : :let previousmode='n'<CR>:
vnoremap : :<C-w>let previousmode='v'<CR>gv:

"function! DeleteCurrentBuffer() abort
    "let current_buffer = bufnr('%')
    "let next_buffer = vem_tabline#tabline.get_replacement_buffer()
    "try
        "exec 'confirm ' . current_buffer . 'bdelete'
        "if next_buffer != 0
            "exec next_buffer . 'buffer'
        "endif
    "catch /E516:/
       "" If the operation is cancelled, do nothing
    "endtry
"endfunction
"nmap <leader>q :call DeleteCurrentBuffer()<CR>
"nmap <leader>h <Plug>vem_move_buffer_left-
"nmap <leader>l <Plug>vem_move_buffer_right-
"nmap <c-h> <Plug>vem_prev_buffer-
"nmap <c-l> <Plug>vem_next_buffer-
"" always show the tabline
"let g:vem_tabline_show=2
"let g:vem_tabline_show_number='index'

"highlight VemTablineNormal           term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#242424 guibg=#cdcdcd gui=none
"highlight VemTablineLocation         term=reverse cterm=none ctermfg=239 ctermbg=251 guifg=#666666 guibg=#cdcdcd gui=none
"highlight VemTablineNumber           term=reverse cterm=none ctermfg=239 ctermbg=251 guifg=#666666 guibg=#cdcdcd gui=none
"highlight VemTablineSelected         term=bold    cterm=bold ctermfg=0   ctermbg=255 guifg=#242424 guibg=#ffffff gui=bold
"highlight VemTablineLocationSelected term=bold    cterm=none ctermfg=239 ctermbg=255 guifg=#666666 guibg=#ffffff gui=bold
"highlight VemTablineNumberSelected   term=bold    cterm=none ctermfg=239 ctermbg=255 guifg=#666666 guibg=#ffffff gui=bold
"highlight VemTablineShown            term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#242424 guibg=#cdcdcd gui=none
"highlight VemTablineLocationShown    term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#666666 guibg=#cdcdcd gui=none
"highlight VemTablineNumberShown      term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#666666 guibg=#cdcdcd gui=none
"highlight VemTablineSeparator        term=reverse cterm=none ctermfg=246 ctermbg=251 guifg=#888888 guibg=#cdcdcd gui=none
"highlight VemTablinePartialName      term=reverse cterm=none ctermfg=246 ctermbg=251 guifg=#888888 guibg=#cdcdcd gui=none
"highlight VemTablineTabNormal        term=reverse cterm=none ctermfg=0   ctermbg=251 guifg=#242424 guibg=#4a4a4a gui=none
"highlight VemTablineTabSelected      term=bold    cterm=bold ctermfg=0   ctermbg=255 guifg=#242424 guibg=#ffffff gui=bold
"
function! SwitchSidesAroundBinaryOperator()
    " Save cursor position
    let l:save = winsaveview()

    execute "normal! vi)\<Esc>"
    '<,'>s#\v%V(\S+)\s+(\S\S)\s+(\S+%V\S)#\3 \2 \1#e

    " Move cursor to original position
    call winrestview(l:save)
endfunction
noremap <leader>e :call SwitchSidesAroundBinaryOperator()<CR>

function! ToggleIncludeSurroundingCharacters()
    execute "normal mphE"
    let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if char=='>'
        execute "normal cs>\""
    else
        execute "normal cs\">"
    endif
    execute "normal `p"
endfunction
nmap <leader>" :call ToggleIncludeSurroundingCharacters()<CR>

function! FormatJSONImpl(previousmode, line1, line2)
    if a:previousmode=='v'
        s/\v%V\_.*%V\_./\=system("python3 -m json.tool", submatch(0))
    else
        execute a:line1.",".a:line2."!python3 -m json.tool"
    endif
endfunction

function! CompactJSONImpl(previousmode, line1, line2)
    if a:previousmode=='v'
        s/\v%V\_.*%V\_./\=system("python3 -c \"import json, sys; print(json.dumps(json.load(sys.stdin), separators=(',',':')))\"", submatch(0))
    else
        execute a:line1.",".a:line2."!python3 -c \"import json, sys; print(json.dumps(json.load(sys.stdin), separators=(',',':')))\""
    endif
endfunction

function! FormatXMLImpl(previousmode, line1, line2)
    if a:previousmode=='v'
        '<,'>s/\v%V.*%V./\=system("python3 -c 'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'", submatch(0))
    else
        execute a:line1.",".a:line2."!python3 -c 'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'"
    endif
endfunction

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

com! -range=% FormatXML :call FormatXMLImpl(previousmode, <line1>, <line2>)
com! -range=% FormatJSON :call FormatJSONImpl(previousmode, <line1>, <line2>)
com! -range=% CompactJSON :call CompactJSONImpl(previousmode, <line1>, <line2>)
com! Format :execute 'silent !scripts/format.sh' | :redraw!
