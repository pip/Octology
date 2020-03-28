# D8FMKTuW: Octology::d8.pm by PipStuart <Pip@CPAN.Org> to define simple objects for storing instants in time, adapted from the old poorly named Time::PT;
package     Octology::d8;
use strict; use warnings;use utf8;use v5.10;
# 2du:try to use or replic8 DateTime::Format::Strptime to help d8 support various strf && strp time formats,generally mimic l8st Time::Piece behavior,
#   maybe find some new hosting && upd8 the web HTML color hrefs&&upd8 CGI,test all documented methods like mday month _mon etc. && upd8 test scripts,
#   crE8 and export d8sort sub,figure out roundtrip for `d8 ANSI` where M:23 is not getting properly shifted into Y && over-extending M expected range,
#   tStz should include a lot of attemptz to roundtrip most value edge-cases primarily surrounding Year shifts,cNtralIz _separ8or valUz 4 stringz && matchez,
#   research how to implement d8's own extensible epoch,tzoffset,julian_day,mjd,week,&&is_leap_year,then add them to POD,dvl XtNded d8 4m@ 4atlEst10e-9 4NTP,
#   stuD HTTPS://Cr.yp.to/daemontools/tai64n.html which puts a precise 12-byte lowercase hex timestamp on each line from stdin in external TAI64N format;
require     Octology::d8::fldz;
#equire                        Exporter;
use base qw(Octology::d8::fldz);#porter);
use         Octology::d8::dur8;
use         Octology::a8;
use         Octology::b8;
use         Carp;
use         File::Copy   qw(mv cp);
use         Time::DayOfWeek;
use         Time::DaysInMonth;
my $hirs   = eval("use Time::HiRes; 8") || 0;
my $locl   = eval("use Time::Local; 8") || 0;
my $zown   = eval("use Time::Zone ; 8") || 0;
#ur @EXPORT= qw(); # eventually export d8() here as new wrapper
our $VERSION='0.0';my $d8VS='K3SM2nBb';
my @_tzofsetz=( # global storage for TimeZone Offsets matching /^[-+][01]\d(00|30|45)$/ shhmm (with non-integer offsets mapping in b64 between R(27)..g(42))
  '-1130',#NUT
  '-0930',
  '-0430',
  '-0330',
  '-0230',#NDT
  '+0330',
  '+0430',
  '+0530',
  '+0545',
  '+0630',
  '+0845',
  '+0930',
  '+1030',
  '+1130',
  '+1245',
  '+1345',#CHADT
);unshift(@_tzofsetz,sprintf("-%02d00",12-(26-$_))) for(15..26);unshift(@_tzofsetz,sprintf("+%02d00",14-$_)) for(0..14); # front-loads even hour zone orders
my %_ofst2ndx=();for(my $i=0;$i<@_tzofsetz;$i++){$_ofst2ndx{$_tzofsetz[$i]}=$i;} # reverse lookup @_tzofsetz indices given the offset as key
my %_knwntzab=(# KNoWN TimeZone ABbreviations, to search in for $ENV{'TZ'} to find the corresponding offset (when Time::Zone doesn't work)
#zone abbreV8ions that are the same in Wikipedia's list as can be computed from Time::Zone::tz_offset($abrv)
  'ADT'  =>24, 'AEDT' =>11, 'AEST' =>10, 'AKDT' =>19, 'AKST' =>18, 'AST'  =>23, 'BRT'  =>24, 'BST'  => 1, 'CDT'  =>22, 'CEST' => 2, 'CET'  => 1, 'CST'  =>21,
  'EDT'  =>23, 'EEST' => 3, 'EET'  => 2, 'EST'  =>22, 'FNT'  =>25, 'GMT'  => 0, 'HKT'  => 8, 'HST'  =>17, 'JST'  => 9, 'KST'  => 9, 'MDT'  =>21, 'MET'  => 1,
  'MEST' => 2, 'MST'  =>20, 'NZDT' =>13, 'NZST' =>12, 'PDT'  =>20, 'PST'  =>19, 'UTC'  => 0, 'WET'  => 0, 'WST'  => 8,
#zone abbrevz that T::Z computes differently from Wikipedia (with my values deferring to T::Z as actually implemented && likely to be more reliable)
  'ACT'  =>22, 'CAT'  =>26, 'CCT'  => 8, 'EAST' =>10, 'ECT'  => 1, 'GST'  =>10, 'MSK'  => 3, 'NT'   =>16, 'SST'  => 2, 'WAT'  =>26,
 #'ACT'  => 8, 'CAT'  => 2, 'CCT'  =>36, 'EAST' =>21, 'ECT'  =>23, 'GST'  =>25, 'MSK'  => 4, 'NT'   =>30, 'SST'  =>16, 'WAT'  => 1, # Wiki diff valz
#zone abbrevs that are overloaded (but already have a preferred T::Z mapping above)
 #'AST'  =>  ,#+0300:03:-0400:23:overloaded
 #'BST'  =>  ,#+0600:06:+0100:01:overloaded
 #'CDT'  =>  ,#-0400:23:-0500:22:overloaded
 #'CST'  =>  ,#+0800:08:-0600:21:overloaded
 #'CST'  =>  ,#+0930:38:-0600:21:overloaded
 #'CST'  =>  ,#+1030:39:-0600:21:overloaded
 #'CST'  =>  ,#-0500:22:-0600:21:overloaded
 #'ECT'  =>  ,#-0500:22:+0100:01:overloaded
 #'EST'  =>  ,#+1000:10:-0500:22:overloaded
 #'GST'  =>  ,#+0400:04:+1000:10:overloaded
 #'MST'  =>  ,#+0800:08:-0700:20:overloaded
 #'MST'  =>  ,#+0630:36:-0700:20:overloaded
 #'SST'  =>  ,#+0800:08:+0200:02:overloaded
#zone abbrevz that are undef by T::Z && aren't overloaded should be fine to map here
  'ACDT' =>39, 'ACST' =>38, 'AFT'  =>33, 'AMST' => 5, 'AMT'  => 4, 'ART'  =>24, 'AWDT' => 9, 'AWST' => 8, 'AZOST'=>26, 'AZT'  => 4, 'BDT'  => 8, 'BIOT' => 6,
  'BIT'  =>15, 'BOT'  =>23, 'BTT'  => 6, 'CEDT' => 2, 'CHADT'=>42, 'CHAST'=>41, 'CHOT' =>19, 'CHST' =>10, 'CHUT' =>10, 'CIST' =>19, 'CIT'  => 8, 'CKT'  =>17,
  'CLST' =>24, 'CLT'  =>23, 'COST' =>23, 'COT'  =>22, 'CT'   => 8, 'CVT'  =>26, 'CWST' =>37, 'CXT'  => 7, 'DAVT' => 7, 'DDUT' =>10, 'DFT'  => 1, 'EASST'=>22,
  'EAT'  => 3, 'EEDT' => 3, 'EGST' => 0, 'EGT'  =>26, 'EIT'  => 9, 'FET'  => 3, 'FJT'  =>12, 'FKST' =>24, 'FKT'  =>23, 'GALT' =>21, 'GAMT' =>18, 'GET'  => 4,
  'GFT'  =>24, 'GILT' =>12, 'GIT'  =>18, 'GYT'  =>23, 'HADT' =>18, 'HAEC' => 2, 'HAST' =>17, 'HMT'  => 5, 'HOVT' => 7, 'ICT'  => 7, 'IDT'  => 3, 'IOT'  => 3,
  'IRDT' => 8, 'IRKT' => 9, 'IRST' =>32, 'KGT'  => 6, 'KOST' =>11, 'KRAT' => 7, 'LINT' =>14, 'MAGT' =>12, 'MART' =>28, 'MAWT' => 5, 'MHT'  =>12, 'MIST' =>11,
  'MIT'  =>28, 'MMT'  =>36, 'MUT'  => 4, 'MVT'  => 5, 'MYT'  => 8, 'NCT'  =>11, 'NDT'  =>31, 'NFT'  =>40, 'NPT'  =>35, 'NST'  =>30, 'NUT'  =>27, 'OMST' => 6,
  'ORAT' => 5, 'PET'  =>22, 'PETT' =>12, 'PGT'  =>10, 'PHOT' =>13, 'PHT'  => 8, 'PKT'  => 5, 'PMDT' =>25, 'PMST' =>24, 'PONT' =>11, 'RET'  => 4, 'ROTT' =>24,
  'SAKT' =>11, 'SAMT' => 4, 'SAST' => 2, 'SBT'  =>11, 'SCT'  => 4, 'SGT'  => 8, 'SLT'  =>34, 'SRT'  =>24, 'SYOT' => 3, 'TAHT' =>17, 'THA'  => 7, 'TFT'  => 5,
  'TJT'  => 5, 'TKT'  =>14, 'TLT'  => 9, 'TMT'  => 5, 'TOT'  =>13, 'TVT'  =>12, 'UCT'  => 0, 'ULAT' => 8, 'UYST' =>25, 'UYT'  =>24, 'UZT'  => 5, 'VET'  =>29,
  'VLAT' =>10, 'VOLT' => 4, 'VOST' => 6, 'VUT'  =>11, 'WAKT' =>12, 'WAST' => 2, 'WEDT' => 1, 'WEST' => 1, 'YAKT' => 9, 'YEKT' => 5,
#zone abbrevs that are overloaded but undef by T::Z (keeping non-preferred values commented, since this hash can only handle each name being a single key)
  'IST'  =>34,#+0530:34:         overloaded
 #'IST'  =>  ,#+0100:01:         overloaded
 #'IST'  =>  ,#+0200:02:         overloaded
  'LHST' =>39,#+1030:39:         overloaded
 #'LHST' =>  ,#+1100:11:         overloaded
);
use overload
  q("")  => \&_stringify,
  q(<=>) => \&_cmp_num,
  q(cmp) => \&_cmp_str,
  q(+)   => \&_add,
  q(-)   => \&_sub;
