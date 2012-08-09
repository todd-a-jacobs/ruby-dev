" vim: tw=78 sw=2

set nocompatible
set backspace=indent,eol,start
set shiftwidth=4	" sw
set autoindent		" ai
set textwidth=72	" tw
set nojoinspaces
set visualbell
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set formatoptions=tcqln
set tags+=./TAGS;/

if version >= 730
  set cryptmethod=blowfish
endif

" reformat inner paragraph to current text-width.
map Q gqip2+
" toggle paste mode
map pp :set invpaste<CR>
" toggle line numbers
map nn :set invnumber<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters
  au FileType text setlocal textwidth=78

  " Make .md a synonym for Markdown.
  au BufRead,BufNewFile *.md,*.markdown setlocal filetype=markdown sw=4 et

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Settings for Ruby-related files.
  au BufRead,BufNewFile *.rb,*.rhtml,Rakefile,Gemfile,*gemspec
     \ setlocal sw=2 tw=80 et fdm=syntax
  au BufRead,BufNewFile *.haml* setlocal filetype=haml ts=2 sw=2 et
  au Filetype ruby iab <buffer> ;d def<CR>end<CR><ESC>(A

  " Preserve tabs in shell scripts to avoid breaking here-documents.
  au BufRead,BufNewFile *.sh setlocal noet

  " Settings for Puppet manifests.
  au BufRead,BufNewFile *.pp setlocal sw=2 et

  augroup html_abbreviations
    au Filetype html :imap <buffer> ;m<SPACE> &mdash;
    au Filetype html :nmap <buffer> ;m :%s!\([[:alnum:]]\)--\([^-]\)!\1\&mdash;\2!g<CR>
  augroup END

  " Try to prevent password files from leaking data.
  augroup passwords
    au BufNewFile,BufReadPre pw setlocal cm=blowfish
    au BufNewFile,BufReadPre pw setlocal noswapfile
    au BufNewFile,BufReadPre pw setlocal nobackup
    au BufNewFile,BufReadPre pw setlocal noshelltemp
    au BufNewFile,BufReadPre pw setlocal history=5
    au BufNewFile,BufReadPre pw setlocal viminfo=
  augroup END
endif

if $HOSTNAME == "vagrant"
endif

if has("win32")
elseif has("unix")
elseif has("macunix")
endif
