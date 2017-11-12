# H92MLLRe: Octology::p8::nvg8.pm crE8d by PipStuart <Pip@CPAN.Org> to be a class for my general path-finding implement8ions of A*, Dijkstra's, GBFS, etc.;
# 2du:try Simp nstd of prnt,try2add JumpPointSearch optn,gbfs:strt dedic8d GreedyBestFirstSearch,dijk:consider how algorithm can know closest goal reachd
#     (proly need target struct wi full Room obj more complex than just terrain),mk bNchmRk,try othr PerlModulez,mk FiboHeap,Splay|CalendarTree,&&HOTQueue;
package     Octology::p8::nvg8;
use strict;use warnings;use utf8;use v5.10;
use         Octology::a8;
use         Octology::p8::m8rx;
use         Octology::p8::tabh;
use         Octology::p8::psps::cnst;
use         Curses::Simp;
my  $VERSION ='0.0';my $d8VS='HBCL4vg8';
my       @atrz=()  ;my      %dvlz=()   ; # setup default nvg8 object attributes && values
push(    @atrz,'m8xo'     );$dvlz{$atrz[-1]}=     undef; # this should get loaded with a m8rx object from new calling lodm
#ush(    @atrz,'widt'     );$dvlz{$atrz[-1]}=ROOM_WIDTH; # should l8r probably add things like jpsf JumpPointSearchFlag, hscl HeuristicSCaLe float, etc.
#ush(    @atrz,'fill'     );$dvlz{$atrz[-1]}=         2;
sub atrb{@atrz;} # attribute methods to query defaults
sub dval{my($self,$attr)=@_;$dvlz{$attr};} # should be able to pass undefined shrn on thru both m8rx && gmap lodt calls below to just get default '8W8N8',wasN3
sub lodm{my $self= shift(@_);my $shrn= shift(@_);$self->{'m8xo'}= Octology::p8::m8rx->new();return($self->{'m8xo'}->lodt($shrn));} # very basic LOaD M8rix
sub astr{my $self= shift(@_);my $frxy= shift(@_);my $toxy= shift(@_);               my($fr_x,$fr_y,$to_x,$to_y); # take either cmprSd b64 xy rpos or x,y, x,y
  $self->lodm() unless(exists($self->{'m8xo'})); # try to load default map room terrain if not done already
  if(@_ >= 2 && $frxy=~ /^\d\d?$/ && 0 <= $frxy && $frxy < $self->{'m8xo'}->{'widt'} &&
                $toxy=~ /^\d\d?$/ && 0 <= $toxy && $toxy < $self->{'m8xo'}->{'hite'}){($fr_x,$fr_y,$to_x,$to_y)=($frxy,$toxy,shift(@_),shift(@_));}
  elsif(defined($frxy) && $frxy=~ /^[0-9A-Za-n][0-9A-Za-n]$/ &&
        defined($toxy) && $toxy=~ /^[0-9A-Za-n][0-9A-Za-n]$/ ){     ($fr_x,$fr_y)=xbrp($frxy);    ($to_x,$to_y)= xbrp( $toxy);}
  if   (defined($fr_x) && defined($fr_y) && defined($to_x)&& defined($to_y)){ # might want to also verify that from && to are not within walls or unwalkable?
    my @tabh;my $tbho=tie(@tabh,'Octology::p8::tabh');my $rang= rang($fr_x,$fr_y,$to_x,$to_y); # altho pathing from Spawn 2 Cntrlr both unwalkable&&need rang!
    $frxy= "$sb64[$fr_x]$sb64[$fr_y]";             # cnst:rang is Chebyshev distance Heuristic
    my %open=($frxy => 1);my %cloz=();my %prnz=();
    my %gcst=($frxy => $self->{'m8xo'}->{'m8rx'}->[$fr_x][$fr_y][1]);
    push (@tabh,[$gcst{$frxy},$frxy]);
    while(@tabh && ($sb10{substr($tabh[0][1],0,1)} != $to_x ||
                    $sb10{substr($tabh[0][1],1,1)} != $to_y)){my @tpxy= split(//,$tabh[0][1]);shift(@tabh);my @neig; # save ToP&&CURrentXY
                                                              my($curx,$cury)=($sb10{$tpxy[0]},$sb10{$tpxy[1]});
      delete($open{"$tpxy[0]$tpxy[1]"} ); # rm  current from open
      $cloz{       "$tpxy[0]$tpxy[1]"}=1; # add current  to  cloz
      if       ($cury >                           0){ # these should just load up all non-wall neighbors to then loop through below
        if     ($curx >                           0){ # remember should also be able to do $self->{'m8xo'}->get($curx,$cury,1) instead
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx  ][$cury-1][1] < 255){push(@neig, $sb64[$curx  ] . $sb64[$cury-1]);}   #  N
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx-1][$cury-1][1] < 255){push(@neig, $sb64[$curx-1] . $sb64[$cury-1]);}   # WN
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx-1][$cury  ][1] < 255){push(@neig, $sb64[$curx-1] . $sb64[$cury  ]);}}  # W
        if     ($curx < $self->{'m8xo'}->{'widt'}-1){
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx+1][$cury-1][1] < 255){push(@neig, $sb64[$curx+1] . $sb64[$cury-1]);}   # EN
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx+1][$cury  ][1] < 255){push(@neig, $sb64[$curx+1] . $sb64[$cury  ]);}}} # E
      if       ($cury < $self->{'m8xo'}->{'hite'}-1){
        if     ($curx < $self->{'m8xo'}->{'widt'}-1){
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx+1][$cury+1][1] < 255){push(@neig, $sb64[$curx+1] . $sb64[$cury+1]);}   # ES
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx  ][$cury+1][1] < 255){push(@neig, $sb64[$curx  ] . $sb64[$cury+1]);}}  #  S
        if     ($curx >                           0){
          if   ($self->{'m8xo'}->{'m8rx'}->[$curx-1][$cury+1][1] < 255){push(@neig, $sb64[$curx-1] . $sb64[$cury+1]);}}} # WS
      for my $nkey(@neig){my $cost=$gcst{"$tpxy[0]$tpxy[1]"};my($neix,$neiy)= split(//,$nkey);$neix=$sb10{$neix};$neiy=$sb10{$neiy};
        $cost+= $self->{'m8xo'}->{'m8rx'}->[$neix  ][$neiy  ][1];
        if( exists($open{$nkey}) && $cost < $gcst{$nkey}){
          delete  ($open{$nkey});} # rm neighbor from open since new path is betr
        if( exists($cloz{$nkey}) && $cost < $gcst{$nkey}){
          delete  ($cloz{$nkey});} # rm neighbor from cloz (this should never happen, unless using an inconsistent inadmissible heuristic)
        if(!exists($open{$nkey}) &&
           !exists($cloz{$nkey})){ # nw neighbor not in either open or cloz yet, so open it up with G cost, track parent, && push to Tied Array Binary Heap
          $open{         $nkey}=     1; # implementing some tie-breaking options to adjust G or H feeding into Fcst here
          $gcst{         $nkey}= $cost; my $fcst=   $cost;#+rang($neix,$neiy, $to_x,$to_y); # most basic loading FCoST = G + H
          $prnz{         $nkey}="$tpxy[0]$tpxy[1]";
                                          #$fcst=   $cost + rang($neix,$neiy, $to_x,$to_y)*1.01; # H*=(1.0+p) wi p=1/1000 or 1/100
          # try some deterministic rand numb like coordin8 hash added to (or betr subtractd from?) H
          my $dxct=$neix-$to_x;my $dyct=$neiy-$to_y; # try str8 line to goal wi dx && dy from cur to to && from from to to for vector cross-product
          my $dxft=$fr_x-$to_x;my $dyft=$fr_y-$to_y;my $cros= abs($dxct*$dyft - $dxft*$dyct);
                                           $fcst=   $cost + rang($neix,$neiy, $to_x,$to_y) + $cros*0.001;
          # try to minimize turns  #if(@tabh == 29){$tbho->prnt();sleep(8);} # try to view what tie-breaks are doing to the heap tree
          push(@tabh,[$fcst,$nkey]);}}} # try to detect search failure with no goal toky to be found in parentz hash
    my $toky="$sb64[$to_x]$sb64[$to_y]";my @path;my $xsps=''; # then should be able to reconstruct reverse path from goal to strt following prnz pointerz
    my $frky="$sb64[$fr_x]$sb64[$fr_y]";my %pthk;my($prvx,$prvy)=($fr_x,$fr_y); # unshift path to ordr from strt to to goal&&pthk shud have just node kyz
    while(exists($prnz{$toky}) && $toky ne $frky){unshift(@path,$toky);$toky=$prnz{$toky};$pthk{$toky}=1;} delete($pthk{$frky}) if(exists($pthk{$frky}));
    for(0..$#path){my @tpxy= split(//,$path[$_]);my($curx,$cury)=($sb10{$tpxy[0]},$sb10{$tpxy[1]});$self->{'m8xo'}->set($curx,$cury,$_+1);
      $xsps.= sprintf("%02d%02d",$curx,$cury) unless(length($xsps)); # start eXpanded Serialized Path String with next tile pos
      if   ($prvx == $curx && $prvy >  $cury){$xsps.='1';}elsif($prvx == $curx && $prvy <  $cury){$xsps.='5';} # these all should match the direction constants
      elsif($prvx <  $curx && $prvy >  $cury){$xsps.='2';}elsif($prvx >  $curx && $prvy <  $cury){$xsps.='6';} #   which go into serialized paths
      elsif($prvx <  $curx && $prvy == $cury){$xsps.='3';}elsif($prvx >  $curx && $prvy == $cury){$xsps.='7';} # last upd8 prev coordin8s B4 next loop iter8ion
      elsif($prvx <  $curx && $prvy <  $cury){$xsps.='4';}elsif($prvx >  $curx && $prvy >  $cury){$xsps.='8';} ($prvx,$prvy)=($curx,$cury);}
    open   my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
    print     $out8 S('Wk');my $d=S('d'); # display all l8r Foreground colrz on a dark background (unless using ReveRse SGR code) && mk oliveDrab for swamps
    for    my $yndx       (0 ..  $self->{'m8xo'}->{'hite'}-1){
      for  my $xndx       (0 ..  $self->{'m8xo'}->{'widt'}-1){
#       my    $mxy1=             $self->{'m8xo'}->{'m8rx'}->[$xndx][$yndx][1];$mxy1=int($mxy1 / 4) if($mxy1 > 63); # load M8rix X,Y from terrain layer 1
#       if   ($mxy1 <=  2){print $out8 $K,'p';} # nstd of always dividing terrain cost by 4, now only doing so if above 63 so 8-bit valz can fit in 6 to print
#       elsif($mxy1 <= 10){print $out8 $d,'s';} # this should let m8rx tfil of plains be just 1 or 2 for swamps to be 5 or 10 && only walls should really drop
#       elsif($mxy1 >= 63){print $out8 $k,'w';} #   print  $out8  $sb64[$mxy1]; # now showing terrain type letters again instead of cost value from here
#       if   ($xndx == $fr_x  && $yndx == $fr_y   ){print  $out8 "$G%" ;}  # append single colored character for from && to tiles
#       elsif($xndx == $to_x  && $yndx == $to_y   ){print  $out8 "$R#" ;}  #   && show found astr path ndxz as bright valuez
#       elsif($self->{'m8xo'}->get($xndx,$yndx)   ){print  $out8 "$Y",$sb64[$self->{'m8xo'}->get($xndx,$yndx) % 64];} # let long path ndxz wrap around b64
#       else                                       {print  $out8   " " ;}} #   && just a blank space for all others for now
        my    $mxy1=             $self->{'m8xo'}->{'m8rx'}->[$xndx][$yndx][1];$mxy1=int($mxy1 / 4) if($mxy1 > 63); # load M8rix X,Y from terrain layer 1
        if   ($mxy1 <=  2){print $out8 S('Fb:k0'),'p';}
        elsif($mxy1 <= 10){print $out8 S('Fb:kg'),'s';}
        elsif($mxy1 >= 63){print $out8 S('Db:bk'),'w';}
        if   ($xndx == $fr_x  && $yndx == $fr_y   ){print  $out8 S('Gb'),"%" ;}  # append single colored character for from && to tiles
        elsif($xndx == $to_x  && $yndx == $to_y   ){print  $out8 S('Rb'),"#" ;}  #   && show found astr path ndxz as bright valuez
        elsif($self->{'m8xo'}->get($xndx,$yndx)   ){print  $out8 S('Yb'),"",$sb64[$self->{'m8xo'}->get($xndx,$yndx) % 64];}
        else                                       {print  $out8   " " ;}} #   && just a blank space for all others for now
      if     ($yndx <  $self->{'m8xo'}->{'hite'}-4){say    $out8     '';}
      elsif  ($yndx <  $self->{'m8xo'}->{'hite'}-3){printf $out8 "$C%s\n"     ,$self->{'m8xo'}->{'tsrn'};}  # 4th to last line should show shrd && roomname
      elsif  ($yndx <  $self->{'m8xo'}->{'hite'}-2){printf $out8 "$G%2d,%-2d\n"      ,$fr_x,$fr_y       ;}  # 3rd && 2nd to last end with from x,y
      elsif  ($yndx <  $self->{'m8xo'}->{'hite'}-1){printf $out8 "$R%2d,%-2d $Y%2d\n",$to_x,$to_y, $rang;}  #                          &&   to x,y && range
      else                                         {printf $out8 "$W%s"              ,substr($xsps,0,58);}} # last line has eXpandedSerializedPathString
    for(0..$#path){my @tpxy= split(//,$path[$_]);my($curx,$cury)=($sb10{$tpxy[0]},$sb10{$tpxy[1]});$self->{'m8xo'}->set($curx,$cury,0);} # reset layr 0 ndxz
    close     $out8             or die "Can't close duplic8 STDOUT handle: $!";return($xsps);}} # also returned path str from the method
