# H83M3sV4: Octology::p8::psps::gmap.pm crE8d by PipStuart <Pip@CPAN.Org> as "Pip's Screeps Global Map" to make an object like original JavaScript Game.map;
# 2du:fix lodt to save opn[srt] Open(Shard|Room|Terrain)&&only load if diff&&retn to all othr map queries,
#   study WebAPI && add availability flags,add lbst to load full JSON prv8 terrain d8a read from local db file as altern8ive to ported JS gbst function;
package     Octology::p8::psps::gmap;
use strict; use warnings;use utf8;use v5.10;use File::Slurp qw(slurp);
use         Octology::a8;
use         Octology::b8;
#se         Octology::c8; # eventually use c8 && Simp && TkAC for similarly rendering anim8ing interactive interfaces for running the local Game simul8ion
#se         Octology::d8;
use         Octology::p8::psps::cnst; # import all the Global Constants
use         Carp; # below mkdir $HOME/lib/Octology/p8/psps/gmap/(\.tmp|simu|prv8|[sp][01][we][sn])/ for 19 dirs:3 solo,Screeps.com orPtr,shrd0or1,&&WS ES WN EN
my  $VERSION='0.0';my $d8VS='H8SMA8PG';            my $mapd="$ENV{'HOME'}/lib/Octology/p8/psps/gmap";
mkdir  ("$ENV{'HOME'}/lib"                 ,0755) unless(-d "$ENV{'HOME'}/lib"                 ); # mk sure proper lib gmap dirz exist
mkdir  ("$ENV{'HOME'}/lib/Octology"        ,0755) unless(-d "$ENV{'HOME'}/lib/Octology"        ); # betr 2 l8r use auto-mkdir module
mkdir  ("$ENV{'HOME'}/lib/Octology/p8"     ,0755) unless(-d "$ENV{'HOME'}/lib/Octology/p8"     );
mkdir  ("$ENV{'HOME'}/lib/Octology/p8/psps",0755) unless(-d "$ENV{'HOME'}/lib/Octology/p8/psps"); # probably all PTR variantz are same
mkdir  ("$mapd"                            ,0755) unless(-d "$mapd"                            ); #   as live Screeps.com so skip 4now?
for  my  $mdir (qw(.tmp simu prv8  s0ws s0es s0wn s0en  s1ws s1es s1wn s1en)){ # prv8 is probably all like shrd0, W0N0..W10N10 (until mAB admin map Xpansion?)
  mkdir("$mapd/$mdir"                      ,0755) unless(-d "$mapd/$mdir");}
my       @atrz=();my        %dvlz=();
push(    @atrz,'shard'    );$dvlz{$atrz[-1]}={'name'=>'prv8','type'=>'normal','ptr'=>0}; # mAB l8r replace with sepR8 global shard obj queriable thru psps?
push(    @atrz,'worldSize');$dvlz{$atrz[-1]}={'0'=>202,'1'=>102,'8'=>11}; # these should replace WORLD_(WIDTH|HEIGHT) (odd prv8 only has 0..10 WN so far)
sub atrb{@atrz;} # attribute methods and default values
sub dval{my($self,$attr)=@_;$dvlz{$attr};} # probably fine that this just returns undef when attr does not exist?
sub dxtz{my $self=shift(@_);my $rmnm=shift(@_);my @xitz=(undef,undef,undef,undef); # may need2inherit proper server shard info from psps Game obj4map lookup
  if($rmnm=~ /^([WE])(\d+)([SN])(\d+)$/i){my $xdir=$1;my $xnum=$2;my $ydir=$3;my $ynum=$4; # maybe take altern8 compressed b64 RoomName?
    # load local terrain d8a for proper room
    # loop through TOP    '1' row looking for any plains exit to yield ynum+1 in N, -1 in S, or flip on border && ck 4 rm d8a xists at very top of map
    # loop through  RIGHT '3' col looking for any plains exit to yield xnum-1 in W, +1 in E, or flip on border && ck full right
    # loop through BOTTOM '5' row looking for any plains exit to yield ynum-1 in N, +1 in S, or flip on border && ck full left
    # loop through   LEFT '7' col looking for any plains exit to yield xnum+1 in W, -1 in E, or flip on border && ck full bottom
  }else{carp "!*Warn*! gmap dxtz(rmnm) - describeExits(roomName):$rmnm invalid!";return(ERR_INVALID_ARGS);} # mAB retn betr code here && below instead?
  return(@xitz);} # accept room object as altern8ive to just roomName
