# H7PMBZUM: Octology::p8::psps.pm crE8d by PipStuart <Pip@CPAN.Org> as "PiP'S httpS://ScreePS.com Play Simul8or" in my new p8:"Play simul8ion" namespace;
# .pm: gmap ../(m8rx|nvg8) pthf room rpln mrkt etc.;
# 2du:mk gmap class&&imp all xbrd.pl stuf,strt bilding&&loading all terrain d8a&&tst,mk p8::nvg8 for general path-finding A* && all common l8r varE8ions,
#   autom8 much of JS export && gmap import of all prv8 room terrain as basic db files && plan for sepR8 real server(s)? shards? && PublicTestRealm dbs which
#     new room.pm Room d8a objects can append to once visibility is gained,mAB mk rpos RoomPosition package also inside room.pm since so rel8d&&likely small,
#   then crE8 tst new pthf.pm PathFinder with AStar to gener8 paths in any room map,first with full sort of openlist && tst,then use tabh from:
#     HTTP://PolicyAlmanac.Org/games/aStarTutorial.htm && compress && expand every form of room names, from && to pos XY, range, resulting paths, ids, etc.,
#   just use longer X or Y range Heuristic (Chebyshev vs. Manhattan dist), allow G from costCallback, give pthf full costM8rix object d8a instead of by gmap,
#   add pthf optns like ignore(Creeps|Roads|DestructibleStructures) && ignore && avoid, maxOps limit not 2000 0.001 CPU ops, maxRooms not 16, heurW8 not 1.2,
#   crE8 mrkt.pm Market object to track terminal transactions && resource buy or sell orders with approprE8 prices which account for the transaction cost,
#   imp nvg8 && pthf HTTPS://En.Wikipedia.Org/wiki/Jump_point_search optimiz8ion for A* to be used in Room.findPath && Dijkstra's for pos.findClosestByPath,
#   study && consider implementing nvg8 Swamps (Pochter 2010) node pruning algorithm before applying the above Jump Point Search to further optimize AStar,
#   read more PathFinding articles about optimiz8ions, improved heuristics, altern8ive algorithms, etc. to provide more options for handling special cases,
#   imp at least Greedy BestFirstSearch && maybe also DFS Depth && BFS Breadth FirstSearches,Bidirectional,Iter8iveDeepeningA*,B*,D*,SMA*,etc. as nvg8 optnz,
#   imp tabh ndxz hash optn to test membership && if needing to decrease a value,imp new Splay trees,Skew,Pairing,Fibonacci,&&BinomialHeaps,try Henriksen's,
#   imp for large sizes Calendar,Lazy,&&HOT queues maybe with buckets for small integer priorities,tst && benchmark all,consider othr d8a priority queues,
#     HTTP://Theory.Stanford.Edu/~amitp/GameProgramming/Heuristics.html describes many good optns, add H optn to scale according to cpu.(tickLimit-getUsed),
#     add H optn to slightly break ties by favoring nodes most away from nearest exits && closest to nearest defense towers && test road plans without JPS,
#     add H optn to apply deterministic random tie-break according to XY, add H optn for adding the cross product of the 2 vectors in example "Fudge" method,
#     try method of max str8 then max diags,imp JPS+ && option for altern8 JPS without corner-cut,think about relevant rule changes for all path costs 1,
#     pretty sure that typical JPS pref of earlier diags && needing to check all str8s of diags first is due to sqrt(2) costs so probably needs rule varE8ion,
#   when pthf start or goal nodes are not walkable,add option to compare paths between all walkable neighbors to select least cost,fewest turn points,etc.,
#   crE8 pthf octile dist optn giving str8 direcs cost 10 && diags 14, or altern8ly 1 && 1.414214, && upd8 heuristic accordingly to see how paths could vary,
#   mk a new rpln.pm RoomPlanner to path basic,then wide roads && fully test road paths are faster,extend rpln to strategically decide where first few RCL
#     structures should be constructed,then export compressed plan scripts with d8a && code,tst that prv8 srvr can follow well enough,mAB srch&&plan4all maps,
#   reanalyze API && plan out whether whole new implement8ion of most essential objects makes any sense && is still sufficiently worth attempting to do,
#   implement Game API,write transl8ion from standard API to local compact form to support both,extend to other packages for child objects,write tsts && POD,
#   Game.shard objects wi name for (sim|shard[01]) type normal && ptr bool,upd8 sapi .htm,
#   crE8 Simp rpln plan visualizer with editability prior to export,add Simp anim8ing simul8ion,crE8 similar c8 SDL && Tk AbstractCanvas rendering options,
#     add anim8ing between all useful path possibilities for comparison && maybe tweaking before selection for critical layout like roads plan for each room;
package     Octology::p8::psps; # originally derived from d8.pm to attempt a Perl port of the public Screeps API for offline analysis && online code gener8ion
use strict; use warnings;use utf8;use v5.10;
#equire       Exporter  ;
#se base qw(  Exporter );
#se vars qw( @EXPORT   ); #$AUTOLOAD

