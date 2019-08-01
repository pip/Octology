# D8FMMtLL:  Octology::d8::dur8.pm by PipStuart <Pip@CPAN.Org> to make simple objects for Octology's dur8ions (spans or overloaded "frames") of time.
package      Octology::d8::dur8;
use strict; use warnings;use utf8;use v5.10;
require      Octology::d8::fldz;
use base qw( Octology::d8::fldz );
use          Octology::b8;
use          Carp;
my $VERSION='0.0';my $d8VS='GAVMA7ku';
use constant ONE_MINUTE          => '1 min';                  #         60;
use constant ONE_HOUR            => '1 hour';                 #      3_600;
use constant ONE_DAY             => '1 day';                  #     86_400;
use constant ONE_WEEK            => '1 week';                 #    604_800;
use constant ONE_REAL_MONTH      => '1 month';                #        '1M';
use constant ONE_REAL_YEAR       => '1 year';                 #        '1Y';
use constant ONE_MONTH           => '1 average month';        #  2_629_744;
                                                               # ONE_YEAR / 12
use constant ONE_FINANCIAL_MONTH => '1 financial month';      #  2_592_000;
                                                               # 30 days
use constant ONE_YEAR            => '1 average year';         # 31_556_930;
                                                               # 365.24225 days
use constant LEAP_YEAR           => '1 leap year';            # 31_622_400;
                                                               # 366 * ONE_DAY
use constant NON_LEAP_YEAR       => '1 nonleap year';         # 31_536_000;
                                                               # 365 * ONE_DAY
use overload
  q("")  => \&_stringify,
  q(<=>) => \&_cmp_num,
  q(cmp) => \&_cmp_str,
  q(+)   => \&_add,
  q(-)   => \&_sub;
