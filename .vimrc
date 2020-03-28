" EBQLIh15:.vimrc by PipStuart <Pip@CPAN.Org> to highly customize my Vim sessions to have my favorite status bar, edit settings, key mappings, && behaviors;
" 2du:stuD Conway's awesome code&&plugins at bottom,stuD HTTPS://Statico.GitHub.IO/vim.html && vim[23].html,ckout best HTTPS://VimAwesome.Com plugins too,
"   also stuD HTTPS://GitHub.Com/airblade/vim-gitgutter if I might want 2du some local diffs between changed code hunk lines instead of usual side-by-side
"     (although that may throw many of my :se list! Ctrl-L past 160), reread && stuD useful 8-Year veteran HTTPS://TomJWatson.Com/blog/vim-tips && practice,
"   stuD best plug-in managers && autom8 loading of best loc8d JSX inline syntax support (instead of persisting with antiqu8d manual plug-in configur8ions);
" Note:HTTPS://Reddit.Com/r/vim/comments/9kpsvd/is_there_a_way_to_have_shortcuts_in_vim_to details using :mksession && UprCase marks 2 autom8 loading files;
"      HTTPS://Joel.Porquet.Org/wiki/hacking/vim_konsole has a pretty good little article about mapping Vim && Zsh keyz from within KDE's konsole terminal;
"set? || setl(ocal)? || let   " wN setting, trailing variable wi bang (!) || prepending 'inv' wil togl boolean flag's value; trail ? 2 query;  BlO so(urce)?
se   nocp                     " nocompatible    - add  Vim NhancmNtz without strIving for vi compatibility (mustB1stBcuzit chngz othr optnz as side effect)
se    enc=utf-8               "     encoding    - was already loading utf-8 from current $LANG locale, && might need termencoding also if they diverge
"se  fenc=utf-8               " fileencoding    - might needed this if ever trying LightLine + ALE with special chars from HTTPS://StaticO.GitHub.IO/vim3.html
let  g:VERSION='0.0'
let     g:d8VS='K3SM2vXs'     " d8VersionString - l8st significant upd8 to whole file was then
let     g:vid8=system('d8')   " VimInit d8      - save d8 when this Vim session first stRtz up to use as dRk pRt at Nd of STatusLine just before bright upd8 d8
let     g:cucf=1              " CUrsorColumFlag - flag to toggle whether :se cuc should be used (since dflt of it on gets slow whN lots of syntx hili on scrn)
let     g:culb=1              " CUrsorLineBold  - flag to toggle whether :se cul below should use highlight with bold across whole line (dbl-mapd2Ctrl-L&&hls)
"so  $VIMRUNTIME/mswin.vim    "be mswin         - ick! du*not*want! MSWindowsCtrl-xcv sux compared2 swEt Ctrl-v hIlIt blox sO nO source or behave on that crap!
" HTTPS://GitHub.Com/junegunn/vim-plug && HTTPS://Drivy.Engineering/setting-up-vim-for-react hopefully for future plugins && React_n8ive dvl && also had to
"   install HTTPS://FaceBook.GitHub.IO/watchman to be able to `npm start` in ~/dvl/t8/rn8v/d8st after `create-react-native-app d8st` did initial setup.
" It also required `agi python-dev` in order to have the proper Python.h file for watchman to be able to make properly before `sudo make install`;
call  plug#begin('~/.vim/vim-plug') " this was frustr8ingly setting fo formatoptions=croql && auto-extending comments messing up my T map to upd8 d8VS d8a
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call  plug#end()
se   list                     " l?              - show Tab(\t <Tab>) && NewLine(\n \<CR>) charactrz(&&my Ctrl-l mapng BlO toglz this option) (bkslshB4CRjust2..
"se  ru                       " ruler           - show cursor line && column in status bar  (my stl addz these separ8ly in my preferred way)   ..fix synhilitz)
se   hid                      " hidden
se   et                       " expandtab       - cnv tabz 2 spcz
se   ts=8                     " tabstop=8
se   sw=2                     " shiftwidth=2    - was 4 before 2
"se  sts=2                    " softtabstop=2
"se  sr                       " shiftround      - setting this should always indent/outdent 2 nearest tabstop
se   ls=2                     " laststatus=2
se   tw=0                     " textwidth=0     - this should NAbl Vim 2 Dtect width from shL && term rather than Xplicit 78,but mAB shudBset2 158 nstd?
let  g:leave_my_textwidth_alone=1 " this stops the autocommand in /etc/vim/vimrc from forcing textwidth=78 for *.txt
se   fo=ql                    " formatoptions   - I think new vim-plug ins set this to 'croql' but auto-commentz messup my T d8VS map. see :help fo-table
se     ai                     "    autoindent
se   nosi                     " nosmartindent
se   nocin                    " nocindent
se      inde=                 "    indentexpr=
se   nobk                     " nobackup
se   backspace=indent,eol,start
se   ml                       " modeline        - allow parsing of modeline commentz (such as '! vim:syntax=xdefaults' at the end of my ~/.Xrc)
se   mls=8                    " modelines       - how many lines are checked for set commandz (default is 5)
se   sc                       " showcmd         - shO (partial) command in status line
se   sm                       " showmatch       - shO matching bracketz
se   ic                       " ignorecase      - du case-insensitive matching
se   is                       " incsearch       - incremNtal srch
se   nohls                    " nohlsearch noh? - nO hIlIt   srch
se   aw                       " autowrite       - autOmatically sAv BfOr cmdz lIk :next && :make
"se  ve                       " virtualedit     - allowz cursor 2 mv past EOL (like old MSDOS qedit used to fondly do, although vim seemed quirkier)
"se  ek                       " esckeys         - disAblz Escape key sEquNcez in insert mOd sO Esc Xitz imED8ly... but betr 2 just lOwr timeout BlO
se   to tm=300 ttm=100        " timeout timeoutlen=300 ttimeoutlen=100 - Milliseconds waited for mapped sequence completion or key code respectively
se   vi='255,n~/.viminfo      " ' " viminfo='50,<1000,s100,:0,n~/vim/viminfo - this stops my Win32 vim from creating extraneous _viminfo files under 4NT
"se  gcr=a:block-Cursor       " guicursor: turn blinking off
se   background=dark          " set background 2 dark mkz syntax hIlIting colrz work more consistNtly wi betr contrast (without dRkblu cmNtz)
se   clipboard=unnamed        " set clipboard  2 unnamed uses the QuoteStar * default global GPM mouse clipboard for any local cp/paste,see :help quotestar
se   go+=aA                   " mkz Visual && modeless selections auto-cp 2 global GPM clipboard (wich they usually sEm 2 du NEwA),see :help guioptions
" it shud B posibl 2 apNd 2 curNt clipboard bufr wi smthng lIk: :let @q=@*<CR>"Qy:let @*=@q<CR>
"se  mouse=a                  " mk vim ctrl the mouse so it can temporarily toggle ai for MiddleClick pasting
se   mh                       " mousehide       - hide the mouse when typing text
"if  $expr <CR> cmd <CR> (elseif? $expr <CR> cmd <CR>)* (el(se)? cmd <CR>)? en(dif)? &&bSt2Use cAs-sNsitv cmparison vs ambiguous plain or ==? Xplicit ignorcase
if   &term ==#        "linux"
  se   t_ve+=[?6c           " termcap cursor visible setngz 6, 2, 113;0;114, 113;0;128 where I prEfr blinking hw versionz Ovr colrful but still sw ones
en "dif
if   &term ==# "screen.linux"
  se   t_ve+=[34l           " console cursor tipz from HTTP://SF.Net/p/tmux/mailman/message/29594950/ probably require me to upd8 my termcap entry bleh
" au   InsertEnter * set t_ve+=[34h^[[?25h  " cnorm  " the above t_ve seemz to have fixed my block cursor in full-screen linux console running vim in scrn
" au   InsertLeave * set t_ve+=[34l         " cvvis  " but uncommenting these au commandz leavez junk all in my vim! =(
" autocmd VimLeave * set t_ve+=[34h^[[?25h  " cnorm
en
if   &term ==# "screen" || &term ==# "xterm"
  se   t_kb=                " NAblz bkspc 2 BhAv consistNtly thru CygWin (wud B betr 2 ck &OSTYPE or smthng instd of just &term abov)
" se   t_kD=^v<Delete>        " not sure if maybe some Chun's console ssh to Aku multiplexing screen term to share vim edit session ruins block cursor somehow?
" fix " since Taki's old CygWin Vim bkspc mkz ^? thru xterm ssh connection, fixdel switches t_kb && t_kD from ^? && ^H to <Del> but I want <BS> =(
en " if literal <C-m> at the end below gets filtered out, might need to `v .bak/.vimrc-D8JMEEjh .vimrc` to yank line 45 there && restore here
se   t_cv=                " set the cursor to be included in visual selections even if it can't be invis && here's a <CR> char for when literal needed: 
se   t_ci=
"e   t_ti= t_te=              " set these variables to empty to stop vim from restoring the screen after exit to the way it was before invok8ion
if   has('spell')
  setl    spell spelllang=en  " use locl English SpelCkr4ASCII,Latin1,UTF-8 encodingz, try :help spell 4detailz
  setl  nospell               " setup SpelCkr lang then turn off by default
en
"(([clisnoxv](un)?|un)m|map) cmdln,[ci],insrt-only,sele,norm,oper-pendng,visual,[sv] modes wi <(C|S|[AM])- for Ctrl,Shft,&&(Alt==Meta)    map  == all([nov])map
" preceding mapped key wi <silent> tells Vim not to print msg when running cmd    exception sm==smagic (substitution) so use smap         map! == all( [ci])map
" 2du:fix C-f 2Format again below && stuD which other Ctrl cmdz (or regularz like 'E') might be currently least used, next best onez to remap when needed;
"map      F  !G perl -MText::Autoformat -e'$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0 origBlO152});print $t'<CR>  " keep F finding char on line backward
 map   <C-f> !G perl -MText::Autoformat -e'$t=join(q(),<STDIN>);$t=autoformat($t,{squeeze=>0,right=>158});print $t'<CR>
" Normal-mode Noremap C-b ("Back" PgUp) to original B Back word (as opposite of W)    " HTTP://Vim.Wikia.Com/wiki/Mapping_fast_keycodes_in_terminal_Vim 4C-S-b?
nn     <C-b> B
"         B sAvz && Bakzup curNt EditFile    " above mapz fmt over Ctrl-Forward FullPageDown since I use C-d && C-u HalfPage mainly && want F to find backward
 map      B  :call SetStatusLineStyle()<CR>:w!<CR>:!bak %<CR><CR>
"         U bakz && Upd8s  curNt EditFile in2 local ~/(lib|bin)/       " map ovrIdz Undo all changez to line since cursor moved into it (wich I don't use much)
 map      U  :call SetStatusLineStyle()<CR>:w!<CR>:!bak %<CR><CR>:!upd8 %<CR>
" many Vim hackers map just 'jj' && 'kk' as quick convenient Escapes out of Insert mode && auto-write. Also Ctrl-[ && Alt-h or Alt-l (4jmpz2 scrn line H && L):
inoremap  <C-l>    <Esc>:w<CR>:se list!<CR><C-l>
inoremap     ZZ    <Esc>:w<CR>
"noremap     JJ    <Esc>   " since insert-mode mappings delay uses of initial key && Jjk; are common enough to annoy when slowed,mine writes on rare ZZ instead
 map      E  Jj
"map      E  JJj   " old map to quickly single-space dbl-spcd linez    " If you f<char> then ; && , will repeat the find (or Til) fwd && bak on the currentline
"map      E  A:<Esc>JJj                                                " was briefly used to join up many distinct transl8ion descriptions with their quot8ions
"         t insertz  `d8`  curNt date-time stamp (used 2 B PipTime)    " T below was orig like f<char> (find4wrd on curline) but srchng T<char> (unTil bakwrdz)
 map      t  :call SetStatusLineStyle()<CR>i<CR><Esc>k:r!d8<CR>k$:j!<CR>J
"         T  upd8s   `d8`  in 1st d8VS='EBQLN3PS' lIn (shud B sAvng ai && ic,seting thM,rEplAcing d8,thN rEstOring thM) migr8d to a function now defined below
"map      T  :call SetStatusLineStyle()                      <CR>:0<CR>/d8VS=<CR>6lcw<CR><Esc>k:r!d8<CR>k$:j!<CR>Jx8h
"map      T  :call SetStatusLineStyle()<CR>:se noai<CR>:se ic<CR>:0<CR>/d8VS=<CR>6lcw<CR><Esc>k:r!d8<CR>k$:j!<CR>Jx8h:se ai<CR>
"ap       T  :call SetStatusLineStyle()<CR>:if &ai<CR>let g:vcai=1<CR>el<CR>let g:vcai=0<CR>en<CR><CR>:se noai<CR>:if &ic<CR>let g:vcic=1<CR>el<CR>let g:vcic=0<CR>en<CR><CR>:se ic<CR>:if getline('.') !~ 'd8VS'<CR>kt<CR>en<CR><CR>:call setpos('.',[0,1,1,0])<CR>/d8VS=<CR>6lcw<CR><Esc>k:r!d8<CR>k$:j!<CR>Jx8h:if g:vcai<CR>se ai<CR>el<CR>se noai<CR>en<CR><CR>:if getline('.') !~ 'd8VS'<CR>echo "'t"<CR>en<CR><CR>:if g:vcic<CR>se ic<CR>el<CR>se noic<CR>en<CR><CR>
 map      T  :keepj     call Upd8VerS()<CR>
" above command mode kt should set the mark similar to normal mode mt && ':ma(rk)? t' would also work with the space between
"       gqvKV#*\= might be unbounds (but goto, q?, visual, K?, Visual, comment #, *?, \?, =?)
"       C-ACKOVWX might be unbounds (but screen A, break C, spellchecK below, O does some awesome back thru files jumping, Visual, W has some submenu, X?);
"       C-t key inserts `d8g` into both XOrg Primary && Clipboard buffers (EvN thO d8g already wrapz xclip 2 set Primary selection buffer itself)
 map   <C-t> :call SetStatusLineStyle()<CR>:       r!d8g    <CR>"+YVD
"       C-n should detect multi-window && du next C-w window like in vimdiff instead of just separ8 full bufferz (IDly cycl thru all wndwz of Ech bufr nXt lup)
 map   <C-n> :call SetStatusLineStyle()<CR>:       bn       <CR>
"           should proly ck winnr('$') but &stl doesn't sEm Abl2shO mor than 1    " Buffer Next above, Prev below
 map   <C-p> :call SetStatusLineStyle()<CR>:       bp       <CR>
"       C-i Dfalt Indent<Tab> was togl IgnoreCase but sAmazTab,C-h DfaltBackSpace<BS> rathr togl HighLightSearch,C-l Dfalt refresh screen still done after togl
"map   <C-i>                               :       se    ic!<CR> " C-i && C-m indistnct frm Tab&&CR but C-h&&BkSpc work sepR8ly in Normal mode (but not Insert)
" I6PM7Cw8:temporarily sidelined Ctrl-H HiLightSearch togl wi curs bold for descriptive YouTu.be U2b URL squirter (mAB mvd below);
 map   <C-h>                               :       se   hls!<CR>
nn     <C-l> :call ToglCursorLineBold()<CR>:       se  list!<CR><C-l>
"imap  <C-k>                                <Esc>u:se spell!<CR> " origmapd insrtmOd Ctrl-k was autOundo4unintNded nrml insrt&&togl spLck butbetr consistNt now
imap   <C-k>            HTTPS://YouTu.be/ "" # d8:18m;<Esc>12<Left>i
nmap   <C-k> iHTTPS://BitChute.Com/video/ "" # d8:18m;<Esc>12<Left>i
" I71M6Ck8:just realized need Ctrl-w to jump Windows when doing vimdiff, so reapproprE8d C-k for spell-checKer toggle above && remapped to U2b with loop here;
" I72M7Ck8:add Insert-mode map of 2nd Ctrl-k to undo back out (16<L>31x) of an unpopul8d Normal-mode inserting of U2b templ8, also toggling spell-checK flag;
"let  g:U2bL='HTTPS://YouTu.be/ "" # d8:18m;'  " hopefully try to just insert U2b URL templ8 variable string below instead of leaving literal, not sure how2?
"nmap  <C-k> :i g:U2bL<CR>12<Left>i            " not yet sure how to colon command insert a particular global variable at cursor before adjusting auto-insert
" I88M4Ck8:initial glances through Google suggest Ctrl-k is mainly an Emacs or Gnome shortcut for deleting from cursor to end-of-line, like vim 'D' probably;
" I88M4PIE:initial glances through Go─hhogle && interestingly disabling imap C-k above && trying in insert-mode gives dark '?' then hjkl? seemed to do lines.
"   study && carefully experiment with originally available C-k behaviors && contempl8 best places to reloc8 spell-checK && U2b desKription Komponent KrE8or.
"   Also may want to remember to explore ASCII x0B for probably name && Ctrl-k mapping && maybe some other sequences, or maybe concealed somewhat deliber8ly;
" I88M6crm:ftst had 2 old notes of C-k being Vertical-Tab so apparently a somewhat weird, inconsistent, usually remappable, possibly potent, etc. capability;
"map   <C-m>                               :if &mouse != 'a'<CR>se mouse=a<CR>el<CR>se mouse= <CR>en<CR><CR>
" above toglz List (show \t&&\n,keep stndRd scrn redraw wi nnoremap),checK spelling,C-m Dfalt <CR> tried togl mouse but probz ensue when shelling out
"map <S-F12> :call SetStatusLineStyle()<CR>:if &mouse != 'a'<CR>se mouse=a<CR>el<CR>se mouse= <CR>en<CR><CR>  " My Ubuntu trapz S-F12 as VolumeUp B4 vim getzit
"map   <F12>                               :se paste!<CR>
" mapng MiddleMouse only works if mouse=a so that vim's mapping is applied instead wichever of XOrg,FluxBox,or GPM
"ap    <MiddleMouse>                       :se paste <CR>"*p:se nopaste<CR>
" nOt: mA stil want 2 map other mouse=a butnz 2 BhAv more similRly 2 mouse=
 se pt=<F12>            " pt == pastetoggle
"map   <F12> :call InvertPasteAndMouse()<CR>
"(snor(emap)?|[cio]?no(remap)?|[lnxv]n(oremap)?|no(remap)?!) $LftHndSide $RitHndSide disallows mapping of $RHS to avoid nested && recursive maps or redef a cmd
" Visual mode p to replace selected text with unnamed "" register containing text of l8st yank or delete. gv reselects previous Visual area, d deletes it,
"   then i enters insert mode. The vnoremap <C-r> inserts named register contents (instead of Redo). Following '=' is expression register for List result.
vn   p <Esc>:let current_reg = @"<CR>gvdi<C-r>=current_reg<CR><Esc>
"[clisnoxv]?ab(brev)? || [clisnoxv]?una(bbrev)? $abrv, :abc for all ab clear
"cab p perldo  " below should Format Wider from cmnd-mode after some Vis-mode selection chose lines (like Ctrl-f map on non-Vis-mode cursor paragraph above)
cab fw !fmt -w158
"  '" jumps to last open position in file  ... This was in my .zshrc e() before moving into Pip::Utl::e().
"  '. jumps to last edit position in file
au   BufNewFile,BufRead *.Xrc setf xdefaults    " add detection of my custom .Xresources file extension (instd of appending modeline '! vim:syntax=xdefaults')
"sy(n(tax)?)? (on|off|sync fromstart)
sy   on                       " this automatically turns basic `filet on` for type detection
sy   sync fromstart
fu! NrBufz() " from HTTP://SuperUser.Com/questions/345520/vim-number-of-total-buffers countz just listed ':ls' bufrz
  let     i  = bufnr(  '$')
  let     j  = 0
  while   i >= 1
    if         buflisted(i)
      let j += 1
    en
    let   i -= 1
  endwhile
  return  j
endf
if   has('autocmd')
 "filet(ype)? (plugin)? on    " plugin on autO-NAblz both regUlR filet Dtection && plugin lOding
  filet plugin off            " on is probably Useful as I had it B4 but it activ8s some indNting rulz wich messup T map && I dOn't knO how2tmp disAbl yet
  filet indent off            " indent on was recomNded by `emerge fluxbox-syntax` on gN2 Ryu long ago but T in .zshrc doesn't work4 plugin on,indent off =(
" se   grepprg=grep\ -nH\ $*  " uncomNt this lIn 2 Use latexSuite plugin
  if   !exists("autocmdz_loaded")
   "au   ... " from :h au(tocmd)<CR>:Itza good idea2hv 'au!' 2undef allB4NEautocmdzRDfynd in .vimrc || Uz this _loaded flag2avoid dupd defz wen srcd multitymz
    let         autocmdz_loaded=1
  en
en
se cul  " cursorline          " setz hIlIting on the whole cursor line(row) && column BlO but I vaguely recall having 2 ck lIk if has('color') smthng B4?
se cuc  " cursorcolumn        " mAB thEz optz used to slO editing down too much, but they no longer seem so bad && just the bg blue is generally gentle
hi        MatchParen   term=bold cterm=bold ctermfg=White
hi        CursorLine   term=bold cterm=bold ctermbg=DarkBlue
hi        CursorColumn term=bold cterm=bold ctermbg=DarkBlue
if   has('statusline')        " custom statusline display detail: (tweakd colrz 2 look betr without rEverse); 2du:stuD vim 256colr spex for hopfuly boldng all
  hi      StatusLine   term=bold cterm=bold ctermbg=DarkBlue ctermfg=White
  hi      StatusLineNC term=bold cterm=NONE ctermbg=Black    ctermfg=DarkGrey
  hi      User1                  cterm=NONE ctermbg=DarkBlue ctermfg=Red
  hi      User2                  cterm=NONE ctermbg=DarkBlue ctermfg=DarkYellow
  hi      User3                  cterm=NONE ctermbg=DarkBlue ctermfg=Yellow
  hi      User4                  cterm=NONE ctermbg=DarkBlue ctermfg=Green
  hi      User5                  cterm=NONE ctermbg=DarkBlue ctermfg=Cyan
  hi      User6                  cterm=NONE ctermbg=DarkBlue ctermfg=Blue
  hi      User7                  cterm=NONE ctermbg=DarkBlue ctermfg=Magenta
  hi      User8                  cterm=NONE ctermbg=DarkBlue ctermfg=DarkMagenta
  hi      User9                  cterm=NONE ctermbg=DarkBlue ctermfg=DarkRed
  se      fcs=stlnc:~,vert:\|,fold:-,diff:~          " set fillchars 4 difrNt mOdz
  " %f                                                 file path
  " %y                                                 file type between braces (if defined)
  " %([%R%M]%)                                         read-only, modified and modifiable flags between braces
  " %{'!'[&ff==#'default_file_format']}                shows a '!' if the file format is not the platform default
  " %{'$'[!&list]}                                     shows a '$' if in list mode
  " %{'~'[&pm==#'']}                                   shows a '~' if in patchmode
  " (%{synIDattr(synID(line('.'),col('.'),0),'name')}) only for debug : display the current syntax item name
  " %=                                                 right-align following items
  " #%n (/ %?)                                         buffer number (over total buffers open)
  " %l/%L,%c%V                                         line number, total number of lines, and column number
  fu!  SetStatusLineStyle() " should this not want fu! to silently force overwrite any existing for this too, 4 some reason? whN wil that EvN pOtNtially occur?
   "let  &stl="%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P"                    " this emulates the standard statusline with 'ruler' set
   "let  &stl="%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'" " displays byte count and byte value, modified flag in red
   ":hi  User1 term=inverse,bold cterm=inverse,bold ctermfg=red
   ":so  $VIMRUNTIME/syntax/hitest.vim " will open new window containing all highlight group names, displayed in their own color
   "let  &stl="%f %y%([%R%M]%)%{'!'[&ff==#'".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V " " VimzDbugStatusLine
   "let  &stl="%f %y%([%R%M]%)%{'!'[&ff==#'".&ff."']}%{'$'[!&list]}%{'~'[&pm==#'']}%=kmap:%k mouse:%1(%{&mouse}%) paste:%{&paste} ord:%03b/x%2B #%n %4l/%-4L(%P),%3c%V %7{system('pt')} " " this one is cooler because it updates the `pt` in the stl all the time but it creates junk in the text && slows down too much
   "let  &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff==#'".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm==#'']}%=%6*m%1(%{&mouse}%)%7*p%{&paste} %1*%03b%*/%2*x%02B %*#%3*%n %4*%4l%*/%5*%-4L%*(%6*%P%*),%5(%7*%3c%1*%2(%V%)%) " . system('pt -v')
    let  vcd8=system('d8 -v') " VimCurD8        - save (Vim-colrd) d8 when status-line was set
   "let  &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff==#'".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm==#'']}%*%< %3*%F%* %4*%o%*/%5*b?%*(%6*%p%%%*) %t %1*%h%2*%k%* %7*".&term."%4*%w%5*%a%*%=%4*%{'i'[!&g:ai]}%5*%{'p'[!&paste]}%-2(%6*%{'m'[&mouse!='']}%7*%{'c'[!&ic]}%)%1*%03b%*/%2*x%02B%*#%3*%-2.2n%4*%4.7l%*/%5*%-4.7L%*(%6*%P%*),%6(%7*%3.5c%8*%-4.5(%V%)%)%9*".g:vid8.":".vcd8
   " D8JMESCu: had 2 pull out %* White colr on byte-offset '/' 2 have room 4 nw colr in d8 (flagz: a g:ai || p paste, m mouse, i ic, h hls)
   "let  &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff==#'".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm==#'']}%*%< %3*%F%* %4*%o/%5*b?%*(%6*%p%%%*) %t %1*%h%2*%k%* %7*".&term."%4*%w%5*%a%*%=%4*%{'i'[!&g:ai]}%5*%{'p'[!&paste]}%-2(%6*%{'m'[&mouse!='']}%7*%{'c'[!&ic]}%)%1*%03b%*/%2*x%02B%*#%3*%-2.2n%4*%4.7l%*/%5*%-4.7L%*(%6*%P%*),%6(%7*%3.5c%8*%-4.5(%V%)%)%9*".g:vid8.":".vcd8
   "let  &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff==#'".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm==#'']}%*%< %3*%F%* %4*%o/%5*b?%*(%6*%p%%%*) %t %1*%h%2*%k%* %7*".&term."%4*%w%5*%a%=%4*%{'a'[!&g:ai]}%{'p'[!&paste]}%5*%{'m'[&mouse!='']}%-2(%6*%{'i'[!&ic]}%7*%{'h'[!&hls]}%)%1*%03b%*/%2*x%02B%*#%3*%-2.2n%4*%4.7l%*/%5*%-4.7L%*(%6*%P%*),%6(%7*%3.5c%8*%-4.5(%V%)%)%9*".g:vid8.":".vcd8 " EC6LA5Ga:goodB4NrBufz  but "/".winnr('$'). shud upd8 wndw cntz similRly but sEmz 2 stA 1
    let  &stl="%f %1*%y%2*%([%R%M]%)%3*%{'!'[&ff==#'".&ff."']}%4*%{'$'[!&list]}%5*%{'~'[&pm==#'']}%*%< %3*%F%* %4*%o/%5*b?%*(%6*%p%%%*) %t %1*%h%2*%k%* %7*".&term."%4*%w%5*%a%=%4*%{'a'[!&g:ai]}%{'p'[!&paste]}%5*%{'m'[&mouse==#'']}%-2(%6*%{'i'[!&ic]}%7*%{'h'[!&hls]}%)%1*%3b%*/%2*x%02B%*#%3*%n/".bufnr('$')."%4*%4.7l%*/%5*%-4.7L%*(%6*%P%*),%6(%7*%3.5c%8*%-4.5(%V%)%)%9*".g:vid8.":".vcd8
   "try2Uz reltime() && the keyz read-ahed bufr 2ck if!2busy duing edt opz2upd8 &stl wi system(b64z&&curd8z),mayb loadng &stl 1st wi all opz Dlimd4 1sys()...
   "  ||port b8(),d8(),etc.2vim! ;) "also need2add %[-0]?($min(\.$max)?)?[fFtmMrRhHwWyYknbBoO0-9lLcvVpPa\{\}\(\)TX\<=#*] && set %< smartly2limit &stl len
   "  &&mayb hv mapd togl ky2swich btwn80col old-norml-stndrd-dflt mod&&160wydPipHiDef fanC nw slik ASCIIker mod! ;)  Adding .vcd8. abov iz2many%\d*z long!
  endf " need some way to count tix && mk sure SetSLS() does not get called too quickly or it barfs on the term
  call SetStatusLineStyle()
  if   has('title') " Window title
    se      titlestring=%t%(\ [%R%M]%)
  en
en
"se  diffexpr=MyDiff()
"fu(nction)?!? $NAME (retu(rn) $expr)? endf(unction)? delf(unction)? where the optional trailing bang (!) will silently force overwriting any existing fu def
"fu  MyDiff() "$NAME has to start with a capital letter
" let  opt = ''
" if   &diffopt =~ 'icase'  | let opt = opt . '-i ' | en
" if   &diffopt =~ 'iwhite' | let opt = opt . '-b ' | en
 "sil(ent!?)? exe(cute)? $expr  " sil skips StdOut && .= ! also skips StdErr
" sil  exe '!C:\Vim\vim62\diff -a ' . opt . '"' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
"endf
fu!  InvertPasteAndMouse() " toggle paste / mouse mode
  if     &mouse ==# ''
    se    mouse=a
    se  nopaste
    echo "mouse mode ON , paste mode off"
  el
    se    mouse=
    se    paste
    echo "mouse mode off, paste mode ON "
  en
endf
fu!  ToglCursorLineBold()  " toggle whether CursorLine 'cul' highlighting has cterm all bold && also toggle slower Column highlighting on every 4th bold togl
  if      g:culb           " maybe should not use g: globalz for these but per window or something instead?
    let   g:culb=0
    hi    CursorLine   term=bold cterm=NONE ctermbg=DarkBlue
    hi    CursorColumn term=bold cterm=NONE ctermbg=DarkBlue
  el
    let   g:culb=1
    hi    CursorLine   term=bold cterm=bold ctermbg=DarkBlue
    hi    CursorColumn term=bold cterm=bold ctermbg=DarkBlue
    if    g:cucf           " like I'm going to remember every 4 of Ctrl-H or L will also toggle CursorColumn highlighting being on && mAB 'se cuc!' is EZ Enuf
      let g:cucf=0
    el
      let g:cucf=1
      se    cuc!
"     hi  CursorLine   term=bold cterm=bold ctermbg=DarkRed " mAB try this again aftr rgc are made pretty dark in *.pal8 && still consider sepR8ing
"     hi  CursorColumn term=bold cterm=bold ctermbg=DarkRed
    en
  en
endf
fu!  Upd8VerS()
  call SetStatusLineStyle()
  if &ai " no longer need to also let g:vcic since \c in regexes makes local explicit ignorecase
    let   g:vcai=1
  el
    let   g:vcai=0
  en
  se      noai
  if  getline('.') !~ "\\cd8VS=['\"]"
    kt
  en
  call setpos('.',[0,1,1,0])
  try " also available are :th(row)? && :fina(lly) sectionz beyond just cat(ch)? && it seems that just try&&cat preserves original srch in register:\"/ alreD
    exe "normal       /\\cd8VS=['\"]\<CR>"
    exe "normal 6lcw\<CR>\<Esc>k"
    r!d8
    norm                       k$
    j!
    norm        Jx8h
  cat      /^Vim\%((\a\+)\)\=:E486/
    " can't use system eScape codes to color echo message line below, needs :echohl (help)?(Boolean|Character|ColorColumn|Comment|Conceal|Conditional|Constant|
    " CursorColumn|CursorLine(Nr)?|Debug|Define|Delimiter|DiffAdd|DiffChange|DiffDelete|DiffText|Directory|Error(Msg)?|Exception|Float|FoldColumn|Folded|
    " Function|GTF_CANCELLED|GTF_CURSOR|GTF_LOOKAHEAD|GTF_NEW|Identifier|Ignore|IncSearch|Include|Keyword|Label|LineNr|Macro|MatchParen|ModeMsg|MoreMsg|
    " NonText|Normal|Number|Operator|Pmenu|PmenuSbar|PmenuSel|PmenuThumb|PreCondit|PreProc|Question|Repeat|Search|SignColumn|Special(Char|Comment|Key)?|
    " Spell(Bad|Cap|Local|Rare)|Statement|StatusLine(NC)?|StorageClass|String|Structure|TabLine(Fill|Sel)?|Tag|Title|Todo|Type(def)?|Underlined|User[1-9]|
    " VertSplit|Visual(NOS)?|WarningMsg|WildMenu|helpBacktick|helpBar|helpCommand|helpExample|helpGraphic|helpHead(er|line)|helpHyperText(Entry|Jump)|
    " helpLeadBlank|helpNotVi|helpNote|helpOption|helpSectionDelim|helpStar|helpURL|helpVim|none|pythonAsync|pythonAttribute|pythonBuiltin|pythonComment|
    " pythonDecorator|pythonDoctest(Value)?|...)
   "ec system('S R') . '!*Warn*!' . system('S O') . ' Exception' . system('S W') . ':' . system('S Y') . v:exception
    echoh           Exception
    ec    '!*Warn*! Exception:' v:exception
    echoh    none
    norm        't
  endtry " just try=>catching E486 where the search failz; Also figure out why I can't just do "se ai!" below instead of keeping around global to toggle?
  if g:vcai
    se   ai
  el
    se noai
  en
endf
" Damian Conway's PerlToolsForVim inserted below, from talk HTTPS://YouTube.Com/watch?v=9u6O0dLuqhI && description at HTTP://YAPCNA.Org/yn2016/talk/6833
autocmd BufNewFile,BufRead *.t setfiletype perl " .t files are perl
"highlight Comment term=bold ctermfg=white      " Comments are important
function! AskQuit (msg, options, quit_option)   " magically build interim directories, if necessary
  if confirm(a:msg, a:options) ==# a:quit_option
    exit
  endif
endfunction
function! EnsureDirExists()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call   AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
        \          "&Create it\nor &Quit?"      , 2)
    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '"     . required_dir . "'",
        \          "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction
augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
"====[ Make arrow keys move visual blocks around ]====
vmap <Up>    <Plug>SchleppUp
vmap <Down>  <Plug>SchleppDown
vmap <Left>  <Plug>SchleppLeft
vmap <Right> <Plug>SchleppRight
vmap    D    <Plug>SchleppDupLeft
"map <C-d>   <Plug>SchleppDupLeft  " don't map this if you still want to be able to HalfPageDown in Visual mode
"====[ Configure % key (via matchit plugin) for Perl 6 as well ]====
" Match angle brackets...
set matchpairs+=<:>,«:»
"====[ Perl programming support ]====
"Adjust keyword characters to match Perlish identifiers...
set iskeyword+=$
set iskeyword+=%
set iskeyword+=@-@
set iskeyword+=:
set iskeyword-=,
" Insert ABbrev8ionz for common Perl code structures which deserve study...
iab udd use Data::Dump 'ddx';<CR>ddx;<Left>
iab udv use Dumpvalue;<CR>Dumpvalue->new->dumpValues();<Esc>hi
iab uds use Data::Show;<CR>show
iab ubm use Benchmark qw( cmpthese );<CR><CR>cmpthese -10, {<CR>};<Esc>O
iab usc use Smart::Comments;<CR>###
iab uts use Test::Simple 'no_plan';
iab utm use Test::More 'no_plan';
iab dbs $DB::single = 1;<Esc>
"====[ Run a Perl module's test suite ]====
let g:PerlTests_program       = 'perltests'   " ...What to call
let g:PerlTests_search_height = 5             " ...How far up to search
let g:PerlTests_test_dir      = '/t'          " ...Where to look for tests
augroup Perl_Tests
  autocmd!
  autocmd BufEnter *.p[lm]  nmap <buffer> ;t :call RunPerlTests()<CR>
  autocmd BufEnter *.t      nmap <buffer> ;t :call RunPerlTests()<CR>
augroup END
function! RunPerlTests ()
  " Start in the current directory...
  let dir = expand('%:h')
  " Walk up through parent directories, looking for a test directory...
  for n in range(g:PerlTests_search_height)
    " When found...
    if isdirectory(dir . g:PerlTests_test_dir)
      " Go there...
      silent exec 'cd ' . dir
      " Run the tests...
      exec ':!' . g:PerlTests_program
      " Return to the previous directory...
      silent cd -
      return
    endif
    " Otherwise, keep looking up the directory tree...
    let dir = dir . '/..'
  endfor
  " If not found, report the failure...
  echohl WarningMsg
  echomsg "Couldn't find a suitable" g:PerlTests_test_dir '(tried' g:PerlTests_search_height 'levels up)'
  echohl None
endfunction
"====[ Auto-setup for Perl scripts and modules and test files ]====  " I don't think Conway's package included this needed perl_file_template.
"augroup Perl_Setup
"  autocmd!
"  autocmd BufNewFile   *.p[lm65],*.t   0r !perl_file_template <afile>
"  autocmd BufNewFile   *.p[lm65],*.t   /^[ \t]*[#].*implementation[ \t]\+here/
"augroup END
"====[ Proper syntax highlighting for Rakudo files ]====
autocmd BufNewFile,BufRead  *   :call CheckForPerl6()
function! CheckForPerl6 ()
  if getline(1) =~ 'rakudo'
    setfiletype perl6
  endif
  if expand('<afile>:e') ==# 'pod6'
    highlight Pod6Block_Heading1 cterm=underline,bold
    highlight Pod6FC_Important   cterm=underline
    setfiletype               pod6
    syntax enable
  endif
endfunction
"====[ Smart completion via <Tab> and <S-Tab> ]====
runtime plugin/smartcom.vim
" Add extra completions (mainly for Perl programming)...
let ANYTHING = ""
let NOTHING  = ""
let EOL      = '\s*$'
                " Left     Right      Insert                             Reset cursor
                " =====    =====      ===============================    ============
call SmartcomAdd( '<<',    ANYTHING,  '>>',                              {'restore':1} )
call SmartcomAdd( '<<',    '>>',      "\<CR>\<Esc>O\<Tab>"                             )
call SmartcomAdd( '?',     ANYTHING,  '?',                               {'restore':1} )
call SmartcomAdd( '?',     '?',       "\<CR>\<Esc>O\<Tab>"                             )
call SmartcomAdd( '{{',    ANYTHING,  '}}',                              {'restore':1} )
call SmartcomAdd( '{{',    '}}',      NOTHING,                                         )
call SmartcomAdd( 'qr{',   ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'qr{',   '}xms',    "\<CR>\<C-D>\<Esc>O\<C-D>\<Tab>"                 )
call SmartcomAdd( 'm{',    ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'm{',    '}xms',    "\<CR>\<C-D>\<Esc>O\<C-D>\<Tab>",                )
call SmartcomAdd( 's{',    ANYTHING,  '}{}xms',                          {'restore':1} )
call SmartcomAdd( 's{',    '}{}xms',  "\<CR>\<C-D>\<Esc>O\<C-D>\<Tab>",                )
call SmartcomAdd( '\*\*',  ANYTHING,  '**',                              {'restore':1} )
call SmartcomAdd( '\*\*',  '\*\*',    NOTHING,                                         )
" Handle single : correctly...
call SmartcomAdd( '^:\|[^:]:',  EOL,  "\<Tab>" )
"After an alignable, align...
function! AlignOnPat (pat)
  return "\<Esc>:call EQAS_Align('nmap',{'pattern':'" . a:pat . "'})\<CR>A"
endfunction
                " Left         Right        Insert
                " ==========   =====        =============================
call SmartcomAdd( '=',         ANYTHING,    "\<Esc>:call EQAS_Align('nmap')\<CR>A")
call SmartcomAdd( '=>',        ANYTHING,    AlignOnPat('=>') )
call SmartcomAdd( '\s#',       ANYTHING,    AlignOnPat('\%(\S\s*\)\@<= #') )
call SmartcomAdd( '[''"]\s*:', ANYTHING,    AlignOnPat(':'),                   {'filetype':'vim'} )
call SmartcomAdd( ':',         ANYTHING,    "\<Tab>",                          {'filetype':'vim'} )
" Perl keywords...
                " Left         Right   Insert                                  Where
                " ==========   =====   =============================           ===================
"                        was inserting " my $___ (___){\n___\n}\n___" originally, but trying to compact for me
call SmartcomAdd( '^\s*for',   EOL,    " my $___ (___){___}\n___",             {'filetype':'perl'} )
call SmartcomAdd( '^\s*if',    EOL,             "(___){___}\n___",             {'filetype':'perl'} )
call SmartcomAdd( '^\s*while', EOL,             "(___){___}\n___",             {'filetype':'perl'} )
call SmartcomAdd( '^\s*given', EOL,             "(___){___}\n___",             {'filetype':'perl'} )
call SmartcomAdd( '^\s*when',  EOL,             "(___){___}\n___",             {'filetype':'perl'} )
"====[ Correct common mistypings in-the-fly ]====
iab        ,,  =>
iab    retrun  return
iab     pritn  print
iab       teh  the
iab      liek  like
iab  liekwise  likewise
iab      Pelr  Perl
iab      pelr  perl
iab        ;t  't
iab    Jarrko  Jarkko
iab    jarrko  jarkko
iab      moer  more
iab  previosu  previous
"====[ Add or subtract comments ]====
" Work out what the comment character is, by filetype... (&& maybe just * needz to be before bottom *.pl line?)
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType               vim                             let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.Xrc                             let b:cmt = exists('b:cmt') ? b:cmt : '!'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
" Work out whether the line has a comment then reverse that condition...
function! ToggleComment()
  let comment_char = exists('b:cmt') ? b:cmt : '#'
  let     currline = getline(".")
  if      currline =~                     '^' . comment_char . ' '
    let   repline  = substitute(currline, '^' . comment_char,          " ", "")
  elseif  currline =~                     '^' . comment_char
    let   repline  = substitute(currline, '^' . comment_char,           "", "")
  else
    let   repline  = substitute(currline, '^ \?'            , comment_char, "")
  en
  call    setline(           ".",repline)
endfunction
" Toggle comments down an entire visual selection of lines...
function! ToggleBlock() range
  let comment_char = exists('b:cmt') ? b:cmt : '#'
  let linenum      = a:firstline
  " Get all the lines, and decide their comment state by examining the first...
  let currline     = getline(a:firstline, a:lastline)
  if  currline[0]  =~                 '^' . comment_char
    " If the first line is commented, decomment all...
    for   line in currline
      if  line     =~                 '^' . comment_char . ' '
        let repline= substitute(line, '^' . comment_char,          " ", "")
      el
        let repline= substitute(line, '^' . comment_char,           "", "")
      en
      call setline( linenum, repline)
      let  linenum+= 1
    endfor
  else
    " Otherwise, encomment all... where orig was: substitute(line, '^\('. comment_char . '\)\?', comment_char, "") to not duplic8 starting comment charz
    for line in currline
      let  repline = substitute(line, '^ \?'            , comment_char, "")
      call setline( linenum, repline)
      let  linenum+= 1
    endfor
  endif
endfunction
" Set up the relevant mappings
nmap <silent> # :call ToggleComment()<CR>j0
vmap <silent> # :call ToggleBlock()  <CR>
"====[ Search folding ]====
" Don't start new buffers folded
set foldlevelstart=99
" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black
" Toggle on and off...
nmap                                 <silent> <expr>  zz  FS_ToggleFoldAroundSearch(             {'context':1})
" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let  vim_sub_pat = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
  autocmd!
  autocmd BufEnter *            nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,      {'context':1})
  autocmd BufEnter *            nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
  autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget( vim_sub_pat,      {'context':1})
  autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget( vim_sub_pat.   '\\|^\s*".*',{'context':0, 'folds':'invisible'})
  autocmd BufEnter *            nmap <silent> <expr>  zv  FS_FoldAroundTarget( vim_sub_pat.   '\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END
" Show only C #includes... (PipNote:I think the next map is for Perl use lines rather than C includes now.)
nmap                                 <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})
"====[ Much smarter "edit next file" command ]====
"nmap <silent> <expr>  e  g:GTF_goto_file()
"nmap <silent> <expr>  q  g:GTF_goto_file('`')
""====[ Smarter interstitial completions of identifiers ]====
"" When autocompleting within an identifier, prevent duplications...
"augroup Undouble_Completions
"  autocmd!
"  autocmd CompleteDone *  call Undouble_Completions()
"augroup None
"function! Undouble_Completions ()
"  let col  = getpos('.')[2]
"  let line = getline('.')
"  call setline('.', substitute(line, '\(\k\+\)\%'.col.'c\zs\1', '', ''))
"endfunction
"9AGJHVRq: belo is .vimrc from GiorgioSironi.BlogSpot.Com_2009_10_getters-and-setters-in-vim.html; Iwnt2co snippetsEmu. ;)
"se   expandtab   "se   tabstop=4     "setl comments=sr:/*,mb:*,ex:*/  "source ~/.vim/plugin/snippetsEmu.vim
"se   autoindent  "se   shiftwidth=4  "setl fo=cqort                   "source ~/.vim/after/ftplugin/php_snippets.vim
"exec "Snippet getset /**<CR>@return ".st."Type".et."<CR>/<CR>public function get".st."Name".et."()<CR>{<CR>  return $this->_".st."name".et.";<CR><BS><BS>\
      "}<CR><CR>public function set".st."Name".et."($".st."name".et.")<CR>{<CR>  $this->_".st."name".et." = $".st."name".et.";<CR><BS><BS>}<CR>"