#equire     Octology::d8::fldz; # maybe l8r sub-packagez will similarly require && use base psps (which is planned to be akin to Screeps' global Game object)
#equire                        Exporter;
#se base qw(Octology::d8::fldz);#porter);

use         Octology::a8;
use         Octology::b8;
#se         Octology::c8; # eventually use c8 && Simp && TkAC for similarly rendering anim8ing interactive interfaces for running the local Game simul8ion
use         Octology::d8;
use         Octology::p8::psps::cnst; # import all the global CoNSTants
use         Carp;
my  $VERSION='0.0';my $d8VS='H83MGQUC';
#use overload
# q("")  => \&_stringify,
# q(<=>) => \&_cmp_num,
# q(cmp) => \&_cmp_str,
# q(+)   => \&_add,
# q(-)   => \&_sub;
#sub _stringify{ # cat non-zero b64 d8 fields
# my @fdat=$_[0]->YMDzhmsp();
# my @attz=$_[0]->_attribute_names();my $tstr='';my $toob=0; # flag design8ing field too big
# $fdat[0]-=2000; # Year adjustment
# for(@fdat){$toob=1 if($_>63);}
## Reverse Year shifts back into fields
##   0) Each 13 added to the Month adds  64 to the Year.
##   1)      24 added to the Hour  adds 256 to the Year.
##   2)      32 added to the Day   makes the year negative just before adding 2000
# if(   $fdat[0]<   0){$fdat[0]*= -1;$fdat[2]+=32;}
# if(   $fdat[0]>=256){$fdat[0]-=256;$fdat[4]+=24;}
# while($fdat[0]>= 64){$fdat[0]-= 64;$fdat[1]+=13;}
# for(my $i=0;$i<@fdat;$i++){
#   if($toob)                                   {$tstr.=$attz[$i].':'.$fdat[$i];$tstr.=', ' if($i<$#fdat);}
#   else                                        { # verbose above for too big, compressed below for fitting
#     if(defined($fdat[$i])&& length($fdat[$i])){$tstr.=          b64($fdat[$i]);}
#     else                                      {$tstr.=                     ' ';}} # add spaces for any found empty fields
# } return($tstr);}

