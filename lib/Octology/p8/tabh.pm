# H82MKeXY: Octology::p8::tabh.pm crE8d by PipStuart <Pip@CPAN.Org> to be a class for Tied Array Binary Heap objects with arrayrefs of [valu,noid] for A*;
# 2du:tune prnt formatting for real-world nvg8:astr node d8a,try to mk prnt rpad vary for max spacing && hopefully some betr alignment,
#   add upd8d ndxz NodeId2iNdexz hash for F valu decreases,tst STORE decrease,add splice each1gets last2sift bakdn or more than 1/8th just rebuild,
#   add optnz with atrz && dfltz for max valu 1st nstd of min,b8 b64,str cmpz,custom sort anon sub,write thorough tests && POD,
#   maybe add (add|(extract_)?top|decrease_key|absorb|delete) methods from Heap.pm or Array::Heap or ipsw optimiz8ions from Binary::Heap::Array,benchmark;
package     Octology::p8::tabh;
use strict;use warnings;use utf8;use v5.10;use Tie::Array;
use         Octology::a8; # needed for colr prnt
my  $VERSION= '0.0';my $d8VS='H9AMA9H9';
my       @atrz=()  ;my %dvlz=()        ;
push(    @atrz,'tabh');$dvlz{$atrz[-1]}=         [];
#ush(    @atrz,'hite');$dvlz{$atrz[-1]}=ROOM_HEIGHT;
#ush(    @atrz,'fill');$dvlz{$atrz[-1]}=          0;
sub atrb{@atrz;} # attribute methods to query defaults
sub dval{my($self,$attr)=@_;$dvlz{$attr};}
sub TIEARRAY {my $clas= shift(@_);my $self= bless({},$clas);my($attr,$ival);
  for       $attr ($self->atrb()){      # init defaults
    $self->{$attr}=$self->dval($attr);}
  while(@_){$attr =     shift(@_); # accept additional constructor params to override defaults
    if (@_ && exists($dvlz{$attr})){$ival= shift(@_);$self->{$attr}=$ival;}} # probably l8r will want to sanity check for valid init types && values here
  $self->{'tabh'}=[]; # mAB tied constructor needs this explicit attr initialized to anon array here vs ref 2 anon array abov for proper tying to succeed?
  return($self);} # it does seem that there are path failures when I comment the above line out, but I'm not seeing any when leaving it in there... weird
sub FETCH    {return(         $_[0]->{'tabh'}->[$_[1]]);}
sub FETCHSIZE{return(scalar(@{$_[0]->{'tabh'}})       );}
sub STORE    {my $oldv =      $_[0]->{'tabh'}->[$_[1]]->[0];                                      # this should test for  decreasing valu then s8pu from there
                              $_[0]->{'tabh'}->[$_[1]] = $_[2];if($_[2] < $oldv){ $_[0]->s8pu($_[1]);}else{$_[0]->s8sh($_[1]);}} # or increase s8sh from there
sub STORESIZE{splice(       @{$_[0]->{'tabh'}}, $_[1], @{$_[0]->{'tabh'}}-$_[1]);               }
sub EXISTS   {return(0) unless(defined($_[0]->{'tabh'}->[$_[1]]));return(1);}
sub CLEAR    {              @{$_[0]->{'tabh'}} = ();                                            }
sub PUSH     {         push(@{$_[0]->{'tabh'}}, $_[1] );                          $_[0]->s8pu();} # add to end && filter up
sub POP      {$_ =      pop(@{$_[0]->{'tabh'}});                                                return($_);}
sub SHIFT    {$_ =    shift(@{$_[0]->{'tabh'}}); # save top, then rot8 last around to first && filter back down
                    unshift(@{$_[0]->{'tabh'}},pop(@{$_[0]->{'tabh'}})) if(scalar(@{$_[0]->{'tabh'}}) > 1);
                                                                                  $_[0]->s8sh();return($_);}
sub UNSHIFT  {         push(@{$_[0]->{'tabh'}}, $_[1] );                          $_[0]->s8pu();} # can't really unshift without disturbing heap,so just push
sub SPLICE   {my $self = shift(@_); # splicing out of the middle of a binary heap will probably need to just copy what's left && push all into new empty heap
  my             $offs = shift(@_) || 0;my $leng = shift(@_);$leng = $self->FETCHSIZE() - $offs unless(defined($leng));
  my $retn =         splice(@{$self->{'tabh'}},$offs,$leng,@_);                   $self->s8to();return($retn);}
sub EXTEND   {}
sub s8to{my $self=shift(@_);@{$self->{'tabh'}} = sort {$a->[0] <=> $b->[0]}  @{$self->{'tabh'}};} # basic Sorting "s8ing" of a Tied Object
sub s8pu{my $self=shift(@_);my $cndx=shift(@_) || scalar(@{$self->{'tabh'}}) - 1; # handle Sorting "s8ing" a binary heap after a normal PUsh to the end
  if (scalar(@{$self->{'tabh'}}) > 1){ # start wi Child iNDeX as last node (which was just pushed there), or higher up if start child index passed as param
    while($cndx > 0){my $pndx = int(($cndx+1)/2)-1; # loop potentially up to just below first root node  # compute Parent node iNDeX
      if($self->{'tabh'}->[$cndx  ]->[0] < $self->{'tabh'}->[$pndx]->[0]){
        ($self->{'tabh'}->[$cndx  ],       $self->{'tabh'}->[$pndx]     )=
        ($self->{'tabh'}->[$pndx  ],       $self->{'tabh'}->[$cndx]     );$cndx=$pndx  ;}else{last;}}}} # exchange to put lower valz higher in tree,or quit
