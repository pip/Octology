# 2AFJBQB7:Curses::Simp.pm crE8d by PipStuart <Pip@CPAN.Org> to Simplify Perl text-mode applic8ion development;
package    Curses::Simp;
use strict;use warnings;use utf8;use v5.10;use vars qw( $AUTOLOAD );
use        Curses;use Tie::Array;
my $curs=8; # used to set this to 0 for old 4NT rendering so now should remove all tests for it
my $ptim=0;#eval('use Time::PT   ;8') || 0;
my $fram=0;#eval('use Time::Frame;8') || 0;
my $VERSION  =  '1.6';my $d8VS='H7IM7IM7'; # remember that 1.2 is really that float and not automatically 1.002 without 'v1.2' or '1.2.0'
END{CScr();} # auto-execute CloseScreen() on exit()
my %GLBL=( # GLOBAL CLASS VARIABLES  # maybe used to need to declare this before END would register a test for FLAGOPEN?
  'FLAGOPEN' => 0,   # flag for if a main curses screen has been opened yet
  'TESTMAPP' => {    # these MAPPs should have just parsed $ENV{'LS_COLORS'} instead
    'NORMAL' => 'w', #00
    'FILE'   => 'w', #00       # normal file
    'DIR'    => 'B', #01;34    # directory
    'LINK'   => 'W', #01;37    # symbolic link
    'FIFO'   => 'y', #00;33;40 # pipe
    'SOCK'   => 'P', #01;35    # socket
   #'DOOR'   => 'P', #01;35   # door
    'BLK'    => 'Y', #01;33;40 # block device driver
    'CHR'    => 'Y', #01;33;40 # character device driver
    'ORPHAN' => 'R', #01;31;40 # symlink to nonexistent file
    'EXEC'   => 'G',}, #01;32    # executable file
  'DFLTMAPP' => { # even though this stuff should read $LS_COLORS, quoting regexez like this is still a really nice way to map a lot of file extensionz2colrz
    qr/\.(cmd|exe|com|btm|bat                                                 )$/x => 'O',
    qr/\.(bak                                                                 )$/x => 'P',
    qr/\.(asm|c|cpp|m|h|scm|pl|pm|py|cgi|htm|html                             )$/x => 'C',
    qr/\.(tar|tgz|tbz|tbz2|arj|taz|lzh|zip|z|gz|bz|bz2|deb|rpm                )$/x => 'R',
    qr/\.(jpg|jpeg|gif|bmp|ppm|tga|xbm|xpm|tif|tiff|png|mpg|mpeg|avi|mov|gl|dl)$/x => 'p',
    qr/\.(txt|rtf                                                             )$/x => 'W',
    qr/\.(cfg|ini                                                             )$/x => 'Y',
    qr/\.(ogg|mp3|s3m|mod|wav|xm|it                                           )$/x => 'C'},
  'OVERMAPP' => {},);
my @DISPSTAK =();# global stack of crE8d Simp objects for display order
my @BORDSETS =();# array of hashes of different border char sets (see OScr())
my @SDLKNAMZ =( # in advanced input mode, these SDLK names return from GetK()
#  SDLKey           ASCII value    Common name
  'SDLK_BACKSPACE',      #'\b'    backspace
  'SDLK_TAB',            #'\t'    tab
  'SDLK_CLEAR',          #        clear
  'SDLK_RETURN',         #'\r'    return
  'SDLK_PAUSE',          #        pause
  'SDLK_ESCAPE',         #'^['    escape
  'SDLK_SPACE',          #' '     space
  'SDLK_EXCLAIM',        #'!'     exclaim
  'SDLK_QUOTEDBL',       #'"'     quotedbl
  'SDLK_HASH',           #'#'     hash
  'SDLK_DOLLAR',         #'$'     dollar
  'SDLK_AMPERSAND',      #'&'     ampersand
  'SDLK_QUOTE',          #'\''    quote
  'SDLK_LEFTPAREN',      #'('     left parenthesis
  'SDLK_RIGHTPAREN',     #')'     right parenthesis
  'SDLK_ASTERISK',       #'*'     asterisk
  'SDLK_PLUS',           #'+'     plus sign
  'SDLK_COMMA',          #','     comma
  'SDLK_MINUS',          #'-'     minus sign
  'SDLK_PERIOD',         #'.'     period
  'SDLK_SLASH',          #'/'     forward slash
  'SDLK_0',              #'0'     0
  'SDLK_1',              #'1'     1
  'SDLK_2',              #'2'     2
  'SDLK_3',              #'3'     3
  'SDLK_4',              #'4'     4
  'SDLK_5',              #'5'     5
  'SDLK_6',              #'6'     6
  'SDLK_7',              #'7'     7
  'SDLK_8',              #'8'     8
  'SDLK_9',              #'9'     9
  'SDLK_COLON',          #':'     colon
  'SDLK_SEMICOLON',      #';'     semicolon
  'SDLK_LESS',           #'<'     less-than sign
  'SDLK_EQUALS',         #'='     equals sign
  'SDLK_GREATER',        #'>'     greater-than sign
  'SDLK_QUESTION',       #'?'     question mark
  'SDLK_AT',             #'@'     at
  'SDLK_LEFTBRACKET',    #'['     left bracket
  'SDLK_BACKSLASH',      #'\'     backslash
  'SDLK_RIGHTBRACKET',   #']'     right bracket
  'SDLK_CARET',          #'^'     caret
  'SDLK_UNDERSCORE',     #'_'     underscore
  'SDLK_BACKQUOTE',      #'`'     grave
  'SDLK_TILDE',          #'~'     tilde
  'SDLK_a',              #'a'     a
  'SDLK_b',              #'b'     b
  'SDLK_c',              #'c'     c
  'SDLK_d',              #'d'     d
  'SDLK_e',              #'e'     e
  'SDLK_f',              #'f'     f
  'SDLK_g',              #'g'     g
  'SDLK_h',              #'h'     h
  'SDLK_i',              #'i'     i
  'SDLK_j',              #'j'     j
  'SDLK_k',              #'k'     k
  'SDLK_l',              #'l'     l
  'SDLK_m',              #'m'     m
  'SDLK_n',              #'n'     n
  'SDLK_o',              #'o'     o
  'SDLK_p',              #'p'     p
  'SDLK_q',              #'q'     q
  'SDLK_r',              #'r'     r
  'SDLK_s',              #'s'     s
  'SDLK_t',              #'t'     t
  'SDLK_u',              #'u'     u
  'SDLK_v',              #'v'     v
  'SDLK_w',              #'w'     w
  'SDLK_x',              #'x'     x
  'SDLK_y',              #'y'     y
  'SDLK_z',              #'z'     z
  'SDLK_DELETE',         #'^?'    delete
  'SDLK_KP0',            #        keypad 0
  'SDLK_KP1',            #        keypad 1
  'SDLK_KP2',            #        keypad 2
  'SDLK_KP3',            #        keypad 3
  'SDLK_KP4',            #        keypad 4
  'SDLK_KP5',            #        keypad 5
  'SDLK_KP6',            #        keypad 6
  'SDLK_KP7',            #        keypad 7
  'SDLK_KP8',            #        keypad 8
  'SDLK_KP9',            #        keypad 9
  'SDLK_KP_PERIOD',      #'.'     keypad period
  'SDLK_KP_DIVIDE',      #'/'     keypad divide
  'SDLK_KP_MULTIPLY',    #'*'     keypad multiply
  'SDLK_KP_MINUS',       #'-'     keypad minus
  'SDLK_KP_PLUS',        #'+'     keypad plus
  'SDLK_KP_ENTER',       #'\r'    keypad enter
  'SDLK_KP_EQUALS',      #'='     keypad equals
  'SDLK_UP',             #        up arrow
  'SDLK_DOWN',           #        down arrow
  'SDLK_RIGHT',          #        right arrow
  'SDLK_LEFT',           #        left arrow
  'SDLK_INSERT',         #        insert
  'SDLK_HOME',           #        home
  'SDLK_END',            #        end
  'SDLK_PAGEUP',         #        page up
  'SDLK_PAGEDOWN',       #        page down
  'SDLK_F1',             #        F1
  'SDLK_F2',             #        F2
  'SDLK_F3',             #        F3
  'SDLK_F4',             #        F4
  'SDLK_F5',             #        F5
  'SDLK_F6',             #        F6
  'SDLK_F7',             #        F7
  'SDLK_F8',             #        F8
  'SDLK_F9',             #        F9
  'SDLK_F10',            #        F10
  'SDLK_F11',            #        F11
  'SDLK_F12',            #        F12
  'SDLK_F13',            #        F13
  'SDLK_F14',            #        F14
  'SDLK_F15',            #        F15
  'SDLK_NUMLOCK',        #        numlock
  'SDLK_CAPSLOCK',       #        capslock
  'SDLK_SCROLLOCK',      #        scrollock
  'SDLK_RSHIFT',         #        right shift
  'SDLK_LSHIFT',         #        left shift
  'SDLK_RCTRL',          #        right ctrl
  'SDLK_LCTRL',          #        left ctrl
  'SDLK_RALT',           #        right alt
  'SDLK_LALT',           #        left alt
  'SDLK_RMETA',          #        right meta
  'SDLK_LMETA',          #        left meta
  'SDLK_LSUPER',         #        left windows key
  'SDLK_RSUPER',         #        right windows key
  'SDLK_MODE',           #        mode shift
  'SDLK_HELP',           #        help
  'SDLK_PRINT',          #        print-screen
  'SDLK_SYSREQ',         #        SysRq
  'SDLK_BREAK',          #        break
  'SDLK_MENU',           #        menu
  'SDLK_POWER',          #        power
  'SDLK_EURO',);         #        euro
my %SDLKCHRM =(
  ' ' => 'SPACE',
  '!' => 'EXCLAIM',
  '"' => 'QUOTEDBL',
  '#' => 'HASH',
  '$' => 'DOLLAR',
  '%' => 'PERCENT',
  '&' => 'AMPERSAND',
  "'" => 'QUOTE',
  '(' => 'LEFTPAREN',
  ')' => 'RIGHTPAREN',
  ',' => 'COMMA',
  '*' => 'ASTERISK',
  '+' => 'PLUS',
  ',' => 'COMMA',
  '-' => 'MINUS',
  '.' => 'PERIOD',
  '/' => 'SLASH',
  ':' => 'COLON',
  ';' => 'SEMICOLON',
  '<' => 'LESS',
  '=' => 'EQUALS',
  '>' => 'GREATER',
  '?' => 'QUESTION',
  '@' => 'AT',
  '[' => 'LEFTBRACKET',
  '\\'=> 'BACKSLASH',
  ']' => 'RIGHTBRACKET',
  '^' => 'CARET',
  '_' => 'UNDERSCORE',
  '`' => 'BACKQUOTE',
  '~' => 'TILDE',);
my %SDLKCRSM =(
  'KEY_BACKSPACE' => 'BACKSPACE',
  'KEY_LEFT'      => 'LEFT',
  'KEY_RIGHT'     => 'RIGHT',
  'KEY_UP'        => 'UP',
  'KEY_DOWN'      => 'DOWN',
  'KEY_HOME'      => 'HOME',
  'KEY_END'       => 'END',
  'KEY_PPAGE'     => 'PAGEUP',
  'KEY_NPAGE'     => 'PAGEDOWN',
  'KEY_IC'        => 'INSERT',
  'KEY_DC'        => 'DELETE',
  'KEY_F1'        => 'F1',
  'KEY_F2'        => 'F2',
  'KEY_F3'        => 'F3',
  'KEY_F4'        => 'F4',
  'KEY_F5'        => 'F5',
  'KEY_F6'        => 'F6',
  'KEY_F7'        => 'F7',
  'KEY_F8'        => 'F8',
  'KEY_F9'        => 'F9',
  'KEY_F10'       => 'F10',
  'KEY_F11'       => 'F11',
  'KEY_F12'       => 'F12',
  'KEY_F13'       => 'F13',
  'KEY_F14'       => 'F14',
  'KEY_F15'       => 'F15');
my %SDLKORDM =(
   '9'   => 'TAB',
  '13'   => 'RETURN',
  '27'   => 'ESCAPE');
my @KMODNAMZ =( # in advanced input mode, these KMOD modifier names get set within the Simp object's '_kmod' hash after each GetK()
#  SDL Modifier                    Meaning
  'KMOD_NONE',           #        No modifiers applicable
# I don't think I can detect locks or left/right with Curses so commented
# 'KMOD_NUM',            #        Numlock is down
# 'KMOD_CAPS',           #        Capslock is down
# 'KMOD_LCTRL',          #        Left Control is down
# 'KMOD_RCTRL',          #        Right Control is down
# 'KMOD_RSHIFT',         #        Right Shift is down
# 'KMOD_LSHIFT',         #        Left Shift is down
# 'KMOD_RALT',           #        Right Alt is down
# 'KMOD_LALT',           #        Left Alt is down
  'KMOD_CTRL',           #        A Control key is down
  'KMOD_SHIFT',          #        A Shift key is down
  'KMOD_ALT',);          #        An Alt key is down
my @kndx =();my @knam =();my %knum =();my $i = 0;#my $abld = 2097152; # had old A_BOLD attribute number here but much better to use exported constant instead
my %clet =('k' =>  0,'r' =>  1, 'g' =>  2,'o' =>  3, # old Color LETters map here (which should be replaced with %p622 just below for 64-to-256 color support
           'u' =>  4,'m' =>  5, 't' =>  6,'y' =>  3,   # u && t(eal) are just aliases for blUe && cyan
           'b' =>  4,'p' =>  5, 'c' =>  6,'w' =>  7,
           'K' =>  8,'R' =>  9, 'G' => 10,'O' =>  3,   # Orange uppercase !bold exception
           'U' => 12,'M' => 13, 'T' => 14,'Y' => 11,
           'B' => 12,'P' =>  5, 'C' => 14,'W' => 15);  # Purple uppercase !bold exception
my @telc =('k','r','g','y', 'b','p','c','w'); # core colors indexed
my @c8p8 = qw(k r O g c b P w  K R Y G C B M W   e h o d t s p i  E H y D T S m I    . f u a z n l j  _ F U A Z N L J   0 2 4 6 8 x v q  1 3 5 7 9 X V Q);
my %pl8n =( #'krOgcbPw KRYGCBMW  ehodtspi EHyDTSmI   .fuaznlj _FUAZNLJ  02468xvq 13579XVQ' just 32 brIt upprcase,odd,&&_ of 8pal8 xpanded colr name map
           'K'=>'blacK'     ,'R'=>'Red'      ,'Y'=>'Yellow','G'=>    'Green'  , 'C'=>'Cyan'        ,'B'=>     'Blue','M'=>'Magenta' ,'W'=>       'White',
           'E'=>'dimgrEy'   ,'H'=>'Hotpink'  ,'O'=>'Orange','D'=>  'oliveDrab', 'T'=>'Turquoise'   ,'S'=>  'Skyblue','P'=>'PurPle'  ,'I'=>       'Ivory',
           '_'=>   'gray_63','F'=>'Firebrick','U'=>'bisqUe','A'=> 'AquAmArine', 'Z'=>'aZure'       ,'N'=>'Navy'     ,'L'=>'Lavender','J'=> 'navaJowhite',
           '1'=>'darkblue-1','3'=>'maroon-3' ,'5'=>'gold-5','7'=>'limegreen-7', '9'=>'dodgerblue-9','X'=>'Xteelblue','V'=>'Violet'  ,'Q'=>'antiQuewhite',);
   $pl8n{  '.'}=uc($pl8n{'_'});$pl8n{'.'}=~ s/_/./; # additionally load pal8 name map with dark dot,even,&& lowercase versions
