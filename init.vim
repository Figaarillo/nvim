" ==============================
"					BASIC CONFIG
" ==============================

"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"/let &packpath = &runtimepath
"source ~/.vimrc

syntax enable
set number																											"add number to the side
set numberwidth=1
set title																												"show the file name
set mouse=a																											"allows interact with the mouse inside vim
set cursorline																									"highlight the current line
set hidden																											"allows switch between buffers and not closing them 
set nowrap
set scrolloff=8

" Config the indent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set sw=2																												"allows indenting with 2 sPlug 'ervandew/supertab'paces instead of tabs

" Color schemes configs
set background=dark
set termguicolors																								"turn on true color in terminal
set hlsearch																										"TODO: search a definition

" other commans
set showcmd																											"show the commands
set encoding=utf-8
set spelllang=en,es																							"correct the words using Spanish and English dictionary
set clipboard=unnamed																						"to be able to use the OS clipboard
set showmatch																										"show where the parentheses close
set relativenumber																							"shows numbers relative to our position
set laststatus=2																								"TODO: search a definition

" ===============================
"					KEY MAPPING
" ===============================
	
let mapleader=";"																								"leader key


nmap <Leader>w :bdelete<CR>																			"to close current buffer
nmap <Leader>r :so<CR>																					"to refresh the changes
nmap <Leader>pi :PlugInstall<CR>																"to install the plugs
nmap <Leader>pu :PlugUpdate<CR>																	"to update the plugs
nmap <Leader>d :bdelete<CR>

" Without leader key
nmap <A-C-j> :NERDTreeToggle<CR>																"to open neerdTree [ctrl+atl+j]
nmap <C-s> :w<CR>           																		"to save [ctrl+s]
imap <C-s> <Esc>:w<CR>																					"to save [ctrl+s]
nmap <C-A-h> :bprevious<CR>
nmap <C-A-l> :bnext<CR>
nmap <C-z> :u<CR>																								"to 
nmap <C-o> O<Esc>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

" Run code
augroup exe_code
  autocmd!

  autocmd FileType python nmap <buffer> <leader>b
          \ :sp<CR> :term python3 %<CR> :startinsert<CR>

  autocmd FileType javascript nmap <buffer> <leader>b
          \ :sp<CR> :term nodejs %<CR> :startinsert<CR>

 
" ===============================
"							PLUGS
" ===============================

call plug#begin('~/AppData/Local/nvim/plugged')

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }													"theme	
Plug 'ayu-theme/ayu-vim' 
Plug 'sheerun/vim-polyglot'																			"collection of a lenguage packs

Plug 'easymotion/vim-easymotion'																"plug to move much easier

" FileExp: NeerdTree | Git status | FileIcons
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'

Plug 'christoomey/vim-tmux-navigator'														"plug to move between tabs

" Status bar
Plug 'vim-airline/vim-airline'																	"plug to status bar
Plug 'vim-airline/vim-airline-themes'														"plug to themes to status ba

" Autocomplete: COC
Plug 'neovim/nvim-lspconfig'                                    "language server
Plug 'nvim-lua/completion-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" JS-sintax
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

" Emmet
Plug 'mattn/emmet-vim'

" SuperTab
Plug 'ervandew/supertab'																			"to navigato between <C-n> / <C-p> sugerences with tab

" Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

" Autosave
Plug 'Pocco81/AutoSave.nvim'

" Pairs color
Plug 'frazrepo/vim-rainbow'

" <Ctrl> + p
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'

" AutoPairs
Plug 'jiangmiao/auto-pairs'

" Comments
Plug 'preservim/nerdcommenter'

" Terminal
Plug 'akinsho/toggleterm.nvim'

call plug#end()


" ===============================
"					PlUGS CONFIGS  
" ===============================

" Themes config
colorscheme dracula
let ayucolor="dark"   " for dark version of theme


" Easymotion
nmap <C-f> <Plug>(easymotion-s2)

" Supertab config
let g:SuperTabDefaultCompletionType = '<c-n>'

" Vim airline
let g:airline#extensions#tabline#enabled=1											"show open buffers (as tabs)
let g:airline#extensions#tabline#fnamemod=':t'									"show only file name
let g:airline#extensions#tabline#formatter='unique_tail_improved'				"format to the tabbar
let g:airline_detect_spelllang=1
let g:airline_powerline_fonts = 1																"fonttrma[
let g:airline_theme='dracula'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Js snippets config
let g:utilSnipsExpandTrigger="<tab>"

" Emmet config
let g:user_emmet_mode='n'																				" in global mode use emmet nomrmal mode
let g:user_emmet_leader_key=","
let g:user_emmet_setttings={
	\ 'javascript': {
	 \ 'extends': 'jsx'
	  \ }
  \ }

" Prettier config / need prev install by coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <C-A-s> :Prettier<CR>			

" Autosave config
lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

" Pair colors config
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" Commentary
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" NerdTree config
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" Ejecutar comandos con alt-enter :Commands
let g:fzf_commands_expect = 'alt-enter'
" Guardar historial de búsquedas
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Empezar a buscar presionando Ctrl + p
nnoremap <C-p> :Files<CR>

" Archivos ignorados
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Ignorar archivos en .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" LSP config
lua << EOF
require'lspconfig'.tsserver.setup{n_attach=require'completion'.on_attach}
EOF

" COC configs

set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion in neovim with ctrl+space
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"TODO: 
"so ~/.config/nvim/maps.vim
"so ~/.config/nvim/plugins.vim
"so ~/.config/nvim/plugin-config.vim"



