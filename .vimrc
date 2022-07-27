set shell=/bin/bash
set nocompatible
set encoding=utf-8
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " * Essentials
    " Plugin 'ervandew/supertab' " Swaped with coc
    " Plugin 'ctrlpvim/ctrlp.vim' Swapped wtith Telescope
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'vim-airline/vim-airline'

    " * Niceties
    Plugin 'neoclide/coc.nvim' " Need to switch to release branch
    Plugin 'psliwka/vim-smoothie'
    Plugin 'nvim-lua/plenary.nvim' " Telescope dependency
    Plugin 'nvim-telescope/telescope.nvim'
    Plugin 'sbdchd/neoformat'
    Plugin 'dbeniamine/cheat.sh-vim'
    Plugin 'mbbill/undotree'
    " Git via coc-git

    " * Languages
    Plugin 'sheerun/vim-polyglot'
    Plugin 'slashmili/alchemist.vim'
    Plugin 'dleonard0/pony-vim-syntax'
    Plugin 'JuliaEditorSupport/julia-vim'
    Plugin 'ziglang/zig.vim'
    Plugin 'zah/nim.vim'
    Plugin 'LnL7/vim-nix'
    Plugin 'fatih/vim-go'
    " Rust via coc-rust?

call vundle#end()

syntax on
set number
filetype plugin indent on
set hidden
set history=30
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartindent
set autoindent
set showmatch
set hlsearch
set ffs=unix
nnoremap <silent> <leader>/ :nohlsearch<Bar>:echo<CR>
colorscheme desert
set statusline+=%#warningmsg#
set statusline+=%*
let g:lightline = {
      \ 'colorscheme': 'desert',
      \ 'component': {
      \   'readonly': '%{&readonly?"R":""}',
      \ },
      \ 'separator': { 'left': '>', 'right': '<' },
      \ 'subseparator': { 'left': '>', 'right': '<' }
      \ }
set laststatus=2
if !has('gui_running')
	set t_co=256
endif
if has('mouse')
  set mouse=a
endif

let mapleader = ","
nmap <leader><CTRL><TAB> :tabNext<CR>
nmap <leader><CTRL><SHIFT><TAB> :tabPrevious<CR>
let g:rustfmt_autosave = 1
let g:asyncrun_open = 15
let g:asyncrun_save = 1
set backspace=indent,eol,start
set relativenumber
set wildmenu

"!!!!!!!!!!!!! coc specific
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>/  :<C-u>nohlsearch<CR>
nnoremap <silent> <space>X  :<C-u>close<CR>
nnoremap <silent> <space>V  :<C-u>vsplit<CR>
nnoremap <silent> <space>S  :<C-u>split<CR>

highlight Pmenu ctermbg=grey
highlight CocErrorSign ctermfg=Black ctermbg=grey

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" undotree binding
nnoremap <F5> :UndotreeToggle<CR>
