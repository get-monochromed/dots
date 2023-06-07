set title
set go=a
set mouse=a
set clipboard+=unnamedplus
set nohlsearch
syntax on
set number relativenumber
set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Custom bindings
noremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
autocmd BufWritePost /home/monochrome/.config/sway/config silent! !swaymsg reload