for(split(//,'02468')){$pl8n{ $_ }=$pl8n{   $_+1};$pl8n{$_}=~ y/a-z13579/A-Z02468/;}
for(        'a'..'z' ){$pl8n{ $_ }=$pl8n{uc($_) };$pl8n{$_}=~ y/a-zA-Z/A-Za-z/    ;}
my %p622 =('k'=>  0, 'r'=>  1,  'O'=>  3, 'g'=>  2,   'c'=>  6, 'b'=>  4,  'P'=>  5, 'w'=>  7, # 8Pal8 64 to 256 map which shud eventually fully replace %clet
           'K'=>  8, 'R'=>  9,  'Y'=> 11, 'G'=> 10,   'C'=> 14, 'B'=> 12,  'M'=> 13, 'W'=> 15,
          #'K'=>241, 'R'=>196,  'Y'=>226, 'G'=>190,   'C'=>123, 'B'=> 21,  'M'=>201, 'W'=>255, # altern8 base 2pal8 brights mapped into 256
           'e'=>237, 'h'=>126,  'o'=>172, 'd'=>236,   't'=> 23, 's'=> 60,  'p'=> 92, 'i'=>244,
           'E'=>242, 'H'=>205,  'y'=>184, 'D'=> 64,   'T'=> 80, 'S'=>116,  'm'=>164, 'I'=>231,
           '.'=>239, 'f'=> 52,  'u'=> 58, 'a'=> 65,   'z'=> 30, 'n'=> 17,  'l'=>103, 'j'=> 95,
           '_'=>247, 'F'=>160,  'U'=>229, 'A'=>122,   'Z'=> 44, 'N'=> 19,  'L'=>225, 'J'=>223,
           '0'=>235, '2'=> 89,  '4'=> 94, '6'=> 22,   '8'=> 31, 'x'=> 24,  'v'=> 96, 'q'=>243,
           '1'=> 18, '3'=>131,  '5'=>220, '7'=> 77,   '9'=> 81, 'X'=>033,  'V'=>213, 'Q'=>224);
# ordered attribute names array && default attribute data hash
my   @_attrnamz=();     my %_attrdata=();
                my %_verbose_attrnamz=();
# field data
push(@_attrnamz, '_wind'); $_attrdata{$_attrnamz[-1]} = 0; # CursesWindowHandle
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowHandle';
push(@_attrnamz, '_text'); $_attrdata{$_attrnamz[-1]} = []; # text     data
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'TextData';
push(@_attrnamz, '_fclr'); $_attrdata{$_attrnamz[-1]} = []; # fg color data
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'ForegroundColorData';
push(@_attrnamz, '_bclr'); $_attrdata{$_attrnamz[-1]} = []; # bg color data
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'BackgroundColorData';
push(@_attrnamz, '_kque'); $_attrdata{$_attrnamz[-1]} = []; # Key Queue
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'KeyQueue';
push(@_attrnamz, '_mque'); $_attrdata{$_attrnamz[-1]} = []; # Key Mod Queue
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'KeyModQueue';
push(@_attrnamz, '_hite'); $_attrdata{$_attrnamz[-1]} = 0;  # window height
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowHeight';
push(@_attrnamz, '_widt'); $_attrdata{$_attrnamz[-1]} = 0;  # window width
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowWidth';
push(@_attrnamz, '_yoff'); $_attrdata{$_attrnamz[-1]} = 0;  # window y-offset
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowYOffset';
push(@_attrnamz, '_xoff'); $_attrdata{$_attrnamz[-1]} = 0;  # window x-offset
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowXOffset';
push(@_attrnamz, '_ycrs'); $_attrdata{$_attrnamz[-1]} = 0;  # cursor y-offset
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'CursorYOffset';
push(@_attrnamz, '_xcrs'); $_attrdata{$_attrnamz[-1]} = 0;  # cursor x-offset
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'CursorXOffset';
push(@_attrnamz, '_btyp'); $_attrdata{$_attrnamz[-1]} = 0;  # border type
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderType';
push(@_attrnamz, '_brfc'); $_attrdata{$_attrnamz[-1]} = 'w';# border fore color
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderForegroundColor';
push(@_attrnamz, '_brbc'); $_attrdata{$_attrnamz[-1]} = 'k';# border back color
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderBackgroundColor';
push(@_attrnamz, '_titl'); $_attrdata{$_attrnamz[-1]} = ''; # window title
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitle';
push(@_attrnamz, '_ttfc'); $_attrdata{$_attrnamz[-1]} = 'W';# title fore color
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitleForegroundColor';
push(@_attrnamz, '_ttbc'); $_attrdata{$_attrnamz[-1]} = 'W';# title back color
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitleBackgroundColor';
push(@_attrnamz, '_dndx'); $_attrdata{$_attrnamz[-1]} = 0;  # DISPSTAK index
                   $_verbose_attrnamz{$_attrnamz[-1]} = 'DisplayStackIndex';
# Flags, storage Values, && extended attributes
push(@_attrnamz, '_flagaudr'); $_attrdata{$_attrnamz[-1]} = 1; # Auto Draw()
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDraw';
push(@_attrnamz, '_flagadtf'); $_attrdata{$_attrnamz[-1]} = 1; # AD Tied FG
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDrawTiedForegroundData';
push(@_attrnamz, '_flagadtb'); $_attrdata{$_attrnamz[-1]} = 1; # AD Tied BG
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDrawTiedBackgroundData';
push(@_attrnamz, '_flagaba7'); $_attrdata{$_attrnamz[-1]} = 1; # AllBoldAbove7
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAllBoldAbove7';
push(@_attrnamz, '_flagmaxi'); $_attrdata{$_attrnamz[-1]} = 1; # Maximize
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMaximize';
push(@_attrnamz, '_flagshrk'); $_attrdata{$_attrnamz[-1]} = 1; # ShrinkToFit
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagShrinkToFit';
push(@_attrnamz, '_flagcntr'); $_attrdata{$_attrnamz[-1]} = 1; # Center
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagCenter';
push(@_attrnamz, '_flagcvis'); $_attrdata{$_attrnamz[-1]} = 0; # CursorVisible
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagCursorVisible';
push(@_attrnamz, '_flagscrl'); $_attrdata{$_attrnamz[-1]} = 0; # Scrollbar
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagScrollbar';
push(@_attrnamz, '_flagsdlk'); $_attrdata{$_attrnamz[-1]} = 0; # SDLK
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagSDLKey';
push(@_attrnamz, '_flagfram'); $_attrdata{$_attrnamz[-1]} = 0; # Time::Frame
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagTimeFrame';
push(@_attrnamz, '_flagmili'); $_attrdata{$_attrnamz[-1]} = 0; # millisecond
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMillisecond';
push(@_attrnamz, '_flagprin'); $_attrdata{$_attrnamz[-1]} = 1; # Prnt into self
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagPrintInto';
push(@_attrnamz, '_flagclru'); $_attrdata{$_attrnamz[-1]} = 0; # Color Used?
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagColorUsed';
push(@_attrnamz, '_flaginsr'); $_attrdata{$_attrnamz[-1]} = 1; # insert mode
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagInsertMode';
push(@_attrnamz, '_flagdrop'); $_attrdata{$_attrnamz[-1]} = 0; # DropDown
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagDropDown';
push(@_attrnamz, '_flagdown'); $_attrdata{$_attrnamz[-1]} = 0; # DropIsDown
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagDropIsDown';
push(@_attrnamz, '_valulasp'); $_attrdata{$_attrnamz[-1]} = undef; # last pair
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'LastPair';
push(@_attrnamz, '_valullsp'); $_attrdata{$_attrnamz[-1]} = undef; # llastpair
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'LastLastPair';
push(@_attrnamz, '_valulasb'); $_attrdata{$_attrnamz[-1]} = undef; # last bold
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'LastBold';
push(@_attrnamz, '_valullsb'); $_attrdata{$_attrnamz[-1]} = undef; # llastbold
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'LastLastBold';
push(@_attrnamz, '_valudol8'); $_attrdata{$_attrnamz[-1]} = undef; # do late
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'LateEscapedPrint';
# methods
sub DfltValu{my($self,$attr)=@_;$_attrdata{$attr};}
sub AttrNamz{@_attrnamz;} # attribute names
sub TIEARRAY{OScr() unless($GLBL{'FLAGOPEN'}); # need Open main Screen for new Simp obj
  my $clas = shift(@_);my $self = bless({},$clas);
  for my $attr ($self->AttrNamz()){$self->{$attr} = $self->DfltValu($attr);} # init defaults
  for(@KMODNAMZ){$self->{'_kmod'}->{$_} = 0;}
  while(@_){
    my $foun = 0;
    my($keey, $valu)=(shift, shift);
    for my $attr ($self->AttrNamz()){
      if($attr =~ /$keey/i) {
        $self->{$attr} = $valu;
        $foun = 1;}}
    unless($foun){
      for my $attr ($self->AttrNamz()){
        if($_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;
          $foun = 1;}}
#     unless($foun){die "!*EROR*! Curses::Simp->new initialization key:$keey was not recognized!";}
    }}
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'});
  $self->Updt(1);
  if($curs){
    $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'},
                              $self->{'_yoff'}, $self->{'_xoff'});
#   unless(exists($self->{'_wind'}) &&  defined($self->{'_wind'})){
#     die "!*EROR*! Curses::Simp->new couldn't crE8 window with hite:$self->{'_hite'},widt:$self->{'_widt'},yoff:$self->{'_yoff'},xoff:$self->{'_xoff'}!";}
  }
  $self->TestDraw(); # newwin doesn't auto draw so if there's init _text && autodraw is on...
  $self->Move(-1, -1) unless($self->{'_ycrs'} || $self->{'_xcrs'});
  curs_set($self->{'_flagcvis'}) if($curs); # set cursor state
  $self->{'_dndx'} = @DISPSTAK;push(@DISPSTAK,\$self);return($self);} # add new Simp object to display order stack
sub FETCH    {return(         $_[0]->{'_text'}->[$_[1]]);}
sub FETCHSIZE{return(scalar(@{$_[0]->{'_text'}})       );}
sub STORE    {         $_[0]->{'_text'}->[$_[1]] = $_[2];                   $_[0]->TestDraw();}
sub STORESIZE{splice(@{$_[0]->{'_text'}}, $_[1], @{$_[0]->{'_text'}}-$_[1]);$_[0]->TestDraw();}
sub EXISTS   {return(0) unless(defined($_[0]->{'_text'}->[$_[1]]));return(1);}
sub CLEAR    {            @{$_[0]->{'_text'}} = ();                         $_[0]->TestDraw();}
sub PUSH     {       push(@{$_[0]->{'_text'}},$_[1]);                       $_[0]->TestDraw();}
sub POP      {$_ =    pop(@{$_[0]->{'_text'}});                             $_[0]->TestDraw();return($_);}
sub SHIFT    {$_ =  shift(@{$_[0]->{'_text'}});                             $_[0]->TestDraw();return($_);}
sub UNSHIFT  {    unshift(@{$_[0]->{'_text'}},$_[1]);                       $_[0]->TestDraw();}
sub SPLICE   {
#             $_ = splice(@{$_[0]->{'_text'}},@_[1..$#_]);                  $_[0]->TestDraw();return($_);}
  my $self = shift(@_);
  my $offs = shift(@_) || 0;
  my $leng = shift(@_);$leng = $self->FETCHSIZE() - $offs unless(defined($leng));
  my $retn = splice(@{$self->{'_text'}},$offs,$leng,@_);                    $self->TestDraw();return($retn);}
sub EXTEND   {}
# MkMethdz creates Simp object field accessor methods with
#   configurable handling && overrideable default operations.  Beppu@CPAN.Org
#   coded the first version of MkMethdz && taught me a new trick. =)
# Special Parameters:
#   NAME => name of the method to be created
#   ARAY => if this is true, $self->{$attr} is assumed to be
#           an array ref, and default subcommands are installed
#   LOOP => like ARAY above but a looping value instead
#   ...  => other method flags describing what to include in made method
#   nmrc => sub reference for handling a numeric subcommand
# The rest of the parameters should be key/value pairs where:
#   subcommand => subroutine reference
sub MkMethdz{
  my %cmnd = @_;
  my $meth = $cmnd{'NAME'} || die('NAME => required!');
  my $aray = $cmnd{'ARAY'} || 0;
  my $rsiz = $cmnd{'RSIZ'} || 0;
  my $mvwn = $cmnd{'MVWN'} || 0;
  my $mvcr = $cmnd{'MVCR'} || 0;
  my $updt = $cmnd{'UPDT'} || 0;
  my $crsr = $cmnd{'CRSR'} || 0;
  my $loop = $cmnd{'LOOP'} || 0;
  my $dstk = $cmnd{'DSTK'} || 0;
  my $attr = '_' . lc($meth);
  $cmnd{'asin'    } ||= sub { # Dflt assign command
    my $self = shift(@_);my $nwvl = shift(@_);
    if(!$dstk || (0 <= $nwvl && $nwvl < @DISPSTAK)){
      if($dstk && $self->{'_dndx'} != $nwvl) { # exchange displaystack indices
        $DISPSTAK[ $nwvl           ]->{'_dndx'} = $self->{'_dndx'};
        ($DISPSTAK[$nwvl           ], $DISPSTAK[$self->{'_dndx'}]) =
        ($DISPSTAK[$self->{'_dndx'}], $DISPSTAK[$nwvl           ]);}
      $self->{$attr}   = $nwvl;
      $self->{'_chgd'} = 1;#curs_set($self->{'_flagcvis'}) if($crsr && $self->{'_chgd'});
    }}; # not sure if I need these semicolons after anon sub defz
  $cmnd{'assign'  } ||= $cmnd{'asin'}; # handle normal names too =)
  $cmnd{'blnk'    } ||= sub { # Dflt blank  command
    my $self =  shift(@_);
    $self->{$attr}   = '';
    $self->{'_chgd'} =  1;};
  $cmnd{'blank'   } ||= $cmnd{'blnk'};
  $cmnd{'togl'    } ||= sub { # Dflt toggle command (for flags)
    my $self =  shift(@_);
    $self->{$attr}  ^=  1;
    $self->{'_chgd'} =  1;};
  $cmnd{'toggle'  } ||= $cmnd{'togl'};
  $cmnd{'true'    } ||= sub { # Dflt truth  command (for flags)
    my $self =  shift(@_);
    $self->{$attr}   =  1;
    $self->{'_chgd'} =  1;};
  $cmnd{'fals'    } ||= sub { # Dflt false  command (for flags)
    my $self =  shift(@_);
    $self->{$attr}   =  0;
    $self->{'_chgd'} =  1;};
  $cmnd{'false'   } ||= $cmnd{'fals'};
  $cmnd{'incr'    } ||= sub { # Dflt increment command
    my $self = shift(@_);my $amnt = shift(@_) || 1;
    if(!$dstk || $self->{'_dndx'} < $#DISPSTAK){
      if($dstk){ # exchange display stack indices
        ${$DISPSTAK[$self->{'_dndx'}-1]}->{'_dndx'}--;
        ( $DISPSTAK[$self->{'_dndx'}  ],$DISPSTAK[$self->{'_dndx'}+1]) =
        ( $DISPSTAK[$self->{'_dndx'}+1],$DISPSTAK[$self->{'_dndx'}  ]);}
      $self->{$attr} += $amnt;
      $self->{'_chgd'} = 1;}};
  $cmnd{'increase'} ||= $cmnd{'incr'};
  $cmnd{'decr'    } ||= sub { # Dflt decrement command
    my $self = shift(@_);my $amnt = shift(@_) || 1;
    if(!$dstk || $self->{'_dndx'}){
      if($dstk){ # exchange display stack indices
        ${$DISPSTAK[$self->{'_dndx'}-1]}->{'_dndx'}++;
        ( $DISPSTAK[$self->{'_dndx'}  ],$DISPSTAK[$self->{'_dndx'}-1]) =
        ( $DISPSTAK[$self->{'_dndx'}-1],$DISPSTAK[$self->{'_dndx'}  ]);}
      $self->{$attr} -= $amnt;
      $self->{'_chgd'} = 1;}};
  $cmnd{'decrease'} ||= $cmnd{'decr'};
  if($aray){ # default commands for when $self->{$attr} is an array ref
    $cmnd{'push'  } ||= sub { # Dflt push
      my $self = shift(@_);push(@{$self->{$attr}},shift(@_));
      $self->{'_chgd'} = 1;};
    $cmnd{'popp'  } ||= sub { # Dflt pop
      my $self = shift(@_); pop(@{$self->{$attr}});
      $self->{'_chgd'} = 1;};
    $cmnd{'pop'   } ||= $cmnd{'popp'};
    $cmnd{'apnd'  } ||= sub { # Dflt append to last line
      my $self = shift(@_);
      if(@{$self->{$attr}}){$self->{$attr}->[-1] .= shift(@_) ;}
      else                 {push(@{$self->{$attr}}, shift(@_));}
      $self->{'_chgd'} = 1;};
    $cmnd{'append'} ||= $cmnd{'apnd'};
    $cmnd{'dupl'  } ||= sub { # Dflt duplicate last line or some line #
      my $self = shift(@_);my $lndx = shift(@_) || -1;
      if(@{$self->{$attr}}){push(@{$self->{$attr}},$self->{$attr}->[$lndx]);}
      else                 {push(@{$self->{$attr}},                     '');}
      $self->{'_chgd'} = 1;};
    $cmnd{'duplicate'} ||= $cmnd{'dupl'};
    $cmnd{'size'  } ||= sub { # return array size
      my $self = shift(@_);return(scalar(@{$self->{$attr}}));};
    $cmnd{'data'  } ||= sub { # set && return whole array data
      my $self = shift(@_);@{$self->{$attr}} = shift(@_) if(@_);
      return(@{$self->{$attr}});};
    $cmnd{'nmrc'  } ||= sub { # Dflt nmrc
      my($self,$keey,$valu)= @_;
      if(defined($valu)){ # value exists to be assigned
        $self->{$attr}->[$keey] = $valu;
        if($attr =~ /^text/i && $self->{'_flagaudr'}){
          $self->Prnt('text' => $valu, 'prin' => 0, # new Prnt() just changing line
                      'yoff' => $keey, 'xoff' => 0);
        }else{$self->{'_chgd'} = 1;} # old array element assignment with full AutoDraw
      }else{return($self->{$attr}->[$keey]);}}; # just return array line
    $cmnd{'numeric'} ||= $cmnd{'nmrc'}; # handle normal names too =)
  }else{
    $cmnd{'nmrc'  } ||= sub { # Dflt nmrc for non-arrays
      my($self,$keey,$valu)= @_;
      if(defined($valu)){
        # hmm I don't think non-array fields will have a numeric key && a val
        #  so I don't know what to do here yet
      }else{ # just assign the key if no defined value
        if(!$dstk || (0 <= $keey && $keey < @DISPSTAK)) {
          if($dstk && $self->{'_dndx'} != $keey) { # xchg displaystack indices
            $DISPSTAK[ $keey           ]->{'_dndx'} = $self->{'_dndx'};
            ($DISPSTAK[$keey           ],$DISPSTAK[   $self->{'_dndx'}]) =
            ($DISPSTAK[$self->{'_dndx'}],$DISPSTAK[   $keey           ]);}
          $self->{$attr}   = $keey;
          $self->{'_chgd'} = 1;}}};
    $cmnd{'numeric'} ||= $cmnd{'nmrc'};} # handle normal names too =)
  if($loop){ # default commands for when $self->{$attr} is a loop
    $cmnd{'next'  } ||= sub { # Dflt next
      my $self = shift(@_);
      $self->{$attr}++; # should get loop limit instead of hard @BORDSETS
      $self->{$attr} = 0 if($self->{$attr} > @BORDSETS);
      $self->{'_chgd'} = 1;};
    $cmnd{'prev'  } ||= sub { # Dflt prev
      my $self = shift(@_);
      $self->{$attr}--; # should get loop limit instead of hard @BORDSETS
      $self->{$attr} = @BORDSETS if($self->{$attr} < 0);
      $self->{'_chgd'} = 1;};
    $cmnd{'previous'} ||= $cmnd{'prev'};} # handle normal names too =)
  { no strict 'refs'; # block to isolate no strict where closure gets defined
    *{$meth} = sub {
      my $self = shift(@_);my($keey,$valu);my $foun;
      while(@_){($keey,$valu)=(shift(@_),shift(@_));
        if    (  $keey =~ /\d+$/){ # call a special sub for numeric keyz
          $cmnd{'nmrc'}->($self,$keey,$valu);
        }elsif( defined($cmnd{  $keey})){
          $cmnd{$keey }->($self,      $valu);
        }elsif(!defined(              $valu)){
          $self->{$attr}   =    $keey;
          $self->{'_chgd'} = 1;
        }elsif($keey eq lc($meth)){ # same as 'asin' with meth name instead
          $self->{"_$keey"} =         $valu;
        }else{$foun = 0; # match && update any attributes accepted by new()
          for my $attr ($self->AttrNamz()){
            if     ($attr =~ /$keey/i ||
                    $_verbose_attrnamz{$attr} eq $keey){ # exact match
              $self->{$attr} = $valu;
              $foun = 1;}}
          unless($foun){
#           die "!*EROR*! Curses::Simp->$meth key:$keey was not recognized!";
#           $keey =~ s/^_*/_/; # could just auto-add unfound instead of dying
#           $self->{$keey} = $valu;
          }}}
      curs_set($self->{'_flagcvis'})                    if($crsr);
      ($self->{'_flagmaxi'},$self->{'_flagshrk'})=(0,0) if($rsiz);
      ($self->{'_flagmaxi'},$self->{'_flagcntr'})=(0,0) if($mvwn);
       $self->Move()                                    if($mvcr);
      if   ($self->{'_chgd'} && $self->{'_flagaudr'}){$self->Draw();}
      elsif($mvwn || $updt)                          {$self->Updt();}
      elsif($rsiz)                                   {$self->Rsiz();}
      $self->{'_chgd'} = 0;
      return($self->{$attr});};
    *{$_verbose_attrnamz{$attr}} = \&{$meth}; # also define verbose names as alternate accessor methods
    if($meth =~ /^Flag/){                     #   ... and if the method is a Flag accessor, provide without /^Flag/
      my $flgm = $meth; $flgm =~ s/^Flag//;
      *{$flgm} = \&{$meth};}}}
MkMethdz( 'NAME' => 'Text', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'FClr', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'BClr', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'KQue', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'MQue', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'Hite', 'RSIZ' => 1 );
MkMethdz( 'NAME' => 'Widt', 'RSIZ' => 1 );
MkMethdz( 'NAME' => 'YOff', 'MVWN' => 1 );
MkMethdz( 'NAME' => 'XOff', 'MVWN' => 1 );
MkMethdz( 'NAME' => 'YCrs', 'MVCR' => 1 );
MkMethdz( 'NAME' => 'XCrs', 'MVCR' => 1 );
MkMethdz( 'NAME' => 'BTyp', 'LOOP' => 1 );
MkMethdz( 'NAME' => 'BrFC', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'BrBC', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'Titl' );
MkMethdz( 'NAME' => 'TtFC', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'TtBC', 'ARAY' => 1 );
MkMethdz( 'NAME' => 'DNdx', 'DSTK' => 1 );
MkMethdz( 'NAME' => 'FlagAuDr' );
MkMethdz( 'NAME' => 'FlagADTF' );
MkMethdz( 'NAME' => 'FlagADTB' );
MkMethdz( 'NAME' => 'FlagABA7', 'UPDT' => 1 );
MkMethdz( 'NAME' => 'FlagMaxi', 'UPDT' => 1 );
MkMethdz( 'NAME' => 'FlagShrk', 'UPDT' => 1 );
MkMethdz( 'NAME' => 'FlagCntr', 'UPDT' => 1 );
MkMethdz( 'NAME' => 'FlagCVis', 'CRSR' => 1 );
MkMethdz( 'NAME' => 'FlagScrl' );
MkMethdz( 'NAME' => 'FlagSDLK' );
MkMethdz( 'NAME' => 'FlagFram' );
MkMethdz( 'NAME' => 'FlagMili' );
MkMethdz( 'NAME' => 'FlagPrin' );
MkMethdz( 'NAME' => 'FlagClrU' );
MkMethdz( 'NAME' => 'FlagInsr' );
MkMethdz( 'NAME' => 'FlagDrop' );
MkMethdz( 'NAME' => 'FlagDown' ); # remember that something in old ts.pl caused deep-recursion below && locked-up Aku, in case there's still such a serious bug
sub InitPair{return() unless($curs);my($self,$fgcl,$bgcl)= @_; my($bold,$curp)=(0,0); # internal sub to Initialize && set color Pairs  # shud usualy!init_pair0
  return()   unless( defined($fgcl) && $fgcl =~ /^([0-9a-z._ ^]|-1)$/i);$fgcl= 'k' if($fgcl eq ' '); # -1 BkGr subst dezign8zUzngDfltColrz fromNCursesX10shn
  $bgcl= 'k' unless( defined($bgcl) && $bgcl =~  /^[0-9a-z._-]$/i); # blacK background color is replaced with transparent -1 && '-' is special for really 'k'
#$self->Move(4,4);for(1..255){init_pair($_,$_,-1);$self->{'_wind'}->attron(COLOR_PAIR($_));$self->{'_wind'}->addstr(sprintf("% 4d",$_)); # shO255clrz lIk`tsgr`
#  $self->{'_wind'}->addstr('  ') unless(($_+1) %  8);                                     $self->{'_wind'}->addstr(' ' ) unless(($_+1) % 16);
#  $self->Move($self->YCrs()+1,0) unless(($_+1) % 32);}                   $self->Move(0,0);$self->{'_wind'}->refresh(); $self->GetK(-1);
  if(has_colors()){unless(exists($GLBL{'COLRPNDX'})){$GLBL{'COLRPNDX'}=1;$GLBL{'COLRPARS'} = {'^-1'=>0};$GLBL{'COLRPARY'} = ['^-1'];} # init just A_NORMAL
    if($fgcl eq '-1'){$curp=$self->{'_valullsp'} if(defined($self->{'_valullsp'}));$bold=$self->{'_valullsb'} if(defined($self->{'_valullsb'}));} #go bak2last
    else{my($fcan,$bcan)=(-1,-1);  if($fgcl ne '^' && exists($p622{$fgcl})){$fcan=$p622{$fgcl};} # don't try2 p622{^} here or c8p8[-1] below either
      if($bgcl eq '-'){$bcan=0;}elsif($bgcl ne 'k' && exists($p622{$bgcl})){$bcan=$p622{$bgcl};} # Fore&&BackColorsAsiNdex
      if(COLORS() == 8){for(16..63){if($fgcl eq $c8p8[$_]){$fcan=$_;$fcan -= 16 while($fcan > 15);$fgcl=$c8p8[$fcan] if($fcan != -1);last;}}
                        for( 8..63){if($bgcl eq $c8p8[$_]){$bcan=$_;$bcan -=  8 while($bcan >  7);$bgcl=$c8p8[$bcan] if($bcan != -1);last;}}
                        if($fcan>7){$fcan -= 8;$bold=1;}} # collapse gr8r colrz down by c8p8 ndx above
      unless(exists($GLBL{'COLRPARS'}{$fgcl.$bgcl})){$curp=$GLBL{'COLRPNDX'}++;
        delete(     $GLBL{'COLRPARS'}{$GLBL{'COLRPARY'}[$curp]}) if(defined($GLBL{'COLRPARY'}[$curp])); # DlEt oldSt pair key if more than max,shud warn l8r 2?
        init_pair($curp,$fcan,$bcan); $GLBL{'COLRPARS'}{$fgcl.$bgcl}=$curp; $GLBL{'COLRPARY'}[$curp]=$fgcl.$bgcl; # mIt want2kEp trak of lEastUsed||oldSt betr?
        $GLBL{'COLRPNDX'}=1 if($GLBL{'COLRPNDX'} >= COLOR_PAIRS());} # loop bak2Bgin if max colrpairs have been alloc8d,where nXt init will clobber oldSt
      $curp=$GLBL{'COLRPARS'}{$fgcl.$bgcl};$bold=1 if($fgcl !~ /^[krOgcbPw^]$/ && $self->{'_flagaba7'});} # nIc4most chrz2BsAm bold sIz,but0..7nEd2!Bcome8..15
    unless(defined($curp) && $curp =~ /^\d+$/ && $curp < COLOR_PAIRS()){$curp=0;} # tryng2init_pair0 just shOz Dflt grn tXt lIk aftr term $z or `S ^` reset
    if(defined($self->{'_wind'})){if(!defined($self->{'_valulasp'}) || $self->{'_valulasp'} != $curp){
        $self->{'_wind'}->attroff( COLOR_PAIR($self->{'_valulasp'})) if(defined($self->{'_valulasp'}));
        $self->{'_wind'}->attron(  COLOR_PAIR($curp));} # $self->{'_wind'}->attroff(A_UNDERLINE);$self->{'_wind'}->attroff(A_REVERSE); #+A_BLINK|INVIS|PROTECT
      if( $bold){$self->{'_wind'}->attron(A_BOLD  );}else{$self->{'_wind'}->attroff(A_BOLD  );} # not sure if this is right way to get Dflt grn, but might
      if(!$curp){$self->{'_wind'}->attron(A_NORMAL);}else{$self->{'_wind'}->attroff(A_NORMAL);} #   need2attroff NORM earlier, if curp
      # should add suport4othr attrz lIk A_DIM proly fAint&&A_STANDOUT mItBdif from A_BOLD,lookz lIk my ncurses `m attr` has A_ITALIC but my Curses.pm duz!yet
      if(!defined($self->{'_valulasp'}) || !defined($self->{'_valulasb'}) || $self->{'_valulasp'} != $curp || $self->{'_valulasb'} != $bold){ # upd8 lastz?
        $self->{'_valullsp'} = $self->{'_valulasp'};$self->{'_valulasp'} = $curp;$self->{'_valullsb'} = $self->{'_valulasb'};$self->{'_valulasb'} = $bold;}}
  } return($curp);}
sub BordChar{ my($self, $loca, $noip)= @_; # return characters for different border types with NoInitPair flag to keep border color the same
  unless($noip){ my $fgcl = $self->{'_brfc'}; my $bgcl = $self->{'_brbc'}; $self->InitPair($fgcl, $bgcl) if($self->{'_flagclru'}); }
  $self->{'_wind'}->addch( $BORDSETS[($self->{'_btyp'} - 1)]{lc($loca)} ); }
sub CnvAnsCC{ my $self = shift; my $acod = shift; my @alut = @telc; my $bold = 0; my($fgcl, $bgcl)=('w', 'k'); # convert ANSI Escaped Color Codes
  $acod =~ s/(^[;0]|;$)//g; # strip all trailing or leading semicolons or zeros
  while($acod =~ s/^(\d+);?//){
    if   ( 1 == $1            ){ $bold = 1;                } # Attribute        codes: 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
    elsif(30 <= $1 && $1 <= 37){ $fgcl = $alut[($1 - 30)]; } # Foreground color codes: 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
    elsif(40 <= $1 && $1 <= 47){ $bgcl = $alut[($1 - 40)]; } # Background color codes: 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
  } $fgcl = uc($fgcl) if($bold); return($fgcl, $bgcl); }
sub ShokScrn{ my $self = shift; my($ycrs, $xcrs); my $slvl = 0; my($keey, $valu); my $foun; # shock (redraw) the entire screen && all windows in order
  while(@_){ ($keey, $valu)=(shift, shift); $foun = 0; # load key/vals like new()           # exact  match  ck  belo
    if(defined($valu)){ for my $attr ($self->AttrNamz()){ if($attr =~ /$keey/i || $_verbose_attrnamz{$attr} eq $keey){ $self->{$attr} = $valu; $foun = 1; } }
      unless($foun){ if($keey =~ /slvl/i){ $slvl = $valu; }else{#die "!*EROR*! Curses::Simp->ShokScrn key:$keey was not recognized!\n";
                      # $keey =~ s/^_*/_/; $self->{$keey} = $valu; # auto-add unfound instead of dying?
    } } }else{ $slvl = $keey; } }
  if($slvl > 0){ if($slvl > 1){ if($slvl > 2){ clear(); } touchwin(); } refresh(); }
  for(@DISPSTAK){                  ${$_}->{'_wind'}->touchwin(); # ${$_}->Move(); # just Move()?
    if(     ${$_}->{'_valudol8'}){ ${$_}->{'_wind'}->refresh();    ${$_}->{'_wind'}->getyx(         $ycrs,                $xcrs  );
      print(${$_}->{'_valudol8'}); printf("\e[%d;%dH",   $ycrs + 1, $xcrs);
      if($ycrs != ${$_}->{'_ycrs'} || $xcrs != ${$_}->{'_xcrs'}){  ${$_}->{'_wind'}->move(          $ycrs,                $xcrs  );
                                                                   ${$_}->{'_wind'}->getyx(${$_}->{'_ycrs'},     ${$_}->{'_xcrs'});
        if( ${$_}->{'_btyp'    }){                                                         ${$_}->{'_ycrs'}--;   ${$_}->{'_xcrs'}--; } } }
    ${$_}->{'_wind'}->refresh(); } } # mAB $self->{'_wind'}->clear() or wclear() below would be better? It seems to be working acceptably well for now as-is.
sub Cler{ my $self = shift;clear();refresh();if(defined($self)){$self->{'_text'}->[$_] = ' ' x $self->Widt() for(0..$self->Hite()-1);$self->Draw();}}
sub KNum{ return %knum; } # I thought I might be able to just call clear() && @{$self->{'_text'}}=() abov2blank screen fastest but post Prntz aren't showing up
sub CLet{ return %p622; } # now returning new Pal8 64 to 256 Color Letter map instead of original with just 16 plus the few altern8s
sub OScr{ no strict 'subs'; # Open a new Curses Screen && setup all useful stuff
  unless($GLBL{'FLAGOPEN'}){ $GLBL{'FLAGOPEN'} = 1;
    # raw() allows ^C,^S,^Z 2simply pass thru,unlike cbreak(),but raw requirz`reset`from the cmdline,if the app crashes; napms($ms) 2nap millisecs;
   #use_env(0);
    initscr();noecho();nonl();raw();start_color();$GLBL{'FLAGUDCL'} = eval('use_default_colors(); 1') || 0;
    # H4RM7w9G:added use_env && use_tioctl above to hopefully better handle window resize events from SIGWINCH && KEY_RESIZE. Dfalt 1,0 try 1,1 0,1 or 0,0
    #   from HTTP://Invisible-Island.Net/ncurses/man/curs_util.3x.html ... poopy, my Curses doesn't have use_tioctl && use_env(0) pegs term at 80x24  =(
    # start_color without use_default_colors was making transparent GnomeTerminal BackGround solid blacK; A7QAMqt: ... but since use_default_colors() above is
    #   not defined in some SunOS/Solaris Curses libraries, I've wrapped it in an eval to hopefully pass their CPAN tests; # below: nodelay()||timeout(-1)...
    curs_set(0);keypad(1);meta(1);intrflush(0);notimeout(0);timeout(0);clear();move(getmaxy()-1,getmaxx()-1);             # ... for non||blocking getch()
    refresh();
    @BORDSETS = ( # initscr initializes line-draw chars for my border hash
      { 'ul' => ACS_ULCORNER,                  'ur' => ACS_URCORNER,
                     'rt' => ACS_RTEE,  'lt' => ACS_LTEE,
                     'tt' => ACS_TTEE,  'bt' => ACS_BTEE,
                     'hl' => ACS_HLINE, 'vl' => ACS_VLINE,
        'll' => ACS_LLCORNER,                  'lr' => ACS_LRCORNER, },
      { 'ul' => '+', 'rt' => '{', 'lt' => '}', 'ur' => '+',             #   032:20: !"#$%&'   040:28:()*+,-./   048:30:01234567   056:38:89:;<=>?
                     'tt' => '+', 'bt' => '+',                          #   064:40:@ABCDEFG   072:48:HIJKLMNO   080:50:PQRSTUVW   088:58:XYZ[\]^_
        'll' => '+', 'hl' => '-', 'vl' => '|', 'lr' => '+',          }, #   096:60:`abcdefg   104:68:hijklmno   112:70:pqrstuvw   120:78:xyz{|}~
      { 'ul' => ' ', 'rt' => ' ', 'lt' => ' ', 'ur' => ' ',             #   160:A0: ... had 160-255 here but with new Ubu17.10 && Perl 5.26.0, after
                     'tt' => ' ', 'bt' => ' ',                          #   192:C0:     `pmfi Curses` trying `d8ok` said malformed UTF-8 chars here &&
        'll' => ' ', 'hl' => ' ', 'vl' => ' ', 'lr' => ' ',          }, #   224:E0:     also down in CPik definition of @bchz block chars so replaced
      { 'ul' => ACS_PLUS,                      'ur' => ACS_PLUS,        #               them with normal characters below 128. `d8ok` seems fine now;
                     'rt' => ACS_RARROW,'lt' => ACS_LARROW,
                     'tt' => ACS_UARROW,'bt' => ACS_DARROW,
                     'hl' => ACS_HLINE, 'vl' => ACS_VLINE,
        'll' => ACS_PLUS,                      'lr' => ACS_PLUS,     },
      { 'ul' => 'X', 'rt' => '[', 'lt' => ']', 'ur' => 'X',
                     'tt' => '#', 'bt' => '#',
        'll' => 'X', 'hl' => '=', 'vl' => 'I', 'lr' => 'X',          },
    );
    @kndx = (
      ERR                    , OK                     , ACS_BLOCK             ,
      ACS_BOARD              , ACS_BTEE               , ACS_BULLET            ,
      ACS_CKBOARD            , ACS_DARROW             , ACS_DEGREE            ,
      ACS_DIAMOND            , ACS_HLINE              , ACS_LANTERN           ,
      ACS_LARROW             , ACS_LLCORNER           , ACS_LRCORNER          ,
      ACS_LTEE               , ACS_PLMINUS            , ACS_PLUS              ,
      ACS_RARROW             , ACS_RTEE               , ACS_S1                ,
      ACS_S9                 , ACS_TTEE               , ACS_UARROW            ,
      ACS_ULCORNER           , ACS_URCORNER           , ACS_VLINE             ,
      A_ALTCHARSET           , A_ATTRIBUTES           , A_BLINK               ,
      A_BOLD                 , A_CHARTEXT             , A_COLOR               ,
      A_DIM                  , A_INVIS                , A_NORMAL              ,
      A_PROTECT              , A_REVERSE              , A_STANDOUT            ,
      A_UNDERLINE            , COLOR_BLACK            , COLOR_BLUE            ,
      COLOR_CYAN             , COLOR_GREEN            , COLOR_MAGENTA         ,
      COLOR_RED              , COLOR_WHITE            , COLOR_YELLOW          ,
      KEY_A1                 , KEY_A3                 , KEY_B2                ,
      KEY_BACKSPACE          , KEY_BEG                , KEY_BREAK             ,
      KEY_BTAB               , KEY_C1                 , KEY_C3                ,
      KEY_CANCEL             , KEY_CATAB              , KEY_CLEAR             ,
      KEY_CLOSE              , KEY_COMMAND            , KEY_COPY              ,
      KEY_CREATE             , KEY_CTAB               , KEY_DC                ,
      KEY_DL                 , KEY_DOWN               , KEY_EIC               ,
      KEY_END                , KEY_ENTER              , KEY_EOL               ,
      KEY_EOS                , KEY_EXIT               , KEY_F0                ,
      KEY_FIND               , KEY_HELP               , KEY_HOME              ,
      KEY_IC                 , KEY_IL                 , KEY_LEFT              ,
      KEY_LL                 , KEY_MARK               , KEY_MAX               ,
      KEY_MESSAGE            , KEY_MIN                , KEY_MOVE              ,
      KEY_NEXT               , KEY_NPAGE              , KEY_OPEN              ,
      KEY_OPTIONS            , KEY_PPAGE              , KEY_PREVIOUS          ,
      KEY_PRINT              , KEY_REDO               , KEY_REFERENCE         ,
      KEY_REFRESH            , KEY_REPLACE            , KEY_RESET             ,
      KEY_RESTART            , KEY_RESUME             , KEY_RIGHT             ,
      KEY_SAVE               , KEY_SBEG               , KEY_SCANCEL           ,
      KEY_SCOMMAND           , KEY_SCOPY              , KEY_SCREATE           ,
      KEY_SDC                , KEY_SDL                , KEY_SELECT            ,
      KEY_SEND               , KEY_SEOL               , KEY_SEXIT             ,
      KEY_SF                 , KEY_SFIND              , KEY_SHELP             ,
      KEY_SHOME              , KEY_SIC                , KEY_SLEFT             ,
      KEY_SMESSAGE           , KEY_SMOVE              , KEY_SNEXT             ,
      KEY_SOPTIONS           , KEY_SPREVIOUS          , KEY_SPRINT            ,
      KEY_SR                 , KEY_SREDO              , KEY_SREPLACE          ,
      KEY_SRESET             , KEY_SRIGHT             , KEY_SRSUME            ,
      KEY_SSAVE              , KEY_SSUSPEND           , KEY_STAB              ,
      KEY_SUNDO              , KEY_SUSPEND            , KEY_UNDO              ,
      KEY_UP                 , KEY_MOUSE              , BUTTON1_RELEASED      , # B15BLZo: problem wi some vendor versions of Curses (Perl v5.8.9 on NetBSD) not including these butn constz (even tho Curses::Simp doesn't even use them yet);
      BUTTON1_PRESSED        , BUTTON1_CLICKED        , BUTTON1_DOUBLE_CLICKED,
      BUTTON1_TRIPLE_CLICKED , BUTTON1_RESERVED_EVENT , BUTTON2_RELEASED      ,
      BUTTON2_PRESSED        , BUTTON2_CLICKED        , BUTTON2_DOUBLE_CLICKED,
      BUTTON2_TRIPLE_CLICKED , BUTTON2_RESERVED_EVENT , BUTTON3_RELEASED      ,
      BUTTON3_PRESSED        , BUTTON3_CLICKED        , BUTTON3_DOUBLE_CLICKED,
      BUTTON3_TRIPLE_CLICKED , BUTTON3_RESERVED_EVENT , BUTTON4_RELEASED      ,
      BUTTON4_PRESSED        , BUTTON4_CLICKED        , BUTTON4_DOUBLE_CLICKED,
      BUTTON4_TRIPLE_CLICKED , BUTTON4_RESERVED_EVENT , BUTTON_CTRL           ,
      BUTTON_SHIFT           , BUTTON_ALT             , ALL_MOUSE_EVENTS      ,
      REPORT_MOUSE_POSITION  , NCURSES_MOUSE_VERSION );# , E_OK                  ,
#     E_SYSTEM_ERROR         , E_BAD_ARGUMENT         , E_POSTED              ,
#     E_CONNECTED            , E_BAD_STATE            , E_NO_ROOM             ,
#     E_NOT_POSTED           , E_UNKNOWN_COMMAND      , E_NO_MATCH            ,
#     E_NOT_SELECTABLE       , E_NOT_CONNECTED        , E_REQUEST_DENIED      ,
#     E_INVALID_FIELD        , E_CURRENT              , REQ_LEFT_ITEM         ,
#     REQ_RIGHT_ITEM         , REQ_UP_ITEM            , REQ_DOWN_ITEM         ,
#     REQ_SCR_ULINE          , REQ_SCR_DLINE          , REQ_SCR_DPAGE         ,
#     REQ_SCR_UPAGE          , REQ_FIRST_ITEM         , REQ_LAST_ITEM         ,
#     REQ_NEXT_ITEM          , REQ_PREV_ITEM          , REQ_TOGGLE_ITEM       ,
#     REQ_CLEAR_PATTERN      , REQ_BACK_PATTERN       , REQ_NEXT_MATCH        ,
#     REQ_PREV_MATCH         , MIN_MENU_COMMAND       , MAX_MENU_COMMAND      ,
#     O_ONEVALUE             , O_SHOWDESC             , O_ROWMAJOR            ,
#     O_IGNORECASE           , O_SHOWMATCH            , O_NONCYCLIC           ,
#     O_SELECTABLE           , REQ_NEXT_PAGE          , REQ_PREV_PAGE         ,
#     REQ_FIRST_PAGE         , REQ_LAST_PAGE          , REQ_NEXT_FIELD        ,
#     REQ_PREV_FIELD         , REQ_FIRST_FIELD        , REQ_LAST_FIELD        ,
#     REQ_SNEXT_FIELD        , REQ_SPREV_FIELD        , REQ_SFIRST_FIELD      ,
#     REQ_SLAST_FIELD        , REQ_LEFT_FIELD         , REQ_RIGHT_FIELD       ,
#     REQ_UP_FIELD           , REQ_DOWN_FIELD         , REQ_NEXT_CHAR         ,
#     REQ_PREV_CHAR          , REQ_NEXT_LINE          , REQ_PREV_LINE         ,
#     REQ_NEXT_WORD          , REQ_PREV_WORD          , REQ_BEG_FIELD         ,
#     REQ_END_FIELD          , REQ_BEG_LINE           , REQ_END_LINE          ,
#     REQ_LEFT_CHAR          , REQ_RIGHT_CHAR         , REQ_UP_CHAR           ,
#     REQ_DOWN_CHAR          , REQ_NEW_LINE           , REQ_INS_CHAR          ,
#     REQ_INS_LINE           , REQ_DEL_CHAR           , REQ_DEL_PREV          ,
#     REQ_DEL_LINE           , REQ_DEL_WORD           , REQ_CLR_EOL           ,
#     REQ_CLR_EOF            , REQ_CLR_FIELD          , REQ_OVL_MODE          ,
#     REQ_INS_MODE           , REQ_SCR_FLINE          , REQ_SCR_BLINE         ,
#     REQ_SCR_FPAGE          , REQ_SCR_BPAGE          , REQ_SCR_FHPAGE        ,
#     REQ_SCR_BHPAGE         , REQ_SCR_FCHAR          , REQ_SCR_BCHAR         ,
#     REQ_SCR_HFLINE         , REQ_SCR_HBLINE         , REQ_SCR_HFHALF        ,
#     REQ_SCR_HBHALF         , REQ_VALIDATION         , REQ_NEXT_CHOICE       ,
#     REQ_PREV_CHOICE        , MIN_FORM_COMMAND       , MAX_FORM_COMMAND      ,
#     NO_JUSTIFICATION       , JUSTIFY_LEFT           , JUSTIFY_CENTER        ,
#     JUSTIFY_RIGHT          , O_VISIBLE              , O_ACTIVE              ,
#     O_PUBLIC               , O_EDIT                 , O_WRAP                ,
#     O_BLANK                , O_AUTOSKIP             , O_NULLOK              ,
#     O_PASSOK               , O_STATIC               , O_NL_OVERLOAD         ,
#     O_BS_OVERLOAD          );
    my @knam = qw(
      ERR                      OK                       ACS_BLOCK              
      ACS_BOARD                ACS_BTEE                 ACS_BULLET             
      ACS_CKBOARD              ACS_DARROW               ACS_DEGREE             
      ACS_DIAMOND              ACS_HLINE                ACS_LANTERN            
      ACS_LARROW               ACS_LLCORNER             ACS_LRCORNER           
      ACS_LTEE                 ACS_PLMINUS              ACS_PLUS               
      ACS_RARROW               ACS_RTEE                 ACS_S1                 
      ACS_S9                   ACS_TTEE                 ACS_UARROW             
      ACS_ULCORNER             ACS_URCORNER             ACS_VLINE              
      A_ALTCHARSET             A_ATTRIBUTES             A_BLINK                
      A_BOLD                   A_CHARTEXT               A_COLOR                
      A_DIM                    A_INVIS                  A_NORMAL               
      A_PROTECT                A_REVERSE                A_STANDOUT             
      A_UNDERLINE              COLOR_BLACK              COLOR_BLUE             
      COLOR_CYAN               COLOR_GREEN              COLOR_MAGENTA          
      COLOR_RED                COLOR_WHITE              COLOR_YELLOW           
      KEY_A1                   KEY_A3                   KEY_B2                 
      KEY_BACKSPACE            KEY_BEG                  KEY_BREAK              
      KEY_BTAB                 KEY_C1                   KEY_C3                 
      KEY_CANCEL               KEY_CATAB                KEY_CLEAR              
      KEY_CLOSE                KEY_COMMAND              KEY_COPY               
      KEY_CREATE               KEY_CTAB                 KEY_DC                 
      KEY_DL                   KEY_DOWN                 KEY_EIC                
      KEY_END                  KEY_ENTER                KEY_EOL                
      KEY_EOS                  KEY_EXIT                 KEY_F0                 
      KEY_FIND                 KEY_HELP                 KEY_HOME               
      KEY_IC                   KEY_IL                   KEY_LEFT               
      KEY_LL                   KEY_MARK                 KEY_MAX                
      KEY_MESSAGE              KEY_MIN                  KEY_MOVE               
      KEY_NEXT                 KEY_NPAGE                KEY_OPEN               
      KEY_OPTIONS              KEY_PPAGE                KEY_PREVIOUS           
      KEY_PRINT                KEY_REDO                 KEY_REFERENCE          
      KEY_REFRESH              KEY_REPLACE              KEY_RESET              
      KEY_RESTART              KEY_RESUME               KEY_RIGHT              
      KEY_SAVE                 KEY_SBEG                 KEY_SCANCEL            
      KEY_SCOMMAND             KEY_SCOPY                KEY_SCREATE            
      KEY_SDC                  KEY_SDL                  KEY_SELECT             
      KEY_SEND                 KEY_SEOL                 KEY_SEXIT              
      KEY_SF                   KEY_SFIND                KEY_SHELP              
      KEY_SHOME                KEY_SIC                  KEY_SLEFT              
      KEY_SMESSAGE             KEY_SMOVE                KEY_SNEXT              
      KEY_SOPTIONS             KEY_SPREVIOUS            KEY_SPRINT             
      KEY_SR                   KEY_SREDO                KEY_SREPLACE           
      KEY_SRESET               KEY_SRIGHT               KEY_SRSUME             
      KEY_SSAVE                KEY_SSUSPEND             KEY_STAB               
      KEY_SUNDO                KEY_SUSPEND              KEY_UNDO               
      KEY_UP                   KEY_MOUSE                BUTTON1_RELEASED       
      BUTTON1_PRESSED          BUTTON1_CLICKED          BUTTON1_DOUBLE_CLICKED 
      BUTTON1_TRIPLE_CLICKED   BUTTON1_RESERVED_EVENT   BUTTON2_RELEASED       
      BUTTON2_PRESSED          BUTTON2_CLICKED          BUTTON2_DOUBLE_CLICKED 
      BUTTON2_TRIPLE_CLICKED   BUTTON2_RESERVED_EVENT   BUTTON3_RELEASED       
      BUTTON3_PRESSED          BUTTON3_CLICKED          BUTTON3_DOUBLE_CLICKED 
      BUTTON3_TRIPLE_CLICKED   BUTTON3_RESERVED_EVENT   BUTTON4_RELEASED       
      BUTTON4_PRESSED          BUTTON4_CLICKED          BUTTON4_DOUBLE_CLICKED 
      BUTTON4_TRIPLE_CLICKED   BUTTON4_RESERVED_EVENT   BUTTON_CTRL            
      BUTTON_SHIFT             BUTTON_ALT               ALL_MOUSE_EVENTS       
      REPORT_MOUSE_POSITION    NCURSES_MOUSE_VERSION   );# E_OK                   
#     E_SYSTEM_ERROR           E_BAD_ARGUMENT           E_POSTED               
#     E_CONNECTED              E_BAD_STATE              E_NO_ROOM              
#     E_NOT_POSTED             E_UNKNOWN_COMMAND        E_NO_MATCH             
#     E_NOT_SELECTABLE         E_NOT_CONNECTED          E_REQUEST_DENIED       
#     E_INVALID_FIELD          E_CURRENT                REQ_LEFT_ITEM          
#     REQ_RIGHT_ITEM           REQ_UP_ITEM              REQ_DOWN_ITEM          
#     REQ_SCR_ULINE            REQ_SCR_DLINE            REQ_SCR_DPAGE          
#     REQ_SCR_UPAGE            REQ_FIRST_ITEM           REQ_LAST_ITEM          
#     REQ_NEXT_ITEM            REQ_PREV_ITEM            REQ_TOGGLE_ITEM        
#     REQ_CLEAR_PATTERN        REQ_BACK_PATTERN         REQ_NEXT_MATCH         
#     REQ_PREV_MATCH           MIN_MENU_COMMAND         MAX_MENU_COMMAND       
#     O_ONEVALUE               O_SHOWDESC               O_ROWMAJOR             
#     O_IGNORECASE             O_SHOWMATCH              O_NONCYCLIC            
#     O_SELECTABLE             REQ_NEXT_PAGE            REQ_PREV_PAGE          
#     REQ_FIRST_PAGE           REQ_LAST_PAGE            REQ_NEXT_FIELD         
#     REQ_PREV_FIELD           REQ_FIRST_FIELD          REQ_LAST_FIELD         
#     REQ_SNEXT_FIELD          REQ_SPREV_FIELD          REQ_SFIRST_FIELD       
#     REQ_SLAST_FIELD          REQ_LEFT_FIELD           REQ_RIGHT_FIELD        
#     REQ_UP_FIELD             REQ_DOWN_FIELD           REQ_NEXT_CHAR          
#     REQ_PREV_CHAR            REQ_NEXT_LINE            REQ_PREV_LINE          
#     REQ_NEXT_WORD            REQ_PREV_WORD            REQ_BEG_FIELD          
#     REQ_END_FIELD            REQ_BEG_LINE             REQ_END_LINE           
#     REQ_LEFT_CHAR            REQ_RIGHT_CHAR           REQ_UP_CHAR            
#     REQ_DOWN_CHAR            REQ_NEW_LINE             REQ_INS_CHAR           
#     REQ_INS_LINE             REQ_DEL_CHAR             REQ_DEL_PREV           
#     REQ_DEL_LINE             REQ_DEL_WORD             REQ_CLR_EOL            
#     REQ_CLR_EOF              REQ_CLR_FIELD            REQ_OVL_MODE           
#     REQ_INS_MODE             REQ_SCR_FLINE            REQ_SCR_BLINE          
#     REQ_SCR_FPAGE            REQ_SCR_BPAGE            REQ_SCR_FHPAGE         
#     REQ_SCR_BHPAGE           REQ_SCR_FCHAR            REQ_SCR_BCHAR          
#     REQ_SCR_HFLINE           REQ_SCR_HBLINE           REQ_SCR_HFHALF         
#     REQ_SCR_HBHALF           REQ_VALIDATION           REQ_NEXT_CHOICE        
#     REQ_PREV_CHOICE          MIN_FORM_COMMAND         MAX_FORM_COMMAND       
#     NO_JUSTIFICATION         JUSTIFY_LEFT             JUSTIFY_CENTER         
#     JUSTIFY_RIGHT            O_VISIBLE                O_ACTIVE               
#     O_PUBLIC                 O_EDIT                   O_WRAP                 
#     O_BLANK                  O_AUTOSKIP               O_NULLOK               
#     O_PASSOK                 O_STATIC                 O_NL_OVERLOAD          
#     O_BS_OVERLOAD          );
    # load $knum{CONSTANT_KEY_NUMBER_VALUE} => "CONSTANT_KEY_NAME_STRING" # not mapping -1..9since'0'..'9'are normal chrz&&GetK retnz -1 when $tmot reached
    for($i=0;$i<@kndx;$i++){ if(defined($knam[$i]) && $kndx[$i] =~ /../ && $kndx[$i] ne '-1'){ $knum{"$kndx[$i]"} = "$knam[$i]"; } }
    for($i=265;$i<=279;$i++){ $knum{"$i"} = "KEY_F" . ($i-264); } # add my own new additional key<->num mappings (i.e., 265..279 => F1..F15)
    for($i=0;$i<@kndx;$i++){ if(defined($knam[$i]) && $knam[$i] eq 'A_BOLD'){ # find the right value of the A_BOLD attribute so strict doesn't complain
#       $abld = $kndx[$i] if($kndx[$i] =~ /^\d+$/);last; #$abld = 2097152;
    } } } return; }
sub CScr{ # Close previously OpenedCursesScreen # Following are Curses funcs that might be useful to call in CloseScreen(): termname(),erasechar(),killchar()
  if($curs && $GLBL{'FLAGOPEN'}){${$DISPSTAK[-1]}->DelW() while(@DISPSTAK);$GLBL{'FLAGOPEN'}=0;return(endwin());}} # delete all simp objects before end
sub NumC{ return(COLORS()); }                                     # might also need delscreen() after endwin() above before returning?
# Curses::Simp object constructor as class method or copy as object method. First param can be ref to copy. Not including optional ref from copy,
#   default is no params to create a new empty Simp object. If params are supplied, they must be hash key => value pairs.
sub new{ OScr() unless($GLBL{'FLAGOPEN'}); my($nvkr, $cork)= @_; my($keey, $valu); my $nobj = ref($nvkr); my $clas = $cork; # need Open Screen for new obj
  $clas = $nobj || $nvkr if(!defined($cork) || $cork !~ /::/); my $self = bless({}, $clas); # Class OR Key
  for my $attr ($self->AttrNamz()){ $self->{$attr} = $self->DfltValu($attr); # init defaults && copy if supposed to
                                    $self->{$attr} = $nvkr->{$attr} if($nobj); }  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; }
  if(defined($cork) && $cork !~ /::/){ $nvkr = shift if($nvkr =~ /::/); while(@_){ my $foun = 0; ($keey, $valu)=(shift, shift); # handle init params with
      for my $attr ($self->AttrNamz()){ if($attr =~ /$keey/i){ $self->{$attr} = $valu;$foun = 1; } }                            #   no colons (classname)
      unless(  $foun){ for my $attr ($self->AttrNamz()){ if($_verbose_attrnamz{$attr} eq $keey){ $self->{$attr} = $valu; $foun = 1; } } # exact match
#       unless($foun){ die "!*EROR*! Curses::Simp->new initialization key:$keey was not recognized!\n"; }
      }}}
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'}); $self->Updt(1);
  if($curs){ $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'}, $self->{'_yoff'}, $self->{'_xoff'});
    unless(exists($self->{'_wind'}) && defined($self->{'_wind'})){#exit();
     #die "!*EROR*! Curses::Simp->new could not create window with hite:$self->{'_hite'},widt:$self->{'_widt'},yoff:$self->{'_yoff'},xoff:$self->{'_xoff'}!\n";
    } } $self->TestDraw(); $self->Move(-1, -1) unless($self->{'_ycrs'} || $self->{'_xcrs'}); # newwin does!autodraw so if therz init _text && autodraw is on...
  curs_set($self->{'_flagcvis'}) if($curs); $self->{'_dndx'} = @DISPSTAK; push(@DISPSTAK, \$self); return($self); } # set cursor state,push obj2stack,&&retn