# Octology::p8::nvg8 object constructor as class method or copy as object method. First param can be ref to copy. Not including optional ref from copy,
#   default is no params to crE8 a new empty nvg8 object. If params are supplied, they must be hash key => value pairs.
sub new{my($nvkr,$cora)= @_;my $clas=$cora;my $pkgn= __PACKAGE__ ;my($attr,$ival); # not shifted: iNVoKeR, Class OR Attrkey, CLASs, l8r ATTRibute && InitVALue
  if   (!defined($cora) || $cora !~ /::/){$clas= ($nvkr->isa($pkgn)) ? $pkgn : $nvkr;} my $self=bless({},$clas); # ClassORAttrkey not valid CLASs, so need2set
  for       $attr ($self->atrb()){     # init defaults...  # below strict error trying to use pkgn as hashref (from nvkr?)
    $self->{$attr}=$self->dval($attr); #   but should also deep copy below if new was called from nvkr
    $self->{$attr}=$nvkr->{    $attr} if($nvkr !~ /::/ && $nvkr->isa($pkgn) && exists($nvkr->{$attr}));}
  if($nvkr->isa($pkgn)){shift(@_);}        shift(@_); # these should always just void shift off the already determined class name && maybe invoker if copying
  while(@_){$attr =     shift(@_); # accept additional constructor params to override defaults
    if (@_ && exists($dvlz{$attr})){$ival= shift(@_);$self->{$attr}=$ival;}} # probably l8r will want to sanity check for valid init types && values here
  $self->lodm(); # load actual default terrain d8a into attribute of m8rx object m8xo
  return(   $self);}