#sub expand{ # returns a d8 object's expanded string form, although might need even more expanded form for when /^.../ is not unique in Mon or Dow
# my $self=shift(@_);my $xpop=shift(@_)||'';my @mnth;my $dofw='   ';my $mont='   ';
# my $cclz=  $self->_field_colors('c'); # load refs to anon color arrays
# my $aclz=  $self->_field_colors('a');my %dfcl=();for(0..@{$cclz}-1){$dfcl{$cclz->[$_]}=$aclz->[$_];} # load c8=>ansi from fields colors d8a
# if(defined($self)&&      $self->M){
#   $dofw=   $self->Dow if($self->D);
#   @mnth= Time::DayOfWeek::MonthNames();
#   $mont=   $mnth[        $self->M-1];
#   $mont=~ s/^(...).*/$1/;} # keep only 1st 3 chars
# if($xpop=~ /a/){my $W="\e\[1;37m"; # eXPand OPtion to enable Ansi color codes in returned string
#   return(sprintf("%s%3s %s%3s %s%2d %s%02d$W:%s%02d$W:%s%02d$W:%s%02d %s%-5s %s%4d", $dfcl{'Y'},$dofw, $dfcl{'O'},$mont, $dfcl{'Y'},$self->D,
#     $dfcl{'C'},$self->h, $dfcl{'B'},$self->m, $dfcl{'M'},$self->s, $dfcl{'P'},$self->p, $dfcl{'G'},$self->zone_offset, $dfcl{'R'},$self->Y));
# }else{ # maybe eventually support additional coloring schemes for expanded d8 d8a here
#   return(sprintf("%3s %3s %2d %02d:%02d:%02d:%02d %-5s %4d", $dofw, $mont, $self->Dhmsp, $self->zone_offset, $self->Y));}}
## d8 object constructor as class method or copy as object method.
#sub new{my($nvkr,$ityp,$idat)=@_;my $nobj=ref($nvkr);
# my $clas=$ityp;$clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
# my $self=Octology::d8::fldz->new($clas);my $rgxs;my $mont;my $zfou=0;my($lofs,$hofs,$mofs);my @attz=$self->_attribute_names();
## timelocal($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
# my @ltim=localtime();my $subs=0;if($hirs){$subs=Time::HiRes::time();$subs-=int($subs);}
# my @dayo=Time::DayOfWeek::DayNames  ();for(@dayo){$_=substr($_,0,3) if(length($_)> 3);} # trunc8 to expected uniq 1st 3chrz, if longer
# my @mnth=Time::DayOfWeek::MonthNames();for(@mnth){$_=substr($_,0,3) if(length($_)> 3);}
# for(@attz){if($nobj){$self->{$_}=$nvkr->{              $_};}  # copy if supposed to (because iNvoker OBJect has become a proper ref)
#            else     {$self->{$_}=$self->_default_value($_);}} #   or init defaults  (although maybe defaults always just get overridden with now, so ptless?)
# unless($nobj){#print "ltim:@ltim:\n    :s  m  h  Md M Y   Wd Yd isdst\n";
#   $self->{'Y'}=$ltim[5]+1900;
#   $self->{'M'}=$ltim[4]+   1;
#   $self->{'D'}=$ltim[3];
#   $self->{'z'}=            0; # '0' GMT +0000 as default zone prior to any detection attempt
#   $self->{'h'}=$ltim[2]; #22; # 'M' CDT -0500 was my hard-coded zone before checking Time::Zone methods below
#   $self->{'m'}=$ltim[1];
#   $self->{'s'}=$ltim[0];
#   $self->{'p'}=int($subs*$self->{'_fps'});#$subs*=$self->{'_fps'};$subs-=int($subs); # this would prepare $subs to be used to calcul8 sub-frames l8r
#   if(exists($ENV{'d8tzofst'})){ # let explicit d8 ENVironment variable directly set zone with expected offset format: /^[-+]?[01]?\d(00|30|45)?$/
#     $lofs  =$ENV{'d8tzofst'};$lofs=~ s/^(\d)/+$1/;$lofs=~ s/^([-+])(\d)$/${1}0${2}00/;$lofs=~ s/^([-+]\d\d)$/${1}00/;
#     if  (exists($_ofst2ndx{$lofs})){$self->{'z'}=$_ofst2ndx{$lofs};$zfou=1;}}
#   if(!$zfou && $zown ){$lofs=tz_local_offset(); # if Time::Zone loaded, try to find local offset that matches
#     if(defined($lofs)){$hofs=int($lofs/3600);$mofs=int(($lofs-($hofs*3600))/60);$lofs=sprintf("%s%02d%02d",($lofs<0)?'-':'+',abs($hofs),$mofs);
#       if(exists($_ofst2ndx{$lofs})){$self->{'z'}=$_ofst2ndx{$lofs};$zfou=1;}}}
#   if(!$zfou && exists($ENV{'TZ'})){ # d8tzofst && T::Z failed so try to determine likely offset from TZ hopefully containing abbreviated zone name
#     if(exists($_knwntzab{$ENV{'TZ'}})){$self->{'z'}=$_knwntzab{$ENV{'TZ'}};$zfou=1;} # lookup TZ abbrev in KNoWN TimeZone ABbreviations hash
#   # else                              { } # TZ probably contains some long name like 'America/Chicago' which I don't know how to lookup usefully yet
#   }}
# if(defined($ityp)&& $ityp!~ /::/){ # there were initializ8ion params
#   my $bzsf=$self->{'z'}; # Best Zone So Far to reset to if attempted match fails
#   $self->{$_}=$self->_default_value($_) for(@attz); # maybe necessary to re-init defaults after now localtime typically popul8d over them?
#   # ...
# }
# for my $attr(@attz){ # re-initialize default values for any fields that have somehow become undefined
#   $self->{$attr}=$self->_default_value($attr) unless(defined($self->{$attr}));}
## Handle Year shifts (but maybe this shouldn't always be done, like when init params intend to design8 a huge value in a single field)
# $self->{'Y'} -= 2000;
##   0) Each 13 added to the Month adds  64 to the Year.
##   1)      24 added to the Hour  adds 256 to the Year.
##   2)      32 added to the Day   makes the year negative just before adding 2k
# # set values back to 0 of last block if off the known end
# $self->{       'M'}  = 39 if($self->{'M'} >            51); # 4 month blocks go 0..51  (0..12, 13..25, 26..38, 39..51)
# $self->{       'D'}  = 32 if($self->{'D'} >            63); #   day   blocks go 0..63  (0..31, 32..63)
# $self->{       'h'} %= 48;   $self->{'m'}%=            60 ; #   hour  blocks go 0..47  (0..23, 24..47)
# $self->{       's'} %= 60;   $self->{'p'}%= 60; #$self->{'_pps'}; #   min,sec,frm all 0..59 normally
# while ($self->{'M'}  > 12  ){$self->{'Y'}+= 64;$self->{'M'}-=13;}
# if    ($self->{'h'}  > 23  ){$self->{'Y'}+=256;$self->{'h'}-=24;}
# if    ($self->{'D'}  > 31  ){$self->{'Y'}*= -1;$self->{'D'}-=32;} $self->{'Y'}+=2000;
# return($self);}