sub Prnt{ # Simp object PrintString method
  my $self = shift; my %parm; my($ycrs, $xcrs); my($keey, $valu);
  my($cnum, $delt, $chrz);    my($yold, $xold); my($fgcl, $bgcl); my $foun;
  $parm{'nore'} = 0; # No Refresh flag init'd to false
  $parm{'ycrs'} = $self->{'_ycrs'};
  $parm{'xcrs'} = $self->{'_xcrs'};
  if($self->{'_btyp'}) { $parm{'ycrs'}++; $parm{'xcrs'}++; }
  $parm{'prin'} = $self->{'_flagprin'}; # init prin param
  while(@_){ ($keey, $valu)=(shift, shift); $foun = 0; if(defined($valu)){ # load params
      for my $attr ($self->AttrNamz()){ if($_verbose_attrnamz{$attr} eq $keey){ $attr =~ s/^_*//; $parm{$attr} = $valu; $foun = 1; } } # exact match
      unless($foun){ $keey =~ s/^_*//; $parm{$keey} = $valu; }
    }else{ $parm{'text'} = $keey; } }
  $chrz = ref($parm{'text'}); # if text, fclr, or bclr are arrays like new or Draw would take, join them
  $parm{'text'} = join("\n", @{$parm{'text'}}) if($chrz eq 'ARRAY');
  if(exists($parm{'fclr'})){ $self->{'_flagclru'} = 1; $chrz = ref($parm{'fclr'}); $parm{'fclr'} = join("\n", @{$parm{'fclr'}}) if($chrz eq 'ARRAY'); }
  if(exists($parm{'bclr'})){ $self->{'_flagclru'} = 1; $chrz = ref($parm{'bclr'}); $parm{'bclr'} = join("\n", @{$parm{'bclr'}}) if($chrz eq 'ARRAY'); }
  return() unless(exists($parm{'text'}) && defined($parm{'text'}) && length($parm{'text'}));
  ($yold, $xold)=($self->{'_ycrs'}, $self->{'_xcrs'});
  $parm{'ycrs'} = $parm{'ytmp'} if(exists($parm{'ytmp'}));
  $parm{'xcrs'} = $parm{'xtmp'} if(exists($parm{'xtmp'})); # below had Malformed UTF-8 character (unexpected continU8ion byt 0x9b && 9c,wi no prECdng stRt byt)
  $parm{'text'} =~ s/[ 	]/ /g; # Prnt does not support escaped printf chars like Draw
  unless($curs){ system("attrib /q /e -rsh C:\\SimpDraw.bat") if(-e 'C:/SimpDraw.bat' && !-w 'C:/SimpDraw.bat');
                 system("del    /q /e      C:\\SimpDraw.bat") if(-e 'C:/SimpDraw.bat' && !-w 'C:/SimpDraw.bat'); open(SCRP,'>>','C:\SimpDraw.bat'); }
  if($parm{'prin'}){ if($self->{'_btyp'}){ if($parm{'ycrs'}){ $parm{'ycrs'}--; }else{ $parm{'zery'} = 1; }
                                           if($parm{'xcrs'}){ $parm{'xcrs'}--; }else{ $parm{'zerx'} = 1; } }
    unless(@{$self->{'_text'}} > $parm{'ycrs'} && defined($self->{'_text'}->[$parm{'ycrs'}])){ $self->{'_text'}->[$parm{'ycrs'}]  = ''; }
    if(length($self->{'_text'}->[$parm{'ycrs'}]) > $parm{'xcrs'}){substr($self->{'_text'}->[$parm{'ycrs'}],$parm{'xcrs'},length($parm{'text'}),$parm{'text'});}
    else{     $self->{'_text'}->[$parm{'ycrs'}] .= ' ' x ($parm{'xcrs'} - length($self->{'_text'}->[$parm{'ycrs'}])) . $parm{'text'};}
    if($self->{'_btyp'}){ $parm{'ycrs'}++ unless(exists($parm{'zery'})); $parm{'xcrs'}++ unless(exists($parm{'zerx'})); } }
  if(exists($parm{'fclr'}) || exists($parm{'bclr'})){ if($parm{'prin'}){ if($self->{'_btyp'}){ if($parm{'ycrs'}){ $parm{'ycrs'}--; }else{ $parm{'zery'} = 1; }
                                                                                               if($parm{'xcrs'}){ $parm{'xcrs'}--; }else{ $parm{'zerx'} = 1; }}
                                                                                        if($self->{'_btyp'}){ $parm{'ycrs'}++ unless(exists($parm{'zery'}));
                                                                                                              $parm{'xcrs'}++ unless(exists($parm{'zerx'})); }}
    $parm{'ycrs'} = 0 unless($parm{'ycrs'} =~ /^\d+$/); $parm{'xcrs'} = 0 unless($parm{'xcrs'} =~ /^\d+$/); $cnum = 0;
    while(length($parm{'text'})){ $chrz = substr($parm{'text'}, 0, 1, ''); $delt = 0;
      if(exists($parm{'fclr'}) && length($parm{'fclr'})){ $fgcl = substr($parm{'fclr'}, 0, 1, ''); }
      if(exists($parm{'bclr'}) && length($parm{'bclr'})){ $bgcl = substr($parm{'bclr'}, 0, 1, ''); } $self->InitPair($fgcl, $bgcl);
      while((!exists($parm{'fclr'}) || !length($parm{'fclr'})  || substr($parm{'fclr'}, 0, 1) eq $fgcl) &&
            (!exists($parm{'bclr'}) || !length($parm{'bclr'})  || substr($parm{'bclr'}, 0, 1) eq $bgcl) && length($parm{'text'})){ $cnum++; $delt++;
        substr($parm{'fclr'}, 0, 1, '') if(exists($parm{'fclr'}) && length($parm{'fclr'}));
        substr($parm{'bclr'}, 0, 1, '') if(exists($parm{'bclr'}) && length($parm{'bclr'})); $chrz .= substr($parm{'text'}, 0, 1, ''); }
      $chrz = '' unless(defined($chrz));
      if(exists($parm{'ycrs'}) && exists($parm{'xcrs'})){ if($curs){ $self->{'_wind'}->addstr($parm{'ycrs'}, $parm{'xcrs'} + ($cnum - $delt), $chrz); }
      }  $cnum++; }
  }else{ $cnum = length($parm{'text'}); if(exists($parm{'ycrs'}) && exists($parm{'xcrs'})){
      if($curs){ $self->{'_wind'}->addstr($parm{'ycrs'}, $parm{'xcrs'}, $parm{'text'}); }
      else     { print SCRP "\@screen " . $parm{'ycrs'} . ' ' . $parm{'xcrs'} . ' ' . $parm{'text'} . "\n"; } } }
  $self->{'_wind'}->getyx($self->{'_ycrs'},     $self->{'_xcrs'}) if($curs);
  if($self->{'_btyp'}){   $self->{'_ycrs'}--;   $self->{'_xcrs'}--; }
  if($curs){ if(exists($parm{'ytmp'}) || exists($parm{'xtmp'})){ $self->Move($yold, $xold); } elsif(!$parm{'nore'}){ $self->{'_wind'}->refresh(); } }
  else     { close(SCRP); system('call C:\SimpDraw.bat'); } return($cnum); }
sub Draw{ # Simp object self Drawing method
  my $self = shift; my($fgcl, $bgcl); my($fgct, $bgct); my($lnum, $cnum);
  my($keey, $valu); my($delt, $char); my($yoff, $xoff); my($ordc, $ordd);
  my($ltxt, $clin, $blin);            my($dol8, $tndx, $foun);
  while(@_){ # load key/vals like new()
    ($keey, $valu)=(shift, shift); $foun = 0;
    if(defined($valu)){
      for my $attr ($self->AttrNamz()){
        if     ($attr =~ /$keey/i ||
                $_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;
          $foun = 1;
        }
      }
#     unless($foun){
#       die "!*EROR*! Curses::Simp::Draw key:$keey was not recognized!\n";
#       $keey =~ s/^_*/_/; # auto-add unfound instead of dying?
#       $self->{$keey} = $valu;
#     }
    }else{
      my $reft = ref($keey);
      if($reft eq 'ARRAY'){   $self->{'_text'}  =             $keey ; }
      else                { @{$self->{'_text'}} = split(/\n/, $keey); }
    }
  }
  $self->Updt();
  if($curs){ $self->{'_wind'}->move(0, 0); }
  else     {
    system("attrib /q /e -rsh C:\\SimpDraw.bat") if(-e 'C:/SimpDraw.bat' && !-w 'C:/SimpDraw.bat');
    system("del    /q /e      C:\\SimpDraw.bat") if(-e 'C:/SimpDraw.bat' && !-w 'C:/SimpDraw.bat');
    open(SCRP, ">C:\\SimpDraw.bat"); print SCRP "\@echo off\n\@cls\n";
  }
  if($self->{'_btyp'}){
    $self->BordChar('ul');
    $tndx = int((($self->{'_widt'} - 2) - length($self->{'_titl'})) / 2);
    if(length($self->{'_titl'})){
      for(my $i=1;$i<$tndx;$i++){
        $self->BordChar('hl', 1);
      }
      $self->BordChar('rt', 1); $tndx++;
      if($self->{'_flagclru'}){
        $self->Prnt('text' => $self->{'_titl'}, 'ytmp' => 0, 'prin' => 0,
                    'fclr' => $self->{'_ttfc'}, 'xtmp' => $tndx,
                    'bclr' => $self->{'_ttbc'} );
      }else{
        $self->Prnt('text' => $self->{'_titl'}, 'ytmp' => 0, 'prin' => 0,
                                                'xtmp' => $tndx );
      }
      $tndx += length($self->{'_titl'});
      $self->{'_wind'}->move(0, $tndx);
      $self->BordChar('lt');
      for(my $i = 1; $i < int((($self->{'_widt'} - 1) - length($self->{'_titl'})) / 2); $i++){
        $self->BordChar('hl', 1);
      }
    }else{
      for(my $i = 0; $i < ($self->{'_widt'} - 2); $i++){
        $self->BordChar('hl', 1);
      }
    }
    if( $self->{'_flagscrl'} ||
       ($self->{'_flagdrop'} && !$self->{'_flagdown'})){
      $self->{'_wind'}->move(0, ($self->{'_widt'} - 4));
      $self->BordChar('tt', 1);
      $self->{'_wind'}->move(0, ($self->{'_widt'} - 1));
    }
    $self->BordChar('ur', 1);
  }
  for($lnum = 0;  $lnum < @{$self->{'_text'}} &&
                ( $lnum <  ($self->{'_hite'} - 2) ||
                 ($lnum <   $self->{'_hite'} && !$self->{'_btyp'})); $lnum++){
    $ltxt = $self->{'_text'}->[$lnum];
    chomp($ltxt) if(defined($ltxt));
    $self->BordChar('vl', 1) if($self->{'_btyp'});
    $self->InitPair(-1)      if($self->{'_btyp'} && $self->{'_flagclru'});
    $ltxt = ' ' x $self->{'_widt'} unless(defined($ltxt));
    if    (length($ltxt) > ($self->{'_widt'} - 2) && $self->{'_btyp'}){
      $ltxt = substr($ltxt, 0, ($self->{'_widt'} - 2));
    }elsif(length($ltxt) >  $self->{'_widt'}                         ){
      $ltxt = substr($ltxt, 0,  $self->{'_widt'}     );
    }
    if((exists($self->{'_fclr'}) && $self->{'_fclr'} && @{$self->{'_fclr'}}) || # below had Malformed UTF-8 character (unexpected continuation byte 0x9b && 9c,
       $ltxt =~ /[ 	]/){ # with no preceding start byte)
      if($self->{'_fclr'} && defined($self->{'_fclr'}->[$lnum])){
        $clin = $self->{'_fclr'}->[$lnum];
      }
      if(exists($self->{'_bclr'}) && $self->{'_bclr'} && defined($self->{'_bclr'}->[$lnum])){
        $blin = $self->{'_bclr'}->[$lnum];
      }
      for($cnum = 0; $cnum < length($ltxt); $cnum++){
        if($cnum <= $self->{'_widt'}){
          $delt = 0;
          if(                              $self->{'_fclr'} && @{$self->{'_fclr'}} && defined($self->{'_fclr'}->[$lnum]) && length($clin) >= ($cnum + 1)){
            $fgcl = substr($clin, $cnum, 1);
            $bgcl = 'k' unless(defined($bgcl) && length($bgcl));
            if(exists($self->{'_bclr'}) && $self->{'_bclr'} && @{$self->{'_bclr'}} && defined($self->{'_bclr'}->[$lnum]) && length($blin) >= ($cnum + 1)){
              $bgcl = substr($blin, $cnum, 1);}
            $self->InitPair($fgcl, $bgcl);
            $self->{'_flagclru'} = 1;}
          $ordc = ord(substr($ltxt, $cnum    , 1));
          $ordd = ord(substr($ltxt, $cnum + 1, 1));
          while($cnum < (length($ltxt) - 1) &&
            $ordc > 31 && $ordc != 127 && $ordc != 155 && $ordc != 156 &&
            $ordd > 31 && $ordd != 127 && $ordd != 155 && $ordd != 156 &&
            (!defined($self->{'_fclr'}->[$lnum])  ||
             length($clin) < ($cnum+1)            ||
             ($fgcl eq substr($clin, ($cnum+1),   1))) &&
            (!exists( $self->{'_bclr'})           ||
             !        $self->{'_bclr'}            ||
             !      @{$self->{'_bclr'}}           ||
             !defined($self->{'_bclr'}->[$lnum])  ||
             length($blin) < ($cnum+1)            ||
             ($bgcl eq substr($blin, ($cnum+1),   1)))){
            $cnum++;$delt++;
            $ordc = $ordd;
            $ordd = ord(substr($ltxt, $cnum + 1, 1));}
          $char = substr($ltxt, $cnum, 1);
          $ordc = ord($char);
          if(!$delt &&
            ($ordc <=  31 || $ordc == 127 || $ordc == 155 || $ordc == 156)) {
            if($self->{'_fclr'} && @{$self->{'_fclr'}}){
              $fgct = $fgcl; $fgct = $clet{$fgcl} if(exists($clet{$fgcl}));
              $bgct = $bgcl; $bgct = $clet{$bgcl} if(exists($clet{$bgcl}));
              if   (ord($fgct) >= ord('A')){$delt = 1;$fgct  = ((ord($fgct) - ord('A')) + 32);}
              elsif(    $fgct  >=      8  ){$delt = 1;$fgct += 22;}
              else                         {$delt = 0;$fgct += 30;}
              if   (ord($bgct) >= ord('A')){          $bgct  = ((ord($bgct) - ord('A')) + 42);}
              elsif(    $bgct  >=      8  ){          $bgct += 32;}
              else                         {          $bgct += 40;}}
          # fonter blanks:0,7,8,  10,   12,13,14,15,      27,155
            for my $tstc (0,7,8,9,10,11,12,13,14,15,24,26,27,155){
              $char = ' ' if($ordc == $tstc);}
            if($curs){$self->{'_wind'}->addstr(' ');}
            else     {print SCRP "\@screen $lnum 0 ^s\n";} #+0 +0 ^s\n";}
            $yoff = $self->{'_yoff'} + 1;
            $xoff = $self->{'_xoff'} + 1;
            if($self->{'_btyp'}){$yoff++;$xoff++;}
            # some special chars must be printed with escapes done later (l8)
            if($self->{'_fclr'} && @{$self->{'_fclr'}}){
              $dol8 .= sprintf("\e[%d;%dH\e[%d;%d;%dm$char", ($lnum + $yoff), ($cnum + $xoff), $delt, $fgct, $bgct);}
            else{
              $dol8 .= sprintf("\e[%d;%dH\e[%dm$char"      , ($lnum + $yoff), ($cnum + $xoff), $delt              );}
          }else{
            if($curs){$self->{'_wind'}->addstr(substr($ltxt, $cnum - $delt, $delt+1));}}}}
      if($curs && $cnum < $self->{'_widt'}){my $wmc2=($self->{'_widt'} - $cnum) - 2;$wmc2=0 if($wmc2 < 0);
        $self->{  '_wind'}->addstr(' ' x $wmc2); # this WidthMinusCnum&&2 is non-negative to stifle new 5.22 warning about
        $self->{  '_wind'}->addstr('  ') unless($self->{'_btyp'} || # negative repeat count for x doing nothing
                                       !defined($ltxt)           ||
                                         length($ltxt) == $self->{'_widt'});}
    }else{ # no color
      if($curs){$self->{'_wind'}->addstr($ltxt);}
      else     {print SCRP "\@screen $lnum 0 $ltxt\n";}
      if(length($ltxt) < ($self->{'_widt'} - 2)){
        if($curs){
          $self->{'_wind'}->addstr(' ' x (($self->{'_widt'} - 2) - length($ltxt)));
          $self->{'_wind'}->addstr('  ') unless($self->{'_btyp'});}}}
    $self->BordChar('vl') if($self->{'_btyp'});}
  if(($lnum < ($self->{'_hite'} - 2)) || # pad blank lines if height not full
     ($lnum <  $self->{'_hite'} && !$self->{'_btyp'})){
    $ltxt  = ' ' x ($self->{'_widt'} - 2);
    $ltxt .= '  ' unless($self->{'_btyp'});
    while($lnum < $self->{'_hite'}){
      if($self->{'_btyp'}){
        $self->BordChar('vl', 1);
        $self->InitPair('k', 'k') if($self->{'_flagclru'});} # black blanks
      if($curs){$self->{'_wind'}->addstr($ltxt);}
      if($self->{'_btyp'}){
        $self->BordChar('vl');
        $lnum+=2 if($lnum >= ($self->{'_hite'} - 3));}
      $lnum++;}}
  if($self->{'_btyp'}){
    $self->BordChar('ll');
    $self->BordChar('hl', 1) for(2..$self->{'_widt'});
    $self->BordChar('lr', 1);
    if    ($self->{'_flagdrop'} && !$self->{'_flagdown'}){
      $self->{'_wind'}->move(1, ($self->{'_widt'} - 4));
      $self->BordChar('vl', 1); $self->{'_wind'}->addstr('\/');
      $self->{'_wind'}->move(($self->{'_hite'} - 1), ($self->{'_widt'} - 4));
      $self->BordChar('bt', 1);
    }elsif($self->{'_flagscrl'}){
      $self->{'_wind'}->move(1, ($self->{'_widt'} - 4));
      $self->BordChar('vl', 1); $self->{'_wind'}->addstr('/\\');
      for(my $lndx = 2; $lndx < ($self->{'_hite'} - 2); $lndx++){
        $self->{'_wind'}->move($lndx, ($self->{'_widt'} - 4));
        $self->BordChar('vl', 1); $self->{'_wind'}->addstr('..');}
      $self->{'_wind'}->move(($self->{'_hite'} - 2), ($self->{'_widt'} - 4));
      $self->BordChar('vl', 1); $self->{'_wind'}->addstr('\/');
      $self->{'_wind'}->move(($self->{'_hite'} - 1), ($self->{'_widt'} - 4));
      $self->BordChar('bt', 1);}}
  unless($curs){close(SCRP);system("call C:\\SimpDraw.bat");}
  $self->{'_valudol8'} = $dol8 if(defined($dol8));
  $self->Move();return();} # replace cursor position && refresh the window
sub TestDraw{ # Test whether an auto-Draw() should be called
  $_[0]->Draw() if($_[0]->{'_text'} && @{$_[0]->{'_text'}} && $_[0]->{'_flagaudr'});}
sub Wait{my $self = shift;my $wait = 0;my($keey,$valu);my $foun;
  while(@_){ # load key/vals like new()
    ($keey,$valu)=(shift,shift);$foun = 0;
    if(defined($valu)){
      for my $attr ($self->AttrNamz()){
        if($attr =~ /$keey/i || $_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;$foun = 1;}}
      unless($foun){
        if($keey =~ /wait/i){$wait = $valu;}
        else                {#die "!*EROR*! Curses::Simp->Wait key:$keey was not recognized!\n";
#         $keey =~ s/^_*/_/; # auto-add unfound?
#         $self->{$keey} = $valu;
        }}}
    else{$wait = $keey;}}
  if    ( $self->{'_flagfram'}){ # cnv from Time::Frame        to Curses ms
    $wait = Time::Frame->new($wait) unless(ref($wait) eq "Time::Frame");
    $wait = int($wait->total_frames() / 60.0 * 1000);
  }elsif(!$self->{'_flagmili'}){ # cnv from Dflt float seconds to Curses ms
    $wait = int($wait * 1000); }
  return(napms($wait));}
sub GetK{
  my $self = shift; my $tmot = 0; my $tsdl = 0;
  my($keey, $valu); my $foun; my $char;
  while(@_){ # load key/vals like new()
    ($keey, $valu)=(shift, shift); $foun = 0;
    if(defined($valu)){
      for my $attr ($self->AttrNamz()){
        if     ($attr =~ /$keey/i ||
                $_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;
          $foun = 1;
        }
      }
      unless($foun){
        if    ($keey =~ /tmot/i || $keey eq 'Timeout'){
          $tmot = $valu;
        }elsif($keey =~ /tsdl/i || $keey eq 'TempSDLKey'){
          $tsdl = $valu;
#       }else{#die "!*EROR*! Curses::Simp->GetK key:$keey was not recognized!\n";
#         $keey =~ s/^_*/_/; # auto-add unfound
#         $self->{$keey} = $valu;
        }
      }
    }else{
      $tmot = $keey;
    }
  }
  if($tmot ne '-1'){
    if    ( $self->{'_flagfram'}){ # cnv from Time::Frame        to Curses ms
      $tmot = Time::Frame->new($tmot) unless(ref($tmot) eq "Time::Frame");
      $tmot = int($tmot->total_frames() / 60.0 * 1000);
    }elsif(!$self->{'_flagmili'}){ # cnv from Dflt float seconds to Curses ms
      $tmot = int($tmot * 1000);
    }
  }
  timeout($tmot) if($curs);
  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; } # clear keymods
  if($self->{'_flagsdlk'} || $tsdl){
    if($curs){ $char = getch(); }
    my $ordc = ord($char);
    $self->{'_kmod'}->{'KMOD_NONE'} = 1;
    if($char =~ /^[A-Z]$/) {
      $self->{'_kmod'}->{'KMOD_NONE'}  = 0;
      $self->{'_kmod'}->{'KMOD_SHIFT'} = 1;
      $char = lc($char);
    }
    if($char ne '-1'){ # $tmot not reached
      if    ($char =~ /^[a-z0-9]$/){
        $char = "SDLK_$char";
      }elsif(exists($SDLKCHRM{$char})){
        $char = "SDLK_$SDLKCHRM{$char}";
      }elsif(exists($knum{$char}) && exists($SDLKCRSM{$knum{$char}})){
        $char = "SDLK_$SDLKCRSM{$knum{$char}}";
      }elsif($ordc == 27){ # escape or Alt-?
        timeout(0);
        my $chr2 = getch();
        if(defined($chr2) && $chr2 ne '-1'){
          $self->{'_kmod'}->{'KMOD_NONE'} = 0;
          $self->{'_kmod'}->{'KMOD_ALT'}  = 1;
          if($chr2 =~ /^[A-Z]$/){
            $self->{'_kmod'}->{'KMOD_SHIFT'} = 1;
            $char = lc($char);
          }
          if    (exists($SDLKCHRM{$chr2})){
            $char = "SDLK_$SDLKCHRM{$chr2}";
          }elsif(exists($knum{$char}) && exists($SDLKCRSM{$knum{$char}})){
            $char = "SDLK_$SDLKCRSM{$knum{$chr2}}";
          }else{
            $char = "SDLK_$chr2";
          }
        }
      }elsif(exists($SDLKORDM{$ordc})){
        $char = "SDLK_$SDLKORDM{$ordc}";
      }elsif($ordc < 27){
        $self->{'_kmod'}->{'KMOD_NONE'} = 0;
        $self->{'_kmod'}->{'KMOD_CTRL'} = 1;
        $char = "SDLK_" . chr($ordc + 96);
      }
    }
  # not detected correctly yet:
#  'SDLK_CLEAR',          #        clear
#  'SDLK_PAUSE',          #        pause
#  'SDLK_KP0',            #        keypad 0
#  'SDLK_KP1',            #        keypad 1
#  'SDLK_KP2',            #        keypad 2
#  'SDLK_KP3',            #        keypad 3
#  'SDLK_KP4',            #        keypad 4
#  'SDLK_KP5',            #        keypad 5
#  'SDLK_KP6',            #        keypad 6
#  'SDLK_KP7',            #        keypad 7
#  'SDLK_KP8',            #        keypad 8
#  'SDLK_KP9',            #        keypad 9
#  'SDLK_KP_PERIOD',      #'.'     keypad period
#  'SDLK_KP_DIVIDE',      #'/'     keypad divide
#  'SDLK_KP_MULTIPLY',    #'*'     keypad multiply
#  'SDLK_KP_MINUS',       #'-'     keypad minus
#  'SDLK_KP_PLUS',        #'+'     keypad plus
#  'SDLK_KP_ENTER',       #'\r'    keypad enter
#  'SDLK_KP_EQUALS',      #'='     keypad equals
#  'SDLK_NUMLOCK',        #        numlock
#  'SDLK_CAPSLOCK',       #        capslock
#  'SDLK_SCROLLOCK',      #        scrollock
#  'SDLK_RSHIFT',         #        right shift
#  'SDLK_LSHIFT',         #        left shift
#  'SDLK_RCTRL',          #        right ctrl
#  'SDLK_LCTRL',          #        left ctrl
#  'SDLK_RALT',           #        right alt
#  'SDLK_LALT',           #        left alt
#  'SDLK_RMETA',          #        right meta
#  'SDLK_LMETA',          #        left meta
#  'SDLK_LSUPER',         #        left windows key
#  'SDLK_RSUPER',         #        right windows key
#  'SDLK_MODE',           #        mode shift
#  'SDLK_HELP',           #        help
#  'SDLK_PRINT',          #        print-screen
#  'SDLK_SYSREQ',         #        SysRq
#  'SDLK_BREAK',          #        break
#  'SDLK_MENU',           #        menu
#  'SDLK_POWER',          #        power
#  'SDLK_EURO',           #        euro
#  kmods:
#  'KMOD_NONE',           #        No modifiers applicable
#  'KMOD_CTRL',           #        A Control key is down
#  'KMOD_SHIFT',          #        A Shift key is down
#  'KMOD_ALT',            #        An Alt key is down
  }else{
    if($curs){
      $char = getch();
      $char = "$knum{$char}" if(defined($char) && exists($knum{$char})); # "KEY_" names if exists
    }
  }
  unshift(@{$self->{'_kque'}}, $char);
  unshift(@{$self->{'_mque'}}, { }); # save %kmod too
  for(@KMODNAMZ){ $self->{'_mque'}->[0]->{$_} = $self->{'_kmod'}->{$_}; }
  while(@{$self->{'_kque'}} > 63){ # keep up to 64 key presses && kmods
    pop(@{$self->{'_kque'}});
    pop(@{$self->{'_mque'}});
  }
  return($char);
}
sub KMod{ # accessor for the %{$self->{'_kmod'}} hash
  my $self = shift; my $kmod = 'KMOD_NONE';
  my($keey, $valu); my $foun;
  while(@_){ # load key/vals like new()
    ($keey, $valu)=(shift, shift); $foun = 0;
    if(defined($valu)){
      for my $attr ($self->AttrNamz()){
        if     ($attr =~ /$keey/i ||
                $_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;
          $foun = 1;
        }
      }
      unless($foun){
        if($keey =~ /kmod/i){
          $kmod = $valu;
#       }else{#die "!*EROR*! Curses::Simp::KMod key:$keey was not recognized!\n";
#         $keey =~ s/^_*/_/; # auto-add unfound
#         $self->{$keey} = $valu;
        }
      }
    }else{
      $kmod = $keey;
    }
  }
  for(@KMODNAMZ){
    if(/$kmod$/i){
      $valu = shift;
      $self->{'_kmod'}->{$_} = $valu if(defined($valu));
      return($self->{'_kmod'}->{$_});
    }
  }
}
sub GetS{ # Get a string at the cursor or pass temp y, x, and length params
  my $self = shift(); # maybe GetS() should update the cursor loc too?
  my $ycrs = shift(); $ycrs = $self->YCrs() unless(defined($ycrs));
  my $xcrs = shift(); $xcrs = $self->XCrs() unless(defined($xcrs));
  my $leng = shift();
  my $line = $self->{'_text'}->[$ycrs]; $line = '' unless(defined($line));
  if(length($line) >= $xcrs){
    if(defined($leng) && $leng <= (length($line) - $xcrs)){
      return(substr($line, $xcrs, $leng));
    }else{
      return(substr($line, $xcrs));
    }
  }
}
sub Move{ # update cursor position
  my $self = shift; my($ycrs, $xcrs)=(shift, shift); my $eflg = 0;
  if(defined($ycrs) && defined($xcrs)){ # (-1, -1) is a special Move exception to put cursor in lower right corner of border (if BTyp)
    if($ycrs == -1 && $xcrs == -1){ $eflg = 1;
      $ycrs = ($self->{'_hite'}-1);
      $xcrs = ($self->{'_widt'}-1);
    }
  }else{
    $ycrs = $self->{'_ycrs'} unless(defined($ycrs));
    $xcrs = $self->{'_xcrs'} unless(defined($xcrs));
  }
  $ycrs = 0 if($ycrs < 0);
  $xcrs = 0 if($xcrs < 0);
  if($self->{'_btyp'}){ # trap cursor inside border
    if    (($ycrs == $self->{'_hite'}-1 &&
            $xcrs == $self->{'_widt'}-2) ||
           ($ycrs == $self->{'_hite'}-2 &&
            $xcrs == $self->{'_widt'}-1)){
      $ycrs = $self->{'_hite'}-2;
      $xcrs = $self->{'_widt'}-2;
    }elsif(!$eflg){ $ycrs++; $xcrs++;
      $ycrs = $self->{'_hite'}-2 if($ycrs > $self->{'_hite'}-2);
      $xcrs = $self->{'_widt'}-2 if($xcrs > $self->{'_widt'}-2);
    }
  }else{
    $ycrs   = $self->{'_hite'}-1 if($ycrs > $self->{'_hite'}-1);
    $xcrs   = $self->{'_widt'}-1 if($xcrs > $self->{'_widt'}-1);
  }
  if($curs && $self->{'_valudol8'}){
    $self->{'_wind'}->refresh();
    $self->{'_wind'}->getyx($self->{'_ycrs'}, $self->{'_xcrs'});
    print($self->{'_valudol8'});
    printf("\e[%d;%dH", $self->{'_ycrs'} + 1, $self->{'_xcrs'});
  }
  if($curs){
    $self->{'_wind'}->move($ycrs, $xcrs);
    $self->{'_wind'}->getyx($self->{'_ycrs'}, $self->{'_xcrs'});
  }
  if($self->{'_btyp'}){ $self->{'_ycrs'}--; $self->{'_xcrs'}--; }
  $self->{'_wind'}->refresh() if($curs);
  return($self->{'_ycrs'}, $self->{'_xcrs'});
}
sub Rsiz{ # update window dimensions (Resize)
  my $self = shift; my $hite = shift; my $widt = shift; my $eflg = 0;
  my ($ymax, $xmax);
  #if(is_term_resized()){endwin();refresh();} # resizeterm();} # try2handle SIGWINCH KEY_RESIZE 401 terminal size changes,but might need2try endwin()/refresh()
  #    since preferable use_tioctl(1) option is not available in my Curses.pm && use_env(0) just pegs 80x24. =( Might use doupdate() instead of refresh()?
  if(defined($hite) && defined($widt)){
    $hite = getmaxy() if($hite == -1);
    $widt = getmaxx() if($widt == -1);
  }else{
    $hite = $self->{'_hite'} unless(defined($hite));
    $widt = $self->{'_widt'};
  }
  $hite = 1 if($hite < 1);
  $widt = 1 if($widt < 1);
  if($self->{'_btyp'}){ # don't resize text && borders away
    $hite = 3 if($hite < 3);
    $widt = 3 if($widt < 3);
    $ymax = $self->{'_wind'}->getmaxy();
    $xmax = $self->{'_wind'}->getmaxx();
    if(($self->{'_ycrs'} == ($hite - 2) &&
        $self->{'_xcrs'} == ($widt - 3) &&
        $self->{'_widt'} != ($xmax    )) ||
       ($self->{'_ycrs'} == ($hite - 3) &&
        $self->{'_xcrs'} == ($widt - 2) &&
        $self->{'_hite'} != ($ymax    )) ||
       ($self->{'_ycrs'} == ($hite - 1) &&
        $self->{'_xcrs'} == ($widt - 2)) ||
       ($self->{'_ycrs'} == ($hite - 2) &&
        $self->{'_xcrs'} == ($widt - 1))){
      $eflg = 1;
    }
  }
  $self->{'_wind'}->resize($hite, $widt);
  $self->{'_wind'}->refresh();
  $self->ShokScrn();
  $self->{'_wind'}->getmaxyx($self->{'_hite'}, $self->{'_widt'});
  $self->Move(-1, -1) if($eflg);
  return($self->{'_hite'}, $self->{'_widt'});
}
sub Updt { # update a Simp object's dimensions (resize && mvwin)
  my $self = shift; my $noch = 0; # No Changes flag
  my($keey, $valu); my $foun;
  while(@_){ # load key/vals like new()
    ($keey, $valu)=(shift, shift); $foun = 0;
    if(defined($valu)){
      for my $attr ($self->AttrNamz()){
        if     ($attr =~ /$keey/i || $_verbose_attrnamz{$attr} eq $keey){ # exact match
          $self->{$attr} = $valu;$foun = 1;}}
      unless($foun){
        if($keey =~ /noch/i){$noch = $valu;}
        else                {#die "!*EROR*! Curses::Simp->Updt key:$keey was not recognized!\n";
#         $keey =~ s/^_*/_/; # auto-add unfound?
#         $self->{$keey} = $valu;
        }}}
    else{$noch = $keey;}}
  my($hite, $widt)=($self->{'_hite'}, $self->{'_widt'});
  my($yoff, $xoff)=($self->{'_yoff'}, $self->{'_xoff'});
  if($curs){
    $self->{'_wind'}->getmaxyx($hite, $widt) unless($noch);
    $self->{'_wind'}->getbegyx($yoff, $xoff) unless($noch);}
  if(length($self->{'_titl'})){
    # if there's a window title, there must be a border to hold it
    $self->{'_btyp'} = 1 unless($self->{'_btyp'});
    # if titl+bord > Widt, trunc titl to Widt - 4 to fit screen
    if(length($self->{'_titl'}) > (getmaxx() - 4)){
      $self->{'_titl'} = substr($self->{'_titl'}, 0, (getmaxx() - 4));}}
  if($self->{'_flagmaxi'}){ # maximize
    if($curs){
      $self->{'_widt'} = getmaxx();
      $self->{'_hite'} = getmaxy();}
    $self->{'_yoff'} = 0;
    $self->{'_xoff'} = 0;
  }else{
    if($self->{'_flagshrk'}){ # shrink to (hite, wider of titl+bord || text)
      if($self->{'_text'} && @{$self->{'_text'}}){
        $self->{'_hite'}  =  @{$self->{'_text'}};
        $self->{'_hite'} +=  2 if($self->{'_btyp'});}
      if($curs){
        $self->{'_hite'} = getmaxy() if($self->{'_hite'} > getmaxy());}
      $self->{'_widt'}  =  1;
      $self->{'_widt'} += (1 + length($self->{'_titl'})) if(length($self->{'_titl'}));
      if($self->{'_text'} && @{$self->{'_text'}}){
        for(@{$self->{'_text'}}){
          $self->{'_widt'}  = length($_) if($self->{'_widt'} < length($_));}
        $self->{'_widt'} += 2 if($self->{'_btyp'});}
      if($curs){
        $self->{'_widt'} = getmaxx() if($self->{'_widt'} > getmaxx());}
    }
    if($self->{'_flagcntr'}){ # set yoff,xoff so window is centered
      if($curs){
        $self->{'_yoff'} = int((getmaxy() - $self->{'_hite'}) / 2);
        $self->{'_xoff'} = int((getmaxx() - $self->{'_widt'}) / 2);}}}
  $self->{'_yoff'} = 0 if($self->{'_yoff'} < 0);
  $self->{'_xoff'} = 0 if($self->{'_xoff'} < 0);
  unless($noch){ # the window has been created so it's ok to change it
    $noch = 1; # reappropriate NoChanges flag to designate whether changed
    if(  $hite != $self->{'_hite'} || $widt != $self->{'_widt'}){
      $self->Rsiz();
#     $self->{'_wind'}->resize($self->{'_hite'}, $self->{'_widt'});
      if($hite >  $self->{'_hite'} || $widt >  $self->{'_widt'}){
        $self->ShokScrn(2);} # Clear/Refresh main screen because window shrank
      $noch = 0;}
    if($yoff != $self->{'_yoff'} || $xoff != $self->{'_xoff'}){
      $self->{'_wind'}->mvwin( $self->{'_yoff'}, $self->{'_xoff'}) if($curs);
      $self->ShokScrn(2); # Clear/Refresh main screen because window moved
      $noch = 0;}}
  return(!$noch);} # return flag telling whether self resized or moved
# Mesg() is a special Curses::Simp object constructor which creates a
#   completely temporary Message window.
# If params are supplied, they must be hash key => value pairs.
sub Mesg{
  my $main = shift; my($keey, $valu); my $char = -1;
  my $self = bless({}, ref($main));
  for my $attr ($self->AttrNamz()){
    $self->{$attr} = $self->DfltValu($attr); # init defaults
  }
  # special Mesg window defaults
  $self->{'_flagmaxi'} = 0; # not maximized
  $self->{'_flagcvis'} = 0; # don't show cursor
  $self->{'_flagclru'} = $main->{'_flagclru'}; # inherit ColorUsed flag
  $self->{'_mesg'} =   '';#EROR!';
  $self->{'_text'} = [ ];
  if($self->{'_flagclru'}){
    $self->{'_fclr'} = [ 'C' ];
    $self->{'_bclr'} = [ 'b' ];
  }
  $self->{'_titl'} =   'Message:';
  $self->{'_ttfc'} =   'G';
  $self->{'_ttbc'} =   'k';
  $self->{'_flagprsk'} = 1;
  $self->{'_pres'} =   'Press A Key...';
  $self->{'_prfc'} =   'Y';
  $self->{'_prbc'} =   'r';
  $self->{'_wait'} =     0;
  $self->{'_type'} =    ''; # type can be set to special message types
                            #   like 'help' or 'info'
  $self->{'_stat'} =     0; # checkbox status
  $self->{'_elmo'} =    ''; # special field to make this Mesg an ELeMent Of
  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; }
  # there were init params with no colon (classname)
  while(@_){
    ($keey, $valu)=(shift, shift);
    if(defined($valu)){
      if($keey =~ /^(mesg|pres|wait|type|stat|elmo|flagprsk)$/){
        $self->{"_$keey"} = $valu;
      }else{
        for my $attr ($self->AttrNamz()){
          $self->{$attr} = $valu if($attr =~ /$keey/i);
        }
      }
    }else{
      $self->{'_mesg'} = $keey;
    }
  }
  unless(@{$self->{'_text'}}){
    @{$self->{'_text'}} = split(/\n/, $self->{'_mesg'});
  }
  if($self->{'_type'}){
    $self->{'_titl'} = '' if($self->{'_titl'} eq 'Message:');
    if     ($self->{'_type'} =~ /^(help|info)$/ && $self->{'_flagclru'}){
      if($self->{'_text'}->[0] =~ /^(\s*)(\w+)(\s+)(v\d+\.)(\d+\s\S{8})(\s*-\s*)((written|hacked|coded|made|crE8d)?\s*by\s*)(.+)$/i){
        my %mtch = ();
        $mtch{'1'} = $1 if(defined($1));
        $mtch{'2'} = $2 if(defined($2));
        $mtch{'3'} = $3 if(defined($3));
        $mtch{'4'} = $4 if(defined($4));
        $mtch{'5'} = $5 if(defined($5));
        $mtch{'6'} = $6 if(defined($6));
        $mtch{'7'} = $7 if(defined($7));
        $mtch{'9'} = $9 if(defined($9));
        $self->{'_fclr'}->[0]  = '';
        $self->{'_bclr'}->[0]  = '';
        $self->{'_fclr'}->[0] .= ' ' x length($mtch{'1'}) if(exists($mtch{'1'}));
        $self->{'_bclr'}->[0] .= 'b' x length($mtch{'1'}) if(exists($mtch{'1'}));
        $self->{'_fclr'}->[0] .= 'G' x length($mtch{'2'});
        $self->{'_bclr'}->[0] .= 'b' x length($mtch{'2'});
        $self->{'_fclr'}->[0] .= ' ' x length($mtch{'3'});
        $self->{'_bclr'}->[0] .= 'b' x length($mtch{'3'});
        $self->{'_fclr'}->[0] .= 'W' . 'Y' x (length($mtch{'4'}) - 2) . 'W';
        $self->{'_bclr'}->[0] .= 'b' . 'b' x (length($mtch{'4'}) - 2) . 'b';
        $self->{'_fclr'}->[0] .=       'C' x (length($mtch{'5'}) - 9) . 'W';
        $self->{'_bclr'}->[0] .=       'b' x (length($mtch{'5'}) - 9) . 'b';
        $self->{'_fclr'}->[0] .= 'ROYGCBMP'; # was originally Time::PT::ptcc() before becoming a new d8 stamp
        $self->{'_bclr'}->[0] .= 'bbbbbbbb';
        $self->{'_fclr'}->[0] .= 'B' x length($mtch{'6'});
        $self->{'_bclr'}->[0] .= 'b' x length($mtch{'6'});
        $self->{'_fclr'}->[0] .= 'W' x length($mtch{'7'});
        $self->{'_bclr'}->[0] .= 'b' x length($mtch{'7'});
        if    ($mtch{'9'} =~ /^([^<]+)<([^@]+)@([^.]+)\.([^>]+)>/){
          $mtch{'91'} = $1;
          $mtch{'92'} = $2;
          $mtch{'93'} = $3;
          $mtch{'94'} = $4;
          $self->{'_fclr'}->[0] .= 'C' x length($mtch{'91'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'91'}) . 'b';
          $self->{'_fclr'}->[0] .= 'G' x length($mtch{'92'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'92'}) . 'b';
          $self->{'_fclr'}->[0] .= 'Y' x length($mtch{'93'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'93'}) . 'b';
          $self->{'_fclr'}->[0] .= 'C' x length($mtch{'94'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'94'}) . 'b';
        }elsif($mtch{'9'} =~ /^([^@]+)@([^.]+)\.(\S+)/){
          $mtch{'91'} = $1;
          $mtch{'92'} = $2;
          $mtch{'93'} = $3;
          $self->{'_fclr'}->[0] .= 'G' x length($mtch{'91'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'91'}) . 'b';
          $self->{'_fclr'}->[0] .= 'Y' x length($mtch{'92'}) . 'W';
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'92'}) . 'b';
          $self->{'_fclr'}->[0] .= 'C' x length($mtch{'93'});
          $self->{'_bclr'}->[0] .= 'b' x length($mtch{'93'});
        }
        if    ($self->{'_type'} eq 'help'){
          $self->{'_titl'} = "$mtch{'2'} Help Text:" unless($self->{'_titl'});
          $self->{'_fclr'}->[1]  = 'W';
          $self->{'_bclr'}->[1]  = 'b';
          $self->{'_text'}->[1]  = ' ' unless(length($self->{'_text'}->[1]));
        }elsif($self->{'_type'} eq 'info'){
          $self->{'_titl'} = "$mtch{'2'} Info Text:" unless($self->{'_titl'});
          $self->{'_fclr'}->[1]  = 'C';
          $self->{'_bclr'}->[1]  = 'b';
          $self->{'_text'}->[1]  = ' ' unless(length($self->{'_text'}->[1]));
        }
        if($self->{'_titl'}){
          $self->{'_btyp'} = 1 unless($self->{'_btyp'});}
      }
    }elsif($self->{'_type'} =~ /^(butn|ckbx)$/){
      $self->{'_flagprsk'} = 0;
      $self->{'_flagcntr'} = 0;
      $self->{'_flagsdlk'} = 1;
      if    ($self->{'_type'} eq 'butn'){
        my $widt = 3;
        if($self->{'_titl'}){
          $self->{'_btyp'} = 1 unless($self->{'_btyp'});
        }else{
          for(@{$self->{'_text'}}){
            $widt = (length($_) + 2) if($widt < (length($_) + 2));
          }
          $self->{'_widt'} = $widt unless($self->{'_widt'});
        }
      }elsif($self->{'_type'} eq 'ckbx'){
        my $ndnt;
        $self->{'_onbx'} = '[X] - ' unless(exists($self->{'_onbx'}));
        unless(exists($self->{'_ofbx'})){
          $self->{'_ofbx'} = $self->{'_onbx'};
          $self->{'_ofbx'} =~ s/^(.)./$1 /;
        }
        $ndnt = ' ' x length($self->{'_ofbx'});
        for(@{$self->{'_text'}}){
          $_ =~ s/^/$ndnt/;
        }
        if($self->{'_stat'}){
          $self->{'_text'}->[0] =~ s/^$ndnt/$self->{'_onbx'}/;
        }else{
          $self->{'_text'}->[0] =~ s/^$ndnt/$self->{'_ofbx'}/;
        }
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[0] = 'c';
          $self->{'_bclr'}->[0] = 'k';
        }
      }
    }
  }
  if($self->{'_flagprsk'}){
    if(length($self->{'_pres'})){
      if($self->{'_flagclru'}){
        $self->{'_fclr'}->[@{$self->{'_text'}}] = $self->{'_prfc'};
        $self->{'_bclr'}->[@{$self->{'_text'}}] = $self->{'_prbc'};
      }
      my $wdst = 0;
      $wdst = length($self->{'_titl'}) + 2;
      if(@{$self->{'_text'}}){ # center press string
        for(@{$self->{'_text'}}){
          $wdst = length($_) if($wdst < length($_));
        }
      }
      if($wdst > length($self->{'_pres'})){
        $self->{'_pres'} = ' ' x int(($wdst - length($self->{'_pres'})) / 2) . $self->{'_pres'};
      }
      push(@{$self->{'_text'}}, $self->{'_pres'});
    }
  }
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'});
  $self->Updt(1);
  $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'},
                            $self->{'_yoff'}, $self->{'_xoff'});
