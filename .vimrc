" Anup's customizations

"{{{ Basic settings ------------------------------------------------------------

set nocompatible
syntax on

" ',' is easy to type, so use it for <Leader> to make compound commands
" easier:
" let mapleader=","
" Unfortunately, this introduces a delay for the ',' command.  Let's compensate
" by introducing a speedy alternative...
" noremap ,. ,

set ic    " Ignore case when searching
set hls   " Highlight search results
set ruler " Show row and column info in the status bar

set noerrorbells novisualbell t_vb=  " Turn off the annoying errorbell

set mouse=a  " Enable mouse in terminal mode

" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamed

" Always show the status line and make it gray
set laststatus=2
highlight StatusLine ctermfg=Gray

" Open new files in tabs
" TODO: Needs some work, esp. when working with Gsearch
"au BufAdd,BufNewFile * nested tab sball

"}}} Basic settings ------------------------------------------------------------


"{{{ Improving basic commands --------------------------------------------------

" Y should work like D and C.
nnoremap Y y$

" Easy quit-all, which is unlikely to be mistyped.
nnoremap <silent> <Leader>qwer :confirm qa<CR>

" Diff mode options
if &diff
  set cursorline
  map ] ]c
  map [ [c
  hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
  hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
  hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

"}}} Improving basic commands --------------------------------------------------


"{{{ Working with Vim itself ---------------------------------------------------
" Function to show the highlight groups applied to the word under cursor.
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}} Working with Vim itself ---------------------------------------------------


"{{{ Plugins -------------------------------------------------------------------
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required

Plugin 'ctrlpvim/ctrlp.vim'  " CtrlP plugin for file system navigation.

"Plugin 'leafgarland/typescript-vim'  " enables TypeScript syntax-highlighting.
Plugin 'sheerun/vim-polyglot'  " syntax highlighting for many languages.

" tComment plugin for comment/uncommenting support in code.
" https://github.com/tomtom/tcomment_vim
Plugin 'tomtom/tcomment_vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"}}} Plugins -------------------------------------------------------------------


""{{{ Code formatting -----------------------------------------------------------
"Glug codefmt
"Glug codefmt-google
"Glug clang-format plugin[mappings]
"
"" Auto format files on save
"augroup autoformat_settings
"  autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,javascript,typescript AutoFormatBuffer clang-format
"  autocmd FileType java AutoFormatBuffer google-java-format
"  autocmd FileType go AutoFormatBuffer gofmt
"  autocmd FileType python AutoFormatBuffer pyformat
"  autocmd FileType markdown AutoFormatBuffer mdformat
"augroup END
""}}} Code formatting -----------------------------------------------------------


"{{{ Misc plugin config --------------------------------------------------------
" Speed up CtrlP indexing from go/ctrlp
let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'

"}}} Misc plugin config --------------------------------------------------------


"{{{ YouCompleteMe -------------------------------------------------------------
" Most settings copied from
" https://github.com/chiphogg/dotfiles/blob/master/.vimrc

" " Turn it on for everything; it's annoying not to have it.
" let g:ycm_filetype_blacklist = {}
"
" " Always load the extra_conf file when it exists.
" let g:ycm_confirm_extra_conf = 0
"
" " Comments and strings are fair game for autocompletion.
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_complete_in_comments_and_strings = 1
"
" " Skip the preview window.
" " let g:ycm_add_preview_to_completeopt = 0
"
" " Start autocompleting right away, after a single character!
" " let g:ycm_min_num_of_chars_for_completion = 1
"
" " This gives me nice autocompletion for C++ #include's if I change vim's
" " working directory to the project root.
" " let g:ycm_filepath_completion_use_working_dir = 1
"
" " Add programming language keywords to the autocomplete list.
" " let g:ycm_seed_identifiers_with_syntax = 1

" The signs are nice, but they're way too slow for me.
let g:ycm_enable_diagnostic_signs = 0

" This can change the location list out from under me.  Instead, populate it
" manually using :YcmDiags.
" let g:ycm_always_populate_location_list = 0
" let g:ycm_open_loclist_on_ycm_diags = 0

" Highlight the errors in yellow instead of red, so red text is readable.
highlight YcmErrorSection ctermbg=yellow

" g] and ctrl-] map to the GoTo subcommand
nnoremap <silent> g] :YcmCompleter GoTo<CR>
nnoremap <silent> <c-]> :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>

" Force a *synchronous* compile-and-check.
" (Caution!  Blocking, and potentially slow.)
nnoremap <silent> <Leader>c :YcmForceCompileAndDiagnostics<CR>
" Try this before restarting vim (useful if the cache gets stale).
nnoremap <silent> <Leader>C :YcmCompleter ClearCompilationFlagCache<CR>
" Repopulate the location list.
nnoremap <silent> <Leader>l :YcmDiags<CR>

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

"}}} YouCompleteMe -------------------------------------------------------------


"{{{ Misc key remappings -------------------------------------------------------
" Ctrl-Left or Ctrl-Right: go to the previous or next tabs
" Alt-Left or Alt-Right: move the current tab to the left or right.
nnoremap <c-Left> :tabprevious<CR>
nnoremap <c-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

noremap <M-1> :buffer! 1<CR>
noremap <M-2> :buffer! 2<CR>
noremap <M-3> :buffer! 3<CR>
noremap <M-4> :buffer! 4<CR>
noremap <M-5> :buffer! 5<CR>
noremap <M-6> :buffer! 6<CR>
noremap <M-7> :buffer! 7<CR>
noremap <M-8> :buffer! 8<CR>
noremap <M-9> :buffer! 9<CR>
noremap <M-n> :bnext!<CR>
noremap <M-p> :bprevious!<CR>
noremap <M-t> :%s/ *$//<CR>
noremap <c-1> :buffer! 1<CR>
noremap <c-2> :buffer! 2<CR>
noremap <c-3> :buffer! 3<CR>
noremap <c-4> :buffer! 4<CR>
noremap <c-5> :buffer! 5<CR>
noremap <c-6> :buffer! 6<CR>
noremap <c-7> :buffer! 7<CR>
noremap <c-8> :buffer! 8<CR>
noremap <c-9> :buffer! 9<CR>
noremap <c-h> /never_match_pattern<CR>
noremap <c-t> :%s/ *$//<CR>
noremap ggt :call vim#move_datatool_focus#MoveDatatoolFocus()<CR><CR>


"}}} Misc key remappings -------------------------------------------------------