# cpu limit below may start at 30 && would increase limits by 10 with each gcl upgrade, up to 300 max, but it seems that without purchasing a subscription,
#   after H82 my limit will stay capped at 10 regardless of gcl, so I'm planning to just expect limit is 10 permanently (since I might not be ready to spawn
#   in the real servers within the next week anyway). I assume l8r ticks will still need to fill bucket with unused up to 10000 max && tickLimit up to 500.
# gcl assumed to start at 1 && progressTotal should be escal8ing point scale like CONTROLLER_LEVELS (200,45000,135000,405000,1215000,3645000,10935000) && I
#   think progress may increase identically with every upgradeController RCL amount. mAB GCL_(POW|MULTIPLY|NOVICE) tell something about these in server source.
my @_atrz=();
my %_dvlz=();
push(     @_atrz,'constructionSites');$_dvlz{$_atrz[-1]}={ }; # will hold all id   => obj
push(     @_atrz,'cpu'              );$_dvlz{$_atrz[-1]}={'limit'=>10,'tickLimit'=>10,       'bucket'=>0}; # mAB l84 replace with new cpu obj
push(     @_atrz,'creeps'           );$_dvlz{$_atrz[-1]}={ }; # will hold all name => obj
push(     @_atrz,'flags'            );$_dvlz{$_atrz[-1]}={ }; # will hold all name => obj
push(     @_atrz,'gcl'              );$_dvlz{$_atrz[-1]}={'level'=> 1, 'progress'=> 0,'progressTotal'=>0}; # mAB l84 replace with new gcl obj
push(     @_atrz,'map'              );$_dvlz{$_atrz[-1]}={ }; # will hold global world map obj && l8r load all manually exported rooms d8a rel8ively
push(     @_atrz,'market'           );$_dvlz{$_atrz[-1]}={ }; # will hold global in-game market obj
push(     @_atrz,'resources'        );$_dvlz{$_atrz[-1]}={SUBSCRIPTION_TOKEN=>0}; # will hold global resources bound to account, && for all RESOURCE_*=>amount
push(     @_atrz,'rooms'            );$_dvlz{$_atrz[-1]}={ }; # will hold all name => obj for those visible (which contain creep or owned structure)
push(     @_atrz,'spawns'           );$_dvlz{$_atrz[-1]}={ }; # will hold all name => obj for those owned in all visible rooms
push(     @_atrz,'structures'       );$_dvlz{$_atrz[-1]}={ }; # will hold all id   => obj
push(     @_atrz,'time'             );$_dvlz{$_atrz[-1]}=  0; # auto-incremented tick counter
push(     @_atrz,'cpu.getUsed'      );$_dvlz{$_atrz[-1]}=0.0; # should l8r become cpu obj method returning float of used since beginning of current tick
sub _atrb{@_atrz;} # methods
sub _dval{my($self,$attr)=@_;$_dvlz{$attr};}
sub getObjectById{
  my $self=shift(@_);my $obid=shift(@_)|| return(undef);my $obje=undef; # replace with correct obj from id lookup within visible rooms
  return($obje); }