# unless(exists($self->{'_wind'}) && defined($self->{'_wind'})){
#   die "!*EROR*! Curses::Simp::Mesg could not create new window with hite:$self->{'_hite'}, widt:$self->{'_widt'}, yoff:$self->{'_yoff'}, xoff:$self->{'_xoff'}!\n";}
  $self->FlagCVis(); # set cursor visibility to new object state
  $self->TestDraw();
  if    ($self->{'_flagprsk'}){
    if($self->{'_wait'}) { $char = $self->GetK($self->{'_wait'}); }
    else                 { $char = $self->GetK(-1); }
    $char = '#' . $char if($self->{'_kmod'}->{'KMOD_SHIFT'});
    $char = '^' . $char if($self->{'_kmod'}->{'KMOD_CTRL' });
    $char = '@' . $char if($self->{'_kmod'}->{'KMOD_ALT'  });
  }elsif($self->{'_wait'}){
    $self->Wait($self->{'_wait'});
  }
  $self->{'_dndx'} = @DISPSTAK; # add object to display order stack
  push(@DISPSTAK, \$self);
  if($self->{'_type'} =~ /^(butn|ckbx)$/){
    return($self); # special types Button && CheckBox persist
  }else{
    $self->DelW();
    $main->ShokScrn(2);# redraw rest
    $main->FlagCVis(); # reset  cursor visibility to calling object state
    return($char);     # return character pressed to dismiss Mesg (if any)
  }
}
# Prmt() is a special Curses::Simp object constructor which creates a
#   completely temporary Prompt window.
# If params are supplied, they must be hash key => value pairs.
sub Prmt{
  my $main = shift; my($keey, $valu); my $char; my $tchr; my $data;
  my $self = bless({}, ref($main));   my $twid; my $indx;
  for my $attr ($self->AttrNamz()){
    $self->{$attr} = $self->DfltValu($attr); # init defaults
  }
  # special Prmt window defaults
  $self->{'_flagsdlk'} = 1;         # get SDLKeys
  $self->{'_flagmaxi'} = 0;         # not maximized
  $self->{'_flagcvis'} = 1;         # show cursor
  $self->{'_flagedit'} = 1;         # editable
  $self->{'_flagescx'} = 0;         # Escape key eXits
  $self->{'_flagclru'} = $main->{'_flagclru'}; # inherit ColorUsed flag
  $self->{'_widt'} = getmaxx() - 4; # but almost full screen wide
  $self->{'_hite'} = 3;             #   && start 1 text line high
#  $self->{'_dref'} = \$data;        # default text data ref !exist at start
  $self->{'_dtxt'} =   '';
  $self->{'_text'} = [ ];
  $self->{'_dtfc'} =   'G';
  $self->{'_dtbc'} =   'b';
  if($self->{'_flagclru'}){
    $self->{'_fclr'} = [ $self->{'_dtfc'} ];
    $self->{'_bclr'} = [ $self->{'_dtbc'} ];
  }
  $self->{'_titl'} =   'Enter Text:';
  $self->{'_ttfc'} =   'C';
  $self->{'_ttbc'} =   'k';
  $self->{'_hifc'} =   'W';
  $self->{'_hibc'} =   'g';
  $self->{'_curs'} =       0; # special prompt cursor index
  $self->{'_sscr'} =       0; # special prompt side-scrolling index
  $self->{'_type'} =  'prmt'; # type can be set to special prompt types
                              #   like 'drop', 'cbls', or 'rdls'
  $self->{'_lndx'} =       0; # special line index for drop down types
  $self->{'_elmo'} =      ''; # special field to make this Prmt an ELeMent Of
  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; }
  # there were init params with no colon (classname)
  while(@_){
    ($keey, $valu)=(shift, shift);
    if(defined($valu)) {
      if($keey =~ /^(dref|dtxt|type|lndx|elmo|flagedit|flagescx)$/){
        $self->{"_$keey"} = $valu;
      }else{
        for my $attr ($self->AttrNamz()){
          $self->{$attr} = $valu if($attr =~ /$keey/i);
        }
      }
    }else{
      $self->{'_dref'} = $keey;
    }
  }
  if    (exists($self->{'_dref'})){
    $self->{'_dtxt'} = ${$self->{'_dref'}};
  }elsif(exists($self->{'_text'}) && @{$self->{'_text'}}){
    $self->{'_dtxt'} = $self->{'_text'}->[0];
    if($self->{'_flagclru'}){
      for($indx = 1; $indx < @{$self->{'_text'}}; $indx++){
        $self->{'_fclr'}->[$indx] = $self->{'_dtfc'} unless($self->{'_fclr'}->[$indx]);
        $self->{'_bclr'}->[$indx] = $self->{'_dtbc'} unless($self->{'_bclr'}->[$indx]);
      }
    }
  }
  $self->{'_data'}     = $self->{'_dtxt'};
  if($self->{'_type'} eq 'drop'){
    $self->{'_flagdrop'} = 1;
    $self->{'_flagdown'} = 0;
    $self->{'_flagcntr'} = 0;
    $self->{'_lndx'}     = 0 unless($self->{'_lndx'});
    $self->{'_hite'}     = 3;
    if($self->{'_widt'} == (getmaxx() - 4) && @{$self->{'_text'}}){
      $self->{'_widt'}   = 3;
      for(@{$self->{'_text'}}){
        $self->{'_widt'} = (length($_) + 6) if($self->{'_widt'} < (length($_) + 6));
      }
      $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'}];
      $self->{'_data'} = $self->{'_dtxt'};
    }
    unshift(@{$self->{'_text'}}, $self->{'_data'});
  }else{
    $self->{'_text'}->[0] = $self->{'_data'} unless(@{$self->{'_text'}});
  }
  $self->{'_curs'} = length($self->{'_data'});
  if($self->{'_widt'} < length($self->{'_titl'}) + 4){
     $self->{'_widt'} = length($self->{'_titl'}) + 4;
  }
  $twid = $self->{'_widt'} - 2;
  unless($self->{'_curs'} <= $twid){ # scrolling necessary off to the left
    substr($self->{'_text'}->[0], 0,  $twid, substr($self->{'_data'}, -$twid, $twid));
  }
  if($self->{'_flagclru'}){
    $self->{'_fclr'}->[0] = $self->{'_hifc'} if($self->{'_curs'});
    $self->{'_bclr'}->[0] = $self->{'_hibc'} if($self->{'_curs'});
  }
  $self->{'_ycrs'} = 0;
  $self->{'_xcrs'} = $self->{'_curs'};
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'});
  $self->Updt(1);
  $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'},
                            $self->{'_yoff'}, $self->{'_xoff'});
