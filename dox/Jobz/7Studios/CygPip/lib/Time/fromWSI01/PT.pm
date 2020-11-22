# 2CN4sip - fULnAME.pm (PakTime, was called PipTime) created by Pip Stuart <Pip@CPAN.Org> to define simple objects for storing instants in time.
package Time::PT;
use strict;
use warnings;
require      Time::Fields;
require                   Exporter;
use base qw( Time::Fields Exporter );
use vars qw( $AUTOLOAD );
use Carp;
use Math::BaseCnv qw( :all );
use Time::DayOfWeek;
use Time::DaysInMonth;
use Time::Frame;
my $hirs = eval("use   Time::HiRes; 1") || 0;
my $locl = eval("use   Time::Local; 1") || 0;
my $zown = eval("use   Time::Zone;  1") || 0;
#my $simp = eval("use Curses::Simp;  1") || 0;
our $VERSION     = '1.2.pIPtIME'; # major . minor . PakTimeStamp
our $PTVR        = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major && minor
our @EXPORT_OK   = qw(ptcc);
use overload
  q("")  => \&_stringify,
  q(<=>) => \&_cmp_num,
  q(cmp) => \&_cmp_str,
  q(+)   => \&_add,
  q(-)   => \&_sub;
sub _stringify { # cat non-zero b64 PT fields
  my @fdat = $_[0]->CYMDhmsfjz();
  my @attz = $_[0]->_attribute_names();
  my $tstr = ''; my $toob = 0; # flag designating field too big
  $fdat[1] -= 2000; # Year adjustment
  for(@fdat) {
    $toob = 1 if($_ > 63);
  }
# Reverse Year shifts back into fields
#   0) Each 13 added to the Month adds  64 to the Year.
#   1)      24 added to the Hour  adds 256 to the Year.
#   2)      32 added to the Day   makes the year negative just before adding 2k
  if(   $fdat[1] <    0) { $fdat[1] *=  -1; $fdat[3] += 32; }
  if(   $fdat[1] >= 256) { $fdat[1] -= 256; $fdat[4] += 24; }
  while($fdat[1] >=  64) { $fdat[1] -=  64; $fdat[2] += 13; }
  if($toob) {
    for(my $i=0; $i<@fdat; $i++) {
      $attz[$i] =~ s/^_(.).*/$1/;
      $attz[$i] = uc($attz[$i]) if($i < 4 || $i == $#fdat);
      $tstr .= $attz[$i] . ':' . $fdat[$i];
      $tstr .= ', ' if($i < $#fdat);
    }
  } else {
    for(my $i=0; $i<@fdat; $i++) {
      if($fdat[$i]) {
        $tstr .= b64($fdat[$i]);
        while($i < 7) { $tstr .= b64($fdat[++$i]); }
      }
    }
  }
  return($tstr);
}
sub _cmp_num {
  my ($larg, $rarg, $srvr) = @_;
  ($larg, $rarg) = ($rarg, Time::PT->new($larg)) if($srvr); # mk both args PT objects
  $rarg = Time::PT->new($rarg) unless(ref($rarg) && $rarg->isa('Time::PT'));
  if   (($larg->C < $rarg->C) ||
        ($larg->Y < $rarg->Y) ||
        ($larg->O < $rarg->O) ||
        ($larg->D < $rarg->D) ||
        ($larg->h < $rarg->h) || # add z?
        ($larg->i < $rarg->i) ||
        ($larg->s < $rarg->s) ||
        ($larg->f < $rarg->f) ||
        ($larg->j < $rarg->j)) { return(-1); }
  elsif(($larg->C > $rarg->C) ||
        ($larg->Y > $rarg->Y) ||
        ($larg->O > $rarg->O) ||
        ($larg->D > $rarg->D) ||
        ($larg->h > $rarg->h) || # add z?
        ($larg->i > $rarg->i) ||
        ($larg->s > $rarg->s) ||
        ($larg->f > $rarg->f) ||
        ($larg->j > $rarg->j)) { return(1); }
  else                         { return(0); }
}
sub _cmp_str {
  my $c = _cmp_num(@_);
  ($c < 0) ? return('lt') : ($c) ? return('gt') : return('eq');
}
# PT + Frame = PT
# PT + anything else is not supported yet
sub _add {
  my ($larg, $rarg, $srvr) = @_;
  my $rslt = Time::PT->new('');
  if($srvr) {
    ($larg, $rarg) = ($rarg, Time::Frame->new($larg));
  }
  unless(ref($rarg) && $rarg->isa('Time::Frame')) {
    $rarg = Time::Frame->new($rarg);
  }
  $rslt->{'_zone'}    = $larg->z + $rarg->z;
  $rslt->{'_jink'}    = $larg->j + $rarg->j;
  $rslt->{'_frame'}   = $larg->f + $rarg->f;
  $rslt->{'_second'}  = $larg->s + $rarg->s;
  $rslt->{'_minute'}  = $larg->i + $rarg->i;
  $rslt->{'_hour'}    = $larg->h + $rarg->h;
  $rslt->{'_day'}     = $larg->D + $rarg->D;
  $rslt->{'_month'}   = $larg->O;
  $rslt->{'_year'}    = $larg->Y;
  $rslt->_sift();
  $rslt->{'_month'}   = $larg->O + $rarg->O;
  $rslt->{'_year'}    = $larg->Y + $rarg->Y;
  $rslt->{'_century'} = $larg->C + $rarg->C;
  $rslt->_sift(1);
  return($rslt);
}
# PT - Frame = PT
# PT - PT    = Frame
# PT - anything else is not supported yet
sub _sub {
  my ($larg, $rarg, $srvr) = @_; my $rslt;
  if($srvr) {
    $larg = Time::PT->new($larg);
  }
  if(ref($rarg) && $rarg->isa('Time::PT')) {
    $rslt = Time::Frame->new();
  } else {
    $rarg = Time::Frame->new($rarg) unless(ref($rarg) && $rarg->isa('Time::Frame'));
    $rslt = Time::PT->new('');
  }
  $rslt->{'_zone'}    = $larg->z - $rarg->z;
  $rslt->{'_jink'}    = $larg->j - $rarg->j;
  $rslt->{'_frame'}   = $larg->f - $rarg->f;
  $rslt->{'_second'}  = $larg->s - $rarg->s;
  $rslt->{'_minute'}  = $larg->i - $rarg->i;
  $rslt->{'_hour'}    = $larg->h - $rarg->h;
  $rslt->{'_day'}     = $larg->D - $rarg->D;
  $rslt->{'_month'}   = $larg->O;
  $rslt->{'_year'}    = $larg->Y;
  $rslt->_sift()  if($rslt->isa('Time::PT'));
  $rslt->{'_month'}   = $larg->O - $rarg->O;
  $rslt->{'_year'}    = $larg->Y - $rarg->Y;
  $rslt->{'_century'} = $larg->C - $rarg->C;
  $rslt->_sift(1) if($rslt->isa('Time::PT'));
  return($rslt);
}
sub _sift { # settles fields into standard ranges (for overflow from add/sub)
  my $self = shift; my $mdon = shift; my $dinf = 0;
  unless($mdon) {
    if($self->{'_jink'} >= $self->{'__jpf'} || 0 > $self->{'_jink'}) {
      $self->{'_jink'}  -= $self->{'__jpf'} if(0 > $self->{'_jink'});
      $self->{'_frame'} += int($self->{'_jink'}  / $self->{'__jpf'});
      $self->{'_jink'}  %= $self->{'__jpf'};
    }
    if($self->{'_frame'} >= $self->{'__fps'} || 0 > $self->{'_frame'}) {
      $self->{'_frame'}  -= $self->{'__fps'} if(0 > $self->{'_frame'});
      $self->{'_second'} += int($self->{'_frame'} / $self->{'__fps'});
      $self->{'_frame'}  %= $self->{'__fps'};
    }
    if($self->{'_second'} >= 60 || 0 > $self->{'_second'}) {
      $self->{'_second'}  -= 60 if(0 > $self->{'_second'});
      $self->{'_minute'}  += int($self->{'_second'} / 60);
      $self->{'_second'}  %= 60;
    }
    if($self->{'_minute'} >= 60 || 0 > $self->{'_minute'}) {
      $self->{'_minute'}  -= 60 if(0 > $self->{'_minute'});
      $self->{'_hour'}    += int($self->{'_minute'} / 60);
      $self->{'_minute'}  %= 60;
    }
    if($self->{'_hour'} >= 24 || 0 > $self->{'_hour'}) {
      $self->{'_hour'}  -= 24 if(0 > $self->{'_hour'});
      $self->{'_day'}   += int($self->{'_hour'} / 24);
      $self->{'_hour'}  %= 24;
    }
    $dinf = 1 unless(defined($self->{'_month'}) && $self->{'_month'});
    $self->{'_month'} = 1 if($dinf);
    while($self->{'_day'} > days_in($self->Y, $self->M) || 0 >  $self->{'_day'}) {
      if(0 >= $self->{'_day'}) {
        $self->{'_month'}--;
        while($self->{'_month'} < 1) {
          $self->{'_year'}--;
          $self->{'_month'} += 12;
        }
        $self->{'_day'}  += days_in($self->Y, $self->M);
      } else {
        $self->{'_day'}  -= days_in($self->Y, $self->M);
        $self->{'_month'}++;
        while($self->{'_month'} > 12) {
          $self->{'_year'}++;
          $self->{'_month'} -= 12;
        }
      }
    }
    $self->{'_month'}-- if($dinf);
  } else {
    if($self->{'_month'} >  12 || 0 >= $self->{'_month'}) {
      $self->{'_month'}  -= 12 if(0 > $self->{'_month'});
      $self->{'_year'}   += int($self->{'_month'} / 12);
      $self->{'_month'}  %= 12;
    }
    # if __use_century && _year > 1000...
  }
}
sub ptcc { # Generic PT Curses::Simp Color Code strings as class method
  my $frmt = shift || 0; my $ptst; my $ptsb;
  if     ($frmt =~ /^-*f/i) {
    $ptst = 'YYY OOO YY GGWCCWBBWPP RRRR';
    $ptsb = '                           ';
    #`pt pt->Wed Jul 16 00:03:31:30 2003
  } elsif($frmt =~ /^-*k/i) {
    $ptst = 'ROYGCBP'; # same as below but with 'hms' in blue bkgrnd
    $ptsb = '   bbb ';
  } else {
    $ptst = 'ROYGCBP';
    $ptsb = '       ';
    # `pt`-> YMDhmsf
  }
  return($ptst, $ptsb);
}
sub expand { # returns a PT object's expanded string form
  my  $self = shift; my @mnth; my $dofw = '   '; my $mont = '   ';
  if($self->month()) {
    if($self->day()) { $dofw = $self->Dow(); }
    @mnth = Time::DayOfWeek::MonthNames();
    $mont = $mnth[$self->month() - 1];
    $mont =~ s/^(...).*/$1/; # keep only 1st 3 chars
  }
  return(sprintf("%3s %3s %2d %02d:%02d:%02d:%02d %4d",
                         $dofw,
                         $mont,
                         $self->day(),
                         $self->hour(),
                         $self->minute(),
                         $self->second(),
                         $self->frame(),
                         $self->year()));
}
# adds color codes corresponding to each field according to ColorTYPe
#   (/^s/i) ? Curses::Simp color codes
# : (/^h/i) ? HTML links && font color tag delimiters
# : (/^4/i) ? 4NT verbose color codes
# : (/^v/i) ? vim User highlight color codes
# : ANSI color escapes (/^z/i) ? wrapped in zsh delimiters;
sub _color_fields {
  my $self = shift;
  my $fstr = shift || ' ' x 10; $fstr =~ s/0+$// if(length($fstr) <= 7);
  my $ctyp = shift || 'ANSI';
  my @clrz = (); my $coun = 0; my $rstr = '';
  if     ($ctyp =~ /^s/i) { # simp color codes
    @clrz = @{$self->_field_colors('simp')};
    if(length($fstr) > 7) { while(length($fstr) > $coun) { $rstr .= $clrz[$coun++]; } }
    else                  { while(length($fstr) > $coun) { $rstr .= $clrz[++$coun]; } }
  } elsif($ctyp =~ /^h/i) { # HTML link && font color tag delimiters
    @clrz = @{$self->_field_colors('html')};
    $_    = '<font color="#' . $_ . '">' for(@clrz);
    $rstr = '<a href="HTTP://Ax9.Org/pt?' . $fstr . '">';
    if(length($fstr) > 7) { while(length($fstr) > $coun) { $rstr .= $clrz[$coun    ] . substr($fstr, $coun++, 1) . '</font>'; } }
    else                  { while(length($fstr) > $coun) { $rstr .= $clrz[$coun + 1] . substr($fstr, $coun++, 1) . '</font>'; } }
    $rstr .= '</a>';
  } elsif($ctyp =~ /^4/i) { # 4NT prompt needs verbose color codes
    @clrz = @{$self->_field_colors('4nt')};
    for(my $i=0; $i<@clrz; $i++) { $clrz[$i] = ' & color ' . $clrz[$i] . ' & echos '; }
    if(length($fstr) > 7) { while(length($fstr) > $coun) { $rstr .= $clrz[$coun    ] . substr($fstr, $coun++, 1); } }
    else                  { while(length($fstr) > $coun) { $rstr .= $clrz[$coun + 1] . substr($fstr, $coun++, 1); } }
  } elsif($ctyp =~ /^v/i) { # vim User highlight color codes
    for(my $i=0; $i<=length($fstr); $i++) { $clrz[$i] = '%' . $i . '*'; }
    if(length($fstr) > 7) { while(length($fstr) > $coun) { $rstr .= $clrz[$coun    ] . substr($fstr, $coun++, 1); } }
    else                  { while(length($fstr) > $coun) { $rstr .= $clrz[$coun + 1] . substr($fstr, $coun++, 1); } }
  } else { # ANSI escapes
    @clrz = @{$self->_field_colors('ansi')};
    if($ctyp =~ /^z/i) { # zsh prompt needs delimited %{ ANSI %}
      for(my $i=0; $i<@clrz; $i++) { $clrz[$i] = '%{' . $clrz[$i] . '%}'; }
    }
    if(length($fstr) > 7) { while(length($fstr) > $coun) { $rstr .= $clrz[$coun    ] . substr($fstr, $coun++, 1); } }
    else                  { while(length($fstr) > $coun) { $rstr .= $clrz[$coun + 1] . substr($fstr, $coun++, 1); } }
  }
  return($rstr);
}
# fULnAME object constructor as class method or copy as object method.
# First param can be ref to copy.  Not including optional ref from
#   copy, default is no params to create a new empty pKGnAME object.
# If params are supplied, they must be a single key && a single value.
# The key must be one of the following 3 types of constructor
#   initialization mechanisms:
#    -1) <packedB64InitStringImplies'str'>(e.g., '3C79jo0')
#     0) 'str'  => <packedB64InitString>  (e.g., 'str'  => '0123456789')
#     1) 'list' => <arrayRef>             (e.g., 'list' => [0, 1, 2..9])
#     2) 'hash' => <hashRef>              (e.g., 'hash' => {'jink' => 8})
sub new {
  my($nvkr, $ityp, $idat)= @_;
  my $nobj = ref($nvkr);
  my $clas = $ityp;
  $clas = $nobj || $nvkr if(!defined($ityp) || $ityp !~ /::/);
  my $self = Time::Fields->new($clas);
  my $rgxs; my $mont; my @attz = $self->_attribute_names();
#       timelocal($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
  my  @ltim = localtime(); my $subs = Time::HiRes::time(); $subs -= int($subs);
  my  @dayo = Time::DayOfWeek::DayNames();
  my  @mnth = Time::DayOfWeek::MonthNames();
  for(@dayo) { $_ = substr($_, 0, 3) if(length($_) > 3); } # ck for uniq 1st 3chrz?
  for(@mnth) { $_ = substr($_, 0, 3) if(length($_) > 3); }
  $self->{'_year'}   = $ltim[5] + 1900;
  $self->{'_month'}  = $ltim[4] + 1;
  $self->{'_day'}    = $ltim[3];
  $self->{'_hour'}   = $ltim[2];
  $self->{'_minute'} = $ltim[1];
  $self->{'_second'} = $ltim[0];
  $self->{'_frame'}  = int($subs * $self->{'__fps'});
  #$subs *= $self->{'__fps'}; $subs -= int($subs);
  #$self->{'_jink'}   = int($subs * $self->{'__jpf'});
  $self->{'__time_separator'} = ':';
  $self->{'__date_separator'} = '-';
  for my $attr ( @attz ) {
#    $self->{$attr} = $self->_default_value($attr); # init defaults
    $self->{$attr} = $nvkr->{$attr} if($nobj);     #  && copy if supposed to
  }
  if(defined($ityp) && $ityp !~ /::/) { # there were initialization params
    for my $attr ( @attz ) {
      $self->{$attr} = $self->_default_value($attr); # init defaults
    }
    ($ityp, $idat) = ('str', $ityp) unless(defined($idat));
    if($ityp =~ /^verbose$/i) { # handle 'verbose' differently
      # verbose string param is expanded date &&/or time text
      $rgxs = '^\\s*((' . join('|', @dayo) . ')\\S*)?\\s*(' .
                          join('|', @mnth) . ')\\S*\\s*(\\d+)' .
               '\\s+(\\d+(\D+(\\d+)){0,4})\\s+(\d+)\\s*$';
      if($idat =~ /$rgxs/i) {
#print "idat:$idat\nrgxs:$rgxs\nDow?$2 Mon$3 dy$4 hr:mn?:sc?:fr?:jn?$5 YEAR!\n";
        $mont                = $3;
        $self->{'_day'}      = $4;
        ($self->{'_hour'}  ,
         $self->{'_minute'},
         $self->{'_second'},
         $self->{'_frame'} ,
         $self->{'_jink'}  ) = split(/\D+/, $5);
        $self->{'_year'}     = $8;
#print "M:$mont D:$self->{'_day'} h:($self->{'_hour'} m:$self->{'_minute'} s:$self->{'_second'} f:$self->{'_frame'} j:($self->{'_jink'} Y:$self->{'_year'}\n";
      } else {
        $rgxs = '^\\s*((' . join('|', @dayo) . ')\\S*)?\\s*(' .
                            join('|', @mnth) . ')\\S*\\s*(' .
                '\\d+)\\s*,?\\s*(\\d+)\\s*$';
        if($idat =~ /$rgxs/i) {
#print "Dow?$2 " if(defined($2)); print "Mon$3 dy$4 YEAR$5!\n";
          $mont            = $3;
          $self->{'_day'}  = $4;
          $self->{'_year'} = $5;
        } else {
          $rgxs = '^\\s*(\\d+(\D+(\\d+)){0,4})\\s*$';
          if($idat =~ /$rgxs/i) {
print "hr:mn?:sc?:fr?:jn?!\n";
# 2do: continue testing && assigning all acceptable verbose formats
          }
        }
      }
      if(defined($mont)) { # convert named month to proper index number
        for(my $i = 0; $i < @mnth; $i++) { # find which month name
          if(lc($mont) eq lc($mnth[$i])) { # $mont =~ /^$mnth[$i]/i) {
            $self->{'_month'} = ($i + 1); # ($i + 1) for 1-based month field
          }
        }
      }
    } elsif($ityp =~ /^s/i && length($idat) <= 9) { # handle small 'str' differently
      # small str param grows right from year field
      my $ilen = length($idat);
      for(my $i = 1; $i <= $ilen; $i++) {
        if($idat =~ s/^(.)//) {
          $self->{$attz[$i]} = b10($1); # break down str
        }
      }
      $self->{'_year'} += 2000;
    } else {
      for my $attr ( @attz ) {
        if     ($ityp =~ /^s/i) {    # 'str'
          $self->{$attr} = b10($1) if($idat =~ s/^(.)//);  # break down string
        } elsif($ityp =~ /^[la]/i) { # 'list' or 'array'
          $self->{$attr} = shift( @{$idat} ) if(@{$idat}); # shift list vals
        } elsif($ityp =~ /^h/i) {    # 'hash'
          # do some searching to find hash key that matches
          for(keys(%{$idat})) {
            if($attr =~ /$_/) {
              $self->{$attr} = $idat->{$_};
              delete($idat->{$_});
            }
          }
        } else { # undetected init type
          croak "!*EROR*! pKGnAME::new initialization type: $ityp did not match 'str', 'list', or 'hash'!\n";
        }
      }
    }
  }
  for my $attr ( @attz ) { # init defaults for any undefined fields
    $self->{$attr} = $self->_default_value($attr) unless(defined($self->{$attr}));
  }
# Handle Year shifts
  $self->{'_year' }  -= 2000;
#   0) Each 13 added to the Month adds  64 to the Year.
#   1)      24 added to the Hour  adds 256 to the Year.
#   2)      32 added to the Day   makes the year negative just before adding 2k
  # 4 month blocks go 0..51  (0..12, 13..25, 26..38, 39..51)
  $self->{'_month'}   = 39 if($self->{'_month'} > 51); # set value back to 0 of
  #   day   blocks go 0..63  (0..31, 32..63)
  $self->{'_day'  }   = 32 if($self->{'_day'  } > 63); # ...last blk if off end
  #   hour  blocks go 0..47  (0..23, 24..47)
  $self->{'_hour' }  %= 48;
  # min,sec,frm,jnk all 0..59
  $self->{'_minute'} %= 60; $self->{'_second'} %= 60;
  $self->{'_frame'}  %= 60; $self->{'_jink'}   %= 60;
  while($self->{'_month'} > 12) {
    $self->{'_year'} +=  64; $self->{'_month'} -= 13;
  }
  if   ($self->{'_hour'}  > 23) {
    $self->{'_year'} += 256; $self->{'_hour'}  -= 24;
  }
  if   ($self->{'_day'}   > 31) {
    $self->{'_year'} *=  -1; $self->{'_day'}   -= 32;
  }
  $self->{'_year'} += 2000;
  return($self);
}

sub subsecond { return(frame(@_)); }
sub _mon { # 0-based month
  my ($self, $nwvl) = @_;
  $self->{'_month'} = ($nwvl + 1) if(@_ > 1);
  return($self->{'_month'} - 1);
}
sub fullmonth { # full month string
  my ($self, $nwvl) = @_; my $mtch; my $mret;
  my @mnmz = Time::DayOfWeek::MonthNames();
  if(@_ > 1) {
    for($mtch=0; $mtch<@mnmz; $mtch++) {
      if($mnmz[$mtch] =~ /^$nwvl/i) {
        $self->{'_month'} = $mtch + 1; last;
      }
    }
  }
  $mret = $mnmz[(($self->{'_month'} - 1) % 12)];
  return($mret);
}
sub monname { # abbreviated month string
  my $monr = $_[0]->fullmonth();
  if   (@_ > 2) { $monr = $_[ $_[0]->M ];          }
  elsif(@_ > 1) { $monr = $_[0]->fullmonth($_[1]); }
  $monr = substr($monr, 0, 3) if(length($monr) > 3);
  return($monr);
}
sub _year { # 1900-based year
  my ($self, $nwvl) = @_;
  $self->{'_year'} = ($nwvl + 1900) if(@_ > 1);
  return($self->{'_year'} - 1900);
}
sub yy { # 2-digit year
  my ($self, $nwvl) = @_; my $yret;
  if(@_ > 1) {
    ($nwvl >= 70) ? $self->{'_year'} = '19' . $nwvl :
                    $self->{'_year'} = '20' . $nwvl;
  }
  $yret = sprintf("%04d", $self->{'_year'});
  return(substr($self->{'_year'}, 2, 2));
}
sub dow { # index of day of week
  my ($self, $nwvl) = @_;
  return(Time::DayOfWeek::DoW($self->YMD));
}
sub Dow { # abbrev. day name
  my ($self, $nwvl) = @_;
  return(Time::DayOfWeek::Dow($self->YMD));
}
sub DayOfWeek { # full day name
  my ($self, $nwvl) = @_;
  return(Time::DayOfWeek::DayOfWeek($self->YMD));
}
*day_of_week = \&dow;
*_wday       = \&dow;
sub wday     { return(dow(@_) + 1);  }
sub wdayname {
  return($_[ $_[0]->wday ]) if(@_ > 2);
  return(Dow(@_));
}
#*day         = \&Dow; # let day be day-of-month rather than Time::Piece wk-day
*fullday     = \&DayOfWeek;
sub   yday      { # day of year
  my ($self, $nwvl) = @_; my $summ = 0;
  if(@_ > 1) {
    for(my $m=1; $m<12; $m++) {
      if(($summ + days_in($self->{'_year'}, $m)) > $nwvl) {
        $self->{'_month'} = $m;
        $self->{'_day'}   = $nwvl - $summ;
        last;
      } else {
        $summ += days_in($self->{'_year'}, $m);
      }
    }
    $summ = $nwvl;
  } else {
    for(my $m=1; $m<$self->{'_month'}; $m++) {
      $summ += days_in($self->{'_year'}, $m);
    }
    $summ += ($self->{'_day'} - 1);
  }
# following compares my yday calculation to localtime's
#my @ltdt = localtime(timelocal($self->smhD, $self->_mon, $self->Y));
#print "!EROR!summ:$summ != ltdt:" . $ltdt[-2] . "\n" if($summ != $ltdt[-2]);
#print join('', $self->smhD) . $self->_mon . ($self->Y - 1900) . "\n" .  join('', @ltdt) . "\n";
  return($summ);
}
*day_of_year = \&yday;
# isdst should be computed by formula when I figure out how so that it
#   won't be restricted by UTC range that localtime expects.
sub isdst { # Is Daylight Savings Time?
  my ($self, $nwvl) = @_; # need 0-based month as timelocal() param
  my @ltdt = localtime(timelocal($self->smhD, $self->_mon, $self->Y));
  return($ltdt[-1]);
}
*daylight_savings = \&isdst;
sub    time { return(    hmsf(  @_)); }
sub alltime { return(    hmsfjz(@_)); }
sub    date { return( YMD(      @_)); }
sub alldate { return(CYMD(      @_)); }
sub pt7     { return( YMDhmsf(  @_)); }
sub all     { return(CYMDhmsfjz(@_)); }
*dt = \&all;
sub datetime { #  2000-02-29T12:34:56            (ISO 8601)
  return(sprintf("%04d-%02d-%02dT%02d:%02d:%02d", $_[0]->YMDhms()));
}
*cdate    = \&expand;
*compress = \&stringify;
# Add these to pod once imp'd
#    $t->epoch               # floating point seconds since the epoch
#    $t->tzoffset            # timezone offset in a Time::Seconds object
#
#    $t->julian_day          # number of days since Julian period began
#    $t->mjd                 # modified Julian date (JD-2400000.5 days)
#
#    $t->week                # week number (ISO 8601)
sub epoch { # floating point seconds since the epoch
  return(0);
}
sub tzoffset { # timezone offset in a Time::Seconds object
  return(0);
}
sub julian_day { # number of days since Julian period began
  return(0);
}
sub mjd { # modified Julian date (JD-2400000.5 days)
  return(0);
}
sub week { # week number (ISO 8601)
  return(0);
}
sub is_leap_year { # true if it is
  return(0);
}
sub month_last_day { # 28-31
  return(days_in($_[0]->YM));
}
sub time_separator { # set the default separator (default ":")
  $_[0]->{'__time_separator'} = $_[1] if(@_ > 1);
  return($_[0]->{'__time_separator'});
}
sub date_separator { # set the default separator (default "-")
  $_[0]->{'__date_separator'} = $_[1] if(@_ > 1);
  return($_[0]->{'__date_separator'});
}
sub day_list { # set the default weekdays
  my $self = shift;
  return(Time::DayOfWeek::DayNames(@_));
}
sub mon_list { # set the default months
  my $self = shift;
  return(Time::DayOfWeek::MonthNames(@_));
}
#sub AUTOLOAD { # methods (created as necessary)
#  no strict 'refs';
#  my ($self, $nwvl) = @_;
#  if     ($AUTOLOAD =~ /.*::[-_]?([CYMODhmisfjz])(.)?/i) {
#    my ($atl1, $atl2) = ($1, $2); my $atnm;
#    my @mnmz = Time::DayOfWeek::MonthNames();
#    $atl1 = 'O' if($atl1 eq 'm' && defined($atl2) && lc($atl2) eq 'o');
#    $atl1 = 'i' if($atl1 eq 'M' && defined($atl2) && lc($atl2) eq 'i');
#    $atl1 = 'O' if($atl1 eq 'M');
#    $atl1 = 'i' if($atl1 eq 'm');
#    $atl1 = 'O' if($AUTOLOAD =~ /.*::fullmon/i);
#    for my $attr ($self->_attribute_names()){
#      my $mtch = $self->_attribute_match($attr);
#      $atnm = $attr if(defined($mtch) && $atl1 =~ /$mtch/i);
#    }
#    if($atl1 eq 'O') {
#      if($AUTOLOAD =~ /.*::_/) { # 0-based month
#        *{$AUTOLOAD} = sub { $_[0]->{$atnm} = ($_[1] + 1) if(@_ > 1); return($_[0]->{$atnm} - 1); };
#        $self->{$atnm} = ($nwvl + 1) if(@_ > 1);
#        return($self->{$atnm} - 1);
#      } elsif($AUTOLOAD =~ /.*::(full)?mon(th|n)/i) { # abbrev. Mon Name
#        if(defined $1) { # store fullmon to do the matching
#          *{$AUTOLOAD} = sub {
#            my $mtch;
#            if(@_ > 1) {
#              for($mtch=0; $mtch<@mnmz; $mtch++) {
#                if($mnmz[$mtch] =~ /^$_[1]/i) {
#                  $_[0]->{$atnm} = $mtch + 1; last;
#                }
#              }
#            }
#            return($mnmz[(($_[0]->{$atnm} - 1) % 12)]);
#          };
#        } else { # store mon(th|n) as a wrapper that truncs fullmon
#          *{$AUTOLOAD} = sub {
#            my $monr = $_[0]->fullmonth();
#               $monr = $_[0]->fullmonth($_[1]) if(@_ > 1);
#            $monr = substr($monr, 0, 3) if(length($monr) > 3);
#            return($monr);
#          };
#        }
#        my $mtch; my $mret;
#        if(@_ > 1) {
#          for($mtch=0; $mtch<@mnmz; $mtch++) {
#            if($mnmz[$mtch] =~ /^$nwvl/i) {
#              $self->{$atnm} = $mtch + 1; last;
#            }
#          }
#        }
#        $mret = $mnmz[(($self->{$atnm} - 1) % 12)];
#        if($AUTOLOAD !~ /.*::full/i && length($mret) > 3) {
#          $mret = substr($mret, 0, 3);
#        }
#        return($mret);
#      }
#    }
#  # normal set_/get_ methods
#  if     ($AUTOLOAD =~ /.*::[sg]et(_\w+)/i) {
#    my $atnm = lc($1);
#    *{$AUTOLOAD} = sub { $_[0]->{$atnm} = $_[1] if(@_ > 1); return($_[0]->{$atnm}); };
#    $self->{$atnm} = $nwvl if(@_ > 1);
#    return($self->{$atnm});
#  # use_??? to set/get field filters
#  } elsif($AUTOLOAD =~ /.*::(use_\w+)/i) {
#    my $atnm = '__' . lc($1);
#    *{$AUTOLOAD} = sub { $_[0]->{$atnm} = $_[1] if(@_ > 1); return($_[0]->{$atnm}); };
#    $self->{$atnm} = $nwvl if(@_ > 1);
#    return($self->{$atnm});
#  # Alias methods which must be detected before sweeps
#  } elsif($AUTOLOAD =~ /.*::time$/i) {
#    *{$AUTOLOAD} = sub { return($self->hms()); };
#    return($self->hms());
#  } elsif($AUTOLOAD =~ /.*::dt$/i) {
#    *{$AUTOLOAD} = sub { return($self->CYMDhmsfjz()); };
#    return($self->CYMDhmsfjz());
#  } elsif($AUTOLOAD =~ /.*::mday$/i) { my $atnm = '_day';
#    *{$AUTOLOAD} = sub { $_[0]->{$atnm} = $_[1] if(@_ > 1); return($_[0]->{$atnm}); };
#    $self->{$atnm} = $nwvl if(@_ > 1); return($self->{$atnm});
#  # all joint field methods (e.g., YMD(), hms(), foo(), etc.
#  } elsif($AUTOLOAD =~ /.*::([CYMODhmisfjz][CYMODhmisfjz]+)$/i) {
#    my @fldl = split(//, $1);
#    my ($self, @nval) = @_; my @rval = (); my $atnm = ''; my $rgex;
#    # handle Month / minute exceptions
#    for(my $i=0; $i<$#fldl; $i++) {
#      $fldl[$i + 1] = 'O' if($fldl[$i] =~ /[yd]/i && $fldl[$i + 1] eq 'm');
#      $fldl[$i    ] = 'O' if($fldl[$i] eq 'm'     && $fldl[$i + 1] =~ /[yd]/i);$      $fldl[$i    ] = 'O' if($fldl[$i] eq 'M');
#      $fldl[$i    ] = 'i' if($fldl[$i] eq 'm');
#    }
#    *{$AUTOLOAD} = sub {
#      my ($self, @nval) = @_; my @rval = ();
#      for(my $i=0; $i<@fldl; $i++) {
#        for my $attr ($self->_attribute_names()){
#          my $mtch = $self->_attribute_match($attr);
#          if(defined($mtch) && $fldl[$i] =~ /^$mtch/i) {
#            $self->{$attr} = $nval[$i] if($i < @nval);
#            push(@rval, $self->{$attr});
#          }
#        }
#      }
#      return(@rval);
#    };
#    for(my $i=0; $i<@fldl; $i++) {
#      for my $attr ($self->_attribute_names()){
#        my $mtch = $self->_attribute_match($attr);
#        if(defined($mtch) && $fldl[$i] =~ /$mtch/i) {
#          $self->{$attr} = $nval[$i] if($i < @nval);
#          push(@rval, $self->{$attr});
#        }
#      }
#    }
#    return(@rval);
#  # sweeping matches to handle partial keys
#  } elsif($AUTOLOAD =~ /.*::[-_]?([CYMODhmisfjz])(.)?/i) {
#    my ($atl1, $atl2) = ($1, $2); my $atnm;
#    $atl1 = 'O' if($atl1 eq 'm' && defined($atl2) && lc($atl2) eq 'o');
#    $atl1 = 'i' if($atl1 eq 'M' && defined($atl2) && lc($atl2) eq 'i');
#    $atl1 = 'O' if($atl1 eq 'M');
#    $atl1 = 'i' if($atl1 eq 'm');
#    for my $attr ($self->_attribute_names()) {
#      my $mtch = $self->_attribute_match($attr);
#      $atnm = $attr if(defined($mtch) && $atl1 =~ /$mtch/i);
#    }
#    *{$AUTOLOAD} = sub { $_[0]->{$atnm} = $_[1] if(@_ > 1); return($_[0]->{$atnm}); };
#    $self->{$atnm} = $nwvl if(@_ > 1);
#    return($self->{$atnm});
#  } else {
#    my $fnam = $AUTOLOAD;
#    $fnam =~ s/Time::PT::/Time::Fields::/;
#    return(&$fnam);
#    croak "No such method: $AUTOLOAD\n";
#  }
#}
sub DESTROY { } # do nothing but define in case && to calm warning in test.pl
127;
# Desc: pKGnAME describes a simple object which encapsulates 10 fields:
#     Century, Year, Month, Day, hour, minute, second, frame, jink, zone
#   where frame is normally 1/60th-of-a-second && jink is normally
#   1/60th-of-a-frame.  The objects describe a high-precision time-
#   instant with fields in decending order of precision such that
#   alphabetic listings will (typically) show time ascension && field
#   arithmetic can be easily performed.  pKGnAME objects can
#   be added to / subtracted from Time::Frame objects to yield
#   new specific pKGnAME instants.
#     The common use of pKGnAME is for a simple `pt` utility to
#   en/decode dates && times using seven (7) Base64 characters.
#     1st: '0A1B2C3'
#     2nd: 'Yd:2003,j:A7_,M:a3I' or 'f:3aL9.eP'
#     if field name ends with d, value is read as decimal nstd of default b64.
#     Third way is super verbose decimal strings:
#       '15 years, 3 months, 7 weeks, 4 jinx' can use any (or none) sep but :
#     4th is hash
#     Total Jinx possible for PT: 1,680,238,080,000,000 (1.7 quatrillion)
#           JnxPTEpoch -> `pt __nWO0000` -> Midnight Jan. 1 7039 BCE
#              PTEpoch -> `pt  _nWO`     -> Midnight Jan. 1 1361  CE
#   pKGnAME members:
#     new inits either with pt-param, expanded, or empty
#
#       epoch_(seconds|frames|jinx)() methods (optional frames/jinx as floats)
#     ptepoch_(seconds|frames|jinx)() methods
#       (since ptEpoch (`pt _nWO` Midnight, Jan1,1361))
#     settle fields with options (like return new Frame object with only
#       total secs of old)
#     re-def frame as other than 60th-of-a-second
#     re-def jink  as other than 60th-of-a-frame
#       e.g., def f && j limits as 31.6227766016838 (sqrt(1000)) for ms jinx
#           or just def f as 1000 for exactly ms frames
#     allow month/year modes to be set to avg or relative
#
#  My Base64 encoding uses characters: 0-9 A-Z a-z . _  since I don't like
#    having spaces or plusses in my time strings.  I need times to be easy to
#    append to filenames for very precise, consice, time-stamp versioning.
#  Each encoded character represents (normally) just a single date or time
#    field.  All fields are 0-based except Month && Day.  The fields are:
#      Year-2000, Month, Day, Hour, Minute, Second, Frame (60th-of-a-second)
#  There are three (3) exceptions to the rule that each character only
#    represents one date or time field.  The bits are there so... why not? =)
#  0) Each 12 added to the Month adds  64 to the Year.
#  1)      24 added to the Hour  adds 320 to the Year.
#  2)      31 added to the Day   makes the year negative just before adding
#            2000.
#  So with all this, any valid pt (of 7 b64 characters) represents a unique
#    instant (precise down to a Frame [60th-of-a-second]) that occurred or
#    will occur between the years 1361 && 2639 (e.g., New Year's Day of each
#    of those years would be '_nWO' && '_n1O').  These rules break down as:
# Hour   Day  Month     Year    YearWith2000
# 24-47 32-62 49-60  -639- -576  1361-1424
#             37-48  -575- -512  1425-1488
#             25-36  -511- -448  1489-1552
#             13-24  -447- -384  1553-1616
#              1-12  -383- -320  1617-1680
#  0-23 32-62 49-60  -319- -256  1681-1744
#             37-48  -255- -192  1745-1808
#             25-36  -191- -128  1809-1872
#             13-24  -127-  -64  1873-1936
#              1-12   -63-   -0  1937-2000
#  0-23  1-31  1-12     0-   63  2000-2063
#             13-24    64-  127  2064-2127
#             25-36   128-  191  2128-2191
#             37-48   192-  255  2192-2255
#             49-60   256-  319  2256-2319
# 24-47  1-31  1-12   320-  383  2320-2383
#             13-24   384-  447  2384-2447
#             25-36   448-  511  2448-2511
#             37-48   512-  575  2512-2575
#             49-60   576-  639  2576-2639
# Notz:
#  PT + Frame can become the core of a new input language which accounts
#    for time.  It could be game sequences like a fireball that can be rolled
#    from d->df && df->f only at a certain speed ... but then also later
#    maybe time-sensitive computer input like typematic key repeat rate but
#    configurable... smarter?  The combinatorics on the X-Box Live pswd is
#    8**4 == 4096 (butn: u,d,l,r,x,y,L,R) so even exhausting the search space
#    (assuming you're too wise for a smpl likely 4-char sequence) could be
#    finished manually in about 9 hours if you complete a test cycle each
#    8 seconds.  Automated would need programmable circuit... plug that
#    thang into USB && make an easy sequencer PT+Frame- based IF to perform!
#    So cool!
#  Could create an easy IF to setup any sort of practice scenario,
#    programmable pad behavior, or even store replays as device inputs &&
#    feed them back in... woohoo that's fscking cool!  GameOver specialty =)
#    umm it would basically need the same IF as a fighting game tool hehe =).
#  Don't need Math::BigInt to store pt epoch seconds (pte's) because perl's
#    floats already have enough precision to store them.  Use the fractional
#    part of those values to store 60ths && don't use builtin timelocal
#    functions which only accept 1970-2036 (or whatever limited) epoch
#    seconds (only 32-bit ints or something =( ).
#  Interaction with other Time modules:
#    Time::Period  - just have an Epoch export option && Period can use it
#    Time::Avail   - doesn't seem useful to my purposes
#    Time::Piece   - might be nice to mimic this module's object interface
#    Time::Seconds - handy for dealing with lots of seconds but about 60ths?
#  old 5-char pt examples: (update these when there's time)
# Xmpl: `pt 01`        == localtime(975657600) # seconds since Epoch
#     `pt 1L7Mu`       == unpack time (Sun Jan 21 07:22:56 2001)
#     `pt _VNxx`       == localtime(1143878399)
#     `pt pt`          == unpack current pt (akin to `pt `pt``)
#     `pt e`           == localtime  (e.g., Thu Jan 21 07:22:56 2001)
#     `pt e e`         == current epoch seconds
#     `pt 1L7Mu e`     == convert from pt to epoch (980090576)
#     `pt 975657600 E` == convert from Epoch seconds to pt (01)
#     `pt Jan 21, 2001 07:22:56`    -> 1L7Mu
#     `pt Sun Jan 21 07:22:56 2001` -> 1L7Mu
#     `pt 1L7Mu cmp FEET0`          -> lt
#     `pt FEET0 cmp 1L7Mu`          -> gt
#     `pt 2B cmp 2B`                -> eq
#       timelocal($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
#
# 61EJjbT - I've realized that I need to be able to clearly specify any Year
#  (or just Year,Month) in isolation so I need to amend the rules for
#  computing years for this purpose.
#
#  I'm thinking they should change to:
#  0) Each 13 added to the Month adds  64 to the Year.
#  1)      24 added to the Hour  adds 256 to the Year.
#  2)      32 added to the Day   makes the year negative just before adding
#            2000.
#  The Month and Day blocks now begin at 0 for isolating broader fields.
#  So with all this (and a new understanding of a 0 Day and/or Month), lone
#    Years can span 1489-2511 (with any optional months therein).
#    (e.g., New Year's Day of each of those years would be '_eXO' && '_e1O').
#  The new rules break down as:
# Hour   Day  Month     Year    YearWith2000
# 24-47 33-63 40-51  -511- -448  1489-1552
#             27-38  -447- -384  1553-1616
#             14-25  -383- -320  1617-1680
#              1-12  -319- -256  1681-1744
#  0-23 33-63 40-51  -255- -192  1745-1808
#             27-38  -191- -128  1809-1872
#             14-25  -127-  -64  1873-1936
#              1-12   -63-   -0  1937-2000
#  0-23  1-31  1-12     0-   63  2000-2063
#             14-25    64-  127  2064-2127
#             27-38   128-  191  2128-2191
#             40-51   192-  255  2192-2255
# 24-47  1-31  1-12   256-  319  2256-2319
#             14-25   320-  383  2320-2383
#             27-38   384-  447  2384-2447
#             40-51   448-  511  2448-2511
# 61FEL3S - 8-char PT's should append zone, 9: jinx,zone, 10: prepends Century
# 779Jm86 - 8-char PT's should append jinx for simplicity

=head1 NAME

fULnAME - objects to store an instant in time

=head1 VERSION

This documentation refers to version pKGvERS of
fULnAME, which was released on ptptIME.

=head1 SYNOPSIS

  use fULnAME;
  
  my $f = fULnAME->new();
  
  print "PakTime is: $f\n";
  print 'The Day-of-Week today is: ', $f->dow(), "\n";

=head1 DESCRIPTION

By default, fULnAME stores time descriptions precise to 60ths-
of-a-second (0.016667 seconds).  The groundwork has been laid
for sub-millisecond precision to be included later.

This module has been adapted from the L<Time::Piece> module
written by Matt Sergeant <matt@sergeant.org> && Jarkko
Hietaniemi <jhi@iki.fi>.  fULnAME inherits base
data structure && object methods from L<Time::Fields>.
pKGnAME was written to simplify storage && calculation
of encoded, yet distinct && human-readable, time data
objects.

This module (fULnAME) does not replace the standard localtime &&
gmtime functions like L<Time::Piece> but fULnAME objects behave
almost identically to L<Time::Piece> objects otherwise (since it
was adapted from... I said that already =) ).

=head1 2DO

=over 2

=item - add Time::Zone stuff to use && match zone field reasonably

=item - updt all POD to reflect new year shifts

=item - mk interoperable w/ Time::Seconds objects

=item - export a pt() again w/ tested new() wrapper && fix all apps to
          use objs instead of local pt()

=item - flesh out constructor init data parsing && formats supported

=item - consider epoch functions like _epoch([which epoch]) or individuals
          like _jinx_epoch()

=item - mk PT->new able to create from different 'epoch' init types

=item -     What else does pKGnAME need?

=back

=head1 WHY?

The reason I created pKGnAME was that I have grown so enamored with
Base64 representations of everything around me that I was
compelled to write a simple clock utility ( `pt` ) using Base64.
This demonstrated the benefit to be gained from time objects with
distinct fields && configurable precision.  Thus, L<Time::Fields>
was written to be the abstract base class for:

  Time::Frame  ( creates objects which represent spans    of time )
      &&
  Time::PT     ( creates objects which represent instants in time )

=head2 HOW?

I've made up some silly sentences as mnemonic devices to help me
remember every 4th uppercase Base64 character:

  Can      12   Noon       MonthOfYear will be less or equal to 'C'.
  Goats    16   4 PM
  Keep     20   8 PM
  Oats     24   Midnight   HourOfDay   will be less than        'O'.
  Some     28
  Where?   32              DayOfMonth  will be less than        'W'.

  Cool    COW (Month Hour Day thresholds)
  Guys    Girls
  Keep    Keep
  On      On                   Off
  Sayin'  Sayin'      Sippin'  Sea
  Wassup  WeeDoggies  Water    Water

  The real extents for MDh are CVN and for msfj are xxxx.

=head1 USAGE

Many of fULnAME's methods have been patterned after the excellent
L<Time::Piece> module written by Matt Sergeant <matt@sergeant.org>
&& Jarkko Hietaniemi <jhi@iki.fi>.

=head2 new(<InitType>, <InitData>)

fULnAME's constructor can be called
as a class method to create a brand new object or as an object
method to copy an existing object.  Beyond that, new() can
initialize pKGnAME objects 3 different ways:

  * <packedB64InitStringImplies'str'>
    e.g., fULnAME->new('3C79jo0');
  * 'str'  => <packedB64InitString>
    e.g., fULnAME->new('str'  => '0A1B2C3D4E');
  * 'list' => <arrayRef>
    e.g., fULnAME->new('list' => [0, 1, 2..9]);
  * 'hash' => <hashRef>
    e.g., fULnAME->new('hash' => {'jink' => 8, 'year' => 2003})

=head2 color(<DestinationColorTypeFormat>)

This is an object member
which will join Base64 representations of each field that has
been specified in use() && joins them with color-codes or color
escape sequences with formats for varied uses.  Currently
available DestinationColorTypeFormats are:

  'ANSI'  # e.g., \e[1;32m
  'zsh'   # e.g., %{\e[1;33m%}
  'vim'   # e.g., %1*           # assuming .vimrc has :hi User[1..7] ...
  'HTML'  # e.g., <a href="HTTP://Ax9.Org/pt?"><font color="#FF1B2B">
  '4NT'   # e.g., color 09 &
  'Simp'  # e.g., RbobYbGbCbUbPb

=head2 ptcc(<DestinationColorTypeFormat>)

Returns the Simp color code string appropriate for pt (PakTime) data.

  Format   Returned color code string
   'k'     the background will change along with the foreground for standard
             time-of day elements (i.e., hms on a dark blue background)
   'f'     color codes for the expanded pt format
             (e.g., color codes corresponding to Sun Jan  4 12:41:48:13 2004)

This function is the only one exported when fULnAME is used.  All other use
of this module should be done through objects created with new().

The following methods allow access to individual fields of
fULnAME objects:

  $t->C  or  $t->century
  $t->Y  or  $t->year
  $t->M  or  $t->month
  $t->D  or  $t->day
  $t->h  or  $t->hour
  $t->m  or  $t->minute
  $t->s  or  $t->second
  $t->f  or  $t->frame
  $t->j  or  $t->jink
  $t->z  or  $t->zone

Please see L<Time::Fields> for further description of field
accessor methods.

After importing this module, when you use localtime or gmtime in a
scalar context, you DO NOT get a special fULnAME object like you
would when using L<Time::Piece>.  This module relies on a new()
constructor instead.  The following methods are available on
fULnAME objects though && remain as similar to L<Time::Piece>
functionality as makes sense.

  $t->frm                 # also as $t->frame && $t->subsecond
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
                 # differently from Time::Piece.  pKGnAME's day() is the
                 # same as mday() instead of wdayname().
  $t->fullday             # Tuesday
  $t->yday                # also available as $t->day_of_year, 0 = Jan 01
  $t->isdst               # also available as $t->daylight_savings

The following functions return a list of the named fields.  The
return value can be joined with any desirable delimiter like:

  join(':', $t->hms);
  join($t->time_separator, $t->hms);

but the functions also can take a list of parameters to update
the corresponding named fields like:

  $t->YMD( 2003, 12, 8 ) # assigns new date of December 8th, 2003 to $t

Following are some useful functions && comments of sample return values:

  $t->hms                 # [12, 34, 56]
  $t->hmsf                # [12, 34, 56, 12]
  $t->time                # same as $t->hmsf

  $t->ymd                 # [2000,  2, 29]
  $t->date                # same as $t->ymd
  $t->mdy                 # [ 2, 29, 2000]
  $t->dmy                 # [29,  2, 2000]
  $t->datetime            # 2000-02-29T12:34:56            (ISO 8601)
  $t->expand              # Tue Feb 29 12:34:56:12 2000
  $t->cdate               # same as $t->expand
  $t->compress            # 02TCYuC
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
simple localization.

  my @days = ( 'Yom Rishone', 'Yom Shayni', 'Yom Shlishi', 'Yom Revi\'i',
               'Yom Khahmishi', 'Yom Hashishi', 'Shabbat' );

  my $hebrew_day = pt->wdayname(@days);
                 # pt->monname() can be used similarly

To update the global lists, use:

  fULnAME::day_list(@days);
    &&
  fULnAME::mon_list(@months);

=head2 Calculations

PT object strings (both in normal initialization && printing) grow
left-to-right starting from the Year to specify whatever precision
you need while Frame objects grow right-to-left from the frame field.

It's possible to use simple addition and subtraction of objects:

  use Time::Frame;
  
  my $cur_pt       = Time::PT->new();# Dhmsf
  my $one_week     = Time::Frame->new('70000');
  my $one_week_ago = $cur_pt - $one_week;

If a calculation is done with a raw string parameter instead of an
instantiated object, the most likely appropriate object
constructor is called on it.  These init strings must adhere to
the implied 'str' format for auto-creating objects;  I aim to
support a much wider array of operations && to make this module
smoothly interoperate with both L<Time::Piece> && L<Time::Seconds>
someday but not yet.

  my $cur_pt             = Time::PT->new();
  my $half_hour_from_now = $cur_pt + 'U00';

The following are valid (where $t0 and $t1 are fULnAME objects
&& $f is a Time::Frame object):

  $t0 - $t1;  # returns Time::Frame object
  $t0 - '63'; # returns Time::PT object
  $t0 + $f;   # returns Time::PT object

=head2 Comparisons

All normal numerical && string comparisons should work reasonably on
fULnAME objects:

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
first Thursday of the year.  In other words, if the first Monday of
January is the 2nd, 3rd, or 4th, the preceding days are part of the
final week of the prior year.  Week numbers range from 1 to 53.

=head1 NOTES

Whenever individual fULnAME attributes are going to be
printed or an entire object can be printed with multi-colors,
the following mapping should be employed whenever possible:

           D      Century -> DarkRed
           A      Year    -> Red
           T      Month   -> Orange
           E      Day     -> Yellow
                   hour   -> Green
            t      minute -> Cyan
            i      second -> Blue
            m      frame  -> Purple
            e      jink   -> DarkPurple
                   zone   -> Grey or White

Please see the color() member function in the USAGE section.

There's some weird behavior for PakTimes created with a zero month
or day field since both are 1-based.  I aim to fix all these bugs
but be warned that this issue may be causing math errors for a bit.

I hope you find fULnAME useful.  Please feel free to e-mail
me any suggestions || coding tips || notes of appreciation
("app-ree-see-ay-shun").  Thank you.  TTFN.

=head1 CHANGES

Revision history for Perl extension fULnAME:

=over 4

=item - pKGvERS  ptptIME

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

* moved Curses::Simp::ptCC into Time::PT::ptcc for PT-specific Simp
    Color Codes

* created Time::Fields::_field_colors (centralized base class color codes)
    && updated Frame && PT _color_fields

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

    `perl -MCPAN -e "install fULnAME"`

or uncompress the package && run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 FILES

fULnAME requires:

L<Carp>                to allow errors to croak() from calling sub

L<Math::BaseCnv>       to handle simple number-base conversion

L<Time::DayOfWeek>       also stores global day && month names

L<Time::DaysInMonth>

L<Time::Fields>        to provide underlying object structure

L<Time::Frame>         to represent spans of time

fULnAME uses (if available):

L<Time::HiRes>         to provide subsecond time precision

L<Time::Local>         to turn epoch seconds back into a real date

L<Time::Zone>           not utilized yet

=head1 SEE ALSO

L<Time::Frame>

=head1 LICENSE

Most source code should be Free!  Code I have lawful authority over is && shall be!
Copyright: (c) 2002-2007, Pip Stuart.
Copyleft : This software is licensed under the GNU General Public License (version 3).  Please consult the Free Software Foundation (HTTP://FSF.Org)
  for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut

