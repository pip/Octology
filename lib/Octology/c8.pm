# E7TMAYX4: Octology::c8.pm by PipStuart <Pip@CPAN.Org> to provide a compatibility applic8ion interface to Curses and a powerful new text-mode through SDL;
package     Octology::c8;
use strict; use warnings;use utf8;use v5.10;
#equire     Exporter;
#se base qw(Exporter);
use         Octology::a8;
use         Octology::b8;
use         Octology::d8;
use         Octology::f8;
use         Tie::Array; # might be better to use Getopt::Long::Descriptive?
use         Getopt::Long qw(GetOptionsFromArray :config bundling pass_through);#Getopt::Long::Configure('bundling','pass_through');
my $curs = 0;#eval('use Curses;8') || 0;
my $ucsf = 0;#l('use Curses::Simp;8'); # disable Simp && just use SDL as primary default renderer or s/0;#/eva/ to test further
my $sdlf = 8; # set to 0 to ignore SDL but for now will need at least one of Simp or SDL to render through
if($sdlf){    # if neither ucsf or sdlf are set, should eventually just dump ANSI text to console && maybe get input from <STDIN> or ReadLine or just quit out?
use SDL;          # originally tried to eval all use SDL lines here hoping to just fallback on Simp if any needed SDL module could not be loaded but..
use SDL::Video;   #  ..critical constants wouldn't export properly into the local namespc when eval'd so it seems SDL is mostly required now rather than opt
use SDL::Event;
use SDL::Events;
use SDL::Joystick;
use SDL::GFX::Rotozoom;
use SDLx::App;
#se SDLx::Text; # also learn TTF && Pango, probably don't need SFont
use SDLx::Sprite;} $sdlf = 0 if(exists($ENV{'TTY'}) && $ENV{'TTY'}=~ /^\/dev\/tty/); # disAbl SDL whN in fullscrn tXt-mOde acordng2 $TTY (or try `tty`?)
#ur @EXPORT=  qw(); # mvd only orig Xportz sube && e2c8 over2 a8.pm (&& since renamed e to S for SKp consistency)
our $VERSION='0.0';my $d8VS='G7BMGDIU';our $auth='PipStuart <Pip@CPAN.Org>';my $name='c8';
my %GLBL=( # GLOBAL CLASS VARIABLES
  'FLAGOPEN'=> 0); # flag for if SDL window crE8d yet (in Simp was for if a main curses screen had been opened yet)
#y @DISPSTAK=(); # global stack of crE8d c8 objects for display order
my @KMODNAMZ=( # in advanced input mode, these KMOD modifier names get set within the c8 object's '_kmod' hash after each GetK()
#  SDL Modifier        Meaning
  'KMOD_NONE',     #  No  modifiers applicable
# I don't think I can detect locks or left/right with Curses so these were originally commented in Simp, but since c8 intends to support both Curses && SDL,
#   I will likely need to add a new separ8 list of just which are unavailable to Curses.
  'KMOD_NUM',      #   Numlock      key is down
  'KMOD_CAPS',     #  Capslock      key is down
  'KMOD_LCTRL',    #  Left  Control key is down
  'KMOD_RCTRL',    #  Right Control key is down
  'KMOD_LSHIFT',   #  Left  Shift   key is down
  'KMOD_RSHIFT',   #  Right Shift   key is down
  'KMOD_LALT',     #  Left  Alt     key is down
  'KMOD_RALT',     #  Right Alt     key is down
  'KMOD_CTRL',     #     A  Control key is down
  'KMOD_SHIFT',    #     A  Shift   key is down
  'KMOD_ALT',);    #     An Alt     key is down
my @knmz=(qw(No NL CL LC RC LS RS LA RA Ct Sh Al)); # V8s for KMOD
#y @bnmz=(qw(Tr Ci Ex Sq L1 R1 L2 R2 Se St L3 R3 Up Rt Dn Lt)); #if($jnam eq 'ZEROPLUS PS(R) Gamepad Adaptor')
my @tFbf=(qw(text Fclr bclr f0nt)); # V8s for main col8 layers, probably next 4 to add: pal8 slct grfc rndt, should load from a8:Hrc && have %col8 && s/^/_/?
#y $sxap;my $sfss;my $evnt;my $jstk;my $jnam;my $nbtz;my $fsof=0; # SdlXAPplic8ion, SdlFullScreenSurface, EVeNT, JoySTicK, JoyNAMe, joyNumBuTnZ,FulScrnOptnFlag
my   @_attrnamz=();         my %_attrdata=(); # ordered attribute names array, default attribute d8a hash
                    my %_verbose_attrnamz=(); # object field d8a
#ush(@_attrnamz, '_wind'    ); $_attrdata{$_attrnamz[-1]} =  0; # CursesWindowHandle
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowHandle';
#ush(@_attrnamz, '_sxap'    ); $_attrdata{$_attrnamz[-1]} =  0;        # SDL main objectz reloc8d from c8 object fldz here to %GLBL 4 sharing but maybe
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLxApp'; #   should return to allow multi-windowz?
#ush(@_attrnamz, '_sfss'    ); $_attrdata{$_attrnamz[-1]} =  0;
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLFullScreenSurface';
#ush(@_attrnamz, '_xfss'    ); $_attrdata{$_attrnamz[-1]} =  0;
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLxFullScreenSurface';
#ush(@_attrnamz, '_evnt'    ); $_attrdata{$_attrnamz[-1]} =  0;
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLEvent';
#ush(@_attrnamz, '_jstk'    ); $_attrdata{$_attrnamz[-1]} =  0;
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLJoystick';
#ush(@_attrnamz, '_jnam'    ); $_attrdata{$_attrnamz[-1]} = '';
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLJoystickName';
#ush(@_attrnamz, '_nbtz'    ); $_attrdata{$_attrnamz[-1]} =  0;
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLJoystickNumButtons'; # note:SDLFullScreenOptionFlag is also SDL down in _flag* section
#ush(@_attrnamz, '_f8om'    ); $_attrdata{$_attrnamz[-1]} = {}; # f8  f0nt   Object Map hash  #y %f0nt;my %sprm =();    # f0ntz also reloc8d to %GLBL 4 sharing
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'f8f0ntObjectMap';
#ush(@_attrnamz, '_sprm'    ); $_attrdata{$_attrnamz[-1]} = {}; # SDL SPRite object Map hash
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'SpriteMap';
push(@_attrnamz, '_Stxt'    ); $_attrdata{$_attrnamz[-1]} = ''; # eScape TeXT     d8a   (did s/e/S/ hEr && in other c8 object filter scripts for consistency)
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'EscapeTextD8a';
push(@_attrnamz, '_text'    ); $_attrdata{$_attrnamz[-1]} = []; #        text     d8a
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'TextD8a';
push(@_attrnamz, '_Fclr'    ); $_attrdata{$_attrnamz[-1]} = []; #        Fg CoLoR d8a   (did s/f/F/ hEr && abov in tFbf && in .Hrc 4mor cnsistNt lAyr sepR8ion)
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'ForegroundColorD8a';
push(@_attrnamz, '_bclr'    ); $_attrdata{$_attrnamz[-1]} = []; #        Bg CoLoR d8a
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'BackgroundColorD8a';
push(@_attrnamz, '_f0nt'    ); $_attrdata{$_attrnamz[-1]} = []; #        f0nt  V8 d8a
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'F0ntAbbreV8ionD8a';
push(@_attrnamz, '_kque'    ); $_attrdata{$_attrnamz[-1]} = []; # Key     QUEue
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'KeyQueue';
push(@_attrnamz, '_mque'    ); $_attrdata{$_attrnamz[-1]} = []; # key Mod QUEue
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'KeyModQueue';
#y $xscl=1.0;my $widt=160;if(exists($ENV{'COLUMNS'})){$widt=$ENV{'COLUMNS'};} # SDL X && Y SCaLes rel8ive to inherited text dimensions * 8x16
#y $yscl=1.0;my $hite= 50;if(exists($ENV{'LINES'}  )){$hite=$ENV{'LINES'}  ;} # default 160x50 => 1280x800
#($ucsf,$widt,$hite,$xscl,$yscl)=(0,80,25,2,2); # quick way to    double pixel scale for 80x25 => 1280x800 similar to SVGA && below Mode13
#($ucsf,$widt,$hite,$xscl,$yscl)=(0,40,12,4,4); # quick way to quadruple pixel scale for 40x12 => 1280x768 nd2allow 12.5 charz4last 32 pixel lines
#$xscl =         0.93;
#        $yscl = 0.88; # these uneven scales fit Chun's 1280x800 screen in non-fullscreen windowed-mode pretty well
#$xscl = $yscl = 1.2 if(exists($ENV{'HOSTNAME'}) && length($ENV{'HOSTNAME'}) < 4); # shorter HOST means larger resolution available
#($ucsf,$widt,$hite,$xscl,$yscl)=(0,80,25,2.4,2.4);
push(@_attrnamz, '_hite'    ); $_attrdata{$_attrnamz[-1]} = 50; # window  HeIghT (should maybe get set to $ENV{  'LINES'})
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowHeight';
push(@_attrnamz, '_widt'    ); $_attrdata{$_attrnamz[-1]} =160; # window   WIDTh (should maybe get set to $ENV{'COLUMNS'})
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowWidth';
push(@_attrnamz, '_yscl'    ); $_attrdata{$_attrnamz[-1]} =1.0; # window Y-SCaLe
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowYScale';
push(@_attrnamz, '_xscl'    ); $_attrdata{$_attrnamz[-1]} =1.0; # window X-SCaLe
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowXScale';
push(@_attrnamz, '_yoff'    ); $_attrdata{$_attrnamz[-1]} =  0; # window Y-OFFset
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowYOffset';
push(@_attrnamz, '_xoff'    ); $_attrdata{$_attrnamz[-1]} =  0; # window X-OFFset
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowXOffset';
push(@_attrnamz, '_ycrs'    ); $_attrdata{$_attrnamz[-1]} =  0; # CuRSor Y-offset
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'CursorYOffset';
push(@_attrnamz, '_xcrs'    ); $_attrdata{$_attrnamz[-1]} =  0; # CuRSor X-offset
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'CursorXOffset';
push(@_attrnamz, '_btyp'    ); $_attrdata{$_attrnamz[-1]} =  0; #  Border TYPe
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderType';
push(@_attrnamz, '_brfc'    ); $_attrdata{$_attrnamz[-1]} = 'w';#  BoRder Fore     Color
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderForegroundColor';
push(@_attrnamz, '_brbc'    ); $_attrdata{$_attrnamz[-1]} = 'k';#  BoRder Back     Color
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowBorderBackgroundColor';
push(@_attrnamz, '_titl'    ); $_attrdata{$_attrnamz[-1]} = ''; # window TITLe
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitle';
push(@_attrnamz, '_ttfc'    ); $_attrdata{$_attrnamz[-1]} = 'W';#  TiTle Fore     Color
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitleForegroundColor';
push(@_attrnamz, '_ttbc'    ); $_attrdata{$_attrnamz[-1]} = 'W';#  TiTle Back     Color
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'WindowTitleBackgroundColor';
#ush(@_attrnamz, '_dndx'    ); $_attrdata{$_attrnamz[-1]} = 0;  # DISPSTAK index
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'DisplayStackIndex';
push(@_attrnamz, '_tsbd'    ); $_attrdata{$_attrnamz[-1]} = {}; # Terminal Scroll Back    D8a
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'TerminalScrollBackD8a';
push(@_attrnamz, '_tsfd'    ); $_attrdata{$_attrnamz[-1]} = {}; # Terminal Scroll Forward D8a
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'TerminalScrollForwardD8a';
push(@_attrnamz, '_flnm'    ); $_attrdata{$_attrnamz[-1]} = ''; # FiLeNaMe
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FileName';
push(@_attrnamz, '_cmds'    ); $_attrdata{$_attrnamz[-1]} = ''; # CoMmanD         String
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'CommandString';
push(@_attrnamz, '_cmdd'    ); $_attrdata{$_attrnamz[-1]} = ''; # CoMmanD Default string
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'CommandDefaultString';
# Flags, storage Values, && extended attributes
push(@_attrnamz, '_flagfsof'); $_attrdata{$_attrnamz[-1]} = 0;
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'SDLFullScreenOptionFlag';
push(@_attrnamz, '_flagmnsb'); $_attrdata{$_attrnamz[-1]} = 1; # MiNiScrollBar
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMiniScrollBar';
push(@_attrnamz, '_flagmsxw'); $_attrdata{$_attrnamz[-1]} = 0; # MiniScrollbar eXtendsWide  # 0 should be inlaid
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMiniScrollbarExtendsWide';
push(@_attrnamz, '_flagovdr'); $_attrdata{$_attrnamz[-1]} = 1; # OVerDRaw
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagOverDraw';
push(@_attrnamz, '_flagodba'); $_attrdata{$_attrnamz[-1]} = 0; # OverDrawBinaryAlignment
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagOverDrawBinaryAlignment';
push(@_attrnamz, '_flagaudr'); $_attrdata{$_attrnamz[-1]} = 1; # AUtoDRaw
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDraw';
push(@_attrnamz, '_flagadtf'); $_attrdata{$_attrnamz[-1]} = 1; # ADTiedFg
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDrawTiedForegroundD8a';
push(@_attrnamz, '_flagadtb'); $_attrdata{$_attrnamz[-1]} = 1; # ADTiedBg
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDrawTiedBackgroundD8a';
push(@_attrnamz, '_flagadtn'); $_attrdata{$_attrnamz[-1]} = 1; # ADTiedf0Nt
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagAutoDrawTiedF0ntD8a';
#ush(@_attrnamz, '_flagmaxi'); $_attrdata{$_attrnamz[-1]} = 1; # Maximize
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMaximize';
#ush(@_attrnamz, '_flagshrk'); $_attrdata{$_attrnamz[-1]} = 1; # ShrinkToFit
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagShrinkToFit';
#ush(@_attrnamz, '_flagcntr'); $_attrdata{$_attrnamz[-1]} = 1; # Center
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagCenter';
push(@_attrnamz, '_flagcvis'); $_attrdata{$_attrnamz[-1]} = 0; # CursorVisible
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagCursorVisible';
#ush(@_attrnamz, '_flagscrl'); $_attrdata{$_attrnamz[-1]} = 0; # Scrollbar
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagScrollbar';
#ush(@_attrnamz, '_flagsdlk'); $_attrdata{$_attrnamz[-1]} = 0; # SDLK
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagSDLKey';
#ush(@_attrnamz, '_flagfram'); $_attrdata{$_attrnamz[-1]} = 0; # Time::Frame  maybe should upd8 this to offer d8::dur8 delay format
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagTimeFrame';
push(@_attrnamz, '_flagmili'); $_attrdata{$_attrnamz[-1]} = 1; # millisecond  ms seems to be default for both SDL && Curses, so 4 c8 now but l8r float secs 2
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagMillisecond';
#ush(@_attrnamz, '_flagprin'); $_attrdata{$_attrnamz[-1]} = 1; # Prnt into self
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagPrintInto';
push(@_attrnamz, '_flagclru'); $_attrdata{$_attrnamz[-1]} = 0; # ColorUsed?
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagColorUsed';
push(@_attrnamz, '_flagf0nu'); $_attrdata{$_attrnamz[-1]} = 0; # F0ntUsed?
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagF0ntUsed';
push(@_attrnamz, '_flaginsr'); $_attrdata{$_attrnamz[-1]} = 1; # InsertMode
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagInsertMode';
push(@_attrnamz, '_flagterm'); $_attrdata{$_attrnamz[-1]} = 0; # TerminalMode && might also l8r try (scrn|H8sh|viii)Modes to nest distinct types of c8 objects
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagTerminalMode';
push(@_attrnamz, '_flagfile'); $_attrdata{$_attrnamz[-1]} = 0; # FileMode to just popul8 a basic c8 object from disk file d8a then do oper8ionz wi transl8ionz
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagFileMode'; # this relies on a readable file             to be named in '_flnm'
push(@_attrnamz, '_flagcmnd'); $_attrdata{$_attrnamz[-1]} = 0; # CommandMode to encapsul8 the output of executing commandz specified in '_cmds' then oper8 on
                       $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagCommandMode'; # && probably also want this profile mode to generalize piping from STDIN
#ush(@_attrnamz, '_flagdrop'); $_attrdata{$_attrnamz[-1]} = 0; # DropDown
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagDropDown';
#ush(@_attrnamz, '_flagdown'); $_attrdata{$_attrnamz[-1]} = 0; # DropIsDown
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'FlagDropIsDown';
#ush(@_attrnamz, '_valulasp'); $_attrdata{$_attrnamz[-1]} = undef; # last pair
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'LastPair';
#ush(@_attrnamz, '_valullsp'); $_attrdata{$_attrnamz[-1]} = undef; # llastpair
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'LastLastPair';
#ush(@_attrnamz, '_valulasb'); $_attrdata{$_attrnamz[-1]} = undef; # last bold
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'LastBold';
#ush(@_attrnamz, '_valullsb'); $_attrdata{$_attrnamz[-1]} = undef; # llastbold
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'LastLastBold';
#ush(@_attrnamz, '_valudol8'); $_attrdata{$_attrnamz[-1]} = undef; # do late
#                      $_verbose_attrnamz{$_attrnamz[-1]} = 'LateEscapedPrint';
# methods
sub AttrNamz{return( @_attrnamz);} # attribute names
sub DfltValu{my($self,$attr)=@_;return($_attrdata{$attr}) if(defined($attr) && length($attr) && exists($_attrdata{$attr}));}
sub L8rc{my $self=shift;my $rcfn=shift;my @rcfd;my $scmd; # Load8TrmResources file,ResourCe FileName,D8a,ShellCoMmanD  # EvN2Ly want2suport all useful optz too
  # if then else below && functions require cmd tree beyond $scmd && is definitely needed to conditionally export && alias only the desired values && funcs
  # this is getting called on each new('term'=>1) && upd8ing %GLBL values for all terms. better to preserve token spaces && cmntz to reconstruct .rc 2diff
  unless(defined($rcfn) && -r $rcfn){$rcfn = '/home/' . $ENV{'USER'} . '/.zshrc' ;} # default to ~/.zshrc until .8rc becomes warranted
  unless(defined($rcfn) && -r $rcfn){$rcfn = '/home/' . $ENV{'USER'} . '/.bashrc';} # && fallback on bash or forget it (although maybe [ck]?sh && cmd wudBgud2)
  if    (defined($rcfn) && -r $rcfn){open(SHRC,'<',$rcfn);@rcfd=<SHRC>;close(SHRC);my $tokn;my $cntf=0; # lOd ResrCzFileD8a2pRs in2 %GLBL _(alis|func) 4cmdXpnd
    for(@rcfd){ # the use of escaped quotes or continU8ions has not been tested
      while     (s/^\s*(\S+)//){if($cntf){$tokn.=$1;}else{$tokn=$1;} # line starts with non-comment non-space TOKeN which might be a Shell CoMmanD to process
        if      ($tokn =~ /^#/ ){s/.*//;$scmd=undef; # strip comments && end cmd
        }elsif  ($tokn =~ /^;/ ){       $scmd=undef; #       semicolon   end cmd
        #elsif  ($tokn =~ /^((un)?setopt|if|then|else|elif|fi|export|alias|zstyle|autoload|echo|eval|ulimit|typeset|bindkey)$/){$scmd=$tokn;print"scmd:$scmd:";
        }elsif  ($tokn =~ /^((un)?setopt|export|alis)$/){$scmd=$tokn;#rint "scmd:$scmd:"; # also allow local variables to be set without export like dircolrz=
        }elsif  (defined($scmd)){ # need to parse if fi into stack or tree structure
          if    ($scmd =~  /setopt$/){my $grcn='_doso';$grcn='_unso' if($scmd =~ /^un/); # mine backslashd B4 \n 2design8 continU8ion; GlobalResrcCmndName
            if  ( length($tokn) && $tokn ne "\\"){push(@{$GLBL{$grcn}},$tokn);}#print "grcn:$grcn:tokn:$tokn:\n";} # don't print pRs tOkNz until l8r
          }elsif($scmd =~ /^export$/){my $grcn='_xprt'; # nd2suport Mbeded Xpansion2keep upd8ing $LS_COLORS && multi-escaped quotes
            if  ( length($tokn) && $tokn =~ /^([^=]+)=(['"`;])(.*)/){my $envr=$1;my $qtyp=$2;my $xval=$3;$cntf=1;$cntf=0 if($qtyp eq ';');
              while ($cntf){
                for my $cndx(0..(length($xval)-1)){ # nd2traverse $xval 2rite joining&&continuing2l8r linez until matching close quote termin8z
                  if(substr($xval,$cndx,1) eq $qtyp && (!$cndx || substr($xval,$cndx-1,1) ne "\\")){$cntf=0; # most basic unescaped matching qtyp found
                     substr($xval,$cndx,length($xval)-$cndx,'');$GLBL{$grcn}{$envr}=$xval;last;}}#print "grcn:$grcn:envr:$envr:xval:$xval:\n";last;}}
                if  ($cntf && length($_)){s/^(\s*\S*)//;if(defined($1)){$xval .= $1;$tokn .= $1;}} # joining next token when needed at end before next quote ck
              }   if($qtyp eq  "'"  ){ # need awareness of quote type (but maybe this one does nothing except maybe some escaping?)
              }elsif($qtyp =~ /["`]/){ # && do expansion
                  if($qtyp eq  '`'  ){}# && do execution
              }elsif($qtyp eq  ';'  ){delete(                   $GLBL{$grcn}{$envr}     );#rint "grcn:$grcn:envr:$envr:dlet::\n"; # && do  deletion
              } my $lxvl=length($xval); # below needs regex special chrz escaped in $xval or to skip over LengthXVaL chrz
              if    ($tokn =~ /^$envr=$qtyp.{$lxvl}$qtyp\s*;(.+)/){$_ = "$1 $_";$scmd=undef;} # hndl "export x='t';export" unshift l8r cmd bak2while tokenizer
            }
          }elsif($scmd =~  /^alias$/){my $grcn='_alis';
          }
        }#else{print "wstd:$tokn:\n";}
      # if(s/^\s*(;|#.*|$)//){$scmd=undef;} # most single-line basic cmndz wil termin8 on semicolon||trAlng cmnt (when # is!within quotes or othr speclcAs)
      }}
  # according to Term::Shell By default, process_esc() uses escaping rules similar to Perl's single-quoted string (yet examples have doubles && tstzRmixd):
  #   Escaped   backslashes     return backslashes.                                                The string'"123\\456"'returns 123\456. # both escaped
  #   Escaped  quote characters return the quote character (to allow quote characters in strings). The string "abc\"def" returns abc"def. # Dubl escaped
  #   All other backslashes are returned  verbatim.                                                The string '123\456'  returns 123\456. # Sngl unchngd
#     my $ts0d="123\\456"  ;my $ts0s='123\\456'  ;print "ts0d:$ts0d:ts0s:$ts0s:\n"; # prntz  123\456   123\456  # both escapez nested bksl
#     my $ts1d="abc\"def"  ;my $ts1s='abc\"def'  ;print "ts1d:$ts1d:ts1s:$ts1s:\n"; # prntz  abc"def   abc\"def # Dubl escapez nested dubl, Sngl unchngd
#     my $ts2d="123\'456"  ;my $ts2s='123\456'   ;print "ts2d:$ts2d:ts2s:$ts2s:\n"; # prntz  123'456   123\456  # Dubl escapez nested sngl, Sngl unchngd
#     #y $ts2d="123\456"   ;my $ts2s='123\456'   ;print "ts2d:$ts2d:ts2s:$ts2s:\n"; # prntz  123I      123\456  # Wide-char warning on this line B4 droopy I
#     my $t00d="0123\\4567";my $t00s='0123\\4567';print "t00d:$t00d:t00s:$t00s:\n"; # prntz 0123\4567 0123\4567 # both
#     my $t01d="0123\"4567";my $t01s='0123\"4567';print "t01d:$t01d:t01s:$t01s:\n"; # prntz 0123"4567 0123\"4567# Sngl unchngd nested dubl
#     my $t02d="0123\'4567";my $t02s='0123\'4567';print "t02d:$t02d:t02s:$t02s:\n"; # prntz 0123'4567 0123'4567 # rest of bakslash quotez escape && lose bksl
#     my $t03d="0123\4567" ;my $t03s='0123\4567' ;print "t03d:$t03d:t03s:$t03s:\n"; # prntz 0123I7    0123\4567 # Wide-char warnz
#     my $tA0d="ABCD\\EFGH";my $tA0s='ABCD\\EFGH';print "tA0d:$tA0d:tA0s:$tA0s:\n"; # prntz ABCD\EFGH ABCD\EFGH
#     my $tA1d="ABCD\"EFGH";my $tA1s='ABCD\"EFGH';print "tA1d:$tA1d:tA1s:$tA1s:\n"; # prntz ABCD"EFGH ABCD\"EFGH
#     my $tA2d="ABCD\'EFGH";my $tA2s='ABCD\'EFGH';print "tA2d:$tA2d:tA2s:$tA2s:\n"; # prntz ABCD'EFGH ABCD'EFGH
#     my $tA3d="ABCD\EFGH" ;my $tA3s='ABCD\EFGH' ;print "tA3d:$tA3d:tA3s:$tA3s:\n"; # prntz ABCDFGH   ABCD\EFGH
  }}
sub L8fd{my $self=shift;  my $flnm=$self->{'_flnm'}; # Load8shFileD8a; maybe load $_Stxt first as single EscapedTeXT pre-split into @_text then S2 col8d
  if(-r "$flnm"){$self->{'_ycrs'} =$self->{'_xcrs'}=$self->{'_hite'}=$self->{'_widt'}=$self->{'_flagcvis'}=0;
    open( FILE,'<',$flnm); chomp(@{$self->{'_text'}}=<FILE>);close(FILE); # maybe linez shouldn't be chompd so like .pal8 file !ending in \n can be seen?
    $self->{'_hite'}     =scalar(@{$self->{'_text'}});$self->{'_Stxt'}='';
    for(0..($self->{'_hite'}-1)){  $self->{'_widt'}=length($self->{'_text'}[$_]) if($self->{'_widt'} < length($self->{'_text'}[$_]));
      if    ($flnm =~ /\.xinitrc$/){ # start basic parsing && tokeniz8ion to interleave other col8 layer's escapez for initial formatz
        $self->{'_text'}[$_] =~ s/^(\s*)(#!.*)$/$1$B$2/; # on #! header, eventually good to colr path && dir-separ8orz like lsd8 (&& c8fn should)
        if($self->{'_text'}[$_] =~  /^(\s*)(#\s*)([0-9A-Za-z._]{8})(\s*:\s*)(\S+)(\s*by\s*)(Pip\s*)(Stuart\s*)/){my $d8c3=d8colr($3);
          $self->{ '_text'}[$_] =~ s/^(\s*)(#\s*)([0-9A-Za-z._]{8})(\s*:\s*)(\S+)(\s*by\s*)(Pip\s*)(Stuart\s*)/$1$C$2$d8c3$W$4$C$5$W$6$C$7$G$8$C/;}
        $self->{'_text'}[$_] =~ s/(<)([^@]+)(\@)([^.]+)(\.)(Com|Net|Org)(>)/$W$1$C$2$W$3$Y$4$W$5$M$6$W$7$C/i; # need to track beginning colr to restore @end
        $self->{'_text'}[$_] =~ s/^(\s*)(#.*)$/$1$C$2/;
      }elsif($flnm =~ /\.mikmod_playlist$/){ # start regexing in codez
        $self->{'_text'}[$_] =~ s/^(Mik)(Mod\s+)(play)(list)$/$R$1$Y$2$G$3$C$4/;
        $self->{'_text'}[$_] =~ s/^(")(.*)("\s+)(")(.*)("\s+)(\d+\s+)(\d+)$/$C$1$Y$2$C$3$G$4$R$5$G$6$B$7$M$8/; # maybe should c8fn $2
      }elsif($flnm =~ /MANIFEST$/){
        $self->{'_text'}[$_]  = c8fn($self->{'_text'}[$_]);
      } $self->{'_Stxt'}     .= $self->{'_text'}[$_] . "\n"; # preserve parse resultz in obj for efficient reuse l8r && stage oper8ionz wher 1st might just
      my @c8d8=S2(              $self->{'_text'}[$_]);       #   reformat plain txt, 2nd colrz foregr, 3rd colrz backgr, 4th layerz f0ntz && each stage
      $self->{  '_text'}[$_]  = $c8d8[0];                    #   should preserve incoming st8 B4 upd8ing the visible represent8ion so stagez can be audited;
      $self->{  '_Fclr'}[$_]  = $c8d8[1];
      $self->{  '_bclr'}[$_]  = $c8d8[2];
      $self->{  '_f0nt'}[$_]  = $c8d8[3];
    }#$self->cc2e(); # this is pretty badly broken =(
  }}
sub L8cd{my $self=shift;my $cmds=$self->{'_cmds'};my $cmdd=$self->{'_cmdd'}; # Load8shCommandD8a like Btix wo shifting to Term scrolbak (or pIpeSTDIN && oper8)
  # eventually want to optionally read both backtickz && STDIN by line (or full) into _Stxt pre-col8 && allow pre-oper8 on that or layerz post-S2
  #   && also add ability to pass in full 8sh cmnd line that executed before piping through this, as well as what follows, to assist in oper8ion selection
  # load single EscapedTeXT first then expand to col8 (Stxt appendz to keep sync with _text etc because each Load() pushez)
  if    (defined($cmds) && length($cmds)){$self->{'_Stxt'}.=        `$cmds` ; # might want2 backtick into array context instead of scalar to multi-line better?
  }elsif( !-t    STDIN                  ){$self->{'_Stxt'}.=join('',<STDIN>); # if no CmndString above && STDIN is not a TTY, read all in already ending in \n
    $self->{'_flagpisi'}=1; # set new PIping from StdIn flag
  }elsif(defined($cmdd) && length($cmdd)){$self->{'_Stxt'}.=        `$cmdd` ;} # fall back on CmndDefault if it's specified
#self->{'_Stxt'}=~ s/(Pip)/$C$1$G/g;print($self->{'_Stxt'}); # testing if piping through command which spawnz cmnd object can oper8 && output good?
  # for Dflt c8 col8 objectz geared towardz SDL, it's useful to have a cmnd profile for isol8ing each execution within an 8trm,
  #   but then there's a slightly different concept of a c8 object cmnd profile that can be piped thru or called first to read from paramz or default backtickz
  #   && then oper8z on d8a && printz (where many basic filter/wrapper cmndz will likely never need col8 layerz)
  # maybe set a GLBL if any term already crE8d to know which type of cmnd to prefer?
  $self->xe2c() if(defined($self->{'_Stxt'}) && length($self->{'_Stxt'}));}
sub xe2c{my $self=shift;for(@tFbf){$self->{"_$_"  }= [];} # eXpand   Escapetextd8a to C8 (after emptying main col8 arrayz)
  my   @ec8o=S2($self->{'_Stxt'}) if( exists($self->{'_Stxt'}) &&  defined($self->{'_Stxt'}) &&   length($self->{'_Stxt'}));
  if  (@ec8o    &&                   defined($ec8o[0]) &&          defined($ec8o[1]) &&          defined($ec8o[2]) &&          defined($ec8o[3])){
    if($ec8o[0] =~ /\n/){my @ec80=split(/\n/,$ec8o[0]);my @ec81=split(/\n/,$ec8o[1]);my @ec82=split(/\n/,$ec8o[2]);my @ec83=split(/\n/,$ec8o[3]);
      for(0..$#ec80){push(@{$self->{'_text'}} ,$ec80[$_]);$self->{'_Fclr'}[$#{$self->{'_text'}}]=$ec81[$_];
        $self->{'_bclr'}[$#{$self->{'_text'}}]=$ec82[$_] ;$self->{'_f0nt'}[$#{$self->{'_text'}}]=$ec83[$_];}}
    else{            push(@{$self->{'_text'}} ,$ec8o[ 0]);$self->{'_Fclr'}[$#{$self->{'_text'}}]=$ec8o[ 1];
        $self->{'_bclr'}[$#{$self->{'_text'}}]=$ec8o[ 2] ;$self->{'_f0nt'}[$#{$self->{'_text'}}]=$ec8o[ 3]; }
    $self->{    '_hite'}= @{$self->{'_text'}};            $self->{'_widt'}= 0; # upd8 wdht aftr new cmnd
    for(0..($self->{'_hite'} -1)){ $self->{'_widt'}= length($self->{'_text'}[$_]) if($self->{'_widt'}< length($self->{'_text'}[$_]));}}}
sub cc2e{my $self=shift;           $self->{'_Stxt'}= '';  # Compress C8 to Escapetextd8a (after emptying lone Stxt scalar) but should join insted of append \n?
  for(0..(@{$self->{'_text'}}-1)){ $self->{'_Stxt'}.=    c2($self->{'_text'}[$_],$self->{'_Fclr'}[$_],$self->{'_bclr'}[$_],$self->{'_f0nt'}[$_]) . "\n";
                                                #print   c2($self->{'_text'}[$_],$self->{'_Fclr'}[$_],$self->{'_bclr'}[$_],$self->{'_f0nt'}[$_]) . "\n";
                                                #print join("\n",$self->{'_text'}[$_],$self->{'_Fclr'}[$_],$self->{'_bclr'}[$_],$self->{'_f0nt'}[$_]);
                                                 }}
sub new{my( $nvkr,$ityp,   $idat)=@_;  my $nobj=ref($nvkr); # basically same as TIEARRAY below just without commented old Curses code (adding fldz stuff)
        my  $clas=$ityp;   $clas =$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
        #y  $clas=shift; # orig c8 new only shifted clas, but now trying to rip d8::fldz new hoping for file vs. term separ8ion
  my        $self=bless({},$clas);
  for   my  $attr ($self->AttrNamz()){
    $self->{$attr}=     []                  if($attr =~ /^_(text|[fb](clr|0nt))$/);
    $self->{$attr}=$self->DfltValu(  $attr) if($attr !~ /^_(text|[fb](clr|0nt))$/); # init Dfaltz (Xcept colIding objX problM hEr wi all base col8 arrayz)
    $self->{$attr}=$nvkr->{$attr} if($nobj);} #  && copy if supposed to
  for(@KMODNAMZ){  $self->{'_kmod'}{$_}=0  ;} shift ; # shed nvkr or clas name B4 looping ky=>vl
  while(@_){my $foun=0;my($keey,$valu)=(shift,shift);
    for my  $attr ($self->AttrNamz()){
      if   ($attr =~                                  /$keey/i){$self->{$attr}=$valu;$foun=1;}
      elsif($attr eq '_flnm' && !defined($valu) && -r "$keey" ){$self->{$attr}=$keey;$foun=1;}} # special check if undef valu but keey has readable flnm
    unless ($foun){
      for my $attr($self->AttrNamz()){
        if(     $_verbose_attrnamz{$attr}          eq  $keey  ){$self->{$attr}=$valu;$foun=1;}} # exact match
      unless($foun){die "!*EROR*! Octology::c8::new initializ8ion key:$keey was not recognized!\n";}
    }}   $self->{'_flagcmnd'}=1 if(length($self->{'_cmds'}) || length($self->{'_cmdd'})); # allow just initing cmd[sd] to imply cmnd true
         $self->{'_flagfile'}=1                             if(length($self->{'_flnm'})); # allow just initing flnm    to imply file true
  if    ($self->{'_flagfile'}){$self->SAAD(0);$self->L8fd() if(length($self->{'_flnm'})); # start basic file    d8a          loading
  }elsif($self->{'_flagcmnd'}){$self->SAAD(0);$self->L8cd()                             ; # start basic shell command output loading (or pIpeSTDIN if!len_cmdz)
  }elsif($self->{'_flagterm'}){$self->SAAD(0);$self->L8rc();$self->CVis(1);$name= '8trm'; # start basic 8trm && 8sh with command prompt
  }else {#self->SAAD(1);$self->{'_dndx'}=@DISPSTAK;push(@DISPSTAK,\$self); # orig pushd new objref to display order stack, tracking index but unused for now
         $self->TestDraw();} # old Curses newwin doesn't auto draw so if _text initd && flagaudr (&& obj not already just a file or cmnd from abov) ...
  return($self);}
sub TIEARRAY{my $clas=shift;my $self=bless({},$clas);
  for my    $attr ($self->AttrNamz()){
    $self->{$attr}=               []      if($attr =~ /^_(text|[fb](clr|0nt))$/);
    $self->{$attr}=$self->DfltValu($attr) if($attr !~ /^_(text|[fb](clr|0nt))$/);} # init defaultz (except main layer anon-arrayz which were persisting)
  for(@KMODNAMZ){  $self->{'_kmod'}{$_}=0;}
  while(@_){my $foun=0;my($keey,$valu)=(shift,shift);
    for my  $attr ($self->AttrNamz()){
      if   ($attr =~                                  /$keey/i){$self->{$attr}=$valu;$foun=1;}
      elsif($attr eq '_flnm' && !defined($valu) && -r "$keey" ){$self->{$attr}=$keey;$foun=1;}} # special check if undef valu but keey has readable flnm
    unless($foun){
      for my $attr($self->AttrNamz()){
        if(     $_verbose_attrnamz{$attr}          eq  $keey  ){$self->{$attr}=$valu;$foun=1;}} # exact match
      unless($foun){die "!*EROR*! Octology::c8::new initializ8ion key:$keey was not recognized!\n";}}}
# $self->{'_flagshrk'}=0 if($self->{'_hite'} && $self->{'_widt'}); # shrk true depended on either hite||widt being 0?
# $self->Updt(1); # Updt with NoChange flag would prepare for flagz maxi, shrk, && cntr to call Rsiz to resize window on dynamic dimensions
  if($curs){ #    $self->{'_wind'}=newwin(                                  $self->{'_hite'},      $self->{'_widt'},
             #                                                              $self->{'_yoff'},      $self->{'_xoff'});
    unless(exists($self->{'_wind'}) && defined($self->{'_wind'})){
      die   "!*EROR*! Octology::c8::new could not crE8 new window with hite:$self->{'_hite'}, widt:$self->{'_widt'}, " .
                                                                      "yoff:$self->{'_yoff'}, xoff:$self->{'_xoff'}!\n";exit();}}
# $self->{'_dndx'}=@DISPSTAK;push(@DISPSTAK,\$self); # add new Octology::c8 object to display order stack
# $self->Move(-1,-1) unless($self->{'_ycrs'} || $self->{'_xcrs'}); # need some SDL graphical emul8ion of cursor to move && blink && hide
  $self->TestDraw(); # newwin doesn't AutoDraw so if there's init _text && AutoDraw is on...
# curs_set($self->{'_flagcvis'}) if($curs); # set Curses cursor state
  return($self);}
sub FETCH     { return(         $_[0]->{'_text'}->[$_[1]]); }
sub FETCHSIZE { return(scalar(@{$_[0]->{'_text'}})       ); }
sub STORE     {
  $_[0]->{'_text'}->[$_[1]] = $_[2];
  $_[0]->TestDraw();}
sub STORESIZE {
  splice(@{$_[0]->{'_text'}}, $_[1], @{$_[0]->{'_text'}} - $_[1]);
  $_[0]->TestDraw();}
sub EXISTS    { return(0) unless(defined($_[0]->{'_text'}->[$_[1]])); return(1); }
sub CLEAR     {             @{$_[0]->{'_text'}} = ();         $_[0]->TestDraw(); }
sub PUSH      {        push(@{$_[0]->{'_text'}}, $_[1]);      $_[0]->TestDraw(); }
sub POP       { $_ =    pop(@{$_[0]->{'_text'}});             $_[0]->TestDraw(); return($_); }
sub SHIFT     { $_ =  shift(@{$_[0]->{'_text'}});             $_[0]->TestDraw(); return($_); }
sub UNSHIFT   {     unshift(@{$_[0]->{'_text'}}, $_[1]);      $_[0]->TestDraw(); }
sub SPLICE    {
#open(DBUG, ">dbug"); for(0..$#_) { print DBUG "$_ : $_[$_]\n"; } close(DBUG); $_[0]->GetK(-1);
#                $_ = splice(@{$_[0]->{'_text'}}, @_[1..$#_]); $_[0]->TestDraw(); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->FETCHSIZE() - $offs unless(defined($leng));
  my $retn = splice(@{$self->{'_text'}}, $offs, $leng, @_);$self->TestDraw();return($retn);}
sub EXTEND    { }
sub OScr{my $self = shift; # in Simp OScr was global but trying in c8 as method
  unless($GLBL{'FLAGOPEN'}){ # need Open main Screen for what was a new Curses::Simp obj but should now start initializing SDL here instead
    if($sdlf){
      for my  $fkey(keys(%f8fm)){ # load my top64 f0nts (attempting to loop with $_ messes up inside tied constructor here)
        $GLBL{'_f8om'}{$fkey}=Octology::f8->new("$ENV{'HOME'}/lib/Octology/f8/f0nt/$f8fm{$fkey}.f0nt");}
                       SDL::init_sub_system(SDL_INIT_JOYSTICK); # w(idth) h(eight) d(epth) f(lags) resizeable(just r does!work but SDL_RESIZABLE f does)
      $GLBL{  '_sxap'}=SDLx::App    ->new(w =>$self->{'_widt'}* 8*$self->{'_xscl'},
                                          h =>$self->{'_hite'}*16*$self->{'_yscl'},d =>32,t =>$name, # spelling diff SDL_RESIZABLE && resizeable
                                          f => SDL_HWSURFACE | SDL_DOUBLEBUF | SDL_HWACCEL | SDL_RESIZABLE,eoq =>1); # EndOnQuit
      $GLBL{  '_sfss'}=SDL::Surface ->new(     SDL_HWSURFACE | SDL_ASYNCBLIT, $self->{'_widt'}*8, $self->{'_hite'}*16, 32, 0, 0, 0, 0);
      $GLBL{  '_xfss'}=SDLx::Surface->new(surface => $GLBL{'_sfss'});
      $GLBL{  '_sxap'}->fullscreen() if($self->{'_flagfsof'} && $ENV{'HOSTNAME'} ne 'Aku');
      $GLBL{  '_evnt'}=SDL::Event   ->new(  ); # below values from `man kbdrate` default 10.9CPS after 0.25secs
                       SDL::Events::enable_key_repeat(250,92);#SDL_DEFAULT_REPEAT_DELAY,SDL_DEFAULT_REPEAT_INTERVAL); # for typematic
      if(              SDL::Joystick::num_joysticks()){
        $GLBL{'_jstk'}=SDL::Joystick->new( 0);
        $GLBL{'_jnam'}=SDL::Joystick::name(0);
        $GLBL{'_nbtz'}=SDL::Joystick::num_buttons($GLBL{'_jstk'});}
      $GLBL{'FLAGOPEN'}=1;
    }elsif($ucsf){ # if Using Simp, set pal8 at start
      for(0..$#avlo){my @rgbd = split(//,  $pmap{$avlo[$_]});for(@rgbd){$_=b10($_)*4;} # silently print color changes (or sys pal8?) B4 new Simp
       #printf("%2d:%s:%s:%3d:%3d:%3d:%s\n"  ,$_,$avlo[$_],$pmap{$avlo[$_]},@rgbd,    $ENV{'TERM'});
       #printf("\e]P%1.1X%2.2X%2.2X%2.2X"    ,$_,                           @rgbd) if($ENV{'TERM'} eq 'xterm'); #GNU/Lin Console?
        printf("\e]4;%d;#%2.2x%2.2x%2.2x\e\\",$_,                           @rgbd) if($ENV{'TERM'} eq 'xterm'); # maybe if TERM ne 'linux'?
      } # maybe should also set bkgr && frgr 0 && 7 like etfp did?
      # do old Simp OScr stuf
      $GLBL{'FLAGOPEN'}=1;
    }}}
sub YCrs{my $self=shift;my    $ycrs=shift; # maybe these should handle -1 && Move should just wrap these similar to Rsiz
  if(defined($ycrs) && $self->{'_ycrs'} ne $ycrs){
         $self->{'_ycrs'}=$ycrs;$self->Draw() if($self->{'_flagaudr'});} # changing window y-cursor position
  return($self->{'_ycrs'});}
sub XCrs{my $self=shift;my    $xcrs=shift;
  if(defined($xcrs) && $self->{'_xcrs'} ne $xcrs){
         $self->{'_xcrs'}=$xcrs;$self->Draw() if($self->{'_flagaudr'});} # changing window x-cursor position
  return($self->{'_xcrs'});}
sub Move{my $self=shift;my    $ycrs=shift;my $xcrs=shift; # upd8 cursor position, where 0,0 is upper  left corner
  if(defined($ycrs) && defined($xcrs)){ # (-1,-1) is a special Move exception to put cursor in lower right corner
    if($ycrs == -1 && $xcrs == -1){
      $ycrs=$self->{'_hite'}-1;
      $xcrs=$self->{'_widt'}-1;}}
  else{
    $ycrs  =$self->{'_ycrs'} unless(defined($ycrs));
    $xcrs  =$self->{'_xcrs'} unless(defined($xcrs));}
  $ycrs    =0 if($ycrs < 0);
  $xcrs    =0 if($xcrs < 0); # used to have special handling to trap cursor within Curses window borders && l8 escaped printing
  $ycrs    =$self->{'_hite'}-1 if($ycrs >= $self->{'_hite'});
  $xcrs    =$self->{'_widt'}-1 if($xcrs >= $self->{'_widt'});
# if($curs){
#   $self->{'_wind'}->move($ycrs,$xcrs);
#   $self->{'_wind'}->getyx($self->{'_ycrs'},$self->{'_xcrs'});
#   $self->{'_wind'}->refresh();}
  $self->{'_ycrs'}=$ycrs;
  $self->{'_xcrs'}=$xcrs;
  return($self->{'_ycrs'},$self->{'_xcrs'});}
sub Hite{my $self=shift;my    $hite=shift;
  if  (defined($hite) && $self->{'_hite'} ne $hite && $hite > 0){
         $self->{'_hite'}=$hite;$self->Draw() if($self->{'_flagaudr'});} # changing window height
  return($self->{'_hite'});}
sub Widt{my $self=shift;my    $widt=shift;
  if  (defined($widt) && $self->{'_widt'} ne $widt && $widt > 0){
         $self->{'_widt'}=$widt;$self->Draw() if($self->{'_flagaudr'});} # changing window width
  return($self->{'_widt'});}
sub Rsiz{my $self=shift;my    $hite=shift;my $widt=shift;                # ReSIZe both window height && width together
  if  (defined($hite) && $self->{'_hite'} ne $hite && $hite > 0){$self->{'_hite'}=$hite;
    if(defined($widt) && $self->{'_widt'} ne $widt && $widt > 0){$self->{'_widt'}=$widt;$self->Draw() if($self->{'_flagaudr'});}}
  return($self->{'_hite'},$self->{'_widt'});}
sub YScl{my $self=shift;my    $yscl=shift;
  if(defined($yscl) && $self->{'_yscl'} ne $yscl){
         $self->{'_yscl'}=$yscl;$self->Draw() if($self->{'_flagaudr'});} # changing window y-scale
  return($self->{'_yscl'});}
sub XScl{my $self=shift;my    $xscl=shift;
  if(defined($xscl) && $self->{'_xscl'} ne $xscl){
         $self->{'_xscl'}=$xscl;$self->Draw() if($self->{'_flagaudr'});} # changing window x-scale
  return($self->{'_xscl'});}
sub OvDr{my $self=shift;my    $ovdr=shift;
  if(defined($ovdr) && $self->{'_flagovdr'} ne $ovdr){
    if($ovdr eq '^'){  $self->{'_flagovdr'} ^= 1;}
    else{$self->{'_flagovdr'}=$ovdr;}} # changing OVerDRaw big  text mode
  return($self->{'_flagovdr'});}
sub ODBA{my $self=shift;my    $odba=shift;
  if(defined($odba) && $self->{'_flagodba'} ne $odba){
    if($odba eq '^'){  $self->{'_flagodba'} ^= 1;}
    else{$self->{'_flagodba'}=$odba;}} # changing OverDrawBinaryAlignment mode
  return($self->{'_flagodba'});}
sub AuDr{my $self=shift;my    $audr=shift;
  if(defined($audr) && $self->{'_flagaudr'} ne $audr){
    if($audr eq '^'){  $self->{'_flagaudr'} ^= 1;}
    else{$self->{'_flagaudr'}=$audr;}} # changing AUtoDRaw tied text mode
  return($self->{'_flagaudr'});}
sub ADTF{my $self=shift;my    $adtf=shift;
  if(defined($adtf) && $self->{'_flagadtf'} ne $adtf){
    if($adtf eq '^'){  $self->{'_flagadtf'} ^= 1;}
    else{$self->{'_flagadtf'}=$adtf;}} # changing AutoDraw Tied Fg   mode
  return($self->{'_flagadtf'});}
sub ADTB{my $self=shift;my    $adtb=shift;
  if(defined($adtb) && $self->{'_flagadtb'} ne $adtb){
    if($adtb eq '^'){  $self->{'_flagadtb'} ^= 1;}
    else{$self->{'_flagadtb'}=$adtb;}} # changing AutoDraw Tied Bg   mode
  return($self->{'_flagadtb'});}
sub ADTN{my $self=shift;my    $adtn=shift;
  if(defined($adtn) && $self->{'_flagadtn'} ne $adtn){
    if($adtn eq '^'){  $self->{'_flagadtn'} ^= 1;}
    else{$self->{'_flagadtn'}=$adtn;}} # changing AutoDraw Tied f0Nt mode
  return($self->{'_flagadtn'});}
sub SAAD{my $self=shift;my    $saad=shift; # Set All AutoDraw
  if(defined($saad) && $saad =~ /^[01^]$/){$self->AuDr($saad);$self->ADTF($saad);$self->ADTB($saad);$self->ADTN($saad);}}
# if I add new sub windows back l8r, then I'll also want Maxi, Shrk, && Cntr here
sub CVis{my $self=shift;my    $cvis=shift;
  if(defined($cvis) && $self->{'_flagcvis'} ne $cvis){
    if($cvis eq '^'){  $self->{'_flagcvis'} ^= 1;}
    else{$self->{'_flagcvis'}=$cvis;}$self->Draw() if($self->{'_flagaudr'});} # Cursor changed Visibility st8 so reDraw screen if AutoDraw
  return($self->{'_flagcvis'});}                                              # (eventually better to just redraw cursor char && !wholscrn)
sub Mili{my $self=shift;my    $mili=shift;
  if(defined($mili) && $self->{'_flagmili'} ne $mili){
    if($mili eq '^'){  $self->{'_flagmili'} ^= 1;}
    else{$self->{'_flagmili'}=$mili;}} # changing whether milliseconds or float seconds should be used for timing
  return($self->{'_flagmili'});}
sub Insr{my $self=shift;my    $insr=shift;
  if(defined($insr) && $self->{'_flaginsr'} ne $insr){
    if($insr eq '^'){  $self->{'_flaginsr'} ^= 1;}
    else{$self->{'_flaginsr'}=$insr;}} # changing whether Prnt will print in insert or overstrike mode (might l8r need cursor redraw here if reflects somehow)
  return($self->{'_flaginsr'});}
sub Term{my $self=shift;my    $term=shift;
  if(defined($term) && $self->{'_flagterm'} ne $term){
    if($term eq '^'){  $self->{'_flagterm'} ^= 1;}
    else{$self->{'_flagterm'}=$term;}} # changing whether whole c8 object is trying to start emul8ing a terminal
  return($self->{'_flagterm'});}
sub File{my $self=shift;my    $file=shift;
  if(defined($file) && $self->{'_flagfile'} ne $file){
    if($file eq '^'){  $self->{'_flagfile'} ^= 1;}
    else{$self->{'_flagfile'}=$file;}} # changing whether whole c8 object is trying to just encapsul8 a file
  return($self->{'_flagfile'});}
sub Cmnd{my $self=shift;my    $cmnd=shift;
  if(defined($cmnd) && $self->{'_flagcmnd'} ne $cmnd){
    if($cmnd eq '^'){  $self->{'_flagcmnd'} ^= 1;}
    else{$self->{'_flagcmnd'}=$cmnd;}} # changing whether whole c8 object is trying to just encapsul8 a command
  return($self->{'_flagcmnd'});}
sub Wait{my $self=shift;my $wait=shift;
  if(defined($wait) && $wait > 0){
    $wait=int($wait*1000) if(!$self->{'_flagmili'}); # allow basic float seconds if default milliseconds flag toggled off
    if($sdlf){$self->OScr() unless($GLBL{'FLAGOPEN'});
      $GLBL{'_sxap'}->delay($wait);}}}
sub GetK{my $self=shift;my $tmot=shift||0;my $tkey='-1';my $stix;my $ctix;
  if($sdlf){$self->OScr() unless($GLBL{'FLAGOPEN'});
    $stix=$GLBL{'_sxap'}->ticks();
    if(defined($tmot) && $tmot > 0){
      $tmot=int($tmot*1000) if(!$self->{'_flagmili'});} # allow basic float seconds if default milliseconds flag toggled off
    while(defined($tkey) && $tkey eq '-1' && ($tmot eq '-1' || !defined($ctix) || ($ctix-$stix) < $tmot)){
          SDL::Events::pump_events();
      if( SDL::Events::poll_event($GLBL{'_evnt'})){
        if     ($GLBL{'_evnt'}->type    == SDL_VIDEORESIZE){ # first handle resize events, then more typical input events
          my($evrw,$evrh)=($GLBL{'_evnt'}->resize_w    ,$GLBL{'_evnt'}->resize_h     );$GLBL{'_sxap'}->resize($evrw,$evrh);
          $self->{'_xscl'}=$evrw / ($self->{'_widt'}* 8.0);
          $self->{'_yscl'}=$evrh / ($self->{'_hite'}*16.0);$self->Draw();
        } elsif($GLBL{'_evnt'}->type    == SDL_KEYDOWN      ){
          if   ($GLBL{'_evnt'}->key_sym == SDLK_0           ){$tkey=  '0';$tkey=')'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);} # seems shifted #s
          elsif($GLBL{'_evnt'}->key_sym == SDLK_1           ){$tkey=  '1';$tkey='!'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);} #   aren't getting
          elsif($GLBL{'_evnt'}->key_sym == SDLK_2           ){$tkey=  '2';$tkey='@'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);} #   own key_sym
          elsif($GLBL{'_evnt'}->key_sym == SDLK_3           ){$tkey=  '3';$tkey='#'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_4           ){$tkey=  '4';$tkey='$'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_5           ){$tkey=  '5';$tkey='%'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_6           ){$tkey=  '6';$tkey='^'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_7           ){$tkey=  '7';$tkey='&'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_8           ){$tkey=  '8';$tkey='*'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_9           ){$tkey=  '9';$tkey='('       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_a           ){$tkey=  'a';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );} # Ctrl-a or A
          elsif($GLBL{'_evnt'}->key_sym == SDLK_b           ){$tkey=  'b';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );} # Ctrl-b or B
          elsif($GLBL{'_evnt'}->key_sym == SDLK_c           ){$tkey=  'c';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );} # Ctrl-c or C ..
          elsif($GLBL{'_evnt'}->key_sym == SDLK_d           ){$tkey=  'd';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_e           ){$tkey=  'e';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_f           ){$tkey=  'f';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_g           ){$tkey=  'g';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_h           ){$tkey=  'h';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_i           ){$tkey=  'i';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_j           ){$tkey=  'j';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_k           ){$tkey=  'k';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_l           ){$tkey=  'l';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_m           ){$tkey=  'm';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_n           ){$tkey=  'n';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_o           ){$tkey=  'o';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_p           ){$tkey=  'p';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_q           ){$tkey=  'q';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_r           ){$tkey=  'r';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_s           ){$tkey=  's';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_t           ){$tkey=  't';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_u           ){$tkey=  'u';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_v           ){$tkey=  'v';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_w           ){$tkey=  'w';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_x           ){$tkey=  'x';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_y           ){$tkey=  'y';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_z           ){$tkey=  'z';$tkey=uc($tkey) if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);
                                                              $tkey="Ct$tkey"             if($GLBL{'_evnt'}->key_mod & KMOD_CTRL );}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_PERIOD      ){$tkey=  '.';$tkey='>'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_UNDERSCORE  ){$tkey=  '_';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_SPACE       ){$tkey=  ' ';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_RETURN      ){$tkey= "\r";} # maybe should be \n newline more like Enter?
          elsif($GLBL{'_evnt'}->key_sym == SDLK_TAB         ){$tkey= "\t";} # might want to check for Shift-Tab && Ctrl-Tab here too
          elsif($GLBL{'_evnt'}->key_sym == SDLK_BACKSPACE   ){$tkey= "\b";}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_ESCAPE      ){$tkey= "\e";} # ^[
          elsif($GLBL{'_evnt'}->key_sym == SDLK_DELETE   ){$tkey=chr(127);} # ^? or maybe chr(127)?
          elsif($GLBL{'_evnt'}->key_sym == SDLK_MINUS       ){$tkey=  '-';$tkey='_'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_PLUS        ){$tkey=  '+';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_QUESTION    ){$tkey=  '?';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_QUOTE       ){$tkey=  "'";$tkey='"'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_QUOTEDBL    ){$tkey=  '"';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_BACKQUOTE   ){$tkey=  '`';$tkey='~'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_COMMA       ){$tkey=  ',';$tkey='<'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_COLON       ){$tkey=  ':';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_SEMICOLON   ){$tkey=  ';';$tkey=':'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_EXCLAIM     ){$tkey=  '!';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_AT          ){$tkey=  '@';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_HASH        ){$tkey=  '#';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_DOLLAR      ){$tkey=  '$';}
         #elsif($GLBL{'_evnt'}->key_sym == SDLK_PERCENT     ){$tkey=  '%';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_CARET       ){$tkey=  '^';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_AMPERSAND   ){$tkey=  '&';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_ASTERISK    ){$tkey=  '*';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_LEFTPAREN   ){$tkey=  '(';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_SLASH       ){$tkey=  '/';$tkey='?'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_RIGHTPAREN  ){$tkey=  ')';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_LESS        ){$tkey=  '<';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_EQUALS      ){$tkey=  '=';$tkey='+'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_GREATER     ){$tkey=  '>';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_LEFTBRACKET ){$tkey=  '[';$tkey='{'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_BACKSLASH   ){$tkey= '\\';$tkey='|'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_RIGHTBRACKET){$tkey=  ']';$tkey='}'       if($GLBL{'_evnt'}->key_mod & KMOD_SHIFT);}
         #elsif($GLBL{'_evnt'}->key_sym == SDLK_LEFTBRACE   ){$tkey=  '{';} # apparently SDL is missing %{|}~ && sometimes gets defined (SDLK_LAST+12345)
         #elsif($GLBL{'_evnt'}->key_sym == SDLK_BAR         ){$tkey=  '|';} # might be better as VERTICALBAR
         #elsif($GLBL{'_evnt'}->key_sym == SDLK_RIGHTBRACE  ){$tkey=  '}';}
         #elsif($GLBL{'_evnt'}->key_sym == SDLK_TILDE       ){$tkey=  '~';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F1          ){$tkey='F1' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F2          ){$tkey='F2' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F3          ){$tkey='F3' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F4          ){$tkey='F4' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F5          ){$tkey='F5' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F6          ){$tkey='F6' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F7          ){$tkey='F7' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F8          ){$tkey='F8' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F9          ){$tkey='F9' ;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F10         ){$tkey='F10';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F11         ){$tkey='F11';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F12         ){$tkey='F12';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F13         ){$tkey='F13';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F14         ){$tkey='F14';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_F15         ){$tkey='F15';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_INSERT      ){$tkey='Ins';}#$self->{'_flaginsr'} ^= 1;}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_LEFT        ){$tkey= 'Lt';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_RIGHT       ){$tkey= 'Rt';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_UP          ){$tkey= 'Up';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_DOWN        ){$tkey= 'Dn';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_PAGEUP      ){$tkey='PUp';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_PAGEDOWN    ){$tkey='PDn';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_HOME        ){$tkey='Hom';}
          elsif($GLBL{'_evnt'}->key_sym == SDLK_END         ){$tkey='End';}
          # should push tkey to kque && flagz to mque for mapping to key-comboz
        }
      }   $ctix=$GLBL{'_sxap'}->ticks();
    }} return($tkey);}
sub PrcS{my $self=shift;my $pt2p=shift; # PText2Process (handling most common escapez 4 pseudo-printing with Prnt)
  while($pt2p =~ s/^(.*?)(\e\[([\d;]*)[A-MPSTXZ]|\n)//){my $pret=$1;my $esco=$2;
#   if(defined($pret) && length($pret)){$self->Prnt(S2($pret));
#     if($pret =~ /\e]4;\d+;#[0-9a-f]{6}\e\\/){#%{$GLBL{'_sprm'}}=(); # test attempt to invalid8 all Spritez if any escape to upd8 term color value
#       for(keys(%{$GLBL{'_sprm'}})){delete($GLBL{'_sprm'}{$_});}
#       $self->Draw();} # && full-screen redraw
#   }
    if     ($esco eq "\n"){$self->{'_xcrs'}=0; # mv cursor to start of next line
      if   ($self->{'_ycrs'}==$self->{'_hite'}-1 && $self->{'_flagterm'}){$self->S2SB(); # Shift top lines 2 ScrollBack if in term mode
      }else{$self->{'_ycrs'}++;}
    } elsif($esco =~ /^\e\[(\d*);?(\d*)([A-MPSTXZ])$/){my $ecp0=$1;my $ecp1=$2;my $ectl=$3; # only supporting 2 number params for now
      if    ($ectl =~ /[A-FILMPSTXZ]/){$ecp0=1 unless(defined($ecp0) && length($ecp0)); # initialize defaults
                                       $ecp1=1 unless(defined($ecp1) && length($ecp1));}
      else                            {$ecp0=0 unless(defined($ecp0) && length($ecp0)); # basically just GHJK should default to 0 so far
                                       $ecp1=0 unless(defined($ecp1) && length($ecp1));}
      if    ($ectl =~ /[AF]/){for(1..$ecp0){$self->{'_ycrs'}-- if($self->{'_ycrs'}                     );}$self->{'_xcrs'}=0 if($ectl eq 'F'); #Up||PrevLine
      }elsif($ectl =~ /[BE]/){for(1..$ecp0){$self->{'_ycrs'}++ if($self->{'_ycrs'} < $self->{'_hite'}-1);}$self->{'_xcrs'}=0 if($ectl eq 'E'); #Dn||NextLine
      }elsif($ectl eq  'C'  ){for(1..$ecp0){$self->Prnt(' ')   if($self->{'_xcrs'} < $self->{'_widt'}-1);}                                     #Fwd
      }elsif($ectl eq  'D'  ){for(1..$ecp0){$self->{'_xcrs'}-- if($self->{'_xcrs'}                     );}                                     #Bak
      }elsif($ectl eq  'G'  ){              $self->{'_xcrs'}=$ecp0; # may need to extend ycrs line in arrays if cursor moved past end
      }elsif($ectl eq  'H'  ){              $self->{'_ycrs'}=$ecp0;$self->{'_xcrs'}=$ecp1; # my cursors start at 0,0 even though standard default is 1,1
      }elsif($ectl eq  'I'  ){for(1..$ecp0){$self->Prnt(' ')      if($self->{'_xcrs'} < $self->{'_widt'}-1                        ); # tabs 8-column increments
                                            $self->Prnt(' ')   while($self->{'_xcrs'} < $self->{'_widt'}-1 && $self->{'_xcrs'} % 8);}
      }elsif($ectl eq  'Z'  ){for(1..$ecp0){$self->{'_xcrs'}--    if($self->{'_xcrs'}                                             ); # tabsback
                                            $self->{'_xcrs'}-- while($self->{'_xcrs'}                      && $self->{'_xcrs'} % 8);}
      }elsif($ectl eq  'J'  ){ # Erase Display ecp0 0 erase  below, 1 erase above, 2 erase all, 3 erase saved lines (xterm)
        if    ($ecp0 == 0){
          for my $c8la(@tFbf){$self->{"_$c8la"}[$self->{'_ycrs'}]=substr($self->{"_$c8la"}[$self->{'_ycrs'}],0,$self->{'_xcrs'});
            for my $lnum($self->{'_ycrs'}+1..@{$self->{"_$c8la"}}-1){$self->{"_$c8la"}[$lnum]='';}}
        }elsif($ecp0 == 1){substr($self->{'_text'}[$self->{'_ycrs'}],0,$self->{'_xcrs'}+1,' ' x $self->{'_xcrs'}+1);
          for my $c8la(@tFbf){for my $lnum(0..$self->{'_ycrs'}-1){$self->{"_$c8la"}[$lnum]='';}}
        }elsif($ecp0 == 2){
          for my $c8la(@tFbf){for my $lnum(0..@{$self->{"_$c8la"}}-1){$self->{"_$c8la"}[$lnum]='';}}}
      }elsif($ectl eq  'K'  ){ # Erase Line    ecp0 0 erase  right, 1 erase  left, 2 erase whole line (Rt trunc8,Lt fill spcz up2cursor2prEsrvRt,Ln='')
        if    ($ecp0 == 0){
          for my $c8la(@tFbf){$self->{"_$c8la"}[$self->{'_ycrs'}]=substr($self->{"_$c8la"}[$self->{'_ycrs'}],0,$self->{'_xcrs'});}
        }elsif($ecp0 == 1){substr($self->{'_text'}[$self->{'_ycrs'}],0,$self->{'_xcrs'}+1,' ' x $self->{'_xcrs'}+1);
        }elsif($ecp0 == 2){
          for my $c8la(@tFbf){$self->{"_$c8la"}[$self->{'_ycrs'}]='';}}
      }elsif($ectl eq  'L'  ){for(1..$ecp0){ # insert lines splice new lines in before ycrs (maybe popping @text > hite)
          for my $c8la(@tFbf){splice(@{$self->{"_$c8la"}},$self->{'_ycrs'},0,'');pop(@{$self->{"_$c8la"}}) if(@{$self->{"_$c8la"}} > $self->{'_hite'});}}
      }elsif($ectl eq  'M'  ){for(1..$ecp0){ # delete lines splice out lines at ycrs
          for my $c8la(@tFbf){splice(@{$self->{"_$c8la"}},$self->{'_ycrs'},1   )                           if(@{$self->{"_$c8la"}} > $self->{'_ycrs'});}}
      }elsif($ectl eq  'P'  ){for(1..$ecp0){ # delete chars substr rm  part of ycrs line in each array
          for my $c8la(@tFbf){substr($self->{"_$c8la"}[$self->{'_ycrs'}],$self->{'_xcrs'},1,'')       if(length($self->{"_$c8la"}[$self->{'_ycrs'}]) > $self->{'_xcrs'});}}
      }elsif($ectl eq  'X'  ){for(1..$ecp0){ # erase  chars substr spc part of ycrs line in text array only
                                                substr($self->{'_text' }[$self->{'_ycrs'}],$self->{'_xcrs'}+$_-1,1,' ') if(length($self->{'_text' }[$self->{'_ycrs'}]) > $self->{'_xcrs'}+$_-1);}
      }elsif($ectl eq  'S'  ){my($ycrs,$xcrs)=$self->Move();$self->Move(0,0);for(1..$ecp0){
          for my $c8la(@tFbf){splice(@{$self->{"_$c8la"}},$self->{'_ycrs'},1   )                           if(@{$self->{"_$c8la"}} > $self->{'_ycrs'});}}$self->Move($ycrs,$xcrs); # scroll up (delete top lines)
      }elsif($ectl eq  'T'  ){my($ycrs,$xcrs)=$self->Move();$self->Move(0,0);for(1..$ecp0){
          for my $c8la(@tFbf){splice(@{$self->{"_$c8la"}},$self->{'_ycrs'},0,'');pop(@{$self->{"_$c8la"}}) if(@{$self->{"_$c8la"}} > $self->{'_hite'});}}$self->Move($ycrs,$xcrs); # scroll dn (insert top lines)
      }
    }
  }$self->Prnt(S2($pt2p));
# if($pt2p =~ /\e]4;\d+;#[0-9a-f]{6}\e\\/){#%{$GLBL{'_sprm'}}=();
#   for(keys(%{$GLBL{'_sprm'}})){delete($GLBL{'_sprm'}{$_});}
#   $self->Draw();}
} # finish printing the remainder with no further PrcS
sub Prnt{my $self=shift;my $ptxt=shift;my $pfcl=shift;my $pbcl=shift;my $pf0n=shift;
  if  (defined($ptxt) && length($ptxt)){
    if(defined($pfcl) && length($pfcl) &&
       defined($pbcl) && length($pbcl) &&
       defined($pf0n) && length($pf0n)){ # 4 layer params provided so write into object arrays && display
      ($ptxt,$pfcl,$pbcl,$pf0n)=(sS($ptxt),sS($pfcl),sS($pbcl),sS($pf0n)); # strip escapes
      unless(@{$self->{'_text'}} > $self->{'_ycrs'}){$self->{'_text'}[$self->{'_ycrs'}]=' 'x ($self->{'_xcrs'}); # make sure @text up to cursor defined
                                                     $self->{'_Fclr'}[$self->{'_ycrs'}]='G'x ($self->{'_xcrs'});
                                                     $self->{'_bclr'}[$self->{'_ycrs'}]='k'x ($self->{'_xcrs'});
                                                     $self->{'_f0nt'}[$self->{'_ycrs'}]='t'x ($self->{'_xcrs'});}
      unless(length($self->{'_text'}[$self->{'_ycrs'}]) > $self->{'_xcrs'}){
        $self->{'_text'}[$self->{'_ycrs'}].=' 'x ($self->{'_xcrs'}-length($self->{'_text'}[$self->{'_ycrs'}]));}
      unless(length($self->{'_Fclr'}[$self->{'_ycrs'}]) > $self->{'_xcrs'}){
        $self->{'_Fclr'}[$self->{'_ycrs'}].='G'x ($self->{'_xcrs'}-length($self->{'_Fclr'}[$self->{'_ycrs'}]));}
      unless(length($self->{'_bclr'}[$self->{'_ycrs'}]) > $self->{'_xcrs'}){
        $self->{'_bclr'}[$self->{'_ycrs'}].='k'x ($self->{'_xcrs'}-length($self->{'_bclr'}[$self->{'_ycrs'}]));}
      unless(length($self->{'_f0nt'}[$self->{'_ycrs'}]) > $self->{'_xcrs'}){
        $self->{'_f0nt'}[$self->{'_ycrs'}].='t'x ($self->{'_xcrs'}-length($self->{'_f0nt'}[$self->{'_ycrs'}]));}
      if($self->{'_flaginsr'}){substr($self->{'_text'}[$self->{'_ycrs'}],$self->{'_xcrs'},0,$ptxt); # insert  mode
                               substr($self->{'_Fclr'}[$self->{'_ycrs'}],$self->{'_xcrs'},0,$pfcl);
                               substr($self->{'_bclr'}[$self->{'_ycrs'}],$self->{'_xcrs'},0,$pbcl);
                               substr($self->{'_f0nt'}[$self->{'_ycrs'}],$self->{'_xcrs'},0,$pf0n); # needs to redraw xcrs to EOL,shift xcrs,&&redraw cursor
      }else{
        if(length($self->{'_text'}[$self->{'_ycrs'}]) < ($self->{'_xcrs'}+length($ptxt))){ # extend row if necessary to accommodate replacement
          $self->{'_text'}[$self->{'_ycrs'}].=' 'x ($self->{'_xcrs'}+length($ptxt)-length($self->{'_text'}[$self->{'_ycrs'}]));
          $self->{'_Fclr'}[$self->{'_ycrs'}].='G'x ($self->{'_xcrs'}+length($ptxt)-length($self->{'_text'}[$self->{'_ycrs'}]));
          $self->{'_bclr'}[$self->{'_ycrs'}].='k'x ($self->{'_xcrs'}+length($ptxt)-length($self->{'_text'}[$self->{'_ycrs'}]));
          $self->{'_f0nt'}[$self->{'_ycrs'}].='t'x ($self->{'_xcrs'}+length($ptxt)-length($self->{'_text'}[$self->{'_ycrs'}]));}
        substr($self->{'_text'}[$self->{'_ycrs'}],$self->{'_xcrs'},length($ptxt),$ptxt); # replace mode
        substr($self->{'_Fclr'}[$self->{'_ycrs'}],$self->{'_xcrs'},length($ptxt),$pfcl);
        substr($self->{'_bclr'}[$self->{'_ycrs'}],$self->{'_xcrs'},length($ptxt),$pbcl);
        substr($self->{'_f0nt'}[$self->{'_ycrs'}],$self->{'_xcrs'},length($ptxt),$pf0n);} # only needs to overdraw length(ptxt) chars from xcrs,shft,&&cursor
      $self->{'_xcrs'}+=length($ptxt);$self->{'_xcrs'}=$self->{'_widt'}-1 if($self->{'_xcrs'}>=$self->{'_widt'}); # maybe should ycrs++;xcrs=0 if@EOL?
      $self->Draw($self->{'_ycrs'}); # just redrawing ycrs row is good but better to split // to just upd8 printed part of xfss here && not call Draw
    }else{$self->PrcS($ptxt);}}} # <4 layers && probably just ptxt param so Process it for embedded escapes && gener8 layers to send back into Prnt here

#   if($self->{'_flagterm'}){ # start detecting Terminal mode Prnt of all supportable ANSI codes
#     if   ($ptxt =~ s/\e]0;([^\e\a]+)(\e\\|\a)//){$GLBL{'_sxap'}->title($1);} # accept window title change code && upd8 SDL window title
#     elsif($ptxt =~ s/\e\[(\d*)A//){my $coun=1;$coun=$1 if(defined($1) && length($1));                           # accept CUU - Cursor Up
#       for(0..($coun-1)){                                                         $self->{'_ycrs'}-- if($self->{'_ycrs'}                     );}}
#     elsif($ptxt =~ s/\e\[(\d*)B//){my $coun=1;$coun=$1 if(defined($1) && length($1));                           # accept CUD - Cursor Down
#       for(0..($coun-1)){$self->S2SB() if($self->{'_ycrs'} == $self->{'_hite'}-1);$self->{'_ycrs'}++ if($self->{'_ycrs'} < $self->{'_hite'}-1);}}
#     elsif($ptxt =~ s/\e\[(\d*)C//){my $coun=1;$coun=$1 if(defined($1) && length($1));$self->{'_xcrs'} += $coun; # accept CUF - Cursor Forward
#       $self->{'_xcrs'}=$self->{'_widt'}-1 if($self->{'_xcrs'} >= $self->{'_widt'});}
#     elsif($ptxt =~ s/\e\[(\d*)D//){my $coun=1;$coun=$1 if(defined($1) && length($1));$self->{'_xcrs'} -= $coun; # accept CUB - Cursor Back
#       $self->{'_xcrs'}=0 if($self->{'_xcrs'} < 0);} # actually stripping them out of the middle of string && pre-moving cursor will not yield proper results
      # When attempting to turn a c8 object into an 8trm applic8ion, it will probably be necessary to split $ptxt && @text on all escapes prior to splitting
      #   on // && aligning col8 layers in Prnt or Draw. They should be handled in the design8d order && may grow to support the gamut of available oper8ions.
      #   Following is a pretty thorough (although not quite exhaustive yet) list of possible escape codes. They've been combined from several sources dealing
      #   mainly with ANSI, VT100, VT52, && XTerm. There is some incompatible overlap && confusion in trying to separ8 the categories.
      # Crucial C1 (8-bit) Control Characters:
      # Esc [       : CSI - Control        Sequence   Introducer(0x9B)
      # Esc \       : ST  - String         Termin8or            (0x9C)
      # Esc ]       : OSC - Operating      System     Command   (0x9D)
      # Esc P       : DCS - Device         Control    String    (0x90)
      # Esc X       : SOS - Start          Of         String    (0x98)
      # Esc D       : IND -                Index                (0x84) move/scroll window up   one line
      # Esc M       : RI  - Reverse        Index                (0x8D) move/scroll window down one line
      # Esc E       : NEL - Next           Line                 (0x85) move               to  next line
      # CSI n     E : CNL - Cursor         Next       Line      (like B but xcrs=0)
      # CSI n     F : CPL - Cursor         Previous   Line      (like A but xcrs=0)
      # CSI n     G : CHA - Cursor         Horizontal Absolute
      # CSI n ; m H : CUP - Cursor                    Position  (row;column are 1-based)
      # CSI n     J : ED  - Erase                     Display   (0=cursor to EndOfScreen,1=cursor to BeginningOfScreen,2=clear entire screen&&mv cursor2toplft)
      # CSI n     K : EL  - Erase      in             Line      (0=cursor to EOL,1=cursor to BOL,2=clear entire line)
      # CSI n     S : SU  - Scroll                    Up
      # CSI n     T : SD  - Scroll                    Down
      # CSI n ; m f : HVP - Horizontal and Vertical   Position  (f:HVP same as H:CUP)
      # CSI n     m : SGR - Select         Graphic    Rendition (lots of parameter codes for dim, italic, underline, blink, reverse, strikethrough, fonts etc.)
      # CSI 5i      :       AUX  Port  On
      # CSI 4i      :       AUX  Port  Off
      # CSI 6     n : DSR - Device         Status     Report    (prints CPR - Cursor Position Report like CSI n ; m R)
      # CSI       s : SCP - Save           Cursor     Position  (only when DECLRMM is disabled)
      # CSI       u : RCP - Restore        Cursor     Position
      # CSI ?25l    : DECTCEM    Hide      Cursor
      # CSI ?25h    : DECTCEM    Show      Cursor
      # CSI 20h     : LMN -   Set new line mode.
      # CSI ?1h     : DECCKM  Set cursor key to applic8ion.
      # CSI ?2h     : DECANM  Set ANSI (versus VT52).
      # CSI ?3h     : DECCOLM Set number of columns to 132.
      # CSI ?4h     : DECSCLM Set smooth scrolling.
      # CSI ?5h     : DECSCNM Set reverse video on screen.
      # CSI ?6h     : DECOM   Set origin to rel8ive.
      # CSI ?7h     : DECAWM    Set auto-wrap   mode.
      # CSI ?8h     : DECARM    Set auto-repeat mode.
      # CSI ?9h     : DECINLM   Set interlacing mode.
      # CSI 20l     : LMN -   Set line feed mode.
      # CSI ?1l     : DECCKM  Set cursor key to cursor.
      # CSI ?2l     : DECANM  Set VT52 (versus ANSI).
      # CSI ?3l     : DECCOLM Set number of columns to  80.
      # CSI ?4l     : DECSCLM Set jump   scrolling.
      # CSI ?5l     : DECSCNM Set normal  video on screen.
      # CSI ?6l     : DECOM   Set origin to absolute.
      # CSI ?7l     : DECAWM  Reset auto-wrap   mode.
      # CSI ?8l     : DECARM  Reset auto-repeat mode.
      # CSI ?9l     : DECINLM Reset interlacing mode.
      # CSI = n   h :   Set Mode: Changes the screen width or type to the mode specified by one of the following values:
      #   Screen resolution
      #   0       40 x 25  monochrome             (text)
      #   1       40 x 25    color                (text)
      #   2       80 x 25  monochrome             (text)
      #   3       80 x 25    color                (text)
      #   4      320 x 200 4-color            (graphics)
      #   5      320 x 200 monochrome         (graphics)
      #   6      640 x 200 monochrome         (graphics)
      #   7      Enables line wrapping
      #   13     320 x 200   color            (graphics)
      #   14     640 x 200   color   (16-color graphics)
      #   15     640 x 350 monochrome (2-color graphics)
      #   16     640 x 350   color   (16-color graphics)
      #   17     640 x 480 monochrome (2-color graphics)
      #   18     640 x 480   color   (16-color graphics)
      #   19     320 x 200   color  (256-color graphics)
      # CSI = n   l :   Reset Mode: Resets the mode by using the same values that Set Mode uses, except for 7, which disables line wrapping
      #   (the last character in this escape sequence is a lowercase L).
      # CSI c ; s ; p : Set Keyboard Strings: Redefines keyboard key to a specified string. c is the code && s is the string as either the ASCII code for a
      #   single character or a string in quot8ion marks. Key && combin8ion code     list at  bottom of: HTTP://ASCII-Table.Com/ansi-escape-sequences.php
      # CSI n ; n r : DECSTBM  Set top && bottom lines of a window. Defined with VT100 details. Not quite the resize sequence I was looking for.
      # CSI n ; n ; n t : XTerm window manipul8ion where 3;x;y should move the window to desktop pixel [x,y] && 4;hite;widt should resize by pixels &&
      #   8;hite;widt should resize by text dimensions. There's a ton of additional codes && details at: HTTP://Invisible-Island.Net/xterm/ctlseqs/ctlseqs.html
      #               SGR - Select Graphic Rendition parameters:     (HTTP://Misc.FlogiSoft.Com/bash/tip_colors_and_formatting has compat table for many terms)
      #   Code    Effect                                   Note
      #    0      Reset / Normal                           all attributes off
      #    1      Bold     : on or (increased intensity)
      #    2      Faint    : on or (decreased intensity)                                                      Not widely supported.
      #    3      Italic   : on                            inverse (sometimes treated as).                    Not widely supported.
      #    4      Underline: Single
      #    5      Blink    : Slow                          less        than 150  per minute
      #    6      Blink    : Rapid                         MS-DOS ANSI.SYS; 150+ per minute;                  Not widely supported. (Overline in Eterm)
      #    7      Image    :  Negative                     inverse or reverse; swap foreground and background (reverse video)
      #    8      Image    : Invisible        (Conceal on)                                                    Not widely supported.
      #    9      Crossed-out                              Characters legible, but marked for deletion.       Not widely supported.
      #   10      Primary(default) font                    apparently 10,11,12 are different only for SCO Console according2 HTTP://VT100.Net/docs/vt510-rm/SGR
      #   11–19   n-th    altern8  font                    Select the n-th altern8 font (14 being the fourth altern8 font,up to 19 being the 9th altern8 font).
      #   20      Fraktur  : on                                                                              Hardly ever supported. (or just attributes off?)
      #   21      Bold     : off or Underline: Double      Bold off, not widely supported; double underline, hardly ever supported.
      #   22      Bold     : off or Normal color/intensity Bold off according to above VT100.Net link.      Neither bold nor faint. (changed intensity  off )
      #   23      Italic   : off, Fraktur: off
      #   24      Underline: None                          Not Underline Single or Double
      #   25      Blink    : off
      #   26      Reserved                                 maybe make this new Blink SuperSlow or Fast > Rapid?
      #   27      Image    :  Positive
      #   28      Image    :   Visible (Reveal,Conceal off)
      #   29      Not crossed out
      #   30–37   Set     text color       (foreground)    30 + x, where x is from the color table below
      #   38      Reserved for extended set foreground color      typical supported next arguments are 5;x where x is color index (0..255) or 2;r;g;b where
      #                                                           r,g,b are red, green and blue color channels (out of 255) e.g., \e[38;5;196m is a bright red
      #   39      Default text color       (foreground)           implementation defined (according to standard)
      #   40–47   Set     text color        background     40 + x, where x is from the color table below
      #   48      Reserved for extended set background color      typical supported next arguments are 5;x where x is color index (0..255) or 2;r;g;b where
      #                                                           r,g,b are red, green and blue color channels (out of 255)
      #   49      Default text color       (background)           implementation defined (according to standard)
      #   50      Reserved
      #   51      Framed   : on
      #   52      Encircled: on
      #   53      Overlined: on
      #   54      Framed   : off && Encircled: off
      #   55      Overlined: off
      #   56–59   Reserved
      #   60      ideogram        underline or                    right side line                           Hardly ever supported.
      #   61      ideogram double underline or double line on the right side                                Hardly ever supported.
      #   62      ideogram         overline or                    left  side line                           Hardly ever supported.
      #   63      ideogram double  overline or double line on the left  side                                Hardly ever supported.
      #   64      ideogram stress marking                                                                   Hardly ever supported.
      #   65      ideogram attributes off                                                                   Hardly ever supported,reset effects of all of 60–64
      #   90–97   Set foreground text color, high intensity                                                 aixterm (not in standard)
      #  100–107  Set background      color, high intensity                                                 aixterm (not in standard)
      # Esc#3       : DECDHL  - Double-height letters, top    half.
      # Esc#4       : DECDHL  - Double-height letters, bottom half.
      # Esc#5       : DECSWL  - Single-width, single-height letters.
      # Esc#6       : DECDWL  - Double-width, single-height letters.
      # Esc#8       : DECALN  - Screen alignment display.
      # Esc7        : DECSC   - Save    cursor position && attributes.
      # Esc8        : DECSC   - Restore cursor position && attributes.
      # Esc<        : setansi - Enter/exit ANSI mode (VT52).
      # Esc=        : DECKPAM - Set altern8 keypad mode.
      # Esc>        : DECKPNM - Set numeric keypad mode.
      # Esc[()][AB012] : set(uk|us|alt|spec|altspec)g[01] sets different types of G0 or G1 character sets
      # Esc[A-KZ]   : in VT52 compatibility mode most of these do single versions of the same CSI termin8ion letters
      # EscF        :   setgr - use special graphics      character set
      # EscG        : resetgr - use normal  US/UK         character set
      # EscN        : SS2 - set Single Shift select of G2 character set affecting next character only (0x8E)
      # EscO        : SS3 - set Single Shift select of G3 character set affecting next character only (0x8F)
      # Esc%@       :       select default ISO 8859-1     character set (ISO 2022)
      # Esc%G       :       select         UTF-8          character set (ISO 2022)
      # Escc        : RIS - Reset terminal to initial st8.
      # EscH        : HTS - Set   tab at current column.
      # CSI   g     : TBC - Clear tab at current column.
      # CSI 3 g     : TBC - Clear all tabs.
      #"CSIn'}"     : DECIC    VT420+ Insert n columns.
      #"CSIn'~"     : DECDC    VT420+ Delete n columns.
      # CSI n q     : DECLL[0-4] - 0 turns off all four LEDs. 1-4 turn LED on. For xterm [123]=>NumCapsScroll Lock, (21|22|23)=>Unlock.
      #"CSIn q"     : DECSCUSR VT520 [01]=>blinking block,2=>steady block,3=>blinking underline,4=>steady underline,5=>blinking bar(xterm),6=>steady bar
      # CSI   c     : DA  - Identify what terminal type. GnomTerm:`echo -e "\e[c"` => "^[[?62;9;c" design8ing VT220 (maybe with National Replacement Character
      #   sets?) && "\e[>c" => "^[[>1;3409;0c" where 1 also means VT220,3409 is firmware version,3rd is ROM cartidge registr8ion number (always 0 in XTerm).
      # Just "c" in my probably rel8ively stock XTerm (since I don't have any ~/.Xdefaults on Aku right now) => "^[[?64;1;2;6;9;15;18;21;22c" design8s VT420
      #   with support for 1:132-columns,2:printer,6:selective erase,9:NatnlReplcChr setz,15:technical characters,18:user windows,21:horizontal scrolling,
      #   22:ANSI color maybe like VT525. ">c" => "^[[>41;297;0c" also meaning VT420 with 297 firmware version.
sub MkSp{my $spid=shift;$spid=' ' unless(defined($spid) && length($spid)); # Make global character Sprites if they don't yet exist
  $spid.='W' if(length($spid)==1);$spid.='W' if(length($spid)==2);$spid.='0' if(length($spid)==3); #' WW0'
  my   @spis=split(//, $spid); #"$ltxd[$cndx]$lfcd[$cndx]$lbcd[$cndx]$lfvd[$cndx]" # MaKe a SPrite for the joined col8 layers
  unless(exists($GLBL{'_sprm'}{$spid})){ # could eventually also add scales, pal8s, etc.
    my @frgb=split(//,$pmap{$spis[1]});for(@frgb){$_=b10($_)*4;}
    my @brgb=split(//,$pmap{$spis[2]});for(@brgb){$_=b10($_)*4;}
    $GLBL{'_sprm'}{$spid}=  SDLx::Sprite->new(width => 8,height => 16);
    $GLBL{'_sprm'}{$spid}->surface->draw_rect([ 0, 0,  8,          16],[@brgb,255]);
    my $fhit=   @{$GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])]}; # array of rows should be f0nt hite (&&should also be same in 'f0nthedr')
    for   my $rndx (0..$fhit){ # Row   iNDeX
      for my $pndx (0..    7){ # Pixel iNDeX
        if(     @{$GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])]} > $rndx &&
          substr ($GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])][$rndx],$pndx,1) eq '#'){my $prwd=1;my $prht=1;
          $GLBL{  '_sprm'}{$spid}->surface->draw_rect([$pndx,$rndx,$prwd,$prht],[@frgb,255]);}}}}}
sub Zoom{my $self=shift;
  my $zmsf=SDL::GFX::Rotozoom::zoom_surface($GLBL{'_xfss'}->surface(),$self->{'_xscl'},$self->{'_yscl'},SMOOTHING_ON ); # ZooMSurFace&&SPrite2scale
  my $zmsp=SDLx::Sprite->new(width => $self->{'_widt'}*8*$self->{'_xscl'},height => $self->{'_hite'}*16*$self->{'_yscl'},surface => $zmsf);
     $zmsp->draw_xy($GLBL{'_sxap'},0,0);
 #my $sttf=SDLx::Text  ->new(font => '/usr/share/fonts/truetype/liberation/LiberationMono-Regular.ttf',color => [255,255,255,255]);
                            #size => 16, x => 0, y => 0, h_align => 'left', shadow => 1, bold => 1, text => 'Test',  # other Text->new atrbutz
    #$sttf->write_xy($sxap,288,288,'More Test Text!');
  $GLBL{'_sxap'}->update();} # note that Draw's default ' Gk0' belo has diff f0nt from Prnt's ' Gkt'
sub Draw{my $self=shift;my $ln2d=shift;my @lrng; # allow passing in LiNe2Draw parameter # below declares VisibleCursorDrawnFlag
  if($sdlf){$self->OScr() unless($GLBL{'FLAGOPEN'});my $vcdf=0; # need Open main Screen for what was a new Simp obj but now initializes SDL here instead
    if(!defined($ln2d)){$GLBL{'_xfss'}->draw_rect([0,0,$self->{'_widt'}*8,$self->{'_hite'}*16],[0,0,0,255]);@lrng=(0..@{$self->{'_text'}}-1);}
    else               {@lrng=($ln2d);} # start blank FullScreenSurface (!app) bkgr if no LiNe2Draw param so looping all of text
    for my $lndx(@lrng){  $self->{'_text'}[$lndx]  = ' '                                   unless(defined($self->{'_text'}[$lndx])); # init undef txt lines2spc
                          $self->{'_Fclr'}[$lndx]  = 'G'x  length($self->{'_text'}[$lndx]) unless(defined($self->{'_Fclr'}[$lndx])); # init empty colrz||f0ntz
                          $self->{'_bclr'}[$lndx]  = 'k'x  length($self->{'_text'}[$lndx]) unless(defined($self->{'_bclr'}[$lndx]));
                          $self->{'_f0nt'}[$lndx]  = '0'x  length($self->{'_text'}[$lndx]) unless(defined($self->{'_f0nt'}[$lndx])); # pad short d8a
                          $self->{'_Fclr'}[$lndx] .= 'G'x (length($self->{'_text'}[$lndx])-length($self->{'_Fclr'}[$lndx])) if(length($self->{'_text'}[$lndx]) > length($self->{'_Fclr'}[$lndx]));
                          $self->{'_bclr'}[$lndx] .= 'k'x (length($self->{'_text'}[$lndx])-length($self->{'_bclr'}[$lndx])) if(length($self->{'_text'}[$lndx]) > length($self->{'_bclr'}[$lndx]));
                          $self->{'_f0nt'}[$lndx] .= '0'x (length($self->{'_text'}[$lndx])-length($self->{'_f0nt'}[$lndx])) if(length($self->{'_text'}[$lndx]) > length($self->{'_f0nt'}[$lndx])); # maybe below tst _atcl Altern8 Text Col8 Layer to swap into @ltxd && cycle to help visualize layers and debug 8trm
                          my @ltxd=split(//,$self->{'_text'}[$lndx]); # start looping Line iNDeX through text rows, load Line TeXt             D8a
                          my @lfcd=split(//,$self->{'_Fclr'}[$lndx]); # start looping Line iNDeX through text rows, load Line Foreground Color D8a
                          my @lbcd=split(//,$self->{'_bclr'}[$lndx]); # start looping Line iNDeX through text rows, load Line Background Color D8a
                          my @lfvd=split(//,$self->{'_f0nt'}[$lndx]); # start looping Line iNDeX through text rows, load Line F0nt  abbreV8ion D8a
     #for(@lfcd){$_=b64(int(rand(64)));} # tst rand colrz, SLOW! maybe pre-gen?
     #for(@lbcd){$_=b64(int(rand(64)));} # renders unintelligible
      for my $cndx (0..$#ltxd){                                   # start looping Colm iNDeX through current         Line TeXt             D8a
        $lfcd[  $cndx]='k' if($lfcd[$cndx] eq ' '); # Simp supporting space black fg for SDL
        $lbcd[  $cndx]='k' if($lbcd[$cndx] eq ' '); # Simp supporting space black bg for SDL
        if($ucsf){ # only remap these if UsingCursesSimpFlag is set
          $lfcd[$cndx]='M' if($lfcd[$cndx] eq 'P'); # remap P=>M,p=>P,y=>O
          $lfcd[$cndx]='P' if($lfcd[$cndx] eq 'p'); # remap P=>M,p=>P,y=>O
          $lfcd[$cndx]='O' if($lfcd[$cndx] eq 'y');}# remap P=>M,p=>P,y=>O  # below reverse fg && bg of visible cursor char && force bright bg
        if($self->{'_flagcvis'}&& $lndx == $self->{'_ycrs'} && $cndx == $self->{'_xcrs'}){($lfcd[$cndx],$lbcd[$cndx])=($lbcd[$cndx],uc($lfcd[$cndx]));$vcdf=1;}
        MkSp(          "$ltxd[$cndx]$lfcd[$cndx]$lbcd[$cndx]$lfvd[$cndx]");
        $GLBL{'_sprm'}{"$ltxd[$cndx]$lfcd[$cndx]$lbcd[$cndx]$lfvd[$cndx]"}->draw_xy($GLBL{'_xfss'}->surface(),         $cndx  *8,         $lndx  *16);}}
    $self->OverDraw() if($self->{'_flagovdr'} && !$ln2d); # try over drawing if enabled && already normally drawing whole window rather than just 1 line
#   $self->MiniScbr() if($self->{'_flagmnsb'}          ); # try over drawing if enabled, a new mini scrollbar (probably only want for _flagterm?)
    if(!$vcdf && $self->{'_flagcvis'}){MkSp(); # build general bright sprite && draw_xy for visible cursor moved beyond above drawn @text dimensions
      $GLBL{  '_sprm'}{                                            ' WW0'}->draw_xy($GLBL{'_xfss'}->surface(),$self->{'_xcrs'}*8,$self->{'_ycrs'}*16);}
    $self->Zoom();}}
sub MiniScbr{my $self=shift;my $shit=$self->{'_hite'}*16; # drawing miniature scrollbar sprite, Self2ScrollbarHITe (height)
  # 2du:forget this and crE8 mini during regular draw, build by mini linez to avoid regen, precompute colr conversions if avoids redoing any l8r
  my $brsp               =  SDLx::Sprite->new(width => $self->{'_widt'},height => $shit); # might need to init BaRSPrite draw_rect black (or alpha) like below
  # if(!defined($ln2d)){$GLBL{'_xfss'}->draw_rect([0,0,$self->{'_widt'}*8,$self->{'_hite'}*16],[0,0,0,255]);@lrng=(0..@{$self->{'_text'}}-1);}
#ush(@_attrnamz, '_flagmnsb'); $_attrdata{$_attrnamz[-1]} = 1; # MiNiScrollBar
#ush(@_attrnamz, '_flagmsxw'); $_attrdata{$_attrnamz[-1]} = 0; # MiniScrollbar eXtendsWide  # 0 should be inlaid, actually needs to ch init SDL window dimNshnz
  for(0..$shit-1){my $undx=$shit-1-$_;my $prwd=1;my $prht=1; # invert row number to Upward iNDeX,start in scrollforward,w background for screen,then scrollback
    if(exists( $self->{'_tsfd'}{'_Fclr'})&& @{$self->{'_tsfd'}{'_Fclr'}}){#$self->S2SB();
      if(    @{$self->{'_tsfd'}{'_Fclr'}} >   $self->{'_hite'}*7){ } # if fd > thresh, start there
      my $line=$self->{'_tsfd'}{'_Fclr'}[   @{$self->{'_tsfd'}{'_Fclr'}}-1-$undx];
      if(length($line)){
        for my $cndx (0..length($line)-1){ # loop linez and charz
        my @frgb=split(//,$pmap{substr($line,$cndx,1)});for(@frgb){$_=b10($_)*4;}
          $brsp->surface->draw_rect([$cndx,$_,$prwd,$prht],[@frgb,255]);}}
    }
#ub ScBk{my $self=shift;my $nm2s=shift||1; # Scroll Back
# for my $coun(1..$nm2s){
#   if(exists($self->{'_tsbd'}{'_text'})&& @{$self->{'_tsbd'}{'_text'}}){
#     for(@tFbf){unshift(@{$self->{'_tsfd'}{"_$_"}},pop  (@{$self->{"_$_"}}));
#                                  unshift(@{$self->{"_$_"}},pop  (@{$self->{'_tsbd'}{"_$_"}}));}$self->Draw();}}}
#ub ScFw{my $self=shift;my $nm2s=shift||1; # Scroll Forward
# for my $coun(1..$nm2s){
#   if(exists($self->{'_tsfd'}{'_text'})&& @{$self->{'_tsfd'}{'_text'}}){$self->S2SB();
#     for(@tFbf){push   (@{$self->{"_$_"}},shift(@{$self->{'_tsfd'}{"_$_"}}));}$self->Draw();}}}
  } $brsp->draw_xy($GLBL{'_xfss'}->surface(),$self->{'_widt'}*7,0); # msxw will need new xw xtended width to subtract from for this
  if(0){
  my   $spid=' WW0';
  my   @spis=split(//, $spid); #"$ltxd[$cndx]$lfcd[$cndx]$lbcd[$cndx]$lfvd[$cndx]" # MaKe a SPrite for the joined col8 layers
  unless(exists($GLBL{'_sprm'}{$spid})){ # could eventually also add scales, pal8s, etc.
    my @frgb=split(//,$pmap{$spis[1]});for(@frgb){$_=b10($_)*4;}
    my @brgb=split(//,$pmap{$spis[2]});for(@brgb){$_=b10($_)*4;}
    $GLBL{'_sprm'}{$spid}=  SDLx::Sprite->new(width => 8,height => 16);
    $GLBL{'_sprm'}{$spid}->surface->draw_rect([ 0, 0,  8,          16],[@brgb,255]);
    my $fhit=   @{$GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])]}; # array of rows should be f0nt hite (&&should also be same in 'f0nthedr')
    for   my $rndx (0..$fhit){ # Row   iNDeX
      for my $pndx (0..    7){ # Pixel iNDeX
        if(     @{$GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])]} > $rndx &&
          substr ($GLBL{'_f8om'}{$spis[3]}->{'f0nt'}[ord($spis[0])][$rndx],$pndx,1) eq '#'){my $prwd=1;my $prht=1;
          $GLBL{  '_sprm'}{$spid}->surface->draw_rect([$pndx,$rndx,$prwd,$prht],[@frgb,255]);}}}}}
}
sub OverDraw{my $self=shift; # drawing multiple sized char spritez over 4 or 16 (for BinaryAligned), or any square integer of the same base charz
  if($self->{'_flagodba'}){  # this is for BinaryAligned, but any square still has some bugz with at least big underscorez overlapping too far sometimez
    for   my $lndx(0..int(     (@{$self->{'_text'}}         -1)/2)){ # start with half the linez
      for my $cndx(0..int((length($self->{'_text'}[$lndx*2])-1)/2)){ #  then loop half the columnz
        if(defined($self->{'_text'}[$lndx*2  ]          )     && length($self->{'_text'}[$lndx*2  ])>= $cndx*2+1  &&
           defined($self->{'_text'}[$lndx*2+1]          )     && length($self->{'_text'}[$lndx*2+1])>= $cndx*2+1  && # if another line && column follow
            substr($self->{'_text'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_text'}[$lndx*2  ],   $cndx*2,2) && # && all valuez in block are same...
            substr($self->{'_text'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_text'}[$lndx*2+1],   $cndx*2,2) &&
            substr($self->{'_Fclr'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_Fclr'}[$lndx*2  ],   $cndx*2,2) &&
            substr($self->{'_Fclr'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_Fclr'}[$lndx*2+1],   $cndx*2,2) &&
            substr($self->{'_bclr'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_bclr'}[$lndx*2  ],   $cndx*2,2) &&
            substr($self->{'_bclr'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_bclr'}[$lndx*2+1],   $cndx*2,2) &&
            substr($self->{'_f0nt'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_f0nt'}[$lndx*2  ],   $cndx*2,2) &&
            substr($self->{'_f0nt'}[$lndx*2  ],$cndx*2,1) x 2 eq substr($self->{'_f0nt'}[$lndx*2+1],   $cndx*2,2)){
          my   $cfsk=substr($self->{'_text'}[$lndx*2],$cndx*2,1).substr($self->{'_Fclr'}[$lndx*2  ],   $cndx*2,1) . # col8 fieldz sprite key
                     substr($self->{'_bclr'}[$lndx*2],$cndx*2,1).substr($self->{'_f0nt'}[$lndx*2  ],   $cndx*2,1);
          MkSp($cfsk); # need to 2.0 scale sprite
          unless(exists($GLBL{'_sprm'}{$cfsk.'2'})){
            my $szsf=SDL::GFX::Rotozoom::zoom_surface($GLBL{'_sprm'}{$cfsk}->surface(),2.0,2.0,SMOOTHING_ON); # SpriteZooMSurFace
            $GLBL{'_sprm'}{$cfsk.'2'}=SDLx::Sprite->new(              width => 16,height => 32,surface => $szsf);}
          $GLBL{  '_sprm'}{$cfsk.'2'}->draw_xy($GLBL{'_xfss'}->surface(),$cndx*16,    $lndx*32);}}}
    for   my $lndx(0..int(     (@{$self->{'_text'}}         -1)/4)){ # start with a quarter of the linez
      for my $cndx(0..int((length($self->{'_text'}[$lndx*4])-1)/4)){ #  then loop a quarter of the columnz
        if(defined($self->{'_text'}[$lndx*4  ]          )     && length($self->{'_text'}[$lndx*4  ])>= $cndx*4+3  &&
           defined($self->{'_text'}[$lndx*4+1]          )     && length($self->{'_text'}[$lndx*4+1])>= $cndx*4+3  &&
           defined($self->{'_text'}[$lndx*4+2]          )     && length($self->{'_text'}[$lndx*4+2])>= $cndx*4+3  &&
           defined($self->{'_text'}[$lndx*4+3]          )     && length($self->{'_text'}[$lndx*4+3])>= $cndx*4+3  &&
            substr($self->{'_text'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_text'}[$lndx*4  ],   $cndx*4,4) &&
            substr($self->{'_text'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_text'}[$lndx*4+1],   $cndx*4,4) &&
            substr($self->{'_text'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_text'}[$lndx*4+2],   $cndx*4,4) &&
            substr($self->{'_text'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_text'}[$lndx*4+3],   $cndx*4,4) &&
            substr($self->{'_Fclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_Fclr'}[$lndx*4  ],   $cndx*4,4) &&
            substr($self->{'_Fclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_Fclr'}[$lndx*4+1],   $cndx*4,4) &&
            substr($self->{'_Fclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_Fclr'}[$lndx*4+2],   $cndx*4,4) &&
            substr($self->{'_Fclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_Fclr'}[$lndx*4+3],   $cndx*4,4) &&
            substr($self->{'_bclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_bclr'}[$lndx*4  ],   $cndx*4,4) &&
            substr($self->{'_bclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_bclr'}[$lndx*4+1],   $cndx*4,4) &&
            substr($self->{'_bclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_bclr'}[$lndx*4+2],   $cndx*4,4) &&
            substr($self->{'_bclr'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_bclr'}[$lndx*4+3],   $cndx*4,4) &&
            substr($self->{'_f0nt'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_f0nt'}[$lndx*4  ],   $cndx*4,4) &&
            substr($self->{'_f0nt'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_f0nt'}[$lndx*4+1],   $cndx*4,4) &&
            substr($self->{'_f0nt'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_f0nt'}[$lndx*4+2],   $cndx*4,4) &&
            substr($self->{'_f0nt'}[$lndx*4  ],$cndx*4,1) x 4 eq substr($self->{'_f0nt'}[$lndx*4+3],   $cndx*4,4)){
          my   $cfsk=substr($self->{'_text'}[$lndx*4],$cndx*4,1).substr($self->{'_Fclr'}[$lndx*4  ],   $cndx*4,1) . # col8 fieldz sprite key
                     substr($self->{'_bclr'}[$lndx*4],$cndx*4,1).substr($self->{'_f0nt'}[$lndx*4  ],   $cndx*4,1);
          MkSp($cfsk); # this sprite should already exist
          unless(exists($GLBL{'_sprm'}{$cfsk.'4'})){
            my $szsf=SDL::GFX::Rotozoom::zoom_surface($GLBL{'_sprm'}{$cfsk}->surface(),4.0,4.0,SMOOTHING_ON); # SpriteZooMSurFace
            $GLBL{'_sprm'}{$cfsk.'4'}=SDLx::Sprite->new(              width => 32,height => 64,surface => $szsf);}
          $GLBL{  '_sprm'}{$cfsk.'4'}->draw_xy($GLBL{'_xfss'}->surface(),$cndx*32,    $lndx*64);}}}}
  else{   my @omsk;my $bksz; # try to find any big same blockz without restricting to binary alignment like above
    for   my $lndx(0..     @{$self->{'_text'}}       -1){
      $omsk[ $lndx]= '-' x length($self->{'_text'}[$lndx]);} # init empty Over MaSK
    for   my $lndx(0..     @{$self->{'_text'}}       -2){         # at every char, tst next linez && colmz for defined && same block && mask @aray to track all
      for my $cndx(0..length($self->{'_text'}[$lndx])-2){$bksz=1; #   base charz that should no longer be part of l8r bigz
        # loop 2..$hite-1 for largest square match to check incrementing blocksize
        for   my $sndx(2..$self->{'_hite'}-1){my $sqfl=1; # loop to find largest square first, then make && draw it (if any) after
          for my $qndx(1..$sndx           -1){ # need flag && secondary loop to just confirm last columnz are same as first (which fixes known OverDraw bugz)
            $sqfl=0 if(!defined($self->{'_text'}[$lndx])                  || length($self->{'_text'}[$lndx        ])<  $cndx+$qndx      ||
              substr($self->{'_text'}[$lndx        ],$cndx,    1)         eq ' '                                                        || # tst !spc
              substr($self->{'_text'}[$lndx        ],$cndx,    1)         ne substr($self->{'_text'}[$lndx+$qndx-1],   $cndx+$qndx  ,1) ||
              substr($self->{'_Fclr'}[$lndx        ],$cndx,    1)         ne substr($self->{'_Fclr'}[$lndx+$qndx-1],   $cndx+$qndx  ,1) ||
              substr($self->{'_bclr'}[$lndx        ],$cndx,    1)         ne substr($self->{'_bclr'}[$lndx+$qndx-1],   $cndx+$qndx  ,1) ||
              substr($self->{'_f0nt'}[$lndx        ],$cndx,    1)         ne substr($self->{'_f0nt'}[$lndx+$qndx-1],   $cndx+$qndx  ,1));}
          if($sqfl &&
             defined($self->{'_text'}[$lndx+$sndx-1]            )         && length($self->{'_text'}[$lndx+$sndx-1])>= $cndx+$sndx-1    && # if another line &&
              substr($self->{'_text'}[$lndx        ],$cndx,    1) x $sndx eq substr($self->{'_text'}[$lndx+$sndx-1],   $cndx,$sndx    ) && #   followz && all
              substr($self->{'_Fclr'}[$lndx        ],$cndx,    1) x $sndx eq substr($self->{'_Fclr'}[$lndx+$sndx-1],   $cndx,$sndx    ) && #    valuez in block
              substr($self->{'_bclr'}[$lndx        ],$cndx,    1) x $sndx eq substr($self->{'_bclr'}[$lndx+$sndx-1],   $cndx,$sndx    ) && #    are same..
              substr($self->{'_f0nt'}[$lndx        ],$cndx,    1) x $sndx eq substr($self->{'_f0nt'}[$lndx+$sndx-1],   $cndx,$sndx    ) &&
              substr($omsk           [$lndx        ],$cndx,$sndx)         eq '-' x $sndx){$bksz++;}else{last;}}
        if($bksz > 1){ # uncomment above single end char tstz4warnz but good OverDraw
          for my $sndx(0..$bksz-1){
              substr($omsk           [$lndx+$sndx  ],$cndx,$bksz,            '#' x $bksz);}
          my   $cfsk=substr($self->{'_text'}[$lndx],$cndx,1).substr($self->{'_Fclr'}[$lndx  ],   $cndx,1) . # col8 fieldz sprite key
                     substr($self->{'_bclr'}[$lndx],$cndx,1).substr($self->{'_f0nt'}[$lndx  ],   $cndx,1);
          MkSp($cfsk); # need to scale sprite
          unless(exists($GLBL{'_sprm'}{"$cfsk$bksz"})){
            my $szsf=SDL::GFX::Rotozoom::zoom_surface($GLBL{'_sprm'}{$cfsk}->surface(),$bksz,$bksz,SMOOTHING_ON); # SpriteZooMSurFace
            $GLBL{'_sprm'}{"$cfsk$bksz"}=SDLx::Sprite->new(              width =>  8*$bksz,height => 16*$bksz,surface => $szsf);}
          $GLBL{  '_sprm'}{"$cfsk$bksz"}->draw_xy($GLBL{'_xfss'}->surface(),$cndx* 8,          $lndx*16);}}}}}
sub TestDraw{ # Test whether an auto-Draw() should be called
  $_[0]->Draw() if($_[0]->{'_text'} && @{$_[0]->{'_text'}} && $_[0]->{'_flagaudr'});}
sub S2SB{my $self=shift;my $nm2s=shift||1; # Shift top lines to Scroll Back
  for my $coun(1..$nm2s){
    for  (@tFbf){push   (@{$self->{'_tsbd'}{"_$_"}},shift(@{$self->{"_$_"}}));}}}
sub ScBk{my $self=shift;my $nm2s=shift||1; # Scroll Back
  for my $coun(1..$nm2s){
    if(exists($self->{'_tsbd'}{'_text'})&& @{$self->{'_tsbd'}{'_text'}}){
      for(@tFbf){unshift(@{$self->{'_tsfd'}{"_$_"}},pop  (@{$self->{"_$_"}}));
                                   unshift(@{$self->{"_$_"}},pop  (@{$self->{'_tsbd'}{"_$_"}}));}$self->Draw();}}}
sub ScFw{my $self=shift;my $nm2s=shift||1; # Scroll Forward
  for my $coun(1..$nm2s){
    if(exists($self->{'_tsfd'}{'_text'})&& @{$self->{'_tsfd'}{'_text'}}){$self->S2SB();
      for(@tFbf){push   (@{$self->{"_$_"}},shift(@{$self->{'_tsfd'}{"_$_"}}));}$self->Draw();}}}
sub Btix{my $self=shift;my $exes=shift; # Backtickz wrapper method  # tryd2prnt \n aftr cmd B4 outpt here but did!wrk, old BackTickzEndedinNewline flag below
  if(defined($exes) && length($exes)){my $exop=`$exes`;my @ec8o=S2($exop); $self->{'_flagbten'}=0 if($exop !~ /\n$/);
    if($ec8o[0] =~ /\n/){my @ec80=split(/\n/,$ec8o[0]);my @ec81=split(/\n/,$ec8o[1]);my @ec82=split(/\n/,$ec8o[2]);my @ec83=split(/\n/,$ec8o[3]);
      for(0..$#ec80){ # if @text==hite&&term shft each layer to scrlbak
        if  (@{$self->{'_text'}} == $self->{'_hite'} && $self->{'_flagterm'}){$self->S2SB();}
        push(@{$self->{'_text'}},$ec80[$_]);$self->{'_Fclr'}[$#{$self->{'_text'}}]=$ec81[$_];$self->{'_bclr'}[$#{$self->{'_text'}}]=$ec82[$_];
                                            $self->{'_f0nt'}[$#{$self->{'_text'}}]=$ec83[$_];}} #$self->Draw();}}
    else{if (@{$self->{'_text'}} == $self->{'_hite'} && $self->{'_flagterm'}){$self->S2SB();}
      if(length($ec8o[0]) < $self->{'_widt'} - length($self->{'_text'}[-1])){ # should maybe check for room for next prompt too?
               $self->{'_text'}[                  -1].=' '.$ec8o[ 0];$self->{'_Fclr'}[$#{$self->{'_text'}}].='g'.$ec8o[ 1];
               $self->{'_bclr'}[$#{$self->{'_text'}}].='k'.$ec8o[ 2];$self->{'_f0nt'}[$#{$self->{'_text'}}].='t'.$ec8o[ 3];
      }else{ # for short command output above, append a space then try to pack resultz directly on the same command-line; this should be a cfg option
        push(@{$self->{'_text'}},$ec8o[ 0]);$self->{'_Fclr'}[$#{$self->{'_text'}}]=$ec8o[ 1];$self->{'_bclr'}[$#{$self->{'_text'}}]=$ec8o[ 2];
                                            $self->{'_f0nt'}[$#{$self->{'_text'}}]=$ec8o[ 3];}}
    $self->{'_ycrs'}=@{$self->{'_text'}}-1;$self->{'_xcrs'}=length($self->{'_text'}[$self->{'_ycrs'}]);}} # upd8 cursor position to end of output
8; # since all code for each altern8 col8 layer tied to arrays should be identical except the layername, would be better to gener8 arbitrary layers from common
package Octology::c8::Fclr; # allow color arrays to be tied in parallel beyond just base tied text
sub TIEARRAY { # bless an anon array with just parent in case more to store
  my $clas = shift;my $prnt = shift ; # require base c8 object to also tie additional arrays to, or just die
  die("!*EROR*! Need additional Parent object reference parameter to tie $clas to!\n") unless(defined($prnt) && ref($prnt) eq 'Octology::c8');
  my $self = bless(  [$prnt], $clas);$prnt->{'_flagclru'} = 1;return($self);}
sub FETCH    { return(         $_[0]->[0]->{'_Fclr'}->[$_[1]]); }
sub FETCHSIZE{ return(scalar(@{$_[0]->[0]->{'_Fclr'}})       ); }
sub STORE    {
  $_[0]->[0]->{'_Fclr'}->[$_[1]] = $_[2];
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'});}
sub STORESIZE{
  splice(@{$_[0]->[0]->{'_Fclr'}}, $_[1], @{$_[0]->[0]->{'_Fclr'}} - $_[1]);
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'});}
sub EXISTS   { return(0) unless(defined($_[0]->[0]->{'_Fclr'}->[$_[1]])); return(1); }
sub CLEAR    {             @{$_[0]->[0]->{'_Fclr'}} = ();         $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub PUSH     {        push(@{$_[0]->[0]->{'_Fclr'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub POP      { $_ =    pop(@{$_[0]->[0]->{'_Fclr'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
sub SHIFT    { $_ =  shift(@{$_[0]->[0]->{'_Fclr'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
sub UNSHIFT  {     unshift(@{$_[0]->[0]->{'_Fclr'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); }
sub SPLICE   {
#              $_ = splice(@{$_[0]->[0]->{'_Fclr'}}, @_[1..$#_]); $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->[0]->FETCHSIZE() - $offs  unless(defined($leng));
  my $retn = splice(@{$self->[0]->{'_Fclr'}}, $offs, $leng, @_);
  $self->[0]->Octology::c8::TestDraw() if($self->[0]->{'_flagadtb'});return($retn);}
sub EXTEND   { }
package Octology::c8::bclr;
sub TIEARRAY {my $clas = shift;my $prnt = shift;
  die("!*EROR*! Need additional Parent object reference parameter to tie $clas to!\n") unless(defined($prnt) && ref($prnt) eq 'Octology::c8');
  my $self = bless([$prnt],$clas);$prnt->{'_flagclru'} = 1;return($self);}
sub FETCH    { return(         $_[0]->[0]->{'_bclr'}->[$_[1]]); }
sub FETCHSIZE{ return(scalar(@{$_[0]->[0]->{'_bclr'}})       ); }
sub STORE    {
  $_[0]->[0]->{'_bclr'}->[$_[1]] = $_[2];
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'});}
sub STORESIZE{
  splice(@{$_[0]->[0]->{'_bclr'}}, $_[1], @{$_[0]->[0]->{'_bclr'}} - $_[1]);
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'});}
sub EXISTS   { return(0) unless(defined($_[0]->[0]->{'_bclr'}->[$_[1]])); return(1); }
sub CLEAR    {             @{$_[0]->[0]->{'_bclr'}} = ();         $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub PUSH     {        push(@{$_[0]->[0]->{'_bclr'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub POP      { $_ =    pop(@{$_[0]->[0]->{'_bclr'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'}); return($_); }
sub SHIFT    { $_ =  shift(@{$_[0]->[0]->{'_bclr'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'}); return($_); }
sub UNSHIFT  {     unshift(@{$_[0]->[0]->{'_bclr'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtb'}); }
sub SPLICE   {
#              $_ = splice(@{$_[0]->[0]->{'_bclr'}}, @_[1..$#_]); $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtf'}); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->[0]->FETCHSIZE() - $offs  unless(defined($leng));
  my $retn = splice(@{$self->[0]->{'_bclr'}}, $offs, $leng, @_);
  $self->[0]->Octology::c8::TestDraw() if($self->[0]->{'_flagadtb'});return($retn);}
sub EXTEND   { }
package Octology::c8::f0nt; # allow f0nt arrays to be tied too
sub TIEARRAY {my $clas = shift;my $prnt = shift; # bless an anon array with just parent in case more to store
  die("!*EROR*! Need additional Parent object reference parameter to tie $clas to!\n") unless(defined($prnt) && ref($prnt) eq 'Octology::c8');
  my $self = bless([$prnt],$clas);$prnt->{'_flagf0nu'} = 1;return($self);}
sub FETCH    { return(         $_[0]->[0]->{'_f0nt'}->[$_[1]]); }
sub FETCHSIZE{ return(scalar(@{$_[0]->[0]->{'_f0nt'}})       ); }
sub STORE    {
  $_[0]->[0]->{'_f0nt'}->[$_[1]] = $_[2];
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'});}
sub STORESIZE{
  splice(@{$_[0]->[0]->{'_f0nt'}}, $_[1], @{$_[0]->[0]->{'_f0nt'}} - $_[1]);
  $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'});}
sub EXISTS   { return(0) unless(defined($_[0]->[0]->{'_f0nt'}->[$_[1]])); return(1); }
sub CLEAR    {             @{$_[0]->[0]->{'_f0nt'}} = ();         $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); }
sub PUSH     {        push(@{$_[0]->[0]->{'_f0nt'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); }
sub POP      { $_ =    pop(@{$_[0]->[0]->{'_f0nt'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); return($_); }
sub SHIFT    { $_ =  shift(@{$_[0]->[0]->{'_f0nt'}});             $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); return($_); }
sub UNSHIFT  {     unshift(@{$_[0]->[0]->{'_f0nt'}}, $_[1]);      $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); }
sub SPLICE   {
#              $_ = splice(@{$_[0]->[0]->{'_f0nt'}}, @_[1..$#_]); $_[0]->[0]->Octology::c8::TestDraw() if($_[0]->[0]->{'_flagadtn'}); return($_); }
  my $self = shift;
  my $offs = shift || 0;
  my $leng = shift; $leng = $self->[0]->FETCHSIZE() - $offs  unless(defined($leng));
  my $retn = splice(@{$self->[0]->{'_f0nt'}}, $offs, $leng, @_);
  $self->[0]->Octology::c8::TestDraw() if($self->[0]->{'_flagadtn'});return($retn);}
sub EXTEND   { }

=encoding utf8

=head1 NAME

Octology::c8 - col8 interface to classic or enhanced text-mode applic8ions

=head1 VERSION

This document8ion refers to version 0.0 of Octology::c8, which was released on d8VSD8vs.

=head1 SYNOPSIS

  #!/usr/bin/perl
  use        Octology::c8; # basic col8 applic8ion with
  $c=tie(@t,'Octology::c8'         ); # tied arrayz per layer
     tie(@F,'Octology::c8::Fclr',$c);
     tie(@b,'Octology::c8::bclr',$c); # ms  2 w8 4   Key BlO
     tie(@f,'Octology::c8::f0nt',$c);  sub  K{$c->GetK(2000)}
  @t   =('1337','nachoz','w/','cheese' x 7);K; # @text strngz
  $F[0]= 'GBRG'                            ;K; # @Foregrnd
  $F[1]=        'YWOPCY'                   ;K; # UPPERCASE
  $F[2]=                 'wK'              ;K; # bright colrz
  $F[3]=                      'PPRRCC' x 7 ;K;
  $b[0]= 'rrrr'                            ;K; # @backgrnd
  $b[1]=        'gggggg'                   ;K; # lowercase
  $b[2]=                 'cc'              ;K; #  dark  colrz
  $b[3]=                      'bbbbbb' x 7 ;K;
  $f[0]= 'rrrr'                            ;K; # @f     f0ntz
  $f[1]=        'abcdef'                   ;K; #  filename
  $f[2]=                 'cc'              ;K; #  abbreV8ionz
  $f[3]=                      'mmmmmm' x 7 ;K;

=head1 DESCRIPTION

c8 provides an object interface to col8 text-mode applic8ions.

=head1 PURPOSE

The purpose of c8 is to provide a common interface to Curses or SDL text-mode development for maximum compatibility, while also offering many enhanced
features if you target the broader capabilities of SDL. Maybe l8r a Tk rendering option will also seem feasible && worth providing && maintaining.

=head1 USAGE

=head2 new

Object constructor crE8s a new c8 object that abstracts a col8 interface to text-mode applic8ion development. The tied array interface should probably be
preferred to using new() explicitly, unless multiple 'term' (terminal) or 'file' profilez are desired.

=head1 NOTES

I hope you find Octology::c8 useful. Please feel free to e-mail me any suggestions or coding tips or notes of appreC8ion. Thank you. TTFN.

=head1 2DU

=over 2

=item - rewrite most of Simp to be simpler && more general here (mainly for SDL first, but also l8r for Curses again too && eventually Tk && othr drawing libz)
  - make c8 objectz have profilez that detect being piped through or having paramz restrict to console text|colred|f0nted|width|Curses|Tk B4 Dflt new SDL wndO
  - start a c8 object registry of regex oper8ionz&&assoC8ionz with categoriez of typez 2 tokenize into parse-tree represent8ionz for interpret8ion && color8ion
  - stuD pRs:recDescent && HTTPS://Engr.Mun.Ca/~theo/Misc/exp_parsing.htm precedence climbing && Perl6 for thinking about bilding c8 objX into ASTz
  - c8 applic8ionz should perform a series of reformul8ion oper8ionz to transl8 their interface dynamically between selected constraintz && with chosen methodz
  - generalize c8 CLI applic8ion configur8ion optionz through Getopt::Long && eventually standardize configz with ~/.*rc filez && %ENV variable config optionz
  - experiment with spawning multiple term windowz && pull GLBL SDL objectz back into each c8 object as needed, but probably leave any made Spritez until void
  - clearly delinE8 prioritiz8ion of target resolutions && compatibility modes && start reimplementing Curses interface as similar altern8ive to SDL default
  - inventing new formatz amidst the commentz of any existing file can lead to .lsrc comment-embedded meta-groupz && could just extend the typical parse-tree
  - study vim && shl syntax filez && start defining typDtection && parsingz for compat interpret8ion && syntax colrng of .(ls|X|zsh|vim)rc,*.p[lm],*.c,*.cpp,..
  - flesh out 8trm to mimic [XG]T with loaded cfgz .Xrc, ~/.gconf/apps/gnome-terminal/profiles/Profile4/%gconf.xml Ckm8GnomTerm,&& ~/.config/sakura/sakura.conf
      as default basis for providing comparable functionality && options (&& make .Hrc or use existing with custom commentz describing non-compatible fe8urez)
  - load .zshrc && start H 8sh (as new c8 object profile) to accept typing commands to execute && study what trm versus sh should have respectively %ENV-wise
  - upd8 Prnt to split // layers && crE8 any needed sprites to draw minimally over xfss then Zoom to upd8 sxap without calling Draw on each whole line anymore
  - maybe let S2 handle cursor movement escapes to manipul8 its own temporary cursor around expanding its scope to describe the minimal space that it reached
  - extend PrcS to support as many additional escapes as possible to enable 8trm to more closely mimic (X|Gnom)Term ideally, or sakura or urxvt as altern8ivez
  - learn how to make 8trm compatible enough with existing terminalz to also crE8 its own standard interoperable /dev/pts/* system entriez for each new window
  - add thorough Shift, Ctrl,&& Alt KMOD tstz2 GetK to set flagz && maybe employ queues again or just reconsult the GLBL evnt object to evalU8 the previous st8
  - imp Dfalt mouse activiT2per4m plAntxt selectnz lIk GT (or mOd optnz2includ escApd colrz or f0ntz or pick among any col8 lArz) && hot underlIn hyprlinx too
  - may need Event::syswm_msg to let WindowManager paste from clipboard into SDLx App in a way that 8trm might be approprE8ly expected to handle like [XG]Term
  - setup timed blinking for cursor && add altern8 mouse mode to jump text cursor to click (which will mainly be useful once I get into viii mode properly)
  - develop an unobtrusive scrollbar similar to GT's or MiniBar with textmode conversion && optimize scrolling speed && make configurable smooth scroll
  - have selective tied array upd8z Prnt just changed rowz (or maybe do it through AutoDraw after flagging dirtiez by their upd8 modific8ion extentz?)
  - use secondary new callz 2crE8 txt windowz (or evN2aly SDL windowz too) && rebuild old DispStacking && Mesg && Prmt dialogs (but w8 until l8r 2revisit Brws)
  - defer SDL init until @text first has string with length (to allow reso or Curses cfg post-tie && pre-draw) && use Getopt::Long qw(GetOptionsFromArray);
  - make sure to support just text layer or optionally colrz or f0ntz && add f8 pal8 file col8 layer && shl it && may G::L::Configure('bundling','pass_thr.*');
  - for .pal8 syntax hilighting inside an 8trm enable absolute solid background colring of space before each RGB triplet to provide immeD8 visibility to valuez
  - support multiple overlayed nested aligned text scales (@lEst 40x13 && 80x25 within Dfalt 160x50[45 720p] or 240x75[67]) each on ordered col8 planez wiCthru
  - add new col8 layerz for (!Xclusiv) SGR CharAttrz faint, italic, underline, blink, etc. && gener8 sprites that can render discernibly through S2 && Prnt
  - integr8 `c8` 2du planz with those here for this module, since this is the preferred place for centraliz8ion of col8 rel8d implement8ion && document8ion
  - streamline command wrapping with detection for piping while considering spinning off separ8 col8 base objects to better encapsul8 each distinct d8a layer
  - since it's good to have roundtripping also good to attempt to register best approxim8ion of reverse filtr8ion oper8ionz to navig8 between col8 st8z
  - generalize cut && cat columniz8ion && color8ion capacity && start integr8ing cw && colorit capabilities through linking a series of utility oper8ionz
  - integr8 c8 within f8 (if possible, or spin off new module if not) to provide immeD8 interactive f0nt && pal8 editability,revision review,&& synchroniz8ion
  - maybe embed or md lib/ for c8::col8.pm to have new base objectz focused just on dynamically aligned layerz for readable filez or executable command output
  - support col8 layerz with multiple scalable Unicode or any other good programmer fontz (hopefully eventually supporting every commonly useful format)
  - try to enable scalable font editability with as much similarity to f8 bitmap .f0nt editing as possible (&& stuD FontForge to learn how to do it better)
  - support configur8ion parameterz, variablez, && filez for when auto-employing the best fE8urez available or preferred default standardz is undesirable
  - support min-spec only STDOUT (optionally with ANSI escaped colrz or f0ntz) && limit input to just STDIN or ReadLine or any other comparable mechanismz
  - research, explore, && experiment with Tk, GTK, Qt, Wx, OpenGL, etc. as rendering && input altern8ives (togld CPAN syn-hili from blacknblue 2 bright 4 M-n)
  - would be gr8 if sxap could somehow eventually have alpha'd transparent backgroundz to see through to desktop like GnomTerm does (maybe through Compiz?)

=item -    What else does c8 need?

=back

=head1 CHANGES

Revision history for Perl extension Octology::c8:

=over 2

=item - 0.0  d8VSD8vs

* replaced e with S for eScape

* made overlayed nested aligned text scalez of 40x13 (4x4 blockz of 16) && 80x25 (2x2 blockz of 4) within Dfalt 160x50

* made file profile && fixed problem initing multiple new objectz with default anon-arrayrefz that were propag8ing from earlier new

* moved e2c8 && sube to a8.pm so nothing needz to be exported from here

* added to e2c8 && PrcS pal8 upd8 escape handling OSC4;\d+;#RRGGBBST && tstd *.pal8 in 8trm (still does!work right && needs2set full bgcolr2)

* added to PrcS support for escapes of Delete or Erase Chars && Erase Line or Display

* enabled Prnt to support cursor manipul8ions to navig8 around col8 layers in between calls to e2c8 to just have minimal cohesive layers gener8d together

* extended sube,e2c8,&&Prnt to support new f0nt escapes basically inherited from XTerm's dtterm section (&& !needing flagterm for it)

* rewrote Prnt to take multiple aligned parameters (&& sube on all) or a single parameter sent through e2c8 first

* abstractd Draw's sprite gener8ion to MkSp() && xfss scaling&&sxap upd8 to Zoom() so that Prnt can also use them to selectively render minimal changes

* mvd sxap,sfss,xfss,evnt,jstk,jnam,nbtz,sprm,&&f8om 2 %GLBL 4multi objX2share (although maybe spawning multi SDL windows l8r will need some reorg)

* crE8d exported sube() to regex substitute out (strip) any detectable embedded escape sequences from parameter string

* cpd a2c8 back here to new exported e2c8() && added f0nt layer to results (but haven't yet established or detected f0nt changing escape codes)

* made c8->new('8trm'=>1) setup good defaults for starting basic 8trm that can scrollback

* made visible cursor draw beyond defined text boundaries && enabled inserting text with Prnt && enabled overstrike/insert mode toggle

* impd fake cursor to move around within col8 arrays constrained to text with visible toggle && fg/bg color inversion like GnomTerm, except forced uc bg

* fixd line redraw by wrapping surface with SDLx::Surface to draw_rect blank && testd Wait && GetK tmot (ms works fine but float secs try did not)

* added Events::enable_key_repeat($delay_ms,$interval_ms) with SDL_DEFAULT_REPEAT_(DELAY|INTERVAL) for typematic

* impd Wait && GetK with timeout && remapd all keys to simple forms as default using sxap->delay($ms) && ticks && maybe not needing threaded Timer

* fixd window scaling to work like ckm8 on rendered text by handling resize event && redrawing from GetK

* embedded in obj hite, widt, scales, f8, && SDL sub-objects

* integr8d multiple f8 f0nt objects in new tied col8 layer

* exported ANSI2col8 to convert from serialized ANSI colored text to separ8d col8 layers (now reloc8d to a8.pm as a2c8)

* crE8d exported c8fn to provide first attempt at centralized filename coloring akin to `c8` && lsd8

* cleand out original ckm8 code to limit focus to c8 && col8 rel8d behavior

* crE8d new col8 layered text object (patterned after Simp) with tied arrays geared toward similar new interface to SDL

* original version started from ckm8 && Simp

=back

=head1 INSTALL

Assuming Octology gets released as a distribution on the CPAN, please run:

  `perl -MCPAN -e "install Octology"`

or uncompress the package and run:

  `perl Makefile.PL;       make;       make test;       make install`
    or if you don't have  `make` but Module::Build is installed
  `perl    Build.PL; perl Build; perl Build test; perl Build install`

=head1 COPYRIGHT AND LICENSE

Most source code should be Free!
  Code I have lawful authority over is and shall be!
Copyright: (c) 2014-2016, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