# unless(exists($self->{'_wind'}) && defined($self->{'_wind'})){
#   die "!*EROR*! Curses::Simp->Prmt could not create new window with hite:$self->{'_hite'}, widt:$self->{'_widt'}, yoff:$self->{'_yoff'}, xoff:$self->{'_xoff'}!\n";}
  $self->FlagCVis(); # set cursor visibility to new object state
  $self->TestDraw();
  $self->{'_dndx'} = @DISPSTAK; # add object to display order stack
  push(@DISPSTAK, \$self);
  if($self->{'_type'} =~ /^(drop)$/){
    return($self); # $self must be given explicit focus via Focu()
  }else{
    $self->Focu(); # give Prompt focus (to handle GetK loops)
    ${$self->{'_dref'}} = $self->{'_data'} if(exists($self->{'_dref'}));
    $data = $self->{'_data'};
    $self->DelW();
    $main->ShokScrn(2);# redraw rest
    $main->FlagCVis(); # reset  cursor visibility to calling object state
    return($data);     # return updated text data
  }
}
# Focu() is a Curses::Simp method which give focus to special
#   typed objects like CheckBoxes or DropDownMenus.
# Maybe later, it will change the border type / color of normal
#   pKGnAME object windows as they gain focus.
sub Focu{
  my $self = shift; return() unless(exists($self->{'_type'}));
  my $updt = shift || 0; my $char = -1; my $tchr;
  unless($updt) {
    if     ($self->{'_type'} eq 'ckbx') {
      $self->Draw('fclr' => [ 'C' ]) if($self->{'_flagclru'});
      $char = $self->GetK(-1);
      $self->Draw('fclr' => [ 'c' ]) if($self->{'_flagclru'});
      if($char =~ /^SDLK_(SPACE)$/) {        # checkbox toggle keys
        $self->{'_stat'} ^= 1;               # any other key loses focus
        $updt = 1;                           #   leaving ckbx state same
      }
    } elsif($self->{'_type'} =~ /^(prmt|drop)$/) { # big Prmt (drop)? focus
      my $cmov; my $done = 0;                      #   input handler
      $self->FlagCVis(1);
      while(!$done) {
        $char = $self->GetK(-1);
        $tchr =  $char;
        $tchr =~ s/SDLK_//;
        $done = 1 if($tchr eq 'RETURN');
        if($self->{'_elmo'} eq 'brws' && $self->{'_flagdrop'} &&
           (($tchr eq 'F1') ||
            ($tchr =~ /^[bcfhu]$/ && $self->{'_kmod'}->{'KMOD_CTRL'}) ||
            ($tchr =~ /^(ESCAPE|SPACE|TILDE|BACKQUOTE)$/ &&  $self->{'_flagdown'}) ||
            ($tchr =~ /^(UP|DOWN|LEFT|RIGHT|j|k)$/       && !$self->{'_flagdown'}) ||
             $tchr =~ /^(TAB)$/)) {
          if($self->{'_flagdrop'} && !$self->{'_flagdown'}) {
            $self->{'_dtxt'} = $self->{'_data'};
            if($self->{'_flagclru'}) {
              $self->{'_fclr'}->[$self->{'_lndx'}] = $self->{'_hifc'};
              $self->{'_bclr'}->[$self->{'_lndx'}] = $self->{'_hibc'};
            }
          }
          $self->{'_echg'} = 1;
          $done = 1;
        }elsif($tchr eq 'TAB'){
          $tchr = '  ';
        }
        $tchr = uc($tchr) if($self->{'_kmod'}->{'KMOD_SHIFT'});
        if($self->{'_flagdrop'} && $self->{'_flagdown'}){ # DropIsDown
          if($char ne 'SDLK_TAB'){
            if     ($tchr =~ /^(RETURN|ESCAPE|SPACE|TILDE|BACKQUOTE)$/) {
              $self->{'_flagdown'} = 0; # Close Drop down
              $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'}];
              $self->{'_data'} = $self->{'_dtxt'};
              unshift(@{$self->{'_text'}}, $self->{'_data'});
              $self->{'_hite'} = 3;
              if($self->{'_flagclru'}){
                $self->{'_fclr'}->[$self->{'_lndx'}] = $self->{'_dtfc'};
                $self->{'_bclr'}->[$self->{'_lndx'}] = $self->{'_dtbc'};
                $self->{'_fclr'}->[0]                = $self->{'_hifc'};
                $self->{'_bclr'}->[0]                = $self->{'_hibc'};
              }
              $char = -1 if($tchr eq 'RETURN');
              $self->{'_echg'} = 1 if($self->{'_elmo'} eq 'brws');
            }elsif($tchr =~ /^(UP|LEFT|k)$/){
              if($self->{'_lndx'}) {
                $self->{'_lndx'}--;
                $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'}    ];
                $self->{'_data'} = $self->{'_dtxt'};
                if($self->{'_flagclru'}){
                  $self->{'_fclr'}->[$self->{'_lndx'} + 1] = $self->{'_dtfc'};
                  $self->{'_bclr'}->[$self->{'_lndx'} + 1] = $self->{'_dtbc'};
                  $self->{'_fclr'}->[$self->{'_lndx'}    ] = $self->{'_hifc'};
                  $self->{'_bclr'}->[$self->{'_lndx'}    ] = $self->{'_hibc'};
                }
                $self->{'_curs'} = length($self->{'_data'});
                $self->{'_echg'} = 1 if($self->{'_elmo'} eq 'brws');
              }
            }elsif($tchr =~ /^(DOWN|RIGHT|j)$/){
              if($self->{'_lndx'} < (@{$self->{'_text'}} - 1)){
                $self->{'_lndx'}++;
                $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'}    ];
                $self->{'_data'} = $self->{'_dtxt'};
                if($self->{'_flagclru'}){
                  $self->{'_fclr'}->[$self->{'_lndx'} - 1] = $self->{'_dtfc'};
                  $self->{'_bclr'}->[$self->{'_lndx'} - 1] = $self->{'_dtbc'};
                  $self->{'_fclr'}->[$self->{'_lndx'}    ] = $self->{'_hifc'};
                  $self->{'_bclr'}->[$self->{'_lndx'}    ] = $self->{'_hibc'};
                }
                $self->{'_curs'} = length($self->{'_data'});
                $self->{'_echg'} = 1 if($self->{'_elmo'} eq 'brws');
              }
            }
            $self->{'_xcrs'} = $self->{'_curs'};
            $self->{'_ycrs'} = $self->{'_lndx'};
            $self->Draw();
          }
        }elsif(  $char ne 'SDLK_RETURN' && (!$self->{'_flagdrop'}       ||
                                           ( $self->{'_elmo'} eq 'brws' &&
                 $char ne 'SDLK_TAB'    &&   $self->{'_flagdrop'}       &&
                ($char !~ /^SDLK_[bcfhu]$/ || !$self->{'_kmod'}->{'KMOD_CTRL'})))){
          $cmov = 0; # mostly regular Prmt stuff
          if     (  $self->{'_flagdrop'} && ($tchr =~ /^(TILDE|BACKQUOTE)$/ ||
                  ( $tchr eq 'SPACE' && (!$self->{'_flagclru'} ||
                   ($self->{'_fclr'}->[0] eq $self->{'_hifc'} &&
                    $self->{'_bclr'}->[0] eq $self->{'_hibc'}))))){
            $self->{'_flagdown'} = 1; # drop Down
            shift(@{$self->{'_text'}});
            $self->{'_hite'} = @{$self->{'_text'}} + 2;
            $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'}];
            $self->{'_data'} = $self->{'_dtxt'};
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[0] = $self->{'_dtfc'};
              $self->{'_bclr'}->[0] = $self->{'_dtbc'};
            }
            $self->{'_curs'} = length($self->{'_data'});
            $self->{'_sscr'} = 0;
          }elsif($tchr eq 'UP'  ){
            if($self->{'_flagdrop'} && !$self->{'_flagdown'}) {
              if($self->{'_lndx'}) {
                $self->{'_lndx'}--;
                $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'} + 1];
                $self->{'_data'} = $self->{'_dtxt'};
                $self->{'_text'}->[0] = $self->{'_data'};
                if($self->{'_flagclru'}){
                  $self->{'_fclr'}->[0] = $self->{'_hifc'};
                  $self->{'_bclr'}->[0] = $self->{'_hibc'};
                }
                $self->{'_curs'} = length($self->{'_data'});
                $self->{'_echg'} = 1 if($self->{'_elmo'} eq 'brws');
              }
            }elsif($self->{'_flagedit'} && $self->{'_curs'}){ # uppercase
              my $temp = substr($self->{'_data'}, $self->{'_curs'}, 1);
                         substr($self->{'_data'}, $self->{'_curs'}, 1, uc($temp));
            }
          }elsif($tchr eq 'DOWN'){
            if($self->{'_flagdrop'} && !$self->{'_flagdown'}){
              if($self->{'_lndx'} < (@{$self->{'_text'}} - 2)){
                $self->{'_lndx'}++;
                $self->{'_dtxt'} = $self->{'_text'}->[$self->{'_lndx'} + 1];
                $self->{'_data'} = $self->{'_dtxt'};
                $self->{'_text'}->[0] = $self->{'_data'};
                if($self->{'_flagclru'}){
                  $self->{'_fclr'}->[0] = $self->{'_hifc'};
                  $self->{'_bclr'}->[0] = $self->{'_hibc'};
                }
                $self->{'_curs'} = length($self->{'_data'});
                $self->{'_echg'} = 1 if($self->{'_elmo'} eq 'brws');
              }
            }elsif($self->{'_flagedit'} && $self->{'_curs'}){ # lowercase
              my $temp = substr($self->{'_data'}, $self->{'_curs'}, 1);
                         substr($self->{'_data'}, $self->{'_curs'}, 1, lc($temp));
            }
          }elsif($self->{'_flagedit'}){
            if    ($tchr eq 'LEFT' ) { # move cursor left
              if($self->{'_curs'}) {
                $self->{'_curs'}--;
                $self->{'_sscr'}-- if($self->{'_sscr'});
              }
              $cmov = 1;
            }elsif($tchr eq 'RIGHT'){ # move cursor right
              if($self->{'_curs'} < length($self->{'_data'})){
                $self->{'_curs'}++;
              }
              $cmov = 1;
            }elsif($tchr eq 'HOME' ){ # move cursor to beginning
              $self->{'_curs'} = 0;
              $self->{'_sscr'} = 0 if($self->{'_sscr'});
              $cmov = 1;
            }elsif($tchr eq 'END'  ){ # move cursor to end
              $self->{'_curs'} = length($self->{'_data'});
              if(length($self->{'_data'}) < $self->{'_widt'} - 2){
                $self->{'_sscr'} = (length($self->{'_data'}) - $self->{'_widt'} - 2);
              }
              $cmov = 1;
            }elsif($tchr eq 'INSERT'){
              $self->FlagInsr('togl');
              if($self->FlagInsr){ $self->{'_titl'} =~ s/\[O\]$//; }
              else               { $self->{'_titl'} .= '[O]';
                unless($self->Widt() > length($self->Titl()) + 4){
                  $self->Widt(length($self->Titl()) + 4);
                  $self->Draw(); # was $main
                }
              }
            }elsif($tchr eq 'BACKSPACE' || ord($tchr) == 127){
              if($self->{'_curs'}){
                substr($self->{'_data'}, --$self->{'_curs'}, 1, '');
                $self->{'_sscr'}-- if($self->{'_sscr'});
              }
            }elsif($tchr eq 'DELETE'){
              if($self->{'_curs'} < length($self->{'_data'})) {
                substr($self->{'_data'},   $self->{'_curs'}, 1, '');
                $self->{'_sscr'}-- if($self->{'_sscr'});
              }
            }elsif($tchr eq 'ESCAPE'){
              if($self->{'_flagescx'}){
                $self->{'_data'} = '';
                $self->{'_curs'} = 0;
              }else{
                if($self->{'_flagclru'}){
                  $self->{'_fclr'}->[0] = $self->{'_hifc'};
                  $self->{'_bclr'}->[0] = $self->{'_hibc'};
                }
                $self->{'_data'} = $self->{'_dtxt'};
                $self->{'_curs'} = length($self->{'_data'});
                $self->{'_sscr'} = 0;
              }
            }else{
              for(keys(%SDLKCHRM)){
                $tchr = $_ if($tchr eq $SDLKCHRM{$_});
              }
              if($tchr ne 'F1'){
                if($self->{'_flagclru'} &&
                   $self->{'_fclr'}->[0] eq $self->{'_hifc'} &&
                   $self->{'_bclr'}->[0] eq $self->{'_hibc'}){
                  $self->{'_data'} = $tchr;
                  $self->{'_curs'} = length($self->{'_data'});
                }else{
                  if    ($self->{'_curs'} == length($self->{'_data'})){
                    $self->{'_data'} .= $tchr;
                  }elsif($self->FlagInsr()){
                    substr($self->{'_data'}, $self->{'_curs'},            0,$tchr);
                  }else{
                    substr($self->{'_data'}, $self->{'_curs'},length($tchr),$tchr);
                  }
                  $self->{'_curs'} += length($tchr);
                }
              }
            }
            while((($self->{'_curs'} - $self->{'_sscr'}) >= ($self->{'_widt'} - 2)) ||
                  (($self->{'_curs'} - $self->{'_sscr'}) >= ($self->{'_widt'} - 5) && $self->{'_flagdrop'} && !$self->{'_flagdown'})){
              $self->{'_sscr'}++;
            }
            if( $self->{'_flagclru'} &&
                $self->{'_fclr'}->[0] eq $self->{'_hifc'} &&
                $self->{'_bclr'}->[0] eq $self->{'_hibc'} &&
               ($self->{'_data'}      ne $self->{'_dtxt'} || $cmov)){
              $self->{'_fclr'}->[0] = $self->{'_dtfc'};
              $self->{'_bclr'}->[0] = $self->{'_dtbc'};
            }
          }else{ # test !editable keys to jump in drop etc.
          }
          if($self->{'_flagdrop'} && $self->{'_flagdown'}){
            $self->{'_xcrs'} = $self->{'_curs'};
            $self->{'_ycrs'} = $self->{'_lndx'};
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[$self->{'_lndx'}] = $self->{'_hifc'};
              $self->{'_bclr'}->[$self->{'_lndx'}] = $self->{'_hibc'};
            }
          }else{
            $self->{'_xcrs'} = ($self->{'_curs'} - $self->{'_sscr'});
            $self->{'_text'}->[0] = $self->{'_data'};
            if($self->{'_sscr'}){
              substr($self->{'_text'}->[0], 0, $self->{'_sscr'} + 3, '...');
            }
          }
          $self->Draw();
        }
      }
    }
  }
  if($updt){
    if     ($self->{'_type'} eq 'ckbx'){
      if($self->{'_stat'}) {
        substr($self->{'_text'}->[0], 0, length($self->{'_ofbx'}), '');
        $self->{'_text'}->[0] =~ s/^/$self->{'_onbx'}/;
      }else{
        substr($self->{'_text'}->[0], 0, length($self->{'_onbx'}), '');
        $self->{'_text'}->[0] =~ s/^/$self->{'_ofbx'}/;
      }
    }
    $self->Draw();
  }
  return($char);
}
sub BildBlox{ # a sub used by CPik to construct color blocks in @text,@[fb]clr
  my $self = shift;
  @{$self->{'_text'}} = ( );
  if($self->{'_flagclru'}) {
    @{$self->{'_fclr'}} = ( );
    @{$self->{'_bclr'}} = ( );
  }
  if    ($self->{'_styl'} eq 'barz'){
    if($self->{'_flagbakg'}){
      for(my $cndx = 0; $cndx < @telc; $cndx++) {
        push(@{$self->{'_text'}},  ' ' . hex($cndx) . ' ' .
               $telc[$cndx] . ' ' . $self->{'_bchr'} x 63);
        if($self->{'_flagclru'}){
          if($cndx == $self->{'_hndx'}){
            push(@{$self->{'_fclr'}}, 'kKkk' . ' ' .  $telc[$cndx] x 63);
            push(@{$self->{'_bclr'}}, 'wwww' . ' ' .  $telc[$cndx] x 63);
          }else{
            push(@{$self->{'_fclr'}}, 'kk'   . ' ' .  $telc[$cndx] x 63);
            push(@{$self->{'_bclr'}}, 'wW'   . ' ' .  $telc[$cndx] x 63);
          }
        }
      }
    }
    if($self->{'_flagforg'}){
      for(my $cndx = 0; $cndx < @telc; $cndx++) {
        if(hex($cndx+@telc) eq 'B' || hex($cndx+@telc) eq 'C'){
          push(@{$self->{'_text'}},  ' ' . '!' . ' ' .
                 uc($telc[$cndx]) .  ' ' . $self->{'_bchr'} x 63);
        }else{
          push(@{$self->{'_text'}},  ' ' . hex($cndx+@telc) . ' ' .
                 uc($telc[$cndx]) .  ' ' . $self->{'_bchr'} x 63);
        }
        if($self->{'_flagclru'}){
          if($cndx == ($self->{'_hndx'} - 8)){
            push(@{$self->{'_fclr'}}, 'kKkk' . ' ' .  uc($telc[$cndx]) x 63);
            push(@{$self->{'_bclr'}}, 'wwww' . ' ' .  uc($telc[$cndx]) x 63);
          }else{
            push(@{$self->{'_fclr'}}, 'kk'   . ' ' .  uc($telc[$cndx]) x 63);
            push(@{$self->{'_bclr'}}, 'wW'   . ' ' .  uc($telc[$cndx]) x 63);
          }
        }
      }
    }
    $self->Move($self->{'_hndx'}, 0);
  }elsif($self->{'_styl'} eq 'blox'){
    if($self->{'_flagbakg'}){
      for(my $rowe = 0; $rowe < 7; $rowe++) {
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=0;$cndx<@telc;$cndx++){
          if     ($rowe < 5){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 8;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= $telc[$cndx]     x 8;
              $self->{'_bclr'}->[-1] .= 'b'              x 8;
            }
          }elsif($rowe < 6){
            $self->{'_text'}->[-1] .= '  ' . hex($cndx) .
                                      '  ' . $telc[$cndx] . '  ';
            if($self->{'_flagclru'}){
              if($cndx == $self->{'_hndx'}){
                $self->{'_fclr'}->[-1] .= 'kkKkkkkk';
                $self->{'_bclr'}->[-1] .= 'wwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= ' w  ';
                $self->{'_bclr'}->[-1] .= '  W ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
    }
    if($self->{'_flagforg'}){
      for(my $rowe = 0; $rowe < 7; $rowe++){
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=0;$cndx<@telc;$cndx++){
          if     ($rowe < 5){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 8;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= uc($telc[$cndx]) x 8;
              $self->{'_bclr'}->[-1] .= 'k'              x 8;
            }
          }elsif($rowe < 6){
            if(hex($cndx+@telc) eq 'B' || hex($cndx+@telc) eq 'C'){
              $self->{'_text'}->[-1] .= '  ' . '!' .
                                        '  ' . uc($telc[$cndx]) . '  ';
            }else{
              $self->{'_text'}->[-1] .= '  ' . hex($cndx+@telc) .
                                        '  ' . uc($telc[$cndx]) . '  ';
            }
            if($self->{'_flagclru'}){
              if($cndx == ($self->{'_hndx'} - 8)) {
                $self->{'_fclr'}->[-1] .= 'bbBbbbbb';
                $self->{'_bclr'}->[-1] .= 'wwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= ' w  ';
                $self->{'_bclr'}->[-1] .= '  W ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
    }
    if($self->{'_hndx'} < 8){
      $self->Move( 5, (( $self->{'_hndx'}      * 8) + 2));
    }else{
      $self->Move(12, ((($self->{'_hndx'} - 8) * 8) + 2));
    }
  }elsif($self->{'_styl'} eq 'squr'){
    if($self->{'_flagbakg'}){
      for(my $rowe=0;$rowe<5;$rowe++){
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=0;$cndx<int(@telc/2);$cndx++){
          if    ($rowe < 3){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 16;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= $telc[$cndx]     x 16;
              $self->{'_bclr'}->[-1] .= 'k'              x 16;
            }
          }elsif($rowe < 4){
            $self->{'_text'}->[-1] .= '     ' . hex($cndx) .
                                      '    '  . $telc[$cndx] . '     ';
            if($self->{'_flagclru'}){
              if($cndx == $self->{'_hndx'}){
                $self->{'_fclr'}->[-1] .= 'kkkkkKkkkkkkkkkk';
                $self->{'_bclr'}->[-1] .= 'wwwwwwwwwwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= '     W  ';
                $self->{'_bclr'}->[-1] .= '  w     ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
      for(my $rowe=0;$rowe<5;$rowe++){
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=int(@telc/2);$cndx<@telc;$cndx++){
          if    ($rowe < 3){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 16;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= $telc[$cndx]     x 16;
              $self->{'_bclr'}->[-1] .= 'k'              x 16;
            }
          }elsif($rowe < 4){
            $self->{'_text'}->[-1] .= '     ' . hex($cndx) .
                                      '    '  . $telc[$cndx] . '     ';
            if($self->{'_flagclru'}){
              if($cndx == $self->{'_hndx'}){
                $self->{'_fclr'}->[-1] .= 'kkkkkKkkkkkkkkkk';
                $self->{'_bclr'}->[-1] .= 'wwwwwwwwwwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= '     W  ';
                $self->{'_bclr'}->[-1] .= '  w     ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
    }
    if($self->{'_flagforg'}){
      for(my $rowe=0;$rowe<5;$rowe++){
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=0;$cndx<int(@telc/2);$cndx++){
          if    ($rowe < 3){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 16;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= uc($telc[$cndx]) x 16;
              $self->{'_bclr'}->[-1] .= 'k'              x 16;
            }
          }elsif($rowe < 4){
            if(hex($cndx+@telc) eq 'B' || hex($cndx+@telc) eq 'C'){
              $self->{'_text'}->[-1] .= '     ' . '!' .
                                        '    '  . uc($telc[$cndx]) . '     ';
            }else{
              $self->{'_text'}->[-1] .= '     ' . hex($cndx+@telc) .
                                        '    '  . uc($telc[$cndx]) . '     ';
            }
            if($self->{'_flagclru'}){
              if($cndx == ($self->{'_hndx'} - 8)){
                $self->{'_fclr'}->[-1] .= 'kkkkkKkkkkkkkkkk';
                $self->{'_bclr'}->[-1] .= 'wwwwwwwwwwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= '     W  ';
                $self->{'_bclr'}->[-1] .= '  w     ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
      for(my $rowe=0;$rowe<5;$rowe++){
        push(@{$self->{'_text'}}, '  ');
        if($self->{'_flagclru'}){
          push(@{$self->{'_fclr'}}, '  ');
          push(@{$self->{'_bclr'}}, '  ');
        }
        for(my $cndx=int(@telc/2);$cndx<@telc;$cndx++){
          if    ($rowe < 3){
            $self->{'_text'}->[-1] .= $self->{'_bchr'} x 16;
            if($self->{'_flagclru'}){
              $self->{'_fclr'}->[-1] .= uc($telc[$cndx]) x 16;
              $self->{'_bclr'}->[-1] .= 'k'              x 16;
            }
          }elsif($rowe < 4){
            if(hex($cndx+@telc) eq 'B' || hex($cndx+@telc) eq 'C'){
              $self->{'_text'}->[-1] .= '     ' . '!' .
                                        '    '  . uc($telc[$cndx]) . '     ';
            }else{
              $self->{'_text'}->[-1] .= '     ' . hex($cndx+@telc) .
                                        '    '  . uc($telc[$cndx]) . '     ';
            }
            if($self->{'_flagclru'}){
              if($cndx == ($self->{'_hndx'} - 8)){
                $self->{'_fclr'}->[-1] .= 'kkkkkKkkkkkkkkkk';
                $self->{'_bclr'}->[-1] .= 'wwwwwwwwwwwwwwww';
              }else{
                $self->{'_fclr'}->[-1] .= '     W  ';
                $self->{'_bclr'}->[-1] .= '  w     ';
              }
            }
          }
        }
        $self->{'_text'}->[-1] .= ' ';
        if($self->{'_flagclru'}){
          $self->{'_fclr'}->[-1] .= ' ';
          $self->{'_bclr'}->[-1] .= ' ';
        }
      }
    }
    if    ($self->{'_hndx'} <  4){
      $self->Move( 3, (( $self->{'_hndx'}       * 16) + 2));
    }elsif($self->{'_hndx'} <  8){
      $self->Move( 8, ((($self->{'_hndx'} -  4) * 16) + 2));
    }elsif($self->{'_hndx'} < 12){
      $self->Move(13, ((($self->{'_hndx'} -  8) * 16) + 2));
    }else{
      $self->Move(18, ((($self->{'_hndx'} - 12) * 16) + 2));
    }
  }
  if($self->{'_flagprsk'}){
    if(length($self->{'_pres'})){
      if($self->{'_flagclru'}){
        $self->{'_fclr'}->[@{$self->{'_text'}}] = $self->{'_prfc'};
        $self->{'_bclr'}->[@{$self->{'_text'}}] = $self->{'_prbc'};
      }
      my $wdst = 0;
      $wdst = length($self->{'_titl'}) + 4;
      if(@{$self->{'_text'}}){ # center press string
        for(@{$self->{'_text'}}){
          $wdst = length($_) if($wdst < length($_));
        }
      }
      if($wdst > length($self->{'_pres'})){
        $self->{'_pres'} = ' ' x int(($wdst - length($self->{'_pres'}) + 1) / 2) . $self->{'_pres'} . ' ' x int(($wdst - length($self->{'_pres'}) + 1) / 2);
      }
      push(@{$self->{'_text'}}, $self->{'_pres'});
    }
  }
  $self->Draw();
  return();
}
# CPik() is a special Curses::Simp object constructor which creates a
#   Color Pick window.
# If params are supplied, they must be hash key => value pairs.
sub CPik{
  my $main = shift;my($keey,$valu);my $char;my $tchr;my $text = '';
  my $self = bless({}, ref($main));
  my $cmov;my $pick;my $done = 0;
  my @bchz = ( 'X', '@', '#', '%', 'X', '@', '#', '%'); # block chars
  my @styz = ( 'barz', 'blox', 'squr' ); # color display styles
  for my $attr($self->AttrNamz()){
    $self->{$attr} = $self->DfltValu($attr); # init defaults
  }
  # special CPik window defaults
  $self->{'_flagsdlk'} = 1;         # get SDLKeys
  $self->{'_flagmaxi'} = 0;         # not maximized
  $self->{'_flagcvis'} = 1;         # show cursor
  $self->{'_flagbakg'} = 1;         # pick background colors
  $self->{'_flagforg'} = 1;         # pick foreground colors
  $self->{'_flagclru'} = $main->{'_flagclru'}; # inherit ColorUsed flag
#  $self->{'_widt'} = getmaxx() - 4; # but almost full screen wide
#  $self->{'_hite'} = getmaxy() - 4; #                     && high
  $self->{'_text'} = [ ' ' ];
  $self->{'_dtfc'} =   'G';
  $self->{'_dtbc'} =   'b';
  if($self->{'_flagclru'}){
    $self->{'_fclr'} = [ $self->{'_dtfc'} ];
    $self->{'_bclr'} = [ $self->{'_dtbc'} ];
  }
  $self->{'_titl'} =   'Color Picker:';
  $self->{'_ttfc'} =   'ROYGUbG';
  $self->{'_ttbc'} =   'pgcupbu';
  $self->{'_flagprsk'} = 1;
  $self->{'_pres'} =   'Pick A Color... (Arrows+Enter, Letter, or Number)';
  $self->{'_prfc'} =   'Y'; # Pick message foreground Color
  $self->{'_prbc'} =   'k'; # Pick message background Color
  $self->{'_hifc'} =   'W'; # highlight    foreground color
  $self->{'_hibc'} =   'g'; # highlight    background color
  $self->{'_hndx'} =     7; # highlight    index
  $self->{'_sndx'} =     0;   # style index
  $self->{'_styl'} =   'barz';# style name
  $self->{'_bndx'} =     0;   # block index
  $self->{'_bchr'} =   'X';   # block char
  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; }
  # there were init params with no colon (classname)
  while(@_){
    ($keey, $valu)=(shift, shift);
    if(defined($valu)){
      if     ($keey =~ /^_*....$/){
        $keey =~ s/^_*//;
        $self->{"_$keey"} = $valu;
      }else{
        for my $attr($self->AttrNamz()){
          $self->{$attr} = $valu if($attr =~ /$keey/i);
        }
      }
    }else{
      $self->{'_styl'} = $keey;
    }
  }
  $self->{'_sndx'} = $self->{'_styl'} if($self->{'_styl'} =~ /^\d+$/);
  $self->{'_styl'} = $styz[$self->{'_sndx'}];
  $self->{'_bndx'} = $self->{'_bchr'} if($self->{'_bchr'} =~ /^\d+$/);
  $self->{'_bchr'} = $bchz[$self->{'_bndx'}];
  if($self->{'_widt'} < length($self->{'_titl'}) + 4){
    $self->{ '_widt'} = length($self->{'_titl'}) + 4;
  }
  $self->{'_ycrs'} = $self->{'_hndx'};
  $self->{'_xcrs'} = 0;
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'});
  $self->Updt(1);
  $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'},
                            $self->{'_yoff'}, $self->{'_xoff'});
# unless(exists($self->{'_wind'}) && defined($self->{'_wind'})){
#   die "!*EROR*! Curses::Simp->CPik could not create new window with hite:$self->{'_hite'}, widt:$self->{'_widt'}, yoff:$self->{'_yoff'}, xoff:$self->{'_xoff'}!\n";}
  $self->FlagCVis(); # set cursor visibility to new object state
  $self->BildBlox(); # build color block data into @text,@fclr,@bclr && Draw()
  $self->Move($self->{'_hndx'}, 0);
  while(!defined($char) || !$done){
    $char = $self->GetK(-1);
    if($char =~ /^SDLK_(RETURN|[0-9A-FRGYUPW])$/i){ # gonna be done
      $char =~ s/^SDLK_//;
      if     ($char =~ /^[BRGYUPCW]$/i){
        $pick = $char;
        $pick = uc($pick) if($self->{'_kmod'}->{'KMOD_SHIFT'});
      }else{
        $self->{'_hndx'} = dec(uc($char)) unless($char =~ /^RETURN$/);
        $pick = $telc[      ($self->{'_hndx'} %  8)];
        $pick = uc($pick) if($self->{'_hndx'} >= 8);
      }
      $done = 1;
    }else{
      $tchr =  $char;
      $tchr =~ s/^SDLK_//;
      $cmov = 0;
      if    ($tchr eq 'PAGEUP'  ){ # Page keys cycle Block Char
        $self->{'_bndx'}++;
        $self->{'_bndx'} = 0 if($self->{'_bndx'} == @bchz);
      }elsif($tchr eq 'PAGEDOWN'){
        $self->{'_bndx'} = @bchz unless($self->{'_bndx'});
        $self->{'_bndx'}--;
      }elsif($tchr eq 'END'     ){ # Home/End cycles layout Style
        $self->{'_sndx'}++;
        $self->{'_sndx'} = 0 if($self->{'_sndx'} == @styz);
      }elsif($tchr eq 'HOME'    ){
        $self->{'_sndx'} = @styz unless($self->{'_sndx'});
        $self->{'_sndx'}--;
      }
      $self->{'_bchr'} = $bchz[$self->{'_bndx'}];
      $self->{'_styl'} = $styz[$self->{'_sndx'}];
      if     ($self->{'_styl'} eq 'barz'){
        if    ($tchr eq 'LEFT'  or $tchr eq 'UP'  ){
          $self->{'_hndx'} = 16 unless($self->{'_hndx'});
          $self->{'_hndx'}--;
        }elsif($tchr eq 'RIGHT' or $tchr eq 'DOWN'){
          $self->{'_hndx'}++;
          $self->{'_hndx'} = 0 if($self->{'_hndx'} == 16);
        }
      }elsif($self->{'_styl'} eq 'blox'){
        if    ($tchr eq 'DOWN'  or $tchr eq 'UP'){
          $self->{'_hndx'} +=  8;
          $self->{'_hndx'} -= 16 if($self->{'_hndx'} >= 16);
        }elsif($tchr eq 'LEFT' ){
          $self->{'_hndx'} = 16 unless($self->{'_hndx'});
          $self->{'_hndx'}--;
        }elsif($tchr eq 'RIGHT'){
          $self->{'_hndx'}++;
          $self->{'_hndx'} = 0 if($self->{'_hndx'} == 16);
        }
      }elsif($self->{'_styl'} eq 'squr'){
        if    ($tchr eq 'UP'   ){
          $self->{'_hndx'} -=  4;
          $self->{'_hndx'} += 16 if($self->{'_hndx'} < 0);
        }elsif($tchr eq 'DOWN' ){
          $self->{'_hndx'} +=  4;
          $self->{'_hndx'} -= 16 if($self->{'_hndx'} >= 16);
        }elsif($tchr eq 'LEFT' ){
          $self->{'_hndx'} = 16 unless($self->{'_hndx'});
          $self->{'_hndx'}--;
        }elsif($tchr eq 'RIGHT'){
          $self->{'_hndx'}++;
          $self->{'_hndx'} = 0 if($self->{'_hndx'} == 16);
        }
      } $self->BildBlox();
    }
  } delwin($self->{'_wind'}); # delete the CPik window, redraw rest
  $main->ShokScrn(2);
  $main->FlagCVis(); # reset  cursor visibility to calling object state
  return($pick);     # return picked color code
}
sub BrwsHelp{ # BrwsHelp() just prints a help text message for Brws()
  my $self = shift;
     $self->Mesg('type' => 'help',
                 'titl' => 'File / Directory Browser Help: (F1)',
"This Browser dialog exists to make it easy to choose a file (or directory).

You can <TAB> between elements.  Ctrl-I and TAB are interpreted as the same
key by Curses so either one can be pressed to cycle forward through Browse
elements.  Ctrl-U cycles backwards.  Ctrl-H toggles hidden files.
Ctrl-F toggles file highlighting.  Ctrl-C shows the configuration screen.

All drop downs can be navigated with the arrow keys, typed directly into,
or have their drop state toggled with the tilde '~' or backtick '`' keys.

  The '=C' button is supposed to look like a wrench for configuration.
    Pressing enter on it will bring up the Browse configuration screen.
  The 'md' button allows you to make a new directory in the current path.
  The 'Path:' drop down lets you specify which directory to apply 'Filter:'
    to when populating the main view box in the center.
  The '..' button moves path up one directory.
  The '??' button brings up this help text.
  The main view box can be navigated with the arrow keys and a file can be
    chosen with Enter.
  The 'Filename:' drop down lets you type the filename specificially or
    pick from recent choices.
  The button following 'Filename:' will likely be labeled 'Open' or
    'Save As' for the purpose of the Browsing.  This button accepts
    whatever name is in the 'Filename:' drop down.
  The 'Filter:' drop down lets you specify what globbing should happen in
    'Path:' to populate the main view.
  The 'Cancel' button quits without making a selection.
");
}
#  The '=C' button is supposed to look like a wrench for configuration.
#    Pressing enter on it will bring up the Browse configuration screen.
#  The 'md' button allows you to make a new directory in the current path.
#  The 'Path:' drop down lets you specify which directory to apply 'Filter:'
#    to when populating the main view box in the center.
#  The '..' button moves path up one directory.
#  The '??' button brings up this help text.
#  The main view box can be navigated with the arrow keys and a file can be
#    chosen with Enter.
#  The 'Filename:' drop down lets you type the filename specificially or
#    pick from recent choices.
#  The button following 'Filename:' will likely be labeled 'Open' or
#    'Save As' for the purpose of the Browsing.  This button accepts
#    whatever name is in the 'Filename:' drop down.
#  The 'Filter:' drop down lets you specify what globbing should happen in
#    'Path:' to populate the main view.
#  The 'Cancel' button quits without making a selection.
sub BrwsCnfg{ # BrwsCnfg() brings up a dialog of checkboxes for elements
  my $self = shift; my $char; my $cndx = 0;
  my %cdsc = ('_cnfg' => '=C - Configuration       Button',
              '_mkdr' => 'md - Make Directory      Button',
              '_path' => 'Path:                 Drop Down',
              '_cdup' => '.. - Change Directory Up Button',
              '_help' => '?? - Help                Button',
              '_view' => 'Main View Area                 ',
              '_file' => 'Filename:             Drop Down',
              '_open' => 'Open/SaveAs/etc.         Button',
              '_filt' => 'Filter:               Drop Down',
              '_cncl' => 'Cancel                   Button',
             );
  my $cfgb = $self->Mesg('type' => 'butn', 'titl'=>'Browser Configuration:',
    'hite' => $self->{'_hite'}, 'widt' => $self->{'_widt'},
    'yoff' => $self->{'_yoff'}, 'xoff' => $self->{'_xoff'}, 'flagsdlk' => 1,
    'mesg' => " Tab or Arrows go between fields, Space toggles, Enter accepts all.",
  );
  for(my $indx=0;$indx<@{$self->{'_elem'}};$indx++){ # make ckboxes
    $cfgb->{'_cbob'}->{ $self->{'_elem'}->[$indx] } = $cfgb->Mesg(
      'type' => 'ckbx',
      'yoff' => ($self->{'_yoff'} + ($indx * 2) + 4),
      'xoff' => ($self->{'_xoff'} + 4),
      'stat' => $self->{'_eflz'}->{ $self->{'_elem'}->[$indx] },
      "$cdsc{$self->{'_elem'}->[$indx]} Visible"
    );
  }
  while(!defined($char) || $char ne 'SDLK_RETURN'){
    $char = $cfgb->{'_cbob'}->{ $self->{'_elem'}->[ $cndx ] }->Focu();
    if    ($char =~ /^SDLK_(TAB|DOWN|j)$/){
      $cndx++;
      $cndx = 0 if($cndx >= @{$self->{'_elem'}});
    }elsif($char =~ /^SDLK_(UP|k)$/ ||
          ($char eq 'SDLK_u' && $cfgb->{'_cbob'}->{ $self->{'_elem'}->[ $cndx ] }->{'_kmod'}->{'KMOD_CTRL'})){
      $cndx = @{$self->{'_elem'}} unless($cndx);
      $cndx--;
    }
  }
  for(my $indx=0;$indx<@{$self->{'_elem'}};$indx++){ # make ckboxes
    $self->{'_eflz'}->{ $self->{'_elem'}->[$indx] } =
      $cfgb->{'_cbob'}->{ $self->{'_elem'}->[$indx] }->{'_stat'};
    $cfgb->{'_cbob'}->{ $self->{'_elem'}->[$indx] }->DelW();
  }
  $cfgb->DelW();
  $self->BildBrws(1);
  return();
}
sub BrwsCdUp{ # BrwsCdUp() just moves the browse path up one directory
  my $self = shift;
  if($self->{'_path'} =~ s/^(.*\/).+\/?$/$1/){
    $self->{'_bobj'}->{'_path'}->{'_text'}->[
      ($self->{'_bobj'}->{'_path'}->{'_lndx'} + 1) ] = $self->{'_path'};
    $self->{'_bobj'}->{'_path'}->{'_dtxt'}           = $self->{'_path'};
    $self->{'_bobj'}->{'_path'}->{'_data'}           = $self->{'_path'};
    $self->{'_bobj'}->{'_path'}->{'_text'}->[0]      = $self->{'_path'};
    $self->{'_bobj'}->{'_path'}->{'_curs'}    = length($self->{'_path'});
    $self->{'_bobj'}->{'_path'}->{'_xcrs'}    = length($self->{'_path'});
    $self->{'_bobj'}->{'_path'}->{'_echg'} = 1;
  }
}
# BildBrws() is a utility of Brws() which creates or updates all the
#   elements of a Browse Window.
#  Brws() bare-bones dialog should look something like:
#  +------------------------{Open File:}-------------------------------+
#  |+--------------------{cwd: /home/pip }----------------------------+|
#  ||../                                                              ||
#  ||.LS_COLORS                                                       ||
#  ||.ssh/                                                            ||
#  ||.zshrc *Highlighted line*                                        ||
#  ||dvl/                                                             ||
#  |+-----------------------------------------------------------------+|
#  |+-----------------{Filename:}--------------+--++========++--------+|
#  ||.zshrc                                    |\/||  Open  || Cancel ||
#  |+------------------------------------------+--++========++--------+|
#  +-------------------------------------------------------------------+
#    or Brws() with frills
#  +---------------------------{Open File:}----------------------------+
#  |+--++--++-----------------------{Path:}----------------+--++--++--+|
#  ||=C||md||/home/pip                                     |\/||..||??||
#  |+--++--++----------------------------------------------+--++--++--+|
#  |+-----------------------------------------------------------------+|
#  ||../                                                              ||
#  ||.LS_COLORS                                                       ||
#  ||.ssh/                                                            ||
#  ||.zshrc *Highlighted line*                                        ||
#  ||dvl/                                                             ||
#  |+-----------------------------------------------------------------+|
#  |+----------------------{Filename:}-------------------+--++========+|
#  ||.zshrc                                              |\/||  Open  ||
#  |+----------------------------------------------------+--++========+|
#  |+-----------------------{Filter:}--------------------+--++--------+|
#  ||* (All Files)                                       |\/|| Cancel ||
#  |+----------------------------------------------------+--++--------+|
#  +-------------------------------------------------------------------+
#  heh... this one is complicated enough that it should probably be
#    Curses::Simp::Brws.pm instead ... too bad =)
#  =C is configure wrench for new dialog of all toggles (&& hotkeys)
#  md is mkdir dialog
#  \/ drop down bar to show recent or common options
#  .. is `cd ..`
#  ?? is help / F1
#  ==== box is highlighted (Enter selects)
#    Ultimately, Brws() should be able to handle easy Browsing for
#      Files or Directories for any Open/SaveAs/etc. purposes
sub BildBrws{
  my $self = shift; my $updt = shift || 0; my $indx;
  $self->FlagCVis(); # set cursor visibility to main Brws object state
  $self->Draw();
  for($indx=0;$indx<@{$self->{'_elem'}};$indx++){
    if(!$self->{'_eflz'}->{$self->{'_elem'}->[$self->{'_endx'}]}){
      $self->{'_endx'}++;
      $self->{'_endx'} = 0 if($self->{'_endx'} == @{$self->{'_elem'}});
    }
  } # this for && below if make sure a visible element is indexed
  if(!$self->{'_eflz'}->{$self->{'_elem'}->[$self->{'_endx'}]}){
    $self->{'_eflz'}->{$self->{'_elem'}->[$self->{'_endx'}]} = 1;
  }
  for($indx = 0; $indx < @{$self->{'_elem'}}; $indx++){
    my $elem = $self->{'_elem'}->[$indx];
    if(!$updt || $self->{'_eflz'}->{$elem}){
      my($yoff, $xoff)=($self->{'_yoff'} + 1, $self->{'_xoff'} + 1);
      my($widt, $hite)=($self->{'_widt'} - 2, $self->{'_hite'} - 2);
      my $type = 'butn';my $titl =  '';my $btyp = 1;
      my $brfc =    'w';my $brbc = 'k';my $scrl = 0;
      my $mesg;my @text;my @fclr;my @bclr;
      if($self->{'_flagclru'}){ @fclr = ( 'w' ); @bclr = ( 'k' ); }
      if    ($elem eq '_cnfg'){ # do specific settings
        $hite = 3; $widt = 4;
        $mesg = '=C';
      }elsif($elem eq '_mkdr'){
        $hite = 3; $widt = 4;
        $xoff += 4 if($self->{'_eflz'}->{'_cnfg'});
        $mesg = 'md';
      }elsif($elem eq '_path'){
        $hite = 3;
        if($self->{'_eflz'}->{'_cnfg'}) { $xoff += 4; $widt -= 4; }
        if($self->{'_eflz'}->{'_mkdr'}) { $xoff += 4; $widt -= 4; }
        if($self->{'_eflz'}->{'_cdup'}) {             $widt -= 4; }
        if($self->{'_eflz'}->{'_help'}) {             $widt -= 4; }
        $type = 'drop';
        $titl = 'Path:';
        if(exists(  $self->{'_bobj'}->{'_path'})){
          @text = @{$self->{'_bobj'}->{'_path'}->{'_text'}};
          if($self->{'_flagclru'}){
            @fclr = @{$self->{'_bobj'}->{'_path'}->{'_fclr'}};
            @bclr = @{$self->{'_bobj'}->{'_path'}->{'_bclr'}};
          }
        }else{
          @text = ( $self->{'_path'}, '/home/', '/tmp/' );
        }
      }elsif($elem eq '_cdup'){
        $hite  = 3;$widt = 4;
        $xoff  = $self->{'_widt'} - 3;
        $xoff -= 4 if($self->{'_eflz'}->{'_help'});
        $mesg  = '..';
      }elsif($elem eq '_help'){
        $hite  = 3;$widt = 4;
        $xoff  = $self->{'_widt'} - 3;
        $mesg  = '??';
      }elsif($elem eq '_view'){
        my $dtdt = 0;
        if($self->{'_eflz'}->{'_cnfg'} ||
           $self->{'_eflz'}->{'_mkdr'} ||
           $self->{'_eflz'}->{'_path'} ||
           $self->{'_eflz'}->{'_cdup'} ||
           $self->{'_eflz'}->{'_help'}){ $yoff += 3;$hite -= 3; }
        if($self->{'_eflz'}->{'_file'} ||
           $self->{'_eflz'}->{'_open'} ||
           $self->{'_eflz'}->{'_cncl'}){            $hite -= 3; }
        if($self->{'_eflz'}->{'_filt'}){            $hite -= 3; }
        if(exists(  $self->{'_bobj'}->{'_view'})){
          @text = @{$self->{'_bobj'}->{'_view'}->{'_text'}};
          if($self->{'_flagclru'}){
            @fclr = @{$self->{'_bobj'}->{'_view'}->{'_fclr'}};
            @bclr = @{$self->{'_bobj'}->{'_view'}->{'_bclr'}};
          }
          if($self->{'_bobj'}->{'_view'}->{'_echg'}){
            $self->{'_choi'} = $text[($self->{'_vndx'} - $self->{'_vscr'})];
            $self->{'_bobj'}->{'_file'}->{'_curs'} = length($self->{'_choi'});
            $self->{'_bobj'}->{'_file'}->{'_xcrs'} = length($self->{'_choi'});
          }
        }
        if(!$updt || $self->{'_bobj'}->{'_mkdr'}->{'_echg'} ||
                     $self->{'_bobj'}->{'_path'}->{'_echg'} ||
                     $self->{'_bobj'}->{'_view'}->{'_echg'} ||
                     $self->{'_bobj'}->{'_filt'}->{'_echg'}){
          @text = (); if($self->{'_flagclru'}){ @fclr = ();@bclr = (); }
          unless($self->{'_choi'}){
            $self->{'_vndx'} = 0;
            $self->{'_choi'} = '';
          }
          unless($self->{'_flaghide'}){
            for(glob($self->{'_path'} . '.' . $self->{'_filt'})){
              $_ .= '/' if(-d $_);
              s/^$self->{'_path'}//;
              $dtdt = 1 if($_ eq '../');
              unless($_ eq './'){ # || /\.swp$/)  # omit . && .swp
                push(@text, $_);
                if(!$self->{'_choi'}){
                  if(-f $_){ $self->{'_choi'} = $_; }
                  else     { $self->{'_vndx'}++;    }
                }
              }
            }
          }
          for(glob($self->{'_path'} . $self->{'_filt'})){
            $_ .= '/' if(-d $_);
            s/^$self->{'_path'}//;
            unless($_ eq './' || ($_ eq '../' && $dtdt)){ # omit . or 2nd ..
              push(@text, $_);
              if(!$self->{'_choi'}){
                if(-f $_){ $self->{'_choi'} = $_; }
                else     { $self->{'_vndx'}++;    }
              }
            }
          }
          $self->{'_vndx'} = (@text - 1) if($self->{'_vndx'} > (@text - 1));
          if($self->{'_flagflhi'}){
            my $lsfc;my $lsbc = 'k'; # need background colors for listing?
            for(@text){
              my $fulf = $self->{'_path'} . $_;
                                $lsfc = $GLBL{'TESTMAPP'}->{'NORMAL'};
              if    (-d $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'DIR'};
              }elsif(-l $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'LINK'};
              }elsif(-p $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'FIFO'};
              }elsif(-S $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'SOCK'};
              }elsif(-b $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'BLK'};
              }elsif(-c $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'CHR'};
             #}elsif(-O $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'ORPHAN'}; # don't know test
              }elsif(-x $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'EXEC'};
              }elsif(-f $fulf){ $lsfc = $GLBL{'TESTMAPP'}->{'FILE'};
                my %CLUT =('0;30' => 'k','1;30' => 'K','0;31' => 'r','1;31' => 'R','0;32' => 'g','1;32' => 'G','0;33' => 'O','1;33' => 'Y',
                           '0;34' => 'b','1;34' => 'B','0;35' => 'p','1;35' => 'P','0;36' => 'c','1;36' => 'C','0;37' => 'w','1;37' => 'W');
                for(split(':',$ENV{'LS_COLORS'})){      my($g2re,$ansn);
                  if    (/^([^=]*[\*\+\?]+[^=]+)=0(.+)$/){($g2re,$ansn)=($1,$2);$g2re=~s/([.])/\\$1/g;
                                                                                $g2re=~s/(\?|(\*|\+))/.$2/g;#$lsp8{qr/^.*\s*$g2re$/}=$ansn;
                  }elsif(              /^([^=]+)=0(.+)$/){($g2re,$ansn)=($1,$2);                            #$lspt{         $g2re  }=$ansn;
                  }$GLBL{'OVERMAPP'}->{qr/^.*\s*$g2re$/} = $CLUT{$ansn} if(exists($CLUT{$ansn}));
                }
                for my $regx(keys(%{$GLBL{'DFLTMAPP'}})){ # test defaults
                  $lsfc = $GLBL{'DFLTMAPP'}->{$regx} if($fulf =~ /$regx/i);
                }
                for my $regx(keys(%{$GLBL{'OVERMAPP'}})){ # test overridz
                  $lsfc = $GLBL{'OVERMAPP'}->{$regx} if($fulf =~ /$regx/i);
                }
              }
              if($self->{'_flagclru'}){
                push(@fclr, $lsfc);
                push(@bclr, $lsbc);
              }
            }
          }elsif($self->{'_flagclru'}){ # don't highlight different files
            for(@text){
              push(@fclr, 'w');
              push(@bclr, 'k');
            }
          }
          if($self->{'_vndx'} != -1){
            substr($bclr[$self->{'_vndx'}], 0, 1,
              substr(    $self->{'_hibc'},  0, 1));
            if($self->{'_flagclru'} && !$self->{'_flagbgho'}){ # !BkGr Hi Only
              substr($fclr[$self->{'_vndx'}], 0, 1, # so get foreground too
                substr(    $self->{'_hifc'},  0, 1));
            }
          }
          if($self->{'_vndx'} > ($hite - 3)){ # handle view scrolling
            my $vndx = $self->{'_vndx'};
            while($vndx-- > ($hite - 3)){
              push(@text, shift(@text));
              if($self->{'_flagclru'}) { shift(@fclr); shift(@bclr); }
            }
            $self->{'_vscr'} = ($self->{'_vndx'} - ($hite - 3));
          }else{
            $self->{'_vscr'} = 0;
          }
        }
        $scrl = 1 if(@text > ($hite - 2));
      }elsif($elem eq '_file'){
        $hite = 3;
        $yoff = $self->{'_hite'} - 2;
        if   ($self->{'_eflz'}->{'_filt'}){ $yoff -= 3;              }
        elsif($self->{'_eflz'}->{'_cncl'}){             $widt -= 12; }
        if   ($self->{'_eflz'}->{'_open'}){             $widt -= 12; }
        $type = 'drop';
        $titl = 'Filename:';
        if(exists(  $self->{'_bobj'}->{'_file'})){
          @text = @{$self->{'_bobj'}->{'_file'}->{'_text'}};
          if($self->{'_flagclru'}){
            @fclr = @{$self->{'_bobj'}->{'_file'}->{'_fclr'}};
            @bclr = @{$self->{'_bobj'}->{'_file'}->{'_bclr'}};
          }
        }
        if($updt || !@text){
          $self->{'_bobj'}->{'_file'}->{'_data'} =        $self->{'_choi'};
          @text                                  =      ( $self->{'_choi'} );
        }
      }elsif($elem eq '_open'){
        $hite = 3; $widt = 12;
        $yoff = $self->{'_hite'} -  2;
        $xoff = $self->{'_widt'} - 11;
        if   ($self->{'_eflz'}->{'_filt'}){ $yoff -= 3;              }
        elsif($self->{'_eflz'}->{'_cncl'}){             $xoff -= 12; }
        $btyp = 4;
        $mesg  = ' ' x int((10 - length($self->{'_acpt'})) / 2);
        $mesg .= $self->{'_acpt'}; # $mesg = '   Open   ';
        $mesg .= ' ' x (10 - length($mesg));
      }elsif($elem eq '_filt'){
        $hite = 3;
        $yoff = $self->{'_hite'} - 2;
        if($self->{'_eflz'}->{'_cncl'}){             $widt -= 12; }
        $type = 'drop';
        $titl = 'Filter:';
        if(exists(  $self->{'_bobj'}->{'_filt'})){
          @text = @{$self->{'_bobj'}->{'_filt'}->{'_text'}};
          if($self->{'_flagclru'}){
            @fclr = @{$self->{'_bobj'}->{'_filt'}->{'_fclr'}};
            @bclr = @{$self->{'_bobj'}->{'_filt'}->{'_bclr'}};
          }
        }else{
          @text = ( $self->{'_filt'}, '.*', '*.pl' );
        }
      }elsif($elem eq '_cncl'){
        $hite = 3; $widt = 12;
        $yoff = $self->{'_hite'} -  2;
        $xoff = $self->{'_widt'} - 11;
        $mesg = '  Cancel  ';
      }
      if($self->{'_endx'} == $indx){
        $btyp =  4;
        $brfc = 'C';
        $brbc = 'b';
      }
      @text = split(/\n/, $mesg) if($mesg);
      if($updt && $self->{'_bobj'}->{$elem}){ # just update existing elements
        if($self->{'_flagclru'}){
          $self->{'_bobj'}->{$elem}->Draw(
            'hite' => $hite, 'widt' => $widt, 'yoff' => $yoff, 'xoff' => $xoff,
                             'btyp' => $btyp, 'brfc' => $brfc, 'brbc' => $brbc,
            'text' => [ @text ], 'fclr' => [ @fclr ], 'bclr' => [ @bclr ],
            'flagscrl' => $scrl,
          );
        }else{
          $self->{'_bobj'}->{$elem}->Draw(
            'hite' => $hite, 'widt' => $widt, 'yoff' => $yoff, 'xoff' => $xoff,
                             'btyp' => $btyp, 'brfc' => $brfc, 'brbc' => $brbc,
            'text' => [ @text ], 'flagscrl' => $scrl,
          );
        }
      }else{
        if     ($type eq 'butn'){ # create respective elements
          if($self->{'_flagclru'}){
            $self->{'_bobj'}->{$elem} = $self->Mesg(
              'hite' => $hite, 'widt' => $widt,
              'yoff' => $yoff, 'xoff' => $xoff,
              'type' => $type, 'titl' => $titl,
              'btyp' => $btyp, 'brfc' => $brfc, 'brbc' => $brbc,
              'text' => [ @text ], 'fclr' => [ @fclr ], 'bclr' => [ @bclr ],
              'elmo' => 'brws', 'flagscrl' => $scrl,
            );
          }else{
            $self->{'_bobj'}->{$elem} = $self->Mesg(
              'hite' => $hite, 'widt' => $widt,
              'yoff' => $yoff, 'xoff' => $xoff,
              'type' => $type, 'titl' => $titl, 'btyp' => $btyp,
              'text' => [ @text ], 'elmo' => 'brws', 'flagscrl' => $scrl,
            );
          }
        }elsif($type eq 'drop'){
          if($self->{'_flagclru'}){
            $self->{'_bobj'}->{$elem} = $self->Prmt(
              'hite' => $hite, 'widt' => $widt,
              'yoff' => $yoff, 'xoff' => $xoff,
              'type' => $type, 'titl' => $titl,
              'btyp' => $btyp, 'brfc' => $brfc, 'brbc' => $brbc,
              'text' => [ @text ], 'fclr' => [ @fclr ], 'bclr' => [ @bclr ],
              'elmo' => 'brws', 'flagscrl' => $scrl,
            );
          }else{
            $self->{'_bobj'}->{$elem} = $self->Prmt(
              'hite' => $hite, 'widt' => $widt,
              'yoff' => $yoff, 'xoff' => $xoff,
              'type' => $type, 'titl' => $titl, 'btyp' => $btyp,
              'text' => [ @text ], 'elmo' => 'brws', 'flagscrl' => $scrl,
            );
          }
        }
      }
    }else{
      $self->{'_eflz'}->{$elem} = undef;
    }
  }
  # reset object changed flags
  $self->{'_bobj'}->{$_}->{'_echg'} = 0 for(@{$self->{'_elem'}});
}
# Brws() is a special Curses::Simp object constructor which creates a
#   file or directory Browse Window.
# If params are supplied, they must be hash key => value pairs.
sub Brws{
  my $main = shift; my($keey, $valu); my $char; my $tchr; my $choi = '';
  my $self = bless({}, ref($main));   my $indx; my $done = 0;
  for my $attr($main->AttrNamz()){
    $self->{$attr} = $main->DfltValu($attr); # init defaults
  }
  # special Brws window defaults
  $self->{'_flagsdlk'} = 1;         # get SDLKeys
  $self->{'_flagmaxi'} = 0;         # not maximized
  $self->{'_flagcvis'} = 0;         # don't show cursor
  $self->{'_flagview'} = 0;         # show 0=short (1=detailed) view
  $self->{'_flaghide'} = 0;         # don't hide .files by default
  $self->{'_flagquik'} = 0;         # don't show quick access panel
  $self->{'_flagsepd'} = 0;         # don't show separate directory pane
  $self->{'_flagflhi'} = 1;         # HIghlight FiLes in browser view
  $self->{'_flagbgho'} = 1;         # BackGround Highlight Only in view
  $self->{'_flagclru'} = $main->{'_flagclru'}; # inherit ColorUsed flag
  $self->{'_widt'} = getmaxx() - 4; # but almost full screen wide
  $self->{'_hite'} = getmaxy() - 4; #                     && high
  $self->{'_text'} = [ ' ' ];
  $self->{'_dtfc'} =   'G';
  $self->{'_dtbc'} =   'b';
  if($self->{'_flagclru'}){
    $self->{'_fclr'} = [ $self->{'_dtfc'} ];
    $self->{'_bclr'} = [ $self->{'_dtbc'} ];
  }
  $self->{'_elem'} = [ '_cnfg', '_mkdr', '_path', '_cdup', '_help', # elements
                       '_view', '_file', '_open', '_filt', '_cncl' ];
  $self->{'_eflz'} =     { }; $self->{'_eflz'}->{$_} = 1 for(@{$self->{'_elem'}}); # initialize element visibility flags
# BareBones settings below
#$self->{'_eflz'}->{$_} = 0 for('_cnfg','_mkdr','_cdup','_help','_filt');
  $self->{'_bobj'} =     { }; # Browse Objects (elements)
  $self->{'_brwt'} =  'File'; # Browse type ('File' or 'Dir')
  $self->{'_acpt'} =  'Open'; # acceptance button text like 'Open' or 'SaveAs'
  $self->{'_path'} =   `pwd`; # default path is the current working dir
  chomp($self->{'_path'});
  $self->{'_path'} =~ s/\/*$/\//;
  $self->{'_btyp'} =     1;   # border type
  $self->{'_titl'} =    '';   # gets set from Browse type below
  $self->{'_ttfc'} =   'G';
  $self->{'_ttbc'} =   'b';
  $self->{'_hifc'} =   'W'; # HIghlight Foreground Color
  $self->{'_hibc'} =   'g'; # HIghlight Background Color
  $self->{'_hndx'} =     0;   # Highlight iNDeX
  $self->{'_endx'} =     6;   # Element iNDeX
  $self->{'_vndx'} =     0;   # View iNDeX (choice line)
  $self->{'_vscr'} =     0;   # View SCRolling (to get choice line in view)
  $self->{'_choi'} =    '';   # choice (the chosen file or dir name)
  $self->{'_filt'} =   '*';   # glob filter
  for(@KMODNAMZ){ $self->{'_kmod'}->{$_} = 0; }
  # there were init params with no colon (classname)
  while(@_){
    ($keey, $valu)=(shift, shift);
    if(defined($valu)){
      if     ($keey =~ /^_*(....)?....$/){
        $keey =~ s/^_*//;
        $self->{"_$keey"} = $valu;
      }else{
        for my $attr($self->AttrNamz()){
          $self->{$attr} = $valu if($attr =~ /$keey/i);
        }
      }
    }else{
      $self->{'_brwt'} = $keey;
    }
  }
  $self->{'_titl'} = "Open $self->{'_brwt'}:" unless($self->{'_titl'});
  if($self->{'_widt'} < length($self->{'_titl'}) + 4) {
    $self->{ '_widt'} = length($self->{'_titl'}) + 4;
  }
  $self->{'_ycrs'} = $self->{'_hndx'};
  $self->{'_xcrs'} = 0;
  $self->{'_flagshrk'} = 0 if($self->{'_hite'} && $self->{'_widt'});
  $self->Updt(1);
  $self->{'_wind'} = newwin($self->{'_hite'}, $self->{'_widt'},
                            $self->{'_yoff'}, $self->{'_xoff'});
# unless(exists($self->{'_wind'}) && defined($self->{'_wind'})) {
#   die "!*EROR*! Curses::Simp->Brws could not create new window with hite:$self->{'_hite'}, widt:$self->{'_widt'}, yoff:$self->{'_yoff'}, xoff:$self->{'_xoff'}!\n";}
  $self->{'_dndx'} = @DISPSTAK; # add object to display order stack
  push(@DISPSTAK, \$self);
  $self->BildBrws(); # create all element objects
  while(!defined($char) || !$done){
    my $elem = $self->{'_elem'}->[$self->{'_endx'}];
    my $sobj = $self->{'_bobj'}->{$elem};
    if($sobj->{'_type'} eq 'drop'){
      $char = $sobj->Focu(); %{$self->{'_kmod'}} = %{$sobj->{'_kmod'}};
      $sobj->FlagCVis(0);
    }else{
      $char = $self->GetK(-1);
    }
    if   ($elem eq '_path'){ $self->{'_path'} = $sobj->{'_data'};
                             $self->{'_path'} =~ s/\/*$/\//;      }
    elsif($elem eq '_file'){ $self->{'_choi'} = $sobj->{'_data'}; }
    elsif($elem eq '_filt'){ $self->{'_filt'} = $sobj->{'_data'}; }
    if   ($char eq 'SDLK_RETURN'){
      if    ($elem eq '_cnfg'){
        $self->BrwsCnfg();
      }elsif($elem eq '_mkdr'){
        my $mdir = 'New_Dir';
        $self->Prmt('titl'     => "Make Directory: $self->{'_path'} ",
                    'flagescx' => 1, \$mdir);
        if(length($mdir)){
          $mdir = $self->{'_path'} .  $mdir unless($mdir =~ /^\//);
          if(-d $mdir){
            $self->Mesg('titl' => '!EROR! - Make Directory',
                                  "Directory: \"$mdir\" already exists!");
          }else{
            mkdir("$mdir", 0700);
            if(-d $mdir){
              $self->{'_bobj'}->{'_mkdr'}->{'_echg'} = 1;
            }else{
              $self->Mesg('titl' => '!EROR! - Make Directory',
                                    "Make directory: \"$mdir\" failed!");
            }
          }
        }
      }elsif($elem eq '_path'){
        $self->{'_bobj'}->{'_path'}->{'_echg'} = 1;
        $self->{'_endx'} = 6; # return from path jumps to file bar
      }elsif($elem eq '_cdup'){
        $self->BrwsCdUp();
      }elsif($elem eq '_help'){
        $self->BrwsHelp();
      }elsif($elem eq '_filt'){
        $self->{'_bobj'}->{'_filt'}->{'_echg'} = 1;
        $self->{'_endx'} = 5; # return from filt jumps to view box
      }else{
        $done = 1;
      }
    }
    $self->BildBrws(1);
    if     ( $char eq 'SDLK_TAB' ||                     # Ctrl-I == Tab
            ($char =~ /^SDLK_(RIGHT|DOWN)$/ && $elem =~ /^_(cnfg|mkdr|cdup|help|open|cncl)$/)){
      $sobj->{'_brfc'} = 'w'; $sobj->{'_brbc'} = 'k';
      $sobj->{'_btyp'} = $self->{'_btyp'} unless($elem eq '_open');
      $sobj->Draw();
      $self->{'_endx'}++;
      $self->{'_endx'} = 0 if($self->{'_endx'} == @{$self->{'_elem'}});
      while(!$self->{'_eflz'}->{$self->{'_elem'}->[$self->{'_endx'}]}){
        $self->{'_endx'}++;
        $self->{'_endx'} = 0 if($self->{'_endx'} == @{$self->{'_elem'}});
      }
      $elem = $self->{'_elem'}->[$self->{'_endx'}];
      $sobj = $self->{'_bobj'}->{$elem};
      $sobj->{'_brfc'} = 'C'; $sobj->{'_brbc'} = 'b';
      $sobj->{'_btyp'} = 4;
      if($elem eq '_file'){
        $self->{'_choi'} =        $sobj->{'_data'};
        $sobj->{'_curs'} = length($self->{'_choi'});
        $sobj->{'_xcrs'} = length($self->{'_choi'});
      }
      $sobj->Draw();
    }elsif( $char eq 'SDLK_u' && $self->{'_kmod'}->{'KMOD_CTRL'} || # Ctrl-U ~ Shift-Tab
           ($char =~ /^SDLK_(LEFT|UP)$/ && $elem =~ /^_(cnfg|mkdr|cdup|help|open|cncl)$/)){
      $sobj->{'_brfc'} = 'w'; $sobj->{'_brbc'} = 'k';
      $sobj->{'_btyp'} = $self->{'_btyp'} unless($elem eq '_open');
      $sobj->Draw();
      $self->{'_endx'} = @{$self->{'_elem'}} unless($self->{'_endx'});
      $self->{'_endx'}--;
      while(!$self->{'_eflz'}->{$self->{'_elem'}->[$self->{'_endx'}]}){
        $self->{'_endx'} = @{$self->{'_elem'}} unless($self->{'_endx'});
        $self->{'_endx'}--;
      }
      $elem = $self->{'_elem'}->[$self->{'_endx'}];
      $sobj = $self->{'_bobj'}->{$elem};
      $sobj->{'_brfc'} = 'C'; $sobj->{'_brbc'} = 'b';
      $sobj->{'_btyp'} = 4;
      if($elem eq '_file'){
        $self->{'_choi'} =        $sobj->{'_data'};
        $sobj->{'_curs'} = length($self->{'_choi'});
        $sobj->{'_xcrs'} = length($self->{'_choi'});
      }
      $sobj->Draw();
    }elsif($char eq 'SDLK_b' && $self->{'_kmod'}->{'KMOD_CTRL'}){ # Ctrl-B toggle view background only highlighting
      $self->{'_flagbgho'} ^= 1;
      $self->{'_bobj'}->{'_filt'}->{'_echg'} = 1;
      $self->BildBrws(1);
    }elsif($char eq 'SDLK_c' && $self->{'_kmod'}->{'KMOD_CTRL'}){ # Ctrl-C bring up configuration dialog
        $self->BrwsCnfg();
    }elsif($char eq 'SDLK_f' && $self->{'_kmod'}->{'KMOD_CTRL'}){ # Ctrl-F toggle view file highlighting
      $self->{'_flagflhi'} ^= 1;
      $self->{'_bobj'}->{'_filt'}->{'_echg'} = 1;
      $self->BildBrws(1);
    }elsif($char eq 'SDLK_h' && $self->{'_kmod'}->{'KMOD_CTRL'}){ # Ctrl-H toggle hidden file globbing
      $self->{'_flaghide'} ^= 1;
      $self->{'_bobj'}->{'_filt'}->{'_echg'} = 1;
      $self->BildBrws(1);
    }elsif($char eq 'SDLK_t' && $self->{'_kmod'}->{'KMOD_CTRL'}){ # Ctrl-T chg btyps
      $self->{'_btyp'}++;
      $self->{'_btyp'} = 0 if($self->{'_btyp'} > @BORDSETS);
      $self->Draw();
      for(@{$self->{'_elem'}}){
        $self->{'_bobj'}->{$_}->{'_btyp'} = $self->{'_btyp'} if($_ ne $elem);
        $self->{'_bobj'}->{$_}->Draw();
      }
    }elsif($char eq 'SDLK_F1'){
      $self->BrwsHelp();
    }elsif($elem eq '_view'){
      if     ($char eq 'SDLK_UP'){
        if($self->{'_vndx'}){
          $self->{'_vndx'}--;
          $self->{'_choi'} = $self->{'_bobj'}->{'_view'}->{'_text'}->[ $self->{'_vndx'} ];
          $self->{'_bobj'}->{'_view'}->{'_echg'} = 1;
          $self->BildBrws(1);
        }
      }elsif($char eq 'SDLK_DOWN'){
        if($self->{'_vndx'} < (@{$self->{'_bobj'}->{'_view'}->{'_text'}} - 1)){
          $self->{'_vndx'}++;
          $self->{'_choi'} = $self->{'_bobj'}->{'_view'}->{'_text'}->[ $self->{'_vndx'} ];
          $self->{'_bobj'}->{'_view'}->{'_echg'} = 1;
          $self->BildBrws(1);
        }
      }elsif($char eq 'SDLK_PAGEUP'){
        $self->{'_vndx'} -= ($self->{'_bobj'}->{'_view'}->{'_hite'} - 3);
        $self->{'_vndx'} = 0 if($self->{'_vndx'} < 0);
        $self->{'_choi'} = $self->{'_bobj'}->{'_view'}->{'_text'}->[ $self->{'_vndx'} ];
        $self->{'_bobj'}->{'_view'}->{'_echg'} = 1;
        $self->BildBrws(1);
      }elsif($char eq 'SDLK_PAGEDOWN'){
        $self->{'_vndx'} += ($self->{'_bobj'}->{'_view'}->{'_hite'} - 3);
        $self->{'_vndx'} = (@{$self->{'_bobj'}->{'_view'}->{'_text'}} - 1)
          if($self->{'_vndx'} >= @{$self->{'_bobj'}->{'_view'}->{'_text'}});
        $self->{'_choi'} = $self->{'_bobj'}->{'_view'}->{'_text'}->[ $self->{'_vndx'} ];
        $self->{'_bobj'}->{'_view'}->{'_echg'} = 1;
        $self->BildBrws(1);
      }elsif($char eq 'SDLK_LEFT'){
        $self->BrwsCdUp();
        $self->BildBrws(1);
      }elsif($char eq 'SDLK_RIGHT'){
        $choi = $self->{'_path'} . $self->{'_choi'};
        if(-d $choi){
          $choi =~ s/^(.*\/)([^\/]+\/)\.\.\/$/$1/; # handle cd..
          $self->{'_path'} = $choi;
          $self->{'_bobj'}->{'_path'}->{'_text'}->[
            ($self->{'_bobj'}->{'_path'}->{'_lndx'} + 1) ] = $self->{'_path'};
          $self->{'_bobj'}->{'_path'}->{'_dtxt'}           = $self->{'_path'};
          $self->{'_bobj'}->{'_path'}->{'_data'}           = $self->{'_path'};
          $self->{'_bobj'}->{'_path'}->{'_text'}->[0]      = $self->{'_path'};
          $self->{'_bobj'}->{'_path'}->{'_curs'}    = length($self->{'_path'});
          $self->{'_bobj'}->{'_path'}->{'_xcrs'}    = length($self->{'_path'});
          $self->{'_bobj'}->{'_path'}->{'_echg'} = 1;
          $self->BildBrws(1);
        }
      }
    }
    if($done){ # clean up && save local choice so all objects can be destroyed
      if   ($elem eq '_cncl'){ $choi = '-1'; }
      else                   { $choi = $self->{'_path'} . $self->{'_choi'};}
      if($self->{'_brwt'} eq 'File' && -d $choi){
        $choi =~ s/^(.*\/)([^\/]+\/)\.\.\/$/$1/; # handle cd..
        $self->{'_path'} = $choi;
        $self->{'_bobj'}->{'_path'}->{'_text'}->[
          ($self->{'_bobj'}->{'_path'}->{'_lndx'} + 1) ] = $self->{'_path'};
        $self->{'_bobj'}->{'_path'}->{'_dtxt'}           = $self->{'_path'};
        $self->{'_bobj'}->{'_path'}->{'_data'}           = $self->{'_path'};
        $self->{'_bobj'}->{'_path'}->{'_text'}->[0]      = $self->{'_path'};
        $self->{'_bobj'}->{'_path'}->{'_curs'}    = length($self->{'_path'});
        $self->{'_bobj'}->{'_path'}->{'_xcrs'}    = length($self->{'_path'});
        $self->{'_bobj'}->{'_path'}->{'_echg'} = 1;
        $self->BildBrws(1);
        $done = 0; # don't accept directory when choosing file
      }
    }
  }
  $self->DelW();      # Delete Brws Window && all element windows
  $main->ShokScrn(2); # redraw all old stuff
  $main->FlagCVis();  # reset  cursor visibility to calling object state
  return($choi);      # return choice (file or dir name)
}
sub DESTROY{
  my $self = shift || return(); my $dndx = $self->{'_dndx'};
  my $shok = 1;
     $shok = 0 if(exists($self->{'_type'}) && length($self->{'_type'}));
  if($self->{'_wind'}){
    delwin($self->{'_wind'});
    for(++$dndx;$dndx<@DISPSTAK;$dndx++){
      if($DISPSTAK[$dndx] && exists(${$DISPSTAK[$dndx]}->{'_dndx'})){
        ${$DISPSTAK[$dndx]}->{'_dndx'}--;
      }
    }
    #remove deleted from displaystack
    splice(@DISPSTAK, $self->{'_dndx'}, 1) if($self->{'_dndx'} < @DISPSTAK);
    $self->ShokScrn(2) if($shok);
  }
}
# VERBOSE METHOD NAME ALIASES
*AttributeNames        = \&AttrNamz;
*DefaultValues         = \&DfltValu;
*MakeMethods           = \&MkMethdz;
*InitializeColorPair   = \&InitPair;
*PrintBorderCharacter  = \&BordChar;
*ConvertAnsiColorCode  = \&CnvAnsCC;
*ShockScreen           = \&ShokScrn;
*KeyNumbers            = \&KNum;
*ColorLetters          = \&CLet;
*NumColors             = \&NumC;
*Height                = \&Hite;
*Width                 = \&Widt;
*PrintString           = \&Prnt;
*DrawWindow            = \&Draw;
*WaitTime              = \&Wait;
*GetKey                = \&GetK;
*GetString             = \&GetS;
*MoveCursor            = \&Move;
*ResizeWindow          = \&Rsiz;
*UpdateWindow          = \&Updt;
*MessageWindow         = \&Mesg;
*PromptWindow          = \&Prmt;
*FocusWindow           = \&Focu;
*ColorPickWindow       = \&CPik;
*BrowseWindow          = \&Brws;
*DeleteWindow          = \&DelW;
*DelW                  = \&DESTROY;
# allow color arrays to be tied too
package Curses::Simp::FClr;
sub TIEARRAY { # bless an anon array with just parent in case more to store
  my $clas = shift;my $prnt = shift;
#  carp("!*EROR*! Need additional Parent object reference  parameter to tie $clas to!\n") unless(defined($prnt) && ref($prnt) eq 'Curses::Simp');
  exit unless(defined($prnt) && ref($prnt) eq 'Curses::Simp');
  my $self = bless([$prnt], $clas);
  $prnt->{'_flagclru'} = 1;
  return($self);
}
sub FETCH    { return(         $_[0]->[0]->{'_fclr'}->[$_[1]]); }
sub FETCHSIZE{ return(scalar(@{$_[0]->[0]->{'_fclr'}})       ); }
sub STORE    {
  $_[0]->[0]->{'_fclr'}->[$_[1]] = $_[2];
  $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'});
}
sub STORESIZE{
  splice(@{$_[0]->[0]->{'_fclr'}}, $_[1], @{$_[0]->[0]->{'_fclr'}} - $_[1]);
  $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'});
}
sub EXISTS   { return(0) unless(defined($_[0]->[0]->{'_fclr'}->[$_[1]])); return(1); }
sub CLEAR    {             @{$_[0]->[0]->{'_fclr'}} = ();         $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub PUSH     {        push(@{$_[0]->[0]->{'_fclr'}}, $_[1]);      $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub POP      { $_ =    pop(@{$_[0]->[0]->{'_fclr'}});             $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
sub SHIFT    { $_ =  shift(@{$_[0]->[0]->{'_fclr'}});             $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
sub UNSHIFT  {     unshift(@{$_[0]->[0]->{'_fclr'}}, $_[1]);      $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub SPLICE   {
#              $_ = splice(@{$_[0]->[0]->{'_fclr'}}, @_[1..$#_]); $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->[0]->FETCHSIZE() - $offs unless(defined($leng));
  my $retn = splice(@{$self->[0]->{'_fclr'}}, $offs, $leng, @_);
  $self->[0]->Curses::Simp::TestDraw() if($self->[0]->{'_flagadtb'});
  return($retn);
}
sub EXTEND   { }
package Curses::Simp::BClr;
sub TIEARRAY {
  my $clas = shift; my $prnt = shift;
#  carp("!*EROR*! Need additional Parent object reference  parameter to tie $clas to!\n") unless(defined($prnt) && ref($prnt) eq 'Curses::Simp');
  exit unless(defined($prnt) && ref($prnt) eq 'Curses::Simp');
  my $self = bless([$prnt], $clas);
  $prnt->{'_flagclru'} = 1;
  return($self);
}
sub FETCH    { return(         $_[0]->[0]->{'_bclr'}->[$_[1]]); }
sub FETCHSIZE{ return(scalar(@{$_[0]->[0]->{'_bclr'}})       ); }
sub STORE    {
  $_[0]->[0]->{'_bclr'}->[$_[1]] = $_[2];
  $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'});
}
sub STORESIZE{
  splice(@{$_[0]->[0]->{'_bclr'}}, $_[1], @{$_[0]->[0]->{'_bclr'}} - $_[1]);
  $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'});
}
sub EXISTS   { return(0) unless(defined($_[0]->[0]->{'_bclr'}->[$_[1]])); return(1); }
sub CLEAR    {             @{$_[0]->[0]->{'_bclr'}} = ();         $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub PUSH     {        push(@{$_[0]->[0]->{'_bclr'}}, $_[1]);      $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub POP      { $_ =    pop(@{$_[0]->[0]->{'_bclr'}});             $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'}); return($_); }
sub SHIFT    { $_ =  shift(@{$_[0]->[0]->{'_bclr'}});             $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'}); return($_); }
sub UNSHIFT  {     unshift(@{$_[0]->[0]->{'_bclr'}}, $_[1]);      $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub SPLICE   {
#              $_ = splice(@{$_[0]->[0]->{'_bclr'}}, @_[1..$#_]); $_[0]->[0]->Curses::Simp::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->[0]->FETCHSIZE() - $offs unless(defined($leng));
  my $retn = splice(@{$self->[0]->{'_bclr'}}, $offs, $leng, @_);
  $self->[0]->Curses::Simp::TestDraw() if($self->[0]->{'_flagadtb'});
  return($retn);
}
sub EXTEND   { }
1;

=encoding utf8

=head1 NAME

Curses::Simp - Curses made almost Simple

=head1 VERSION

This documentation refers to version 1.6 of Curses::Simp, which was released on
.

=head1 SYNOPSIS

  use                       Curses::Simp;
  my $keey = '';my @text;   # just text demonstr8ion
  my $simp =   tie(@text,  'Curses::Simp'    );
  @text=('1337', 'nachoz', 'w/', 'cheese' x 7);
  while ($keey !~/[qx]/i) { # w8 4'q'Quit or 'x'eXit
    $keey=$simp->GetK(-1);  # block until keypressed
    push(@text,    $keey);} # append  key &&autoupd8

=head1 DESCRIPTION

Curses::Simp provides a very brief mechanism for upd8ing almost any common text console or terminal screen by using just a typical Perl array (or multiple
arrays to include aligned color or attribute codes). Most keyboard events can be obtained and tested for directly. The intended goal is ease-of-use for the
most common cases a coder of any Curses applic8ion is likely to require or desire. As many features as possible are supported in some form or another and
several utility functions are also provided to both demonstr8 Simp's capabilities and to autom8 or streamline aspects of further applic8ion development.
This module also comes packaged with several executable example applic8ions which exercise Simp features for various rel8ively standalone purposes.

=head1 WHY?

Curses::Simp was originally crE8d over 15 years ago because I could hardly find adequ8ly helpful document8ion or examples of L<Curses> usage in Perl, so I
fiddled with as many options as I could until I had learned enough to wrap the most important behaviors in names and enhanced functions which suited me
better. In hindsight, I definitely should have researched the many Open-Source Curses applic8ions that have been written in C, since they remain quite
similar and relevant to the standard Perl interface.

I also have a domin8ing penchant for extreme brevity and meticulous alignment, so this module should be pretty potent for somewhat featureful code golf.

I would also like to apologize (very bel8dly) for not adhering to the clearly sound advice on L<HTTP://PAUSe.Perl.Org> regarding the Naming of Modules.
"Simp" as a name provides no meaningful context, fails to describe key features or distinguishing characteristics of the code, and obviously origin8d from my
desire to design8 it as "Simple" (but also brief), which is the first-mentioned name to avoid. My bad! Maybe as the code matures further, this unfortun8 name
can be deprec8d in favor of something more appropri8. I do hope my early naming transgressions can be pardoned by anyone who finds the provided functionality
at least slightly useful (or maybe even just a bit amusing).

=head1 USAGE

B<new()> - Curses::Simp object constructor

new() opens a new Curses screen if one does not exist already and initializes many useful default screen, color, and key settings. The crE8d Curses screen is
automatically closed on program exit, so quite a bit of internal housekeeping at both applic8ion startup and ending can be handily ignored most of the time.

While it remains possible to just call new() to launch a fresh Curses::Simp applic8ion, please also consider the altern8 (and now preferred) way to crE8 a new
main Simp object in the section on L<"Tied Array Interfaces"> below. This new() constructor should probably only be used to crE8 additional small
(i.e., non-maximized) Curses windows which may temporarily overlay just a sub-section of the main full-screen content held in the tied arrays.

Available object methods are described in detail below. Each of the following four-letter abbreV8d or verbose method names can be used as initializ8ion
parameters to new():

   Key       or  VerboseName                 =>   Default Value
  -----         -------------                    ---------------
  'text'     or 'TextData'                   =>        [ ]
  'fclr'     or 'ForegroundColorData'        =>        [ ]
  'bclr'     or 'BackgroundColorData'        =>        [ ]
  'kque'     or 'KeyQueue'                   =>        [ ]
  'mque'     or 'KeyModQueue'                =>        [ ]
  'hite'     or 'WindowHeight'               =>         0
  'widt'     or 'WindowWidth'                =>         0
  'yoff'     or 'WindowYOffset'              =>         0
  'xoff'     or 'WindowXOffset'              =>         0
  'ycrs'     or 'CursorYOffset'              =>         0
  'xcrs'     or 'CursorXOffset'              =>         0
  'btyp'     or 'WindowBorderType'           =>         0
  'brfc'     or 'WindowBorderForegroundColor'=>        'w'
  'brbc'     or 'WindowBorderBackgroundColor'=>        'k'
  'titl'     or 'WindowTitle'                =>         ''
  'ttfc'     or 'WindowTitleForegroundColor' =>        'W'
  'ttbc'     or 'WindowTitleBackgroundColor' =>        'k'
  'dndx'     or 'DisplayStackIndex'          =>         0
  'flagaudr' or 'FlagAutoDraw'               =>         1
  'flagadtf' or 'FlagAutoDrawTiedForegroundData' =>     1
  'flagadtb' or 'FlagAutoDrawTiedBackgroundData' =>     1
  'flagmaxi' or 'FlagMaximize'               =>         1
  'flagshrk' or 'FlagShrinkToFit'            =>         1
  'flagcntr' or 'FlagCenter'                 =>         1
  'flagcvis' or 'FlagCursorVisible'          =>         0
  'flagscrl' or 'FlagScrollbar'              =>         0
  'flagsdlk' or 'FlagSDLKey'                 =>         0
  'flagfram' or 'FlagTimeFrame'              =>         0
  'flagmili' or 'FlagMillisecond'            =>         0
  'flagprin' or 'FlagPrintInto'              =>         1
  'flagclru' or 'FlagColorUsed'              =>         0

An example of setting and upd8ing 'WindowHeight':

  use        Curses::Simp;
  my $simp = Curses::Simp->new('WindowHeight' => 7 ); # set
     $simp->WindowHeight(                       15 ); # upd8

Please see the individual sections in the L<"ACCESSOR AND FLAG METHODS"> heading for more inform8ion on how to manipul8 crE8d Curses::Simp objects.

Most other Curses::Simp methods also accept hash key => value pairs as parameters, which loads the object fields the same way new() does before performing
their specified oper8ion. This gives the programmer the ability to upd8 many Simp fields within a single call to any particular accessor method. The method
name just design8s where the lone final parameter value will be assigned and which field will be returned.

=head2 Tied Array Interfaces

Curses::Simp now supports tied array interfaces as the new preferred object construction mechanism (instead of new()). This allows for much more natural and
intuitive manipul8ion of screen d8a (i.e., text, colors, and attributes) through all of the familiar oper8ions that can be performed on standard Perl arrays.
A basic example for just tying text can be found in the L<"SYNOPSIS"> section above.

Since it is not a straightforward process to tie multiple arrays to different components of the same object (which seemed most desirable for printing aligned
colors and text attributes), here is an example of how it can be done:

  use                 Curses::Simp; # good idea2use strict&&warn
            my @text;my @fclr;my @bclr; # 30-second demonstr8ion
  my $simp=tie(@text,'Curses::Simp'            ); # press keys..
           tie(@fclr,'Curses::Simp::FClr',$simp); #   ..to speed
           tie(@bclr,'Curses::Simp::BClr',$simp); #   ..up upd8s
     @text=(  '1337','nachoz','w/','cheese' x 7);$simp->GetK(2);
  push(@fclr, 'GBRG'                           );$simp->GetK(2);
  push(@fclr,        'YWOPCY'                  );$simp->GetK(2);
  push(@fclr,                 'wK'             );$simp->GetK(2);
  push(@fclr,                      'P'         );$simp->GetK(2);
  push(@bclr, 'r'                              );$simp->GetK(4);
  push(@bclr,        'g'                       );$simp->GetK(4);
  push(@bclr,                 'c'              );$simp->GetK(4);
  push(@bclr,                      'b'         );$simp->GetK(8);

Notice the three tie() lines near the top. The second and third calls must provide the third parameter of the object which they also want to tie to.
If this is not provided, the program will exit.

The result of all this is an extremely simple way to immeD8ly manipul8 any of the text or colors displayed on the console screen or within your terminal.

=head2 CnvAnsCC or ConvertAnsiColorCode( $AnsiColorCode )

Returns the Simp form of the ANSI color code $AnsiColorCode.

$AnsiColorCode may contain any of the typical ANSI attribute or color codes:

                        Attribute        codes:
  00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
                        Foreground color codes:
  30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
                        Background color codes:
  40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

ConvertAnsiColorCode() is primarily useful as an internal function to the Curses::Simp package, but it has been exposed because it could prove useful
elsewhere as well.

=head2 ShokScrn or ShockScreen( [$FlagClear] )

ShockScreen() forces the screen and all crE8d Simp objects to be refreshed in order.

The $FlagClear (default is a false 0) can be provided to specify that the entire screen is to be cleared before everything refreshes.
Clearing the entire screen usually is not necessary and it slows drawing down.

$FlagClear can be 1, 2, or 3 for increasing levels of clearing and redrawing.

=head2 KNum or KeyNumbers()

Returns a hash with key    numbers  => "names".

=head2 CLet or ColorLetters()

Returns a hash with color "letters" => numbers.

=head2 NumC or NumColors()

Returns the number of available colors          (last index: NumC() - 1). This will most likely return either 8 or 256 for modern implement8ions of Curses.

=head2 Hite or Height

Returns the current Simp object's window height (last index: Hite() - 1).

=head2 Widt or Width

Returns the current Simp object's window width  (last index: Widt() - 1).

=head2 Prnt or PrintString( $String )

Prints $String at current cursor position. PrintString() can also accept a hash of parameters (e.g., PrintString('text' => $String) ) where:

  'text' => [ "String to Print" ], # or can just be string without arrayref
  'fclr' => [ "ForegroundColorCodes corresponding to text" ],
  'bclr' => [ "BackgroundColorCodes corresponding to text" ],
  'ycrs' =>  3, # number to move the cursor's y to before printing
  'xcrs' =>  7, # number to move the cursor's x to before printing
  'yoff' => 15, # same as ycrs except original ycrs is restored afterwards
  'xoff' => 31, # same as xcrs except original xcrs is restored afterwards
  'prin' =>  1, # flag to specify whether printed text should upd8 the
                #   main Text(), FClr(), and BClr() d8a or just print to the
                #   screen temporarily. Default is true (i.e., Print Into all)

The hash keys can also be the corresponding VerboseNames described in the new() section instead of these 4-letter abbreV8d key names.

PrintString() returns the number of characters printed.

=head2 Draw or DrawWindow()

Draws the current Simp object with the established TextData() and ColorData() functions.

DrawWindow() accepts a hash of parameters like new() which will upd8 as many attributes of the Simp object as are specified by key => value pairs.

DrawWindow() returns the number of lines printed (which is normally the same as Height()).

=head2 Wait or WaitTime( $Time )

WaitTime() does nothing for $Time seconds.

$Time can be an integer or floating point number of seconds. (e.g., WaitTime(1.27) does nothing for just over one second).

WaitTime() (like GetKey()) can also use altern8 w8ing methods. The default $Time format is integer or floating seconds. It can
also instead be specified as an integer of milliseconds. This mode can be set with the FlagMillisecond(1) method.

=head2 GetK or GetKey( [$Timeout [,$FlagSDLKey]] )

Returns a key-press if one is made or -1 after waiting $Timeout seconds.

$Timeout can be an integer or floating point number of seconds. (e.g., GetKey(2.55) w8s for just over two and one-half seconds before returning -1 if no key
was pressed).

Default behavior is to not block (i.e., GetKey(0)). Use GetKey(-1) for a blocking key-press (i.e., to w8 indefinitely).

GetKey() can use altern8 w8ing methods. The default is integer or floating seconds but it can also instead utilize integer milliseconds, if preferred. This
modes can be set with the FlagMillisecond(1) method.

Under normal mode (i.e., when $FlagSDLKey is absent or false), GetKey() returns a string describing whatever key was pressed. This will either be a single
character or the Curses name for the key, if it was a special key. The list of special key names that can be returned from normal mode are described in the
L<"CURSES KEY NOTES"> section. This means that the return value should be easy to test directly like:

  use        Curses::Simp;
  my $simp = Curses::Simp->new();   # initialize a new object
  my $key  = $simp->GetKey(-1);     # get a blocking keypress
  if    (    $key  eq 'a'        ){ # do 'a'            stuff
  }elsif(    $key  eq 'b'        ){ # do 'b'            stuff
  }elsif(    $key  eq 'A'        ){ # do 'A'            stuff
  }elsif(    $key  eq 'B'        ){ # do 'B'            stuff
  }elsif(    $key  eq 'KEY_LEFT' ){ # do Left-Arrow-Key stuff
  }elsif(    $key  eq 'KEY_NPAGE'){ # do PageDown       stuff
  }elsif(    $key  eq 'KEY_F1'   ){ # do F1    (Help)   stuff
  }elsif(ord($key) ==  9         ){ # do Tab            stuff
  }elsif(ord($key) == 13         ){ # do Return         stuff
  }elsif(ord($key) == 27         ){ # do Escape         stuff
  } # note some terminals trap F1 for their own Help first

$FlagSDLKey is a flag (default is false) which tells GetKey() to return a verbose key string name from the list of SDLKeys in the L<"SDLKEY NOTES"> section
instead of the normal Curses key value or name. In SDLKey mode, GetKey() also sets flags for Shift, Control, and Alt keys which are testable through KeyMode().

The $FlagSDLKey parameter sets SDLKey mode temporarily (i.e., only for a single execution of GetKey() ). This mode can be turned on permanently via the
FlagSDLKey(1) function.

If the $Timeout for GetKey() is reached and no key-press has occurred (in either normal mode or SDLKey mode), -1 is returned.

=head2 KMod or KeyMode( [$KeyName [,$NewValue]] )

Returns the key mode (st8) of the key mode name $KeyName. $KeyName should be one of the KMOD_ names from the bottom of the L<"SDLKEY NOTES"> section.

If no parameters are provided, the st8 of KMOD_NONE is returned.

If $NewValue is provided, the st8 of $KeyName is set to $NewValue.

=head2 GetS or GetString(  [$YCursor, $XCursor[, $ResultLength]] )

GetString() returns the string found from the cursor (or the specified coordin8s) on to the end-of-line or just up to $ResultLength, if provided.

=head2 Move or MoveCursor( [$YCursor, $XCursor] )

MoveCursor() upd8s the current Simp object's cursor position to the newly specified $YCursor, $XCursor.

By default, the cursor is not visible but this can be changed through the FlagCursorVisible(1) function.

Returns ($YCursor, $XCursor) as the coordin8s of the cursor.

=head2 Rsiz or ResizeWindow( $Height, $Width )

ResizeWindow() upd8s the current Simp object's window dimensions to the newly specified $Height, $Width.

Think of ResizeWindow() as an easy way to call and upd8 or just obtain both Height() and Width() at once.

Returns ($Height, $Width) as the dimensions of the window.

=head2 Mesg or MessageWindow( $Message )

MessageWindow() draws a Message Window in the center of the screen to display $Message. MessageWindow() can also accept a hash of parameters
(e.g., MessageWindow('mesg' => $Message) ) where:

  'mesg' => "Message to Print",
  'text' => [ "same as new \@text" ],
  'fclr' => [ "ForegroundColorCodes corresponding to mesg or text" ],
  'bclr' => [ "BackgroundColorCodes corresponding to mesg or text" ],
  'titl' => "MessageWindow Title string",
  'ttfc' => "ColorCodes corresponding to titl foreground color",
  'ttbc' => "ColorCodes corresponding to titl background color",
  'flagprsk' => 1, # a flag specifying whether to "Press A Key"
  'pres' => "Press A Key...", # string to append if flagprsk is true
  'prfc' => "ColorCodes corresponding to pres foreground color",
  'prbc' => "ColorCodes corresponding to pres background color",
  'wait' => 1.0, # floating number of seconds to w8
                 #   if flagprsk is true , MessageWindow() w8s this
                 #     long for a key-press before quitting
                 #   if flagprsk is false, MessageWindow() w8s this
                 #     long, regardless of whether keys are pressed

The hash keys can also be the corresponding VerboseNames described in the new() section, instead of these 4-letter abbreV8d key names.

Returns the value of the pressed key (if the "Press A Key" flag was true). This can be used to make simple one-character prompt windows. For example:

  use          Curses::Simp;
  my $simp   = Curses::Simp->new();
  my $answer = $simp->MessageWindow('titl' => 'Is Simp useful?',
                                    'pres' => '(Yes/No)');
               $simp->MessageWindow('titl' => 'Answer:', $answer);

=head2 Prmt or PromptWindow( \$DefaultRef )

PromptWindow() draws a Prompt Window in the center of the screen to display and upd8 the value of $DefaultRef. \$DefaultRef should be
a reference to a variable containing a string you want edited or replaced. PromptWindow() can also accept a hash of parameters
(e.g., PromptWindow('dref' => \$DefaultRef) ) where:

  'dref' => \$dref, # Default Reference to variable to be read and edited
  'dtxt' => "Default Text string in place of dref",
  'dtfc' => "ColorCodes corresponding to dref/dtxt foreground color",
  'dtbc' => "ColorCodes corresponding to dref/dtxt background color",
  'hifc' => "ColorCodes for highlighted (unedited) dref/dtxt foreground color",
  'hibc' => "ColorCodes for highlighted (unedited) dref/dtxt background color",
  'text' => [ "same as new \@text" ],
  'fclr' => [ "ForegroundColorCodes corresponding to text" ],
  'bclr' => [ "BackgroundColorCodes corresponding to text" ],
  'hite' =>  3, # height of the prompt window (including borders)
  'widt' => 63, # width  of the prompt window (including borders)
  'titl' => "PromptWindow Title string",
  'ttfc' => "ColorCodes corresponding to titl foreground color",
  'ttbc' => "ColorCodes corresponding to titl background color",
  'flagcvis' => 1, # a flag specifying whether the cursor should be displayed

The hash keys can also be the corresponding VerboseNames described in the new() section, instead of these 4-letter abbreV8d key names.

=head2 CPik or ColorPickWindow()

ColorPickWindow() is a simple Color Picker window.

It accepts arrow keys to highlight a particular color and enter to select. The letter corresponding to the color or the number of the index can also be
pressed instead.

Returns the letter (i.e., Color Code) of the picked color.

=head2 Brws or BrowseWindow()

BrowseWindow() is a simple file browser.

It contains typical file browse dialog components which can be tabbed between. The tilde (~) character opens and closes drop down boxes. Enter presses
highlighted buttons or selects a highlighted file. F1 brings up the BrowseWindow() help text.

Returns the full filename chosen or -1 if dialog was canceled.

=head2 DESTROY or DelW or DeleteWindow()

DeleteWindow() deletes all the components of the crE8d Simp object and calls ShockScreen() to cause the screen (and all other crE8d objects) to be redrawn.

=head1 ACCESSOR AND FLAG METHODS

Simp accessor and flag object methods have rel8d interfaces as they each access and upd8 a single component field of Curses::Simp objects. Each one always
returns the value of the field they access. Thus, if you want to obtain a certain value from a Simp object, just call the accessor method with no parameters.
If you provide parameters, the field will be upd8d and will return its new value.

All of these methods accept a default parameter of their own type or a hash of oper8ions to perform on their field.

Some oper8ions are only applicable to a subset of the methods, as dict8d by the field type. The available oper8ions are:

   Key   =>   Value Type
    NormalName (if different) ... # Purpose
  -----      ------------
  'asin' =>  $scalar (number|string|arrayref)
   'assign' # asin is context-sensitive assignment to load the field
  'blnk' =>  $ignored         # blanks a string value
   'blank'
  'togl' =>  $ignored         # toggles    a flag value
   'toggle'
  'true' =>  $ignored         # trues      a flag value
  'fals' =>  $ignored         # falsifies  a flag value
   'false'
  'incr' =>  $numeric_amount
   'increase' # increments if no $num is provided or increases by $num
  'decr' =>  $numeric_amount
   'decrease' # decrements if no $num is provided or decreases by $num
  'nmrc' =>  $string
   'numeric'
  # instead of an explicit 'nmrc' hash key, this means the
  #   key is an entirely numeric string like '1023'
  #   so the value gets assigned to that indexed element when
  #   the field is an array. The key is assigned directly if
  #   the field is numeric or a string.
  # Array-Specific operations:
  'size' => $ignored                # return the array size
  'push' => $scalar (number|string) # push new value
  'popp' => $ignored                # pop last value
   'pop'
  'apnd' => $scalar (number|string) # append to last element
   'append'
  'dupl' => $number                 # duplicate last line or
   'duplicate'                      #   $num line if provided
  'data' => $arrayref               # assigns the array if
                                    #   $arrayref provided and
                                    #   returns ALL array data
  # Loop-Specific operations:
  'next' => $ignored          # assign to next     in loop
  'prev' => $ignored          # assign to previous in loop
   'previous'

=head2 Array Accessors

  Text or TextData            # update the text  array
  FClr or ForegroundColorData # update the color array for foregrounds
  BClr or BackgroundColorData # update the color array for backgrounds

Instead of using the above Array Accessors and Array-Specific oper8ions, it is recommended that you employ the L<"Tied Array Interfaces"> since they
accomplish the goal of screen manipul8ion in a much more Perl-friendly manner.

=head2 Loop Accessors

  BTyp or WindowBorderType # loop through border types

=head2 Normal Accessors

  Name or VerboseName                 # Description
  ----    -----------                 -------------
  Hite or WindowHeight                # window height
  Widt or WindowWidth                 # window width
  YOff or WindowYOffset               # window y-offset position
  XOff or WindowXOffset               # window x-offset position
  YCrs or CursorYOffset               # window y-cursor position
  XCrs or CursorXOffset               # window x-cursor position
  BrFC or WindowBorderForegroundColor # border fg color code string
  BrBC or WindowBorderBackgroundColor # border bg color code string
  Titl or WindowTitle                 # title string
  TtFC or WindowTitleForegroundColor  # title  fg color code string
  TtBC or WindowTitleBackgroundColor  # title  bg color code string
  DNdx or DisplayStackIndex           # global display index

=head2 Flag Accessors

  FlagName or VerboseFlagName Default # Description
  --------    --------------- ------- -------------
  FlagAuDr or FlagAutoDraw      1     # Automatic DrawWindow() call whenever
                                      #   TextData or Color*Data is updated
  FlagADTF or FlagAutoDrawTiedForegroundData 1 # Automatic DrawWindow() call
    #   for arrays tied to Curses::Simp::FClr objects when FlagAuDr is already set
  FlagADTB or FlagAutoDrawTiedBackgroundData 1 # Automatic DrawWindow() call
    #   for arrays tied to Curses::Simp::BClr objects when FlagAuDr is already set
  FlagMaxi or FlagMaximize      1     # Maximize window
  FlagShrk or FlagShrinkToFit   1     # Shrink window to fit TextData
  FlagCntr or FlagCenter        1     # Center window within entire screen
  FlagCVis or FlagCursorVisible 0     # Cursor Visible
  FlagScrl or FlagScrollbar     0     # use Scrollbars
  FlagSDLK or FlagSDLKey        0     # use advanced SDLKey mode in GetKey()
  FlagFram or FlagTimeFrame     0     # use Time::Frame objects  instead of
                                      #   float seconds for timing
  FlagMili or FlagMillisecond   0     # use integer milliseconds instead of
                                      #   float seconds for timing
  FlagPrin or FlagPrintInto     1     # PrintString() prints Into TextData
    # array.  If FlagPrintInto is false, then each call to PrintString()
    # only writes to the screen temporarily and will be wiped the next time
    # the window behind it is updated.
  FlagClrU or FlagColorUsed     0     # ColorUsed gets set automatically
    # when color codes are used and determines if internal dialogs have color

=head2 Accessor and Flag Method Usage Examples

  #!/usr/bin/perl -w
  use strict;
  use Curses::Simp;
  # create new object which gets auto-drawn with init params
  my $simp = Curses::Simp->new('text' => [ 'hmmm', 'haha', 'whoa', 'yeah' ],
                               'fclr' => [ 'kkkK', 'kKKw', 'KwrR', 'ROYW' ],
                               'btyp' => 1,
                               'maxi' => 0);
     $simp->GetK(-1);               # wait for a key press
     $simp->Text('push' => 'weee'); # add more to the Text
     $simp->FClr('push' => 'WwKk'); #             and FClr arrays
     $simp->Maxi('togl');           # toggle  the maximize flag
     $simp->GetK(-1);               # wait for a key press
     $simp->Text('2'    => 'cool'); # change index two elements of Text
     $simp->FClr('2'    => 'bBCW'); #                          and FClr
     $simp->Maxi('fals');           # falsify the maximize flag
     $simp->GetK(-1);               # wait for a key press
     $simp->Text('popp');           # pop the last elements off Text
     $simp->FClr('popp');           #                       and FClr
     $simp->BTyp('incr');           # increment the border type
     $simp->GetK(-1);               # wait for a key press
     $simp->Text('asin' => [ 'some', 'diff', 'rent', 'stuf' ]);
     $simp->FClr('asin' => [ 'GGYY', 'CCOO', 'BBRR', 'WWPP' ]);
     $simp->BTyp('incr');           # increment the border type
     $simp->GetK(-1);               # wait for a key press before quitting

=head1 CURSES KEY NOTES

When the GetKey() function is in the normal default mode of input, special key-press name strings will be returned when detected. A small set of the names
below are found commonly (like the arrow keys, the function keys, HOME, END, PPAGE [PageUp], NPAGE [PageDown], IC [Insert], and BACKSPACE) but they are all
described here since they are supported by L<Curses.pm> and therefore could arise.

The list of returnable Curses Key names are:

      KEY_F1                   KEY_F2                   KEY_F3                 
      KEY_F4                   KEY_F5                   KEY_F6                 
      KEY_F7                   KEY_F8                   KEY_F9                 
      KEY_F10                  KEY_F11                  KEY_F12                
      KEY_F13                  KEY_F14                  KEY_F15                
      KEY_A1                   KEY_A3                   KEY_B2                 
      KEY_BACKSPACE            KEY_BEG                  KEY_BREAK              
      KEY_BTAB                 KEY_C1                   KEY_C3                 
      KEY_CANCEL               KEY_CATAB                KEY_CLEAR              
      KEY_CLOSE                KEY_COMMAND              KEY_COPY               
      KEY_CREATE               KEY_CTAB                 KEY_DC                 
      KEY_DL                   KEY_DOWN                 KEY_EIC                
      KEY_END                  KEY_ENTER                KEY_EOL                
      KEY_EOS                  KEY_EXIT                 KEY_F0                 
      KEY_FIND                 KEY_HELP                 KEY_HOME               
      KEY_IC                   KEY_IL                   KEY_LEFT               
      KEY_LL                   KEY_MARK                 KEY_MAX                
      KEY_MESSAGE              KEY_MIN                  KEY_MOVE               
      KEY_NEXT                 KEY_NPAGE                KEY_OPEN               
      KEY_OPTIONS              KEY_PPAGE                KEY_PREVIOUS           
      KEY_PRINT                KEY_REDO                 KEY_REFERENCE          
      KEY_REFRESH              KEY_REPLACE              KEY_RESET              
      KEY_RESTART              KEY_RESUME               KEY_RIGHT              
      KEY_SAVE                 KEY_SBEG                 KEY_SCANCEL            
      KEY_SCOMMAND             KEY_SCOPY                KEY_SCREATE            
      KEY_SDC                  KEY_SDL                  KEY_SELECT             
      KEY_SEND                 KEY_SEOL                 KEY_SEXIT              
      KEY_SF                   KEY_SFIND                KEY_SHELP              
      KEY_SHOME                KEY_SIC                  KEY_SLEFT              
      KEY_SMESSAGE             KEY_SMOVE                KEY_SNEXT              
      KEY_SOPTIONS             KEY_SPREVIOUS            KEY_SPRINT             
      KEY_SR                   KEY_SREDO                KEY_SREPLACE           
      KEY_SRESET               KEY_SRIGHT               KEY_SRSUME             
      KEY_SSAVE                KEY_SSUSPEND             KEY_STAB               
      KEY_SUNDO                KEY_SUSPEND              KEY_UNDO               
      KEY_UP                   KEY_MOUSE                                       

=head1 SDLKEY NOTES

The GetKey() function has a special advanced mode of input. Instead of returning the plain key-press (e.g., 'a'), the $FlagSDLKey parameter can be set to true
for temporary SDLKey mode, or with FlagSDLKey(1) for permanence so that verbose strings of SDLKey names (e.g., 'SDLK_a') will be returned.

The list of returnable SDLKey names are:

   SDLKey           ASCII value    Common name
  ----------------  -----------   ------------
  'SDLK_BACKSPACE',      #'\b'    backspace
  'SDLK_TAB',            #'\t'    tab
  'SDLK_CLEAR',          #        clear
  'SDLK_RETURN',         #'\r'    return
  'SDLK_PAUSE',          #        pause
  'SDLK_ESCAPE',         #'^['    escape
  'SDLK_SPACE',          #' '     space
  'SDLK_EXCLAIM',        #'!'     exclaim
  'SDLK_QUOTEDBL',       #'"'     quotedbl
  'SDLK_HASH',           #'#'     hash
  'SDLK_DOLLAR',         #'$'     dollar
  'SDLK_AMPERSAND',      #'&'     ampersand
  'SDLK_QUOTE',          #'\''    quote
  'SDLK_LEFTPAREN',      #'('     left parenthesis
  'SDLK_RIGHTPAREN',     #')'     right parenthesis
  'SDLK_ASTERISK',       #'*'     asterisk
  'SDLK_PLUS',           #'+'     plus sign
  'SDLK_COMMA',          #','     comma
  'SDLK_MINUS',          #'-'     minus sign
  'SDLK_PERIOD',         #'.'     period
  'SDLK_SLASH',          #'/'     forward slash
  'SDLK_0',              #'0'     0
  'SDLK_1',              #'1'     1
  'SDLK_2',              #'2'     2
  'SDLK_3',              #'3'     3
  'SDLK_4',              #'4'     4
  'SDLK_5',              #'5'     5
  'SDLK_6',              #'6'     6
  'SDLK_7',              #'7'     7
  'SDLK_8',              #'8'     8
  'SDLK_9',              #'9'     9
  'SDLK_COLON',          #':'     colon
  'SDLK_SEMICOLON',      #';'     semicolon
  'SDLK_LESS',           #'<'     less-than sign
  'SDLK_EQUALS',         #'='     equals sign
  'SDLK_GREATER',        #'>'     greater-than sign
  'SDLK_QUESTION',       #'?'     question mark
  'SDLK_AT',             #'@'     at
  'SDLK_LEFTBRACKET',    #'['     left bracket
  'SDLK_BACKSLASH',      #'\'     backslash
  'SDLK_RIGHTBRACKET',   #']'     right bracket
  'SDLK_CARET',          #'^'     caret
  'SDLK_UNDERSCORE',     #'_'     underscore
  'SDLK_BACKQUOTE',      #'`'     grave
  'SDLK_TILDE',          #'~'     tilde
  'SDLK_a',              #'a'     a
  'SDLK_b',              #'b'     b
  'SDLK_c',              #'c'     c
  'SDLK_d',              #'d'     d
  'SDLK_e',              #'e'     e
  'SDLK_f',              #'f'     f
  'SDLK_g',              #'g'     g
  'SDLK_h',              #'h'     h
  'SDLK_i',              #'i'     i
  'SDLK_j',              #'j'     j
  'SDLK_k',              #'k'     k
  'SDLK_l',              #'l'     l
  'SDLK_m',              #'m'     m
  'SDLK_n',              #'n'     n
  'SDLK_o',              #'o'     o
  'SDLK_p',              #'p'     p
  'SDLK_q',              #'q'     q
  'SDLK_r',              #'r'     r
  'SDLK_s',              #'s'     s
  'SDLK_t',              #'t'     t
  'SDLK_u',              #'u'     u
  'SDLK_v',              #'v'     v
  'SDLK_w',              #'w'     w
  'SDLK_x',              #'x'     x
  'SDLK_y',              #'y'     y
  'SDLK_z',              #'z'     z
  'SDLK_DELETE',         #'^?'    delete
  'SDLK_UP',             #        up arrow
  'SDLK_DOWN',           #        down arrow
  'SDLK_RIGHT',          #        right arrow
  'SDLK_LEFT',           #        left arrow
  'SDLK_INSERT',         #        insert
  'SDLK_HOME',           #        home
  'SDLK_END',            #        end
  'SDLK_PAGEUP',         #        page up
  'SDLK_PAGEDOWN',       #        page down
  'SDLK_F1',             #        F1
  'SDLK_F2',             #        F2
  'SDLK_F3',             #        F3
  'SDLK_F4',             #        F4
  'SDLK_F5',             #        F5
  'SDLK_F6',             #        F6
  'SDLK_F7',             #        F7
  'SDLK_F8',             #        F8
  'SDLK_F9',             #        F9
  'SDLK_F10',            #        F10
  'SDLK_F11',            #        F11
  'SDLK_F12',            #        F12
  'SDLK_F13',            #        F13
  'SDLK_F14',            #        F14
  'SDLK_F15',            #        F15
  # SDLKeys below aren't detected correctly yet
  'SDLK_KP0',            #        keypad 0
  'SDLK_KP1',            #        keypad 1
  'SDLK_KP2',            #        keypad 2
  'SDLK_KP3',            #        keypad 3
  'SDLK_KP4',            #        keypad 4
  'SDLK_KP5',            #        keypad 5
  'SDLK_KP6',            #        keypad 6
  'SDLK_KP7',            #        keypad 7
  'SDLK_KP8',            #        keypad 8
  'SDLK_KP9',            #        keypad 9
  'SDLK_KP_PERIOD',      #'.'     keypad period
  'SDLK_KP_DIVIDE',      #'/'     keypad divide
  'SDLK_KP_MULTIPLY',    #'*'     keypad multiply
  'SDLK_KP_MINUS',       #'-'     keypad minus
  'SDLK_KP_PLUS',        #'+'     keypad plus
  'SDLK_KP_ENTER',       #'\r'    keypad enter
  'SDLK_KP_EQUALS',      #'='     keypad equals
  'SDLK_NUMLOCK',        #        numlock
  'SDLK_CAPSLOCK',       #        capslock
  'SDLK_SCROLLOCK',      #        scrollock
  'SDLK_RSHIFT',         #        right shift
  'SDLK_LSHIFT',         #        left shift
  'SDLK_RCTRL',          #        right ctrl
  'SDLK_LCTRL',          #        left ctrl
  'SDLK_RALT',           #        right alt
  'SDLK_LALT',           #        left alt
  'SDLK_RMETA',          #        right meta
  'SDLK_LMETA',          #        left meta
  'SDLK_LSUPER',         #        left windows key
  'SDLK_RSUPER',         #        right windows key
  'SDLK_MODE',           #        mode shift
  'SDLK_HELP',           #        help
  'SDLK_PRINT',          #        print-screen
  'SDLK_SYSREQ',         #        SysRq
  'SDLK_BREAK',          #        break
  'SDLK_MENU',           #        menu
  'SDLK_POWER',          #        power
  'SDLK_EURO',           #        euro

SDLKey mode also sets flags in KeyMode() where:

   SDL Modifier                    Meaning
  --------------                  ---------
  'KMOD_NONE',           #        No modifiers applicable
  'KMOD_CTRL',           #        A  Control key is down
  'KMOD_SHIFT',          #        A  Shift   key is down
  'KMOD_ALT',            #        An Alt     key is down

=head1 COLOR NOTES

Colors can be encoded along with each text line to be printed. PrintString() and DrawWindow() each take hash parameters where the key should be one of:

  'fclr' or 'ForegroundColorData'
  'bclr' or 'BackgroundColorData'

and the value is a color code string as described below.

A normal color code is simply a single character (typically just the first letter of the color name and the case [upper or lower] design8s high or low
intensity [i.e., Bold on or off]). The default printing mode of color codes assumes black (or actually ncurses -1) background colors for everything when no
'ColorBackgroundData' is supplied.

There were some scarce times many years back where Bold was misbehaving and the correct value of A_BOLD (from my personal implement8ion of Curses) needed to be
hardcoded. Thankfully this has not been the case for quite a while, but be warned that it may potentially fail again due to it returning the incorrect number
of the A_BOLD attribute. I never quite figured out exactly why it stopped working for a while, so I'm wary that the troubling issue could resurface somehow.

=head2 Normal Color Code Reference

   (lower-case = dark  )  k(blacK)  r(Red    )  g(Green)  y(Yellow)
   (upper-case = bright)  b(Blue )  m(Magenta)  c(Cyan )  w(White )

=head2 Alternate Color Codes

   (lower-case = dark  )                        o([Orange]  Yellow)
   (upper-case = bright)  p([Purple]  Magenta)

=head2 Case-Determines-Brightness Exceptions

There are two special exceptions to the Case-Determines-Brightness rule. Orange is actually Dark Yellow but it is often expected to be much brighter than any
of the other dark colors. Therefore, Upper-Case 'O' breaks the "lower-case = dark, upper-case = bright" rule and is interpreted as simply an alias to
Lower-Case 'y' when only 8 colors are supported. Similarly 'P' may map to dark magenta with a Lower-Case 'm'. When only 8 colors are supported,
Lower-Case 'o' and 'p' are the same as 'O' and 'P' (which are in turn the same as darks 'y' and 'm'). All other colors remain consistent with the rule.

=head1 TODO

=over 2

=item - replace all old clet with new p622

=item - tst new extra FClr code '^' for getting actual normal instead of whatever default 'w' or 'G' that usually isn't the same color green

=item - remove all 4NT code since it cannot be tested anymore and get rid of tests for $curs since it is now the only option

=item - remove Math::BaseCnv and probably all Time::(PT|Frame) referencez

=item - consider removing or simplifying MkMethodz and s/Flag//gi (just comment and document which are mere flagz)

=item - fix CnvAnsCC to be much like `c` and maybe include a form of `S` as new CnvCCAns

=item - consider upd8ing or replacing ShokScrn with just new Cler()

=item - add constructor options for not initializing whatever should be selectable like raw, cbreak, etc. (or mk new runtime flagz for what can chng aftr init)

=item - tst and support as much UTF-8 as possible

=item - maybe benchmark and rewrite Draw and Prnt to be faster and hopefully simpler, while still handling as many special charz as possible

=item - fix tied arrayz to TestDraw at least only modified linez (and maybe also just temp Prnt [restoring cursor loc8ion aftr] small parts from substr callz)

=item - make new COLOR_PAIR alloc8ion modez for tracking most frequently used per-character, per-pair-change, and maybe upd8 replaced pairz to have some sort
  of minimal RGB distance to the closest still existing pair probably starting with just closest bkgr and same foregrnd (unless reversed)

=item - also expose some pair management routinez in case some more special mechanism needz to be used to minimize color clobber (esp. for l8r CPik windowz)

=item - import `tsgr` map in prepR8ion for new attr array

=item - make new tied array TAtr as a TextAttributez LUT for any char in a new GLBL remappable hash that containz valuez of 1 or more SGR codez to support all
  the modez Curses can, as well as all 256 colorz (overriding any of the main 64 specified in FClr or BClr and adding any newly needed COLOR_PAIR)

=item - tst mkng methodz (all but GetK?) retn obj like Term::Screen so they can chain too (and maybe add at() [or mv], clrscr() [cs], clreol() [cl],
  clreos() [ce], insline() [il], delline() [dl], inschar() [ic], delchar() [dc], [id]c_exists() as just true, cur(in)?vis() alias CVis(), etc. to support
  similar syntax, but note that 'clr\w{3}()' function namez as various 'clear' will likely be confusing since Simp is entrenched in using '\wclr' to mean
  'color' instead)

=item - maybe also support normal(), bold(), and reverse() (remember to call CORE::reverse then for standard Perl srvr function) as flagged modez for Prnt

=item - make new prioritized 1 and 2 letter aliasez to all the major methodz for even better golfing opportunitiez (that will likely be less memorable though)

=item - audit remaining code (maybe make nice new CPik and fix Mesg to detect and color my typical help or info windowz and to have functional borderz again)

=item - consider scrapping Brws or improving it and adding at least all `dircolors -p` to DFLTMAPP as well as any other most useful extensionz or just read
  LS_COLORS and fix BrowserHelp to not just be on F1 since WindowManager or terminal program may trap it before it can reach the applic8ion

=item - mk CPik work for predictable 16, 64, or 256 color modez in at least 160x50, 80x24, and 40x12 modez (as well as upd8ing p622 mapping and maybe even a
  new 2pal8 .pal8 file editor)

=item - mk APik to select and upd8 GLBL LUT for any TextAttributez that can be supported

=item - write new better unit tests patterned after Term::Screen, Curses itself, and any other similar modulez I can find

=item - revamp all POD (especially document new stuff like 64-to-256 color and extended TextAttribute support)

=item - fix up all bin/ applic8ionz that deserve package inclusion and make most able to handle term resizing btwn 160x50<->80x24 and Ctrl-[CZS] gracefully

=item - prepare new package and test as thoroughly as possible before releasing to the CPAN


=item - mk proper scrollbars for all objects and use in Brws: view

=item - Brws: mk togl to pack files left and right in view

=item - mk ~/.simprc to save CPik and Brws cfg, OVERMAPP, etc.

=item - CPik: rewrite BildBlox to scale style to window dims if !flagshrk
          and mk sure no forg or bakg works for all styles... also add
          options for only name or number options or common grid size defaults

=item - CPik: add styles to pick fgcl,bgcl color code at once

=item - 4NT: work on recognizing more keys the same as Curses (and then SDL)

=item - 4NT: write custom window support? mk Mesg at least wrap MSGBOX

=item - describe Simp objects sharing apps (ptok above pmix)
          mk OScr read Simp apps @_ param list and auto-handle --geom wxh+x+y

=item - Prmt: mk new 'cbls' type: as a ckbx list and use in BrwsCnfg

=item - Prmt: mk new 'rdls' type: as a radio list w/ auto (*) -

=item - Mesg: mk new 'slid' type: params for all overlay text, chars, ticks,
          flags, etc. and updt pmix to use... maybe register sub fields,dims...

=item - Prnt: add multi-line option where text can split on /\n/ but each new
          line prints relative to starting xcrs

=item - Prmt: add multi-line option where dtxt can split on /\n/ and ^d
          accepts entry instead of RETURN

=item - Prnt: handle ASCII chars under 32 with escapes like Draw

=item - Draw: optimize rendering

=item - Prnt and Draw: handle ASCII chars under 32 better than current escapes

=item - mk 'ceol' and 'ceos' params to clear text[n] from cursor on

=item - consider breaking sub (CPik|Brws|.+?) into own Curses::Simp::$1.pm
          instead of letting Simp.pm remain so cluttered

=back

        if detectable:

=over 4

=item - handle xterm resize events

=item - handle mouse input (study any existent Curses apps that use mouse input you can find ... probably in C), read man for gpm(1), sysmouse(4), and sb(4)
  and study aumix mouse source

=item - Learn how to read a Shift-Tab key press if in any way distinguishable from normal unshifted Tab/Ctrl-I

=item -    What else does Simp need?

=back

=head1 CHANGES

Revision history for Perl extension Curses::Simp:

=over 4

=item - 1.6

* changed VERSION to simple float and replaced old PT with sepR8 d8VS

* fixed InitPair to handle recent 256-color Curses and added 8pal8 color map

=item - 1.4.A8UG1gG  Mon Aug 30 16:01:42:16 2010

* Brws: setup to read $ENV{'LS_COLORS'} into GLBL{OVERMAPP}

* fixed POD error that was failing on FreeBSD because items must follow overs

* tested ACS_ borders working again, restored as dfalt, added new ARROW bordset

* fixed Prmt handle Eterm BACKSPACE (ord(127)) like TTY (without ndng Ctrl-BS)

* fixed FlagCVis (MkMethodz CRSR flag was accidentally set as CURS)

* updated license to GPLv3 and bumped minor version for the CPAN

=item - 1.2.A7DDCh3  Tue Jul 13 13:12:43:03 2010

* made B == Blue and K == blacK like RGB vs. CMYK

* added ColorUsed '_flagclru' tracking and test for internal dialogs

* fixed up Mesg() for no press key option to force window to stay for wait
    and auto header color gen for my help and info pages

* added flags to auto-draw tied @_fclr (FlagADTF) and @_bclr (FlagADTB)

* added optional length param to GetS

* added basic 4NT support by generating C:/SimpDraw.bat

* added Tie::Array interfaces for @_text, @_fclr, and @_bclr

* removed repeats and color code expansion and added @_bclr

* updated License

* added GetS() since Dan asked how

=item - 1.0.4287FJQ  Sun Feb  8 07:15:19:26 2004

* made Brws()

* added ckbx and butn types to Mesg() and drop type to Prmt() and wrote Focu()
    to focus new types

* added info and help types to Mesg() to auto title and color those screens

* added blox and squr styles to CPik and made style/blockchar increment
    keys (PgUp/Dn/Home/End)

=item - 1.0.41V0L3a  Sat Jan 31 00:21:03:36 2004

* made flag accessors without ^Flag

* wrote support for VerboseName hash keys

* fixed ShokScrn overlap and DelW bugs

* made GetK return detected KEY_ names in normal mode and added CURSES
    KEY MODE section to POD and made both key modes return -1 if $tmot reached

* made ShokScrn not blank the screen so often

* made Text('1' => 'new line') use Prnt instead of Draw for efficiency

* updated POD to use VerboseNames instead of 4-letter names and replaced most '&&'

* made verbose accessor names like VerboseName instead of verbose_name

=item - 1.0.41O4516  Sat Jan 24 04:05:01:06 2004

* made all but ptok and qbix non-executable for EXE_FILES

* updated POD and added Simp projects into bin/ and MANIFEST in preparation
    for release

=item - 1.0.41O3SQK  Sat Jan 24 03:28:26:20 2004

* fixed weird char probs in Draw and removed weird char support from Prnt

* added PrintInto '_flagprin' ability

* made new Mesg, Prmt, and CPik utils

* added SDLK advanced input option to GetK

* setup window border char sets

=item - 1.0.4140asO  Sun Jan  4 00:36:54:24 2004

* refined Draw() and InitPair() for objects instead of exported procedures

* CHANGES section and new objects created

=item - 1.0.37VG26k  Thu Jul 31 16:02:06:46 2003

* original version

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install Curses::Simp"`

or uncompress the package and run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 FILES

Curses::Simp requires:

=over 4

=item L<Curses>        - provides core screen and input handling

=item L<Tie::Array>    - allow text arrays to be bound to objects

=back

=head1 BUGS

Please report any bugs or feature requests to   bug-Curses-Simp       at RT.CPAN.Org, or through the web interface at
  L<HTTPS://RT.CPAN.Org/NoAuth/ReportBug.html?Queue=Curses-Simp>.     I will be notified, and then you can be updated of progress on your bug
  as I address fixes.

=head1 SUPPORT

You can find documentation for this module (after it is installed) with the perldoc command.

  `perldoc Curses::Simp`

You can also look for information at:

    RT: CPAN's Request Tracker

  HTTPS://RT.CPAN.Org/NoAuth/Bugs.html?Dist=Curses-Simp

    AnnoCPAN: Annotated CPAN documentation

  HTTP://AnnoCPAN.Org/dist/Curses-Simp

    CPAN Ratings

  HTTPS://CPANRatings.Perl.Org/d/Curses-Simp

    Search CPAN

  HTTP://Search.CPAN.Org/dist/Curses-Simp

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2002-2017, Pip Stuart.
Copyleft :  This software is licensed under the  GNU General Public License
  (version 3 or later). Please consult L<HTTPS://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTPS://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
