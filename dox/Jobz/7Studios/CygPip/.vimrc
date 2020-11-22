" 81FIRGB - .vimrc by Pip Stuart <Pip@CPAN.Org>,<PipStuart@GMail.Com>
"set? || setl(ocal)?  " when setting, trailing the variable w/ bang (!) || prepending 'inv' will toggle the boolean flag's value
se nocp               " nocompatible    - Add vim enhancements without striving for vi compatibility
" Study Vim.Org/tips && Vim.Wikia.Com for more tips && examples, like this one on making .vimrc portable, avoiding error messages when environment changes:
"  1. Check version:             if version >= 600 | set foldcolumn=2 | en
"  2. Use environment variables: source          $VIMRUNTIME/vimrc_example.vim
"  3. Loading scripts (especially useful for scripts just merged into standard macros, but note that :runtime command might be better way to do this):
"                                if filereadable($VIMRUNTIME ."/macros/matchit.vim") | source $VIMRUNTIME/macros/matchit.vim | en
"source $VIMRUNTIME/mswin.vim " ack! I don't want Windows stupid Ctrl-xcv behavior!  I need my Ctrl-v block highlighting.
"behave mswin
se list               " list            - Show tab and newline characters (just `se l` should werk according to the dox but it chokes =( )
"se ru                 " ruler           - Show cursor line and column in status bar
se hid                " hidden
se et                 " expandtab
se ts=8               " tabstop=8
se sw=2               " shiftwidth=2    - was 4 before 2
"se sts=2              " softtabstop=2
"se sr                 " shiftround      - Always indent/outdent to the nearest tabstop
se ls=2               " laststatus=2
se wm=0               " wrapmargin=0    - not used when tw has a value
"se tw=0               " textwidth=0
"let g:leave_my_textwidth_alone=1 " This stops the autocommand in /etc/vim/vimrc from forcing textwidth=78 for *.txt
se ai                 " autoindent
se nobk               " nobackup
se backspace=indent,eol,start
se sc                 " showcmd         - Show (partial) command in status line.
se sm                 " showmatch       - Show Matching brackets.
se ic                 " ignorecase      - Do Case-Insensitive matching
se is                 " incsearch       - Incremental  Search
se nohlsearch         " noh?            - No HighLight search
se aw                 " autowrite       - Automatically save before commands like :next and :make
"se ve                 " virtualedit     - Allows cursor to move past EOL
"se ek                 " esckeys         - Disables Escape key sequences in insert mode so that Esc exits immediately... but better to just lower timeout below
se to tm=300 ttm=100  " timeout timeoutlen=300 ttimeoutlen=100 - Milliseconds waited for mapped sequence completion or key code respectively
" next line viminfo='50,<1000,s100,:0,n~/vim/viminfo - this stops my Win32 vim from creating extraneous _viminfo files under 4NT
se vi='255,n~/.viminfo
"se gcr=a:block-Cursor " guicursor: turn blinking off
se background=dark    " setting the background to dark makes syntax highlighting colors work more consistently with better contrast (w/o drkblu cmntz)
se clipboard=unnamed  " setting the clipboard to unnamed uses the QuoteStar * default global GPM mouse clipboard for any local cp/paste,see :help quotestar
se go+=aA             " makes Visual && modeless selections auto-cp to the global GPM clipboard (which they usually seem to do anyway) ,see :help guioptions
" it should be possible to append to the current clipboard buffer w/ something like: :let @q=@*<CR>"Qy:let @*=@q<CR>
"se mouse=a            " mk vim ctrl the mouse so it can temporarily toggle ai for MiddleClick pasting
se mousehide          " hide the mouse when typing text
"if $expr elseif? $expr el(se)? cmd en(dif)?
if &term == "linux"
  se t_ve+=[?6c " termcap cursor visible settings 6, 2, 113;0;114, 113;0;128 where I prefer the blinking hw versions over the colorful but still sw ones
en "dif
if &term == "xterm" || &term == "screen"
  se t_kb=      " this enables BackSpace to behave consistently thru CygWin
"  se t_kD=^v<Delete>
"  fix " since Taki's vim bkspc mks ^? through CygWin's xterm sshd connection, fixdel switches t_kb && t_kD from ^? && ^H to <Del> but I want <BS> =(
en
se t_cv= " set the cursor to be included in visual selections even if it can't be invis && here's a <CR> char for when literal needed: 
se t_ci=
" below: auto-runs `perl -c` when saving Perl code
"au BufWritePost *.pl,*.pm !perl -c %
setl   spell spelllang=en " use local English SpelCkr for ASCII,Latin1,UTF-8 try :help spell
setl nospell              " setup SpelCkr lang then turn off by default
"(([clisnoxv](un)?|un)m|map) cmdln,[ci],insrt-only,sele,norm,oper-pendng,visual,[sv] modes w/ <(C|S|[AM])- for Ctrl,Shft,&&(Alt==Meta)    map  == all([nov])map
" preceding mapped key w/ <silent> tells Vim not to print msg when running cmd    exception sm==smagic (substitution) so use smap         map! == all( [ci])map
" below: F gets mapped to Autoformat whatever paragraph of text cursor is in, according to: $(TERM|DISPLAY) == "" || $COMSPEC != "C:\WINDOWS\system32\cmd.exe"
if   $OS       == "Windows_NT" && $TERM    == ""  " probably means I'm in a Win32 (4NT|Cmd).Exe shell so... handle shell quotes differently
  if $PipsCols == "160"        || $COLUMNS == "160"
    map  F !G perl -MText::Autoformat -e"$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0,right=>152});print$t"<CR>
  el
    map  F !G perl -MText::Autoformat -e"$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0           });print$t"<CR><CR>
  en
el
  if $PipsCols == "160"        || $COLUMNS == "160" " still may need some dum2umd after this when in CygWin because fmt is giving some ^M
    map  F !G perl -MText::Autoformat -e'$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0,right=>152});print$t'<CR>
  el
    map  F !G perl -MText::Autoformat -e'$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0           });print$t'<CR>
  en
en
"        B saves && backs-up current EditFile
map      B :w!<CR>:!bak  %<CR><CR>
"        U saves && updates  current EditFile into local ~/(lib|bin)/
map      U :w!<CR>:!updt %<CR><CR>
"map      E JJj
"        t key inserts current PipTime: `pt`
map      t i<CR><Esc>k:r!pt<CR>k$:j!<CR>J
"        T key updates `pt` in $VERSION = '$mjvr.$mnvr.$ptvr' line
map      T :0<CR>/$VERSION<CR>8wdwi<CR><Esc>k:r!pt<CR>k$:j!<CR>Jx7h
"      C-t key inserts `ptg` into both XOrg Primary && Clipboard buffers
map   <C-t> :r!ptg<CR>"+YVD
map   <C-n> :bn<CR>
map   <C-p> :bp<CR>
"map   <C-h> :se   hls!<CR>
map   <C-l> :se  list!<CR>
map   <C-k> :se spell!<CR>
" mapping MiddleMouse only works if mouse=a so that vim's mapping is applied instead whichever of XOrg,FluxBox,or GPM 
map <MiddleMouse> :se paste<CR>"*p:se nopaste<CR>
" note: may still want to map other mouse=a buttons to behave more similarly to mouse=
map <S-F12> :if &mouse != 'a'<CR>se mouse=a<CR>el<CR>se mouse= <CR>en<CR><CR>
"map   <F12> :if &paste       <CR>se nopaste<CR>el<CR>se paste  <CR>en<CR><CR>
map   <F12> :se paste!<CR>
"se pt=<F12>           " pt == pastetoggle ... but need some way to show paste status, maybe along status bar
"map   <F12> :call InvertPasteAndMouse()<CR>
"map <C-l> :if &list<CR>se nolist<CR>el<CR>se list<CR>en<CR><CR>
"sy(n(tax)?)? (on|off|sync fromstart)
sy on
sy sync fromstart
"[clisnoxv]?ab(brev)? || [clisnoxv]?una(bbrev)? $abrv, :abc for all ab clear
"cab p perldo
"  '" jumps to last open position in file  ... This is in my .zshrc e()
"  '. jumps to last edit position in file
" Make p in Visual mode replace the selected text with the "" register.
"(snor(emap)?|[cio]?no(remap)?|[lnxv]n(oremap)?|no(remap)?!) $LftHndSide $RitHndSide disallows mapping of $RHS to avoid nested && recursive maps or redef a cmd
vn p <Esc>:let current_reg = @"<CR>gvdi<C-r>=current_reg<CR><Esc>
if has("autocmd")
  "filet(ype)? (plugin)? on  " plugin on auto-enables both regular filet detection && plugin loading
  filet plugin on
"  se grepprg=grep\ -nH\ $* " uncomment this line to use latexSuite plugin
en
if has('statusline') " Custom statusline display detail: (maybe tweak colors to look better w/o reverse)
  hi StatusLine term=bold,reverse cterm=bold ctermbg=DarkBlue
  " %f                                                 file path
  " %y                                                 file type between braces (if defined)
  " %([%R%M]%)                                         read-only, modified and modifiable flags between braces
  " %{'!'[&ff=='default_file_format']}                 shows a '!' if the file format is not the platform default
  " %{'$'[!&list]}                                     shows a '*' if in list mode
  " %{'~'[&pm=='']}                                    shows a '~' if in patchmode
  " (%{synIDattr(synID(line('.'),col('.'),0),'name')}) only for debug : display the current syntax item name
  " %=                                                 right-align following items
  " #%n                                                buffer number
  " %l/%L,%c%V                                         line number, total number of lines, and column number
  fu SetStatusLineStyle()
    if &stl == '' || &stl =~ 'synID'
      "let &stl="%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P"                    " this emulates the standard statusline with 'ruler' set
      "let &stl="%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'" " displays byte count and byte value, modified flag in red
      ":hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
      ":so $VIMRUNTIME/syntax/hitest.vim " will open new window containing all highlight group names, displayed in their own color
      "let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=kmap:%k mouse:%1(%{&mouse}%) paste:%{&paste} ord:%03b/x%2B #%n %4l/%-4L(%P),%3c%V %7{system('pt')} " " this one is cooler because it updates the `pt` in the stl all the time but it creates junk in the text && slows down too much
      let &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff=='".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm=='']}%=%6*m%1(%{&mouse}%)%7*p%{&paste} %1*%03b%*/%2*x%02B %*#%3*%n %4*%4l%*/%5*%-4L%*(%6*%P%*),%5(%7*%3c%1*%2(%V%)%) " . system('pt -v')
      :hi User1 term=bold,reverse cterm=bold ctermfg=Red       ctermbg=DarkBlue
      :hi User2 term=bold,reverse cterm=bold ctermfg=DarkYellow ctermbg=DarkBlue
      :hi User3 term=bold,reverse cterm=bold ctermfg=Yellow    ctermbg=DarkBlue
      :hi User4 term=bold,reverse cterm=bold ctermfg=Green     ctermbg=DarkBlue
      :hi User5 term=bold,reverse cterm=bold ctermfg=Cyan      ctermbg=DarkBlue
      :hi User6 term=bold,reverse cterm=bold ctermfg=Blue      ctermbg=DarkBlue
      :hi User7 term=bold,reverse cterm=bold ctermfg=Magenta   ctermbg=DarkBlue
    el
      let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
    en
    "if &paste != ''
      "let &stl.="  "
    "el
      "let &stl.="no"
    "en
    "let &stl.="paste "
  endf " Switch between the normal and vim-debug modes in the status line
  nmap _ds :call SetStatusLineStyle()<CR>
  call           SetStatusLineStyle()
  if has('title') " Window title
    se titlestring=%t%(\ [%R%M]%)
  en
en
"se diffexpr=MyDiff()
"fu(nction)?!? ... (retu(rn) $expr)? endf(unction)? delf(unction)? where the optional trailing bang (!) will silently force overwriting any existing fu def
fu MyDiff()
  let opt = ''
  if &diffopt =~ 'icase'  | let opt = opt . '-i ' | en
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | en
  "sil(ent!?)? exe(cute)? $expr  " sil skips StdOut && .= ! also skips StdErr
  sil exe '!diff -a ' . opt . '"' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
endf
fu! InvertPasteAndMouse() " toggle paste / mouse mode
  if  &mouse == ''
    se mouse=a | se nopaste
    echo "mouse mode on , paste mode off"
  el
    se mouse=  | se   paste
    echo "mouse mode off, paste mode on "
  en
endf
se tw=0               " textwidth=0
let g:leave_my_textwidth_alone=1 " This stops the autocommand in /etc/vim/vimrc from forcing textwidth=78 for *.txt