sub _stringify{ # cat non-zero b64 d8 fields
  my @fdat=$_[0]->YMDzhmsp();
  my @attz=$_[0]->_attribute_names();my $tstr='';my $toob=0; # flag design8ing field too big
  $fdat[0]-=2000; # Year adjustment
  for(@fdat){$toob=1 if($_>63);}
# Reverse Year shifts back into fields
#   0) Each 13 added to the Month adds  64 to the Year.
#   1)      24 added to the Hour  adds 256 to the Year.
#   2)      32 added to the Day   makes the year negative just before adding 2000
  if(   $fdat[0]<   0){$fdat[0]*= -1;$fdat[2]+=32;}
  if(   $fdat[0]>=256){$fdat[0]-=256;$fdat[4]+=24;}
  while($fdat[0]>= 64){$fdat[0]-= 64;$fdat[1]+=13;}
  for(my $i=0;$i<@fdat;$i++){
    if($toob)                                   {$tstr.=$attz[$i].':'.$fdat[$i];$tstr.=', ' if($i<$#fdat);}
    else                                        { # verbose above for too big, compressed below for fitting
      if(defined($fdat[$i])&& length($fdat[$i])){$tstr.=          b64($fdat[$i]);}
      else                                      {$tstr.=                     ' ';}} # add spaces for any found empty fields
  } return($tstr);}
sub _cmp_num{my($larg,$rarg,$srvr)=@_;
  ($larg,$rarg)=($rarg,Octology::d8->new($larg)) if($srvr); # mk both args d8 objects
  $rarg=Octology::d8->new($rarg) unless(ref($rarg) && $rarg->isa('Octology::d8'));
  if   (($larg->Y < $rarg->Y) ||
        ($larg->M < $rarg->M) ||
        ($larg->D < $rarg->D) ||
        ($larg->z < $rarg->z) || # should probably have smarter h+z <=>
        ($larg->h < $rarg->h) ||
        ($larg->m < $rarg->m) ||
        ($larg->s < $rarg->s) ||
        ($larg->p < $rarg->p)){return(-1);}
  elsif(($larg->Y > $rarg->Y) ||
        ($larg->M > $rarg->M) ||
        ($larg->D > $rarg->D) ||
        ($larg->z > $rarg->z) ||
        ($larg->h > $rarg->h) ||
        ($larg->m > $rarg->m) ||
        ($larg->s > $rarg->s) ||
        ($larg->p > $rarg->p)){return(1);}
  else                        {return(0);}}
sub _cmp_str{my $c=_cmp_num(@_);($c<0) ? return('lt') : ($c) ? return('gt') : return('eq');}
# d8 + dur8 = d8
# d8 + anything else is not supported yet
sub _add{
  my($larg,$rarg,$srvr)=@_;my $rslt=Octology::d8->new('');
    ($larg,$rarg)=($rarg,Octology::d8::dur8->new($larg)) if($srvr);
           $rarg =       Octology::d8::dur8->new($rarg)  unless(ref($rarg) && $rarg->isa('Octology::d8::dur8'));
  $rslt->{'f'}=$larg->p+$rarg->p;
  $rslt->{'s'}=$larg->s+$rarg->s;
  $rslt->{'m'}=$larg->m+$rarg->m;
  $rslt->{'h'}=$larg->h+$rarg->h;
  $rslt->{'z'}=$larg->z+$rarg->z;
  $rslt->{'D'}=$larg->D+$rarg->D;
# $rslt->{'M'}=$larg->M;
# $rslt->{'Y'}=$larg->Y;
# $rslt->_sift( );
  $rslt->{'M'}=$larg->M+$rarg->M;
  $rslt->{'Y'}=$larg->Y+$rarg->Y;
  $rslt->_sift( );
  return($rslt);}
# d8 - dur8 = d8
# d8 - d8   = dur8
# d8 - anything else is not supported yet
sub _sub{
  my($larg,$rarg,$srvr)=@_;my $rslt;          $larg=Octology::d8->new($larg) if($srvr);
  if(ref($rarg)&& $rarg->isa('Octology::d8')){$rslt=Octology::d8::dur8->new(     );
  }else                                      {$rarg=Octology::d8::dur8->new($rarg) unless(ref($rarg)&& $rarg->isa('Octology::d8::dur8'));
                                              $rslt=Octology::d8->new(''   );}
  $rslt->{'p'}=$larg->p-$rarg->p;
  $rslt->{'s'}=$larg->s-$rarg->s;
  $rslt->{'m'}=$larg->m-$rarg->m;
  $rslt->{'h'}=$larg->h-$rarg->h;
  $rslt->{'z'}=$larg->z-$rarg->z;
  $rslt->{'D'}=$larg->D-$rarg->D;
  $rslt->{'M'}=$larg->M;
  $rslt->{'Y'}=$larg->Y;
  $rslt->_sift( ) if($rslt->isa('Octology::d8'));
  $rslt->{'M'}=$larg->M-$rarg->M;
  $rslt->{'Y'}=$larg->Y-$rarg->Y;
  $rslt->_sift(1) if($rslt->isa('Octology::d8'));
  return($rslt);}
sub d8cc{my $frmt=shift(@_)||0;my($ptst,$ptsb); # Generic d8 c8 Color Code strings (derived from old Curses::Simp) as class method
#                       `d8 e`->Wed Jul 16 00:03:31:30 -0500 2003
  if    ($frmt=~ /-*f/i){$ptst='YYY OOO YY CCWBBWMMWPP GGGGG RRRR';
    if  ($frmt=~ /-*k/i){$ptsb='           bbbbbbbbbbb wwwww     ';}
    else                {$ptsb='                                 ';}
  }else                 {$ptst='ROYGCBMP';
    if  ($frmt=~ /-*k/i){$ptsb='   wbbbb';}# same as below but with white 'z' background && 'hmsp' backed in darkblue
    else                {$ptsb='        ';}
  } return($ptst,$ptsb);} # d8->YMDzhmsp
# Note:`d8` && `d8ok` utilz use 'f' for Full Format to invoke this original expand form (e was phased out since Octology almost always uses x for eXpand now);
sub expand{ # returns a d8 object's expanded string form, although might need even more expanded form for when /^.../ is not unique in Mon or Dow
  my $self=shift(@_);my $xpop=shift(@_)||'';my @mnth;my $dofw='   ';my $mont='   ';
  my $cclz=  $self->_field_colors('c'); # load refs to anon color arrays
  my $aclz=  $self->_field_colors('a');my %dfcl=();for(0..@{$cclz}-1){$dfcl{$cclz->[$_]}=$aclz->[$_];} # load c8=>ansi from fields colors d8a
  if(defined($self)&&      $self->M){ # the changes to use lowercase 'o' && 'p' mean all these mappings need to reflect the changes in sprintf below
    $dofw=   $self->Dow if($self->D);
    @mnth= Time::DayOfWeek::MonthNames();
    $mont=   $mnth[        $self->M-1];
    $mont=~ s/^(...).*/$1/;} # keep only 1st 3 chars
  if($xpop=~ /a/){my $W="\e\[1;37m"; # eXPand OPtion to enable Ansi color codes in returned string
    return(sprintf("%s%3s %s%3s %s%2d %s%02d$W:%s%02d$W:%s%02d$W:%s%02d %s%-5s %s%4d", $dfcl{'Y'},$dofw, $dfcl{'o'},$mont, $dfcl{'Y'},$self->D,
      $dfcl{'C'},$self->h, $dfcl{'B'},$self->m, $dfcl{'M'},$self->s, $dfcl{'p'},$self->p, $dfcl{'G'},$self->zone_offset, $dfcl{'R'},$self->Y));
  }else{ # maybe eventually support additional coloring schemes for expanded d8 d8a here
    return(sprintf("%3s %3s %2d %02d:%02d:%02d:%02d %-5s %4d", $dofw, $mont, $self->Dhmsp, $self->zone_offset, $self->Y));}}
sub lsft{ # returns a d8 object's ls --full-time string form
  my $self=shift(@_);my $xpop=shift(@_)||'';
  my $cclz=  $self->_field_colors('c'); # load refs to anon color arrays
  my $aclz=  $self->_field_colors('a');my %dfcl=();for(0..@{$cclz}-1){$dfcl{$cclz->[$_]}=$aclz->[$_];} # load c8=>ansi from fields colors d8a
  my $frcp=  $self->p / $self->{'_pps'};$frcp =~s/^0\.//;$frcp.='0' while(length($frcp) < 9);$frcp=substr($frcp,0,9) if(length($frcp) > 9);
  if($xpop=~ /a/){my $W="\e\[1;37m"; # eXPand OPtion to enable Ansi color codes in returned string
    return(sprintf("%s%4d$W-%s%02d$W-%s%02d %s%02d$W:%s%02d$W:%s%02d$W.%s%9d %s%-5s", $dfcl{'R'},$self->Y, $dfcl{'o'},$self->M, $dfcl{'Y'},$self->D,
      $dfcl{'C'},$self->h, $dfcl{'B'},$self->m, $dfcl{'M'},$self->s, $dfcl{'P'},$frcp,$dfcl{'G'},$self->zone_offset));
  }else{ #          '2013-08-15 12:55:23.833703078 -0500'
    return(sprintf("%4d-%02d-%02d %02d:%02d:%02d.%9d %-5s", $self->YMDhms, $frcp, $self->zone_offset));}}
sub cpan{ # returns a d8 object's cpan && pause string form
  my $self=shift(@_);my $xpop=shift(@_)||'';my @mnth;my $dofw='   ';my $mont='   ';my $zabr='GMT';
  my $cclz=  $self->_field_colors('c'); # load refs to anon color arrays
  my $aclz=  $self->_field_colors('a');my %dfcl=();for(0..@{$cclz}-1){$dfcl{$cclz->[$_]}=$aclz->[$_];} # load c8=>ansi from fields colors d8a
  if(defined($self)&&      $self->M){
    $dofw=   $self->Dow if($self->D);
    @mnth= Time::DayOfWeek::MonthNames();
    $mont=   $mnth[        $self->M-1];
    $mont=~ s/^(...).*/$1/;} # keep only 1st 3 chars
  if($zown){$zabr=tz_name();if(defined($zabr) && length($zabr)){$zabr=uc($zabr);}else{$zabr='GMT';}} # if Time::Zone loaded, try to find local abbreV8d name
  else     {for(sort(keys(%_knwntzab))){if($_knwntzab{$_} == $self->{'z'}){$zabr=$_;last;}}} # just match the first alphabetical abbreV8d name in same zone
  if($xpop=~ /a/){my $W="\e\[1;37m"; # eXPand OPtion to enable Ansi color codes in returned string
    return(sprintf("%s%3s$W, %s%02d %s%3s %s%4d %s%02d$W:%s%02d$W:%s%02d %s%s", $dfcl{'Y'},$dofw, $dfcl{'Y'},$self->D, $dfcl{'o'},$mont, $dfcl{'R'},$self->Y,
      $dfcl{'C'},$self->h, $dfcl{'B'},$self->m, $dfcl{'M'},$self->s, $dfcl{'G'},$zabr));
  }else{ #          'Wed, 14 Aug 2013 15:08:07 GMT'
    return(sprintf("%3s, %02d %3s %4d %02d:%02d:%02d %s", $dofw, $self->D, $mont, $self->Yhms, $zabr));}}
sub iso{ # returns a d8 object's ISO 8601 complete string form
  my $self=shift(@_);my $xpop=shift(@_)||'';
  my $cclz=  $self->_field_colors('c'); # load refs to anon color arrays
  my $aclz=  $self->_field_colors('a');my %dfcl=();for(0..@{$cclz}-1){$dfcl{$cclz->[$_]}=$aclz->[$_];} # load c8=>ansi from fields colors d8a
  my $frcp=  $self->p / $self->{'_pps'};$frcp =~s/^0\.//;$frcp.='0' while(length($frcp) < 2);$frcp=substr($frcp,0,2) if(length($frcp) > 2);
  my $zowc=  $self->zone_offset();  $zowc =~s/^([-+]\d\d)(\d\d)$/$1:$2/;
  if($xpop=~ /a/){my $W="\e\[1;37m";my($zosn,$zohh,$zomm)=$zowc =~/^([-+])(\d\d):(\d\d)$/; # eXPand OPtion with Ansi color codes embedded
    return(sprintf("%s%4d$W-%s%02d$W-%s%02d${W}T%s%02d$W:%s%02d$W:%s%02d$W.%s%02d$W%s%s%02d$W:%s%02d", $dfcl{'R'},$self->Y, $dfcl{'o'},$self->M,
      $dfcl{'Y'},$self->D, $dfcl{'C'},$self->h, $dfcl{'B'},$self->m, $dfcl{'M'},$self->s, $dfcl{'p'},$frcp, $zosn, $dfcl{'G'},$zohh, $dfcl{'G'},$zomm));
  }else{ #            '1997-07-16T19:20:30.45+01:00'      # YYYY-MM-DDThh:mm:ss.sTZD
    return(sprintf("%4d-%02d-%02dT%02d:%02d:%02d.%02d%-6s", $self->YMDhms, $frcp, $zowc));}}
sub bak{#H5JM2bMF:`bak`l8st major upd8; 267KBPZA:auto-backup a file into './.bak/' with a -`d8` appended before the extension, or at the end if none
  my $self=shift(@_);my $bcou=0; # K3SM2cwP:migr8ing Pip::Utl.pm->bak() here as d8.pm object method (instead of str8 exported function);
  # 2du:aftr doing `ea` from ~/dvl/c8/simp/ I edited again with just `e` but vim 'B' key for calling `bak` made ~/.bak/-$d8.zshrc instead of normal .zshrc-$d8
  #     ... so I had to  `cd ~/.bak;rename 's/^(-........)(\..*)$/$2$1/' *` to fix those && several others that were much older so fix that in here,
  #   refactor ~/.erc searching code from bak&&e,add -optz lsb LiStBakz,bkd parm2tst isBkDup?,dif w/prev,re[sv] RE(Store|Vert2) prev,ifc 2onlyBakIfSrcCmpilz
  #   forget about $^O OS Type&&`fc.exe`4 MSWin,hndl flnmz =~ /\s/,mk ifc Dflt2not let bak cp unles`perl -c`,tst;
  my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); # at least assume 4NT shell
  my $ttyn = $ENV{'TTY'} || $ENV{'_SHELL'} || '';#$ttyn = shift || '' unless(length($ttyn));
  my $mulf=0;$mulf=1 if(@_ && $#_); # bakng multiple filez flag?
  my $srcf = shift ||  $ENV{'EDTF'} || $ENV{'EDITFILE'} || ''; my $dstf;my $home = $ENV{'HOME'} || '/home/pip';$home =~ s|/+$||;my $cwdr;
  if(length($ttyn)) {
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($srcf))                  { $srcf = $ttyn;     } }
  unless(-d $home . '/.erc') {
    mkdir(  $home . '/.erc', 0700); }
  if(-d $home . '/.erc') {
    my $ercg = $home . '/.erc/eall';      # Global .erc/eall  filelist
    my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTY filelist
    if($osty eq 'good') { $cwdr = `pwd`; }
    else                { $cwdr =  `cd`;
      if($srcf eq  '*') { unshift(@ARGV, $_) for(glob("*.*")); $srcf = shift; } }
    chomp($cwdr);
    my $extn; my @tsts; my $pass; my $pktm = "$self"; #`d8`;#Time::PT->new(); # hopefully just stringifies object instead of needing bak-tik shL 2 d8 or new();
    if(!-r $srcf && -r $ercl && open(ERCL, '<', $ercl)) { chomp($srcf = <ERCL>); close(ERCL); }
    if(!-r $srcf && -r $ercg && open(ERCG, '<', $ercg)) { chomp($srcf = <ERCG>); close(ERCG); }
    die "!*EROR*! Please pass bak a filename to backup!\n" unless(-r $srcf);
    unless(-d '.bak') { mkdir('.bak') || die  "!*EROR*! Couldn't create '.bak' directory!\n"; }
    unless(-w '.bak') {                  die  "!*EROR*! Cannot write to '.bak' directory!\n"; }
    while ( $srcf   ) {
      if(-f $srcf && -r $srcf) { $dstf = $srcf; $extn = '';
        if($dstf =~ s/^(.+)(\..{1,5})$/$1/) { $extn  = $2;   # strip file extension !*Note*! Are there any extensions >5 chars worth supporting? Not so far.
          $extn  = ".tar" . $extn if($dstf =~ s/^\.tar$//);} # special-case to put -d8 before .tar.(gz|bz2|.*) also
        if($dstf =~ /\//) { $dstf =~ s/(.*)\//$1\/.bak\//; } else { $dstf =~ s/^/.bak\//; }
        unless($osty eq 'good') { $srcf =~ s/\//\\/g; $dstf =~ s/\//\\/g; } # kaka dir-separators?
        @tsts = reverse(sort(glob($dstf . "-????????" . $extn))); $pass = 1; # probably eventually better to employ d8-specific sorting
        if(@tsts) { @tsts = @tsts[0..7] if(@tsts > 8); # test last 8 backups for differences before proceeding (originally was just 3)
          for(@tsts) { 
            if($osty eq 'good') { $pass =  `diff --brief $_ $srcf`;
              unless($pass)     { $_    =~ s/^$cwdr[\\\/]//;$srcf =~ s/^$cwdr[\\\/]//;
#                  s/(.*)-(.)(.)(.)(.)(.)(.)(.)(.)/$1-$R$2$O$3$Y$4$G$5$C$6$B$7$M$8$P$9$G/; # better to pass to a8::d8c
#               if( /(.*)-(.{8})/){my $clrd=d8c($2);
#                  s/(.*)-(.{8})/$1-$clrd$z/;} # actually better to just c8fn whole name, but not so easy to do for srcf yet
                $_ = c8fn($_);
                printf("!*EROR*! File: '%-16s already bak'd up as '%s'!\n", $srcf . "'", $_); last;
              }}}}
        if($pass) { $dstf .= "-$pktm" . $extn;    cp($srcf,$dstf);
          if($osty eq 'good'){ $pass = `diff --brief $srcf $dstf`; if(length($pass)){$pass=0;}else{$pass=1;}}
          $srcf =~ s/^$cwdr[\\\/]//;$dstf =~ s/^$cwdr[\\\/]//;
          if(-e $dstf) {
            if( $pass) { $dstf = c8fn($dstf);$bcou++; # SUCCESS! # mAB longstanding quotez around filez below were mainly only there 4 rare spaced out namez
                     printf("${B}bakd$C %-16s$M as %s$z"                , $srcf      , $dstf); print "\n" if($mulf); # trying to add a bit betr color8ion
            } else { printf("!*EROR*! File: '%-16s differs from '%s'!\n", $srcf . "'", $dstf); } # FAILED `diff`
          } else   { printf("!*EROR*! Couldn't bak up: '%-16s as '%s'\n", $srcf . "'", $dstf); } # FAILED output-file-creation or something else
        }
      } $srcf = shift; }
  } else           { print( "!*EROR*! Couldn't find ~/.erc/ at: '$home/.erc/'\n"); } return(''); } # probably just want 2 retn '' or SUCCESS printf nstd?
# d8 object constructor as class method or copy as object method.
# First param can be ref to copy. Not including optional ref from copy, default is no params to crE8 a new d8 object auto-popul8d with now d8a.
# If parameters are supplied, they must either be a lone single detectable string represent8ion or a single key => value pair signifying a supported format.
# The key must be one of the following types of constructor initializ8ion mechanisms:
#    -1) <packedB64InitStringImplies'd8'type> (eg,              'D8FMLTqh') with no key since 'd8' is implied, but other formats should also be detectable
#     0) 'd8'      => <packedB64InitString>   (eg, 'd8'      => '01234567')
#     1) 'array'   => <arrayRef>              (eg, 'array'   => [0, 1, 2..7])
#     2) 'hash'    => <hashRef>               (eg, 'hash'    => {'h' => 8})
#     3) 'expand'  => <expandedInitString>    (eg, 'expand'  => 'Fri Aug 16 14:26:27:12 -0500 2013')
#     4) 'lsft'    => <expandedLSFullTime>    (eg, 'lsft'    => '2013-08-15 12:55:23.833703078 -0500') like output from `ls -l --full-time`
#     5) 'cpan'    => <cpanDateTimeStamp>     (eg. 'cpan'    => 'Wed, 14 Aug 2013 15:08:07 GMT')
#     6) 'iso'     => <iso8601FullDateTime>   (eg. 'iso'     => '1997-07-16T19:20:30.45+01:00') # YYYY-MM-DDThh:mm:ss.sTZD ISO 8601 format
#     7) 'YYYYMMDD'=> <eightDigitDate>        (eg. 'YYYYMMDD'=> '20131231') # This format probably shouldn't be explicit but should be handled through some
#   more general strptime pattern for then parsing constructor strings; Handling arbitrary as well as explicit formats should maybe be dynamically detected in
#   constructors or as composite output formats with field aware coloring or maybe ->expand should become part of ->_stringify which tests new internal
#   present8ion values for configurable output && optional coloring formats;
# Should think what might be the optimal interface to allow any explicit or auto-detected format to be input or output, with optional color encoding.
# For handling more formats better, maybe distinct ones should be placed in their own subroutines && the auto-'d8' should become a matching dispatcher.
sub new{my($nvkr,$ityp,$idat)=@_;my $nobj=ref($nvkr);
  my $clas=$ityp;$clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
  my $self=Octology::d8::fldz->new($clas);my $rgxs;my $mont;my $zfou=0;my($lofs,$hofs,$mofs);my @attz=$self->_attribute_names();
# timelocal($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
  my @ltim=localtime();my $subs=0;if($hirs){$subs=Time::HiRes::time();$subs-=int($subs);}
  my @dayo=Time::DayOfWeek::DayNames  ();for(@dayo){$_=substr($_,0,3) if(length($_)> 3);} # trunc8 to expected uniq 1st 3chrz, if longer
  my @mnth=Time::DayOfWeek::MonthNames();for(@mnth){$_=substr($_,0,3) if(length($_)> 3);}
  for(@attz){if($nobj){$self->{$_}=$nvkr->{              $_};}  # copy if supposed to (because iNvoker OBJect has become a proper ref)
             else     {$self->{$_}=$self->_default_value($_);}} #   or init defaults  (although maybe defaults always just get overridden with now, so ptless?)
  unless($nobj){#print "ltim:@ltim:\n    :s  m  h  Md M Y   Wd Yd isdst\n";
    $self->{'Y'}=$ltim[5]+1900;
    $self->{'M'}=$ltim[4]+   1;
    $self->{'D'}=$ltim[3];
    $self->{'z'}=            0; # '0' GMT +0000 as default zone prior to any detection attempt
    $self->{'h'}=$ltim[2]; #22; # 'M' CDT -0500 was my hard-coded zone before checking Time::Zone methods below
    $self->{'m'}=$ltim[1];
    $self->{'s'}=$ltim[0];
    $self->{'p'}=int($subs*$self->{'_pps'});#$subs*=$self->{'_pps'};$subs-=int($subs); # this would prepare $subs to be used to calcul8 sub-phasses l8r
    if(exists($ENV{'d8tzofst'})){ # let explicit d8 ENVironment variable directly set zone with expected offset format: /^[-+]?[01]?\d(00|30|45)?$/
      $lofs  =$ENV{'d8tzofst'};$lofs=~ s/^(\d)/+$1/;$lofs=~ s/^([-+])(\d)$/${1}0${2}00/;$lofs=~ s/^([-+]\d\d)$/${1}00/;
      if  (exists($_ofst2ndx{$lofs})){$self->{'z'}=$_ofst2ndx{$lofs};$zfou=1;}}
    if(!$zfou && $zown ){$lofs=tz_local_offset(); # if Time::Zone loaded, try to find local offset that matches
      if(defined($lofs)){$hofs=int($lofs/3600);$mofs=int(($lofs-($hofs*3600))/60);$lofs=sprintf("%s%02d%02d",($lofs<0)?'-':'+',abs($hofs),$mofs);
        if(exists($_ofst2ndx{$lofs})){$self->{'z'}=$_ofst2ndx{$lofs};$zfou=1;}}}
    if(!$zfou && exists($ENV{'TZ'})){ # d8tzofst && T::Z failed so try to determine likely offset from TZ hopefully containing abbreviated zone name
      if(exists($_knwntzab{$ENV{'TZ'}})){$self->{'z'}=$_knwntzab{$ENV{'TZ'}};$zfou=1;} # lookup TZ abbrev in KNoWN TimeZone ABbreviations hash
    # else                              { } # TZ probably contains some long name like 'America/Chicago' which I don't know how to lookup usefully yet
    }}
  if(defined($ityp)&& $ityp!~ /::/){ # there were initializ8ion params
    my $bzsf=$self->{'z'}; # Best Zone So Far to reset to if attempted match fails
    $self->{$_}=$self->_default_value($_) for(@attz); # maybe necessary to re-init defaults after now localtime typically popul8d over them?
    unless(defined($idat)){($ityp,$idat)=('d8',$ityp); # rather than slipping in an automatic 'd8' type here, better to detect many types && dispatch instead
    }
    if    ($ityp=~ /^l/i){ # handle 'lsft'   string param as `ls -l --full-time` date &&    time text '2013-08-15 12:55:23.833703078 -0500'
      if($idat=~ /^(\d{4})-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d)(:\d\d|\.\d{9})\s([-+]?\d{1,4})/){
        $self->{'Y'}              =$1;
        $self->{'M'}              =$2;
        $self->{'D'}              =$3;
        $self->{'h'}              =$4;
        $self->{'m'}              =$5;
        $self->{'s'}              =$6;
        $self->{'p'}              =$7;
        $self->{'z'}              =$8;$self->{'z'}=~s/^(\d)/+$1/;$self->{'z'}=~s/^([-+])(\d)$/${1}0${2}00/;$self->{'z'}=~s/^([-+]\d\d)$/${1}00/;
        if(exists($_ofst2ndx{$self->{'z'}})){$self->{'z'}=$_ofst2ndx{$self->{'z'}};}else{$self->{'z'}=$bzsf;} # specified zone offset reset if not found
        if($self->{'p'}=~ /^\./){$self->{'p'}='0'.$self->{'p'};$self->{'p'}=int($self->{'p'}*$self->{'_pps'});}
        else                    {$self->{'p'}=~ s/^://;} # compute phasses from float seconds or just strip colon
      } else{croak "!*EROR*! d8::new 'lsft' initializ8ion type could not be matched with the expected format!\n";}
    }elsif($ityp=~ /^e/i){ # handle 'expand' string param as expanded            date &&/or time text
      $rgxs='^\\s*(('.join('|',@dayo).')\\S*)?\\s*('.
                      join('|',@mnth).')\\S*\\s*(\\d+)'.
             '\\s+(\\d+(\D+(\\d+)){0,3})\\s+([-+]\d{1,4})?\\s*(\d+)\\s*$';
      if($idat=~ /$rgxs/i){
#print "idat:$idat\nrgxs:$rgxs\nDow?$2 Mon$3 dy$4 hr:mn?:sc?:fr?$5 +-zon YEAR!\n";
        $mont                     =$3;
        $self->{ 'D'}             =$4;
        $self->{ 'z'}             =$bzsf;if(defined($8)&& length($8)){$self->{'z'}=$8;$self->{'z'}=~s/^(\d)/+$1/;$self->{'z'}=~s/^([-+])(\d)$/${1}0${2}00/;
          $self->{'z'}=~s/^([-+]\d\d)$/${1}00/;  if(exists($_ofst2ndx{$self->{'z'}})){$self->{'z'}=$_ofst2ndx{$self->{'z'}};}else{$self->{'z'}=$bzsf;}}
        ($self->{'h'},
         $self->{'m'},
         $self->{'s'},
         $self->{'f'})=split(/\D+/,$5);
        $self->{ 'Y'}             =$9;
#print "M:$mont D:$self->{'D'} h:$self->{'h'} m:$self->{'m'} s:$self->{'s'} f:$self->{'f'} z:$self->{'z'} Y:$self->{'Y'}\n";
      }else{
        $rgxs='^\\s*(('.join('|',@dayo).')\\S*)?\\s*('.
                        join('|',@mnth).')\\S*\\s*('.
                   '\\d\\d?)\\s*,?\\s*(\\d{4})\\s*$'; # (Fri)? Dec 19,? 2014
        if($idat=~ /$rgxs/i){
#print "Dow?$2 " if(defined($2));
#print "Mon$3 dy$4 YEAR$5!\n";
          $mont       =$3;
          $self->{'D'}=$4;
          $self->{'Y'}=$5;
        }else{
          $rgxs='^\\s*(\\d{2})(\D+(\\d{2}))?(\D+(\\d{2}))?(\D+(\\d{2}))?\\s*$'; #  18(:02(:16(:32)?)?)?
          if($idat=~ /$rgxs/i){
            $self->{'h'}=$1;
            $self->{'m'}=$3 if(defined($3) && length($3));
            $self->{'s'}=$5 if(defined($5) && length($5));
            $self->{'f'}=$7 if(defined($7) && length($7));
#print "hr:mn?:sc?:fr? - $self->{'h'}:$self->{'m'}:$self->{'s'}:$self->{'f'}!\n";
          }}}
      if(defined($mont)){#convert named month to proper index number
        for(my $i=0;$i<@mnth;$i++){ # find which month name
          if(lc($mont)eq lc($mnth[$i])){
            $self->{'M'}=($i+1); # ($i+1) for 1-based month field
          }}}
    }elsif($ityp=~ /^c/i){my $ilen=length($idat); # 'cpan' => 'Wed, 14 Aug 2013 15:08:07 GMT'
      $rgxs='^\\s*(('.join('|',@dayo).')\\S*)?\\s*(\\d+)\\s*('.
                      join('|',@mnth).')\\S*\\s*(\\d{4})'.
             '\\s+(\\d{2})\D+(\\d{2})\D+(\\d{2})\\s+(\w+)\\s*$';
      if($idat=~ /$rgxs/i){
        $self->{'D'}=$3;
        $mont       =$4;
        $self->{'Y'}=$5;
        $self->{'z'}=$bzsf;if(defined($9)&& length($9)){$self->{'z'}=$9;
                             if(exists($_knwntzab{$self->{'z'}})){$self->{'z'}=$_knwntzab{$self->{'z'}};}else{$self->{'z'}=$bzsf;}}
        $self->{'h'}=$6;
        $self->{'m'}=$7;
        $self->{'s'}=$8;}
      if(defined($mont)){#convert named month to proper index number
        for(my $i=0;$i<@mnth;$i++){ # find which month name
          if(lc($mont)eq lc($mnth[$i])){
            $self->{'M'}=($i+1); # ($i+1) for 1-based month field
          }}}
    }elsif($ityp=~ /^i/i){my $ilen=length($idat); # 'iso' => '1997-07-16T19:20:30.45+01:00') # YYYY-MM-DDThh:mm:ss.sTZD ISO 8601 format
      $rgxs='^\\s*(\\d{4})-(\\d\\d)-(\\d\\d)T(\\d\\d):(\\d\\d):(\\d\\d)\\.(\\d\\d)([-+]\\d\\d:\\d\\d)\\s*$';
      if($idat=~ /$rgxs/i){
        $self->{'Y'}=$1;
        $self->{'M'}=$2;
        $self->{'D'}=$3;
        $self->{'z'}=$bzsf;if(defined($8)&& length($8)){$self->{'z'}=$8;$self->{'z'}=~s/://;
                             if(exists($_ofst2ndx{$self->{'z'}})){$self->{'z'}=$_ofst2ndx{$self->{'z'}};}else{$self->{'z'}=$bzsf;}}
        $self->{'h'}=$4;
        $self->{'m'}=$5;
        $self->{'s'}=$6;
        $self->{'p'}=int($self->{'_pps'} * "0.$7");}
    }elsif($ityp=~ /^d/i){my $ilen=length($idat); # handling main 'd8' format as growing right from Year field through YMDzhmsp
      for(my $i=0;$i<$ilen;$i++){$self->{$attz[$i]}=b10($1) if($idat=~ s/^([0-9A-Za-z._])//);} # break down d8 str from left side && construct field attrz
      $self->{'z'}%=@_tzofsetz; # just modulo wrap zone values that are gr8r than the number of defined offsets
      $self->{'Y'}+=      2000;
    }else{
      for my $attr(@attz){
        if    ($ityp=~ /^a/i){ # 'array'
          $self->{$attr}=shift(@{$idat}) if(@{$idat}); # shift array vals
        }elsif($ityp=~ /^h/i){ # 'hash'
          for(keys(%{$idat})){ # do some searching to find hash key that matches
            if($attr=~ /$_/ ){$self->{$attr}=$idat->{$_} ;
                                      delete($idat->{$_});}}
        }else{ # undetected init type
          croak "!*EROR*! d8::new initializ8ion type: $ityp did not match 'd8', 'array', 'hash', 'expand', 'lsft', 'cpan', or 'iso'!\n";
        }}}}
  for my $attr(@attz){ # re-initialize default values for any fields that have somehow become undefined
    $self->{$attr}=$self->_default_value($attr) unless(defined($self->{$attr}));}
# Handle Year shifts (but maybe this shouldn't always be done, like when init params intend to design8 a huge value in a single field)
  $self->{'Y'} -= 2000;
#   0) Each 13 added to the Month adds  64 to the Year.  # `d8 _eX`   FriJan 1st1745 to `d8 _pV`   MonDec31st2255 (all Midnights)
#   1)      24 added to the Hour  adds 256 to the Year.  # `d8 _eX0O` TueJan 1st1489 to `d8 _pV0O` ThuDec31st2511 (s/O$/lxxx/ for last phass of Year)
#   2)      32 added to the Day   makes the year negative just before adding 2k  # here Day:'W'..'_', above hour:'O'..'l' (up Oh to lo eL)
  # set values back to 0 of last block if off the known end
  $self->{       'M'}  = 39 if($self->{'M'} >            51); # 4 month blocks go 0..51  (0..12, 13..25, 26..38, 39..51)
  $self->{       'D'}  = 32 if($self->{'D'} >            63); #   day   blocks go 0..63  (0..31, 32..63)
  $self->{       'h'} %= 48;   $self->{'m'}%=            60 ; #   hour  blocks go 0..47  (0..23, 24..47)
  $self->{       's'} %= 60;   $self->{'p'}%= 60; #$self->{'_pps'}; #   min,sec,frm all 0..59 normally
  while ($self->{'M'}  > 12  ){$self->{'Y'}+= 64;$self->{'M'}-=13;}
  if    ($self->{'h'}  > 23  ){$self->{'Y'}+=256;$self->{'h'}-=24;}
  if    ($self->{'D'}  > 31  ){$self->{'Y'}*= -1;$self->{'D'}-=32;} $self->{'Y'}+=2000;
  return($self);}
sub subsecond{  my $self=shift(@_);return(           $self->p(@_));}
sub zone_offset{my $self=shift(@_);return($_tzofsetz[$self->z]   );}
sub _mon{       my($self,$nwvl)=@_; # 0-based month
  $self->{'M'}=($nwvl+1) if(@_>1);
  return($self->{'M'}-1);}
sub fullmonth{my($self,$nwvl)=@_;my($mtch,$mret);
  my @mnmz=Time::DayOfWeek::MonthNames();
  if(@_>1){for($mtch=0;$mtch<@mnmz;$mtch++){
      if($mnmz[$mtch]=~ /^$nwvl/i){$self->{'M'}=$mtch+1;last;}}
  }$mret=$mnmz[(($self->{'M'}-1) % 12)];
  return($mret);}
sub monname{ # abbreviated (1st 3 character) month name string
  my $monr=$_[0]->fullmonth();
  if   (@_>2){$monr=$_[ $_[0]->{'M'} ];     }
  elsif(@_>1){$monr=$_[0]->fullmonth($_[1]);}
  $monr=substr($monr,0,3) if(length($monr)>3);
  return($monr);}
sub _year{my($self,$nwvl)=@_; # 1900-based year
  $self->{'Y'}=($nwvl+1900) if(@_>1);
  return($self->{'Y'}-1900);}
sub yy{my($self,$nwvl)=@_;my $yret; # 2-digit year; not sure what yret was useful for (old print Dbugging?)
  if(@_>1){($nwvl>=70)?$self->{'Y'}='19'.$nwvl:
                       $self->{'Y'}='20'.$nwvl;}
  $yret=sprintf("%04d",$self->{'Y'});
  return(substr($self->{'Y'},2,2));}
sub dow      {my($self,$nwvl)=@_;return(Time::DayOfWeek::DoW(      $self->YMD));} # index of day-of-week (&& these gobble nwvl)
sub Dow      {my($self,$nwvl)=@_;return(Time::DayOfWeek::Dow(      $self->YMD));} # abbreV8d day-of-week name
sub DayOfWeek{my($self,$nwvl)=@_;return(Time::DayOfWeek::DayOfWeek($self->YMD));} # full     day-of-week name
sub day_of_week{return(   Dow(@_)      );}
sub _wday      {return(   dow(@_)      );}
sub  wday      {return(   dow(@_)    +1);}
sub  wdayname  {return($_[ $_[0]->wday ]) if(@_>2);
                return(   Dow(@_)      );}
#ub   day      {return(   Dow(@_)      );} # this is commented because d8's day() is better as day-of-month rather than like Time::Piece's day-of-week
sub fullday    {return(   DayOfWeek(@_));}
sub  mday{my($self,$nwvl)=@_;
  $self->{'D'}=$nwvl if(@_>1);
  return($self->{'D'});}
sub   day_of_month{return(mday(@_));}
sub  yday{my($self,$nwvl)=@_;my $summ=0; # compute day of year
  if(@_>1){for(my $m=1;$m<        12;$m++){
      if( ($summ +  days_in($self->Y,$m))>$nwvl){$self->{'M'}=$m;
                                                 $self->{'D'}=$nwvl-$summ;last;}
      else{$summ += days_in($self->Y,$m);}
    }      $summ  =                       $nwvl;
  }else{   for(my $m=1;$m<  $self->M;$m++){
           $summ += days_in($self->Y,$m);}
           $summ += $self->D -1;
  } # the following compares d8's yday calcul8ion above with localtime's && should be migr8d to boundary tests of both
#my @ltdt = localtime(timelocal($self->smhD, $self->_mon, $self->Y));
#print "!EROR!summ:$summ != ltdt:" . $ltdt[-2] . "\n" if($summ != $ltdt[-2]);
#print join('', $self->smhD) . $self->_mon . ($self->Y - 1900) . "\n" .  join('', @ltdt) . "\n";
  return($summ);}
sub day_of_year     {return(yday(     @_));}
#   isdst should be computed by formula when I figure out how so that it won't be restricted by UTC range that localtime expects.
sub isdst{my($self,$nwvl)=@_; # IS Daylight Savings Time? && why even gobble any nwvl if it can't or shouldn't be assigned?
  my @ltdt=localtime(timelocal($self->smhD,$self->_mon,$self->Y)); # need 0-based month as timelocal() param
  return($ltdt[-1]);}
sub daylight_savings{return(isdst(    @_));}
sub cdate           {return(expand(   @_));}
sub compress        {return(stringify(@_));}
sub epoch           {return(0);} # floating point seconds since the epoch
sub tzoffset        {return(0);} # timezone offset in a Time::Seconds (which will need to be used in header) object
sub julian_day      {return(0);} # number of days since Julian period began
sub mjd             {return(0);} # modified Julian date (JD-2400000.5 days)
sub week            {return(0);} # week number (ISO 8601)
sub    is_leap_year {return(0);} # true if it is a leap year
sub month_last_day  {return(days_in($_[0]->YM));} # 28-31
sub DESTROY         {} # do nothing but define in case && to calm warning in test.pl
8;

=encoding utf8

=head1 NAME

Octology::d8 - objects to store a dated instant in time

=head1 VERSION

This document8ion refers to version 0.0 of Octology::d8, which was released on d8VSD8vs.

=head1 SYNOPSIS

  use       Octology::d8;use v5.10;
  my  $d8 = Octology::d8->new();
  say "d8 is: $d8";
  say 'The Day-of-Week today is: ',$d8->dow();

=head1 DESCRIPTION

By default, Octology::d8 stores time descriptions precise to
60ths-of-a-second (0.016667 seconds).

This module has been adapted from the L<Time::Piece> module
written by Matt Sergeant <matt@sergeant.org> && Jarkko
Hietaniemi <jhi@iki.fi>. Octology::d8 inherits base
data structure && object methods from L<Octology::d8::fldz>.
d8 was written to simplify storage && calcul8ion
of encoded, yet distinct && human-readable, time d8a
objects.

This module (Octology::d8) does not replace the standard localtime &&
gmtime functions like L<Time::Piece> but Octology::d8 objects behave
almost identically to L<Time::Piece> objects otherwise (since it
was adapted from... I said that already =) ).

=head1 2DU

=over 2

=item - add Time::Zone stuff to use && match zone field reasonably

=item - upd8 all POD to reflect new year shifts

=item - mk interoperable w/ Time::Seconds objects

=item - export a d8() again with tested new() wrapper && fix all apps to use objs instead of local d8()

=item - flesh out constructor init data parsing && formats supported

=item - consider epoch functions like _epoch([which epoch]) or individuals like _phasses_epoch()

=item - mk d8->new() able to crE8 from different 'epoch' init types

=back

=head1 WHY?

The reason I crE8d d8 was that I have grown so enamored with
Base64 represent8ions of everything around me that I was
compelled to write a simple clock utility ( `d8ok` ) using Base64.
This demonstrated the benefit to be gained from time objects with
distinct fields && configurable precision. Thus, L<Octology::d8::fldz>
was written to be the abstract base class for:

  Octology::d8::dur8  ( crE8s objects which represent dur8ions of time )
      &&
  Octology::d8        ( crE8s objects which represent instants in time )

=head2 HOW?

I've made up some silly sentences as mnemonic devices to help me remember every 4th Base64 character:

  4   ...   8   ...              Morning AM hours are also less than 'C'.
  Can      12   Noon            MonthOfYear will be less or equal to 'C'.
  Goats    16   4 PM
  Keep     20   8 PM
  Oats     24   0 AM Midnight   hourOfDay   will be less     than    'O'.
  Some     28
  Where?   32                   DayOfMonth  will be less     than    'W'.

  Cool    COW (Month hour Day thresholds)
  Guys    Girls
  Keep    Keep
  On      On                   Off
  Sayin'  Sayin'      Sippin'  Sea
  Wassup  We          Water    Water
    36    all
    40    eat         echo
    44    in
    48    many        my
    52    quick       quiet
    56    utility     underground
    60    yards       yard

  The real typical extents for Month,Day,hour MDh are CVN and for minute,second,phass msp are xxx.

  "5AFKPUZejoty": 5 Away From Keyboard, is a PUZzle (Please Use Zipper) to e-jot down y, goes by 5.

  My most useful Base-64 conversion phrase to memorize is the somewhat senseless: "AKUma-eoy BMXing it with COamy on mount FUjy!" picturing the demonic
  Street Fighter character riding a BMX bike with James Comey on Mount Fuji. By taking the main altern8ing case characters in the original string, you get b10
  10,20,30,40,50,60 then 11,22,33,44,55 with 12,24,36,48,60 on mount 15,30,45,60. Each part goes by 10*6, 11*5, 12*5, 15*4. Knowing this and the
  "COW Girls Keep On...SWaeimquy" swimming quietly for every 4 from above after a bit of practice enables pretty quick mental calcul8ion in either direction.

=head1 USAGE

Many of Octology::d8's methods have been patterned after the excellent
L<Time::Piece> module written by Matt Sergeant <matt@sergeant.org>
&& Jarkko Hietaniemi <jhi@iki.fi>.

=head2 new(<InitType>, <InitData>)

Octology::d8's constructor can be called
as a class method to crE8 a brand new object or as an object
method to copy an existing object. Beyond that, new() can
initialize d8 objects several different ways:

  * <packedB64InitStringImplies'd8'>
    e.g., Octology::d8->new('E7UM23JF');
  * 'd8'     => <packedB64InitString>
    e.g., Octology::d8->new('d8'    => '0A1B2C3D');
  * 'list'   => <arrayRef>
    e.g., Octology::d8->new('array' => [0, 1, 2..7]);
  * 'hash'   => <hashRef>
    e.g., Octology::d8->new('hash'  => {'s' => 8, 'Y' => 2003})
  * 'expand' => <expandStr>
    e.g., Octology::d8->new('expand'=>'Wed Jul 30 02:33:58:45 -0500 2014')
  * 'lsft'   => <lsFullTimeStr>
    e.g., Octology::d8->new('lsft'  =>'2013-08-15 12:55:23.833703078 -0500')
  * 'cpan'   => <cpanStr>
    e.g., Octology::d8->new('cpan'  =>'Wed, 14 Aug 2013 15:08:07 GMT')
  * 'iso'    => <isoStr>
    e.g., Octology::d8->new('iso'   =>'1997-07-16T19:20:30.45+01:00')

=head2 colr(<Destin8ionColorTypeFormat>)

This is an object member
which will join Base64 represent8ions of each field that has
been specified in use() && joins them with color-codes or color
escape sequences with formats for varied uses. Currently
available Destin8ionColorTypeFormats are:

  'ANSI'  # e.g., \e[1;32m
  'zsh'   # e.g., %{\e[1;33m%}
  'vim'   # e.g., %1*           # assuming .vimrc has :hi User[1..8] ...
  '4NT'   # e.g., color 09 &

=head2 d8cc(<Destin8ionColorTypeFormat>)

Returns the Octology::c8 color code string approprE8 for d8 d8a.

  Format   Returned color code string
   'k'     the background will change along with the foreground for standard
             time-of day elements (i.e., hmsp on a dark blue background)
   'f'     color codes for the expanded d8 format
             (e.g., colors corresponding to Sun Jan  4 12:41:48:13 -0500 2004)

The following methods allow access to individual fields of
Octology::d8 objects:

  $t->Y  or  $t->year
  $t->M  or  $t->month
  $t->D  or  $t->day
  $t->z  or  $t->zone
  $t->h  or  $t->hour
  $t->m  or  $t->minute
  $t->s  or  $t->second
  $t->p  or  $t->phass

Please see L<Octology::d8::fldz> for further description of field
accessor methods.

After importing this module, when you use localtime or gmtime in a
scalar context, you DO NOT get a special Octology::d8 object like you
would when using L<Time::Piece>. This module relies on a new()
constructor instead. The following methods are available on
Octology::d8 objects though && remain as similar to L<Time::Piece>
functionality as made sense.

  $t->phs                 # also as $t->phass && $t->subsecond
  $t->sec                 # also available as $t->second
  $t->min                 # also available as $t->minute
  $t->hour                # 24 hour
  $t->mday                # also available as $t->day_of_month
  $t->mon                 # 1 = January
  $t->_mon                # 0 = January
  $t->monname             # Feb
  $t->month               # same as $t->mon
                 # *NOTE* The above definition ( of $t->month() ) is
                 # different from the Time::Piece interface which defines
                 # month() the same as monname() instead of mon().
  $t->fullmonth           # February
  $t->year                # based at 0 (year 0 AD is, of course 1 BC)
  $t->_year               # year minus 1900
  $t->yy                  # 2 digit year
  $t->wday                # 1 = Sunday
  $t->_wday               # 0 = Sunday
  $t->day_of_week         # 0 = Sunday
  $t->wdayname            # Tue
  $t->day                 # same as mday
                 # *NOTE* Similar to month() above, I've defined day()
                 # differently from Time::Piece. d8's day() is the
                 # same as mday() instead of wdayname().
  $t->fullday             # Tuesday
  $t->yday                # also available as $t->day_of_year, 0 = Jan 01
  $t->isdst               # also available as $t->daylight_savings

The following functions return a list of the named fields. The
return value can be joined with any desirable delimiter like:

  join(               ':', $t->hms);
  join($t->time_separator, $t->hms);

but the functions also can take a list of parameters to upd8
the corresponding named fields like:

  $t->YMD( 2003, 12, 8 ) # assigns new date of December 8th, 2003 to $t

Following are some useful functions && comments of sample return values:

  $t->hms                 # [12, 34, 56]
  $t->hmsp                # [12, 34, 56, 12]
  $t->time                # same as $t->hmsp

  $t->ymd                 # [2000,  2, 29]
  $t->date                # same as $t->ymd
  $t->mdy                 # [ 2, 29, 2000]
  $t->dmy                 # [29,  2, 2000]
  $t->datetime            # 2000-02-29T12:34:56            (ISO 8601)
  $t->expand              # Tue Feb 29 12:34:56:12 -0500 2000
  $t->cdate               # same as $t->expand
  $t->compress            # same as $t->YMDzhmsp
  "$t"                    # same as $t->compress

  $t->is_leap_year        # true if it is
  $t->month_last_day      # 28-31

  $t->time_separator($s)  # set the default separator (default ":")
  $t->date_separator($s)  # set the default separator (default "-")
  $t->day_list(@days)     # set the default weekdays
  $t->mon_list(@days)     # set the default months

=head2 Local Locales

Both wdayname() && monname() can accept the same list parameter
as day_list() && mon_list() respectively for temporary help with
simple localiz8ion.

  my @days = ( 'Yom Rishone', 'Yom Shayni', 'Yom Shlishi', 'Yom Revi\'i',
               'Yom Khahmishi', 'Yom Hashishi', 'Shabbat' );

  my $hebrew_day = Octology::d8->wdayname(@days);
                 # Octology::d8->monname() can be used similarly

To update the global lists, use:

  Octology::d8::day_list(@days);
    &&
  Octology::d8::mon_list(@months);

=head2 Calcul8ions

d8 object strings (both in normal initializ8ion && printing) grow
left-to-right starting from the Year to specify whatever precision
you need while dur8 objects grow right-to-left from the phass field.

It's possible to use simple addition and subtraction of objects:

  use Octology::d8;
  use Octology::d8::dur8;

  my $cur_d8       = Octology::d8->new(); # YMDzhmsp
  my $one_week     = Octology::d8::dur8->new('700000');
  my $one_week_ago = $cur_d8 - $one_week;

If a calcul8ion is done with a raw string parameter instead of an
instantE8d object, the most likely approprE8 object
constructor is called on it. These init strings must adhere to
the implied 'str' format for auto-creating objects. I aim to
support a much wider array of oper8ions && to make this module
smoothly interoper8 with both L<Time::Piece> && L<Time::Seconds>
someday.

     $cur_d8             = Octology::d8->new();
  my $half_hour_from_now = $cur_d8 + 'U00';

The following are valid (where $t0 and $t1 are Octology::d8 objects
&& $dr is an Octology::d8::dur8 object):

  $t0 - $t1;  # returns Octology::d8::dur8 object
  $t0 - '63'; # returns Octology::d8       object
  $t0 + $dr;  # returns Octology::d8       object

=head2 Comparisons

All normal numerical && string comparisons should work reasonably on
Octology::d8 objects:

  "<",  ">",  "<=", ">=", "<=>", "==" &&  "!="
  "lt", "gt", "le", "ge", "cmp", "eq" and "ne"

=head2 YYYY-MM-DDThh:mm:ss

The ISO 8601 standard defines the date format to be YYYY-MM-DD, and
the time format to be hh:mm:ss (24 hour clock), and if combined,
they should be concatenated with date first and with a capital 'T'
in front of the time.

=head2 Week Number

The ISO 8601 standard specifies that weeks begin on Monday and the first
week of the year is the one that includes both January 4th and the
first Thursday of the year. In other words, if the first Monday of
January is the 2nd, 3rd, or 4th, the preceding days are part of the
final week of the prior year. Week numbers range from 1 to 53.

=head1 NOTES

Whenever individual Octology::d8 attributes are going to be
printed or an entire object can be printed with multi-colors,
the following 8bow mapping should be employed whenever possible:

      D  Year    -> Red
      A  Month   -> Orange
      T  Day     -> Yellow
      E   zone   -> Green
       t  hour   -> Cyan
       i  minute -> Blue
       m  second -> Magenta
       e  phass  -> Purple

Please see the colr() member function in the USAGE section.

There's some weird behavior for d8s crE8d with a zero month
or day field since both are mainly 1-based. I aim to fix all these bugs
but be warned that this issue may be causing some math errors for a bit.

I hope you find Octology::d8 useful.

=head1 CHANGES

Revision history for Perl extension Octology::d8:

=over 2

=item - pAKGvERS  d8VSD8vs

* moved d(ur)?8color subs to a8 && stopped exporting d8cc too to simplify d8 usage && started s/fields/fldz/g && s/(dur8)ion/$1/g

* moved d8cc() from EXPORT_OK to now just be exported by default too

* added exported dur8color() to grow to the left through reversed 8bow colors

* added exported   d8color() to be reverse of Octology::b8::b8color()

* updated license copyright years (already had GPLv3)

* added vim coloring option && s/PipTime/PakTime/gi && made ptcc() only EXPORT_OK explicitly

* changed year shifts to allow meaningful 0-month and 0-day values in any block

=item - 1.2.565EHOV  Sun Jun  5 14:17:24:31 2005

* updated test.pl to work properly with Build.PL as well as Makefile.PL

* updated License, minor version, && precision description

=item - 1.0.42M3ChX  Sun Feb 22 03:12:43:33 2004

* added 4NT option to color codes in Fields && color() members in Frame && PT

* updated POD links && CHANGES chronology

=item - 1.0.41M4cZH  Thu Jan 22 04:38:35:17 2004

* moved pt, fpt, && lspt into bin/ for packaging as EXE_FILES

* added Time::Frame::total_frames method

=item - 1.0.418BGcv  Thu Jan  8 11:16:38:57 2004

* moved Curses::Simp::ptCC into Time::PT::ptcc for PT-specific Simp Color Codes

* created Time::Fields::_field_colors (centralized base class color codes) && updated Frame && PT _color_fields

* added HOW? POD section for mnemonics

=item - 1.0.3CVL3V4  Wed Dec 31 21:03:31:04 2003

* changed PREREQ to not have lib files from this pkg

=item - 1.0.3CQ8ibf  Fri Dec 26 08:44:37:41 2003

* fixed typo && hardcoded path in VERSION_FROM of gen'd Makefile.PL

=item - 1.0.3CNNQHc  Tue Dec 23 23:26:17:38 2003

* combined Fields, Frame, && PT into one pkg

=item - 1.0.3CCA2VC  Fri Dec 12 10:02:31:12 2003

* removed indenting from POD NAME section

=item - 1.0.3CBIQv7  Thu Dec 11 18:26:57:07 2003

* updated test.pl to use normal comments

=item - 1.0.3CB7Vxh  Thu Dec 11 07:31:59:43 2003

* added HTML color option && prepared for release

=item - 1.0.3CA8ipi  Wed Dec 10 08:44:51:44 2003

* built class to inherit from Time::Fields && mimic Time::Piece

=item - 1.0.37VG26k  Thu Jul 31 16:02:06:46 2003

* original version of module derived from `pt` cmd-line utl

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install Octology::d8"`

or uncompress the package && run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::d8 requires:

L<Carp>                  to allow errors to croak() from calling sub

L<Octology::b8>          to handle simple number-base conversion

L<Time::DayOfWeek>       also stores global day && month names

L<Time::DaysInMonth>

L<Octology::d8::fldz>    to provide underlying object structure

L<Octology::d8::dur8>    to represent spans of time

Octology::d8 uses (if available):

L<Time::HiRes>           to provide subsecond time precision

L<Time::Local>           to turn epoch seconds back into a real date

L<Time::Zone>            not utilized yet

=head1 SEE ALSO

L<Octology::d8::dur8>

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
