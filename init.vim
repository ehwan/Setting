" Plugins loading
call plug#begin( '~/.config/nvim/plugged' )

Plug 'chriskempson/vim-tomorrow-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plug 'tikhomirov/vim-glsl'
"Plug 'keith/swift.vim'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'andweeb/presence.nvim'
" :Copilot setup
Plug 'github/copilot.vim'
"Plug 'apple/sourcekit-lsp' ", { 'branch': 'swift-5.1-branch' }

call plug#end()


"force auto completion trigger
let s:trigger_dict = {
      \'c':[ '\k\k', "->" , '\.' ],
      \'cpp':[ '\k\k', "::" , "->" , '\.' ],
      \'rust':[ '\k\k', "::", '\.' ],
      \'python':['\k\k','\.'],
      \'cl':['\k\k',"->",'\.'],
      \'swift':['\k\k','\.'],
      \}

function s:initialize()
  for l:k in keys(s:trigger_dict)
    let l:patterns = s:trigger_dict[l:k]
    if type(l:patterns) == type([]) && len(l:patterns) >= 1
      let l:pout = join( l:patterns, '\)\|\(' )
      let s:trigger_dict[l:k] = '\m\('.l:pout.'\)$'
    endif
  endfor
endfunction
call s:initialize()


function <SID>force_trigger_completion()
  call feedkeys( "\<c-x>\<c-o>" )
  return ""
endfunction


function s:is_tail_trigger()
  " get last 2 characters
  let l:len = 2
  let l:tail = strpart(getline('.'), col('.')-l:len, l:len-1).v:char

  " word in force-completion-trigger dict
  return l:tail =~ s:trigger_dict[&filetype]
endfunction

function s:insertcharpre()
  if s:is_tail_trigger()
    call <SID>force_trigger_completion()
  endif
endfunction

let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 0
"let g:lsp_highlight_references_enabled = 0
let g:lsp_virtual_text_enabled = 0
let g:lsp_preview_doubletap = 0
let g:lsp_signature_help_enabled = 1
let g:lsp_fold_enabled = 0
autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'pyright',
      \ 'cmd': {server_info->
      \   ['pyright-langserver', '--stdio']},
      \ 'whitelist': ['python']
      \ })
autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': {server_info->
      \   [
      \     '/usr/bin/clangd',
      \     '--compile-commands-dir=~/.config/nvim/',
      \     '--completion-style=detailed',
      \     '--function-arg-placeholders',
      \     '--header-insertion=never',
      \     '--background-index=false',
      \   ]},
      \ 'whitelist': ['c', 'cpp'],
      \ })
autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->
      \   [
      \     '/Users/ehwan/.cargo/bin/rust-analyzer'
      \   ]},
      \ 'whitelist': ['rust'],
      \ 'initialization_options': {
      \   'cargo': {
      \      'buildScripts': {
      \         'enable': v:true,
      \       },
      \      'procMacro': {
      \         'enable': v:true,
      \       },
      \   },
      \ }
      \ })
autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'clangd-cl',
      \ 'cmd': {server_info->
      \   [
      \     '/usr/bin/clangd',
      \     '--compile-commands-dir=~/.config/nvim/clcompile',
      \     '--completion-style=detailed',
      \     '--function-arg-placeholders',
      \     '--header-insertion=never',
      \     '--background-index=false',
      \   ]},
      \ 'whitelist': ['cl'],
      \ })
autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'sourcekit-lsp',
      \ 'cmd': {server_info->
      \['sourcekit-lsp']},
      \ 'whitelist': ['swift']
      \ })


function s:completion_set()
  setlocal omnifunc=lsp#complete
  inoremap <buffer><expr> <c-space> <SID>force_trigger_completion()
  inoremap <buffer><expr> <c-n> pumvisible()?"\<c-n>":<SID>force_trigger_completion()
  nnoremap <buffer> \g :LspDefinition<cr>
  nnoremap <buffer> \d :LspDefinition<cr>
  nnoremap <buffer> \h :LspHover<cr>
  nnoremap <buffer> \n :LspNextReference<cr>
  nnoremap <buffer> \p :LspPreviousReference<cr>
  nnoremap <buffer> \r :LspRename<cr>
  nnoremap <buffer> \f :LspDocumentFormat<cr>
  vnoremap <buffer> \f :LspDocumentRangeFormat<cr>
  nnoremap <buffer> \t :LspPeekTypeDefinition<cr>
  nnoremap <buffer> \s :LspSignatureHelp<cr>
  augroup completion_group
    autocmd!
    autocmd InsertCharPre <buffer> call s:insertcharpre()
    autocmd CompleteDone <buffer> pclose
    autocmd InsertLeave <buffer> pclose
    autocmd BufWritePre <buffer> :LspDocumentFormatSync
  augroup END
endfunction
autocmd User lsp_buffer_enabled call s:completion_set()

au BufNewFile,BufRead,BufReadPost *.cl set filetype=cl


set shortmess+=c

" vim-airline
let g:airline_extensions = [ 'tabline' ]
let g:airline_exclude_preview = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 0
let g:airline_section_z = '%3.4l,%-2.3c 0x%02.2B'


" NERDComment
let g:NERDCommentEmptyLines = 1
nmap // <leader>c<space>
vmap // <leader>c<space>

nnoremap <tab> :NERDTreeToggle<CR>

let g:python3_host_prog = 'python'
let g:loaded_python_provider = 1

set list
set colorcolumn=80

set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

colorscheme Tomorrow-Night-Eighties

set number
set relativenumber

set completeopt=menuone,noinsert,noselect,preview

"set previewheight=6
set nowritebackup
set noswapfile


noremap ; :
noremap : ;
inoremap qq <esc>
inoremap Qq <esc>
inoremap QQ <esc>
nnoremap q <esc>
nnoremap Q <nop>
vnoremap q <esc>
vnoremap S s
nnoremap ! q

noremap J 4j
noremap K 4k
noremap H ^
noremap L $

"noremap . <nop>
noremap . %

noremap \[ :bp!<cr>
noremap \] :bn!<cr>

set rtp+=/opt/homebrew/opt/fzf
nnoremap <c-p> :FZF<cr>