sub _stringify{ # cat non-zero b64 fields down to phass or should just be used fields
  my @fdat=$_[0]->YMDzhmsp();
  my @attz=$_[0]->_attribute_names();my $tstr='';my $toob=0; # flag design8ing field too big
  for(@fdat){$toob=1 if($_>63);}
  if($toob){
    for(my $i=0;$i<@fdat;$i++){
      $attz[$i]=~ s/^_(.).*/$1/;
      $attz[$i]= uc($attz[$i]) if($i<3);
      $tstr.=$attz[$i].':'.$fdat[$i];
      $tstr.=', ' if($i<$#fdat);}
  }else{
    for(my $i=0;$i<@fdat;$i++){
      if(defined($fdat[$i])&& $fdat[$i]){$tstr.=b64($fdat[  $i]); # don't start until non-zero field found in order
        while(  $i<@fdat               ){$tstr.=b64($fdat[++$i]);}# then join the rest to the end
      }}
  } return($tstr);}
sub _cmp_num{
  my($larg,$rarg,$srvr)=@_;
  ($larg,$rarg)=($rarg,Octology::d8::dur8->new($larg)) if($srvr); # mk both args dur8 objects
  # maybe compare _total_phasses() or something?
  return(0);}
sub _cmp_str{my $r= _cmp_num(@_); ($r<0) ? return('lt') : ($r) ? return('gt') : return('eq');}
# dur8 + dur8  = dur8
# dur8 + d8    = d8   (calcul8ion is passed off to d8.pm)
# dur8 + 'str' = d8   (passed off to d8.pm after d8->new('str') is made)
# dur8 + anything else is not supported yet
sub _add{
  my($larg,$rarg,$srvr)=@_;my $rslt;
  $larg=Octology::d8->new($larg) if($srvr);
  $rarg=Octology::d8->new($rarg) unless(ref($rarg)&& $rarg->isa('Octology::d8::dur8'));
  if((ref($larg)&& $larg->isa('Octology::d8'))||
     (ref($rarg)&& $rarg->isa('Octology::d8'))){
    $rslt=$larg+$rarg; # pass off calculation to d8.pm
  }else{
    $rslt=Octology::d8::dur8->new();
    $rslt->{'p'}=$larg->p+$rarg->p;
    $rslt->{'s'}=$larg->s+$rarg->s;
    $rslt->{'m'}=$larg->m+$rarg->m;
    $rslt->{'h'}=$larg->h+$rarg->h;
    $rslt->{'z'}=$larg->z+$rarg->z;
    $rslt->{'D'}=$larg->D+$rarg->D;
    $rslt->{'M'}=$larg->M+$rarg->M;
    $rslt->{'Y'}=$larg->Y+$rarg->Y;
    $rslt->_sift();
  } return($rslt);}
# dur8  - dur8 = dur8
# 'str' - dur8 = d8   (passed off to d8.pm after d8->new('str') is made)
# dur8  - anything else is not supported yet
sub _sub{
  my($larg,$rarg,$srvr)=@_;my $rslt;
  $larg=Octology::d8->new($larg) if($srvr);
  if(ref($larg)&& $larg->isa('Octology::d8')){
    $rslt=$larg-$rarg; # pass off calcul8ion to d8.pm
  }else{
    $rarg=Octology::d8::dur8->new($rarg) unless(ref($rarg)&& $rarg->isa('Octology::d8::dur8'));
    $rslt=Octology::d8::dur8->new();
    $rslt->{'p'}=$larg->p-$rarg->p;
    $rslt->{'s'}=$larg->s-$rarg->s;
    $rslt->{'m'}=$larg->m-$rarg->m;
    $rslt->{'h'}=$larg->h-$rarg->h;
    $rslt->{'z'}=$larg->z-$rarg->z;
    $rslt->{'D'}=$larg->D-$rarg->D;
    $rslt->{'M'}=$larg->M-$rarg->M;
    $rslt->{'Y'}=$larg->Y-$rarg->Y;
    $rslt->_sift();
  } return($rslt);}
# Octology::d8::dur8 object constructor as class method or copy as object method.
# First param can be ref to copy.  Not including optional ref from
#   copy, default is no params to create a new empty dur8 object.
# If params are supplied, they must be a single key && a single value.
# The key must be one of the following 3 types of constructor
#   initialization mechanisms:
#    -1) <packedB64InitStringImplies'str'>(eg. '0A1B2C3D'            )
#     0) 'str'  => <packedB64InitString>  (eg. 'str'  => '0A1B2C3D'  )
#     1) 'array'=> <arrayRef>             (eg. 'array'=> [0, 1, 2..7])
#     2) 'hash' => <hashRef>              (eg. 'hash' => {'h' => 8}  )
#     3) 'g3'   => <gst123TimeString>     (eg. 'g3'   => '0:03:47.88')
#     4) 'mp'   => <mplayerFloatSecondz>  (eg. 'mp'   =>  254.1      )
sub new{my($nvkr,$ityp,$idat)=@_;my $nobj=ref($nvkr);my $clas=$ityp;
  $clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
  my $self=Octology::d8::fldz->new($clas);
  my @attz=$self->_attribute_names();
  for my $attr(@attz){
#   $self->{$attr}=$self->_default_value($attr); # init defaults
    $self->{$attr}=$nvkr->{$attr} if($nobj);}    #  && copy if supposed to
  if(defined($ityp)&& $ityp!~ /::/){ # there were initialization params
    ($ityp,$idat)=('str',$ityp) unless(defined($idat));
    if($ityp=~ /^verbose$/i){ # dur8's verbose string param has field names followed by colon then decimal numbers, like 'Y:2013 M:8 D:...'
      while($idat=~ s/([YMDwzhmsp]):(\d+)//){my($fnam,$fval)=($1,$2); # this is pointlessly no different from a hash with s/=>/:/g && strip commas
        if($fnam=~ /^w/){$self->{'D'}  +=(7*$fval);} # adding weeks field option to auto-gener8 7 times as many Days
        else            {$self->{$fnam}+=   $fval; }}
    }elsif($ityp=~ /^s/i){ # handle 'str' param growing left from phass field
      my $ilen=length($idat);
      for(my $i=(8-$ilen);$i<8;$i++){
        if($idat=~ s/^(.)//){$self->{$attz[$i]}=b10($1);}} # break down str
    }elsif($ityp=~ /^g/i){ # 'g3'  might want to l8r add more flexible parsing for optional fldz && fractional partz
      if($idat=~ /(\d+):(\d+):(\d+)\.(\d+)/){$self->{'h'}=$1;$self->{'m'}=$2;$self->{'s'}=$3;$self->{'p'}=int($4/100.0*64);}
    }elsif($ityp=~ /^m/i){ # 'mp'
      if($idat=~ /(\d+)\.(\d+)/){                                            $self->{'s'}=$1;$self->{'p'}=int($2/ 10.0*64);
        while($self->{'s'} >= 60){
          $self->{    's'} -= 60;$self->{'m'}=0 unless(exists($self->{'m'}) && defined($self->{'m'}) && $self->{'m'}=~ /^\d+$/);$self->{'m'}++;}
        while($self->{'m'} >= 60){ # assuming there won't be Dayz long secondz
          $self->{    'm'} -= 60;$self->{'h'}=0 unless(exists($self->{'h'}) && defined($self->{'h'}) && $self->{'h'}=~ /^\d+$/);$self->{'h'}++;}}
    }else{
      for my $attr(@attz){
        if    ($ityp=~ /^s/i){ # 'str'
          $self->{$attr}=b10($1) if($idat=~ s/^(.)//); # break down string
        }elsif($ityp=~ /^a/i){ # 'array'
          $self->{$attr}=shift(@{$idat}) if(@{$idat}); # shift array vals
        }elsif($ityp=~ /^h/i){ # 'hash'
          for(keys(%{$idat})){ # do some searching to find hash key that matches
            if($attr=~ /$_/){$self->{$attr}=$idat->{$_};
              delete(                       $idat->{$_});}}
        }else{croak "!*EROR*! Octology::d8::dur8::new initialization type: $ityp did not match 'str','array','hash','g3', or 'mp'!\n";}}} # unDtectd init type
  }return($self);}
sub total_phasses{ # return the integer number of phasses in a Octology::d8::dur8 obj
  my $self=shift;my $totl=0;
  $totl+= $self->p();
  $totl+=($self->s() * 60);
  $totl+=($self->m() * 60 * 60);
  $totl+=($self->h() * 60 * 60 * 60); # should zone count for any phasses?
  $totl+=($self->D() * 60 * 60 * 60 * 24);
  $totl+=($self->M() * 60 * 60 * 60 * 24 * 30.4368537808642);
  $totl+=($self->Y() * 60 * 60 * 60 * 24 * 365.24225);
  return($totl);}
sub DESTROY{ } # do nothing but define in case && to calm warning in test.pl
8;

=head1 NAME

Octology::d8::dur8 - objects to store a dur8ion of time

=head1 VERSION

This documentation refers to version pAKGvERS of Octology::d8::dur8, which was released on d8VSD8vs.

=head1 SYNOPSIS

  use Octology::d8::dur8;

  my $d = Octology::d8::dur8->new('verbose' => '2 weeks');
  print 'Number of days is ', $d->d(), "\n";

=head1 DESCRIPTION

This module has been adapted from the Time::Seconds module written by Matt Sergeant <matt@sergeant.org> and Jarkko Hietaniemi <jhi@iki.fi>.
Octology::d8::dur8 inherits base data structure and object methods from Octology::d8::fldz.
dur8 was written to simplify storage and calcul8ion of encoded, yet distinct and human-readable, time data objects.

=head1 2DU

=over 2

=item - copy total_phasses into AUTOLOAD for (in|as|total)_(YMDzhmsp) functions which convert to any field

=item - better ways to specify common verbose sizes

=item -     What else does dur8 need?

=back

=head1 WHY?

The reason I created dur8 was that I have grown so enamored with Base64 represent8ions of everything around me that I was
compelled to write a simple clock utility ( `d8ok` ) using Base64. This demonstr8d the benefit to be gained from time objects with
distinct fields and configurable precision. Thus, L<Octology::d8::fldz> was written to be the abstract base class for:

  Octology::d8        ( crE8s objects for instants in time )
    and
  Octology::d8::dur8  ( crE8s objects for dur8ions of time )

=head1 USAGE

Many of Octology::d8::dur8's methods have been patterned after the excellent L<Time::Piece> module written by Matt Sergeant <matt@sergeant.org>
and Jarkko Hietaniemi <jhi@iki.fi>.

=head2 new(<InitType>, <InitData>)

Octology::d8::dur8's constructor can be called as a class method to create a brand new object or as an object method to copy an existing object.
Beyond that, new() can initialize dur8 objects in the following ways:

  * <packedB64InitStringImplies'str'>
    eg. Octology::d8::dur8->new('01234567');
  * 'str'  => <packedB64InitString>
    eg. Octology::d8::dur8->new('str'  => 'ABCDEFGH');
  * 'array'=> <arrayRef>
    eg. Octology::d8::dur8->new('array'=> [0, 1, 2..7]);
  * 'hash' => <hashRef>
    eg. Octology::d8::dur8->new('hash' => {'phass' => 7, 'year' => 2014})
  * 'g3'   => <gst123TimeString>
    eg. Octology::d8::dur8->new('g3'   => '0:03:47.88')
  * 'mp'   => <mplayerFloatSecondz>
    eg. Octology::d8::dur8->new('mp'   =>  254.1)

=head2 total_phasses()

total_phasses simply returns the total number of phasses an Octology::d8::dur8 object specifies.

=head2 colr(<DestinationColorTypeFormat>)

This is an object member which will join Base64 representations of each field that has been specified in use() and joins them with color-codes or color
escape sequences with formats for varied uses. dur8's color pattern gets applied right-to-left. Currently available DestinationColorTypeFormats are:

  'ANSI'  # eg. \e[1;32m
  'zsh'   # eg. %{\e[1;33m%}
# 'HTML'  # eg. <a href="http://Ax9.Org/pt?"><font color="#FF1B2B"> #URL defunct && need new d8 CGI to supplant old pt
  'c8'    # eg. ROYGCBMP

The following methods allow access to individual fields of Octology::d8::dur8 objects:

  $t->Y  # Year
  $t->M  # Month
  $t->D  # Day
  $t->z  # zone
  $t->h  # hour
  $t->m  # minute
  $t->s  # second
  $t->p  # phass

Please see L<Octology::d8::fldz> for a more thorough description of field accessor methods.

=head1 NOTES

Whenever individual Octology::d8::dur8 attributes are going to be printed or an entire object can be printed with multi-colors,
the following mapping should be employed whenever possible:

  D  Year    -> Red
  A  Month   -> Orange
  T  Day     -> Yellow
  E   zone   -> Green
   t  hour   -> Cyan
   i  minute -> Blue
   m  second -> Magenta
   e  phass  -> Purple

Please see the colr() member function in the USAGE section.

I hope you find Octology::d8::dur8 useful. Please feel free to e-mail me any suggestions or coding tips or notes of appreC8ion. Thank you. TTFN.

=head1 CHANGES

Revision history for Perl extension Time::Frame:

=over 4

=item - pAKGvERS  d8VSD8vs

* migr8d old Time::Frame over to new Octology::d8::dur8 name and lowercased && shortened fldz.pm

* updated license copyright years (already had GPLv3)

* combined Fields, Frame, && PT into one pkg (so see PT CHANGES section for updates to Fields or Frame)

=item - 1.0.3CCA3bG  Fri Dec 12 10:03:37:16 2003

* removed indenting from POD NAME field

=item - 1.0.3CB7RLu  Thu Dec 11 07:27:21:56 2003

* added HTML color option && prepared for release

=item - 1.0.3CA8thM  Wed Dec 10 08:55:43:22 2003

* built class to inherit from Time::Fields

=item - 1.0.37VG26k  Thu Jul 31 16:02:06:46 2003

* original version

=back

=head1 INSTALL

Please run:

      `perl -MCPAN -e "install Octology::d8"`

or uncompress the package && run the standard:

      `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::d8::dur8 requires:

L<Carp>                 to allow errors to croak() from calling sub

L<Octology::b8>         to handle number-base transl8ion

L<Octology::d8::fldz>   to provide underlying object structure

=head1 SEE ALSO

L<Octology::d8>

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2003-2015, Pip Stuart.
Copyleft : This software is licensed under the GNU General Public License (version 3). Please see the Free Software Foundation (HTTP://FSF.Org)
  for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