sub s8sh{my $self=shift(@_);my $pndx=shift(@_) || 0; # handle Sorting "s8ing" a binary heap after a normal SHift from the beginning
  if (scalar(@{$self->{'tabh'}}) > 1){ # start wi Parent iNDeX as first node (or other index could be passed in when increasing a value)
    while(2*($pndx+1)-1 < @{$self->{'tabh'}}){my $cndx=2*($pndx+1)-1; # loop potentially down to just above last node  # compute Child node iNDeX
      my $xndx=$pndx; # have a temporary eXchange iNDeX for testing lowest of both children (except at end when there might just be left child)
      if($self->{'tabh'}->[$cndx  ]->[0] < $self->{'tabh'}->[$xndx]->[0]){$xndx=$cndx  ;}
      if(    $cndx+1    < @{$self->{'tabh'}} &&
         $self->{'tabh'}->[$cndx+1]->[0] < $self->{'tabh'}->[$xndx]->[0]){$xndx=$cndx+1;}
      if($xndx != $pndx){
        ($self->{'tabh'}->[$xndx  ],       $self->{'tabh'}->[$pndx]     )=
        ($self->{'tabh'}->[$pndx  ],       $self->{'tabh'}->[$xndx]     );$pndx=$xndx  ;}else{last;}}}} # exchange to put higher valz lower in tree,or quit
sub log2{ my $numb=shift(@_);return(log($numb)/log(2));} # easily compute the log base-2 of a number
sub prnt{ my $self=shift(@_);my $size= scalar(@{$self->{'tabh'}});my $rndx=0; # need to test more possible sizes
  open    my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  for(0..log2($size)){my $rsiz=2**$_;my $psiz= int((156 - $rsiz*10) / ($rsiz+1));$psiz=1 if($psiz == 0); # max level 4 so far needs 16*4 + 17*5 = 64+85 = 149
    printf   $out8 "%d:",$_;my $rpad= ' ' x $psiz; # mAB odd spc pads just won't vertalign wi higher lvls unless they pre-inherit int vals of smallers?
    for   my $rndx ($rsiz-1..(2*($rsiz-1))){ # 63 wraps a little with 32 on layer 5 but skews more from level 4 16 so need variable rpads &&2omit commas4more
      printf $out8 "%s%s%3.4f$G%s",$rpad,($rndx % 2) ? $M : $R,@{$self->{'tabh'}->[$rndx]};last if($rndx == $#{$self->{'tabh'}});} say $out8 '';}
  close      $out8             or die "Can't close duplic8 STDOUT handle: $!";} # printf was formatting costs as integers before
# Octology::p8::tabh object constructor as class method or copy as object method. First param can be ref to copy. Not including optional ref from copy,
#   default is no params to crE8 a new empty tabh object. If params are supplied, they must be hash key => value pairs.
sub new{my($nvkr,$cora)= @_;my $clas=$cora;my $pkgn= __PACKAGE__ ;my($attr,$ival); # not shifted: iNVoKeR, Class OR Attrkey, CLASs, l8r ATTRibute && InitVALue
  if   (!defined($cora) || $cora !~ /::/){$clas= ($nvkr->isa($pkgn)) ? $pkgn : $nvkr;} my $self=bless({},$clas); # ClassORAttrkey not valid CLASs, so need2set
  for       $attr ($self->atrb()){     # init defaults...  # below strict error trying to use pkgn as hashref (from nvkr?)
    $self->{$attr}=$self->dval($attr); #   but should also deep copy below if new was called from nvkr
    $self->{$attr}=$nvkr->{    $attr} if($nvkr !~ /::/ && $nvkr->isa($pkgn) && exists($nvkr->{$attr}));}
  if($nvkr->isa($pkgn)){shift(@_);}        shift(@_); # these should always just void shift off the already determined class name && maybe invoker if copying
  while(@_){$attr =     shift(@_); # accept additional constructor params to override defaults
    if (@_ && exists($dvlz{$attr})){$ival= shift(@_);$self->{$attr}=$ival;}} # probably l8r will want to sanity check for valid init types && values here
  return(   $self);}
8;

=encoding utf8

=head1 NAME

Octology::p8::tabh - make Tied Array Binary Heap objects

=head1 VERSION

This document8ion refers to version 0.0 of Octology::p8::tabh, which was released on
.

=head1 SYNOPSIS

  use utf8;use v5.10;use Octology::p8::tabh;
  my @tabh; # tied array && basic object demonstr8ion
  my $tbho  = tie(@tabh,'Octology::p8::tabh');
  # maybe set new  tbho optionz above or here with methods
  #push (@tabh, [31, '00']); # add some test values with node id
  #push (@tabh, [12, '01']); # ...
  #while(@tabh){my $frst=shift(@tabh); # keep removing first arrayref
  #  say 'valu:',$frst->[0],' noid:',$frst->[1];} # ... until empty

=head1 DESCRIPTION

=head1 2DU

=over 2

=item - flesh out interface

=back

=head1 USAGE

=head2 new()

Octology::p8::tabh's constructor without tying an array...

=head1 NOTES

I hope you find Octology::p8::tabh useful.

=head1 CHANGES

Revision history for Perl extension Octology::p8::tabh:

=over 2

=item - pAKGvERS  d8VSD8vs

* original version of module based mainly on Simp && HTTP://PolicyAlmanac.Org/games/binaryHeaps.htm

=back

=head1 INSTALL

Please run:

  `perl -MCPAN -e "install Octology::p8::tabh"`

or uncompress the package && run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::p8::tabh requires:

=over 2

=item L<Tie::Array>    - allow text arrays to be bound to objects

=item L<Octology::a8>  - for autom8d exports of global d8a && functions

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