sub notify{
  my $self=shift(@_);my $mesg=shift(@_)||'';my $grpi=shift(@_)||0;substr($mesg,1000,(length($mesg)-1000),'') if(length($mesg) > 1000);
  if($grpi == 0){ # e-mail out notific8ion immeD8ly
  }else{ # w8 grpi minutes before mailing out all grouped by then
  }}
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
# market object then has 4 properties && 8 methods to deal with

# to do this stuff, I'm probably going to need to isol8 a constants package first which all l8r can use, then next complete packages defining all the above
#   needed objects before specifying the main psps Game object, which has them all as correct instances
# so should they all be sepR8d out as distinct .pm files or will defining them all at the top here work well enough && not become unmanageably long?
# probably need to find && study actual l8st Screeps priv8 server code from GitHub in order to adequ8ly answer that && many other undocumented questions

# Octology::p8::psps object constructor as class method or copy as object method. This is planned to be very similar to Screeps global top-level Game object.
sub new{
  my($nvkr,$ityp,$idat)=@_;
  my $nobj=ref($nvkr);
  my $clas=$ityp;
  $clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
  my $self=bless({},$clas);
  for my $attr    ($self->_atrb()){
    $self->{$attr}=$self->_dval($attr);       # init defaults
    $self->{$attr}=$nvkr->{$attr} if($nobj);} #   && copy if supposed to
  if(defined($ityp)&& $ityp!~ /::/){ # there were init params with no colon (classname)
#   ($ityp,$idat)=('str',$ityp) unless(defined($idat));
#   for my $attr($self->_attribute_names()){
#     if    ($ityp=~ /^s/i){ # 'str'
#       $self->{$attr}=b10($1) if($idat=~ s/^(.)//); # break down string
#     }elsif($ityp=~ /^l/i){ # 'array'
#       $self->{$attr}=shift(@{$idat}) if(@{$idat}); # shift array vals
#     }elsif($ityp=~ /^h/i){ # 'hash'
#       # do some searching to find hash key that matches
#       for(keys(%{$idat})){
#         if($attr=~ /$_/){
#           $self->{$attr}=$idat->{$_};
#           delete($idat->{$_});}}
#     }else{croak "!*EROR*! Octology::d8::fldz::new initialization type: $ityp did not match 'str', 'array', or 'hash'!\n";}} # undetected init type
  }return($self);}
sub DESTROY         {} # do nothing but define in case && to calm warnings that may arise from tests
8;

=encoding utf8

=head1 NAME

Octology::p8::psps - PiP'S ScreePS Perl Simul8or

=head1 VERSION

This document8ion refers to version 0.0 of Octology::p8::psps, which was released on
.

=head1 SYNOPSIS

  use       Octology::p8::psps;use v5.10;
  my  $ps = Octology::p8::psps->new();
 #say "ps is: $ps"; # this could do something with _stringify()

=head1 DESCRIPTION

=head1 2DU

=over 2

=item - flesh out interface

=back

=head1 USAGE

=head2 new()

Octology::p8::psps' constructor...

=head1 NOTES

I hope you find Octology::p8::psps useful.

=head1 CHANGES

Revision history for Perl extension Octology::p8::psps:

=over 2

=item - pAKGvERS  d8VSD8vs

* original version of module based mainly on d8

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install Octology::p8::psps"`

or uncompress the package && run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::p8::psps requires:

L<Carp>                  to allow errors to croak() from calling sub

L<Octology::a8>          for autom8d exports of global d8a && functions

L<Octology::b8>          to handle simple number-base conversion

L<Octology::d8>          for compact time stamps

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
