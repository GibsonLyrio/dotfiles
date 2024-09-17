""" SCRIPT START

"-----------------------------

" {{{ Basic Settings
set number         " Enable line numbers
set relativenumber " Relativize the line numbers for current position
set hlsearch       " Highlight all search matches
set incsearch      " Search as you type
syntax on          " Enable syntax highlight
set scrolloff=4     " Start scroll 4 lines away from top or bottom screen
" }}}

"-----------------------------

" {{{ Indent & Tabs Options
set autoindent
set smartindent
set tabstop=2      " Number of spaces that a <Tab> counts for
set shiftwidth=2   " Number of spaces to use for each setp of (auto)indent
set expandtab      " Convert tabs to spaces
" }}}

"-----------------------------

" {{{ Shortcuts
nnoremap <C-s> :w<CR>
" }}}

"-----------------------------

" {{{ Plugins
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'lambdalisue/suda.vim'

call plug#end()
" }}}

" {{{ Commands to manage plugins 
"     :PlugInstall  -> install the plugins
"     :PlugUpdate   -> install or update the plugins
"     :PlugDiff     -> review the changes from the last update
"     :PlugClean    -> remove plugins no longer in the list
" }}}

"-----------------------------

""" SCRIPT END
