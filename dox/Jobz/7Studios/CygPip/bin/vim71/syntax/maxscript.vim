" Vim syntax file
" Language:    MaxScript (Autodesk's 3DStudio MaxScript .ms && .mcr files)
" Maintainer:  PipStuart <Pip@CPAN.Org>,<PStuart@SevenStudios.Com>
" Last Change: 81FInk7   (Tue Jan 15 18:49:46:07 PST 2008)
" Version:     0         (derived from v6 of xmath.vim)
" URL:         N/A
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  sy clear
elseif exists("b:current_syntax")
  finish
en
" parenthesis sanity checker
sy region  maxscriptZone              matchgroup=Delimiter start="("  matchgroup=Delimiter end=")" transparent contains=ALLBUT,maxscriptError
sy region  maxscriptZone              matchgroup=Delimiter start="\[" matchgroup=Delimiter end="]" transparent contains=ALLBUT,maxscriptError
sy match   maxscriptError             "[)\]}]"
"sy match   maxscriptBraceError        "[)}]"   contained
"sy match   maxscriptCurlyError        "[)\]]"  contained
"sy match   maxscriptParenError        "[\]}]"  contained
sy match   maxscriptComma             "[,;:]"
sy match   maxscriptComma             "\.\.\.$"
" A bunch of useful maxscript keywords
sy case    ignore
sy keyword maxscriptFuncCmd           fn function utility
sy keyword maxscriptType              global local
"sy keyword maxscriptStatement         execute  exit  pause  return  undefine
sy keyword maxscriptConditional       if then else elseif
sy keyword maxscriptRepeat            while do for in
sy keyword maxscriptCmd               checkbox spinner on
sy keyword maxscriptFunc              range open close okToClose resized moved changed checked pos center
sy case    match
" Labels (supports maxscript's goto)
sy match   maxscriptLabel             "^\s*<[a-zA-Z_][a-zA-Z0-9]*>"
" String and Character constants
" Highlight special characters (those which have a backslash) differently
sy match   maxscriptSpecial                                                contained "\\\d\d\d\|\\."
sy region  maxscriptString            start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=maxscriptSpecial,@Spell
sy match   maxscriptOperator           "[*=+-]"
sy match   maxscriptCharacter         "'[^\\]'"
sy match   maxscriptSpecialChar         "'\\.'"
sy match   maxscriptNumber            "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
" Comments:
" maxscript supports --...  (to EndOfLine) && /* ... */ comment blocks (like C/C++)
sy cluster maxscriptCommentGroup                          contains=maxscriptString,maxscriptTodo,@Spell
sy keyword maxscriptTodo                                  contained  COMBAK  DEBUG  FIXME  Todo  TODO  XXX
sy match   maxscriptComment                 "--.*$"       contains=@maxscriptCommentGroup
"sy region  maxscriptCommentBlock      start="/*" end="*/" contains=@maxscriptCommentGroup
" synchronizing
"sy sync    match maxscriptSyncComment grouphere  maxscriptCommentBlock "/*"
"sy sync    match maxscriptSyncComment groupthere NONE                  "*/"
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if   version >= 508 || !exists("did_maxscript_syntax_inits")
  if version <  508
    let                         did_maxscript_syntax_inits = 1
    com -nargs=+ HiLink hi     link <args>
  el
    com -nargs=+ HiLink hi def link <args>
  en
  HiLink maxscriptBraceError       maxscriptError
  HiLink maxscriptCmd              maxscriptStatement
  HiLink maxscriptCommentBlock     maxscriptComment
  HiLink maxscriptCurlyError       maxscriptError
  HiLink maxscriptFuncCmd          maxscriptStatement
  HiLink maxscriptParenError       maxscriptError
  " The default methods for highlighting.  Can be overridden later
  HiLink maxscriptCharacter        Character
  "HiLink maxscriptComma            Delimiter
  HiLink maxscriptComma            Type
  HiLink maxscriptComment          Comment
  HiLink maxscriptCommentBlock     Comment
  HiLink maxscriptConditional      Conditional
  HiLink maxscriptError            Error
  HiLink maxscriptFunc             Function
  HiLink maxscriptLabel            PreProc
  HiLink maxscriptNumber           Number
  HiLink maxscriptOperator         PreProc
  HiLink maxscriptRepeat           Repeat
  HiLink maxscriptSpecial          Type
  HiLink maxscriptSpecialChar      SpecialChar
  HiLink maxscriptStatement        Statement
  HiLink maxscriptString           String
  HiLink maxscriptTodo             Todo
  HiLink maxscriptType             Type
  delc HiLink
en
let b:current_syntax = "maxscript"
" vim: ts=17
