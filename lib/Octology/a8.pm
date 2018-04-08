# E86MAxFB: Octology::a8.pm crE8d by PipStuart <Pip@CPAN.Org> to automatically alloc8 common applic8ion d8a like ANSI SKpz and assoC8d attributes or arguments;
# 2du:rEgNr8 all 6-HEX RGB thru h2rl && upd8 all usagez,
#   stuD term codes from: HTTP://Vim.Wikia.Com/wiki/Xterm256_color_names_for_console_Vim for any diffz for a8 main mapz here && l8r f8:pal8 d8a layrd namz,
#   cmus Curses colr themez uses intz in -1..255. wi namez -1=>'default' for whatever terminal default,
#     Fg&&bg:0.. 7 =>  black,     red,     green,     yellow,      blue,     magenta,     cyan, gray, &&          ... also "reverse|underline|blink" optz below
#     Fg    :8..15=>darkgray,lightred,lightgreen,lightyellow, lightblue,lightmagenta,lightcyan,white, && Attrz set of namez "standout|bold" wi "default"=>none,
#   mk nw standalOn lodH 4 .Hrc d8a&&structur 2Bcome availabl2all othr cOd once tStdEnuf&&redE2B put hEre in a8&&thNXportd,Use Hd8a 2add psgr lAyrz2 c8.pm,
#   subS:strip c8 lAyrz (carefully rm from amidst thOs 2B prEservd), phase out %m[cFb]2[Fbc], S() Omitz 1st text lAyr&&tAkez joind str of Fclr lAyr valU on
#     thru in ordr2mk SKp Only && wher lAyr dFinition ordr shud dict8 prEferd CquNce4multipl SKp cOdez
#     (althO Xceptionz 4 mOst SGR B4 [Fb]clr within shared 'm'-termin8d cOdez shud gNerally B B4 sepR8 f0nt&&pal8 fIle chnging SKp cOdez);
#   thN mAB sepR8 f() can B altern8ive2 Dling wi sO many $f([0-9A-Za-z_]|dot) Xported scalarz && abov shud alow rm mOst $S[Kk][8bp]\w Xportz alsO4 clEnr wA,
#   thN alsO c() wher sOlO nAmzRlIk verbz convertng2their nAm typ from implId othr as input && [cS]() cud Ech tAk Xtra pRam4just wich c8 lAyrz2Dl wi in ordr,
#   S2() && c2() shud probably still bOth rEquIre as input or gNR8 as output all of top8 lAyrz as a complEt bAsis tool,
#   it will still probablyBpreferable2hangon2 $[WROYGCBMPKz]i 4just quik mOst comon Fclrz that interlEv alInd wi regX countd cap2rz of EficiNt $[1-9],
#   Dtermin wethr U2b8() Blongz hEre or betr in nw U8.pm 4"Utiliz8ion" module wi Utlz4UniT of U thEm wi U2b && upd8 (as smRt nw port of Utl:updt 4Octology),
#     upd8:shud autO knO wher lib|bin gOz but Only put if passez `perl -c $uf` && hOpfuly alsO furthr tStz2trust prOmOtng OK!2break systM UsabiliT && auto
#       chmod binz in nEd,alsO autODtect lIkly rIt fIl wN!Xplicit thru srchng betr than just ckng old $ENV{EditFile},of course colr activiTz thru c8fn;
#     bk  :thN mk bk as nw Utl:bak that will autOcall upd8 wN trakng src2dSt as sAm from mOst rEcNt manUal XeQtion sO nO longr hav2lEv vim 2tSt cOd in $path;
#   bild autom8d tStmOde4 U2b8 2C rEsult of running every dnlOded fIle thru U2b4 && shO discrepanCz BtwEn NE loc8abl fIl wi sAm IdNt fEld2knO wher cOd lackz,
#   probably will nEd2workon mking c8 objX2hav pRstrEz4lOding any knOwn DsIrabl4m@ in2nwEficiNt Hrc stylz that can thNBUsed2gNR8 orig 4mz from incrEasingly
#     cNtralIzd .Hrc d8a fIl 2 EvN2ally control everything Useful from there;
# F4HM1w8b:old2du:gnr8:bild mAn V8 dOmAnz bAsdon rulz,add bclr&&f0nt cOdz2 *8colr,c8fn:sync2l8st lsd8,add dir&&path sepR8or colring,rElOd .ls?rc OnlywNcalld,
#   add special Dtection of /(\.\w+?)\.((t(ar)?\.)?[7bg]?z(ip)?)$/ 2 dbl-colr mAn nAm by $1&&just zip part of Xtension sepR8ly,
#   add colriz8ionz c8(fp|d8|pn|em|ur|ip|rg|tn|re|ge) => FilesysPermz,Datez,PersonNamez,EMailz,URlz,IPaddyz,RGba?z,TelephoneNumbz,REsolutionz,GEometry
#     && mAB          (rx|vn|bt) => RegeXez,VersionNumbz,B10numbz(or b10colr); pn should accept pakd colrz CMGYWB => FirstMiddleLastSuffixPunctu8ionComma;
#     mAB *8colr should all remain basic string-oriented colrizerz but c8d8 && c8bt can Xhibit 4m@ support varE8ion bAsed on contNt EvalU8ion;
#   kinda confUsing2have a8 Xport c8fn && frNdz wi nO c8.pm Xportz sO mAB core colr8ion rouTnz shudBnAmd as pRtz of a8 (or accept c8 Bcuz assoC8z wi colr8?),
#   fix c2 to convert 8ANSI colrz to extended SKp cOdez && S2=Fb;
# H5QMD19M:go bak2 drawing bord with colrz,mk cdst srch retn scorez sorted wi ndxz,mk own similar dist func,look4l8st colors.txt 2slurp,
#   standup totally sepR8 new structurez,mk dflt all Bold XtNded colrz wi optnz2only basic 2pal8 colr or just disabl dflt Bold,tst all termz4 256 suport,
#   rEmMbr 2pal8 0..15 ndx of 8pal8 actually point2 256 ndxz of 8ANSI,stRt rEgNer8ing high 48 of 1st 8pal8 && compare wi orig,tst if SKpd pal8 upd8z work4more
#     than just  0..15 somehow,setup lotz of good srch setz&&optnz2whitl down,try diff alloc8 prIoriTz4bSt combin8ion of wLnAmd family afiniT&&dIversiT,
#   NAbl .pal8 fIlz in HX &&sAvng most rEcNt call4lookup&&srch&&edit,bild fulscrn a8 Xportz hLp tXt lIk sumb,mk all output autOhndl optnl 80 or 160 wId,
#   gNr8 all Blox&&Barz dbl&&half mOdez,considr IDl rolz of fUtur pm2x tstc tStc && tsgr,gNr8 all4 8pal8z 2fil256,rEtIr orig d8a && rouTnz once newRbetr,
#   mk chp8() to togl dflt all Bold, use basic old 2pal8, shift 2pal8 into neon wash melo && 8pal8 into dark avrg lite, give all colrz othr SGR atribz,
#     so mk %acfg to configure flagz of use basic, all bold, remapz, && have chp8 modify && regener8 necessary d8a, consider new layer that just specifies
#     what F D A L O H && b d a l o h layerz regular Fb should map to && handle 90+ && 100+ High intensity too, && maybe encode every possible form
#     distinctly so they can all be sepR8d but probably default to basic O o auto-converting to eXtended Fb to avoid old Normal resetz && allow independent
#     Bold, && add acfg optnz for random once or always among bright or dark halvez;
#   cdst:add new non-dflt colrd layr:8pal8ky inoutput && limit resultz,mk -n not consume 256 ndx so regular one or -X RRGGBB or name can be chosen;
#   tstc:should form formatted row templ8z which can combine vertically or horizontally to comprise larger blocks (without the tricky idea of SKp cursor
#     jumping to each solid block at a time). Then for any of the axes of rel8ionship dark 6 to bright 10 as Clen through Neon, Wash, Melo && as Fpl8 through
#     Dark, Avrg, Lite, Orig, High or any arbitrary order can be picked && shud scale dense or sparse,mk Fbl cnv layer keyz so only need F keyz in %p8k2;
package     Octology::a8;
use strict; use warnings;use utf8;use v5.10;use Encode;
require         Exporter;  # add new colr systM
use base     qw(Exporter); # mainly exporting global utility functions && variables originally inherited from c8.pm as well as a few f8.pm d8a structures
our @EXPORT= qw(bfr8c    b8c    d8c    dur8c       a8c   a8colr      h2rl   rl2h       drkh
                bfr8colr b8colr d8colr dur8colr    d8cs @d8cl  chti  c8fn     S2   c2  S c   sS    lodl @Monz @Mon     %mc2F %mc2b %mF2c %mb2c        %sb10
 $SKp8 $SKp0 $SKp1 $SKp2 b8clr  $SKpf $SKpt %pmap %cmap       %pl8n  ftst       %f8fm %f8pm %sgrm %sgrn @Dayz @Day  lrc      comma  curs  sumb @x256  @sb64
    $z    $k    $r    $o    $y    $g     $c $SKpb    $m    $p    $w  tstc    $K    $R    $O    $Y    $G    $C    $B    $M    $P    $W    %p622 %p222
 $tnhf $ucdf  spff  spfd  spfX   shfl  reso $auth %cmsp %p8k2 @p82k  chp8     S2f4 c2f4 dm2u cdst %crgb %cbrt @snls @mrls %cdrd %cdrn    %nrgb         gnp8);
 # of 52 posibl sngl-letr var nmz,a8 Xportz 20,$b && $a unavail,so shudB thEs30 lFt4quik shortSt nAmz: 'def hij l n  q stuv x', 'A  DEF HIJ L N  Q STUV X Z'
our $VERSION='0.0';my  $d8VS='I45MCalN';our $auth='PipStuart <Pip@CPAN.Org>'; # above not exporting $b since collidez with sort{$a  <=> $b}
our $ucdf= eval('use Color::Similarity::RGB qw(distance);1') || 0; # try2set UseColorDistanceFlag if optional module is available
our @Monz=qw(January February March   April     May June July   August September October November December);our @Mon=();push(@Mon,substr($_,0,3)) for(@Monz);
our @Dayz=qw(Sunday  Monday   Tuesday Wednesday Thursday Friday Saturday                                  );our @Day=();push(@Day,substr($_,0,3)) for(@Dayz);
our $SKp8="\e[";our $SKp0=$SKp8.'00';our $SKp1=$SKp8.'01';our $SKp2=$SKp8.'22';our $tnhf=0; # ANSI "NC" eScApe "SKp" cOdez && TermCanHandleF0ntz flag
our $SKpf="\e]50;"; # escape f0nt   prefix     # background codez in 40z have 2 letterz  && start with b  # $b comNted because of sort{$a cmp $b} collision
our $SKpt="\e\\";   # escape string termin8or  # foreground codez in 30z have 1 letter  # 2 letter f0ntz  # $y may get masked by coordz ($y,$x)=$c8->Move()
our $z   = $SKp0.'m' ; # special z Zero SKp code to reset all attributez    # Orig enumer8d all SKpz here, but now use S() below instead
our %cmap=('VGA' =>'kbgcrPOw KBGCRMYW', # supported Colr MAP sequencez of index orderingz
           'ANSI'=>'krgObPcw KRGYBMCW', # might want to lc(keyz)
          '8ANSI'=>'krgObPcw KRGYBMCW  ehdospti EHDySmTI   .faunlzj _FAUNLZJ  0264xv8q 1375XV9Q', # 8pal8 columnz realigned for ANSI SKp number code mapping
          '8pal8'=>'krOgcbPw KRYGCBMW  ehodtspi EHyDTSmI   .fuaznlj _FUAZNLJ  02468xvq 13579XVQ', # each 2pal8 within labeled qw(clen neon wash melo)
          '2pal8'=>'krOgcbPw KRYGCBMW', # basically compacted same eightbow order as pal8 bracketed by blacK && White squeezing Orange && Purple over darks
           'pal8'=>         'ROYGCBMP', # maybe  *pal8 d8a should all be stored and detected from within filez having the same .pal8 extension?
          '8bow' =>         'ROYGCBMP', # altern8 pal8 (a single palette of just 8 colrz with an alias of 8bow, but mAB pal8 should be KRYGCBMW instead?)
         'd8bo'  =>         'RoYGCBMp', # altern8 pal8 but meant to be used to allow all 8 to be able to display in Bold together
           'U2b8'=>         'CRGMY'  ); # altern8 colr sequence for 64-bitz in 11-digit b64 b8 numberz probably using 'url' URLSafe charset for YouTube IDz
our %cmsp;for(keys %cmap){my $mstr=$cmap{$_};$mstr=~ s/\s+//g;$cmsp{$_}= [split(//,$mstr)];} # should load all Color Mapz already SPlit apart
our %pl8n=('K'=>'blacK'     ,'R'=>'Red'      ,'Y'=>'Yellow','G'=>    'Green'  ,  'C'=>'Cyan'        ,'B'=>     'Blue','M'=>'Magenta' ,'W'=>       'White',
           'E'=>'dimgrEy'   ,'H'=>'Hotpink'  ,'O'=>'Orange','D'=>  'oliveDrab',  'T'=>'Turquoise'   ,'S'=>  'Skyblue','P'=>'PurPle'  ,'I'=>       'Ivory',
           '_'=>   'gray_63','F'=>'Firebrick','U'=>'bisqUe','A'=> 'AquAmArine',  'Z'=>'aZure'       ,'N'=>'Navy'     ,'L'=>'Lavender','J'=> 'navaJowhite',
           '1'=>'darkblue-1','3'=>'maroon-3' ,'5'=>'gold-5','7'=>'limegreen-7',  '9'=>'dodgerblue-9','X'=>'Xteelblue','V'=>'Violet'  ,'Q'=>'antiQuewhite',);
    $pl8n{ '.'}=uc($pl8n{'_'});$pl8n{'.'}=~ s/_/./; # just 32 brIt upprcase,odd,&&_ of 8pal8 xpanded colr name map above
for(split(//,'02468')){$pl8n{$_}=$pl8n{   $_+1};$pl8n{$_}=~ y/a-z13579/A-Z02468/;} # additionally load pal8 name map with dark dot,even,&& lowercase versions
for(        'a'..'z' ){$pl8n{$_}=$pl8n{uc($_) };$pl8n{$_}=~ y/a-zA-Z/A-Za-z/    ;}
#ur %p22b=('k'=>  0, 'r'=>  1,  'O'=>  3, 'g'=>  2,   'c'=>  6, 'b'=>  4,  'P'=>  5, 'w'=>  7,  #   stil shud DfIn altern8 dRkz diff from %p222
#          'K'=>241, 'R'=>196,  'Y'=>226, 'G'=>190,   'C'=>123, 'B'=> 21,  'M'=>201, 'W'=>255); # 2Pal8    to 256 (just for   Bold 16 nstd of standard 2pal8)
our %p222=('k'=>  0, 'r'=>  1,  'O'=>  3, 'g'=>  2,   'c'=>  6, 'b'=>  4,  'P'=>  5, 'w'=>  7,  #   this shud remap basic 16 by ANSI order
           'K'=>  8, 'R'=>  9,  'Y'=> 11, 'G'=> 10,   'C'=> 14, 'B'=> 12,  'M'=> 13, 'W'=> 15); # 2Pal8    to 256 (just for   Bold 16 nstd of standard 2pal8)
our %p622=('e'=>237, 'h'=>126,  'o'=>172, 'd'=>236,   't'=> 23, 's'=> 60,  'p'=> 92, 'i'=>244,  #  Pal8 64 to 256 (just for xtnded 48 past 16 standard 2pal8)
           'E'=>242, 'H'=>205,  'y'=>184, 'D'=> 64,   'T'=> 80, 'S'=>116,  'm'=>164, 'I'=>231,
           '.'=>239, 'f'=> 52,  'u'=> 58, 'a'=> 65,   'z'=> 30, 'n'=> 17,  'l'=>103, 'j'=> 95,
           '_'=>247, 'F'=>160,  'U'=>229, 'A'=>122,   'Z'=> 44, 'N'=> 19,  'L'=>225, 'J'=>223,
           '0'=>235, '2'=> 89,  '4'=> 94, '6'=> 22,   '8'=> 31, 'x'=> 24,  'v'=> 96, 'q'=>243,
           '1'=> 18, '3'=>131,  '5'=>220, '7'=> 77,   '9'=> 81, 'X'=>033,  'V'=>213, 'Q'=>224);
our %p8k2=( # 1st good Pal8 maps gener8d for full Keyz 2 256 from `gnp8 p` (but using FDAL instead of bdal to favor just F default now)
  'F' => {'k'=>  0,'r'=>  1,'O'=>  3,'g'=>  2,'c'=>  6,'b'=>  4,'P'=>  5,'w'=>  7, 'K'=>  8,'R'=>  9,'Y'=> 11,'G'=> 10,'C'=> 14,'B'=> 12,'M'=> 13,'W'=> 15,
          'e'=>237,'h'=>125,'o'=>172,'d'=> 22,'t'=> 23,'s'=> 54,'p'=> 92,'i'=>244, 'E'=>242,'H'=>205,'y'=>184,'D'=> 64,'T'=> 80,'S'=>116,'m'=>164,'I'=>254,
          '.'=>239,'f'=> 52,'u'=> 58,'a'=> 65,'z'=> 30,'n'=> 17,'l'=>103,'j'=> 95, '_'=>247,'F'=>160,'U'=>229,'A'=> 85,'Z'=> 44,'N'=> 19,'L'=>225,'J'=>223,
          '0'=>235,'2'=> 89,'4'=> 94,'6'=> 28,'8'=> 31,'x'=> 24,'v'=> 96,'q'=>243, '1'=> 18,'3'=>132,'5'=>220,'7'=> 77,'9'=> 81,'X'=> 27,'V'=>213,'Q'=>224,},
  'D' => {'k'=> 16,'r'=> 88,'O'=>136,'g'=> 29,'c'=> 66,'b'=>233,'P'=> 90,'w'=>250, 'K'=>102,'R'=>162,'Y'=>190,'G'=> 41,'C'=> 45,'B'=> 56,'M'=>165,'W'=>193,
          'e'=>241,'h'=>161,'o'=>130,'d'=>101,'t'=> 25,'s'=> 60,'p'=> 53,'i'=>106, 'E'=> 72,'H'=>169,'y'=>179,'D'=> 46,'T'=> 74,'S'=>110,'m'=>127,'I'=>148,
          '.'=>138,'f'=>166,'u'=>100,'a'=> 76,'z'=> 43,'n'=> 98,'l'=>133,'j'=>144, '_'=>248,'F'=>168,'U'=>192,'A'=> 48,'Z'=> 50,'N'=> 21,'L'=>146,'J'=>187,
          '0'=>137,'2'=>175,'4'=>173,'6'=> 83,'8'=> 73,'x'=> 20,'v'=>176,'q'=> 70, '1'=> 93,'3'=>200,'5'=>180,'7'=>155,'9'=>153,'X'=> 55,'V'=>212,'Q'=>151,},
  'A' => {'k'=>232,'r'=>124,'O'=>178,'g'=> 34,'c'=> 36,'b'=>236,'P'=> 97,'w'=>251, 'K'=>245,'R'=>196,'Y'=>226,'G'=> 82,'C'=> 51,'B'=> 26,'M'=>201,'W'=>194,
          'e'=> 59,'h'=>163,'o'=>202,'d'=> 35,'t'=> 32,'s'=> 61,'p'=> 91,'i'=>113, 'E'=>108,'H'=>170,'y'=>185,'D'=>112,'T'=> 86,'S'=>111,'m'=>128,'I'=>154,
          '.'=>181,'f'=>131,'u'=>142,'a'=> 42,'z'=> 79,'n'=> 68,'l'=>135,'j'=>139, '_'=>145,'F'=>203,'U'=>228,'A'=> 49,'Z'=>123,'N'=> 99,'L'=>182,'J'=>188,
          '0'=>107,'2'=>204,'4'=>209,'6'=>119,'8'=> 39,'x'=>105,'v'=>140,'q'=>149, '1'=>104,'3'=>211,'5'=>221,'7'=>120,'9'=>158,'X'=> 33,'V'=>218,'Q'=>157,},
  'L' => {'k'=>234,'r'=>126,'O'=>215,'g'=> 40,'c'=> 38,'b'=>238,'P'=>171,'w'=>252, 'K'=>249,'R'=>197,'Y'=>227,'G'=> 47,'C'=> 87,'B'=> 57,'M'=>207,'W'=>255,
          'e'=>240,'h'=>198,'o'=>208,'d'=> 71,'t'=> 37,'s'=> 67,'p'=>134,'i'=>114, 'E'=>109,'H'=>206,'y'=>186,'D'=>118,'T'=>122,'S'=>117,'m'=>129,'I'=>191,
          '.'=>217,'f'=>167,'u'=>143,'a'=> 78,'z'=>115,'n'=> 62,'l'=>177,'j'=>246, '_'=>152,'F'=>210,'U'=>230,'A'=>121,'Z'=>159,'N'=> 69,'L'=>189,'J'=>253,
          '0'=>174,'2'=>199,'4'=>214,'6'=> 84,'8'=> 75,'x'=>147,'v'=>183,'q'=>150, '1'=>141,'3'=>216,'5'=>222,'7'=>156,'9'=>195,'X'=> 63,'V'=>219,'Q'=>231,});
our @p82k;for(keys %p8k2){for my $p8ky (keys %{$p8k2{$_}}){$p82k[$p8k2{$_}{$p8ky}]="$_$p8ky";}} # popul8 Pal8 256 2 Keyz reverse-lookup
my $dfpl= "000 g00 gL0 0g0 0gg 00g g0g ggg  LLL _LL __L L_L L__ LL_ _L_ ___"; # DeFault kernel PaL8 colors after booting (in 2pal8 order) but =~ s/P/L/g;
my $cmpl= "000 g00 _SI 0g0 0gg DPf g0g CCC  ggg z99 __L L_L L__ Sdp kOr ___"; # CnvGTP28($cmsv); # CheckMate ckm8 PaL8 colors (from GnomTerm) 2pal8 order
my @fvpl=($cmpl,
         #"215 T34 _WI 0F9 0SX 06A xK_ GUZ  6DJ _JU __C B_b L__ 7V_ xX_ sy_", # krOgcbPw KRYGCBMW orig TigsFavs converted to 2pal8 order but modified
          "EEE WEM pX0 EI4 8SQ GQU V9p WWU  QQQ _Qj pp0 QZ8 Guq Xpw p0p __y", # ehodtspi EHyDTSmI with hand gener8d darks ((round Bright/4)*2) other than op
          "KKK M44 WSO GWQ UWW 00G SSW WSM  eee i88 _vn V_r y__ 00W vv. _th", # .fuaznlj _FUAZNLJ  although looking up dark version3 of each might improve
          "00I M6C WQ0 6Q6 8GM 4IW UGU WUQ  00Y iCO _r0 CpC HWj 7a_ xWx .wr");# 02468xvq 13579XVQ
my @fpsp= split(/\s+/, join(' ',@fvpl));our %pmap=();#FavPalSePar8d||SPlit && Pal8 abrV8ion letters SePar8d
for(0..63){$pmap{$cmsp{'8pal8'}[$_]} = $fpsp[$_];}
my $jpms=''; # Joined Pal8 Mapd Strngs
my %Sdsr=('_' =>'01;30', '^'  => '00', '.' => '22;30', 'H_' =>'90','h.' => '100', # ScapeDigitSequenceReverse lookup
          'K' =>'01;30', 'bk' => '40', 'k' => '22;30', 'HK' =>'90','hk' => '100',
          'R' =>'01;31', 'br' => '41', 'r' => '22;31', 'HR' =>'91','hr' => '101',
          'O' =>'22;33', 'bo' => '43', 'o' => '22;33', 'HO' =>'93','ho' => '103',  'bO' => '43', # extra uppercase Orange background && 22 for Foreground
          'Y' =>'01;33', 'by' => '43', 'y' => '22;33', 'HY' =>'93','hy' => '103',  'hO' =>'103',
          'G' =>'01;32', 'bg' => '42', 'g' => '22;32', 'HG' =>'92','hg' => '102',
          'C' =>'01;36', 'bc' => '46', 'c' => '22;36', 'HC' =>'96','hc' => '106',
          'B' =>'01;34', 'bb' => '44', 'b' => '22;34', 'HB' =>'94','hb' => '104',
          'M' =>'01;35', 'bm' => '45', 'm' => '22;35', 'HM' =>'95','hm' => '105',  'hP' =>'105',
          'P' =>'22;35', 'bp' => '45', 'p' => '22;35', 'HP' =>'95','hp' => '105',  'bP' => '45', # extra upcase Purples
          'W' =>'01;37', 'bw' => '47', 'w' => '22;37', 'HW' =>'97','hw' => '107');
          # remember that SKp2 not handled by c8 && 8trm yet so b8colr && die8 are only printing   boldz
          # should setup 0 to really reset attributez, f0ntz, && everything && prefer just 22     4bold off;
our %mc2F;our %mc2b;our %mF2c;our %mb2c; # MapC8Col8ColrCodz2ForeBackgrnd && rEverse  # also adding 8trm below restored main lsd8 colors
if(exists($ENV{'TERM'}) && $ENV{'TERM'} !~ /^(([Ex]|st)term|screen|rxvt|linux|8trm)/){$tnhf=1;} # TermNoHandleFlag (need linux here too for console colors)
our $k;our $K;our $r   ;our $R;our $o;our $O;our $y;our $Y;our $g;our $G; # Fclr shrtcutz to get set, reset, shifted, or randomized in CHangePal8 function
our $c;our $C;our $SKpb;our $B;our $m;our $M;our $p;our $P;our $w;our $W; # avoid sort $b
sub chp8{ # should do similar stuff but all may need to use joined layer keyz with 8pal8 key, && accept parameter optionz
  for(0..$#{$cmsp{'8ANSI'}}){my $mlet=$cmsp{'8ANSI'}[$_]; # also now doing H && h very similarly here (had to add 90/100+ map in %Sdsr above)
                             my $modc=$_ % 16;      $mc2F{'O'.$mlet} =$Sdsr{       $cmsp{'8ANSI'}[$modc]};
                                              $mF2c{$mc2F{'O'.$mlet}}=      'O'.   $cmsp{'8ANSI'}[$modc] ;
                             my $s220=              $mc2F{'O'.$mlet}; $s220=~ s/22/00/;
                                              $mF2c{          $s220 }=      'O'.   $cmsp{'8ANSI'}[$modc] ;
                                $modc=$_ %  8;      $mc2b{'o'.$mlet} =$Sdsr{'b'.   $cmsp{'8ANSI'}[$modc]};
                                              $mb2c{$mc2b{'o'.$mlet}}=      'o'.   $cmsp{'8ANSI'}[$modc] ;
                                                    $mc2b{'h'.$mlet} =$Sdsr{'h'.   $cmsp{'8ANSI'}[$modc]};
                                              $mb2c{$mc2b{'h'.$mlet}}=      'h'.   $cmsp{'8ANSI'}[$modc] ;
                                                    $mc2F{'H'.$mlet} =$Sdsr{'H'.uc($cmsp{'8ANSI'}[$modc])}; # since mod 8, need to uppercase for right key
                                              $mF2c{$mc2F{'H'.$mlet}}=      'H'.   $cmsp{'8ANSI'}[$modc] ;}
  $mc2F{'F^'}=$mc2b{'b^'}='00';$mF2c{'00'}='F^';$mb2c{'00'}='b^'; # add special case caret to access reset 00 like $z or S(':N') but with 2 zeroez
  unless($tnhf){ # check TermCannotHandleFlag  # also adding default Bold F colrz which should have a cfg option l8r
    for(0..$#p82k){$mc2F{$p82k[$_]}='01;38;5;' . spfd($_);$mF2c{$mc2F{$p82k[$_]}}=$p82k[$_];
      my $p8ky=$p82k[$_]; $p8ky=~ s/^([FDAL])//;if($1 eq 'F'){$p8ky= 'b'.$p8ky;}else{$p8ky= lc($1).$p8ky;} # should learn how to use \l in regex to lc() too
                   $mc2b{$p8ky    }=   '48;5;' . spfd($_);$mb2c{$mc2b{$p8ky    }}=$p8ky    ;}}
  $k=S('k');$K=S('K');$r   =S('r');$R=S('R');$o=S('o');$O=S('O');$y=S('y');$Y=S('Y');$g=S('g');$G=S('G'); #Fclr shrtcutz
  $c=S('c');$C=S('C');$SKpb=S('b');$B=S('B');$m=S('m');$M=S('M');$p=S('p');$P=S('P');$w=S('w');$W=S('W'); #avoid sort $b
} # since these all may now have layer prefixes, maybe the hashes can be combined?
chp8(); # gotta call it to init d8a!
our @x256=(qw[000000 800000  008000 808000   000080 800080  008080 C0C0C0    808080 FF0000  00FF00 FFFF00   0000FF FF00FF  00FFFF FFFFFF
              000000 00005F  000087 0000AF   0000D7 0000FF  005F00 005F5F    005F87 005FAF  005FD7 005FFF   008700 00875F  008787 0087AF
              0087D7 0087FF  00AF00 00AF5F   00AF87 00AFAF  00AFD7 00AFFF    00D700 00D75F  00D787 00D7AF   00D7D7 00D7FF  00FF00 00FF5F
              00FF87 00FFAF  00FFD7 00FFFF   5F0000 5F005F  5F0087 5F00AF    5F00D7 5F00FF  5F5F00 5F5F5F   5F5F87 5F5FAF  5F5FD7 5F5FFF
              5F8700 5F875F  5F8787 5F87AF   5F87D7 5F87FF  5FAF00 5FAF5F    5FAF87 5FAFAF  5FAFD7 5FAFFF   5FD700 5FD75F  5FD787 5FD7AF
              5FD7D7 5FD7FF  5FFF00 5FFF5F   5FFF87 5FFFAF  5FFFD7 5FFFFF    870000 87005F  870087 8700AF   8700D7 8700FF  875F00 875F5F
              875F87 875FAF  875FD7 875FFF   878700 87875F  878787 8787AF    8787D7 8787FF  87AF00 87AF5F   87AF87 87AFAF  87AFD7 87AFFF
              87D700 87D75F  87D787 87D7AF   87D7D7 87D7FF  87FF00 87FF5F    87FF87 87FFAF  87FFD7 87FFFF   AF0000 AF005F  AF0087 AF00AF
              AF00D7 AF00FF  AF5F00 AF5F5F   AF5F87 AF5FAF  AF5FD7 AF5FFF    AF8700 AF875F  AF8787 AF87AF   AF87D7 AF87FF  AFAF00 AFAF5F
              AFAF87 AFAFAF  AFAFD7 AFAFFF   AFD700 AFD75F  AFD787 AFD7AF    AFD7D7 AFD7FF  AFFF00 AFFF5F   AFFF87 AFFFAF  AFFFD7 AFFFFF
              D70000 D7005F  D70087 D700AF   D700D7 D700FF  D75F00 D75F5F    D75F87 D75FAF  D75FD7 D75FFF   D78700 D7875F  D78787 D787AF
              D787D7 D787FF  D7AF00 D7AF5F   D7AF87 D7AFAF  D7AFD7 D7AFFF    D7D700 D7D75F  D7D787 D7D7AF   D7D7D7 D7D7FF  D7FF00 D7FF5F
              D7FF87 D7FFAF  D7FFD7 D7FFFF   FF0000 FF005F  FF0087 FF00AF    FF00D7 FF00FF  FF5F00 FF5F5F   FF5F87 FF5FAF  FF5FD7 FF5FFF
              FF8700 FF875F  FF8787 FF87AF   FF87D7 FF87FF  FFAF00 FFAF5F    FFAF87 FFAFAF  FFAFD7 FFAFFF   FFD700 FFD75F  FFD787 FFD7AF
              FFD7D7 FFD7FF  FFFF00 FFFF5F   FFFF87 FFFFAF  FFFFD7 FFFFFF    080808 121212  1C1C1C 262626   303030 3A3A3A  444444 4E4E4E
              585858 626262  6C6C6C 767676   808080 8A8A8A  949494 9E9E9E    A8A8A8 B2B2B2  BCBCBC C6C6C6   D0D0D0 DADADA  E4E4E4 EEEEEE]); # XTerm256colr pal8
our %nrgb=( 'aliceblue'           => 'F0F8FF',  'antiquewhite'        => 'FAEBD7',  'antiquewhite1'       => 'FFEFDB',  'antiquewhite2'       => 'EEDFCC',
            'antiquewhite3'       => 'CDC0B0',  'antiquewhite4'       => '8B8378',  'aqua'                => '00FFFF',  'aquamarine'          => '7FFFD4',
            'aquamarine1'         => '7FFFD4',  'aquamarine2'         => '76EEC6',  'aquamarine3'         => '66CDAA',  'aquamarine4'         => '458B74',
            'azure'               => 'F0FFFF',  'azure1'              => 'F0FFFF',  'azure2'              => 'E0EEEE',  'azure3'              => 'C1CDCD',
            'azure4'              => '838B8B',  'beige'               => 'F5F5DC',  'bisque'              => 'FFE4C4',  'bisque1'             => 'FFE4C4',
            'bisque2'             => 'EED5B7',  'bisque3'             => 'CDB79E',  'bisque4'             => '8B7D6B',  'black'               => '000000',
            'blanchedalmond'      => 'FFEBCD',  'blue'                => '0000FF',  'blue1'               => '0000FF',  'blue2'               => '0000EE',
            'blue3'               => '0000CD',  'blue4'               => '00008B',  'blueviolet'          => '8A2BE2',  'brown'               => 'A52A2A',
            'brown1'              => 'FF4040',  'brown2'              => 'EE3B3B',  'brown3'              => 'CD3333',  'brown4'              => '8B2323',
            'burlywood'           => 'DEB887',  'burlywood1'          => 'FFD39B',  'burlywood2'          => 'EEC591',  'burlywood3'          => 'CDAA7D',
            'burlywood4'          => '8B7355',  'cadetblue'           => '5F9EA0',  'cadetblue1'          => '98F5FF',  'cadetblue2'          => '8EE5EE',
            'cadetblue3'          => '7AC5CD',  'cadetblue4'          => '53868B',  'chartreuse'          => '7FFF00',  'chartreuse1'         => '7FFF00',
            'chartreuse2'         => '76EE00',  'chartreuse3'         => '66CD00',  'chartreuse4'         => '458B00',  'chocolate'           => 'D2691E',
            'chocolate1'          => 'FF7F24',  'chocolate2'          => 'EE7621',  'chocolate3'          => 'CD661D',  'chocolate4'          => '8B4513',
            'coral'               => 'FF7F50',  'coral1'              => 'FF7256',  'coral2'              => 'EE6A50',  'coral3'              => 'CD5B45',
            'coral4'              => '8B3E2F',  'cornflowerblue'      => '6495ED',  'cornsilk'            => 'FFF8DC',  'cornsilk1'           => 'FFF8DC',
            'cornsilk2'           => 'EEE8CD',  'cornsilk3'           => 'CDC8B1',  'cornsilk4'           => '8B8878',  'crimson'             => 'DC143C',
            'cyan'                => '00FFFF',  'cyan1'               => '00FFFF',  'cyan2'               => '00EEEE',  'cyan3'               => '00CDCD',
            'cyan4'               => '008B8B',  'darkblue'            => '00008B',  'darkcyan'            => '008B8B',  'darkgoldenrod'       => 'B8860B',
            'darkgoldenrod1'      => 'FFB90F',  'darkgoldenrod2'      => 'EEAD0E',  'darkgoldenrod3'      => 'CD950C',  'darkgoldenrod4'      => '8B6508',
            'darkgray'            => 'A9A9A9',  'darkgreen'           => '006400',  'darkgrey'            => 'A9A9A9',  'darkkhaki'           => 'BDB76B',
            'darkmagenta'         => '8B008B',  'darkolivegreen'      => '556B2F',  'darkolivegreen1'     => 'CAFF70',  'darkolivegreen2'     => 'BCEE68',
            'darkolivegreen3'     => 'A2CD5A',  'darkolivegreen4'     => '6E8B3D',  'darkorange'          => 'FF8C00',  'darkorange1'         => 'FF7F00',
            'darkorange2'         => 'EE7600',  'darkorange3'         => 'CD6600',  'darkorange4'         => '8B4500',  'darkorchid'          => '9932CC',
            'darkorchid1'         => 'BF3EFF',  'darkorchid2'         => 'B23AEE',  'darkorchid3'         => '9A32CD',  'darkorchid4'         => '68228B',
            'darkred'             => '8B0000',  'darksalmon'          => 'E9967A',  'darkseagreen'        => '8FBC8F',  'darkseagreen1'       => 'C1FFC1',
            'darkseagreen2'       => 'B4EEB4',  'darkseagreen3'       => '9BCD9B',  'darkseagreen4'       => '698B69',  'darkslateblue'       => '483D8B',
            'darkslategray'       => '2F4F4F',  'darkslategray1'      => '97FFFF',  'darkslategray2'      => '8DEEEE',  'darkslategray3'      => '79CDCD',
            'darkslategray4'      => '528B8B',  'darkslategrey'       => '2F4F4F',  'darkslategrey1'      => '97FFFF',  'darkslategrey2'      => '8DEEEE',
            'darkslategrey3'      => '79CDCD',  'darkslategrey4'      => '528B8B',  'darkturquoise'       => '00CED1',  'darkviolet'          => '9400D3',
            'deeppink'            => 'FF1493',  'deeppink1'           => 'FF1493',  'deeppink2'           => 'EE1289',  'deeppink3'           => 'CD1076',
            'deeppink4'           => '8B0A50',  'deepskyblue'         => '00BFFF',  'deepskyblue1'        => '00BFFF',  'deepskyblue2'        => '00B2EE',
            'deepskyblue3'        => '009ACD',  'deepskyblue4'        => '00688B',  'dimgray'             => '696969',  'dimgrey'             => '696969',
            'dodgerblue'          => '1E90FF',  'dodgerblue1'         => '1E90FF',  'dodgerblue2'         => '1C86EE',  'dodgerblue3'         => '1874CD',
            'dodgerblue4'         => '104E8B',  'firebrick'           => 'B22222',  'firebrick1'          => 'FF3030',  'firebrick2'          => 'EE2C2C',
            'firebrick3'          => 'CD2626',  'firebrick4'          => '8B1A1A',  'floralwhite'         => 'FFFAF0',  'forestgreen'         => '228B22',
            'fuchsia'             => 'FF00FF',  'gainsboro'           => 'DCDCDC',  'ghostwhite'          => 'F8F8FF',  'gold'                => 'FFD700',
            'gold1'               => 'FFD700',  'gold2'               => 'EEC900',  'gold3'               => 'CDAD00',  'gold4'               => '8B7500',
            'goldenrod'           => 'DAA520',  'goldenrod1'          => 'FFC125',  'goldenrod2'          => 'EEB422',  'goldenrod3'          => 'CD9B1D',
            'goldenrod4'          => '8B6914',  'gray'                => 'BEBEBE',  'gray0'               => '000000',  'gray1'               => '030303',
            'gray10'              => '1A1A1A',  'gray100'             => 'FFFFFF',  'gray11'              => '1C1C1C',  'gray12'              => '1F1F1F',
            'gray13'              => '212121',  'gray14'              => '242424',  'gray15'              => '262626',  'gray16'              => '292929',
            'gray17'              => '2B2B2B',  'gray18'              => '2E2E2E',  'gray19'              => '303030',  'gray2'               => '050505',
            'gray20'              => '333333',  'gray21'              => '363636',  'gray22'              => '383838',  'gray23'              => '3B3B3B',
            'gray24'              => '3D3D3D',  'gray25'              => '404040',  'gray26'              => '424242',  'gray27'              => '454545',
            'gray28'              => '474747',  'gray29'              => '4A4A4A',  'gray3'               => '080808',  'gray30'              => '4D4D4D',
            'gray31'              => '4F4F4F',  'gray32'              => '525252',  'gray33'              => '545454',  'gray34'              => '575757',
            'gray35'              => '595959',  'gray36'              => '5C5C5C',  'gray37'              => '5E5E5E',  'gray38'              => '616161',
            'gray39'              => '636363',  'gray4'               => '0A0A0A',  'gray40'              => '666666',  'gray41'              => '696969',
            'gray42'              => '6B6B6B',  'gray43'              => '6E6E6E',  'gray44'              => '707070',  'gray45'              => '737373',
            'gray46'              => '757575',  'gray47'              => '787878',  'gray48'              => '7A7A7A',  'gray49'              => '7D7D7D',
            'gray5'               => '0D0D0D',  'gray50'              => '7F7F7F',  'gray51'              => '828282',  'gray52'              => '858585',
            'gray53'              => '878787',  'gray54'              => '8A8A8A',  'gray55'              => '8C8C8C',  'gray56'              => '8F8F8F',
            'gray57'              => '919191',  'gray58'              => '949494',  'gray59'              => '969696',  'gray6'               => '0F0F0F',
            'gray60'              => '999999',  'gray61'              => '9C9C9C',  'gray62'              => '9E9E9E',  'gray63'              => 'A1A1A1',
            'gray64'              => 'A3A3A3',  'gray65'              => 'A6A6A6',  'gray66'              => 'A8A8A8',  'gray67'              => 'ABABAB',
            'gray68'              => 'ADADAD',  'gray69'              => 'B0B0B0',  'gray7'               => '121212',  'gray70'              => 'B3B3B3',
            'gray71'              => 'B5B5B5',  'gray72'              => 'B8B8B8',  'gray73'              => 'BABABA',  'gray74'              => 'BDBDBD',
            'gray75'              => 'BFBFBF',  'gray76'              => 'C2C2C2',  'gray77'              => 'C4C4C4',  'gray78'              => 'C7C7C7',
            'gray79'              => 'C9C9C9',  'gray8'               => '141414',  'gray80'              => 'CCCCCC',  'gray81'              => 'CFCFCF',
            'gray82'              => 'D1D1D1',  'gray83'              => 'D4D4D4',  'gray84'              => 'D6D6D6',  'gray85'              => 'D9D9D9',
            'gray86'              => 'DBDBDB',  'gray87'              => 'DEDEDE',  'gray88'              => 'E0E0E0',  'gray89'              => 'E3E3E3',
            'gray9'               => '171717',  'gray90'              => 'E5E5E5',  'gray91'              => 'E8E8E8',  'gray92'              => 'EBEBEB',
            'gray93'              => 'EDEDED',  'gray94'              => 'F0F0F0',  'gray95'              => 'F2F2F2',  'gray96'              => 'F5F5F5',
            'gray97'              => 'F7F7F7',  'gray98'              => 'FAFAFA',  'gray99'              => 'FCFCFC',  'green'               => '00FF00',
            'green1'              => '00FF00',  'green2'              => '00EE00',  'green3'              => '00CD00',  'green4'              => '008B00',
            'greenyellow'         => 'ADFF2F',  'grey'                => 'BEBEBE',  'grey0'               => '000000',  'grey1'               => '030303',
            'grey10'              => '1A1A1A',  'grey100'             => 'FFFFFF',  'grey11'              => '1C1C1C',  'grey12'              => '1F1F1F',
            'grey13'              => '212121',  'grey14'              => '242424',  'grey15'              => '262626',  'grey16'              => '292929',
            'grey17'              => '2B2B2B',  'grey18'              => '2E2E2E',  'grey19'              => '303030',  'grey2'               => '050505',
            'grey20'              => '333333',  'grey21'              => '363636',  'grey22'              => '383838',  'grey23'              => '3B3B3B',
            'grey24'              => '3D3D3D',  'grey25'              => '404040',  'grey26'              => '424242',  'grey27'              => '454545',
            'grey28'              => '474747',  'grey29'              => '4A4A4A',  'grey3'               => '080808',  'grey30'              => '4D4D4D',
            'grey31'              => '4F4F4F',  'grey32'              => '525252',  'grey33'              => '545454',  'grey34'              => '575757',
            'grey35'              => '595959',  'grey36'              => '5C5C5C',  'grey37'              => '5E5E5E',  'grey38'              => '616161',
            'grey39'              => '636363',  'grey4'               => '0A0A0A',  'grey40'              => '666666',  'grey41'              => '696969',
            'grey42'              => '6B6B6B',  'grey43'              => '6E6E6E',  'grey44'              => '707070',  'grey45'              => '737373',
            'grey46'              => '757575',  'grey47'              => '787878',  'grey48'              => '7A7A7A',  'grey49'              => '7D7D7D',
            'grey5'               => '0D0D0D',  'grey50'              => '7F7F7F',  'grey51'              => '828282',  'grey52'              => '858585',
            'grey53'              => '878787',  'grey54'              => '8A8A8A',  'grey55'              => '8C8C8C',  'grey56'              => '8F8F8F',
            'grey57'              => '919191',  'grey58'              => '949494',  'grey59'              => '969696',  'grey6'               => '0F0F0F',
            'grey60'              => '999999',  'grey61'              => '9C9C9C',  'grey62'              => '9E9E9E',  'grey63'              => 'A1A1A1',
            'grey64'              => 'A3A3A3',  'grey65'              => 'A6A6A6',  'grey66'              => 'A8A8A8',  'grey67'              => 'ABABAB',
            'grey68'              => 'ADADAD',  'grey69'              => 'B0B0B0',  'grey7'               => '121212',  'grey70'              => 'B3B3B3',
            'grey71'              => 'B5B5B5',  'grey72'              => 'B8B8B8',  'grey73'              => 'BABABA',  'grey74'              => 'BDBDBD',
            'grey75'              => 'BFBFBF',  'grey76'              => 'C2C2C2',  'grey77'              => 'C4C4C4',  'grey78'              => 'C7C7C7',
            'grey79'              => 'C9C9C9',  'grey8'               => '141414',  'grey80'              => 'CCCCCC',  'grey81'              => 'CFCFCF',
            'grey82'              => 'D1D1D1',  'grey83'              => 'D4D4D4',  'grey84'              => 'D6D6D6',  'grey85'              => 'D9D9D9',
            'grey86'              => 'DBDBDB',  'grey87'              => 'DEDEDE',  'grey88'              => 'E0E0E0',  'grey89'              => 'E3E3E3',
            'grey9'               => '171717',  'grey90'              => 'E5E5E5',  'grey91'              => 'E8E8E8',  'grey92'              => 'EBEBEB',
            'grey93'              => 'EDEDED',  'grey94'              => 'F0F0F0',  'grey95'              => 'F2F2F2',  'grey96'              => 'F5F5F5',
            'grey97'              => 'F7F7F7',  'grey98'              => 'FAFAFA',  'grey99'              => 'FCFCFC',  'honeydew'            => 'F0FFF0',
            'honeydew1'           => 'F0FFF0',  'honeydew2'           => 'E0EEE0',  'honeydew3'           => 'C1CDC1',  'honeydew4'           => '838B83',
            'hotpink'             => 'FF69B4',  'hotpink1'            => 'FF6EB4',  'hotpink2'            => 'EE6AA7',  'hotpink3'            => 'CD6090',
            'hotpink4'            => '8B3A62',  'indianred'           => 'CD5C5C',  'indianred1'          => 'FF6A6A',  'indianred2'          => 'EE6363',
            'indianred3'          => 'CD5555',  'indianred4'          => '8B3A3A',  'indigo'              => '4B0082',  'ivory'               => 'FFFFF0',
            'ivory1'              => 'FFFFF0',  'ivory2'              => 'EEEEE0',  'ivory3'              => 'CDCDC1',  'ivory4'              => '8B8B83',
            'khaki'               => 'F0E68C',  'khaki1'              => 'FFF68F',  'khaki2'              => 'EEE685',  'khaki3'              => 'CDC673',
            'khaki4'              => '8B864E',  'lavender'            => 'E6E6FA',  'lavenderblush'       => 'FFF0F5',  'lavenderblush1'      => 'FFF0F5',
            'lavenderblush2'      => 'EEE0E5',  'lavenderblush3'      => 'CDC1C5',  'lavenderblush4'      => '8B8386',  'lawngreen'           => '7CFC00',
            'lemonchiffon'        => 'FFFACD',  'lemonchiffon1'       => 'FFFACD',  'lemonchiffon2'       => 'EEE9BF',  'lemonchiffon3'       => 'CDC9A5',
            'lemonchiffon4'       => '8B8970',  'lightblue'           => 'ADD8E6',  'lightblue1'          => 'BFEFFF',  'lightblue2'          => 'B2DFEE',
            'lightblue3'          => '9AC0CD',  'lightblue4'          => '68838B',  'lightcoral'          => 'F08080',  'lightcyan'           => 'E0FFFF',
            'lightcyan1'          => 'E0FFFF',  'lightcyan2'          => 'D1EEEE',  'lightcyan3'          => 'B4CDCD',  'lightcyan4'          => '7A8B8B',
            'lightgoldenrod'      => 'EEDD82',  'lightgoldenrod1'     => 'FFEC8B',  'lightgoldenrod2'     => 'EEDC82',  'lightgoldenrod3'     => 'CDBE70',
            'lightgoldenrod4'     => '8B814C',  'lightgoldenrodyellow'=> 'FAFAD2',  'lightgray'           => 'D3D3D3',  'lightgreen'          => '90EE90',
            'lightgrey'           => 'D3D3D3',  'lightpink'           => 'FFB6C1',  'lightpink1'          => 'FFAEB9',  'lightpink2'          => 'EEA2AD',
            'lightpink3'          => 'CD8C95',  'lightpink4'          => '8B5F65',  'lightsalmon'         => 'FFA07A',  'lightsalmon1'        => 'FFA07A',
            'lightsalmon2'        => 'EE9572',  'lightsalmon3'        => 'CD8162',  'lightsalmon4'        => '8B5742',  'lightseagreen'       => '20B2AA',
            'lightskyblue'        => '87CEFA',  'lightskyblue1'       => 'B0E2FF',  'lightskyblue2'       => 'A4D3EE',  'lightskyblue3'       => '8DB6CD',
            'lightskyblue4'       => '607B8B',  'lightslateblue'      => '8470FF',  'lightslategray'      => '778899',  'lightslategrey'      => '778899',
            'lightsteelblue'      => 'B0C4DE',  'lightsteelblue1'     => 'CAE1FF',  'lightsteelblue2'     => 'BCD2EE',  'lightsteelblue3'     => 'A2B5CD',
            'lightsteelblue4'     => '6E7B8B',  'lightyellow'         => 'FFFFE0',  'lightyellow1'        => 'FFFFE0',  'lightyellow2'        => 'EEEED1',
            'lightyellow3'        => 'CDCDB4',  'lightyellow4'        => '8B8B7A',  'lime'                => '00FF00',  'limegreen'           => '32CD32',
            'linen'               => 'FAF0E6',  'magenta'             => 'FF00FF',  'magenta1'            => 'FF00FF',  'magenta2'            => 'EE00EE',
            'magenta3'            => 'CD00CD',  'magenta4'            => '8B008B',  'maroon'              => 'B03060',  'maroon1'             => 'FF34B3',
            'maroon2'             => 'EE30A7',  'maroon3'             => 'CD2990',  'maroon4'             => '8B1C62',  'mediumaquamarine'    => '66CDAA',
            'mediumblue'          => '0000CD',  'mediumorchid'        => 'BA55D3',  'mediumorchid1'       => 'E066FF',  'mediumorchid2'       => 'D15FEE',
            'mediumorchid3'       => 'B452CD',  'mediumorchid4'       => '7A378B',  'mediumpurple'        => '9370DB',  'mediumpurple1'       => 'AB82FF',
            'mediumpurple2'       => '9F79EE',  'mediumpurple3'       => '8968CD',  'mediumpurple4'       => '5D478B',  'mediumseagreen'      => '3CB371',
            'mediumslateblue'     => '7B68EE',  'mediumspringgreen'   => '00FA9A',  'mediumturquoise'     => '48D1CC',  'mediumvioletred'     => 'C71585',
            'midnightblue'        => '191970',  'mintcream'           => 'F5FFFA',  'mistyrose'           => 'FFE4E1',  'mistyrose1'          => 'FFE4E1',
            'mistyrose2'          => 'EED5D2',  'mistyrose3'          => 'CDB7B5',  'mistyrose4'          => '8B7D7B',  'moccasin'            => 'FFE4B5',
            'navajowhite'         => 'FFDEAD',  'navajowhite1'        => 'FFDEAD',  'navajowhite2'        => 'EECFA1',  'navajowhite3'        => 'CDB38B',
            'navajowhite4'        => '8B795E',  'navy'                => '000080',  'navyblue'            => '000080',  'oldlace'             => 'FDF5E6',
            'olive'               => '808000',  'olivedrab'           => '6B8E23',  'olivedrab1'          => 'C0FF3E',  'olivedrab2'          => 'B3EE3A',
            'olivedrab3'          => '9ACD32',  'olivedrab4'          => '698B22',  'orange'              => 'FFA500',  'orange1'             => 'FFA500',
            'orange2'             => 'EE9A00',  'orange3'             => 'CD8500',  'orange4'             => '8B5A00',  'orangered'           => 'FF4500',
            'orangered1'          => 'FF4500',  'orangered2'          => 'EE4000',  'orangered3'          => 'CD3700',  'orangered4'          => '8B2500',
            'orchid'              => 'DA70D6',  'orchid1'             => 'FF83FA',  'orchid2'             => 'EE7AE9',  'orchid3'             => 'CD69C9',
            'orchid4'             => '8B4789',  'palegoldenrod'       => 'EEE8AA',  'palegreen'           => '98FB98',  'palegreen1'          => '9AFF9A',
            'palegreen2'          => '90EE90',  'palegreen3'          => '7CCD7C',  'palegreen4'          => '548B54',  'paleturquoise'       => 'AFEEEE',
            'paleturquoise1'      => 'BBFFFF',  'paleturquoise2'      => 'AEEEEE',  'paleturquoise3'      => '96CDCD',  'paleturquoise4'      => '668B8B',
            'palevioletred'       => 'DB7093',  'palevioletred1'      => 'FF82AB',  'palevioletred2'      => 'EE799F',  'palevioletred3'      => 'CD6889',
            'palevioletred4'      => '8B475D',  'papayawhip'          => 'FFEFD5',  'peachpuff'           => 'FFDAB9',  'peachpuff1'          => 'FFDAB9',
            'peachpuff2'          => 'EECBAD',  'peachpuff3'          => 'CDAF95',  'peachpuff4'          => '8B7765',  'peru'                => 'CD853F',
            'pink'                => 'FFC0CB',  'pink1'               => 'FFB5C5',  'pink2'               => 'EEA9B8',  'pink3'               => 'CD919E',
            'pink4'               => '8B636C',  'plum'                => 'DDA0DD',  'plum1'               => 'FFBBFF',  'plum2'               => 'EEAEEE',
            'plum3'               => 'CD96CD',  'plum4'               => '8B668B',  'powderblue'          => 'B0E0E6',  'purple'              => 'A020F0',
            'purple1'             => '9B30FF',  'purple2'             => '912CEE',  'purple3'             => '7D26CD',  'purple4'             => '551A8B',
            'rebeccapurple'       => '663399',  'red'                 => 'FF0000',  'red1'                => 'FF0000',  'red2'                => 'EE0000',
            'red3'                => 'CD0000',  'red4'                => '8B0000',  'rosybrown'           => 'BC8F8F',  'rosybrown1'          => 'FFC1C1',
            'rosybrown2'          => 'EEB4B4',  'rosybrown3'          => 'CD9B9B',  'rosybrown4'          => '8B6969',  'royalblue'           => '4169E1',
            'royalblue1'          => '4876FF',  'royalblue2'          => '436EEE',  'royalblue3'          => '3A5FCD',  'royalblue4'          => '27408B',
            'saddlebrown'         => '8B4513',  'salmon'              => 'FA8072',  'salmon1'             => 'FF8C69',  'salmon2'             => 'EE8262',
            'salmon3'             => 'CD7054',  'salmon4'             => '8B4C39',  'sandybrown'          => 'F4A460',  'seagreen'            => '2E8B57',
            'seagreen1'           => '54FF9F',  'seagreen2'           => '4EEE94',  'seagreen3'           => '43CD80',  'seagreen4'           => '2E8B57',
            'seashell'            => 'FFF5EE',  'seashell1'           => 'FFF5EE',  'seashell2'           => 'EEE5DE',  'seashell3'           => 'CDC5BF',
            'seashell4'           => '8B8682',  'sienna'              => 'A0522D',  'sienna1'             => 'FF8247',  'sienna2'             => 'EE7942',
            'sienna3'             => 'CD6839',  'sienna4'             => '8B4726',  'silver'              => 'C0C0C0',  'skyblue'             => '87CEEB',
            'skyblue1'            => '87CEFF',  'skyblue2'            => '7EC0EE',  'skyblue3'            => '6CA6CD',  'skyblue4'            => '4A708B',
            'slateblue'           => '6A5ACD',  'slateblue1'          => '836FFF',  'slateblue2'          => '7A67EE',  'slateblue3'          => '6959CD',
            'slateblue4'          => '473C8B',  'slategray'           => '708090',  'slategray1'          => 'C6E2FF',  'slategray2'          => 'B9D3EE',
            'slategray3'          => '9FB6CD',  'slategray4'          => '6C7B8B',  'slategrey'           => '708090',  'slategrey1'          => 'C6E2FF',
            'slategrey2'          => 'B9D3EE',  'slategrey3'          => '9FB6CD',  'slategrey4'          => '6C7B8B',  'snow'                => 'FFFAFA',
            'snow1'               => 'FFFAFA',  'snow2'               => 'EEE9E9',  'snow3'               => 'CDC9C9',  'snow4'               => '8B8989',
            'springgreen'         => '00FF7F',  'springgreen1'        => '00FF7F',  'springgreen2'        => '00EE76',  'springgreen3'        => '00CD66',
            'springgreen4'        => '008B45',  'steelblue'           => '4682B4',  'steelblue1'          => '63B8FF',  'steelblue2'          => '5CACEE',
            'steelblue3'          => '4F94CD',  'steelblue4'          => '36648B',  'tan'                 => 'D2B48C',  'tan1'                => 'FFA54F',
            'tan2'                => 'EE9A49',  'tan3'                => 'CD853F',  'tan4'                => '8B5A2B',  'teal'                => '008080',
            'thistle'             => 'D8BFD8',  'thistle1'            => 'FFE1FF',  'thistle2'            => 'EED2EE',  'thistle3'            => 'CDB5CD',
            'thistle4'            => '8B7B8B',  'tomato'              => 'FF6347',  'tomato1'             => 'FF6347',  'tomato2'             => 'EE5C42',
            'tomato3'             => 'CD4F39',  'tomato4'             => '8B3626',  'turquoise'           => '40E0D0',  'turquoise1'          => '00F5FF',
            'turquoise2'          => '00E5EE',  'turquoise3'          => '00C5CD',  'turquoise4'          => '00868B',  'violet'              => 'EE82EE',
            'violetred'           => 'D02090',  'violetred1'          => 'FF3E96',  'violetred2'          => 'EE3A8C',  'violetred3'          => 'CD3278',
            'violetred4'          => '8B2252',  'webgray'             => '808080',  'webgreen'            => '008000',  'webgrey'             => '808080',
            'webmaroon'           => '800000',  'webpurple'           => '800080',  'wheat'               => 'F5DEB3',  'wheat1'              => 'FFE7BA',
            'wheat2'              => 'EED8AE',  'wheat3'              => 'CDBA96',  'wheat4'              => '8B7E66',  'white'               => 'FFFFFF',
            'whitesmoke'          => 'F5F5F5',  'x11gray'             => 'BEBEBE',  'x11green'            => '00FF00',  'x11grey'             => 'BEBEBE',
            'x11maroon'           => 'B03060',  'x11purple'           => 'A020F0',  'yellow'              => 'FFFF00',  'yellow1'             => 'FFFF00',
            'yellow2'             => 'EEEE00',  'yellow3'             => 'CDCD00',  'yellow4'             => '8B8B00',  'yellowgreen'         => '9ACD32',);
my $w3cp = qq[ HTTPS://W3Schools.Com/colors/colors_picker.asp is pretty sweet for gener8ing many pretty and useful formats from any easily input color!:
Red
#ff0000
rgb(255, 0, 0)
hsl(0, 100%, 50%)
Lighter / Darker:
100%             #ffffff
95%              #ffe6e6
90%              #ffcccc
85%              #ffb3b3
80%              #ff9999
75%              #ff8080
70%              #ff6666
65%              #ff4d4d
60%              #ff3333
55%              #ff1a1a
50%            #ff0000
45%              #e60000
40%              #cc0000
35%              #b30000
30%              #990000
25%              #800000
20%              #660000
15%              #4d0000
10%              #330000
5%               #1a0000
0%               #000000
Hue
Hue     HexaRgbHsl
0       #FF0000rgb(255, 0, 0)   hsl(0, 100%, 50%)
15      #ff4000rgb(255, 64, 0)  hsl(15, 100%, 50%)
30      #ff8000rgb(255, 128, 0) hsl(30, 100%, 50%)
45      #ffbf00rgb(255, 191, 0) hsl(45, 100%, 50%)
60      #FFFF00rgb(255, 255, 0) hsl(60, 100%, 50%)
75      #bfff00rgb(191, 255, 0) hsl(75, 100%, 50%)
90      #80ff00rgb(128, 255, 0) hsl(90, 100%, 50%)
105     #40ff00rgb(64, 255, 0)  hsl(105, 100%, 50%)
120     #00FF00rgb(0, 255, 0)   hsl(120, 100%, 50%)
135     #00ff40rgb(0, 255, 64)  hsl(135, 100%, 50%)
150     #00ff80rgb(0, 255, 128) hsl(150, 100%, 50%)
165     #00ffbfrgb(0, 255, 191) hsl(165, 100%, 50%)
180     #00FFFFrgb(0, 255, 255) hsl(180, 100%, 50%)
195     #00BFFFrgb(0, 191, 255) hsl(195, 100%, 50%)
210     #0080ffrgb(0, 128, 255) hsl(210, 100%, 50%)
225     #0040ffrgb(0, 64, 255)  hsl(225, 100%, 50%)
240     #0000FFrgb(0, 0, 255)   hsl(240, 100%, 50%)
255     #4000ffrgb(64, 0, 255)  hsl(255, 100%, 50%)
270     #8000ffrgb(128, 0, 255) hsl(270, 100%, 50%)
285     #bf00ffrgb(191, 0, 255) hsl(285, 100%, 50%)
300     #FF00FFrgb(255, 0, 255) hsl(300, 100%, 50%)
315     #ff00bfrgb(255, 0, 191) hsl(315, 100%, 50%)
330     #ff0080rgb(255, 0, 128) hsl(330, 100%, 50%)
345     #ff0040rgb(255, 0, 64)  hsl(345, 100%, 50%)
360     #FF0000rgb(255, 0, 0)   hsl(0, 100%, 50%)

#051a5c
rgb(5, 26, 92)
hsl(226, 90%, 19%)
Lighter / Darker:
100%             #ffffff
95%              #e7ecfe
90%              #cfd9fc
85%              #b6c6fb
80%              #9eb4fa
75%              #86a1f9
70%              #6e8ef7
65%              #557bf6
60%              #3d68f5
55%              #2555f4
50%              #0d42f2
45%              #0b3cda
40%              #0a35c2
35%              #092eaa
30%              #082891
25%              #062179
20%              #051b61
19%              #051a5c
15%              #041449
10%              #030d30
5%               #010718
0%               #000000
Hue
Hue     HexaRgbHslHsl
0       #5c0505rgb(92, 5, 5)    hsl(0, 90%, 19%)
15      #5c1b05rgb(92, 27, 5)   hsl(15, 90%, 19%)
30      #5c3005rgb(92, 48, 5)   hsl(30, 90%, 19%)
45      #5c4605rgb(92, 70, 5)   hsl(45, 90%, 19%)
60      #5c5c05rgb(92, 92, 5)   hsl(60, 90%, 19%)
75      #465c05rgb(70, 92, 5)   hsl(75, 90%, 19%)
90      #305c05rgb(48, 92, 5)   hsl(90, 90%, 19%)
105     #1b5c05rgb(27, 92, 5)   hsl(105, 90%, 19%)
120     #055c05rgb(5, 92, 5)    hsl(120, 90%, 19%)
135     #055c1brgb(5, 92, 27)   hsl(135, 90%, 19%)
150     #055c30rgb(5, 92, 48)   hsl(150, 90%, 19%)
165     #055c46rgb(5, 92, 70)   hsl(165, 90%, 19%)
180     #055c5crgb(5, 92, 92)   hsl(180, 90%, 19%)
195     #05465crgb(5, 70, 92)   hsl(195, 90%, 19%)
210     #05305crgb(5, 48, 92)   hsl(210, 90%, 19%)
225     #051b5crgb(5, 27, 92)   hsl(225, 90%, 19%)
226     #051a5crgb(5, 26, 92)   hsl(226, 90%, 19%)
240     #05055crgb(5, 5, 92)    hsl(240, 90%, 19%)
255     #1b055crgb(27, 5, 92)   hsl(255, 90%, 19%)
270     #30055crgb(48, 5, 92)   hsl(270, 90%, 19%)
285     #46055crgb(70, 5, 92)   hsl(285, 90%, 19%)
300     #5c055crgb(92, 5, 92)   hsl(300, 90%, 19%)
315     #5c0546rgb(92, 5, 70)   hsl(315, 90%, 19%)
330     #5c0530rgb(92, 5, 48)   hsl(330, 90%, 19%)
345     #5c051brgb(92, 5, 27)   hsl(345, 90%, 19%)
360     #5c0505rgbrgb(92, 5, 5) hsl(0, 90%, 19%)];
our @sb64=('0'..'9','A'..'Z','a'..'z','.','_'); # SingleBase64 array && Base10 hash (since it's probably best not to use b8.pm here in a8)
our %sb10=();$sb10{$sb64[$_]}=$_ for(0..$#sb64);our %crgb;our %cbrt;our @snls;our @mrls;our %cdrd;our %cdrn;   # DclAr ColrDist d8a:BRiTness,Srch iNdex LiSt,
# might also want to load old original handmade b64 8pal8 which is in %pmap to check for l8r distance against  #   MatchRsltLiSt,ColrDistRsltD8a,RsltNdxz
for my $p2rn (0..$#x256){my $p2rv= $x256[$p2rn];my($pred,$pgrn,$pblu)=(hex(substr($p2rv,0,2)),hex(substr($p2rv,2,2)),hex(substr($p2rv,4,2)));
  my   $pkey=          spfd($p2rn);$cbrt{$pkey}=   $pred+$pgrn+$pblu;$crgb{$pkey}=[$pred,$pgrn,$pblu];} # stRt %crgb holding all anon RGB arrayz 4l8r dist ckz
for my $pndx (0.. 15     ){$crgb{$cmsp{'8ANSI'}[$pndx]}=$crgb{spfd(      $pndx )};} # also load up %crgb (was $pb10{ plain b64 8pal8 colr keyz })
for my $p8ck (keys(%p622)){$crgb{               $p8ck }=$crgb{spfd($p622{$p8ck})};} #   from %p622 && mv 2pal8 to 0..15 in ANSI ordr
for my $cnam (sort(keys %nrgb)){my $p2rv= $nrgb{$cnam};my($pred,$pgrn,$pblu)=(hex(substr($p2rv,0,2)),hex(substr($p2rv,2,2)),hex(substr($p2rv,4,2)));
                                   $cbrt{$cnam}=          $pred+$pgrn+$pblu;$crgb{$cnam}=[$pred,$pgrn,$pblu];} # load 684 namd colrs from various rgb.txt files
our %sgrm=('N' =>  0 ,  'S' => 26     , # 0 'N Normal / reset; # SelectGrphcRnditn char atrMap'    # Q 'S reServed : remap?                              '
           'B' =>  1 ,  'r' => 27     , # 1 'B Bold     : on or increased intensity           '    # R 'r image    :  positive        (Reverse: off)     '
           'A' =>  2 ,  'v' => 28     , # 2 'A fAint    : on or decreased intensity           '    # S 'v image    :   Visible (reVeal,conceal: off)     '
           'I' =>  3 ,  'c' => 29     , # 3 'I Italic   : on                                  '    # T 'c not Crossed-out                                '
           'U' =>  4 , #' ' => 30–37  , # 4 'U Underline: single                              '    #U-b'  set     text color       (foreground)          '
           'L' =>  5 ,  'X' => 38     , # 5 'L bLink    : sLow    Less than 150/min           '    # c 'X reserved for eXtended set foreground color     '
           'K' =>  6 ,  'Y' => 39     , # 6 'K blinK    : quicK   more than 150/min           '    # d 'Y default text colorY      (foreground)          '
           'R' =>  7 , #' ' => 40–47  , # 7 'R image    :  negative        (Reverse: on )     '    #e-l'  set     text color       (background)          '
           'V' =>  8 ,  'x' => 48     , # 8 'V image    : inVisible   (Vail,conceal: on )     '    # m 'x reserved for eXtended set background color     '
           'C' =>  9 ,  'y' => 49     , # 9 'C     Crossed-out                                '    # n 'x default text colorY      (background)          '
           '0' => 10 ,  's' => 50     , # A '0 primary (default) f0nt in a new topA map?      '    # o 's reServed : remap?                              '
           '1' => 11 ,  'M' => 51     , # B '1st        altern8  f0nt                         '    # p 'M fraMed   : on                                  '
           '2' => 12 ,  'E' => 52     , # C '2nd        altern8  f0nt                         '    # q 'E Encircled: on                                  '
           '3' => 13 ,  'O' => 53     , # D '3rd        altern8  f0nt                         '    # r 'O Overlined: on                                  '
           '4' => 14 , #'d' =>  ?     , # E '4th        altern8  f0nt                         '    #  ? d mAB remap2 DblOvrlIn+anothr cOd&&comNtBlO d=>24?
           '5' => 15 ,  'm' => 54     , # F '5th        altern8  f0nt                         '    # s 'm fraMed   : off, Encircled: off                 '
           '6' => 16 ,  'o' => 55     , # G '6th        altern8  f0nt                         '    # t 'o Overlined: off                                 '
           '7' => 17 , #' ' => 56–59  , # H '7th        altern8  f0nt                         '    #u-x'  reserved                                       '
           '8' => 18 ,  'H' => 60     , # I '8th        altern8  f0nt                         '    # y 'H ideogram        underline or        line rigHt '
           '9' => 19 ,  'h' => 61     , # J '9th        altern8  f0nt                         '    # z 'h ideogram double underline or double line rigHt '
           'F' => 20 ,  'T' => 62     , # K 'F Fraktur  : on                                  '    # . 'T ideogram         overline or        line lefT  '
           'D' => 21 ,  't' => 63     , # L 'D bold     : off or underline: Double            '    # _ 't ideogram double  overline or double line lefT  '
           'b' => 22 ,  'G' => 64     , # M 'b Bold     : off, fAint  : off or Nrml colr/ntNsT'    #10 'G ideoGram stress marking                        '
           'i' => 23 ,  'g' => 65     , # N 'i Italic   : off, Fraktur: off                   '    #11 'g ideoGram attributes off                        '
           'u' => 24 , #' ' => 90–97  , # O 'u Underline: none                                '    #1Q-1X'set foreground text color, High intensity      '
           'l' => 25 , #' ' =>100–107 , # P 'l bLink    : off                                 '    #1a-1h'set background      color, High intensity      '
          # definitely need more than 1 b64 char to represent dec ndx of all codez past t 63 but [34][0-7] shud probly just control Fb layerz leaving sgr alone
          );our %sgrn=reverse(%sgrm); # also map main iNdices back to keyz (needing differentE8ion 4 each alias below that doesn't get remapd2unique code yet)
          # no Jj Pp Qq Ww Zz ._ above, but remember that new c8 H h layerz for High intensity are not same as ideogram rigHt mapping, so maybe push T t up
          #   to righT && use ._ index matching mapping for future ideogram lefts;
     $sgrm{'n'}=   0 ; #  n => N or remap or maybe altern8 way to toggle Bold back on? nah, just another Normal for now
     $sgrm{'a'}=  22 ; #  a => b or remap to fAint background color or ultra fAint Foreground?
     $sgrm{'f'}=  23 ; #  f => i or remap to other F0nt like a=>futura-1 better than F=>fat? mAB EvNtually f can just disable Fraktur, leaving Italic alone
     $sgrm{'d'}=  24 ; #  d => u or remap to Double overline or just Double underline off but leave potential single Underline (or from B4) intact?
     $sgrm{'k'}=  25 ; #  k => l or remap to some new special custom blinK pulsing color pattern?
     $sgrm{'e'}=  54 ; #  e => m or remap to double fraMEd with some other code, or just turn Encircled off to leave fraMed maybe still on l8r?
sub drkh{ # convert any RRGGBB HEX with channel intensities dropped to 8th int before returning RGBl result, or try better interface? (2du:fix2gNr8 rsltz)
  my $rgbh=shift( @_);my $scal=shift(@_)||(1.0/8);my $valu=0;my $lowb=0;my $rgbs='';
  my @rgbd=split(//,('0'x 6));return('') unless(defined($rgbh) && length($rgbh));
  if(length($rgbh) == 6){@rgbd=split(//,$rgbh); # do $sb64[..] aftr each b10 valu pRtoff b64 6-bit chars while filng lowbits
    for my $rndx ( 0..2){$rgbd[$rndx]=sprintf("%2.2X",int((hex($rgbd[$rndx*2])*16+hex($rgbd[$rndx*2+1]))*$scal));
    } return(h2rl(join('',@rgbd))); } } # should setup taken HEX RGB && scale to darken maybe default colors from d8/fldz.pm for d8g deep darkz
sub rl2h{ # convert any typical b64 RGBL into RRGGBB HEX with Last Low bits Loaded Layered aLready
  my   $rgbs='';while(@_){ # loop all params && join into single end-result string
    my $rgbh=shift( @_);my $valu=0;                       my @rgbd=split(//,('0'x 4));return('') unless(defined($rgbh) && length($rgbh));
    if(length($rgbh) == 4){#$rgbh=uc($rgbh) if($rgbh=~ /[a-z]/);
                                                             @rgbd=split(//,$rgbh); # do $sb64[..] aftr Ech b10 valU pRtoff b64 6-bit chars whIl filng lowbits
      $valu= $sb10{$rgbd[0]} * 4;$valu+=2 if($sb10{$rgbd[3]} & 32);$valu+=1 if($sb10{$rgbd[3]} & 16);$rgbs.= sprintf("%2.2X",$valu);
      $valu= $sb10{$rgbd[1]} * 4;$valu+=2 if($sb10{$rgbd[3]} &  8);$valu+=1 if($sb10{$rgbd[3]} &  4);$rgbs.= sprintf("%2.2X",$valu);
      $valu= $sb10{$rgbd[2]} * 4;$valu+=2 if($sb10{$rgbd[3]} &  2);$valu+=1 if($sb10{$rgbd[3]} &  1);$rgbs.= sprintf("%2.2X",$valu);         } $rgbs.=' ';}
  $rgbs=~ s/ $//;return($rgbs);}
sub h2rl{ # convert any typical HEX RRGGBB into RGBL b64 with Last Low bits Layered (might not want to uc() if 4-char leng or maybe flagd 2cnv bak2 HEX)
  my   $rgbs='';while(@_){
    my $rgbh=shift( @_);my $valu=0;my $lowb=0;my $rgbs='';my @rgbd=split(//,('0'x 6));return('') unless(defined($rgbh) && length($rgbh));
    if(length($rgbh) == 6){                                  @rgbd=split(//,$rgbh); # do $sb64[..] aftr Ech b10 valU pRtoff b64 6-bit chars whIl filng lowbits
      $valu= hex($rgbd[0]) * 16 + hex($rgbd[1]);$rgbs.=$sb64[int($valu/4)];$lowb+=2 if($valu & 2);$lowb+=1 if($valu & 1);$lowb*=4;
      $valu= hex($rgbd[2]) * 16 + hex($rgbd[3]);$rgbs.=$sb64[int($valu/4)];$lowb+=2 if($valu & 2);$lowb+=1 if($valu & 1);$lowb*=4;
      $valu= hex($rgbd[4]) * 16 + hex($rgbd[5]);$rgbs.=$sb64[int($valu/4)];$lowb+=2 if($valu & 2);$lowb+=1 if($valu & 1);$rgbs.=$sb64[$lowb];} $rgbs.=' ';}
  $rgbs=~ s/ $//;return($rgbs);}
sub S{my $Sstr='';my $codz='';if(@_ && defined($_[0])){$codz= join('',@_);} # might want l8r flag optionz as sepR8d by spacez for these joinz though
if((!defined($codz) || !length($codz)) && !-t STDIN){chomp($codz= join('',<STDIN>));}
  if(defined($codz) && length($codz)){ # problM mAB doing !-t ck twice from bin/S to S()?
    if($codz=~  /^--?h/i){print # need to fix lodH usage of old S && gnp8
"   S  - produce eScape codes from c8 Fbs     Vers:$VERSION  d8VS:$d8VS  Auth:$auth
        No more passing ':' colon as placeholder for F or b but instead now colon can be prefixed with desired
        FDALOH bdaloh (&& eventually f f0nt again too) layers, so a single colon with nothing before it should skip expected layers && go str8 to SGR
        attributes like `S :IUC`. If you pass just a '^' caret for Fclr, the reset Normal zero is returned (like ':N', just with two zeroes instead of one).
        `c` should be the inverse function. I should add some sort of global configur8ion flag which will auto-piggy back 8trm f0nt codes with each color.
  -h  - print this Help text and exit;";return('');}
    my @lyrz= qw(F b); # expected default layerz
    if($codz=~ s/^([FDALOHbdalohf]*:+)//){@lyrz= split(//,$1);pop(@lyrz);}
    my @sepc = split(//,$codz);my $Sl8f='';
    if(@sepc && exists($ENV{'TERM'})){
      if   (           $ENV{'TERM'} =~ /^(linux)$/){ # try to replace console F:o with O && p with P
        $sepc[0]= 'O' if($sepc[0] eq 'o');
        $sepc[0]= 'P' if($sepc[0] eq 'p');} # hopefully those are the only 2 in need of correction, && also that this is the right place to do it
      elsif(           $ENV{'TERM'} =~ /^(8trm)$/ && defined($SKpf) && defined($SKpt) && @sb64 == 64){ # try to randomly throw 8trm f0nt codes in with others
        my $rndf=$sb64[int(rand(64))];$rndf= lc($rndf) if($rndf=~ /^[CGHIRT]$/);$rndf='d' if($rndf eq '.');$rndf='1' if($rndf eq '_'); # chng illegible f0nts
        $rndf   ='m' if($rndf=~ /^[8WP]$/i); $rndf='r' if($rndf=~ /^[kY]$/);$Sl8f=$SKpf . $rndf . $SKpt;}} # 8 surely was causing errorz && probably some above
    for(@lyrz){if(@sepc){ # Maybe deprec8 % && # shortcut to X since new DAL layerz are better
        if   (/[FDALOH]/ && $sepc[0]=~ /^[%#]$/){  my $cndx='';       shift(@sepc); # have some support for old Xtended colr shortcut,even tho proly not needed
          if     (@sepc){if($sepc[0]=~ /^[0-9A-F]$/i){$cndx =$sepc[0];shift(@sepc);
              if (@sepc  && $sepc[0]=~ /^[0-9A-F]$/i){$cndx.=$sepc[0];shift(@sepc);} $cndx=  hex($cndx);}
            elsif(          $sepc[0]=~ /^[0-9A-Z._]$/i){                             $cndx=$sb10{$sepc[0]};}
            if(length($cndx)){$Sstr="01;38;5;".spfd($cndx);}else{     shift(@sepc);}} last;} # alow 1 or 2 HEX chars or 1 b64 ndx then skip any other layerz
        if   (/[FDALOH]/ && exists($mc2F{$_ . $sepc[0]})){$Sstr.= ';' if(length($Sstr));$Sstr.=$mc2F{$_ .        $sepc[   0]};}
        elsif(/[bdaloh]/ && exists($mc2b{$_ . $sepc[0]})){$Sstr.= ';' if(length($Sstr));$Sstr.=$mc2b{$_ .        $sepc[   0]};}
       #elsif(/[bdaloh]/ && $sepc[0] !~ /^[-+]$/){say "!*EROR*! No match for layer:$_ with sepc:$sepc[0]! Skipping...";} # detect bg skipz like F: prefix
        elsif(/[f]/      && $sepc[0]=~ /^[0-9A-Z._]$/i  ){$Sl8f = $SKpf . $sepc[0] . $SKpt;} # hopefully don't need to add a -f flag just 2 design8 f0nt layer
        shift(@sepc);}} # should only be 1 or 2 of these since not checking f0nt for now  # might want to save dash skip above for bg -1 versus real 0 blacK
    my $sndx=0;while($sndx <= $#sepc){
      if     ($sepc[$sndx] eq 'X' && $#sepc >= $sndx+2        ){$Sstr.= ';' if(length($Sstr));$Sstr.='01;38;5;'. hex($sepc[$sndx+1].$sepc[$sndx+2]);$sndx+=2;}
      elsif  ($sepc[$sndx] eq 'x' && $#sepc >= $sndx+2        ){$Sstr.= ';' if(length($Sstr));$Sstr.=   '48;5;'. hex($sepc[$sndx+1].$sepc[$sndx+2]);$sndx+=2;}
      elsif  (exists(        $sgrm{$sepc[   $sndx]})){ # mk Bold codez overide Xisting st8 of Fclr,or prepend new,&& append all othrz (until grup ordrz)
        if   ($sepc[$sndx] eq 'b'){if($Sstr=~ /(^|;) 0? 1  (;|$)/x){$Sstr=~ s/(^|;) 0? 1  (;|$)/${1}22$2/x;}else{$Sstr=~ s/^(\d)/22;$1/;}}
        elsif($sepc[$sndx] eq 'B'){if($Sstr=~ /(^|;)(0*|22)(;|$)/ ){$Sstr=~ s/(^|;)(0*|22)(;|$)/${1}01$3/ ;}else{$Sstr=~ s/^(\d)/01;$1/;}} # uprcase Bold on
        else                                                   {$Sstr.= ';' if(length($Sstr));$Sstr.= $sgrm{$sepc[$sndx]};}} $sndx++;}
    if    (length($Sstr)                                      ){$Sstr = $SKp8 . $Sstr    .   'm';  # wrap all digitz && semicolonz as single escape code
      if  (length($Sl8f)                                      ){$Sstr.= $Sl8f                   ;} #  append f0nt code already stored above by f layer
    }elsif(length($Sl8f)                                      ){$Sstr = $Sl8f                   ;} # assign  f0nt code alone
  } return($Sstr);}
sub c{my $Sstr=shift;if(!defined($Sstr) && !-t STDIN){chomp($Sstr= join('',<STDIN>));} my $codz='';my $codF='';my $codb='';my $lyrz='';
  if(defined($Sstr) && $Sstr=~  /^--?h/i){print # need to bild SGR grupz so that Dflt retn is ordrd consistently with max 1 (last) field per grup 4both S&&c
"   c  - produce c8 Fbs codes from escapes    Vers:$VERSION  d8VS:$d8VS  Auth:$auth
        You can pass in most standard escaped color or attribute SelectGraphicRendition codes and this will transl8 it into Fbs format.
        `S` should be the inverse function. Please see `S -h` for details on the few special case c8 characters ':' colon && '^' carat.
  -h  - print this Help text and exit;";return('');}
            $Sstr='' unless  ( defined($Sstr));
  while    ($Sstr=~ s/\e\[([\d;]+)m //x){my $numz=$1;
    while  ($numz=~ s/^ ;?( \d+  );?//x){my $digz=$1; # could a semicolon precede digitz? might want to substitute out of numz below after confirmed existz
      if   ($digz=~  /^(0[01]|22)$/  && $numz=~ s/^(3[0-7]  );?//x && exists($mF2c{"$digz;$1"})){$codF = $mF2c{ "$digz;$1"};} # Dtect stndRd singl colrz
      elsif($digz=~  /^ 4[0-7]   $/x &&                               exists($mb2c{ $digz    })){$codb = $mb2c{  $digz    };} # with O or o layer
      elsif($digz=~  /^ 9[0-7]   $/x &&                               exists($mF2c{ $digz    })){$codF = $mF2c{  $digz    };} # &&   H or h layers now too
      elsif($digz=~  /^10[0-7]   $/x &&                               exists($mb2c{ $digz    })){$codb = $mb2c{  $digz    };}
      elsif($digz=~  /^(0[01]|22)$/x && $numz=~  /^(38;5;\d+);? /x && exists($mF2c{"$digz;$1"})){$codF = $mF2c{ "$digz;$1"};  # catch new Bold XtNdedz
                                        $numz=~ s/^(38;5;\d+);?//x;                                                         }
      elsif($digz=~  /^ 38       $/x && $numz=~  /^(5;   \d+);? /x && exists($mF2c{"$digz;$1"})){$codF = $mF2c{ "$digz;$1"};
                                        $numz=~ s/^(5;   \d+);?//x;                                                         }
      elsif($digz=~  /^ 48       $/x && $numz=~  /^(5;   \d+);? /x && exists($mb2c{"$digz;$1"})){$codb = $mb2c{ "$digz;$1"};  # nEd2!strip hi numzB4ckng4
                                        $numz=~ s/^(5;   \d+);?//x;                                                         } #   8pal8 XistNce
      elsif(exists($sgrn{$digz})){                                                               $codz.= $sgrn{  $digz    };
        if ($sgrn{$digz}=~ /^[Xx]$/  && $numz=~ s/^ 5;0*(\d+);?//x                             ){$codz.=sprintf("%02X",$1 );}}
      elsif($digz=~  /^(0+      )$/x &&                               exists($mF2c{'00'      })){$codF = $mF2c{  '00'     }; }}} # special check for ^ caret 0
  #hile    ($Sstr=~ s/\e\]50;([^\a\e]+)(\a|\e\\)//                                             ){$codf = $1;$codf=':' if($codf !~ /^[0-9A-Z._]$/i);}
  # maybe adding or finding 3 or more 0's before Xx codez can preserve them instead of transl8ing into FDAL layerz as general default
  if(length($codF)){$codF=~ s/^(.)//;$lyrz.=$1 if($1 ne 'F');} #$codb='+';} # make plus or minus bkgr placeholder below, or just prefix F: better?
  if(length($codb)){$codb=~ s/^(.)//;$lyrz.=$1 if($1 ne 'b');}elsif(length($codF) && length($codz) && !length($lyrz)){$lyrz='F';}
  if(length($lyrz) || (!length($codF) && !length($codb))){$lyrz.=':';}
  $codz="$lyrz$codF$codb$codz";return($codz);} # tidy up codez before returning
# 2du:add -help to S2 && c2,mk new Dflt minimum output,mAB optn 2gNr8 Xpanded hedr&&SGR sectnz,DsIning IDeal wAyz2consistNtly Xchng d8a btwn fUtureS2&&c2Bgood,
#   l8r mk new hedr section for qr// to list of layr stringz to apply as stRt of syntax-hilitng nstd of fully line-oriented alignment,add flgz 4 b64 && b256,
#   add flag 4 all sectionz && layrz to be delimited somehow instead of pre-sized in maybe lengthy header,pigybak flgz or cfg Dtailz or cmNtz in hidN SKpzB4 0;
sub S2{ # convert almost any eScaped text string into new col8 format   (totally in-progress); will need locl singl b256 to support big ndxz wiot DpNdNC on b8;
  my     $Stxt= join(' ',@_) || ''; # non -help parameter can get d8a piped in
  if    ($Stxt !~  /(^|\s)-?-?h(elp|\s|$)/i && !-t STDIN){$Stxt=decode('UTF-8',join('',<STDIN>));chomp($Stxt);}
  else  {$Stxt .= "\n S2 - convert eScaped string into col8 format  d8VS:$d8VS Auth:$auth;";}
  my     $ctxt=$Stxt;
         $ctxt=~ s/^/a8:S2:d8VS:$d8VS:hedr:flgz:lyrz:size:lnls:xclu:catr:catu;\n/; # mAB also custom 8pal8 layr dFinition, what else?
  return($ctxt);} # mAB nstd of catu section listing y,x of each Use, betr to just auto-use further sgrSGR... layrz as ndxz of catr exceed 64z &&
                  #   similRly nstd of xclu just have 3 new dflt 8pal8 layrz 4 each of F && b or gNer8 custom layrz by frequency of use;
sub c2{ # convert col8 format into escaped text
  my     $ctxt= join(' ',@_) || '';
  if    ($ctxt !~  /(^|\s)-?-?h(elp|\s|$)/i && !-t STDIN){$ctxt=decode('UTF-8',join('',<STDIN>));chomp($ctxt);}
  my     $Stxt=$ctxt;
         $Stxt=~ s/^[^\n]*\n//;
  return($Stxt);}
sub S2f4{my($text,$Fclr,$bclr,$f0nt  );my $dFbf=':::';my($nxtF,$nxtb,$nxtf)=(split(//,$dFbf)); # Dflt && NeXT Fg && bg colrz && f0nt (try dFbf '^::' ?)
            $text=$Fclr=$bclr=$f0nt='';my $Stxt; # SGR layer should enable non-8pal8 eXtended colors
          # going to probably want to keep sepR8 joinz of both @_ (preferred for flags) && STDIN (preferred for d8a), but still good to have vice versa optnz
  if(!@_ && !-t STDIN){$Stxt=decode('UTF-8',join('',<STDIN>));chomp($Stxt);}  # whN pIpd try2just slurp all
  else                {$Stxt=               join('',     @_) ;$Stxt=join(' ',@_) if($Stxt !~ /\n/);} # default join paramz
  while($Stxt =~ s/^(.*?)(\e\[([\d;]*)m|\e\]4;\d+;#[0-9A-Fa-f]{6}(\a|\e\\)|\e\]50;[^\a\e](\a|\e\\)|\n)//){my $pret=$1;my $esco=$2;
    if(defined($pret) && length($pret)){$text.=$pret;$Fclr.=$nxtF x length($pret);$bclr.=$nxtb x length($pret);$f0nt.=$nxtf x length($pret);}
    if   ($esco eq "\n"               ){$text.=$esco;$Fclr.=$esco                ;$bclr.=$esco;                $f0nt.=$esco;}
    elsif($esco =~ /^\e\[   0  *  m$/x){($nxtF,$nxtb,$nxtf)=(split(//,$dFbf));} # atMpt2recognIze shL outputting empty m (or just zeroez) 2reset2 Normal green
    elsif($esco =~ /^\e\[ [\d;]*  m$/x){my $cofe=c($esco);
      $cofe=~ s/^([FDALOH])?([bdaloh])?:([0-9A-Za-z._]+)/$3/; # hopefully just ignore any non-Fclr or bclr 8pal8 planes for now, until c8 gets new plane layers
                                                          if(length($cofe) >= 1 && substr($cofe,0,1) ne ':'){$nxtF=substr($cofe,0,1);}
                                                          if(length($cofe) >= 2 && substr($cofe,1,1) ne ':'){$nxtb=substr($cofe,1,1);}}
    elsif($esco =~ /^\e\[([012]?) K$/x){my $ecp0=0;$ecp0=$1 if(defined($1)); # specially handle ls output having [K to Xplicitly blank past line end
      ($nxtF,$nxtb,$nxtf)=(split(//,$dFbf)) unless($ecp0);} # CSI n K : EL - Erase in Line (0=cursor to EOL,1=cursor to BOL,2=clear entire line)
    elsif($esco =~ /^\e\]4;(\d+);#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})(\a|\e\\)$/){my $acdn=$1; # upd8 pal8 map with new colors
      my $acdr=int(hex($2)/4);my $acdg=int(hex($3)/4);my $acdb=int(hex($4)/4); # may need to error check each param value
      $pmap{$cmsp{'ANSI'}[$acdn]}= $sb64[$acdr] . $sb64[$acdg] . $sb64[$acdb];}
    elsif($esco =~ /^\e\]50;([^\a\e]*)(\a|\e\\)$/){$nxtf=$1 if(defined($1) && length($1));} # hndl f0nt chngz thN apNd fInal tail BlO wN nO SKpz||nwlInz rEmAn
  } if(defined($Stxt) && length($Stxt)){$text.=$Stxt;$Fclr.=$nxtF x length($Stxt);$bclr.=$nxtb x length($Stxt);$f0nt.=$nxtf x length($Stxt);}
  return(   $text,         $Fclr,         $bclr,         $f0nt);}
sub c2Sl{my $text=shift;my $Fclr=shift;my $bclr=shift;my $f0nt=shift;my $curF=' ';my $curb=' ';my $curf=' '; # CURrent Fg bg colrz && f0nt start with defaultz
  my $Stxt = '';       return()   if    ( ! defined($text) || !length($text)); # may want to handle empty stringz too  # abov cur[Fbf]were[Gkt] but spcnow4all
  $Fclr = $curF x length($text)   unless(   defined($Fclr) &&  length($Fclr)); # do Xpansion of othr layrz 2mk sure substr offset of each text char is found
  $Fclr.= substr($Fclr,length($Fclr)-1,1) x (length($text)  -  length($Fclr)) unless( length($text) <= length($Fclr));
  $bclr = $curb x length($text)   unless(   defined($bclr) &&  length($bclr));
  $bclr.= substr($bclr,length($bclr)-1,1) x (length($text)  -  length($bclr)) unless( length($text) <= length($bclr));
  $f0nt = $curf x length($text)   unless(   defined($f0nt) &&  length($f0nt));
  $f0nt.= substr($f0nt,length($f0nt)-1,1) x (length($text)  -  length($f0nt)) unless( length($text) <= length($f0nt));
  # note that below might be a good default to prECd \n wi $z but shud alsO l8r take a pRam flag 2 leave them alone (or mAB reset aftr instead as anothr opt?)
  for(0..length($text)-1){                if(substr($text,$_,1)    eq   "\n"     ){$Stxt.= $z;}else{ # prECd newlInz with ZrO rEset cOde (is this right?)
      if  ($curF ne substr($Fclr,$_,1) || $curb ne substr($bclr,$_,1)            ){$curF = substr($Fclr,$_,1);
        if($curb ne 'k' && substr($bclr,$_,1) eq 'k'){$Stxt.= $z;$curb = ':';}else{$curb = substr($bclr,$_,1);} # k bg colr diff from none -1 Dflt so ignor
       #if($curb ne 'k' && substr($bclr,$_,1) eq 'k'){$Stxt.= $z;$curb = 'k';}else{$curb = substr($bclr,$_,1);} # actually mAB shud!ignor k bg wich duz -1?
                                                                                   $Stxt.= S("$curF$curb");} # appending sgrlayer will be hard, partz ! alIgnd
     #if  ($curf ne substr($f0nt,$_,1) && $tnhf){        $curf= substr($f0nt,$_,1);$Stxt.= S("f:$curf"   );}    # can't do f0ntz AgN wiot -f Flag2NAble inSKpz
                                                                                 } $Stxt.= substr($text,$_,1);} return($Stxt);}
sub c2f4{my $text=shift;my $Fclr=shift;my $bclr=shift;my $f0nt=shift;my $Stxt; # try ($text,$Fclr,$bclr,$f0nt)= shift(@_)
  if((!defined($text) || !length($text)) && !-t STDIN){my @id8a=<STDIN>;if(@id8a){decode('UTF-8',@id8a);my $bksz=int(@id8a/4);
      for my $indx (0.. $bksz-1){$text=$id8a[$indx];$Fclr=$id8a[$bksz+$indx];$bclr=$id8a[$bksz*2+$indx];$f0nt=$id8a[$bksz*3+$indx];
        $Stxt.=c2Sl(      $text ,$Fclr,$bclr,$f0nt);}}} # break down multi-line blockz into sepR8d linez && hand-off to Col82eScapedLine() helper for the work
  else{ $Stxt =c2Sl(chomp($text),$Fclr,$bclr,$f0nt);} return($Stxt);} # hndl pRamz without trailng nwln,unlIk mor typical pIpng thru (why dif thO?)
sub sS{      my $Stxt=shift;my $sefz=shift; # eScape TeXT, SubstituteEscapeFlagZ  # 2du:sepR8 out lAyrz && mAB add categoriez of CSI cOdez that Dserv IsOl8ion
  if  ( defined($Stxt) && $Stxt=~ /^-*[hCFbsXxfpEedzc]+$/){ # I forget what c8 layerz of SKpz n && m were eventually supposed to be for IsOl8ing?
    if( defined($sefz) && $sefz=~  /[^-hCFbsXxfpEedzc]/  ){($Stxt,$sefz)=($sefz,$Stxt);} # subroutine was originally named subS() for SUBstitute eScapes
    elsif(                !-t STDIN                      ){ $sefz=$Stxt;  $Stxt= undef;}}
  if  (!defined($Stxt) && !-t STDIN                      ){decode('UTF-8',$Stxt= join('',<STDIN>));}
  if( (!defined($sefz) && defined($Stxt) && $Stxt=~  /^-?-?h(elp)?/i) || (defined($sefz) && $sefz=~  /h/i)){my $htxt=
"  sS   - Substitute eScape codes (or commas)   Vers:$VERSION  d8VS:$d8VS
   Auth: $auth  Xmpl:`ls --color=always -A ~| sS`; should add -S SGR Selection
  ...Strip 4 combined attributes like -SIiUu 4 any Italic/Underline on/off out;
    C  - strip all codes beginning with CSI            (like 'FbsXx')
  [Fbs]- strip Foreground, Background, Select graphic rendition codes
    X  - strip foreground  codes for eXtended 256 colors
    x  - strip background  codes for extended 256 colors
    f  - strip F0nt change codes
    p  - strip Pal8 change codes
    E  - duplic8    Escape code   d8a for debugging while still colored
    e  - strip just Escape characters for debugging (like old `S2C8`)
    d  - strip surrounding code, leaving just Digits and semicolons
    z  - wrap codes in Zshell prompt delimiters         '%{' and '%}'
    c  - strip Commas   (unrel8d to eScapes but here for convenience)
    h  - print this Help text and exit.            Default is 'Cfp'.";$htxt.="\n" if(exists($ENV{'COLUMNS'}) && $ENV{'COLUMNS'} <= 80);
    $Stxt=~ s/^-?-?h(elp)?\s*/$htxt/i;}
  elsif(defined($Stxt) && length($Stxt)){my $Sein=0;$Sein=1 if($Stxt=~ /\n$/);$sefz='Cfp' unless(defined($sefz));$sefz=~ s/[^hCFbsXxfpEedzc]//g; #SEndzInNwln?
    if($sefz=~  /C/  ){$Stxt=~ s/ \e \[ [\d;]*         [A-MPSTXZm]//gx  ;} # CSI codes should all fit this pattern && get stripped
    if($sefz=~ /[FbsXx]/){my @Sttd= split(/\n/,$Stxt);for my $lndx(0..$#Sttd){my $tlin=$Sttd[$lndx];my $blin='';
        while($tlin=~ s/^(.*?)\e\[([\d;]+)m//){$blin.=$1 if(defined($1));my $digz=$2;
          if($sefz=~  /F/){$digz=~ s/(^|;)(0?[01]|22)(;3[0-7])+(;|$)/$1$4/g ;$digz=~ s/;;+/;/g;}
          if($sefz=~  /b/){$digz=~ s/(^|;)( 4[0-7]  )(;4[0-7])+(;|$)/$1$4/gx;$digz=~ s/;;+/;/g;}
          if($sefz=~  /X/){$digz=~ s/(^|;)(38; 5    )(; \d+  ) (;|$)/$1$4/gx;$digz=~ s/;;+/;/g;}
          if($sefz=~  /x/){$digz=~ s/(^|;)(48; 5    )(; \d+  ) (;|$)/$1$4/gx;$digz=~ s/;;+/;/g;}
          if($sefz=~  /s/){my @dsep= split(/;/,$digz);my $pdig='';my $ppdg='';if(@dsep){ # split rEmAning digz on semiz && lookBhInd for Xtended colrz
              for my $dndx(0..$#dsep){                                                   #   && also don't strip any normal or bold on or off
                if(exists($sgrn{$dsep[$dndx]}) && ($ppdg !~ /^[34]8$/ || $pdig ne '5') && $dsep[$dndx] !~ /^(0?0|0?1|5|22|[34]8)$/){$dsep[$dndx]='';}
                $ppdg=$pdig;$pdig=$dsep[$dndx];}
              $digz='';$digz= join(';',@dsep) if(@dsep);
          }}  $digz=~ s/(^;+|;;+|;+$)//g;$blin.=$SKp8 . $digz . 'm' if(length($digz));}
        $blin.=$tlin if(length($tlin));$Sttd[$lndx]=$blin if(length($blin));
      } $Stxt= join("\n",@Sttd);$Stxt.= "\n"  if($Sein);} # trying to do some tricky slicing up of codez to isol8 Fbs layerz
    if($sefz=~  /d/  ){$Stxt=~ s/ \e \[([\d;]+)        [A-MPSTXZm]/$1/gx;} # just leave any digitz && semicolon sepR8orz (likely useful for `lsrc`)
    if($sefz=~  /f/  ){$Stxt=~ s/ \e \]50;[^\a\e]*       (\a|\e\\)//gx  ;} # OSC set font.IfBginz wi'#'ndx abs in font mNU or rel8ive if nXt chr '+'or'-'.
    if($sefz=~  /p/  ){$Stxt=~ s/ \e \]4;\d+;#[0-9A-F]{6}(\a|\e\\)//gi  ;} # OSC set pal8 colr.Byond ST StrTrmn8or'Esc\',altern8 BEL 'Ctrl-G' chr(7).
    if($sefz=~  /z/  ){$Stxt=~ s/(\e\[[\d;]*[A-MPSTXZm]|\e\](50;[^\a\e]*|4;\d+;#[0-9A-Fa-f]{6})(\a|\e\\))/%{$1%}/g;} # Zshell ProMpT wrapper
    if($sefz=~  /E/  ){$Stxt=~ s/(\e(\[ [\d;]*         [A-MPSTXZm] ))/$1$2/gx ;  # keep escapez but duplic8 contentz for debugging
       $Stxt=~ s/(\e(\]50;[^\a\e]*|\]4;\d+;#[0-9A-Fa-f]{6})(\a|\e\\))/$1$2\\/g;} #  duplic8 font && pal8 (this warnz 2nd '(' unmatched when /x flag on?)
    if($sefz=~  /e/  ){$Stxt=~ s/ \e//gx;} # strip just escape characters && leave behind any trailing code contentz
    if($sefz=~  /c/  ){$Stxt=~ s/  ,//gx;} # also strip commas for convenience (even though they have basically nothing to do with escapez)
  }else{     $Stxt='';} return($Stxt);}
our @d8cl=();for(split(//,$cmap{'d8bo'})){push(@d8cl,S($_));} # the default d8ColrList is loaded with eScaped formz described by ColrMap's d8bo sequence
sub   d8colr {return(  d8c(@_));}
sub   d8c    {my $rtns = ''; # maybe these should eventually accept flags to select among most useful coloring options
  if(!@_ && !-t STDIN){chomp(@_=decode('UTF-8',<STDIN>));}
  for my $d8st (@_){my @d8di = split(//,        $d8st );my $d8dc = '';for(0..$#d8di){$d8dc .= $d8cl[          $_%@d8cl ] . $d8di[$_]        ;} $rtns.="$d8dc ";
  }      $rtns =~ s/\s$//;return($rtns);}
sub dur8colr {return(dur8c(@_));}
sub dur8c    {my $rtns = ''; # should build     dur8ion colors right-to-left like b8colr but reversing the d8bo color order
  if(!@_ && !-t STDIN){chomp(@_=decode('UTF-8',<STDIN>));}
  for my $d8st (@_){my @d8di = split(//,reverse($d8st));my $d8dc = '';for(0..$#d8di){$d8dc  = $d8cl[$#d8cl - ($_%@d8cl)] . $d8di[$_] . $d8dc;} $rtns.="$d8dc ";
  }      $rtns =~ s/\s$//;return($rtns);}
sub bfr8colr {return(bfr8c(@_));}
sub bfr8c    {my $rtns = ''; # should build b8 fraction colors left-to-right like d8colr but reversing the d8bo color order
  if(!@_ && !-t STDIN){chomp(@_=decode('UTF-8',<STDIN>));} # turn only piping thru in2chompd paramz since skipng over \n (&&what else?) wNrot8ing colrz is hRdr
  for my $b8st (@_){my @b64d = split(//,        $b8st );my $b64c = '';for(0..$#b64d){$b64c .= $d8cl[$#d8cl - ($_%@d8cl)] . $b64d[$_]        ;} $rtns.="$b64c ";
  }      $rtns =~ s/\s$//;return($rtns);}
sub   b8colr {return(  b8c(@_));}
sub   b8c    {my $rtns = ''; # just do coloring stringwise for when sprintf zero-padding a specific width is needed   # mk b8clr 2Dtect commaz && % B4 coloring
  if(!@_ && !-t STDIN){chomp(@_=decode('UTF-8',<STDIN>));}
  for my $b8st (@_){my @b64d = split(//,reverse($b8st));my $b64c = '';for(0..$#b64d){$b64c  = $d8cl[          $_%@d8cl ] . $b64d[$_] . $b64c;} $rtns.="$b64c ";
  }      $rtns =~ s/\s$//;return($rtns);}
sub   b8clr  {my $rtns = ''; # Dtect commaz && % B4 coloring
  if(!@_ && !-t STDIN){chomp(@_=decode('UTF-8',<STDIN>));}
  for my $b8st (@_){my $tdst;my $iprt=0;my $fprt=0;my $comw=0;
    if  ($b8st=~ /^(.+?)[%](.+)$/){$iprt=$1;$fprt=$2;}else{$iprt=$b8st;}
    if  ($iprt=~ /,([^,]+)$/){$comw= length($1);} d8cs('RoYGWCBMpW') if($comw); # assume coma 4 b64 char blox
    $tdst   =            b8colr($iprt);
    if  ($fprt){$comw=0;
      if($fprt=~ /^([^,]+),/){$comw= length($1);} d8cs('WRoYGWCBMp') if($comw); # assume coma 4 b64 char blox reversed
      $tdst.= "$W\%" . bfr8colr($fprt) . $z;} $rtns.= "$tdst ";} $rtns =~ s/\s$//;d8cs('d8bo');return($rtns);} # try2restore default ColrSequ before returning
sub   d8cs   {my $dccs = ''; # d8 ColrSet (or ColrSequence), d8 ColrCodeString
  if(!@_ && !-t STDIN){chomp(@_=<STDIN>);} # turn only piping thru into paramz
  if(!@_){           unshift(@_,'d8bo' );} # should loop through all @_ paramz below appending to dccs,accepting XtNded colr cOdez && use S() nstd of eval $c
  for(@_){if   (/^--?g(et)?    $/ix){ } # do something for get? maybe empty above should be just -get instead && Xplicit 'd8bo' or --reset is better interface?
          elsif(exists($cmap{$_}  )){$dccs.= $cmap{$_};}    # %cmap key namez getz valuz  # might want 2 accept /^m:/i 4DfInd cMapz && /^s:/i 4Xplicit set|sequ
          elsif(/^([0-9A-Z._]+)$/i ){$dccs.=       $_ ;}}   # 8pal8 colr codz             # below popUl8 @d8ColrList wi Xpnded cOdz  #  /^[KROYGCBMPW]+$/i old
# for some strange reason I either needed to call d8cs("$1") with quotes from 8ct or crE8 a new pointless $1 capture group above to avoid uninitd $_ warningz
  if           (length($dccs      )){$dccs =~ s/[^0-9A-Za-z._]+//g;@d8cl=();for(split(//,$dccs)){push(@d8cl,S($_));}} # replaced old end SKpz wi S($_)
  elsif        ($_[0] =~ /\e/      ){@d8cl =       @_ ;}    # assume othr pRamz are already Xpanded list of SKpd colrz 2 rEplAce Dflt (if 1st has SKp)
  $dccs='';     $dccs .= c($_)   for(@d8cl);return($dccs);} # reconstruct ColrCodeString from l8st ColrList (which still must contain SKpz for usage)
sub shfl{ # takes an arrayref or list of items to shuffle, or pipe thru by lines unless either @data size just 1 then try to split scalar string, shfl, join
  my $tflg = 0;my @data;if(@_){@data = @_;}elsif(!-t STDIN){@data = <STDIN>;$tflg = 1;}else{return('');} # TTY FLaG, Solo Scalar String FLaG, Arrayref FLaG
  my $sflg = 0;my $size = 0; # 2du:add param to design8 decoding all @data as UTF-8 && add `shuf --help` optnz -echo -input-range -head-count -output -repeat..
  my $aflg = 0;my $aref;if(ref($data[0]) eq 'ARRAY'){$aflg = 1;}elsif(@data == 1){$sflg = 1;$_ = $data[0];@data = split(//,$_);} # thN add own -help output
  if($aflg){$aref = $data[0];}else{$aref = \@data;} $size = @{$aref};if($size){for(my $indx = ($size-1);$indx;$indx--){my $rand = int(rand($indx+1));
                                                             ($aref->[$indx], $aref->[$rand])=($aref->[$rand], $aref->[$indx]) if($rand != $indx);}}
  if($aflg){return($aref);}elsif($sflg){return(join('',@data));}else{return(@data);}} # should add options like -help && at least `m shuf`
sub sumb{  my $widt=0;$widt=1 if(exists($ENV{'COLUMNS'}) && $ENV{'COLUMNS'} >= 158); # suport norml or doubl wId outpt (wi just widthOK flag4now, nstd of valu)
  my $htxt='';for(@_){        if(/^-?-?h/){$htxt=" sumb - SUMmarizing Binaries crE8d by $auth to colorfully describe my top 96 (or so) executable ~/bin/ files;
   An asterisk '*' after the group name means the file returns at least some form of useful text for parameter -h for help.
  2du:add typz&&cOdz2 .Hrc 4l8r rEcfg,fix widt2BconsistNtly colmz nstd of flag,split this hLp tXt2fit if 80 widt,mk nw optz4anyothrUsefl grupz,sortz,or hIlItz,
   h  - print this Help text && exit               ;  gO thru list&&add similR styl hLp tXt&&pRamz 2 evry Utl,wrkon upd8ng craPSt&&oldSt Utlz2Ball worthwIl,
   l  - List in ls order (instead of GroupByModule);    consistNt,EficiNt,doQmNted,&&hOpfuly dMonstr8ive in some wA;
   u  - Undescribed files should be listed too     ; (this was broken for new ~/bin/ dirs, also auto-wide doesn't color tst/ dir properly like -1 mode)
   1  - force each name && description onto 1 line ; (within the current text of sumb, the character [or single-char string] '8' appears precisely 90 times)
   2  - just start listing 2nd page of descriptions;
   s  - Shuffle list                               ;";}} # H7BM1pTe:sumb word popularity show quite the startling symmetries, patterns, && trends with halves:
#   'to' => 56, 'from' => 28, 'convert' => 22, 'utility' => 22,  'base' => 13, 'decimal' => 6, 'XML' => 6, 'NotYetInModule' => 6; # these R probably top8 4now
  my $gbym= 1;for(@_){$gbym=0 if(/^-?-?[su12]*l/i);} # -l List in ls order (used to be -g GroupByModule 2NAbl the now default)    # tfcu bdXN top8 abbreV8ions
  my $shuf= 0;for(@_){$shuf=1 if(/^-?-?[lu12]*s/i);} # -s Shuffle list  # totally forgot 'color'abov 19,'number'=>10,'string'=>8; # && Wow! '10'=>10, '64'=> 7
  my $sunf= 0;for(@_){$sunf=1 if(/^-?-?[ls12]*u/i);} # -u show Undescribed files                                                  # '*'=>19 (butonly18R4 -help)
  my @ufls=();for(@_){$widt=0 if(/^-?-?[lsu2]*1/i);} # -1 force each description to 1 line (so reset width flag)                  # '!'=> 5 (also much in choo)
  my $s2pf= 0;for(@_){$s2pf=1 if(/^-?-?[lsu1]*2/i);} # -2 just start listing 2nd page                                             # 'char'=>6,'rot'=>5,
  my @bfls= split(/\n/,`ls $ENV{'HOME'}/bin`) if( exists($ENV{'HOME'}) && -d "$ENV{'HOME'}/bin"); # make BinFileLiSt
     @bfls= split(/\n/,`ls   /usr/local/bin`) if(!exists($ENV{'HOME'}) && -d   "/usr/local/bin"); # make BinFileLiSt fallback if no ~/bin to /usr/local instead
  my %bfst=( # BinFileSummaryText (originally was listed in default ls order, but now is reorganized into colored module group sections like default output)
    '8ct'   => "a8 *ColrTest of all four b8 and d8 orient8ions for sequence comparison    ",
    'a8'    => "a8  new d8a object representing ~/.Hrc  (with printing out like `lodH`)   ", # fix 2 fully load obj && output same as lodH
    'b8c'   => "a8  colorizer for  b8  b64 number-strings   (>Right>-to-<Left<< >4wrd>)   ",
    'b8clr' => "a8  colorizer for  b8  b64 which  handles bfr8 (%fractions) and commas    ",
    'bfr8c' => "a8  colorizer for  b8 bfr8 fractions as b64 (<Left<<-to->Right> <Bkwd<)   ",
    'c'     => "a8 *converter from ANSI escape codes to c8 (col8) format    (FbSGR out)   ",
    'c2'    => "a8  converter from new compact c8 format 2 compressed with escape codes   ",
    'c2f4'  => "a8  converter from old 4-layer c8 format 2 compressed with escape codes   ",
    'c8fn'  => "a8  colorizer that loads environment LS_COLORS for paths and FileNames    ",
    'cdst'  => "a8 *sort known Color sets according to closest DiSTance from parameter    ",
    'chti'  => "a8 *CHange TItle for current terminal window within desktop environment   ",
    'curs'  => "a8 *CURSor changing utility for colors, size, and blink  (only console)   ", # mAB rEtIr unless can be extended to alter terminal cursors
    'd8c'   => "a8  colorizer for d8 (Date and Time) stamps (<Left<<-to->Right> >4wrd>)   ",
    'dm2u'  => "a8 *converter of Dos or Mac line-endings to Unix  (double to Single -s)   ",
    'dur8c' => "a8  colorizer for d8 dur8(ion) time-spans   (>Right>-to-<Left<< <Bkwd<)   ",
    'ftst'  => "a8 *colorful listing of Perl File-TeSTs  (and backslashed escape codes)   ",
    'lodH'  => "a8  load ~/.Hrc into d8a-structure and print out colorfully (like `a8`)   ", # mAB rEtIr once a8 struct&&color becomes more capable
    'lrc'   => "a8 *utility to gener8 ~/.lsrc file from ~/.lrc format   (for LS_COLORS)   ",
    'pm2x'  => "a8 *Pal8Map to '2' eXtended (based on Color::Similarity::RGB->distance)   ", # add optz2gNr8 clOsSt 8pal8z 3mor tImz2filup all xtrm256colrz
    'reso'  => "a8  display RESOlution list gener8or  (parameters will match each line)   ", # mAB color
    'S'     => "a8 *converter from c8 (col8) V8 format to ANSI eScape codes (FbSGR in )   ",
    'S2'    => "a8  converter from eScape encoded input to new compact c8 (col8) format   ",
    'S2f4'  => "a8  converter from eScape encoded input to old 4-layer c8 (col8) format   ",
    'shfl'  => "a8  SHuFfLe lines or chars (like Games::Cards::Poker->Shuffle &&`shuf`)   ",
    'sS'    => "a8 *Substitute out (regex Strip) eScape codes by types (just Commas -c)   ", # was subS;mAB betr than -c 2`fact 64|b64|coma|perl -pe 's/,//g'`?
    'sumb'  => "a8 *SUMmarize ~/bin/ described files by color category (displaying now)   ",

    'b10'   => "b8  converter from base-64 number-strings  to  [0-9] base-10 (decimal)    ",
    'b110'  => "b8  converter from base128 number-strings  to  [0-9] base-10 (decimal)    ", # rEnAmd from orig `bb10`
    'b128'  => "b8  converter from base-10 to base-128 b128  (Chess and Cards in UTF-8)   ", # rEtIr b128 b110 ocT deC&&Use b8 nstd?
    'b210'  => "b8  converter from base256 number-strings  to  [0-9] base-10 (decimal)    ",
    'b256'  => "b8  converter from base-10 to base-256 b256  (128 plus common in UTF-8)   ",
    'b64'   => "b8  converter from base-10  digit-strings  to base-64   number-strings    ",
    'b8'    => "b8  converter that tries to auto-detect intended from && to number base   ",
    'choo'  => "b8  n CHOOse m with factorials from combin8orics as  n! / (m! * (n-m)!)   ",
    'cma'   => 'b8  CoMmA insert utility for every 3 digit characters (\d or /[0-9]+/ )   ',
    'cnv'   => "b8  Math::BaseCnv CoNVerter, tries to detect intended base  (like `b8`)   ", # mAB rEtIr orig cnv once b8 is thoroughly reliable instead
    'coma'  => "b8  COMmA insert utility for every 4  b64  characters ( /[A-Z._0-9]+/i)   ",
    'dec'   => "b8  converter from HEXadecimal (base-16)   to  [0-9] decimal (base-10)    ",
    'deC'   => "b8  converter from ocTal [0-7] (base- 8)   to  [0-9] deCimal (base-10)    ",
    'fact'  => "b8  FACTorial calcul8or multiplying a number down to 1  (was in `choo`)   ",
    'fibo'  => "b8  FIBOnacci sequence element calcul8or which takes the decimal index    ",
    'HEX'   => "b8  converter from decimal (base-10)  to UpperCase HEXadecimal   (b16)    ",
    'ocT'   => "b8  converter from deCimal 0-9 (base-10)   to ocTal   [0-7]  (base- 8)    ",
    'prim'  => "b8  PRIMe num sequence element calcul8or which takes the decimal index    ",
    'q'     => "b8 *calQl8or of command-line Math::BigFloat  (in vim :r!q 63xx31 | cma)   ", # fix to use oper8or precedence && parens (prolly nEd2B quOtd)
    'rot1'  => "b8  utility to ROT8 each char of passed in b256 number-strings (by 128)   ", # lIk vim Visual sele thN 'g?' 2rot13
    'rotW'  => "b8  utility to ROT8 each char of passed in b64  number-strings (by  32)   ",
    'sum8'  => "b8  SUM8ion function adding number down to 1 (actually just multiplies)   ",

    '8trm'  => "c8  TeRMinal-like applic8ion (a slow experimental SDL backtick wrapper)   ", # mAB add 8trm features to GnomTerm source instead of SDL App
    'c8'    => "c8  `lsd8` deriv8ive with some cut and hoping to also do cat eventually   ", # flesh out interface for cut part at least (&& mAB cat too)
    'ckm8'  => "c8  ChecKMate custom text Chess SDL applic8ion  (or in Curses::Simp -c)   ", # still need to fix Simp to not core-dump on exit
    'd8ok'  => "c8  Curses::Simp text-mode clOcK with varying speed,form,and meter bars   ",
    'die8'  => "c8  terse random dice-rolling  utility  (as similar to HTTP://Rolz.Org)   ",
    'pmix'  => "c8  Curses::Simp /dev/mixer manipul8ion utility (not used byPulseAudio)   ", # mAB rEtIr aftr mix8 good sinc Pulse proly fUtur
    'prym'  => "c8  Curses::Simp prime-number gener8ion screensaver (currently broken!)   ", # port to prim as new CLI && Curses IF
    'qbix'  => "c8  Curses::Simp Rubik's Cube as spoonerism 'QbixRube' text applic8ion    ", # port to qbx3 wi CLI, Curses, && GL IFz
    'shl8'  => "c8  Source-HighLight8 utility colors detectable syntax within Octology    ", # flesh out c8 hIlItng systM && incrEs suported formatz
    'tsgr'  => "c8  Test Select Graphic Rendition escapes && xterm-256color Blocks (-b)   ", # mAB shud mv2 a8 lIk tstc?
    'wdht'  => "c8  Curses::Simp utility shows resize terminal dimension WiDth x HeighT   ",
    'xx'    => "c8  XxX square teXt eXpansion utility (which scales with 8trm overdraw)   ",

    'calN'  => "d8 *caleNdar utility showing the past many Years (with 1 week per line)   ", # add good optionz like `cal -3` && 2,3,4,6,12-column modez
    'd8'    => "d8 *DateTime stamps and conversion util (-a ANSI color, -f Full format)   ",
    'd8g'   => "d8  DateTime stamp  utility as header for G-mails with  Gerry  (my Dad)   ",
    'd8ow'  => "d8 *DayOfWeek utility taking Year, Month, && Day as d8 YMD param or now   ",
    'dic'   => "d8  wrapper for `dict`(ionary) command  (like piping through `colorit`)   ",
    'lsd8'  => "d8  highly reformatted `ls -lF --full-time` (file-sys Time as d8-stamp)   ",
    'ptcnv' => "d8  CoNVerter from `pt` to new `d8` format (by inserting likely 'zone')   ", # mAB slurp ptold in as optn,in case future autOcnv nEded
    'w8'    => "d8 *wait a dur8(ion) like '3U' as 3.5 seconds or '2qm' as 2.88 minutes    ",
    'pt'    => "Time::PT *for original PipTime module  (main precursor to Octology::d8)   ",

    '2psf'  => "f8  converter from .f0nt plain-text encoding to the .psf binary format    ",
    'etfp'  => "f8 *actual binary executable to gET or sET console Fonts (psf) && Pal8s   ",
    'flet'  => "f8  basic interactive utility to pick desired Font LETters for `figlet`   ", # proly rEwrIt with Curses IF as 8let with d8colr ability
    'pal8'  => "f8 *utility to modify 16-color palettes in either  terminal or console    ", # ad suport4 b256 24bit colrz,8pal8z,&&remapngz
    'psf2'  => "f8  converter from the .psf binary format to .f0nt plain-text encoding    ",

    'xbc'   => "m8  XML Binary Compress utility   (give an .xml file  to     make .xtb)   ", # mAB rEtIr XML cmprs && xpnd utilz since so rarely nEded
    'xbx'   => "m8  XML Binary  eXpand  utility   (give an .xtb file  to  restore .xml)   ", # shud colr fIl XtNsionz
    'xstrp' => "m8  XML STRiP  all   mixed-node whitespace   utility   (from XML::Tidy)   ",
    'xtc'   => "m8  XML  Text  Compress utility (yields smaller .xml  with   same tree)   ",
    'xtidy' => "m8  XML::Tidy inserts indenting whitespace for mixed-node nesting depth   ",
    'xtx'   => "m8  XML  Text   eXpand  utility (restores orig. .xml from before `xtc`)   ",

    'U2b2'  => "U8  download from YouTube just audio in high-quality ('2'=to auto-best)   ",
    'U2b3'  => "U8  download from YouTube just audio in mp3 format (usually transcoded)   ", # proly transcOded NEwA
    'U2b4'  => "U8  reformat 're4mat' the name of a downloaded U2b file to align fields   ",
    'U2b8'  => "U8  download from YouTube a normal video file (in default 1280x720 res)   ",
    'upd8'  => "U8  UPDate development files into ~/lib/ or ~/bin/ dirs after valid8ion   ",
    'UTF8'  => "U8 *wide printing of most UTF-8 (or ASCII) chars up to index (or range)   ", # mAB add more sets of logical blocks && colr b8 char-sets
    'bak'   => "Utl  auto-save now d8-stamp in the end-name of a .bak/ backup file copy   ",
    'e'     => "Utl  EDITOR wrapper which includes a fragile old package templ8 system    ", # mAB rEwrIt mOst Useful BhAVor as nw clEnr U8:e or let dokr:e

    'frip'  => "    NotYetInModule,`flac` Free Lossless Audio Codec CD RIPper (extract)   ",
    'g3'    => "    NotYetInModule,`gst123` Expect wrapper,heavily reformats and colors   ",
    'g8'    => "    NotYetInModule,`git` wrapper,match long commands && .bak/ converter   ",
    'kpc'   => "   *NotYetInModule,`kpcli` deriv8ive for text KeePass (pswd management)   ",
    'mix8'  => "    NotYetInModule,`pmix`  deriv8ive for PulseAudio Curses::Simp mixer    ", # flesh out commandz && CLI before bilding new Curses interface
    'pakr'  => "    NotYetInModule,`qbix` PAcKRube Rubik's Cube format converter  (b64)   ", # add standRd Singmaster not8ion conversion && mAB put in b8.pm
    'pimp'  => "    NotYetInModule,`zinf`  wrapper PipsInteractiveMusicPlaylister audio   ", # mAB rEtIr sinc g3 is alreD gr8 (but consider rand playlistz)
    'shot'  => "   *NotYetInModule,`scrot` wrapper utility to autom8 basic screen SHOTs   ",
    ); # mAB add reverse oper8ion with scaling back down4neg8iv option
  if($s2pf){%bfst=( # BinFileSummaryText (getting set to just 2nd page d8a)
   #'drkh'  => "a8  converter from 6-char HEX to b64 RgbLow with 8th of intensities on    ", # mIt want2add a8:drkh with 8ths of colr chanLz from input too
    'gnp8'  => "a8  GeNer8 full 256-Pal8 color blocks (with 4 planes of 4 shifts of 16)   ", # mAB these colr pal8 blox shud B new optnz for tstc or tsgr nstd
    'h2rl'  => "a8  converter from 6-char HEX to b64 Rgb with 4th char as Low-bit-pairs   ",
    'oupd'  => "a8  UPD8 ~/dvl/t8/Octl/Octology/ `git` repo with l8st files from ~/ dir   ", # was too fragile, but then got included as seeming stable enough
    'rl2h'  => "a8  converter from b64 Rgb with 4th char as Low-bit-pairs to 6-char HEX   ",
    'supd'  => "a8 *util to UPD8 HTTPS://Screeps.Com Scripts ~/.config/ for game client   ",
    'tstc'  => "a8 *TeST eScapes `S` of c8 `c` format for pal8 colors && SGR attributes   ", # mAB fold in2 tsgr && mv latr2 a8,or mk -blox in tstc?

    'fctz'  => "b8  FaCTorlZ listed (takes (lines-1) 47 and 1 b64 or 2 b256 parameters)   ", # `fctz 47 1` is like `fctz | b64` just with different nwln wrapz
    'fibz'  => "b8  FIBonacZ listed up to filling in 48 lines with normally 160 columns   ",
    'prmz'  => "b8  PRiMe..Z listed up to filling in 48 lines with normally 160 columns   ",
    'sumz'  => "b8  SUM8ionZ listed up to filling in 48 lines with normally 160 columns   ",

    'sloc'  => "c8  Beppu-san sent `SlowCat.pl` simul8ing default 9600 baud print speed   ",

    'tstn'  => "p8  TeST random Navig8ion of A* paths thru HTTPS://Screeps.Com maps d8a   ", # new PurPle colr p8 section here is re-comNted sinc just tst4now
    );} # might want to add a8:g for new grep varE8ion && a8:s8 for standard && custom sorts && shuffles
# HBPL7end:reordered by module sections,moved dic from wrong b8 to d8 section,retired ptold sinc shudBeasy2rEmk in d8 if evr nEdedAgN,mAd nw d8ow 2 calc dow;
#   'dow'   => "Time::DayOfWeek *utility taking Year, Month, and Day parameters or now    ",
#   'ptold' => "Time::PT  original 5-character PipTime utility from before  March 2006    ", # mAB rEtIr or fold code in2ptcnv?
# HB4M6rF8:moved old ~/bin/tst ~/bin/.tst to hide it away from sumb && my t8/Octl/Octology/.git repo so scrnshotz can seem more similar && added w8 2 rebalance
#   'tst'      => "    directory where I experiment with new candid8 binary executables   ", # hid this directory as ~/bin/.tst/ instead of handling special -d
# HB1MFGao:made asci alias to new U8:UTF8;
#   'asci'     => "U8 *wide display of most printable ASCII (or UTF-8) chars on 4 lines   ", # mAB add more sets of logical blocks && colr b8 char-sets
#   'calQ'     => "b8 *calcul8or from the command-line using Math::BigFloat obj or sl q   ", # fix to use oper8or precedence && parens (prolly nEd2B quOtd)
#   'q'        => "b8 *symbolic link to `calQ` which can call Quick from vim :r!q 63x31   ", # mAB just mv calQ to q instead?
# H65MDRlb:pokr BKm G::C::Poker/ex/txholdem.pl && should become colrd, accept st8 4 MonteCarlo, gener8 new pre-computed odds mAB rEsMbling .Hrc mor than XML;
#   'pokr'     => "    Games::Cards::Poker simple synopsis example Texas Hold'Em game     ", # mAB colr&&tAk pRamz4how many roundz2run&&sumRIz wi bnkrolz
#   'readhead' => "    read header inform8ion out of binary d8a files (like image size)   ", # rEtIrd as just Utl:rdhd() (mAB mk as shL func2?)
 # H5MM8Hwe:graveyard started here to archive old retired binary files with summaries until I'm sure I'm ready 2 DlEt thM complEtly. 17 of 95 hav a -hLp sO fR;
  # '2lo'      => $W."    Perl one-liner to '2' LOwercase parameter files  (like tolo.exe)   ", # 2lo now moved to just a zsh alias
  # 'bb10'     => $B."b8  converter from base".S('CgB')."128$z$B number-strings to base-${R}10 $B(${R}dec${B}imal)         ", # rEplAcd wi `b110` abov
  # 'calc'     => $Y."Utl calcul8or from the command-line            (precursor to `calQ`)   ",
  # 'cdx'      => $W."    NotYetInModule, CompactDisc music eXtraction utility script        ", # this was supplanted by superior frip
  # 'cfdd'     => $Y."Utl Consolid8 Files Discarding Duplic8s to clean up hard drives        ",
  # 'cln'      => $W."    symbolic link to `calc` for historical familiarity   (now alias)   ",
  # 'cnvimgz'  => $W."    NotYetInModule, CoNVerts a directory of images   (old and basic)   ",
  # 'dum2umd'  => $W."    NotYetInModule, converts DosUnixMac file line-endings (now dm2u)   ",
  # 'fdmr'     => $W."    NotYetInModule, Fix Duplic8 Music Rips (old and inflexible)        ",
  # 'getc'     => $W."    script to experiment with IO::Handle and Select for Expect         ",
  # 'grepp'    => $W."    Unix grep clone in Perl by graff on HTTP://PerlMonks.Org           ",
  # 'gvdIfmt'  => $W."    git vim dif all nested around central I pivot character            ",
  # 'hex'      => $B."b8  same as heX, not same as Perl's hex built-in (old and confusing)   ", # rEtIrd heX BlO as unfAvrd,&&alias hX='HEX|tr A-Z a-z' workz
  # 'heX'      => $B."b8  converter from$R dec${B}imal (base-${R}10$B)  to lowercase ".S('5rB')."heX$z${B}adecimal (b".S('5rB')."16$z$B)   ",  # sAme nstd
  # 'locd'     => $Y."Utl loc8 duplic8s utility to clean up hard drive storage redundancy    ",
  # 'longlinz' => $Y."Utl print long line info from environment                              ",
  # 'lsd8xt'   => $R."d8  almost same as     `lsd8 `  (with no color or f0nt escape codes)   ", # was similR Enuf 2 `lsd8|sS` 2 rEtIr
  # 'lsrc'     => $C."c8  oldutil 2 gener8 $B~$Y/$M.lsrc$C file from $B~$Y/$M.lrc$C format (for LS_COLORS)   ",
  # 'm4a2mp3'  => $W."    converter from Mpeg4Audio to MPeg1layer3  format  (using ffmpeg)   ", # rEtIred as zsh function m423()
  # 'sarep'    => $W."    SearchAndREPlace tool written by Matthew Borowski                  ", # mAB rEvIv if studying provez useful (ck4newer version 1st)
  # 'scal'     => $W."    old image SCALing utility using Gimp.pm and Gimp::Fu               ",
  # 'sortfile' => $W."    sorts the lines of a parameter file              (old and basic)   ",
  # 'tolo'     => $W."    Perl one-liner to lowercase parameter filenames   (now as `2lo`)   ",
  # 'updt'     => $Y."Utl update (precursor to `upd8` without as much valid8ion)             ", # rEtIrd tIny script&&now just an alias (in Ks orig stil nEded)
  # 'Xpct'     => $Y."U8  experiment with eXPeCT  (almost same as `g3` and slurped in2 U8)   ",
  # 'ZdifTriq' => $W."    old Gentoo hard-drive /z to /Z comparison utility                  ",
  # 'zpmt'     => $G."a8  format escaped text for Zsh ProMpT command-line width detection    ", # now replaced with `sS z`
 # H4NM4NM4:keeping to exactly 1 160x50 page contains barely worthwhile:c8,curs,mix8,pimp,pmix,prym,readhead,shl8 so try2upd8 them to be useful or retire them;
  my $bfle=$#bfls;my %bftc=('grup'=>{'a8'=>'F:A','b8'=>'F:B','c8'=>'F:C','d8'=>'F:R','f8'=>'F:o','m8'=>'F:M','U8' =>'F:Y', # BinFilzListEnd && TypeCodez
                       'dirz'=>'F:N','no'=>'F:W',     'Time::DayOfWeek'=>'F:F','Time::PT'=>'F:F','p8'=>'F:p','Utl'=>'F:5',       }, # mABkeyz shudB qr// nstd?
                            'modu'=>{ 'Math::BaseCnv'=>'D:B',       'Similarity::RGB->distance'=>'F:C','Games::Cards::Poker->Shuffle'=>'F:p','XML::Tidy'=>'pb',
             'Math::BigFloat'=>'F:C', 'C::S'=>'Zb','Curses::Simp'=>'Zb', 'C::Simp'=>'Zb','DiSTance'=>'F:C','Octology::d8'=>'F:R',},
                            'file'=>{'~' =>'F:B','\/'=>'F:Y','\.'=>'Ib','fn'=>'Mb','`' =>'yk','cf'=>'F:G','\*'=>'W1','\+'=>'Rb','mixer'=>'F:o','Date'=>'L:R',
     'strings'=>'F:8','ANSI'=>'ob', ',' =>'Lk','bfr8'=>'F:B','col8'=>'F:C','dur8'=>'F:R',      '\('=>'Wn','\)'=>'Wn','\['=>'ob','\]'=>'ob','ASCII'=>'Ab',
                                             '\.config'=>'F:B','columns'=>'Ck',
  'EDITOR'=>'Un','LS_COLORS'=>'Yn','bin'=>'F:B','\.bak'=>'F:B','\.Hrc'=>'F:M','\.psf'=>'F:M','\.f0nt'=>'Cg','\.xml'=>'ob','\.xtb'=>'F:B', # SKpspecialz
      'down'=>'F:U','SKpz'=>'F:7',   '!' =>'Fk','HTTP' =>'F:H','Org'=>'F:X','Rolz'=>'F:M','gst123'=>'F:G','git'=>'F:G','kpcli'=>'F:G','YouTube'=>'5r',
      'Perl'=>'Cb' ,'vim' =>'Vb','Unix' =>'Xb', 'HTTPS'=>'F:H','Com'=>'F:B','Screeps'=>'F:C',            'text'=>'F:F', 'time'=>'F:F',    'U2b'=>'5r',
      'load'=>'F:5','cRdz'=>'Cc','Chess'=>'Ww','base'=>'F:X', 'UTF'=>'Gb','SDL'=>'SN',    'pmix'=>'F:G','aumix'=>'F:G',          }, # mAB squEz all fIlz into
                            'base'=>{' 8'=>'ok','16'=>'5r','64'=>'Ac','128'=>'Cb','256'=>'Md','10'=>'Fn','dec'=>'Fn','ocT'=>'ok',}, #   betr vertical column?
                            'colr'=>{'L' =>'Xg','R' =>'Rw', '4'=>'Aq', 'B'=>'M0', '2'=>'F:V',                                    },
                            'b64r'=>{'\['=>'Xw','-'=>'pk','0'=>'Gb','9'=>'pb','A'=>'gb','Z'=>'Fb','\.'=>'Wb','_'=>'Ub','7'=>'Ub',}, # rEmMbr2ignorthiswhol tkey
                            'xmlt'=>{'Text'=>'F:R','Binary'=>'F:B','Compress'=>'F:C','eXpand'=>'F:Y','whitespace'=>'F:W',        },
                            'd8fz'=>{'Year'=>'Fb','Month'=>'ob','Day'=>'Yb','week'=>'ok','zone'=>'Gb','displaying'=>'HARL','now'=>'HIRK',},);
  my $i;my $j="$z$SKp1".'m'; # Jump_bak2zero_bold
  my $d;my $e;my $f;my $h; # additional SKp code holder variablez; $i reInit && $j Jumpbak are the locl onez 2 prEserv
  my $l;my $n;my $q;my $s; # have 'defh lnqs' 8 2Uz4 b64r especially, but then can be used for plenty else, forgot $a is for sort, still avail: $t $u $v $x
  for (0..$bfle){my $grup='';#$grup='dirz' if(-d "$ENV{'HOME'}/bin/$bfls[$bfle - $_]"); # commenting out subdirectory check, because trying to hide priv8 tst/
    if( exists($bfst{$bfls[$bfle - $_]})){
      if($bfst{$bfls[$bfle - $_]}=~  /^\s*(\S+)/){$grup=$1 unless($grup eq 'dirz');$i=$j; # look for group to match Xpected as always 1st non-space string
        $grup='no' unless( exists($bftc{'grup'}{  $grup})); # if no match, set group to 'no'
        $i.=S($bftc{'grup'}{$grup}); # OvrId if directory (fnd out why no sumRy 4 tst/ is matchng but not showng unknown so it shud B there)
        $bfst{ $bfls[$bfle - $_]}=~ s/^(\s*)(\S)/$1$i$2/; # prepend group color to whole line text
        $bfst{ $bfls[$bfle - $_]}=~ s/(:)(\s*r)(\s*!)(\s*\w+)(\s*[^x*d\/m\%p+m-]+)(\s*[x*d\/m\%p+m-]+)
                                                             (\s*[^x*d\/m\%p+m-]+)(\s*\|)(\s*\w+)/$W$1$Y$2$B$3$G$4$M$5$O$6$M$7$W$8$G$9$i/x; # colr vim cmdB4!
       #$l=S($bftc{'file'}{ '\[' });$bfst{$bfls[$bfle-$_]}=~ s/([\[]+)/$l$1$i/gx; # Xplicitly do brak Left  # nEd2!do Left bracket this smpl wA sinc ruinz SKpz
       #$l=S($bftc{'file'}{ '\]' });$bfst{$bfls[$bfle-$_]}=~ s/([\]]+)/$l$1$i/gx; # Xplicitly do brak Rite
        $h=S($bftc{'file'}{ '!'  });$bfst{ $bfls[$bfle - $_]}=~ s/(\W| [nmr])(!)/$1$h$2$i/gx;d8cs('oCRoMoGY' ); # tryng some non-d8bo colrsequ for Octology too
        $h=d8colr('Octology'      );$bfst{ $bfls[$bfle - $_]}=~ s/Octology      /$h$i/gx    ;d8cs('CoMoR'    ); # colr bangz 1st thng,thN all"color",cnv,&& utl
        $h=d8colr('color'         );$bfst{ $bfls[$bfle - $_]}=~ s/([^`])color   /$1$h$i/gx  ;                   # alsObAsic2pal8regXzBlO du!Use $h or $l 2lFt
        $h=d8colr('Color'         );$bfst{ $bfls[$bfle - $_]}=~ s/([^`])Color   /$1$h$i/gx  ;d8cs('IIIIJQQ'  ); # && new cdst descriptn has capitalIzd "Color"
        $h=d8colr('wrapper'       );$bfst{ $bfls[$bfle - $_]}=~ s/wrapper       /$h$i/gx    ;d8cs('XXXNNN111'); # && new White "wrapper" varE8ionz
        $h=d8colr('converter'     );$bfst{ $bfls[$bfle - $_]}=~ s/converter     /$h$i/gx    ;                   # && get old BaseCnv cnv capitalized
        $h=d8colr('CoNVerter'     );$bfst{ $bfls[$bfle - $_]}=~ s/CoNVerter     /$h$i/gx    ;d8cs('GBZOM'    ); # && try to get S && c col8 post-text layrz
        $h=d8colr('FbSGR'         );$bfst{ $bfls[$bfle - $_]}=~ s/FbSGR         /$h$i/gx    ;d8cs('9TZZB'    ); # shud upd8 these 2use more Blue shAdz,!Cyanz
        $h=d8colr('lines'         );$bfst{ $bfls[$bfle - $_]}=~ s/lines         /$h$i/gx    ;d8cs('9TBZZZ'   );
        $h=d8colr('listed'        );$bfst{ $bfls[$bfle - $_]}=~ s/listed        /$h$i/gx    ;d8cs('ZC9TVmM'  ); # rEmMbr2rEset2 d8bo whN done BlO
        $h=d8colr('utility'       );$bfst{ $bfls[$bfle - $_]}=~ s/utility       /$h$i/gx    ;
        $h=d8colr('util'          );$bfst{ $bfls[$bfle - $_]}=~ s/util          /$h$i/gx    ;d8cs('d8bo'     ); # should be same as 'RoY' or close
        $h=d8colr('YMD'           );$bfst{ $bfls[$bfle - $_]}=~ s/YMD           /$h$i/gx    ;d8cs('mmmMMMppVVVVVV'); # NYIM was orig S('mkB') at very end
        $h=d8colr('NotYetInModule');$bfst{ $bfls[$bfle - $_]}=~ s/NotYetInModule/$h$i/gx    ;d8cs('d8bo'     ); # du!Uz $i $j 2map 8pal8z in2 fldz BlO
        $h=S('Z');$bfst{$bfls[$bfle-$_]}=~ s/(Select\s*)(Graphic\s*)(Rendition)/$h$1$O$2$M$3$i/;    # get SGR ZOM 4 tsgr
                  $bfst{$bfls[$bfle-$_]}=~ s/      (\s+)(S)(G)(R)(\s+)       /$1$h$2$O$3$M$4$i$5/x; # get SGR ZOM 4 tstc (spc-sepR8d)
        if($grup eq 'd8' && $bfls[$bfle - $_] eq 'w8'){ # should properly color quoted example dur8ions in whatever w8 description
          while($bfst{$bfls[$bfle - $_]}=~  /(\s)(['"])([0-9A-Za-x]+)\2/){$s=$1;$q=$2;$d=$3;$e=dur8colr($d);
            $bfst{    $bfls[$bfle - $_]}=~ s/($s)(['"])([0-9A-Za-x]+)\2/$1$G$2$e$G$2$i/;}
          $bfst{      $bfls[$bfle - $_]}=~ s/(fra?me?  s?)/$p$1$i/gx;
          $bfst{      $bfls[$bfle - $_]}=~ s/(sec(ond)?s?)/$M$1$i/g ;
          $bfst{      $bfls[$bfle - $_]}=~ s/(min(ute)?s?)/$B$1$i/g ;
          $bfst{      $bfls[$bfle - $_]}=~ s/(ho?u?r   s?)/$C$1$i/gx;}
        # mAB mk d8colr 4 NotYetInModule 2,&& rm from Nd of %bftc
        $d=S($bftc{'modu'}{'Games::Cards::Poker->Shuffle'});$bfst{$bfls[$bfle-$_]}=~ s/(Games::Cards)(::Poker->Shuffle)/$d$1$d$2$i/gx; # set colrz around Cards
        $d=S($bftc{'b64r'}{'\['});
        $e=S($bftc{'b64r'}{ '-'});
        $f=S($bftc{'b64r'}{ '0'});
        $h=S($bftc{'b64r'}{ '9'});
        $l=S($bftc{'b64r'}{ 'A'});
        $n=S($bftc{'b64r'}{ 'Z'});
        $q=S($bftc{'b64r'}{'\.'});
        $s=S($bftc{'b64r'}{ '_'});
        $bfst{ $bfls[$bfle - $_]}=~ s/(\/)(\[)(0)(-)(9)(\])(\+\/)/$1$d$2$f$3$e$4$h$5$d$6$i$7/x; # just co?ma regXz stRtd as basic 2pal8, mAB nEd pRam shft BlO?
        $bfst{ $bfls[$bfle - $_]}=~ s/ \/ (\[)(A)(-)(Z)(\.)(_)(0)(-)(9)\]\+\//\/$d$1$l$2$e$3$n$4$q$5$s$6$f$7$e$8$h$9$d\]$i+\//x; # 1st9duz!capture clos braket
        $bfst{ $bfls[$bfle - $_]}=~ s/(\s)(\[)(0)(-)(9)(\])(\s)  /$1$d$2$f$3$e$4$h$5$d$6$i$7/x; # just get non-regex     bracketed decimal rangez too
        $bfst{ $bfls[$bfle - $_]}=~ s/(\s)    (0)(-)(9)    (\s)  /$1$f$2$e$3$h$4$i$5/x;         # just get non-regex non-bracketed decimal rangez too
        $h=S($bftc{'b64r'}{ '7'});
        $bfst{ $bfls[$bfle - $_]}=~ s/(\s)(\[)(0)(-)(7)(\])(\s  )/$1$d$2$f$3$e$4$h$5$d$6$i$7/x; # then [0-7] ocT rangez enclosed
        $h=S($bftc{'file'}{'cf'});
        $l=S($bftc{'file'}{'`' });
        $bfst{ $bfls[$bfle - $_]}=~ s/(`)([^`]+)(`)/$l$1$h$2$l$3$i/g; # Xplicitly do baktikd CommandFile 2gether 1st (Cmz2wrk wL)
        $h=S($bftc{'file'}{'~' });$s=S($bftc{'file'}{'bin'});
        $l=S($bftc{'file'}{'\/'});$d=S($bftc{'file'}{'\.' });
        $bfst{ $bfls[$bfle - $_]}=~ s/(~)(\/)(dvl)(\/)(t8)(\/)(Octl)(\/)/$h$1$l$2$s$3$l$4$s$5$l$6$s$7$l$8$i/gx;
        $bfst{ $bfls[$bfle - $_]}=~ s/(~)(\/)(\.)(config )(\/)/$h$1$l$2$d$3$h$4$l$5$i/gx;
        $bfst{ $bfls[$bfle - $_]}=~ s/(~)(\/)(bin|lib    )(\/)/$h$1$l$2$s$3$l$4$i/gx;
        $bfst{ $bfls[$bfle - $_]}=~ s/(~)(\/)(\s)             /$h$1$l$2$3$i/gx      ;$s=S($bftc{'file'}{ 'mixer'}); # get  /dev/mixer dir
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\/)(dev)(\/)(mixer )/$l$1$h$2$l$3$s$4$i/gx;$s=S($bftc{'file'}{'\.bak' }); # get ~/ *  / dirz
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(\.)(bak    )(\/)/$1$d$2$s$3$l$4$i/gx  ;$s=S($bftc{'file'}{'\.Hrc' }); # get   .bak/ dirz
        $bfst{ $bfls[$bfle - $_]}=~ s/(~)(\/)(\.)([Hl]s?rc   )/$h$1$l$2$d$3$s$4$i/gx;$s=S($bftc{'file'}{'\.psf' }); # get ~/.*rc  filz
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(\()(psf )(\s|\))/$1$2$s$3$i$4/gx      ;                               # get   (psf)
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(\.)(psf )(\s   )/$1$d$2$s$3$i$4/gx    ;$s=S($bftc{'file'}{'\.f0nt'}); # get   .psf  filz
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(\.)(f0nt)(\s   )/$1$d$2$s$3$i$4/gx    ;$s=S($bftc{'file'}{'\.xml' }); # get   .f0nt filz
        $bfst{ $bfls[$bfle - $_]}=~ s/(er|\s)(\.)(xml )(\s|\))/$1$d$2$s$3$i$4/gx    ;$s=S($bftc{'file'}{'\.xtb' }); # get   .xml  filz (1rItaftr'smaller'nospc)
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(\.)(xtb )(\s|\))/$1$d$2$s$3$i$4/gx    ;$d=S($bftc{'base'}{  '64'  }); # get   .xtb  filz
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\(b)   ( 64 )       /(${B}b$d$2$i/gx      ;                               # get    b64
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\sb)   ( 64 )       /$1$d$2$i/gx          ;$d=S($bftc{'base'}{  '16'  }); # get    b16
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\(b)   ( 16 )       /$1$d$2$i/gx          ;                               # du b16
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)    (HEX )(adeci)/$1$d$2$i$3/gx        ;$d=S($bftc{'base'}{ 'ocT'  }); # du HEX
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)    (ocT )(al   )/$1$d$2$i$3/gx        ;$d=S($bftc{'base'}{  '10'  }); # du ocT
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s|\() (de[cC])(ima)/$1$d$2$i$3/gx        ;$d=S($bftc{'base'}{ '128'  }); # du deC or dec
        $bfst{ $bfls[$bfle - $_]}=~ s/  (b(ase)?)(128 )(\s   )/$1$d$3$i$4/gx        ;$d=S($bftc{'base'}{ '256'  }); # du 128
        $bfst{ $bfls[$bfle - $_]}=~ s/  (b(ase)?)(256 )(\s   )/$1$d$3$i$4/gx        ;$s=S($bftc{'d8fz'}{'2006'  }); # du 256 hopefully both b256 && base256
        $bfst{ $bfls[$bfle - $_]}=~ s/   (xterm-)(256 )(color)/$1$d$2$i$3/gx        ;$d=S('Mb');
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\D    )(  4 )(\D   )/$1$d$2$i$3/gx        ;$d=S('Yg');
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\D    )(  6 )(\D   )/$1$d$2$i$3/gx        ;$d=S('ob'); # du some basic sumb page2 b8 sequence listz
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\D    )( 47 )(\D   )/$1$d$2$i$3/gx        ;$d=S('Yb');
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s    )( 48 )(\s   )/$1$d$2$i$3/gx        ;$d=S('Gr');
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s    )(160 )(\s   )/$1$d$2$i$3/gx        ;$d=S('Rk');
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s    )(9600)(\s   )/$1$d$2$i$3/gx        ;$d=S($bftc{'d8fz'}{'March' }); # du 256 more
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)   (March)(2006 )/$1$d$2$s$3$i/gx      ;$d=S($bftc{'file'}{ 'cRdz' }); # du d8 fldz M && Y from ptold
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s|:) (Cards)(\s|:|\e)/$1$d$2$i$3/gx      ;$d=S($bftc{'file'}{ 'SKpz' }); # just get b128 Cards, not Gmz:Cards:Pokr
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)(e[Ss]capes?)(\s)/$1$d$2$i$3/gx        ;$d=S($bftc{'file'}{ 'down' }); # mAB want to d8colr for SKpz too?
                                                                                     $l=S($bftc{'file'}{ 'load' }); # du downloadz in half
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s)   (down)(load(ed)?)/$1$d$2$l$3$i/gx   ;$d=S($bftc{'file'}{ 'time' }); # du all time && Time
        $bfst{ $bfls[$bfle - $_]}=~ s/  (full-)(   time)(  \W)/$G$1$G$2$i$3/gx      ; # pre-colr ls flag's "-time" B4 next match would make Reddish
        $bfst{ $bfls[$bfle - $_]}=~ s/   (\s|e)([Tt]ime)(  \W)/$1$d$2$i$3/gx        ; # mAB shud add Date
        for   my $tkey (sort(keys(  %bftc        ))){ # these orderz probably matter too
          for my $ckey (sort(keys(%{$bftc{$tkey}}))){$h=S($bftc{$tkey}{$ckey}); # load Hilite, then start doing some key transl8ion before searching on it
              my $srch=$ckey;$srch='<Left<<' if($srch eq 'L');$srch='<Bkwd<' if($srch eq 'B');
                             $srch='>Right>' if($srch eq 'R');$srch='>4wrd>' if($srch eq '4');
            if  ($ckey !~  /^(no|cf|fn|dirz|~|bin|\.bak|\.Hrc|\*|\(|\)|\[|\]|\+|:|2|!)$/ && $tkey ne 'b64r'){ # don't do None group,CmdFil,FlNm etc or b64regX
              if($srch =~  /^(\.|,)$/){$bfst{$bfls[$bfle - $_]}=~ s/      ($srch)      /$h$1$i/gx  ;}    # try non-delimited just for keyz that seem fine
              else                    {$bfst{$bfls[$bfle - $_]}=~ s/(\W  )($srch)(\W)/$1$h$2$i$3/gx;}}}} # try just lookng4IsOl8d srchz;
        $l=S($bftc{'modu'}{'DiSTance'});$bfst{$bfls[$bfle-$_]}=~ s/(:)(R)(G)(B)(-)/$1$R$2$G$3$B$4$l$5/;  # insert RGB
        $l=S($bftc{'file'}{'\/'});$bfst{$bfls[$bfle-$_]}=~ s/( \/ +)/$l$1$i/gx;  # Xplicitly do slashz at Nd
        $l=S($bftc{'file'}{'\*'});$bfst{$bfls[$bfle-$_]}=~ s/( \* +)/$l$1$i/gx;  # Xplicitly do stRz
        $l=S($bftc{'file'}{'\+'});$bfst{$bfls[$bfle-$_]}=~ s/( \+ +)/$l$1$i/gx;  # Xplicitly do plus
        $l=S($bftc{'file'}{'\('});$bfst{$bfls[$bfle-$_]}=~ s/( [(]+)/$l$1$i/gx;  # Xplicitly do pRNz Left
        $l=S($bftc{'file'}{'\)'});$bfst{$bfls[$bfle-$_]}=~ s/( [)]+)/$l$1$i/gx;  # Xplicitly do pRNz Rite
        $h=S($bftc{'colr'}{ '2'});$bfst{$bfls[$bfle-$_]}=~ s/(-to- )/$h$1$i/gx;  # Xplicitly do colr btwn Lz && Rz
       #$d=S($bftc{'d8fz'}{'NotYetInModule'     });$bfst{$bfls[$bfle-$_]}=~ s/(NotYetInModule     )/$d$1$i/gx; # try2fInaly do !YetInMod
      }
    }else{
          if($sunf){                                                            push(@ufls,$bfls[$bfle - $_]);} # ShowUNdescribedFiles saved for l8r
                                                     splice(@bfls,$bfle - $_,1);  # && cut out as will no longr B needed since dflt rebilds BinFileLiSt ordr
         #if($sunf){$bfls[$bfle - $_] .= ' ' x (80 - length($bfls[$bfle - $_]));push(@ufls,$bfls[$bfle - $_]);} # ShowUndescribedFiles saved for l8r
         #elsif(    $bfls[$bfle - $_] ne 'tst'){     splice(@bfls,$bfle - $_,1);} # or cut non-dir may no longr B needed since dflt rebilds BinFileLiSt ordr
         }}
  my   $blih=int(@bfls/2); # BinListInHalf
  my   @bgls=qw(a8 b8 c8 d8 Time::PT f8 m8 p8 U8 Utl none dir);my %bgml=();for(@bgls){$bgml{$_}= [];} # init BinGroupLiSt && BinGroupMemberList
  for (@bfls){#f(-d "$ENV{'HOME'}/bin/$_"){my $dlen=length($_)+1;$_ = "$B$_$Y/";$_ .= ' ' x (9-$dlen) if(9 > $dlen);} # old custom colr of any bin subdirz
    if($gbym){if(-d "$ENV{'HOME'}/bin/$_"){       push(@{$bgml{'dir'}},$_);} # directories used to get a slash appended above, which was checked for here
           elsif(exists($bfst{$_})){my $fdsc=$bfst{$_};$fdsc=~ s/^(\s+|\e\[[0-9;]*m)+//g; # strip leading SKpd colrz from Ech FileDeSCription to reveal module
        if($fdsc=~ /^(\S+)/ && exists($bgml{$1})){push(@{$bgml{ $1  }},$_);}else{push(@{$bgml{'none'}},$_);}}}}
  if($gbym){@bfls=();for(@bgls){for my $flnm (@{$bgml{$_}}){push(@bfls,$flnm);}}} # reorder main BinFileLiSt according to detected groups from above
  if($shuf){shfl(\@bfls);} # maybe option to random shuffle order
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  $h= S($bftc{'file'}{ 'cf' }); # load CommandFile codez 1st
  $f= S($bftc{'file'}{ '\/' }); # load dir sepR8or Forward slash
  $d= S($bftc{'grup'}{'dirz'}); # load Dircolr
  if   ($htxt){print  $out8 $htxt;}
  elsif($widt){my $dirn; # I really don't understand this section of code well enough to yet figure out how to dir-colr for widt like the working linear below
    if(@bfls % 2){ # tried altern8ing dark blue bkgr, but too stripey && $O was resetting but should be as hard now
      for (0 ..         $blih  ){ # after [bd]([fu]r)?8colr shrunk to just .*8c, replaced 8 orig '9s' values with '6s' instead
        if(-d "$ENV{'HOME'}/bin/$bfls[$_]"){$dirn= sprintf("%-6s",$bfls[$_].'/');$dirn=~ s/(\/)/$f$1$d/g; # 4m@ && colr dir key
                                   printf($out8 "$d%s"  ,$dirn            );print $out8 $bfst{$bfls[$_        ]} if(exists($bfst{$bfls[$_        ]}));
        }else{                     printf($out8 "$h%-6s",$bfls[$_        ]);print $out8 $bfst{$bfls[$_        ]} if(exists($bfst{$bfls[$_        ]}));
        }
        if(-d "$ENV{'HOME'}/bin/$bfls[$_]"){$dirn= sprintf("%-6s",$bfls[$_].'/');$dirn=~ s/(\/)/$f$1$d/g; # 4m@ && colr dir key
          if(@bfls > $_+$blih+1){  printf($out8 "$d%s"  ,$dirn            );print $out8 $bfst{$bfls[$_+$blih+1]} if(exists($bfst{$bfls[$_+$blih+1]}));
                                   say    $out8  $z;}
        }else{
          if(@bfls > $_+$blih+1){  printf($out8 "$h%-6s",$bfls[$_+$blih+1]);print $out8 $bfst{$bfls[$_+$blih+1]} if(exists($bfst{$bfls[$_+$blih+1]}));
                                   say    $out8  $z;}
        }
      }
    }else{ # HB1MFcat:presumably just 48 even no modulo is ordering lower right corner double rot8d only when `sumb u` trying to append undescribeds;
      for (0 ..         $blih-1){  printf($out8 "$h%-6s",$bfls[$_        ]);print $out8 $bfst{$bfls[$_        ]} if(exists($bfst{$bfls[$_        ]}));
        if  (@bfls > $_+$blih  ){  printf($out8 "$h%-6s",$bfls[$_+$blih  ]);print $out8 $bfst{$bfls[$_+$blih  ]} if(exists($bfst{$bfls[$_+$blih  ]}));
                                   say    $out8  $z;}}
    }
  }else{
    for  (0 ..         $#bfls  ){ # setting dirn only seemz to work when not in widt mode so far
      if (-d "$ENV{'HOME'}/bin/$bfls[$_]"){my $dirn= sprintf("%-6s",$bfls[$_].'/');$dirn=~ s/(\/)/$f$1$d/g; # 4m@ && colr dir key
                                   printf($out8 "$d%s"  ,$dirn            );print $out8 $bfst{$bfls[$_        ]} if(exists($bfst{$bfls[$_        ]}));
      }else{
                                   printf($out8 "$h%-6s",$bfls[$_        ]);print $out8 $bfst{$bfls[$_        ]} if(exists($bfst{$bfls[$_        ]}));
      }
                                   say    $out8  $z;}}
  if($sunf){                       print  $out8  $z,join(' ',reverse(@ufls));} # Show UNdescribed File LiSt at end (mAB reorg into 2nd bkgr desc sumb page?)
  close   $out8             or die "Can't close duplic8 STDOUT handle: $!";}
our %f8fm=( # defining default F8F0ntMap top64 with unique b64 keys && favorites mapping to first letter of names, others map to any letter of name
            #   or are arranged otherwise logically like BinC are ._, foreign cyrillic, greek, hebrew, && thai are all uppercase of their first letters
            #   bigserif and sanserif are Xx, roman-1 is 1, futura-2 is 2, lat4 are 34, gr.f16 is 6, etc.; '.' was temporarily 'dmn8' to test dominoez f0nt;
            # apparently original wierd (deliber8 misspelling?) was weird but weird.f0nt mainly had high-bit Hebrew so rename swapped vowels;
  # maybe eventually these should all attempt to load from .Hrc with lodH as a8->new but these can be fallback defaults in case no .Hrc can be found;
  '0' => 'standrd0', '8' => 'tallg88d', 'G' => 'Greek'   , 'O' => 'crOstall', 'W' => 'backWard', 'e' => 'eMPTY'   , 'm' => 'mED'     , 'u' => 'COMPuTER', 
  '1' => 'roman-1' , '9' => 'france9' , 'H' => 'Hebrew'  , 'P' => 'suPer'   , 'X' => 'bigXerif', 'f' => 'fAT'     , 'n' => 'nICEFnT' , 'v' => 'MEDIEvAL', 
  '2' => 'futura-2', 'A' => 'Alt-8x16', 'I' => 'Inverted', 'Q' => 'teQton'  , 'Y' => 'stretchY', 'g' => 'gRFIXED' , 'o' => 'FRESNo'  , 'w' => 'wEIRD'   , 
  '3' => 'lat4-163', 'B' => 'Bold'    , 'J' => 'scottJ'  , 'R' => 'ReveRse' , 'Z' => 'ZanZurf' , 'h' => 'hEARST'  , 'p' => 'SLOppY'  , 'x' => 'xANxERIF', 
  '4' => 'lat4-16+', 'C' => 'CyrilliC', 'K' => 'blocK'   , 'S' => 'Surreal' , 'a' => 'FUTURa-1', 'i' => 'iTALiCS' , 'q' => 'ANTIqUE' , 'y' => 'HyLAS'   , 
  '5' => 'finnish5', 'D' => 'moDern-1', 'L' => 'Lcd'     , 'T' => 'Thai'    , 'b' => 'bROADWAY', 'j' => 'CRAKRjAK', 'r' => 'rOMAN3'  , 'z' => 'zWIzz-1' , 
  '6' => 'gr.f16'  , 'E' => 'EurotypE', 'M' => 'Modern-2', 'U' => 'coUrier' , 'c' => 'cALLIGRA', 'k' => 'kIDS-1'  , 's' => 'sCRIPT'  , '.' => 'bnc.drop',#dmn8
  '7' => 'thin7'   , 'F' => 'Fraktur' , 'N' => 'Norway'  , 'V' => 'silVer'  , 'd' => 'dECO'    , 'l' => 'lEDFONT' , 't' => 'tEKtItE' , '_' => 'bnc_blok');
# above are new renamed filenames each containing at least 1 instance of their key character, below are original DOS && Unix filenames for historical reference
# '0' => 'standard', '8' => 'tallgood', 'G' => 'greek'   , 'O' => 'CrosTall', 'W' => 'backward', 'e' => 'empty'   , 'm' => 'med'     , 'u' => 'computer',
# '1' => 'roman-1' , '9' => 'france'  , 'H' => 'hebrew'  , 'P' => 'super'   , 'X' => 'bigserif', 'f' => 'fraktur' , 'n' => 'nicefnt' , 'v' => 'medieval',
# '2' => 'futura-2', 'A' => 'alt-8x16', 'I' => 'inverted', 'Q' => 'tekton'  , 'Y' => 'stretch' , 'g' => 'grfixed' , 'o' => 'fresno'  , 'w' => 'wierd'   ,
# '3' => 'lat4-16' , 'B' => 'bold'    , 'J' => 'scott'   , 'R' => 'reverse' , 'Z' => 'sansurf' , 'h' => 'hearst'  , 'p' => 'sloppy'  , 'x' => 'sanserif',
# '4' => 'lat4-16+', 'C' => 'cyrillic', 'K' => 'block'   , 'S' => 'surreal' , 'a' => 'futura-1', 'i' => 'italics' , 'q' => 'antique' , 'y' => 'hylas'   ,
# '5' => 'finnish' , 'D' => 'modern-1', 'L' => 'lcd'     , 'T' => 'thai'    , 'b' => 'broadway', 'j' => 'crakrjak', 'r' => 'roman3'  , 'z' => 'swiss-1' ,
# '6' => 'gr.f16'  , 'E' => 'eurotype', 'M' => 'modern-2', 'U' => 'courier' , 'c' => 'calligra', 'k' => 'kids-1'  , 's' => 'script'  , '.'=>'dmn8',#'BinCBlok',
# '7' => 'thin'    , 'F' => 'fat'     , 'N' => 'norway'  , 'V' => 'silver'  , 'd' => 'deco'    , 'l' => 'ledfont' , 't' => 'tektite' , '_' => 'BinCDrop',);
# above is b64 key order, below is value f0nt name in directory listing order by columns first for reference
# 'A' => 'alt-8x16', 'b' => 'broadway', 'e' => 'empty'   , '2' => 'futura-2', 'i' => 'italics' , 'D' => 'modern-1', 'Z' => 'sansurf' , 'S' => 'surreal' ,
# 'q' => 'antique' , 'c' => 'calligra', 'E' => 'eurotype', 'G' => 'greek'   , 'k' => 'kids-1'  , 'M' => 'modern-2', 'J' => 'scott'   , 'z' => 'swiss-1' ,
# 'W' => 'backward', 'u' => 'computer', 'F' => 'fat'     , '6' => 'gr.f16'  , '3' => 'lat4-16' , 'n' => 'nicefnt' , 's' => 'script'  , '8' => 'tallgood',
# 'X' => 'bigserif', 'U' => 'courier' , '5' => 'finnish' , 'g' => 'grfixed' , '4' => 'lat4-16+', 'N' => 'norway'  , 'V' => 'silver'  , 't' => 'tektite' ,
# '.' => 'BinCBlok', 'j' => 'crakrjak', 'f' => 'fraktur' , 'h' => 'hearst'  , 'L' => 'lcd'     , 'R' => 'reverse' , 'p' => 'sloppy'  , 'Q' => 'tekton'  ,
# '_' => 'BinCDrop', 'O' => 'CrosTall', '9' => 'france'  , 'H' => 'hebrew'  , 'l' => 'ledfont' , '1' => 'roman-1' , '0' => 'standard', 'T' => 'thai'    ,
# 'K' => 'block'   , 'C' => 'cyrillic', 'o' => 'fresno'  , 'y' => 'hylas'   , 'm' => 'med'     , 'r' => 'roman3'  , 'Y' => 'stretch' , '7' => 'thin'    ,
# 'B' => 'bold'    , 'd' => 'deco'    , 'a' => 'futura-1', 'I' => 'inverted', 'v' => 'medieval', 'x' => 'sanserif', 'P' => 'super'   , 'w' => 'wierd'   ,);
# F33LGRsv:switching out a=>archon for f=>futura-1 for new intent to support fraktur (still with archon non-letter maps) and reordered listing above;
our %f8pm=( # defining default F8Pal8Map (should eventually crE8 at least 64 pal8 files to key here for loading && usage in a c8 col8 layer for pal8 file)
  'B' => 'Bepspurp', 'c' => 'cORRI'   , 'd' => 'dARKZ'   , 'R' => 'deepRed' , 'g' => 'gOOFY'   , 'r' => 'r'       , 'f' => 'TIGSfAVS', 't' => 't'       ,
  'b' => 'bLUES'   , 'p' => 'DARKpRIM', 'D' => 'Decent'  , 'F' => 'Flipped' , 'n' => 'nICE'    , 's' => 'sILLY'   , 'T' => 'Tigzfavz', 'y' => 'yEL'     ,);
# above are new renamed filenames each containing at least 1 instance of their key character, below are original DOS && Unix filenames for historical reference
# 'B' => 'bepspurp', 'c' => 'corri'   , 'd' => 'darkz'   , 'R' => 'deepred' , 'g' => 'goofy'   , 'r' => 'r'       , 'f' => 'tigsfavs', 't' => 't'       ,
# 'b' => 'blues'   , 'p' => 'darkprim', 'D' => 'decent'  , 'F' => 'flipped' , 'n' => 'nice'    , 's' => 'silly'   , 'T' => 'TigzFavz', 'y' => 'yel'     , ;
#ur  $Hrcd; #  new  Hrc compound "rash" d8a structure object which is fundamentally a hierarchy of arrayz adorned with hashez between layerz && Xpansionz
#ub   lodH{}# LOaD .Hrc file as test on top (then automatically instead) of above exported d8a typez. this should become a rewrite of standalone lodH
  # plan:exact file contentz including commentz should be preserved in order to enable writing back out without any loss,
  #   parsing should warn about mismatchez between V8 keyz and the number of middle-mapz or expansionz,
  #   also warn if middle-map has redefinition without X multiXpansion flag, commaz should be optional,
  #   col8 layerz && multiXpansion flag should be detected as prefix or suffix, allow Ff: midlmap multi-c8lAyrkEyz2set bOth2gethr,
  #   handle explicit or autom8d Xpansion set naming, autOapply all midlmapz of c: to every l8r prEfix Usage,
  #   commaz in Bgn can autOsepR8 wider than 1-character V8 keyz (which will make joined context ambiguous when sub-keyz are also used),
  #   different typez of quoting && escaping delimiterz should be supported;
  # note:Space-based token parsing is not ideal but per-char is so tedious. Maybe in Hd8a have context, V8 key, hash of c8layerz describing whole set &&
  #   X0..Xn for Xpansionz with own hash keyz 'Xpnd' && c8layerz for any Xtra midlmapz (which should be copied to any following Xpansionz),
  #   then duplic8 any Xpansion with a label. Consider pushing all onto array structure too;
sub new{my($clas,$Hfil,$wrnf)=@_;$wrnf=0 unless(defined($wrnf)); # add WaRNingFlag
  my       $self=bless({},$clas); # default  .Hrc is in cwd ./ before checking HOME ~/ path
  unless(defined( $Hfil) && -r $Hfil){$Hfil='.Hrc';$Hfil="$ENV{'HOME'}/$Hfil" if(exists($ENV{'HOME'}) && !-r $Hfil);} # unspecified lOdzDfalt
  if    (defined( $Hfil) && -r $Hfil){open my $Hflh,'<',$Hfil or die "!*EROR*! Couldn't open  Hfil:$Hfil for reading! $!\n";binmode $Hflh,':encoding(UTF-8)';
    @{$self->{'Hfld'}}=<$Hflh>;       close   $Hflh           or die "!*EROR*! Couldn't close Hflh! $!\n"; # I ac2lywant2BAbl2custmcolrcomNtzcontNtz inoutput2
    my( $sst8,$cntx,    $ajvk,$ajmk,$c8pk,$c8sk,$xspl,$xssl); # SectnST8,CoNTeXt,ActiveJoined abbreV8ion&&Middlemap Keyz, c8 Prefix&&SuffixKeyz,XpandSet Labelz
    $sst8='B';$cntx='/';$ajvk=$ajmk=$c8pk=$c8sk=$xspl=$xssl='';my @ktnz;my $patn=''; # 2D KeyTokenNdxZ for switching to context && c8 prefix, PrevArowTokenNdx
    my $mcsf=0;   @{$self->{'Hftd'}}=(); # Middlemap C8 Suffix Flag && init empty HFileTokenD8a
    for my  $line(@{$self->{'Hfld'}}){   # loop HFileLineD8a && parse apart Tokenz
      while($line=~ s/^(.|\n)//){my $char=$1; # rEmMber that Dfalt /./ does not match \n
        if   ($char eq ';'){ # complete current XpndSet (do some valid8ion,load rash) then reinitialize valz for next Bgn section
          # l8r if $ajvk =~ /,/ split to get longer VKey namez
          for my $kndx(0..(length($ajvk)-1)){ # loop to load key d8a
            $self->{'Hd8a'}{$cntx}{substr($ajvk,$kndx,1)}{'c8lF'} = S(substr($ajmk,$kndx,1)) if(length($ajmk) > $kndx);}
          push(       @{$self->{'Hftd'}},['scln',  $char ]);$sst8='B';$cntx='/';$ajvk=$ajmk=$c8pk=$c8sk=$xspl=$xssl=$patn='';@ktnz=();$mcsf=0;}
        elsif($char eq '#'){
          push(       @{$self->{'Hftd'}},['cmnt',"#$line"]);last;} # skip the rest of parsing if comment until EndOfLine
        elsif($char =~ /^\s$/){if($line =~ s/^(\s+)//){$char.=$1;}
          push(       @{$self->{'Hftd'}},['spcz',  $char ]);} # any spacez can be ignored for now (&& l8r quoted spacez will be handled there)
        elsif($sst8 eq 'B'){ # handle char in Bgn section
          if   ($char eq '=' && $line =~ /^>/){$line =~ s/^>//;$sst8='m';@ktnz=();$patn=scalar(@{$self->{'Hftd'}});$mcsf=0; # upd8 section 2 mDL
            push(     @{$self->{'Hftd'}},['laro',  '=>'  ]);}  # assume LeftARrOw
          elsif($char eq ':'){for my $ktns(@ktnz){$self->{'Hftd'}[$ktns][0]='cntx';} # loop to s/ajvk/cntx/g
            push(     @{$self->{'Hftd'}},['coln',  $char ]);$cntx.=$ajvk;$ajvk='';} # shift keyz to context
          else{push(@ktnz,scalar(@{$self->{'Hftd'}})); # track KeyToken iNdiceZ in case they need to change to context l8r
            push(     @{$self->{'Hftd'}},['ajvk',  $char ]);$ajvk.=$char;}} # append key
        elsif($sst8 eq 'm'){ # handle char in mDL section (or could be eNd)
          if   ($char eq '=' && $line =~ /^>/){$line =~ s/^>//;$sst8='N';@ktnz=();$patn=scalar(@{$self->{'Hftd'}});$mcsf=0;
            $ajmk=$c8pk=$c8sk=''; # valid8 completed mDL map as same length of keyz && known c8 layerz B4 mAB cnv2eNd && resetting for new section
            push(     @{$self->{'Hftd'}},['raro',  '=>'  ]);}
          elsif($char eq ':'){if(length($ajvk) == length($ajmk)){$mcsf=1;}else{for my $ktns(@ktnz){$self->{'Hftd'}[$ktns][0]='c8pk';}}
            push(     @{$self->{'Hftd'}},['coln',  $char ]);}  # flag as switching to suffix or shift keyz to prefix
          elsif($mcsf){
            push(     @{$self->{'Hftd'}},['c8sk',  $char ]);$c8sk.=$char;}  # append to suffix
         #elsif(length($ajvk) > 2 && length($ajvk) == length($ajmk)){ # already same length keyz so don't append, cnv whole section to eNd
         #} # go back to $patn PrevArow && prepend all back to $line && rm from Hftd then switch $sst8='N' to reprocess
          else{push(@ktnz,scalar(@{$self->{'Hftd'}})); # track KeyToken iNdiceZ in case they need to change to prefix  l8r (or eNd Xpansion)
            push(     @{$self->{'Hftd'}},['ajmk',  $char ]);$ajmk.=$char;}} # append key
        elsif($sst8 eq 'N'){ # handle char in eNd section
          push(       @{$self->{'Hftd'}},['xpnd',  $char ]);}}} # append key
  }elsif($wrnf){say "!*Warn*! Default .Hrc file not found in current directory or user HOME && no path parameter given to a8->new()!";}
  return($self);}
sub a8colr {return(  a8c(@_));}
sub a8c    {my $self=shift;return unless(defined($self) && exists($self->{'Hftd'}));
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  for  my $tndx(0..$#{$self->{'Hftd'}}){
    print $out8 $W if($self->{'Hftd'}[$tndx][0] =~ /^(coma|coln|scln)$/);
    print $out8 $G if($self->{'Hftd'}[$tndx][0] eq 'cntx');
    print $out8 $Y if($self->{'Hftd'}[$tndx][0] eq 'ajvk');
    print $out8 $B if($self->{'Hftd'}[$tndx][0] eq 'laro');
    print $out8 $R if($self->{'Hftd'}[$tndx][0] eq 'raro');
    print $out8 $C if($self->{'Hftd'}[$tndx][0] eq 'cmnt');
    if               ($self->{'Hftd'}[$tndx][0] eq 'ajmk'){
      print $out8   S($self->{'Hftd'}[$tndx][1]) . $self->{'Hftd'}[$tndx][1];} # try to just color map keyz to start
    else{print $out8  $self->{'Hftd'}[$tndx][1];}}
  close       $out8         or die "Can't close duplic8 STDOUT handle: $!";}
# rs= 00          : RESET                   global dflt
# no= 00          : NORMAL                  NOrmal dflt
# fi= 00          : FILE                    normal FIle (altho idealy evrythng shud Bcome smthng distinct in contextz)
# di= 01;34       : DIR                     DIrectory                                           
# ln= 01;37       : LINK                    symbolic LiNk (if set to 'target' instead of colr;code;numz,color inherits that of file symlinked to)
# mh= 00          : MULTIHARDLINK           regular  file with more than one link   (used2b just "HARDLINK" with 44;37 but coreutils chngd aroun 9A6J8d7P)
# or= 05;01;01;46 : ORPHAN                  sym------link to nonexistent file
# mi= 05;01;01;41 : MISSING                   && the MISSING file it points to (blinkng alert?) #.ANSI.01.30  01;30 # bright blacK
# ex= 01;32       : EXEC                    file w/ EXECute permission                 (+x    ) #.ANSI.01.31  01;31 # bright Red
# su= 01;37;01;42 : SETUID                  file that is        SETUID                 (   u+s) #.ANSI.01.32  01;32 # bright Green
# sg= 00;30;00;43 : SETGID                  file that is        SETGID                 (   g+s) #.ANSI.01.33  01;33 # bright Yellow
# ca= 00;30;41    : CAPABILITY              file with capability?                               #.ANSI.01.34  01;34 # bright Blue
# st= 01;37;01;44 : STICKY                  dir  w/ STICKY bit  set && !other-writable (+t,o-w) #.ANSI.01.35  01;35 # bright Magenta (Purple)
# ow= 01;34;01;42 : OTHER_WRITABLE          dir  w/ sticky bit !set &&  OTHER-WRITABLE (   o+w) #.ANSI.01.36  01;36 # bright Cyan
# tw= 00;30;00;45 : STICKY_OTHER_WRITABLE   dir  w/ STICKY bit  set &&  OTHER-WRITABLE (+t,o+w) #.ANSI.01.37  01;37 # bright White     zsh:'%{' ANSI '%}'
# pi= 00;33;00;40 : FIFO                    pipe  (First-In,First-Out)               (orig bcam 40;33 with coreutils chng2 /etc/DIR_COLORS aroun 9A6J8d7P)
# so= 01;35       : SOCK                    SOCKet
# do= 01;35       : DOOR                    DOOR  (not sure why this was commented out before?) I'd gues this is POSIX||BSD-centric but !in Linux FylSys?
# bd= 01;33;01;40 : BLK                     BLocK     device driver
# cd= 01;33;01;40 : CHR                     CHaRacter device driver         #*.2du=01;33:*..#add0thRlsfyLtypz,symlnx..
sub lrc{ # G8SM73VD:lrc crE8d by PipStuart <Pip@CPAN.Org> to gener8 ~/.lsrc from .lrc as well as notify user of any upd8z from recent`dircolors -p`;
  my $srcf="$ENV{'HOME'}/.lrc" ;my $sxxc;my $sxxp;my $ckpf=1; # Section xx (c8 OverDraw) Color && Previous, ChecK dircolors -P Flag
                                                     $ckpf=0 if(@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /p/); # also accept paramz  for`dircolors -p`&&help tXt2
  my $dstf="$ENV{'HOME'}/.lsrc";($srcf,$dstf)=($dstf,$srcf)  if(@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /s/); #   && Swap default .lrc=>.lsrc for .lsrc=>.lrc
  my $cist= join('|',qw(RESET NORMAL FILE DIR LINK MULTIHARDLINK ORPHAN MISSING EXEC SETUID SETGID CAPABILITY STICKY OTHER_WRITABLE STICKY_OTHER_WRITABLE FIFO
    SOCK DOOR BLK CHR));my $cisr= qr/^($cist)\s/; # ColorInitStringTypez && regex to match them (need space after to get to STICKY_OTHER_WRITABLE)
  my $jlhl='# F1RLLK2K:~/.lrc  by PipStuart <Pip@CPAN.Org> as an altern8 format for .lsrc ideally having new ~/bin/lrc gNR8 either from the other;';
  my $lshl='# 819J2Pip:~/.lsrc by PipStuart <Pip@CPAN.Org> izAheavily modifId`dircolors`cfgfIl(Orig ~/.DIR_COLORS)wich setz $ENV{\'LS_COLORS\'} 4GNU' .
    '`ls --color`&&`lsd8`;'; # Just L && LS Header Linez abov shudBmain difrNcz on lInz 1&&5 wich don't lNd thMsLvz2auto-gNR8ion thru sprintf lIk rSt of d8a;
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  if(@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /h/){
    print $out8 # in case any Unicode added l8r
"  lrc - gener8 ~/.lsrc from ~/.lrc       Vers:$VERSION  d8VS:$d8VS
  Auth: $auth
   p  - do *not* check temporary dircolors -p output for recent upd8s
   r  - gener8 Random bright colors for every file type and extension
   s  - Swap order of gener8ion  (.lsrc=>.lrc *not* implemented yet!)
   h  - print this Help text and exit\n";return(0);}
  open my $srch,'<' ,$srcf  or die $!;binmode $srch,':encoding(UTF-8)';my @srcd=<$srch>;close $srch || die $!;my $ccod='';
  open my $dsth,'>' ,$dstf  or die $!;binmode $dsth,':encoding(UTF-8)';my $bpck='KROYGCBMPW';$bpck= join('','13579','A'..'Z','_'); # BrightPal8ColorKeyz
  for  my $srcl(0..$#srcd){ # might just need {2} below instead of trying to ref back to $1
    if(@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /s/){ # handle reversal of default behavior so ls is gener8ing l
      if   (      $srcl == 0){$srcd[$srcl]="$jlhl\n";}
      elsif(      $srcl == 4){$srcd[$srcl]="$lshl\n";} # used to [YOWKMCcgrRmP] below but better to allow any b64 future color sectionz
      elsif($srcd[$srcl]=~/^#([0-9A-Za-z._])\1$/){$sxxp=$sxxc if(defined($sxxc));$sxxc=$1;} # track encountered Section colorz to popul8 following d8a linez
      elsif($srcd[$srcl]=~/^\./){chomp($srcd[$srcl]);}} # 2du:wrap digitz&&semiz in SKpz then convert via c()
    else{ # default behavior so l is gener8ing ls
      if   (      $srcl == 0){$srcd[$srcl]="$lshl\n";}
      elsif(      $srcl == 4){$srcd[$srcl]="# This file was gNR8d by `lrc` Vers:$VERSION d8VS:$d8VS on d8:" . `d8` . ". Please edit ~/.lrc and run `lrc` " .
        "then `src` to see changes;\n";}
      elsif($srcd[$srcl]=~/^#([0-9A-Za-z._])\1$/){$sxxp=$sxxc if(defined($sxxc));$sxxc=$1;} # track encountered Section colorz to popul8 following d8a linez
      elsif($srcd[$srcl]=~/$cisr/){chomp $srcd[$srcl];$srcd[$srcl].=' 'x(44-length $srcd[$srcl]) if length $srcd[$srcl] < 44;$srcd[$srcl].="\n";my $styp=$1;
        if ($srcd[$srcl]=~/^$styp\s+(\S+)/){my $chnk=$1;$ccod=sS(S($chnk),'d'); # probably better to just lookup %mc2F instead of sS d on S
          if(@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /r/){$ccod=sS(S(substr($bpck,int(rand(length($bpck))),1)),'d');}
                               substr($srcd[$srcl],26,16,sprintf("%-16s",$ccod));}}
      elsif($srcd[$srcl]=~/^\./  ){chomp $srcd[$srcl];$srcd[$srcl].=' 'x(44-length $srcd[$srcl]) if length $srcd[$srcl] < 44;$srcd[$srcl].="\n";
        if  (                  substr($srcd[$srcl],30, 1)        eq ' '  && defined($sxxp) && $sxxc eq $sxxp            ){$ccod=sS(S($sxxc),'d'); }
        else{my $chnk='';$chnk=substr($srcd[$srcl],30,12);$chnk=~s/\s+//g;if(length($chnk) && $chnk=~ /^[:0-9A-Z._^]+$/i){$ccod=sS(S($chnk),'d');}}
        if  (@_ && $_[0]=~ /^[-sprh]+$/ && $_[0]=~ /r/){$ccod=sS(S(substr($bpck,int(rand(length($bpck))),1)),'d');}
                               substr($srcd[$srcl],26,16,sprintf("%-16s",$ccod));}}
    $srcd[$srcl]=~ s/\s+$/\n/;print $dsth $srcd[$srcl];} close $dsth || die $!;
  if($ckpf){ # default is to check if drc -p has been upd8d with new extension entries (but this doesn't yet match against TERM or file type lines)
    system('dircolors -p > /tmp/dc-p.lrc'); # these should all maybe use $ENV{'TMP'} ||TEMP||TMPPREFIX for which directory to write to (if any of them exist)
    if    (           -r  '/tmp/dc-p.lrc'){ # try just basic hashz2match respectiv NtrEz AgNst Blow
      open my $dcph,  '<','/tmp/dc-p.lrc' || die $!;binmode $dcph,':encoding(UTF-8)';my @dcpd=<$dcph>;close $dcph || die $!;my %sdee;my %ddee;
      unlink(             '/tmp/dc-p.lrc'); # tidy up /tmp
      for(0..$#srcd){if($srcd[$_]=~ /^(\.\S+)/){$sdee{$1}=1;}} # should just need flag for if extension was detected
      for(0..$#dcpd){if($dcpd[$_]=~ /^(\.\S+)/){$ddee{$1}=$dcpd[$_];chomp($ddee{$1});}}
      for(sort(keys(%ddee))){printf $out8 "%-16s sEmz2!Xist in .lrc d8a yet.\n",$ddee{$_} unless(exists($sdee{$_}));}}}
  close   $out8             or die "Can't close duplic8 STDOUT handle: $!";}
my %lsp8;my %lspt;
sub lodl{ # LOaD Ls_colors
  for(split(':',$ENV{'LS_COLORS'})){ my   ($g2re,$fx2e);
    if   (/^([^=]*[\*\+\?]+[^=]+)=(.+)$/){($g2re,$fx2e)=($1,"$SKp8$2m");$g2re=~s/([.])/\\$1/g;$g2re=~s/\?/./g;$g2re=~s/(\*|\+)/.$1/g;
      $lsp8{qr/^.*\s*$g2re$/}=$fx2e;}
    elsif(              /^([^=]+)=(.+)$/){($g2re,$fx2e)=($1,"$SKp8$2m");
      $lspt{         $g2re  }=$fx2e;}} # regex at bottom uses NOrmal at end but after `eval $(dircolors)` resets $LS_COLORS to defaults,'no' does!exist giving:
      $lspt{         'no'   }="${SKp8}00m" unless(exists($lspt{'no'}));} # "Use of uninitialized value in concatenation (.) or string..." so making sure exists
sub spcs{my($ssfn,$q)=@_; # subroutine handling SPeCial separ8or character Substitutions, those being Special Substs on FileNames && identified Qolor params
  if(       $ssfn=~/\s->\s.+\*$/                              ){$q=$lspt{'ex'};
            $ssfn=~s/^(.+?)(\s->\s)([^*]+)(\*)$/$lspt{'ln'}$1$Y$2$q$3$W$4/x; #         executable symlink handling
  }else{ if($ssfn=~/\s->\s(\e\[([\d;]*)m)*(.+)$/){my $ltfn=$3;$ltfn=~s/(\e\[([\d;]*)m)+//g; # srch below 4 subdir arg which should replace '.'
           if(!-e "$ltfn")                                     {$q=$lspt{'mi'};$ltfn=~s/(\[)/\\$1/g; # try escaping brackets to not become char class?
            $ssfn=~s/^(.*)($ltfn)              /$1$q$2/x;}}                  # end broken         symlink handling
            $ssfn=~s/^(.+?)(\s->\s)            /$lspt{'ln'}$1$O$2$q/x;       # end non-executable symlink handling
  }         $ssfn=~s/(\.+)                     /$W$1$q/xg   if($q ne $W);
            $ssfn=~s/(\.+)                     /$C$1$q/xg   if($q eq $W);
            $ssfn=~s/(-+)([^>])                /$Y$1$q$2/xg if($q ne $Y);
            $ssfn=~s/(-+)([^>])                /$W$1$q$2/xg if($q eq $Y);
            $ssfn=~s/(_+)                      /$C$1$q/xg   if($q ne $C);
            $ssfn=~s/(_+)                      /$G$1$q/xg   if($q eq $C);
            $ssfn=~s/(\++)                     /$R$1$q/xg   if($q ne $R);
            $ssfn=~s/(\++)                     /$B$1$q/xg   if($q eq $R);
  return   ($ssfn);} # 2du:fix c8fn UTF8 decoding to try to only do where needed like lsd8,sync all highlightz,
sub c8fn{  my $fnam;my $aflg=0;$aflg=1 if(@_);my $zflg=0;if($aflg && $_[0] =~ /^-*z$/){$zflg=1; shift(@_);$aflg=0 unless(@_);}my $sflg=0;my $rtxt='';
  open my $sin8,'<&','STDIN'  or die "Can't open  duplic8 STDIN  handle: $!";binmode $sin8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  lodl() unless(%lsp8 && %lspt); # make sure global LS_COLORS d8a regexes are loaded
  if(!$aflg && !-t $sin8){     $sflg=1;   @_=<$sin8>;} # BlO renamed $k $kolumn_x to $n for Named color && String 2!colide with
  while($fnam=decode('UTF-8',shift(@_))){ # fix pIping for GT:ls|c8fn to work on multi-line && -w 160 to go proper wide
    if(defined($fnam) && length($fnam)){#chomp($fnam);
      my $tnam=$fnam;my($n,$s); # process filename colr  # single-letter variables holding primary escaped colors
  #   if($subd eq '.'&& @ARGV){my $andx=0;while(!-d "$ARGV[$andx]"&& $andx<$#ARGV){$andx++;}if(-d "$ARGV[$andx]"){$subd="$ARGV[$andx]";$subd=~s/\/+$//;}}
  #   above was for when ls output enabled tracking the traversed subdirectory, but such context is likely to remain unknowable from here within c8fn()
      if($tnam=~  /-([-0-9A-Z_]{11})-([0-9A-Z._]{6})-(NA_|[0-9A-Z._][1-9A-C][1-9A-V])\./i){my $epch=b8colr($2);my $uld8=d8colr($3);d8cs('U2b8');
         $uld8="$M$3" if($3 eq 'NA_');                                                     my $idnt=b8colr($1);                    d8cs();
        # above override default d8 colr8ion when uldt was Not Available  # this hIlIting is specifically for U2b8 -> U2b4 name resultz
        # might want to try to strip out idnt && epch so l8r spcs won't recolr their /[-._]/, then after add back before uldt.xtn
         $tnam=~ s/-([-0-9A-Z_]{11})-([0-9A-Z._]{6})-(NA_|[0-9A-Z._][1-9A-C][1-9A-V])\./-$idnt-$epch-$uld8./i; # l8r colr uldr && mAB Artist columz sepR8ly2
        # since most of my typical audio filez are colrd $Y by .ls?rc && vidz are $P, subfield colrz here mostly avoid those unless they're mainly in the othr
         $tnam=~ s/(^|\D)([12]\d{3})(\D)/$1$R$2$3/g;} # basic detection of potential Year from previous or this millennium, wrapped by non-digitz (2du:@Monz)
      for  my $svgl(keys(%lspt)){                      $n=$lspt{$svgl};my($bgin,$fsnm);                      #Typz
        if   ($svgl eq'ex'&& (($bgin,$fsnm)= $fnam=~/^(.*?)(.+?)\*+  $/x)&& -x "$fsnm"){
              $tnam=~s/^($bgin)($fsnm)(\*+)   $/$1$n$2$W$3/x;               $tnam=spcs(   $tnam ,$n);     }    # escape special /lost+found/ globs below
        elsif($svgl eq'di'&& (($bgin,$fsnm)= $fnam=~/^(.*?)(.+?)\/+  $/x)             ){  $fsnm =~ s/\+/\\+/g; # allow ending slash to design8 dirz even if!-d
              $tnam=~s/^($bgin)($fsnm)(\/+)   $/$1$n$2$Y$3/x;               $tnam=spcs(   $tnam ,$n);     }  # !sure how2mk paths up to files color dirs right
        elsif($svgl eq'di'&&                 $fnam=~/^          \/+  $/x && -d "$fnam"){                     # testing solo root / Red, might want solo ~
              $tnam=~s/^              (\/+)   $/$R$1/x;                     $tnam=spcs(   $tnam ,$n);     }  #   or  always root / or home ~
        elsif($svgl eq'ln'&& (($bgin,$fsnm)= $fnam=~/^(.+?)\s->\s(.+)$/x)&& -l "$bgin"){my $fanm=$fsnm;
          for my $shgl(sort keys(%lsp8)){if($fsnm=~/$shgl/){$s=$lsp8{$shgl};$fanm=spcs("$s$fsnm",$s);last;}} # color symlink's target by extension
              $tnam=~s/^($bgin)(\s->\s)($fsnm)$/$W$1$Y$2$g$fanm/x;          $tnam=spcs(   $tnam ,$n);     }}
      for     my $shgl(sort keys(%lsp8)){if($tnam=~/$shgl/){$n=$lsp8{$shgl};$tnam=spcs("$n$tnam",$n);last;}} #Gl0b
      # matching against both names below to hopefully avoid splitting escapes as though they were valid PT or d8 characters (&& can't s/// d8 1st without $n)
      # setup matching PT range below to be somewhat tightly constrained to just the most expected values && trying to detect dash already with escape prefix
      if($tnam=~/^.*-(\e\[([\d;]*)m)*([0-9A-D][1-9A-C][1-9A-V][0-9A-Za-x]{4})                (\e\[([\d;]*)m)*([-.*\/]|$)/x){my $ptvr=$3;#y $ptim=undef; # oldPT
        if($fnam=~/-$ptvr([-.*\/]|$)/){#ptim=    Time::PT->new($ptvr);my $stim=$ptim->color('ansi');$stim.=$M.'0' if($ptvr=~/0$/);
          my @ptfl= split(//,$ptvr);my $stim="$R$ptfl[0]$O$ptfl[1]$Y$ptfl[2]$G$ptfl[3]$C$ptfl[4]$B$ptfl[5]$M$ptfl[6]";
          $tnam=~s/$ptvr/$stim/ if(length($stim)==(length($ptvr)  *12  ));}}
   while($tnam=~/^.*-(\e\[([\d;]*)m)*([0-9A-Za-z._][1-9A-C][1-9A-V][0-9A-Za-g][0-9A-Za-x]{4})(\e\[([\d;]*)m)*([-.*\/]|$)/x){my $d8vr=$3;#y $dtim=undef; # newd8
        if($fnam=~/-$d8vr([-.*\/]|$)/){#dtim=Octology::d8->new($d8vr);my $etim=$dtim->color('a'   );#etim.=$P.'0' if($d8vr=~/0$/); # try2wrk around!using d8.pm
#         my @d8fl= split(//,$d8vr);my $etim="$R$d8fl[0]$O$d8fl[1]$Y$d8fl[2]$G$d8fl[3]$C$d8fl[4]$B$d8fl[5]$M$d8fl[6]$P$d8fl[7]"  ; # but rEmMbrUcan use d8colr
          my $etim=d8colr($d8vr);                                                                                                      $tnam=~s/$d8vr/$etim/;}}
      $tnam  =~s/   -                (n)(o)(w)                                                  ([-.*\/]|$)/-$M$1$M$2$M$3$4/x;     # Dtect now dif from YMD BlO
   while($tnam=~/^.*-(\e\[([\d;]*)m)*([0-9A-Za-z._])([0-9A-Za-q])([0-9A-Za-z._])(\e\[([\d;]*)m)*([-.*\/]|$)/x){my($d8vY,$d8vM,$d8vD)=($3,$4,$5);  # && -YMD- d8
          my $etim="$R$d8vY$O$d8vM$Y$d8vD";if($d8vY ne 'n' || $d8vM ne 'o' || $d8vD ne 'w'){                                 $tnam=~s/$d8vY$d8vM$d8vD/$etim/;}}
      if($tnam=~/^.*-(\e\[([\d;]*)m)*(((19|20)\d\d)([01]\d)([0123]\d))          (\e\[([\d;]*)m)*([-.*\/]|$)/x){my($dYMD,$dY,$dM,$dD)=($3,$4,$6,$7);
        if($fnam=~/-$dYMD([-.*\/]|$)/){                               my $etim="$R$dY$O$dM$Y$dD";                                                 # && YYYYMMDD
          $tnam=~s/$dYMD/$etim/ if(length($etim)==((length($dYMD)+3)*12));}} $lspt{'di'}=$B unless(exists($lspt{'di'}));
      $tnam    =~s/^\/home\/$ENV{'USER'}/$lspt{'di'}~/ if($zflg); # replace absolute path with rel8ive home in regular dir colr (only4Zsh prmpt,but bash ndz2!)
      #f($tnam =~s/(\/)([-0-9A-Z._~+]+)/$Y$1$B$2/gi){$tnam=~s/([-0-9A-Z._~+]+)(\/)/$1$Y$2/i;} # F1FLAAER:atMpt2mk c8fn colrnAmd pathdirz&&sepR8orz(l8rUz'di')
      #  $tnam =~s/([-0-9A-Z._~+]+)(\/)/$lspt{'di'}$1$Y$2/gi;                                 # F26LB0Ib:atMpt2mk c8fn colrnAmd pathz&&sepR8orz(l8rUzHrc:s 4Y)
      if($tnam =~s/(\/)([-0-9A-Z._~+]+)/$Y$1$lspt{'di'}$2/gi){$tnam=~s/([-0-9A-Z._~+]+)(\/)/$1$Y$2/i;} # maybe replace all of these if just $tnam =~ /\//
      $fnam=~ s/^.*$/$g$tnam$lspt{'no'}/; # abov fix just / $Y,don't $B ovrId stRt of fIlnAm@Nd,alow stRting rel8ive non-absolute dirname,NAbl zshcolrz4prmpt
      if($aflg){                 $rtxt .="$fnam ";} # substitute colorz && reset 2 NOrmal then append return text && strip spacez at end
      else     {$fnam =~ s/\n$//;$rtxt .= $fnam  ;}}} $rtxt =~ s/\s$//                    if($aflg);my $lpno=$lspt{'no'};$lpno=~ s/(\[)/\\$1/g;
                                                      $rtxt =~ s/\n($lpno)$/$1/           if($sflg); # maybe need additional escapez in lpno above?
                                            if($zflg){$rtxt =~ s/(\e\[([\d;]+)           [A-MPSTXZm])/%{$1%}/gx; # zflg should wrap all common SKpz
                                                      $rtxt =~ s/(\e\]50;[^\a\e]*          (\a|\e\\))/%{$1%}/gx;
                                                      $rtxt =~ s/(\e\]4;\d+;#[0-9A-Fa-f]{6}(\a|\e\\))/%{$1%}/g;}
  close $sin8 or die "Can't close duplic8 STDIN  handle: $!";return($rtxt);} # should probably enable c8fn to loop on multiple parameters to process together?
sub chti{ my $ptxt=shift;my $whti=0;my $ttxt;my %wlut=('b'=>0,'i'=>1,'w'=>2); # CHangeTItle;  ParameterTeXT, WHichTItle, TitleTeXT, WhichLookUpTable;
  if(defined($ptxt) && $ptxt=~ /^-+h(elp)?$/){say " chti  - CHange TItle of terminal window       Vers:$VERSION  d8VS:$d8VS by Auth:$auth
  Usage: chti <NewTitleText> [TargetOption]     (this utility should generally be equivalent to calling 'wmctrl -r :ACTIVE: -T NewTitleText')
  Changes the current title to NewTitleText. If all title text parameters are followed by a single TargetOption, they are handled as:
    -i  changes title  of just Icon
    -w  changes title  of just          Window
    -b  changes titles of Both icon and window (default)
    -h  display this Help text and exit
  If NewTitleText is any of the following shortcuts, they are expanded:
     2 => 2du
     8 => 8xt
     i => irc     Note: If zsh alias ct is used to call chti, for some reason the shell may also expand these shortcut parameters as aliases info or irssi.
     s => sys     Note: The below uppercase versions get prepended with 'Pips' and appended with 'GnomTerm' to resemble preferred terminal Profile names.
     c => ckm8   ,  C => Ckm8
     d => Default,  D => Dflt
     o => othr   ,  O => Othr
     t => tst    ,  T => Test
  If no parameters are given, the current working directory is used.";exit;} # 2du:tSt tRgetOptz wi multi-pRam UTF8 tItlz,accept option pRamz anywhere in @_,
  # accept '--' to stop looking4optionz, read NewTitleText from STDIN if no pRamz, upd8 hLptXt
  elsif(defined($ptxt) && $ptxt  =~ s/^-+([biw])$/$1/){$whti=$wlut{ $ptxt };$ptxt=shift;} # accept  1st WHich pRam
  if   (@_             && $_[-1] =~ s/^-+([biw])$/$1/){$whti=$wlut{pop(@_)};            } # accept last WHich pRam
  my %tlut=('2'=>'2du','8'=>'8xt','i'=>'irc','s'=>'sys','c'=>'ckm8','d'=>'Default','o'=>'othr','t'=>'tst','C'=>'Ckm8','D'=>'Dflt','O'=>'Othr','T'=>'Test');
  if(defined($ptxt) && length($ptxt)){$ttxt=$ptxt;if(@_){$ttxt.=' '.join(' ',@_);}}else{ # apNd rEmAining pRamz or else Dtermin good setngz4 nO pRam
    if   (exists($ENV{'COLUMNS'}) && $ENV{'COLUMNS'} eq  '80'){$ttxt='d';}  # Dtect Default prOfIl as Only standRd width
    elsif(exists($ENV{'PWD'})){$ttxt=$ENV{'PWD'};$ttxt=~ s|^/home/[^/]+/||;$ttxt=~ s|^([^/]+)/.*|$1| if($ttxt!~ /^dvl/);} # try2IsOl8just1st~/dir as nondvltItl
    if   (exists($ENV{'HOME'})    && $ENV{'HOME'   } eq $ttxt){$ttxt='o';}} # if Only in ~, assume othr
  if(exists($tlut{$ttxt})){if($ttxt =~ /\D/ && $ttxt eq uc($ttxt)){$ttxt="Pips$tlut{$ttxt}GnomTerm";} # this sub Only rEtrnz ch stringbutwil nEd2prnt2tAk Efect
                           else                                   {$ttxt=     $tlut{$ttxt}         ;}}else{$ttxt= decode('UTF-8',$ttxt);} # try2hndl wId charz
  $ttxt=~ s/\e\\//g;return("\e\]$whti;$ttxt\e\\");} # strip out any embedded early string-termin8or sequencez before returning any remaining title change code
sub curs{ # console cursor changing utility learned from HTTP://TLDP.Org (seems to only have effect in full-screen console TTYs)
  my   $csiz = shift || 0; my $ctms = shift || 0; my $csms = shift || 0; my $name='curs';
  if(  $csiz){ # 2du:ch IF to resemble pal8 colr spec
    if($csiz =~ /^-*h/i){ # help
      say " $name  - modify the console CURSor  Vers:$VERSION  d8VS:$d8VS by Auth:$auth
  Usage: $name <NewCursorValue1Shape> <NewValue2Toggle> <Value3Set>
  Change the console cursor by providing one to three decimal bytes for size, set-mask, and change-mask respectively. They could also be joined bitwise
    in reverse order and provided as a single b64 number. Negative sizes select pre-defined sets. *Note* Highlights are ignored for the last two flags.
  Add 16 to the size for a software cursor.
  Add 32 to the size to always change the background color.
  Add 64 to the size to allow different foregrounds and backgrounds.

  Examples:
    `$name      `  # default  blinking block
    `$name -1   `  #  normal  blinking underline
    `$name  2   `  #  normal  blinking underline
    `$name  8   `  #          blinking block
    `$name 17 64`  # red  non-blinking block

# The cursor appearance is controlled by a <ESC>[?1;2;3c escape sequence where 1, 2 and 3 are dec parmz described below. If you omit any of them, they dflt 0.
# 1 specifiez curs size (0=default, 1=invisible, 2=underline, ..., 8=full block)
#   + 16 if you want the software cursor to be applied
#   + 32 if you want to always change the background color
#   + 64 if you dislike having the background the same as the foreground. Highlights are ignored for the last two flags.
# 2 pickz char attrz to toggle (by XORing with value of param). standard VGA: high 4 bits specify bkgr and low 4 frgr. both: low 3 bits set colr (normal colr
#   codez used by console) and high bit turns on highlight (or sometimes blinking, depending on configur8ion of VGA).
# 3  is   char attrz to set. set goes before change, so you can clear a bit by including it in both set mask and toggle mask.
# Note: The built-in echo command in zsh might not support -e so $name may need to call /bin/echo explicitly to enable escape interpret8ion.";exit();
    }elsif($csiz =~ /[^-0-9]/ || $csiz > 128){ # 4 b64 chrz -> b10, mask out 3 bytes in reverse order
      $csiz = b10($csiz); $csms = ($csiz & (255 << 16)) >> 16; $csiz &= 65535; $ctms = ($csiz & (255 << 8)) >> 8; $csiz &= 255;}}
  if   ($csiz >   0){system("/bin/echo -n -e '\e[?$csiz;$ctms;$csms" . "c'");} # parmd
  elsif($csiz ==  0){system("/bin/echo -n -e '\e[?8c'                     ");} # BlinkBlock         # canned good settings
  elsif($csiz == -1){system("/bin/echo -n -e '\e[?2c'                     ");} # NormBlinkU
  elsif($csiz == -2){system("/bin/echo -n -e '\e[?17;0;64c'               ");} # RedNon-BlinkBlock
  elsif($csiz == -3){system("/bin/echo -n -e '\e[?17;14;224c'             ");} # YelNon-BlinkBlock  # \e[?12l may just disable blinking (re-enable with?)
} # with csiz:17 && varying csms                                         with csiz:17 && varying ctms
  #   0: norm blink u            16: drkblue?  bg, same fgz as above       0: green     fg normal blinking u                   16: drkblack? bg w/ green? fg
  #   1: invis but  cyan? fg     32: drkgreen  bg, same fgz                1: cyan      fg invis                               32: drkgreen  bg
  #   2: invis but green? fg     48: drkcyan   bg                          2: black     fg                                     48: drkcyan   bg
  #   3:            cyan?        64: drkred    bg                          3: blue      fg                                     64: drkred    bg
  #   4:           yellow        80: drkpurple bg                          4: yellow    fg                                     80: drkpurple bg
  #   5:            white        96: orange    bg                          5: white     fg                                     96: orange    bg
  #   6:           yellow       112: drkwhite  bg                          6: red       fg                                    112: drkcyan   bg
  #   7:            white       128: black     bg                          7: purple    fg                                    128: drkgreen  bg
  #   8:            green       144: blue      bg                          8: drkgreen  fg                                    144: blue      bg
  #   9:             cyan       160: green     bg                          9: drkcyan   fg                                    160: green     bg
  #  10:            green       178: cyan      bg                         10: totally invis, drkblack fg on drkblack bg       176: cyan      bg
  #  11:             cyan       192: red       bg                         11: drkblue   fg                                    192: red       bg
  #  12:           yellow       208: purple    bg                         12: orange    fg                                    208: purple    bg
  #  13:            white       224: yellow    bg                         13: drkwhite  fg                                    224: yellow    bg
  #  14:           yellow       240: white     bg                         14: drkred    fg                                    240: white     bg
  #  15:            white                                                 15: drkpurple fg
sub dm2u{my $flnm=shift||'h';my $rslt=shift||'u';my $oopt=shift||'';my $coun=1;my $snrf=''; 
  # 1CKJLhGo: dum2umd crE8d by PipStuart <Pip@CPAN.Org> to replace dtou.exe && utod.exe because they choke on ASCII 26 (Ctrl-Z == EOF in normal Win32
  #   i.e., without binmode). Old utils clobbered a bunch of my files =(... && I knew some simple Perl could quickly do a better job of it. =)
  # 23FKBREZ: added 's' parameter to turn all double newlines into Singles.  G81M6str:renamed as a8::dm2u to fit my ~/bin short-name trend.
  ($flnm,$rslt)=($rslt,$flnm) if(-e $rslt); # Usag: 1st param is file to convert. Optional 2nd param is 'd' or 'm' for Dos or Mac formatted EndOfLines.
  ($flnm,$oopt)=($oopt,$flnm) if(-e $oopt); #   Empty or 'u' 2nd param does default Unix format.
  if($rslt=~/^-*s$/i){$coun=2;$rslt=$oopt}  # Note: No intermediate file is used so you need enough RAM to store the whole file in a scalar.
  if($oopt=~/^-*s$/i){$coun=2            }  #   Expect problems if your file doesn't fit in RAM easily.
  if($flnm=~/^-*h(elp)?$/i||$rslt=~/^-*h(elp)?$/i){say " dm2u  - convert Dos and Mac newlines to Unix  Vers:$VERSION  d8VS:$d8VS by Auth:$auth
  Usage: dm2u [LineOptions] <FileName>
  Convert newlines to       different  formats: ASCII   HEX b16  dec b10   ocT b8    with LineOptions:
    -u    newlines in FileName to UNIX format  (   LF)   (  A)   (   10)   (   12)  LineFeed (default)
    -m    newlines in FileName to MAC  format  (CR   )   (D  )   (13   )   (15   )  CarriageReturn
    -d    newlines in FileName to DOS  format  (CR LF)   (D A)   (13 10)   (15 12)  CarigRetn LineFeed
    -s    squish double newlines in FileName to SINGLES
    -h    display this HELP text and exit           (this code is patterned after dtou.exe for MS-DOS)
  Note: No intermediate file or buffering is used by this code (yet), so you will need enough RAM to store the whole file in a Perl scalar.
    Expect problems if the input file does not fit into your system RAM easily. Such cases will require a more staged solution.";exit;}return unless(-e $flnm);
  open my $flih,'<',$flnm or die $!;binmode($flih);$snrf=join('',<$flih>   ) ;close $flih or die $!;
  if   (lc($rslt)=~/^-*d/i){$snrf=~s/(\015\012|\015|\012){$coun}/\015\012/g} # Dos             1512 CRLF
  elsif(lc($rslt)=~/^-*m/i){$snrf=~s/(\015\012|\015|\012){$coun}/\015/g    } # Mac             15   CR
  else                     {$snrf=~s/(\015\012|\015|\012){$coun}/\012/g    } # (Uni|GNU/Linu)x   12   LF
  open my $floh,'>',$flnm or die $!;binmode($floh);      print    $floh $snrf;close $floh or die $!;}
sub comma{my $strn=shift;my $comc=shift||',';my $blok=shift||3; # ECKLNcb3:`cma`cre,8d2,add,com,mas,2lo,ng#,str
  if(!defined($strn) && !-t STDIN){$strn.=$_ while(<STDIN>);}   #   HTTP://Perl.Com/doc/manual/html/pod/perlfaq5.html#How_can_I_output_my_numbers_with
  if(!defined($strn)){$strn='';} # set strn to empty string if not loaded from param or piping through
  my  @strz = split(/\n/,$strn); # H92MJ9gf:cma migr8d to b8.pm but leaving version here as comma for ftst && reso to use below;
  for(@strz){if(/^\s*[-+]?(\d+)/){my $word = $1; # Bl0Xmplfr0mPerlFAQ5Ab0v; Just:s/^(-?\d+)(\d{3})/$1,$2/g;
                                  my $cwrd =reverse $word;1 while $cwrd=~s/([^,\s]{$blok})([^,\s])/$1$comc$2/; # needs to reset each match or gets $blok+1
                                                          #cwrd=~s/([^,\s]{$blok})([^,\s])/$1$comc$2/g;
                                     $cwrd =reverse $cwrd;#cwrd=~s/^(\s*)$comc/$1/g;
                                     s/$word/$cwrd/;}}
  # HB1MAhmX:if this ever needs it? but b8:cma should accept something like -cCOLUMN_MASK like `df|cma -c1-3` which will delay && stretch all cols by max cmas;
      $strn =  join("\n",@strz);return($strn);} # orig!enuf cuz must insrt coma,then recalc pos&&from:
sub ftst{ # 37MK06SK:ftst Utl2run thruPerlzFileTeSTz on its parameter Filename
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  my $file=shift(@_)||$_||'-h';my $hlpf=0; # E89M7xUl:upd8d list below slightly to reflect: HTTP://JohnBokma.Com/perl/perl-quick-reference-card.pdf
  my @oper=('r','  readable by effective UID/GID  ','R','  Readable by     real  UID/GID  ',
            'w','  writable by effective UID/GID  ','W','  Writable by     real  UID/GID  ',
            'x','executable by effective UID/GID  ','X','eXecutable by     real  UID/GID  ',
            'o','owned      by effective UID/GID  ','O','Owned      by     real  UID/GID  ',
            'e','exists                           ','z','zero size                        ',
            'f','file                             ','s','size'                             ,
            'd','directory                        ','l','link                             ',
            'p','named pipe (FIFO)                ','S','Socket                           ',
            'b','block special file               ','c','character special file           ',
            't','tty                              ','u','setuid bit                       ',
            'k','sticky bit                       ','g','setgid bit                       ',
            'T','Text           (was MSWin only)  ','B','Binary         (opposite of -T)  ',
            'M','age (@stRtup) in Days since Modific8ion', # was 'M','age of file (at startup) in (fractional) days since Modification',
            'A','age (@stRtup) in Days since last Access',
            'C','age (@stRtup) in Days since inodeChange',);
  if($file =~  /^-?-?h(elp)?$/ && !-e $file){$hlpf=1;$file='';} $file="$ENV{'HOME'}/.Hrc" unless(length($file));
  if($hlpf){say $out8 " ftst  - loop through Perl dash-Flag File TeSTs on parameter Filename  Vers:$VERSION  d8VS:$d8VS by Auth:$auth
         Note that -T in Perl 5.24 is a heuristic guess whether it is an ASCII or UTF-8 Text file, which is useful beyond MicroSoft Windows environments;
   -h  - print this Help text; If no filename parameter is given, \$_ then the default Octology \$HOME/.Hrc d8a file is tested.
         Also prints Perl regex && string backslash eScape codes in one 160x48 page to keep similar reference together for now;";}
  for(my $i=0;$i<@oper;$i+=2){print  $out8 "$G($Y-" . S(uc($oper[$i])) . "$oper[$i] $file$G)$W==$G($C";my $etrv=0;
    if(0&& $oper[$i] =~ /[TB]/ && $^O !~ /^MSWin/){ # or $^O or $ENV{'OSTYPE'} used to test for what were MicroSoft only flags
                              print  $out8 "Can't test, except in MSWindows!";}
    else                     {$etrv=eval(    "(-" .                      "$oper[$i] \'$file\')"); $etrv=0 unless(defined($etrv) && $etrv);
                              print  $out8            $etrv  if($oper[$i] !~ /^[MACs]$/); # originally only checked if eval succeeded but did!retn actual value
                              print  $out8      comma($etrv) if($oper[$i] eq      's'  );
                              printf $out8 "%23.18f", $etrv  if($oper[$i] =~ /^[MAC]$/ ); # align age floats
                             }print  $out8 "$G)$W:$R$oper[$i+1]";print $out8 ' ' x  (34 - length(comma($etrv))) if($oper[$i] eq 's');
                              print  $out8 "\n" if(!exists($ENV{'COLUMNS'}) || $ENV{'COLUMNS'} <= 108 || $i % 4 || $i > ($#oper-8));}
  say $out8 S('A')," AquAmArine compact list of Perl backslash eScape codes for both regular-expressions and character-strings:
  \\000              escape                             Octal sequence.    \\o{};(See also)  # /!in\\[\\];\$/ mEnz!usable in bracket char class (like [\\dA-Z])
  \\1, \\2, ..past 9?        absolute (can \${d+} in s///) backreference.   !in[];  # Character Escapes - Fixed characters: 7 chars have a dedicated escape.
  \\a                Alarm                or                      bell         ;  #   Following table shows them with their ASCII code points (in dec && HEX),
  \\A                beginning            of                    string.   !in[];  #   their ASCII name, the control escape on ASCII platforms, and a short
  \\b                            word / non-word    Boundary.   Backspace  in[];  #   description. (4EBCDIC platforms, see OPERATOR DIFFERENCES in perlebcdic.)
  \\B                not a       word / non-word    Boundary.             !in[];  # Seq. CoDec PtHEX  ASCII  Cntrl  Description: \\cK is VerticalTab;CntrlOrdr:
  \\cX               Control-X                                                 ;  #  \\a     7    07    BEL    \\cG    Alarm or Bell;GHIJ Alrm,Bksp,Tab,Lnfeed,
  \\C                single    oCtet,   even     under UTF-8.  (deprec8ed)!in[];  #  \\b     8    08     BS    \\cH    BackSpace [1];KLM VTab,4mfeed,Carigretn;
  \\d                character class 4      Digits                             ;  #  \\e    27    1B    ESC    \\c[    Escape character;Ctrl-K toggles spell-
  \\D                character class 4  non-Digits                             ;  #  \\f    12    0C     FF    \\cL    Form Feed       ; checK in   ~/.vimrc ;
  \\e                Escape                      character                     ;  #  \\n    10    0A     LF    \\cJ    Line Feed [2];00 NUL Ctrl-@,01 SOH C-A,
  \\E                End mode: stop any \\Q, \\L, \\U, or \\F processing;     !in[];  #  \\r    13    0D     CR    \\cM    Carriage Return; 02 STX C-B,03 ETX C-C;
  \\f                Form feed                                                 ;  #  \\t     9    09 HT TAB    \\cI HrzTab (Indent);L8r colrize this reference;
  \\F                Foldcase                               until \\E.     !in[];  \\r                Return                      character                  ;
  \\g{}, \\g1         named, absolute,     or  relative   backreference.   !in[];  \\R                generic           newline.                        !in[];
  \\G                pos                      assertion.                  !in[];  \\s                character class 4                  whiteSpace          ;
  \\h                character class 4      Horizontal whitespace              ;  \\S                character class 4  non-            whiteSpace          ;
  \\H                character class 4  non-Horizontal whitespace              ;  \\t                Tab                         character                  ;
  \\k{}, \\k<>, \\k''  named                        bacKreference.          !in[];  \\u                titlecase (Uc) next         character.            !in[];
  \\K                Keep the stuff left  of                      \\K.     !in[];  \\U                Uppercase                              until \\E.  !in[];
  \\l                Lowercase      next         character.               !in[];  \\v                character class 4         Vertical whitespace          ;
  \\L                Lowercase                              until \\E.     !in[];  \\V                character class 4  non-   Vertical whitespace          ;
  \\n                (Logical)         Newline   character                     ;  \\w                character class 4      Word characters                 ;
  \\N                Any character but Newline.                           !in[];  \\W                character class 4  non-Word characters                 ;
  \\N{}              Named or Numbered unicode   character or sequence         ;  \\x{}, \\x00        escape                       heXadecimal sequence      ;
  \\o{}              escape                             Octal sequence         ;  \\X                unicode  'eXtended grapheme cluster'.             !in[];
  \\p{}, \\pP         character w given unicode                Property         ;  \\z                end             of                         string.!in[];
  \\P{}, \\PP         character wogiven unicode                Property         ;  \\Z                end             of                         string.!in[];
  \\Q                Quote (disable) pattern metacharacters until \\E.     !in[];\\cA-D:01 StartOfHeading,02 StartofTeXt,03 breakEndofTXt,04 EndOfTransmission,
  \\cE 05 ENQuiry,\\cF 06 positiveACKnowlegment,\\cN 0E ShiftOut,\\cO 0F ShiftIn(XON resume output),\\cP 10 DataLinkEscape HTTP://DC.Org/files/asciitable.pdf
  \\cQ-T DeviceControlcharacter1-4,\\cU 15 NegativeAcKnowledgement,\\cV 16 SYNchronousidle,\\cW 17 EndofTransBlock,\\cX 18 CANcel,\\cY 19 EndofMedium,
  \\cZ 1A SUBstitute/endoffile,\\c[ 1B ESCape,\\c\\ 1C FileSeparator,\\c] 1D GroupSeparator ,\\c^ 1E RecordSeparator,\\c_ 1F UnitSeparator,20 SPace!",
 "\"#\$%&'()*+,..."; # `pdoc perlvar` describes all the shortest variables && perlrun has runtime flags
  # functions that use $_ as a default argument: abs, alarm, chomp, chop, chr, chroot, cos, defined, eval, evalbytes, exp, fc, glob, hex, int, lc, lcfirst,
  #   length, log, lstat, mkdir, oct, ord, pos, print, printf, quotemeta, readlink, readpipe, ref, require, reverse (in scalar context only), rmdir, say, sin,
  #   split (for its second argument), sqrt, stat, study, uc, ucfirst, unlink, && unpack.  all solo file tests use $_ except for -t , which defaults to STDIN.
  # pattern matching oper8ions m//, s///, && tr/// (AKA y///) when used without an =~ oper8or.    default iter8or variable in for(each) loop if none supplied.
  # implicit iter8or variable in grep() and map() functions.  implicit variable of given().   the default place to put the next value or input record when a
  #   <FH> , readline, readdir, or each oper8ion's result is tSted by itself as the sole criterion of a while tSt. outside a while tSt, this will not happen;
  close   $out8             or die "Can't close duplic8 STDOUT handle: $!";} # should learn all the above functions && eventually print somehow as colrd rFrNc;
# favorite resoz:320x200,640x400(2x2),1280x800(4x4*320x200),1920x1200(6x6),2560x1600(8x8*320x200) then 1920x1080p of my AsusHDMI monitors&&SamsungGalXS4Phone;
sub reso{my $optz=join(' ',@_)||''; # 598KBvas:reso crE8d by PipStuart <Pip@CPAN.Org> 2rank display resolutions by totl pixlz&&aspect r8ioz.  # ^4x4=10240x6400
  my $whby=4; # 2du:add colrz&&optnz BsIdz matchz,mAB rm WdHt/\d columnz,stuD film resoz lIk supr-wId 2.89:1,PanasonicAnamorphic 2.4:1,etc&&add BlO;
  my @wdmz=(10240,8192,7680,6400,5120,4096,3840,3280,3200,3072,2960,2560,2456,2304,2220,2048,1920,1856,1800,1792,1680,1600,1480,1440,1400,1366,1280,1152,1024);
  my @hdmz=( 6400,4800,4320,4096,3072,2400,2304,2160,2048,1920,     1800,1600,1536,     1440,1392,1350,1344,1280,1200,1152,     1080,1024,1050, 960, 900, 864);
  push(@wdmz,960,854,            800,768,720,640,    512,        480,470,426,400,        320,240,        160,    120,80,40); # rvrs sortd pixl widthz2compUt on
  push(@hdmz,854,800,768,720,640,600,576,540,480,400,384,360,350,348,320,300,272,270,240,200,160,150,144,120,100, 75,50,25); # ""              heightz
  my @aspz=( 18.5/9  , 17/9  , 16/9  ,  5/3  ,  8/5  ,  3/2  ,  4/3  ,  5/4  );map{$_=sprintf("%-4.2f",$_)*1.0}@aspz;
  my @asps=("18.5/9w","17/9w","16/9w"," 5/3w"," 8/5w"," 3/2s"," 4/3s"," 5/4s");my %rslt=();
  my %prcz=('7680x4800'=>[ 'WHUXGA ',   1.00,85,'spec:Wide Hexa Ultra   XGA                            '], # 2du:XtNd all descz by 3 charz
            '7680x4320'=>[ '8K UHD ',64000.0,85,'spec:UltraHigh DefN 8K 4320p UHDTV2:Sharp    AKA:SHV  '], # SHV:SuperHighVision
            '6400x4800'=>[  'HUXGA ',   1.00,30,'spec:Wide HexadecatuplSXGA                            '],
            '6400x4096'=>[ 'WHSXGA ',   1.00,30,'spec:Wide HexadecatuplSXGA                            '],
            '5120x4096'=>[  'HSXGA ',   1.00,30,'spec:HexadecatupleSuperXGA                            '],
            '5120x3200'=>[  'WHXGA ',   1.00,30,'spec:Wide HexadecatupleXGA                            '],
            '4096x3072'=>[   'HXGA ',   1.00,30,'spec:HexadecatupleXtendedGraphicsArray                '],
            '4096x2160'=>[ '4K DCI ',32000.0,30,'spec:UltraHigh DefN 4K 2160p UHDTV1:LG                '],
            '3840x2400'=>[ 'WQUXGA ',   1.00,32,'spec:Wide Quad UltraXGA                               '],
            '3840x2160'=>[ '4K UHD ',3500.00,32,'spec:UltraHigh DefN 4K 2160p UHDTV1:Asus PQ321 10BPP  '], # IGZO LED bklt wiDisplayPort&&dual HDMI
            '3200x2400'=>[  'QUXGA ',   1.00,30,'spec:Quad Ultra     XGA                               '],
            '3280x2048'=>[ 'WQSXGA ',   1.00,30,'spec:Wide Quad SuperXGA:Barco Coronis Fusion 6MP DL   '],
            '3200x2048'=>[ 'WQSXGA ',   1.00,30,'spec:Wide Quad SuperXGA                               '],
            '3200x1800'=>[  'WQXGA+',   1.00,30,'spec:Wide Quad      XGA+  UbuLaptop:Dell XPS13 DvlEd  '], # with Intel KabyLake Corei5, 8GB RAM, 256GB SSD
            '2960x1440'=>[   'WQHD+', 720.00, 6,'spec:Wide Quad High Def+   :Samsung GalaxyS8 highest  '],
            '2560x2048'=>[  'QSXGA ',   1.00,30,'spec:Quad SuperXtendGA                                '],
            '2560x1600'=>[  'WQXGA ',1444.15,30,'spec:Wide Quad XtendGA             :Dell 3007WFP      '],
            '2560x1440'=>[    'QHD ',1449.00,13,'spec:Quad High Definition:AKA:WQHD :Fuji T904WideQHD  '],
            '2220x1080'=>[    'FHD+', 720.00, 6,'spec:Full High Definition+ :Samsung GalaxyS8 mid(Dflt)'],
            '2048x1536'=>[   'QXGA ',   1.00,21,'spec:Quad XtendGraphxA    Max4CRTanalog        24bpp  '],
            '2048x1152'=>[  'QWXGA ',   1.00,27,'spec:Quad Wide XtendGA     :Samsung 2342BWX 23inch LCD'],
            '2048x1080'=>[ '2K DCI ',   1.00,32,'spec:DLP CinemaTech2K 2048 DigitalFilmProjectnStndrd  '], # 48bpp at 24f/s
            '1920x1200'=>[  'WUXGA ', 679.15,24,'spec:Wide UltraXtendGA    Max4DVI  :Dell 2407WFP      '],
            '1920x1080'=>['HD 1080 ',   1.00,27,'spec:High Definition  1080p      AKA:FHD:FullHighDef  '], #  from WikiPDa Ntryz:CmputrDisplayStndrdSpecz
            '1680x1050'=>[  'WSXGA+', 339.15,20,'spec:Wide SuperXtndGA+             :Dell 2007WFP      '], #VidAdaptrHardwar:  MDA ,   CGA,  OGA ,   HGC,
            '1600x1200'=>[   'UXGA ', 359.20,20,'spec:UltraXtendGraphxA             :Dell 2007 FP      '], #    TGA ,  PGC ,   EGA ,  MCGA,  VGA ,  8514,
            '1600x900' =>[     'HD+',   1.00,15,'spec:High Definition + 900p                           '], #   SVGA , TIGA ,   XGA
            '1480x720' =>[     'HD+', 720.00, 6,'spec:High Definition +     :Samsung GalaxyS8 lowest   '], #DisplayResolutnz:QQVGA , HQVGA, QVGA ,  HVGA,
            '1440x900' =>[   'WXGA+', 189.99,19,'spec:Wide XtendGrafxA+ AKA:WSXGA :SCEPTRE X9WG-NagaV  '], #    VGA ,FWVGA ,  SVGA ,   XGA,  XGA+,  SXGA,
            '1400x1050'=>[   'SXGA+',   1.00,17,'spec:SuperXtendGrafxA+                                '], #   SXGA+, UXGA ,  QXGA , QSXGA,QUXGA ,  HXGA,
            '1280x1024'=>[   'SXGA ', 247.20,19,'spec:SuperXtendGraphxA             :Dell 1907 FP      '], #  HSXGA ,HUXGA
            '1280x800' =>[   'WXGA ',   1.00,15,'spec:Wide XtendGraphxA                                '], #WideScrnVariants:WQVGA ,  WVGA,WSVGA ,  WXGA,
            '1280x768' =>['5:3WXGA ',   1.00,14,'spec:5Wyd3XtendGraphxA                                '], #  WSXGA , WXGA+, WSXGA+, WUXGA,WQXGA ,WQSXGA,
            '1280x720' =>['HD  720 ',   1.00,23,'spec:High Definition 720p  also 1360x768 && 1366x768  '], # WQUXGA ,WHXGA ,WHSXGA ,WHUXGA
            '1152x864' =>[    'XGA+',   1.00,17,'spec:eXtendedGraphicsArrayPlus     also x870 && x900  '],
            '1024x768' =>[    'XGA ',   1.00,17,'spec:eXtendedGraphicsArray         also 8514 256colr  '],
            '1024x600' =>[  'WSVGA ',   1.00,10,'spec:Wide SuperVideoGA                                '],
            '1024x576' =>[  'WSVGA ',   1.00, 7,'spec:Wide SuperVideoGA                                '],
             '960x720' =>[ 'xlarge ',   1.00, 8,'spec: genrlIzd size: Android 4.3 eXtra large min res  '], # genrlIzd size deprec8d for sw<N>dp SmalstWidth
             '960x640' =>[   'DVGA ',   1.00, 4,'spec:Doubl-sizeVGA                                    '],
             '960x540' =>[    'qHD ',   1.00, 4,'spec:quarter of full 1080p HD                         '],
             '800x600' =>[   'SVGA ',   1.00,15,'spec:SuperVideoGraphxArray         orig 4bpp  16colr  '], # TIGA:TexasInstrumentsGraphixArchitecture competed
             '768x576' =>[    'PAL ',   1.00,19,'spec:PhaseAltrn8gLine?                                '],
             '854x480' =>[  'FWVGA ',   1.00,12,'spec:Full Wide VGA                                    '],
             '800x480' =>['5:3WVGA ',   1.00,12,'spec:5Wyd3VideoGraphxA                                '],
             '720x480' =>[   'NTSC ',   1.00,19,'spec:NatnlTelevStndrdCommittee                        '],
             '720x350' =>[    'MDA ',   1.00, 8,'spec:MonochromeDisplay(andPrinter)?Adapter   AKA:MDP  '], # OGA:OrchidGraphixAdapter also had 720x350
             '720x348' =>[    'HGC ',   1.00, 8,'spec:HerculesGraphixCard     1bpp  Aspectr8io 1:1.55  '], # height had to be multiple of 4 for tech reasonz
             '640x480' =>[    'VGA ',   1.00, 6,'spec:VideoGraphixArray:alsoAndroid 4.3 large min res  '], # Android API Level18; res also4 PGC:ProGraphixCtrlr
             '640x400' =>[   'QCGA ',   1.00, 6,'spec:QuadColorGraphixArray         :!rEl spec,mAd up  '], # most early Q speczR4 quarter but mAB this 1st Quad
             '640x360' =>[    'nHD ',   1.00,14,'spec:ninth   of full 1080p HD                         '],
             '640x350' =>[    'EGA ',   1.00, 8,'spec:EnhancedGraphixAdapter 16 colrz from 6-bit pal8  '],
             '480x320' =>[   'HVGA ',   1.00,14,'spec:Half-size VGA                                    '],
             '470x320' =>[ 'normal ',   1.00, 4,'spec: generalized size:    Android 4.3normal min res  '],
             '426x320' =>[  'small ',   1.00, 2,'spec: generalized size:    Android 4.3 small min res  '], # Nintendo 3DS screen is   400x240 WQVGA like below
             '400x240' =>[  'WQVGA ',   1.00, 4,'spec:Wide QuartVGA     with variantz up2 PSP 480x272  '], # TGA:TandyGraphxAdaptr also suportd CGA  16colr
             '320x240' =>[   'QVGA ',   1.00, 4,'spec:QuartGraphixArray                                '], # Plantronics Colorplus also suportd CGA dblcolrdpth
             '320x200' =>[    'CGA ',   1.00,13,'spec:ColorGraphixAdapter also had HiRes:640x200 mode  '], # Note:A==Adapter 4hRdware nstd of Array 4just resoz
             '240x160' =>[  'HQVGA ',   1.00, 4,'spec:Half QuartVGA                                    '], # MCGA:MultiColrGraphixArray suportd CGA 256colr&&
             '160x120' =>[  'QQVGA ',   1.00, 3,'spec:QuartQuartVGA                                    ']);#   640x480 monochrome @60Hz
  my %mskz=('2560x1350'=>    "17/9w", # masks out unreal resolutions found amidst possible widths && heights with a potentially valid aspect-r8io
            '1800x960' =>    "17/9w",
            '1600x854' =>    "17/9w",
            '1440x768' =>    "17/9w",
             '720x384' =>    "17/9w", # 17/9 1.8889 - 0.1111 =
             '512x272' =>    "17/9w", # 16/9 1.7778 - 0.1111 =
            '3840x2304'=>    " 5/3w", #  5/3 1.6667 - 0.0667 =
            '2560x1536'=>    " 5/3w", #  8/5 1.6    - 0.1    =
            '1800x1080'=>    " 5/3w", #  3/2 1.5    - 0.1667 =
            '1792x1080'=>    " 5/3w", #  4/3 1.3333 - 0.0833 =
            '1600x960' =>    " 5/3w", #  5/4 1.25 ... so MinimumAspectR8ioVari8ion btwn stndRdz is ~0.06
            '1440x864' =>    " 5/3w",
            '1440x854' =>    " 5/3w", # with the prolifer8ion of resolution dimensions && adding 18.5/9 aspect, probably can't easily detect only the actual
            '3072x2048'=>    " 3/2s", #   defined && maybe for purchase resolutions without autom8ing some Googling && parsing, or just let more be unreal?
            '2304x1536'=>    " 3/2s", # would also want to identify if any here masked have popped up as a product to promote them up to a priced description
            '1920x1280'=>    " 3/2s",
            '1800x1200'=>    " 3/2s",
            '1792x1200'=>    " 3/2s");
  for      my  $wdim (@wdmz){
    for    my  $hdim (@hdmz){ # belo: Widt X(times*multiply) Hite as Product(totlPixlz) && "WxH"Str; 2du:tune AspectScale belo2limit tolerance4resoz2accept
      for( my  $andx=0;$andx<@aspz;$andx++){my $wxhp = $wdim*$hdim;my $wxhs = $wdim . "x$hdim";next if(exists($mskz{$wxhs}));my $arat = $wdim*1.0 / $hdim;
        if(abs($arat-$aspz[$andx])<0.06){$rslt{$wxhp} .= sprintf("%10s%6sx%-4s%8s(%-04s[%-06s])%4d/%-3d", # had coma wich chngd2prnt&&!retn,nEd arat*1.0BlO?
                                         comma($wxhp),$wdim,$hdim,$asps[$andx],$aspz[$andx],substr(sprintf("%-8.6f",$arat),2,6),int($wdim/8),int($hdim/16));
                                         $rslt{$wxhp} .= sprintf("%7.1f%7.1f",$wdim/$whby,$hdim/$whby); # A1JLKRhc:nw ck4B64Nc0dng of6pxLz4txtChrz in2Wd vsHt
          if(exists($prcz{$wxhs})      ){$rslt{$wxhp} .= sprintf(" %8s%8.2f%8.2f%7.2f %3s  %s", # 2du:compact 8x16Chrz,Wd/,Ht/ columnz&&mAB pad 1st colmz betr
                    $prcz{$wxhs}[0],$prcz{$wxhs}[1],$prcz{$wxhs}[1]/($wxhp/1000000),$prcz{$wxhs}[1]/$prcz{$wxhs}[2],$prcz{$wxhs}[2],$prcz{$wxhs}[3]); }
                                         $rslt{$wxhp} .= "\n"; last;
        }#else{print "Fail: wdim:$wdim hdim:$hdim diff:" . ($wdim - ($hdim * $aspz[$andx])) . "\n";}
      }}}      print "TotlPixelz Resolution  AspectRatio[actual] 8x16Chrz   Wd/$whby   Ht/$whby Standard   Price    \$/MiPx \$/In Inch Name\n";
  for(reverse(sort { $a <=> $b } keys(%rslt))){ if(length($optz)){print $rslt{$_} if($rslt{$_} =~ /$optz/);} # should add some -help wi mAB Dflt'HD'&& optionz
                                                else             {print $rslt{$_}                         ;}}}
sub spff{my $frmt='%12.12f';if(@_ && $_[0]=~ /%/){$frmt= shift(@_);} if(@_){return( sprintf("%16s",sprintf("$frmt",shift(@_))));}} # SPrintF float
sub spfd{my $frmt='%03d';if(@_ && $_[0]=~ /%/){$frmt= shift(@_);} if(@_ && $_[0]=~ /^\d+$/){return(sprintf("$frmt",shift(@_)) );}} # SPrintF dec
sub spfX{my $frmt='%02X';if(@_ && $_[0]=~ /%/){$frmt= shift(@_);} if(@_ && $_[0]=~ /^\d+$/){return(sprintf("$frmt",shift(@_)) );}} # SPrintF HX
sub cdst{ # Color DiSTance (derived from pm2x);pre-init what's necSary as new Xportz,but thN try2only load up nEded structurez that wil really B used in here
  my $nonr=0;my $frmf=0;my $hexf=0;my $nocf=0;my $nodf=0;my $snrf=0;my $xhri=0; # hndl flgz lIk specify rsltz -sIz or -colors.txt name2add2 %crgb && %cbrt 1st
  while  (@_ && $_[0]=~ /^--?(\S+)$/){my $flag=$1;if($flag=~ /^h(elp)?$/i){return( # run through some basic directions on parameters && expected behavior
" cdst - ColorDiSTance d8a gener8or  d8VS:$d8VS  Auth:$auth;
        after any flags, pass in an integer parameter between 0..255 for just within x256 for now or use -X to give any 24-bit HEXadecimal rgb code instead;
  -h  - print this Help text and return; should add ways to moder8 toward increasingly useful results; actually without -N \@snls resets indices to 0..255;
  -N  - NoNR  No iNdexes Reset (to leave for external management of limiting range to test against and removing new best selections);
  -n  - SNRF  Search Named Rgb  Flag (nstd of default 0..255 of x256, use Named d8a as a set to test which was gener8d from colors.txt && various rgb.txt);
  -d  - NoDF  No Distances      Flag (also applies to -f Disabling Default Distances from Full); Named colors can't be properly colored just in terminal;
  -f  - FRMF  Full Result Match Flag (which will include distance scores before closest matching colors that all shared that score);
  -x  - HexF  HEXadecimal       Flag; flags can be combined after single dash like -dfx ;
  -X  - XHRI  eXplicit HEX RGB Input (this is instead of default x256 index to test against); can also just give color name as next parameter;
  -c  - NoCF  No   Colors       Flag;");} $nonr=1 if($flag=~ /N/);$hexf=1 if($flag=~ /x/);$nocf=1 if($flag=~ /c/i);$frmf=1 if($flag=~ /f/i);
                                          $snrf=1 if($flag=~ /n/);$xhri=1 if($flag=~ /X/);$nodf=1 if($flag=~ /d/i); shift(@_);}
  my $ndx0=shift(@_);return("!*EROR*! Bad index for distance check!") if(!defined($ndx0));
  if($ucdf){my $s;@mrls=();@snls=(0..255) unless($nonr); # DfIn lIk old ccd2 CalQl8ClosestColrDistnc2() # nEd2!kEp pushng sames all over so ck ALRedyFlag
    if($snrf){ # also allow ndx0 to be a colr name nstd of just an x256 index, && mAB nstd of alwyz full nrgb put sorted key indicez in snls for l8r -N mngmNt
      for my $cnam (keys %nrgb){my $alrf=0;if(exists($cdrd{$ndx0})){for my $odst (keys %{$cdrd{$ndx0}}){if(exists($cdrn{$ndx0}{$odst}{$cnam})){$alrf=1;last;}}}
        unless($alrf){my $rdst= spff(distance($crgb{spfd($ndx0)},$crgb{$cnam}));push(@{$cdrd{$ndx0}{$rdst}},$cnam);$cdrn{$ndx0}{$rdst}{$cnam}=1;}}}
    else{ my $crkn;if($xhri){$ndx0=$nrgb{lc($ndx0)} if(exists($nrgb{lc($ndx0)})); # also convert just name to RGB
        if($ndx0=~ /^[0-9A-F]{6}$/){my($pred,$pgrn,$pblu)=(hex(substr($ndx0,0,2)),hex(substr($ndx0,2,2)),hex(substr($ndx0,4,2)));
          $cbrt{$ndx0}=                $pred+$pgrn+$pblu;$crgb{$ndx0}=[$pred,$pgrn,$pblu];$crkn=$ndx0;}} $crkn= spfd($ndx0) unless(defined($crkn));
      for my $sndx (@snls){my $alrf=0;if(exists($cdrd{$ndx0})){for my $odst (keys %{$cdrd{$ndx0}}){if(exists($cdrn{$ndx0}{$odst}{$sndx})){$alrf=1;last;}}}
        unless($alrf){my $rdst= spff(distance($crgb{$crkn},$crgb{spfd($sndx)}));push(@{$cdrd{$ndx0}{$rdst}},$sndx);$cdrn{$ndx0}{$rdst}{$sndx}=1;}}}
    my     @dsks= sort { $a <=> $b }   keys %{$cdrd{$ndx0}};
    for(0..$#dsks){push(@mrls,$dsks[$_]) unless($nodf);for my $wnon (@{$cdrd{$ndx0}{$dsks[$_]}}){ push(@mrls,$wnon);}}
    if(!$frmf){if($hexf){for(@mrls){$_ = spfX($_) unless(/\D/);}} return(@mrls);} # still allow hexified indices even if not -f Formatting Full
    for my $rndx (0..$#mrls){if($mrls[$rndx]=~ /^(\s*\d+\.\d+)$/){my $fltd= spff($mrls[$rndx]);
                                $mrls[$rndx]=~s/^(\s*\d+\.\d+)$/\n$z$fltd/;
                                $mrls[$rndx]=~s/^\n// unless($rndx);}elsif($mrls[$rndx]=~ /^(\d+)$/){my $frmd= spfd($mrls[$rndx]);
                $s= S('#' .spfX($mrls[$rndx]));                                                         $frmd= spfX($mrls[$rndx]) if($hexf);
                $s='' if($nocf);$mrls[$rndx]=~s/^.*$/$s$frmd/      ;}elsif($snrf && exists($nrgb{$mrls[$rndx]})){
   my $rrgb=$nrgb{$mrls[$rndx]};$mrls[$rndx] = "\e[38;2;".hex(substr($rrgb,0,2)).';'.hex(substr($rrgb,2,2)).';'.hex(substr($rrgb,4,2)).'m'.$mrls[$rndx];
                                }} return(@mrls);} # Xplicit b10 decimal 2;R;G;Bm abov insted of old %nr2x named RGB to closest of 256 hex map
  else{return("!*EROR*! No distance function available without needed module or custom altern8ive to be written.\n");} # but betr stil2real colr in 8trm or Tk
}
# 2du:add gener8or for tsgr bB pP l colr blox modez as well as ~/dvl/f8/colr/256colors2.pl style with scaling options to cover most of 80x24 && 160x48 &&
#   would be cool to be able to index the 6x6x6 color cube from any axes for custom gradients per-plane && maybe make a rampant redundant re-tiling format
#   where all similar adjacent edges can be reflected and re-axised around to maximize rel8ive recognition;
sub gnp8{my %p226= reverse(%p622);my %g8lm; # gener8 3 new 8pal8z based on various logic or priorities with Gener8LayrMap
  for my $andx (0..$#{$cmsp{'ANSI'}}){$p226{$andx}='b'.$cmsp{'ANSI'}[$andx];$g8lm{'b'}{$cmsp{'ANSI'}[$andx]}=$andx;} # load first 2pal8 into 256-to-64 mappings
  for my $p8ky (keys %p622){$g8lm{'b'}{$p8ky}=$p622{$p8ky};} # load extended 48 of 1st level 8pal8 from orig p622 map
  $g8lm{'d'}{'k'}= 16;$p226{ 16}='dk';$g8lm{'d'}{'r'}= 88;$p226{ 88}='dr';$g8lm{'d'}{'b'}=233;$p226{233}='db'; # pre-define new maps to start with && rm
  $g8lm{'a'}{'k'}=232;$p226{232}='ak';$g8lm{'a'}{'r'}=124;$p226{124}='ar';$g8lm{'a'}{'b'}=238;$p226{238}='ab';
  $g8lm{'l'}{'k'}=234;$p226{234}='lk';
  $g8lm{'l'}{'W'}=192;$p226{192}='lW';$g8lm{'a'}{'W'}=228;$p226{228}='aW';
  $g8lm{'l'}{'I'}=222;$p226{222}='lI';$g8lm{'a'}{'I'}=216;$p226{216}='aI';
  $g8lm{'l'}{'L'}=182;$p226{182}='lL';$g8lm{'a'}{'L'}=217;$p226{217}='aL';
  $g8lm{'l'}{'Q'}=158;$p226{158}='lQ';
  $g8lm{'d'}{'R'}=162;$p226{162}='dR'; # was  46 brit Green , took 162 from ap
  $g8lm{'a'}{'p'}= 61;$p226{ 61}='ap'; # was 162 brit MagRed, took  61 from ad
  $g8lm{'a'}{'d'}= 28;$p226{ 28}='ad'; # to dO
  $g8lm{'d'}{'O'}=130;$p226{130}='dO'; # to dp
  $g8lm{'d'}{'p'}=163;$p226{163}='dp'; # to a0
  $g8lm{'a'}{'0'}=137;$p226{137}='a0'; # to aD
  $g8lm{'a'}{'D'}=112;$p226{112}='aD'; # to lD
  $g8lm{'l'}{'D'}= 46;$p226{ 46}='lD'; # to dR back again to keep a rot8d loop
  $g8lm{'d'}{'E'}=109;$p226{109}='dE'; # to aa
  $g8lm{'a'}{'a'}= 76;$p226{ 76}='aa'; # to dE back again
  $g8lm{'a'}{'W'}=194;$p226{194}='aW'; # to aU && back
  $g8lm{'a'}{'U'}=228;$p226{228}='aU';
  $g8lm{'l'}{'W'}=193;$p226{193}='lW'; # to dU && back
  $g8lm{'d'}{'U'}=192;$p226{192}='dU';
  $g8lm{'d'}{'0'}= 63;$p226{ 63}='d0'; # 3-way loop
  $g8lm{'d'}{'_'}=152;$p226{152}='d_';
  $g8lm{'a'}{'A'}= 79;$p226{ 79}='aA'; # `pal8 d` sets 1st 2pal8 to Defaults, `src` calls pal8 for current TTY, `reset` restores GnomTerm 2pal8
  $g8lm{'b'}{'3'}=132;$p226{132}='b3'; # 2 swap
  $g8lm{'l'}{'.'}=131;$p226{131}='l.';
  $g8lm{'l'}{'A'}= 50;$p226{ 50}='lA'; # 2 swap
  $g8lm{'l'}{'Z'}=123;$p226{123}='lZ';
  $g8lm{'d'}{'P'}= 91;$p226{ 91}='dP'; # 4 rot8
  $g8lm{'a'}{'P'}= 90;$p226{ 90}='aP';
  $g8lm{'l'}{'P'}=134;$p226{134}='lP';
  $g8lm{'d'}{'N'}= 21;$p226{ 21}='dN';
  $g8lm{'b'}{'h'}=125;$p226{125}='bh'; # 6 rot8
  $g8lm{'d'}{'h'}=161;$p226{161}='dh';
  $g8lm{'a'}{'h'}=127;$p226{127}='ah';
  $g8lm{'l'}{'h'}=163;$p226{163}='lh';
  $g8lm{'d'}{'p'}= 53;$p226{ 53}='dp';
  $g8lm{'l'}{'r'}=126;$p226{126}='lr';
  $g8lm{'b'}{'A'}= 86;$p226{ 86}='bA'; # 2 swap
  $g8lm{'l'}{'T'}=122;$p226{122}='lT';
  $g8lm{'l'}{'A'}=121;$p226{121}='lA'; # 3 rot8
  $g8lm{'d'}{'A'}= 48;$p226{ 48}='dA';
  $g8lm{'d'}{'Z'}= 50;$p226{ 50}='dZ';
  $g8lm{'d'}{'F'}=168;$p226{168}='dF'; # 5 rot8
  $g8lm{'l'}{'O'}=208;$p226{208}='lO';
  $g8lm{'d'}{'u'}=100;$p226{100}='du';
  $g8lm{'a'}{'O'}=173;$p226{173}='aO';
  $g8lm{'l'}{'j'}=106;$p226{106}='lj';
  $g8lm{'a'}{'g'}= 34;$p226{ 34}='ag'; # 2 swap
  $g8lm{'l'}{'g'}= 40;$p226{ 40}='lg';
  $g8lm{'a'}{'X'}= 33;$p226{ 33}='aX'; # 2 swap
  $g8lm{'d'}{'l'}=177;$p226{177}='dl';
  $g8lm{'a'}{'c'}= 66;$p226{ 66}='ac'; # 10rot8
  $g8lm{'d'}{'X'}= 25;$p226{ 25}='dX';
  $g8lm{'a'}{'Q'}=183;$p226{183}='aQ';
  $g8lm{'l'}{'Z'}=159;$p226{159}='lZ';
  $g8lm{'a'}{'Z'}=123;$p226{123}='aZ';
  $g8lm{'a'}{'z'}= 39;$p226{ 39}='az';
  $g8lm{'d'}{'c'}= 38;$p226{ 38}='dc';
  $g8lm{'d'}{'x'}= 20;$p226{ 20}='dx';
  $g8lm{'d'}{'K'}=102;$p226{102}='dK';
  $g8lm{'l'}{'K'}=249;$p226{249}='lK';
  $g8lm{'d'}{'c'}= 66;$p226{ 66}='dc'; # 3 rot8
  $g8lm{'a'}{'c'}= 36;$p226{ 36}='ac';
  $g8lm{'l'}{'c'}= 38;$p226{ 38}='lc';
  $g8lm{'d'}{'0'}= 20;$p226{ 20}='d0'; # 4 rot8
  $g8lm{'d'}{'x'}=115;$p226{115}='dx';
  $g8lm{'l'}{'x'}=147;$p226{147}='lx';
  $g8lm{'l'}{'X'}= 63;$p226{ 63}='lX';
  $g8lm{'d'}{'9'}=186;$p226{186}='d9'; # 4 rot8
  $g8lm{'a'}{'9'}=153;$p226{153}='a9';
  $g8lm{'l'}{'9'}=195;$p226{195}='l9';
  $g8lm{'d'}{'I'}=211;$p226{211}='dI';
  $g8lm{'d'}{'5'}=186;$p226{186}='d5'; # 3
  $g8lm{'d'}{'7'}=155;$p226{155}='d7';
  $g8lm{'d'}{'9'}=157;$p226{157}='d9';
  $g8lm{'a'}{'i'}=106;$p226{106}='ai'; # 3
  $g8lm{'l'}{'i'}=108;$p226{108}='li';
  $g8lm{'l'}{'j'}=246;$p226{246}='lj';
  $g8lm{'d'}{'3'}=209;$p226{209}='d3'; # 5
  $g8lm{'l'}{'3'}=211;$p226{211}='l3';
  $g8lm{'d'}{'I'}=142;$p226{142}='dI';
  $g8lm{'a'}{'o'}=178;$p226{178}='ao';
  $g8lm{'l'}{'o'}=215;$p226{215}='lo';
  $g8lm{'d'}{'I'}=113;$p226{113}='dI'; # 2
  $g8lm{'a'}{'u'}=142;$p226{142}='au';
  $g8lm{'l'}{'Q'}=254;$p226{254}='lQ'; # 5
  $g8lm{'d'}{'Q'}= 49;$p226{ 49}='dQ';
  $g8lm{'l'}{'8'}=157;$p226{157}='l8';
  $g8lm{'d'}{'9'}=153;$p226{153}='d9';
  $g8lm{'a'}{'9'}=158;$p226{158}='a9';
  $g8lm{'d'}{'W'}=194;$p226{194}='dW'; # 3
  $g8lm{'a'}{'W'}=193;$p226{193}='aW';
  $g8lm{'l'}{'W'}=255;$p226{255}='lW';
  $g8lm{'a'}{'3'}=222;$p226{222}='a3'; # 5
  $g8lm{'d'}{'3'}=210;$p226{210}='d3';
  $g8lm{'a'}{'4'}=209;$p226{209}='a4';
  $g8lm{'d'}{'4'}=179;$p226{179}='d4';
  $g8lm{'a'}{'I'}=149;$p226{149}='aI';
  $g8lm{'a'}{'3'}=211;$p226{211}='a3'; # 2
  $g8lm{'l'}{'3'}=216;$p226{216}='l3';
  $g8lm{'l'}{'v'}=183;$p226{183}='lv'; # 4
  $g8lm{'a'}{'Q'}=151;$p226{151}='aQ';
  $g8lm{'a'}{'q'}=181;$p226{181}='aq';
  $g8lm{'d'}{'q'}=180;$p226{180}='dq';
  $g8lm{'d'}{'E'}= 72;$p226{ 72}='dE'; # 2
  $g8lm{'l'}{'E'}=109;$p226{109}='lE';
  $g8lm{'a'}{'A'}= 49;$p226{ 49}='aA'; # 2
  $g8lm{'d'}{'Q'}= 79;$p226{ 79}='dQ';
  $g8lm{'a'}{'5'}=221;$p226{221}='a5'; # 5
  $g8lm{'l'}{'5'}=222;$p226{222}='l5';
  $g8lm{'l'}{'I'}=154;$p226{154}='lI';
  $g8lm{'a'}{'y'}=185;$p226{185}='ay';
  $g8lm{'l'}{'y'}=191;$p226{191}='ly';
  $g8lm{'d'}{'Q'}= 85;$p226{ 85}='dQ'; # 2
  $g8lm{'a'}{'8'}= 79;$p226{ 79}='a8';
  $g8lm{'d'}{'t'}= 35;$p226{ 35}='dt'; # 3
  $g8lm{'a'}{'t'}= 32;$p226{ 32}='at';
  $g8lm{'l'}{'t'}= 37;$p226{ 37}='lt';
  $g8lm{'d'}{'Q'}= 79;$p226{ 79}='dQ'; # 4
  $g8lm{'a'}{'8'}= 75;$p226{ 75}='a8';
  $g8lm{'a'}{'T'}= 86;$p226{ 86}='aT';
  $g8lm{'b'}{'A'}= 85;$p226{ 85}='bA';
  $g8lm{'l'}{'a'}= 42;$p226{ 42}='la'; # 3
  $g8lm{'l'}{'z'}= 79;$p226{ 79}='lz';
  $g8lm{'d'}{'Q'}= 78;$p226{ 78}='dQ';
  $g8lm{'a'}{'z'}= 78;$p226{ 78}='az'; # 6
  $g8lm{'d'}{'8'}= 39;$p226{ 39}='d8';
  $g8lm{'a'}{'8'}=105;$p226{105}='a8';
  $g8lm{'l'}{'8'}= 75;$p226{ 75}='l8';
  $g8lm{'a'}{'Q'}=157;$p226{157}='aQ';
  $g8lm{'d'}{'Q'}=151;$p226{151}='dQ';
  $g8lm{'d'}{'x'}= 20;$p226{ 20}='dx'; # 4
  $g8lm{'d'}{'0'}=137;$p226{137}='d0';
  $g8lm{'a'}{'0'}=108;$p226{108}='a0';
  $g8lm{'l'}{'i'}=115;$p226{115}='li';
  $g8lm{'l'}{'d'}= 71;$p226{ 71}='ld'; # 2
  $g8lm{'d'}{'d'}=101;$p226{101}='dd';
  $g8lm{'d'}{'1'}= 93;$p226{ 93}='d1'; # 2
  $g8lm{'l'}{'p'}=171;$p226{171}='lp';
  $g8lm{'a'}{'x'}=135;$p226{135}='ax'; # 3
  $g8lm{'a'}{'v'}=140;$p226{140}='av';
  $g8lm{'l'}{'1'}=146;$p226{146}='l1';
  $g8lm{'d'}{'D'}= 46;$p226{ 46}='dD'; # 2
  $g8lm{'l'}{'D'}=118;$p226{118}='lD';
  $g8lm{'l'}{'i'}= 78;$p226{ 78}='li'; # 3
  $g8lm{'a'}{'z'}= 79;$p226{ 79}='az';
  $g8lm{'l'}{'z'}=115;$p226{115}='lz';
  $g8lm{'d'}{'L'}=182;$p226{182}='dL'; # 2
  $g8lm{'l'}{'L'}=189;$p226{189}='lL';
  $g8lm{'d'}{'_'}=248;$p226{248}='d_'; # 2
  $g8lm{'l'}{'_'}=152;$p226{152}='l_';
  $g8lm{'d'}{'W'}=193;$p226{193}='dW'; # 2
  $g8lm{'a'}{'W'}=194;$p226{194}='aW';
  $g8lm{'a'}{'w'}=251;$p226{251}='aw'; # 2
  $g8lm{'l'}{'w'}=252;$p226{252}='lw';
  $g8lm{'d'}{'8'}= 73;$p226{ 73}='d8'; # 6
  $g8lm{'a'}{'8'}= 39;$p226{ 39}='a8';
  $g8lm{'a'}{'x'}=105;$p226{105}='ax';
  $g8lm{'l'}{'l'}=135;$p226{135}='ll';
  $g8lm{'d'}{'.'}=131;$p226{131}='d.';
  $g8lm{'l'}{'.'}=104;$p226{104}='l.';
  $g8lm{'a'}{'q'}=150;$p226{150}='aq'; # 2
  $g8lm{'l'}{'q'}=181;$p226{181}='lq';
  $g8lm{'a'}{'7'}=120;$p226{120}='a7'; # 2
  $g8lm{'l'}{'7'}=156;$p226{156}='l7';
  $g8lm{'d'}{'a'}= 76;$p226{ 76}='da'; # 4
  $g8lm{'a'}{'a'}= 42;$p226{ 42}='aa';
  $g8lm{'l'}{'a'}= 78;$p226{ 78}='la';
  $g8lm{'l'}{'i'}=114;$p226{114}='li';
  $g8lm{'d'}{'O'}=136;$p226{136}='dO'; # 2
  $g8lm{'d'}{'o'}=130;$p226{130}='do';
  $g8lm{'a'}{'O'}=178;$p226{178}='aO'; # 2
  $g8lm{'a'}{'o'}=173;$p226{173}='ao';
  $g8lm{'l'}{'O'}=215;$p226{215}='lO'; # 2
  $g8lm{'l'}{'o'}=208;$p226{208}='lo';
  $g8lm{'d'}{'P'}= 90;$p226{ 90}='dP'; # 3
  $g8lm{'a'}{'P'}= 61;$p226{ 61}='aP';
  $g8lm{'a'}{'p'}= 91;$p226{ 91}='ap';
  $g8lm{'l'}{'P'}=171;$p226{171}='lP'; # 2
  $g8lm{'l'}{'p'}=134;$p226{134}='lp';
  $g8lm{'d'}{'f'}=166;$p226{166}='df'; # 10
  $g8lm{'l'}{'f'}=167;$p226{167}='lf';
  $g8lm{'a'}{'f'}=131;$p226{131}='af';
  $g8lm{'d'}{'y'}=179;$p226{179}='dy';
  $g8lm{'d'}{'.'}= 70;$p226{ 70}='d.';
  $g8lm{'d'}{'i'}=106;$p226{106}='di';
  $g8lm{'a'}{'i'}=113;$p226{113}='ai';
  $g8lm{'d'}{'I'}=148;$p226{148}='dI';
  $g8lm{'d'}{'4'}=173;$p226{173}='d4';
  $g8lm{'a'}{'o'}=202;$p226{202}='ao';
  $g8lm{'d'}{'.'}=138;$p226{138}='d.'; # 9
  $g8lm{'a'}{'.'}=180;$p226{180}='a.';
  $g8lm{'l'}{'.'}=181;$p226{181}='l.';
  $g8lm{'d'}{'q'}= 70;$p226{ 70}='dq';
  $g8lm{'l'}{'q'}=217;$p226{217}='lq';
  $g8lm{'a'}{'L'}=182;$p226{182}='aL';
  $g8lm{'d'}{'L'}=146;$p226{146}='dL';
  $g8lm{'l'}{'1'}=141;$p226{141}='l1';
  $g8lm{'a'}{'1'}=104;$p226{104}='a1';
  $g8lm{'d'}{'5'}=180;$p226{180}='d5'; # 8
  $g8lm{'l'}{'y'}=186;$p226{186}='ly';
  $g8lm{'l'}{'I'}=191;$p226{191}='lI';
  $g8lm{'a'}{'I'}=154;$p226{154}='aI';
  $g8lm{'a'}{'q'}=149;$p226{149}='aq';
  $g8lm{'l'}{'q'}=150;$p226{150}='lq';
  $g8lm{'l'}{'.'}=217;$p226{217}='l.';
  $g8lm{'a'}{'.'}=181;$p226{181}='a.';
  $g8lm{'a'}{'0'}=107;$p226{107}='a0'; # 2
  $g8lm{'a'}{'E'}=108;$p226{108}='aE';
  $g8lm{'d'}{'l'}=133;$p226{133}='dl'; # 3
  $g8lm{'a'}{'l'}=135;$p226{135}='al';
  $g8lm{'l'}{'l'}=177;$p226{177}='ll';
  $g8lm{'a'}{'b'}=236;$p226{236}='ab'; # 8
  $g8lm{'b'}{'d'}= 22;$p226{ 22}='bd';
  $g8lm{'b'}{'6'}= 28;$p226{ 28}='b6';
  $g8lm{'a'}{'d'}= 35;$p226{ 35}='ad';
  $g8lm{'d'}{'t'}= 55;$p226{ 55}='dt';
  $g8lm{'d'}{'s'}= 60;$p226{ 60}='ds';
  $g8lm{'b'}{'s'}= 54;$p226{ 54}='bs';
  $g8lm{'l'}{'b'}=238;$p226{238}='lb';
  $g8lm{'a'}{'h'}=163;$p226{163}='ah'; # 8
  $g8lm{'l'}{'h'}=198;$p226{198}='lh';
  $g8lm{'a'}{'F'}=203;$p226{203}='aF';
  $g8lm{'l'}{'F'}=210;$p226{210}='lF';
  $g8lm{'d'}{'3'}=200;$p226{200}='d3';
  $g8lm{'l'}{'m'}=129;$p226{129}='lm';
  $g8lm{'a'}{'m'}=128;$p226{128}='am';
  $g8lm{'d'}{'m'}=127;$p226{127}='dm';
  $g8lm{'d'}{'t'}= 25;$p226{ 25}='dt'; # 2
  $g8lm{'d'}{'X'}= 55;$p226{ 55}='dX';
  $g8lm{'l'}{'6'}= 84;$p226{ 84}='l6'; # 3
  $g8lm{'a'}{'6'}=119;$p226{119}='a6';
  $g8lm{'d'}{'6'}= 83;$p226{ 83}='d6';
  $g8lm{'b'}{'I'}=254;$p226{254}='bI'; # 2
  $g8lm{'l'}{'Q'}=231;$p226{231}='lQ';
  $g8lm{'a'}{'P'}= 97;$p226{ 97}='aP'; # 2
  $g8lm{'a'}{'s'}= 61;$p226{ 61}='as';
  @snls=(0..255);my $sloe=$#snls;for(0..$#snls){if(exists($p226{$snls[$sloe-$_]})){splice(@snls,$sloe-$_,1);}} # should chop out 48 Xtended after 1st 2pal8
  my $argz='';$argz= join(' ',@_) if(@_);
  # new LADlad Fb 8pal8 planes; consider needing to splice out of every earlier score's array && delete from hash if not easy to just track && skip over l8r;
  my @cdcr;my %cdwb;my $l=0; # ColrDistCallRslt, ColrDistWithBrit for post ndx0 l a d layrz;
  my $g8po='o  krOgcbPw KRYGCBMW  eh dtspi EHyDTSmI   .fuaznlj _FUAZNLJ  02468xvq 13579XVQ';$g8po=~ s/\s+//g; # each 2pal8 labeled qw(clen neon wash melo)
  for my $p8ky (split(//,$g8po)){ # need2test if key not in p622 to properly index base 2pal8 into Xtended 0..15 or just make whole new unified colr system
    my $pndx;if(exists($p622{$p8ky})){$pndx=$p622{$p8ky};}else{for my $andx (0..$#{$cmsp{'ANSI'}}){if($p8ky eq $cmsp{'ANSI'}[$andx]){$pndx=$andx;last;}}}
    @cdcr= cdst('-N',$pndx);my $lscr= spff(0);for(@cdcr){if(/^\s*\d+\.\d+$/){$lscr=$_;}elsif(/^\d+$/){
        if   ($cbrt{spfd($pndx)} >  $cbrt{spfd($_)}){push(@{$cdwb{spfd($pndx)}{'d'}{$lscr}},$_);}
        elsif($cbrt{spfd($pndx)} == $cbrt{spfd($_)}){push(@{$cdwb{spfd($pndx)}{'a'}{$lscr}},$_);} # mAB == avg should be within small threshold
        else                                        {push(@{$cdwb{spfd($pndx)}{'l'}{$lscr}},$_);}}}
    for   my $plnk (qw(l a d)){my $pikf=0;my $plns=$plnk; # Pal8LayrNameKeyz in lite, avrg, then dark ordr with Pal8LayrNameShifted
      next if(exists($g8lm{$plnk}) && exists($g8lm{$plnk}{$p8ky}));
      if(!exists($cdwb{spfd($pndx)}{$plnk}) || !keys(%{$cdwb{spfd($pndx)}{$plnk}})){$plns='a' if($plnk eq 'd');} # try2detect when best to auto-lighten layrz
      if(!exists($cdwb{spfd($pndx)}{$plns}) || !keys(%{$cdwb{spfd($pndx)}{$plns}})){$plns='l' if($plns eq 'a');}
      for my $dscr (sort {$a <=> $b} keys %{$cdwb{spfd($pndx)}{$plns}}){
        for my $nndx (                    @{$cdwb{spfd($pndx)}{$plns}{$dscr}}){
          if(defined($nndx) && !exists($p226{$nndx})){$g8lm{$plnk}{$p8ky}=$nndx;$p226{$nndx}="$plnk$p8ky"; # should apply to orig layr even if shifted lite
            for my $sndx (0..$#snls){if($nndx == $snls[$sndx]){splice(@snls,$sndx,1);$pikf=1;last;}} # loop to rm pickd index from snls for less to srch next
            last if($pikf);}} last if($pikf);}}}
  my $cpfx='F:kx'; # could better error-check code to end in x or X (or % or #)
  # note that pal8 change SKp codes with something like this \e]4;%d;%2.2x;%2.2x;%2.2x\e\\ && it works for remapping any decimal x256 index until `reset`
  if    ($argz=~ /(^|\s)-?-?c=?\s*(\S+)/i){$cpfx=$2;} # set a new parameter c8 code prefix
  if    ($argz=~ /(^|\s)-?-?p/i){$l=0;my %foun; # Print Pal8
    for     my $plnk (qw(b d a l)){$l=0;my $p8kz=$cmap{'8pal8'};$p8kz=~ s/\s+//g;print "\n'$plnk' => ["; # print out map for code
      for   my $p8ky (split(//,$p8kz)){if(exists($g8lm{$plnk}) && exists($g8lm{$plnk}{$p8ky})){
          if(exists($foun{$g8lm{$plnk}{$p8ky}})){print "Eror: $plnk$p8ky duplic8 mapd to $g8lm{$plnk}{$p8ky}!";}else{$foun{$g8lm{$plnk}{$p8ky}}=1;}
                                                                                 printf("'$p8ky'=>%3d,",$g8lm{$plnk}{$p8ky});}
        else                                                   {                 print   "$p8ky not found!,";}
        if(++$l == 64){print '],';}elsif(!($l % 16)){print "\n        ";}elsif(!($l % 8)){print '  ';}}}
    for(0..255){print "Missing: $_\n" unless(exists($foun{$_}));} say '';
  }elsif($argz=~ /(^|\s)-?-?l/){ # layers in bd,al blocks in bigger 8pal8 lowercase first (like q versus Q)
  }elsif($argz=~ /(^|\s)-?-?L/){ # Layers in bd,al blocks in bigger normal 8pal8
    # think about cleaner way to gener8 less duplic8 code
  }elsif($argz=~ /(^|\s)-?-?q/){ # quads of b then d each own 8pal8, then lower row for a && l but all lowercase grouped then uppercase
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
  }elsif($argz=~ /(^|\s)-?-?Q/){ # Quads of b then d each own 8pal8, then lower row for a && l
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(b d)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='krOgcbPw';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='KRYGCBMW';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='ehodtspi';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='EHyDTSmI';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='.fuaznlj';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='_FUAZNLJ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='02468xvq';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );}}say '';
    for   my $plnk (qw(a l)){$g8po='13579XVQ';
      for my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}}say '';
  }elsif($argz=~ /(^|\s)-?-?s/i){ # like `tstc s` for Squeeze
  for     my $plnk (qw(b d a l)){$g8po='krOgcbPw ehodtspi  .fuaznlj 02468xvq';$g8po=~ s/\s+//g; # now gener8 8pal8 blox to compare all sets
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk$p8ky %02X"      ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky}                    );} say '';}
  for     my $plnk (qw(b d a l)){$g8po='KRYGCBMW EHyDTSmI  _FUAZNLJ 13579XVQ';$g8po=~ s/\s+//g;
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk$p8ky %02X"      ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky}                    );} say '';}
  }else{
  for     my $plnk (qw(b d a l)){$g8po='krOgcbPw ehodtspi';$g8po=~ s/\s+//g; # now gener8 16 10-char-wide blox on double rows with 8pal8 colr names lookin nice
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});} say '';
    for   my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );} say '';
    for   my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}say ''}
  for     my $plnk (qw(b d a l)){$g8po='.fuaznlj 02468xvq';$g8po=~ s/\s+//g;
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});} say '';
    for   my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );} say '';
    for   my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}say ''}
  for     my $plnk (qw(b d a l)){$g8po='KRYGCBMW EHyDTSmI';$g8po=~ s/\s+//g;
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});} say '';
    for   my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );} say '';
    for   my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}say ''}
  for     my $plnk (qw(b d a l)){$g8po='_FUAZNLJ 13579XVQ';$g8po=~ s/\s+//g;
    for   my $p8ky (split(//,$g8po)){printf("%s$plnk $p8ky %03d %02X",S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$g8lm{$plnk}{$p8ky},$g8lm{$plnk}{$p8ky});} say '';
    for   my $p8ky (split(//,$g8po)){my $p8V8= $pl8n{$p8ky};$p8V8=substr($p8V8, 0,10) if(length($p8V8) > 10);
                                     printf("%s%-10s"                ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$p8V8                                  );} say '';
    for   my $p8ky (split(//,$g8po)){my $hrgb= $x256[$g8lm{$plnk}{$p8ky}];
                                     printf("%s%-6s %s%s%s"          ,S($cpfx . spfX($g8lm{$plnk}{$p8ky})),$hrgb,$sb64[int(hex(substr($hrgb,0,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,2,2))/4)],
                                                                                                                 $sb64[int(hex(substr($hrgb,4,2))/4)])}say ''}
  }}
sub tstc{my $retn='';my $argz='';my $widt=80;$widt=$ENV{'COLUMNS'} if(exists($ENV{'COLUMNS'})); # kEp snglspcBtwn arg pRamz whN trEtng all2gethr as sngl strng?
  $argz= join(' ',@_) if(@_);if($argz =~ /(^|\s)-?-?h(elp)?(\s|$)/i){return(
" tstc crE8d by PipStuart <Pip\@CPAN.Org> to tst the display of 8pal8 (64-of-256) colors && terminal attributes;
   h - print out this Help text and return
       2du:fix all print && say to append to scalar to return,all the SGR attributes below should be subsumed under a new -c option or something,
         figure out best main new default block sizes to start options for,count for newlines instead of checking matching color keyz,
         do narOwr Squeeze of 1st 8pal8 on2 4 lInz lIk `tStc s`;
   s - Squeeze each of the 4 2pal8s onto a single line
   z - check roundtripZ of each 8pal8 color code going through S and c to be back to the same
   b - reset Bold making all fonts normal 4 colrs gr8rthan 15 (dfalt is Bold for all gr8rthan 7)
   B - set   Bold fonts (used to turn 0..7 krOgcbPw dark Foregrounds into bright counterparts by pre-modifying existing Fclr)
   A - set fAint                                     O - set Overlined           (hardly ever supported)
   I - set ItalIcs                                   F - set Fraktur font        (hardly ever supported)
   U - set Underline                                 D - set underline Double    (hardly ever supported)
   L - set bLink        (slow,lessthan 150/min)      M - set fraMed              (hardly ever supported)
   K - set blinK        (fast,morethan 150/min)      E - set EncirclEd           (hardly ever supported)
   R - set ReveRse                                   H - set ideogram line rigHt (hardly ever supported)
   V - set inVisible                                 T - set ideogram line lefT  (hardly ever supported)
   C - set Crossed-out                               G - set ideoGram stressmark (hardly ever supported)\n");}
  for my $layr (qw(F D A L)){my $blyr=lc($layr);$blyr='b' if($blyr eq 'f'); # load eScape && togl its own Bold if code given, could just y/FDALOHbdaloh/bda...
    my @cmdo;my @cmrz= split(/\s+/,$cmap{'8pal8'});for(0..7){ #,2,4,6,1,3,5,7)
      push(@cmdo,split(//,$cmrz[$_]));} # try building DifOrdr than @{$cmsp{'8pal8'}}
    for(@cmdo){my $Spv8=S("F$blyr:K$_");if   ($argz=~ /B/){$Spv8=~ s/^(\e\[)(0+|22)(;|m)/${1}01$3/ ;} # nEd2 B smRtr about stripng non-SGR cOdz
                                        elsif($argz=~ /b/){$Spv8=~ s/^(\e\[)(0* 1 )(;|m)/${1}22$3/x;}
    $retn.=$Spv8;if($argz=~ /[^ szb-]/i){my $nosz=$argz;$nosz=~ s/[ szb-]+//gi;$retn.= S(":$nosz") if(length($nosz));}
    my $pv2n=$p8k2{$layr}{$_};$pv2n=0 unless defined $pv2n;
    if($argz=~ /z/i                ){      $_=    c(S($_));} # used to do sS(S($_),'d') nstd of just loading key to 256 ndx
    if($argz=~ /s/i && $widt >= 160){$retn.= sprintf("$blyr$_%03d"       ,$pv2n          );$retn.="\n" if(/^ [IQ]  $/x );}
    else                            {$retn.= sprintf("$blyr:$_ %03d %12s",$pv2n,$pl8n{$_});$retn.="\n" if(/^[wijq] $/ix);
                                                                                           $retn.="\n" if(/^[gda67]$/i && $widt ==  80);}}}
  $retn.=  "$z${G}Maybe since around 1979, ANSI escape sequences were: $z";for(30..37,40..47){$retn.=$G if($_ >= 40);
                                                                                              $retn.="\e[${_}m$_$z ";}
  $retn.="$z$G wrapped by CSI Escape left-bracket then 'm'.";
  $retn.="$z\n${G}All the above color code examples are default. Bold: "  ;for(30..37       ){$retn.="\e[${_}m$_ ";}
  $retn.="$z${G}changes color and font w8. Then much more recently, the palettes commonly supported
  grew to 256 colors with the basic 16, a 6x6x6 color cube, and a grayscale ramp of the last 24 (all optionally Bold w8d font now, without color change).\n";
  # orig 256colors2.pl by Author: Todd Larason <jtl@molehill.org>  # $XFree86: xc/programs/xterm/vttests/256colors2.pl,v 1.2 2002/03/26 01:46:43 dickey Exp $
  # "use the resources for colors 0-15 - usually more-or-less a reproduction of the standard ANSI colors, but possibly more pleasing shades"
  for        (my $redd =   0;$redd <   6;$redd++){ # colors 16-231 are a 6x6x6 color cube  # all eScapes used to be \x1b nstd of \e
    for      (my $gren =   0;$gren <   6;$gren++){ # these actually are probably assigning the colors before displaying them, which I don't normally want to do
      for    (my $blue =   0;$blue <   6;$blue++){#$retn.= sprintf("\e]4;%d;rgb:%2.2x/%2.2x/%2.2x\e\\", 16 + ($red * 36) + ($green * 6) + $blue,
  #          ($red   ? ($redd * 40 + 55) : 0),
  #          ($green ? ($gren * 40 + 55) : 0),
  #          ($blue  ? ($blue * 40 + 55) : 0));
      }}} # colors 232-255 are a grayscale ramp, intentionally leaving out
  for        (my $gray =   0;$gray <  24;$gray++){my $levl = ($gray * 10) + 8; # black and white
  # $retn.= sprintf("\e]4;%d;rgb:%2.2x/%2.2x/%2.2x\e\\", 232 + $gray, $levl, $levl, $levl);
  }
  for        (my $gren =   0;$gren <   6;$gren++){my $Fclr;my $gclr; # now the color cube #$retn.="Color cube, 6x6x6:\n";
    if       (   $gren ==  0){ # try to nest first ANSI 2pal8, a blank, then snaking grayscale before each cube line
      for    (   $Fclr =   0;$Fclr <   8;$Fclr++){$retn.="\e[01;48;5;${Fclr}m" . join(':',split(//,$p82k[$Fclr]));} $retn.=$z;}
    elsif    ($gren == 1){
      for    (   $Fclr =   8;$Fclr <  16;$Fclr++){$retn.="\e[01;48;5;${Fclr}m" . join(':',split(//,$p82k[$Fclr]));} $retn.=$z;}
    elsif    ($gren == 2){$retn.=$z . ' ' x (3*2);
      for    (   $gclr = 232;$gclr < 238;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
    elsif    ($gren == 3){$retn.=$z . ' ' x (3*2);
      for    (   $gclr = 238;$gclr < 244;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
    elsif    ($gren == 4){$retn.=$z . ' ' x (3*2);
      for    (   $gclr = 244;$gclr < 250;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
    elsif    ($gren == 5){$retn.=$z . ' ' x (3*2);
      for    (   $gclr = 250;$gclr < 256;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
#   elsif    ($gren == 2){                                                                                          $retn.=$z . ' ' x (3*8);}
#   elsif    ($gren == 3){ # old way was snaking 3 rows of 8 before switched to above 4 rows of 6 as better
#     for    (   $gclr = 232;$gclr < 240;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
#   elsif    ($gren == 4){
#     for    (   $gclr = 247;$gclr >=240;$gclr--){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
#   elsif    ($gren == 5){
#     for    (   $gclr = 248;$gclr < 256;$gclr++){$retn.="\e[01;48;5;${gclr}m" . join(':',split(//,$p82k[$gclr]));} $retn.=$z;}
    for      (my $redd =   0;$redd <   6;$redd++){
      for    (my $blue =   0;$blue <   6;$blue++){my $colr = 16 + ($redd * 36) + ($gren * 6) + $blue;
                                                  $retn.="\e[01;48;5;${colr}m" . join(':',split(//,$p82k[$colr]));} $retn.=$z;} # nEdz lc&&F2b 4bkgr consistNC
    if       (   $gren ==  0){$retn.="$C # GNU/Linux utilities use"  ;}
    elsif    (   $gren ==  1){$retn.="$C #   such ANSI colors pretty";}
    elsif    (   $gren ==  2){$retn.="$C #   rarely, but I hope that";}
    elsif    (   $gren ==  3){$retn.="$C #   Octology makes them far";}
    elsif    (   $gren ==  4){$retn.="$C #   more widespread in the" ;}
    elsif    (   $gren ==  5){$retn.="$C #   more colorful future.=)"  ;}
    $retn.="\n$z";} # now the grayscale ramp #$retn.="Grayscale ramp:\n";
 $retn.="${G}Even after much use, I still consider long digit codes like \"\\e[01;33;44m\" or \"\\x1B[01;38;5;085;48;5;017m\" too unwieldy. So I sorted and searched
  rgb.txt and colors.txt to represent colors as just 1 or 2 descriptive characters. There are also High intensity Foregrnd 90..97 and backgrnd 100..107.
I call a \"pal8\" a generic term for 8 (or any multiple) of such remapped color-codes. A \"2pal8\" is meant to describe the old standard first 16 colors
  renamed (or l8r extended sets of 16 that correspond back to the original 16). In order to attain my default \"8bow\" of " . d8colr($cmap{'8bow'}) . "$G, I needed to promote
 $O dark$Y yellow$G to$O bright Orange$G and$P dark$M magenta$G to$P bright PurPle$G. I'm still not sure if$P PurPle$G should order before$M Magenta$G, being closer to$B Blue$G?
So the original ANSI in 2pal8 form is '"  ;for(@{$cmsp{ 'ANSI'}}){$retn.= S($_) . $_;$retn.=' ' if(/^w$/);} # krgObPcw KRGYBMCW  shud colr neon wash melo BlO2
  $retn.="$G' and my reordering '"        ;for(@{$cmsp{'2pal8'}}){$retn.= S($_) . $_;$retn.=' ' if(/^w$/);} # krOgcbPw KRYGCBMW  shud colr dark avrg lite BlO2
  $retn.="$G'. Then shifting 2pal8 from clen into neon, wash, and melo.
They were all named closely too as in '"  ;for(        16..63   ){$retn.= S($cmsp{    '8pal8'}[$_]) . $cmsp{'8pal8'}[$_]; # ehodtspi EHyDTSmI  l8r 48 of 64
                                                                  $retn.=' ' if($cmsp{'8pal8'}[$_]=~ /^[ijqIJ]$/ );       # .fuaznlj _FUAZNLJ
                                                                  $retn.=' ' if($cmsp{'8pal8'}[$_]=~ /^   [IJ]$/x);}      # 02468xvq 13579XVQ
  $retn.="$G' following Uppercase, odd, and underscore all correspond
  to brighter versions of dim lowercase, even, and dot colors. Then 8pal8 remaps Fclr to Dark, Avrg, Lite to cover 256.";
# Because of the Bold heritage, the 8 dark Foreground colors could not display in a Bold font-face, even if they were modified to appear similarly bright and
#   similarly the higher Bold bright 8 colors could not appear for early background colors either.
# Then there are arbitrary 38;2;R;G;Bm codes where RGB are 0..255 for any 24-bit color, which are easy enough to construct extended maps for.
# There's also the subtlety of dark black actually being different than -1 transparent background, being only easily restored with $z.
# So now if you remember 10 main colors: blacK  Red Orange Yellow Green  Cyan Blue Magenta PurPle  White each abbreV8d by KROYG CBMPW and lowercase dark,
#   you can easily control 20 colors. If you transl8 the 2pal8 into neon, wash, or melo, those 20 extend to 64, or all 64 can be named sepR8ly, then extended
#   to dark, avrg, and lite for maybe two nested contexts switching base 2pal8, or just 8pal8 plane around b64 abbreV8ion.
# Lots of ideas, swap MP, mk DAL && NWM rot8 && ignore OH, gNr8 .Hrc from code-analysis && vice-versa...
  while($retn=~  /m([FDALOH]):/){my $blyr=$1;$blyr=~ y/FDALOHbdaloh/bdalohFDALOH/;
    $retn    =~ s/m([FDALOH]):    /m$blyr:/x;} # post-process F2b flip-flop Foreground uc default 8pal8 layer prefixes into usage as bkgrnd lc versions
  $retn      =~ s/^\s+//; # not sure why blank newline snuck in top
  return($retn);}
8;

=encoding utf8

=head1 NAME

Octology::a8 - Autom8 exports of base Octology functionality

=head1 VERSION

This documentation refers to version 0.0 of Octology::a8 released on.

=head1 SYNOPSIS

  use Octology::a8;

  # show some example usage

=head1 DESCRIPTION

This module is primarily a collection of variables and functions which are automatically exported as fundamental throughout Octology. This module also defines
objects which represent the .Hrc file format as a data-structure in memory which can override the default exports.

=head1 USAGE

=head2 new()

The standard a8 object constructor, which does rudimentary parsing and coloring of the ~/.Hrc d8a file.

=head1 CHANGES

Revision history for Perl extension Octology::a8:

=over 2

=item - 0.0 

* started writing POD

* original version (derived from old Pip::Utl code)

=back

=head1 TODO

=over 2

=item - flesh out objects

=back

=head1 INSTALL

From the command shell, please run:

  `perl -MCPAN -e "install Octology"`

or uncompress the package and run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2014-2016, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