8;

=encoding utf8

=head1 NAME

Octology::p8::nvg8 - general path-finding NaViG8ion objects

=head1 VERSION

This document8ion refers to version 0.0 of Octology::p8::nvg8, which was released on
.

=head1 SYNOPSIS

  use utf8;use v5.10;use Octology::p8::nvg8; # maybe just give nvg8 new a gmap roomName to internally load with gmap into m8rx to then call astr member on
  my @tabh; # tied array && basic object
  my $tbho  = tie(@tabh,'Octology::p8::tabh');
  my @m8rx; # tied array && basic object
  my $tm8o  = tie(@m8rx,'Octology::p8::m8rx');
  # may need new gmap obj to load some room terrain into m8rx
  # then start astr && dijk using tabh
  push (@tabh, [31, '00']); # add some test values with node id
  push (@tabh, [12, '01']); # ...
  while(@tabh){my $frst=shift(@tabh);
    say 'valu:',$frst->[0],' noid:',$frst->[1];}

=head1 DESCRIPTION

=head1 2DU

=over 2

=item - flesh out interface

=back

=head1 USAGE

=head2 new()

Octology::p8::nvg8's constructor to hold navig8ion st8 d8a

=head1 NOTES

I hope you find Octology::p8::nvg8 useful.

=head1 CHANGES

Revision history for Perl extension Octology::p8::nvg8:

=over 2

=item - pAKGvERS  d8VSD8vs

* original version of module based mainly on tabh && HTTP://Theory.Stanford.Edu/~amitp/GameProgramming

=back

=head1 INSTALL

Please run:

  `perl -MCPAN -e "install Octology::p8::nvg8"`

or uncompress the package && run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::p8::nvg8 requires:

=over 2

=item L<Octology::p8::tabh>  - for Tied Array Binary Heap priority queue objects

=item L<Octology::p8::m8rx>  - for tied array M8RiX objects to describe map path costs

=back

=head1 SEE ALSO

L<Heap::Binary> for an altern8 implement8ion of an untied binary heap

L<Array::Heap>  for an altern8 implement8ion of an untied binary heap

L<Octology::p8::taqs for TiedArrayQuickSorted or l8r similar classes?>

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