sub describeExits        {my $self=shift(@_);my $rmnm=shift(@_);my %xitz=(TOP=>undef,RIGHT=>undef,BOTTOM=>undef,LEFT=>undef);my @xtza=$self->dxtz($rmnm);
  if(!@xtza || ($#xtza == 0 && $xtza[0] == ERR_INVALID_ARGS)){                   return(ERR_INVALID_ARGS);}
  $xitz{TOP   }=$xtza[0] if(defined($xtza[0]));
  $xitz{ RIGHT}=$xtza[1] if(defined($xtza[1]));
  $xitz{BOTTOM}=$xtza[2] if(defined($xtza[2]));
  $xitz{  LEFT}=$xtza[3] if(defined($xtza[3]));
  return(%xitz);}
sub findExit             {my $self=shift(@_);my $frrm=shift(@_);my $torm=shift(@_);my %opts=(@_);                               my $rmdr=ERR_INVALID_ARGS;
  # $rmdr=FIND_EXIT_TOP   ;
  # $rmdr=FIND_EXIT_RIGHT ;
  # $rmdr=FIND_EXIT_BOTTOM;
  # $rmdr=FIND_EXIT_LEFT  ;
  # $rmdr=ERR_NO_PATH;
  return($rmdr);} # accept room object or name                                      # %opts can be for findRoute pathfindng
sub findRoute            {my $self=shift(@_);my $frrm=shift(@_);my $torm=shift(@_);my %opts=(@_);my @rout=(); # opts can be routeCallback(rmNm,fromRmNm) func
  return(@rout);}
sub getRoomLinearDistance{my $self=shift(@_);my $rnm0=shift(@_);my $rnm1=shift(@_);my $cntn=shift(@_) || 0;                     my $ldst=ERR_NO_PATH;
  return($ldst);}
sub getTerrainAt         {my $self=shift(@_);my $rmpx=shift(@_);my $rmpy=shift(@_);my $rmnm=shift(@_) || undef;                 my $tran=ERR_INVALID_ARGS;
  if(!defined($rmnm) && $rmpy=~ /^([WE])(\d+)([SN])(\d+)$/i){$rmnm=$rmpy;$rmpy=$rmpx->{'y'};$rmpx=$rmpx->{'x'};} # ck ref RoomPosX also valid RoomPos obj
  return($tran);}
sub getWorldSize         {my $self=shift(@_);my $wsiz; # size from world corners so shard1 rooms from W50S50 to E50N50 would return 102,s0 202,prv8 just 11?
  return($wsiz);}
sub isRoomAvailable      {my $self=shift(@_);my $rmnm=shift(@_);my $shrd=$self->{'shard'}->{'name'};$shrd=~ s/^shard//;my $crnm;my $avai=ERR_INVALID_ARGS;
  # load .md8a file to proper room position && read out avai flag eventually
  return($avai);}
# map object should have describeExits(roomName) returning like { TOP=>'W8N4',RIGHT=>'W7N3',BOTTOM=>'W8N2',LEFT=>'W9N3' } or undef for not found room
#                         && findExit( fromRoom, toRoom, opts) with room names or objects && maybe findRoute() path-finding options
#                                                returning FIND_EXIT_(TOP|RIGHT|BOTTOM|LEFT) or ERR_NO_PATH or ERR_INVALID_ARGS
#                         && findRoute(fromRoom, toRoom, opts) with room names or objects again but opts maybe as routeCallback(roomName, fromRoomName) to
#   calcul8 && return float cost of entering room to prioritize own rooms or avoid others, with findRoute returning route array of form:
#                                   [ { exit => FIND_EXIT_RIGHT , room => 'arena21' },
#                                     { exit => FIND_EXIT_BOTTOM, room => 'arena22' }, ... ] or ERR_NO_PATH
#   then getRoomLinearDistance(roomName1, roomName2, continuous)
#   &&   getTerrainAt(x, y,    roomName) or can take RoomPosition obj instead of x,y && returns plain, swamp, or wall even for otherwise invisible rooms
#   &&   isRoomAvailable(      roomName) for whether you can move a creep into it
# console.log(Game.shard);  from my prv8 yielded: {"name":"my-private-server","type":"normal","ptr":false} # chng name in .../example-mods/player-sandbox.js
# console.log(Game.map.getWorldSize() ); yielded: 12 # if!((gWS-2)%20) quads proly balanced like shrd0 -100..100&&shrd1 -50..50,else prv8 proly just WN 0..10
# console.log(JSON.stringify(Game.gcl)); yielded: {"level":1,"progress":0,"progressTotal":1000000}
# to get the locl auth tokn:`wget -O auth.json --header='Content-Type: application/json' --post-data '{"email":"pipstuart@gmail.com","password":"..."}' 'http://localhost:21025/api/auth/signin'`
# then quickly using the token:`wget -O rm-stat-0-W8N3.json --header='X-Token: $tokn' --header='X-Username: $tokn' 'http://localhost:21025/api/game/room-status?shard=shard0&room=W8N3'` gets status:normal so keep reading directions on how to keep retrieving && properly using the right token to maintain auth for more;
# 2du:stuD how to autom8 getng more d8a 2xtnd md8a fmt hopefully at least for available && novice statz,
#   encode all gd8a in cnst wi prtz&&rolz&&structz,enable extending worldSize to expand border md8a,
#   Xamine (CostMatrix|path).serialize from < 10,plan m8rx&&nvg8,mk astr&&dijk,flesh out intrfacez2mk cm8x&&pthf,strt room wi rpos wrapr ovr [cx]brp,
#   mk strc&&gcpu&&mrkt,bild up psps wi kid objz,try srvr&&sml8&&sd8a,mk Simp&&c8 interactive anim8ing rendererz;
sub wbst{my $self=shift(@_);my $shrd=shift(@_);my $rmnm=shift(@_) ;my $xrnm; # Web-get Base64 Sector Terrain (probably only4 live Screeps.com srvr shrdz 4now)
# `   wget 'HTTPS://Screeps.Com/api/game/room-overview?interval=1&shard=shard0&room=W8N3' -O 'rm-ovrv-0-W8N3.json'   ` # these need User/Pswd auth 1st
# `   wget 'HTTPS://Screeps.Com/api/game/room-status?shard=shard0&room=W8N3'              -O 'rm-stat-0-W8N3.json'   `
  my $sapi='HTTPS://Screeps.Com/api/game/room-terrain?shard=shard';my($xdir,$xsnu,$ydir,$ysnu);my $mpth="$mapd/"; # s1ws s1es s1wn s1en
  if( defined($shrd)){if(!defined($rmnm) && $shrd=~ /^(shard|prv)?([018])-?([WE]\d+[SN]\d+|[0-9A-Za-z._]{3})$/){$shrd=$2;$rmnm=$3;}} # parse out combined pRamz
  if(!defined($shrd)){$shrd=$self->{'shard'}->{'name'};} # 4now inheriting global Game.shard obj in2 gmap obj && Dfltng to that when unspecified
  $shrd=~ s/^(shard|prv)//g;$shrd='8' unless($shrd=~ /^[01]$/);
  if($shrd eq '8'){$mpth.="prv8/";
     $sapi='HTTP://localhost:21025/api/game/room-terrain?shard=prv';}
  if(!defined($rmnm)){ # loop thru quadrantz of chosen or inherited shard first && pick base room of next incomplete sector to wget now
    if($sapi=~    /localhost:21025/){ # if I end up growing my prv8 map dimensionz significantly, will want to replace this with a looping search like below
      if   (!-r   $mpth . cbrn('W0N0'  ) . '.md8a'){$rmnm='W0N0'  ;} # these should check expected file sizes with -s also
      elsif(!-r   $mpth . cbrn('W10N0' ) . '.md8a'){$rmnm='W10N0' ;}
      elsif(!-r   $mpth . cbrn('W0N10' ) . '.md8a'){$rmnm='W0N10' ;}
      elsif(!-r   $mpth . cbrn('W10N10') . '.md8a'){$rmnm='W10N10';}
      else{$sapi='HTTPS://Screeps.Com/api/game/room-terrain?shard=shard';$mpth="$mapd/";$shrd='0';}} # done wi prv8 so fall back on srchng in shrd0 next below
    if($shrd ne '8'){
      for    my   $tshr ($shrd,$shrd ^ 1){ # maybe could just do $shrd,!$shrd here instead of xor? this will need to become 0..maxshard if ever gr8r than 1
        for       $xdir ('W','E'){for($xsnu=0;$xsnu<=int(($self->{'worldSize'}->{$tshr}-2)/2);$xsnu+=10){
            for   $ydir ('S','N'){for($ysnu=0;$ysnu<=int(($self->{'worldSize'}->{$tshr}-2)/2);$ysnu+=10){
                # the only valid sizes should be /^9260?0?$/ so shud also ck -s for these 3 here when already -r && unlink incompletez to start them over
                if(!-r "$mapd/s$tshr" . lc("$xdir$ydir") . '/' . cbrn("$xdir$xsnu$ydir$ysnu") . '.md8a'){
                  $shrd=       $tshr;                          $rmnm ="$xdir$xsnu$ydir$ysnu";last;}}
              last if( defined($rmnm));} last if( defined($rmnm));}
          last     if( defined($rmnm));} last if( defined($rmnm));}}}
  if( defined($rmnm)){$xrnm =$rmnm;$xrnm= xbrn($rmnm) if(length($rmnm) == 3);} # accept compressed base64 room names && auto-eXpand them
  if(!defined($xrnm)){croak "!*EROR*! No next terrain sector found! Croaking out...";}
  if( defined($xrnm) && $xrnm=~ /^([WE])(\d+)([SN])(\d+)$/){($xdir,$xsnu,$ydir,$ysnu)=($1,$2,$3,$4);$xsnu -= ($xsnu % 10);$ysnu -= ($ysnu % 10);
    if($sapi !~   /localhost:21025/){$mpth.="s$shrd" . lc("$xdir$ydir") .'/';}
    open  my $out8,'>&',STDOUT or carp "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
    open  my $sdfh,'>' ,$mpth . cbrn("$xdir$xsnu$ydir$ysnu") . '.md8a'                                   or carp "!*Warn*! Couldn't open  md8a file! $!";
    for   my $ynum ($ysnu..$ysnu+9){
      for my $xnum ($xsnu..$xsnu+9){    my     $lrnm="$xdir$xnum$ydir$ynum"   ;my  $crnm= cbrn($lrnm); # set Loop && Compressed Room NaMes
        unless  (      -r    "$mapd/.tmp/$shrd$lrnm.json" || ($shrd eq '0' && ($xnum > 100 || $ynum > 100)) || ($shrd eq '1' && ($xnum > 50 || $ynum > 50))
                                                         ){say $out8 "wget:  $mapd/.tmp/$shrd$lrnm.json ..."; # chngd abov 2 skip past worldSize edgez
          system("wget -q -O '$mapd/.tmp/$shrd$lrnm.json' '$sapi$shrd&room=$lrnm&encoded=true'"); sleep(2) unless($shrd eq '8');} # mAB need2sleep or miss some
        if      (      -r    "$mapd/.tmp/$shrd$lrnm.json"){ my $jd8a= slurp("$mapd/.tmp/$shrd$lrnm.json" ); carp "!*Warn*! Bad slurp! $!" if(!defined($jd8a));
          if    (defined($jd8a)){my $b_id;my $crtd; # try to quickly detect correct JSON hash d8a in either order below
            if   ($jd8a=~ /"terrain":"([^"]+)",.*?"_id":"([^"]+)"/){$crtd=    cbrt($1) ;$b_id= b64(dec($2));} # prv8 idz only 15 heX charz while
            elsif($jd8a=~ /"_id":"([^"]+)",.*?"terrain":"([^"]+)"/){$b_id= b64(dec($1));$crtd=    cbrt($2) ;} # live idz  are 24 heX charz, so get non-quotez
            if(defined($b_id) && defined($crtd)){
              substr($b_id,0,0,'0' x (16 - length($b_id))) if(length($b_id) < 16); # mk sure any leading zeroes in 24-heX will stil pad 12-bytes 16-b64 96-bits
              printf $sdfh   "  '%3s' => [ '%s',"."\n",       $crnm, $b_id  ; # compile sector from parsing new .tmp/ JSON into formatted SectorD8aFileHandle
              printf $sdfh ' ' x  4 .  "qw( %s"  ."\n",substr($crtd,  0,139); #   of .md8a file (now with each room on 7 linz2strt with name,id,avai on first?)
              printf $sdfh ' ' x  8 .      "%s"  ."\n",substr($crtd, $_,139) for(139,278,417,556);
              printf $sdfh ' ' x  8 .      "%s ) ],\n",substr($crtd,695,139);} #say $out8 "added: $mapd/.tmp/$shrd-$lrnm.json into .md8a sector file.";
            unlink(          "$mapd/.tmp/$shrd$lrnm.json");}}}} # then figurout how2get RoomAvailable d8a thru API too && add flag to first formatted line
    close          $sdfh                                                                                 or carp "!*Warn*! Couldn't close md8a file! $!";
    close          $out8                                                                                 or carp "Can't close duplic8 STDOUT handle: $!";}}
sub prnt{ my $self=shift(@_);my $shrd=shift(@_);my $rmnm=shift(@_);my($crnm,$xrnm); # print room map terrain d8a as colored squares of text
  $shrd='8'    if(!defined($shrd)); # just set defalt shard prv8
  if(defined($shrd)){if(!defined($rmnm) && $shrd=~ /^(shard|prv)?([018])-?([WE]\d+[SN]\d+|[0-9A-Za-z._]{3})$/){$shrd=$2;$rmnm=$3;}} # parse out combined pRamz
  $rmnm='W8N3' if(!defined($rmnm)); # just set easy familiar default room which will be valid in shrd 018 if none provided
  my($tstr,  $tstf)=('', 0 );my $b_id='';  $crnm=$xrnm=$rmnm;  $crnm=cbrn($rmnm) if(length($rmnm) > 3);$xrnm= xbrn($rmnm) if(length($rmnm) == 3);
  if($xrnm=~/^([WE])(\d+)([SN])(\d+)$/){my(  $xdir,$xsnu,$ydir,$ysnu)=($1,$2,$3,$4);$xsnu -= ($xsnu % 10);$ysnu -= ($ysnu % 10); my $rsiz  = 50 ;my @ld8a;
    my $mdir="$mapd/";if($shrd eq '8'){$mdir.='prv8';}else{$mdir.="s$shrd" . lc("$xdir$ydir");}
    open  my $out8,'>&',STDOUT or carp "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
    open  my $sdfh,'<',"$mdir/" . cbrn("$xdir$xsnu$ydir$ysnu") . '.md8a'                                 or carp "!*Warn*! Couldn't open  md8a file! $!";
    while  (<$sdfh>){ # loop through sector map d8a file until finding the proper compressed room name key to flag starting to load the terrain string
      if   (          /^\s*'$crnm'\s*=>\s*\[\s*'([^']+)',/ ){$b_id =$1;               $tstf  =         1     ;}
      elsif( $tstf && /^\s*  (qw\(\s*)?           (\S+)  /x){$tstr.=$2;last if(length($tstr) == int(50*50/3));}} @ld8a= split(//,xbrt($tstr)); # Linear D8a
    close          $sdfh                                                                                 or carp "!*Warn*! Couldn't close md8a file! $!";
    for            (0..$rsiz-1){
      for  my $xndx(0..$rsiz-1){
        if   ($ld8a[$_*$rsiz+$xndx] eq'0'){print $out8 "$K p";}  # Plains
        elsif($ld8a[$_*$rsiz+$xndx] eq'1'){print $out8 "$k w";}  # Wall
        elsif($ld8a[$_*$rsiz+$xndx] eq'2'){print $out8 "$O s";}  # Swamp
        elsif($ld8a[$_*$rsiz+$xndx] eq'3'){print $out8 "$k w";}} # Wall (over Swamp)
      print        $out8 "$Y xrnm$W:$G$xrnm$B b_id$W:$C$b_id$O avai$W:$R?" if($_ == $rsiz-2);
      say          $out8 ''                                            unless($_ == $rsiz-1);}
    close          $out8                                                                                 or carp "Can't close duplic8 STDOUT handle: $!";}}
sub lodt{ my $self=shift(@_);my $shrd=shift(@_);my $rmnm=shift(@_);my($crnm,$xrnm); # just load room map terrain d8a for other methods above to query from
  $shrd='8'    if(!defined($shrd)); # just set defalt shard prv8
  if(defined($shrd)){if(!defined($rmnm) && $shrd=~ /^(shard|prv)?([018])-?([WE]\d+[SN]\d+|[0-9A-Za-z._]{3})$/){$shrd=$2;$rmnm=$3;}} # parse out combined pRamz
  $rmnm='W8N3' if(!defined($rmnm)); # just set easy familiar default room which will be valid in shrd 018 if none provided
  my($tstr,  $tstf)=('', 0 );my $b_id='';  $crnm=$xrnm=$rmnm;  $crnm=cbrn($rmnm) if(length($rmnm) > 3);$xrnm= xbrn($rmnm) if(length($rmnm) == 3);
  if($xrnm=~/^([WE])(\d+)([SN])(\d+)$/){my(  $xdir,$xsnu,$ydir,$ysnu)=($1,$2,$3,$4);$xsnu -= ($xsnu % 10);$ysnu -= ($ysnu % 10); my $rsiz  = 50 ;
    my $mdir="$mapd/";if($shrd eq '8'){$mdir.='prv8';}else{$mdir.="s$shrd" . lc("$xdir$ydir");}
    open    my $sdfh,'<',"$mdir/" . cbrn("$xdir$xsnu$ydir$ysnu") . '.md8a'                               or carp "!*Warn*! Couldn't open  md8a file! $!";
   #if(defined($sdfh)){ # since just carp warning failure above, may need to check if File Handle already closed like set fail flag above or just die nstd?
      while  (<$sdfh>){ # loop through sector map d8a file until finding the proper compressed room name key to flag starting to load the terrain string
        if   (          /^\s*'$crnm'\s*=>\s*\[\s*'([^']+)',/ ){$b_id =$1;               $tstf  =         1     ;}
        elsif( $tstf && /^\s*  (qw\(\s*)?           (\S+)  /x){$tstr.=$2;last if(length($tstr) == int(50*50/3));}}
      close    $sdfh                                                                                     or carp "!*Warn*! Couldn't close md8a file! $!";#}
  }  $tstr= xbrt($tstr) if($tstf);return($tstr);} # should save loaded shard, roomName, && terrainString to test at start so don't reload already stored
# Octology::p8::psps::gmap object constructor as class method or copy as object method. This is planned to be very similar to Screeps global Game.map object.
sub new{my($nvkr,$ityp,$idat)=@_;my $nobj=ref($nvkr);my $clas=$ityp;$clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);my $self=bless({},$clas);
  for my    $attr ($self->atrb()){
    $self->{$attr}=$self->dval($attr);            # init defaults
    $self->{$attr}=$nvkr->{    $attr} if($nobj);} #   && copy if supposed to  # probably need to smarter deep copy shard && worldSize etc. hashes here
  return(   $self);} # maybe shift off @_ then accept init params as probably attribute key,value pairs
sub DESTROY {} # do nothing but define in case && to calm warnings that may arise from tests
8;

=encoding utf8

=head1 NAME

Octology::p8::psps::gmap - Pip's Screeps Global Map class

=head1 VERSION

This document8ion refers to version 0.0 of Octology::p8::psps::gmap, which was released on
.

=head1 SYNOPSIS

  use       Octology::p8::psps::gmap;use v5.10;
  my  $gm = Octology::p8::psps::gmap->new();
 #say "gm is: $gm"; # this could do something with _stringify()

=head1 DESCRIPTION

=head1 2DU

=over 2

=item - flesh out interface

=back

=head1 USAGE

=head2 new()

Octology::p8::psps::gmap's constructor...

=head1 NOTES

I hope you find Octology::p8::psps::gmap useful.

=head1 CHANGES

Revision history for Perl extension Octology::p8::psps::gmap:

=over 2

=item - pAKGvERS  d8VSD8vs

* original version of module based mainly on xbrd.pl script to expand b64 room d8a printed to console.log

=back

=head1 INSTALL

Please run:

  `perl -MCPAN -e "install Octology::p8::psps"`

or uncompress the package && run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::p8::psps::gmap requires:

L<Carp>                      to allow errors to croak() from calling sub

L<Octology::a8>              for autom8d exports of global d8a && functions

L<Octology::b8>              to handle simple number-base conversion

L<Octology::d8>              for compact time stamps

L<Octology::p8::psps::cnst>  for global constants

=head1 SEE ALSO

L<Octology::p8::psps::l8r_subclasses>

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2017, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
