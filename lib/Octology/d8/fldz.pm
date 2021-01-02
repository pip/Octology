# D8FMMHPM:Octology::d8::fldz.pm crE8d by PipStuart <Pip@CPAN.Org> as a base class for specialized d8 objects (Octology::d8 and Octology::d8::dur8);
package    Octology::d8::fldz;
use strict;use warnings;use utf8;use v5.10;
use vars qw( $AUTOLOAD );
my $VERSION='0.0';my $d8VS='L11L9Fls';
use overload
  q("") => sub{ # anonymous verbose fldz stringify()
             my @fdat=$_[0]->YMDzhmsp();
             my @attz=$_[0]->_attribute_names();my $tstr='';my $vrbf=1;
             for(my $i=0;$i<@fdat;$i++){
               $fdat[$i]=0 unless(defined($fdat[$i]));
               if($vrbf){$tstr.=$attz[$i].':'.$fdat[$i];$tstr.=', ' if($i<$#fdat);}
               else     {$tstr.=          b64($fdat[$i]);}
             } return($tstr);};
use Octology::a8;
use Octology::b8;
use Carp;my @d8bo=split(//,$cmap{'d8bo'}); # setup what was a8.pm ColorMAP originally for pal8, then 8bow, then d8bo here (were RoYGCBMp B4 YGTBUDSN);
         my @d8bl=split(//,$cmap{'d8bl'}); # setup FDAL layerz 2;
         my @d8bs=split(//,$cmap{'d8bs'}); # setup SGR  planez 2;
my $locl=eval("use Time::Local           ; 1") || 0; # 2nd d8bo was:  Yellow, Green, Turquoise, Blue,   bisqUe, oliveDrab, Skyblue, Navy;
my $hirs=eval("use Time::HiRes qw(usleep); 1") || 0; # hopefully usleep or nanosleep can be loaded like this
my   @_attrnamz=split(//,'YMDzhmsp');my %_attrdflt=();$_attrdflt{$_    }=  0 for(@_attrnamz); # ordered attribute names array && default value (0) hash
push(@_attrnamz,'_pps'             );   $_attrdflt{'_pps'              }= 60; # r8io of phasses-per-second
push(@_attrnamz,'_time_separator'  );   $_attrdflt{'_time_separator'   }=':'; # might utilize these fields for more configurable printing l8r
push(@_attrnamz,'_date_separator'  );   $_attrdflt{'_date_separator'   }='-'; # might utilize these fields for more configurable printing l8r
my %_fielclrz=( # global field color codes in a hash of arrays
  'c' => [       $d8bo[0] ,          # Year    c8 col8 colr codz
                 $d8bo[1] ,          # Month   # K5IMMUOl:s/RoMp/Newz/;
                 $d8bo[2] ,          # Day
                 $d8bo[3] ,          #  zone
                 $d8bo[4] ,          #  hour
                 $d8bo[5] ,          #  minute
                 $d8bo[6] ,          #  second
                 $d8bo[7] ],         #  phass
  '4' => [            '0c',          # Year    4NT # stil nEd2 YGTBUDSN 4hw
                      '06',          # Month
                      '0e',          # Day
                      '0a',          #  zone
                      '0b',          #  hour
                      '09',          #  minute
                      '0d',          #  second
                      '05'],         #  phass
  'h' => [          '_6A_',          # Year    web (Html) dRk h (2du: fil in l8r wi a8:drkh() mAB as RGBl form nstd of HEX
                    '_UA_',          # Month
                    '__6_',          # Day
                    '6_E_',          #  zone
                    '6___',          #  hour
                    '6U__',          #  minute
                    'k6__',          #  second
                    'U2l_'],         #  phass
  'w' => [        'FF1B2B',  #'_6A_' # Year    web (HTML)
                  'FF7B2B',  #'_UA_' # Month
                  'FFFF1B',  #'__6_' # Day
                  '1BFF3B',  #'6_E_' #  zone
                  '1BFFFF',  #'6___' #  hour
                  '1B7BFF',  #'6U__' #  minute
                  'BB1BFF',  #'k6__' #  second
                  '7B0BBF'], #'U2l_' #  phass
  'a' => [     S("$d8bl[0]:$d8bo[0]$d8bs[0]"),          # Year    ANSI (calling a8:S to gener8 SKp codez)
               S("$d8bl[1]:$d8bo[1]$d8bs[1]"),          # Month
               S("$d8bl[2]:$d8bo[2]$d8bs[2]"),          # Day
               S("$d8bl[3]:$d8bo[3]$d8bs[3]"),          #  zone
               S("$d8bl[4]:$d8bo[4]$d8bs[4]"),          #  hour
               S("$d8bl[5]:$d8bo[5]$d8bs[5]"),          #  minute
               S("$d8bl[6]:$d8bo[6]$d8bs[6]"),          #  second
               S("$d8bl[7]:$d8bo[7]$d8bs[7]")],         #  phass
  'z' => ["%{".S("$d8bl[0]:$d8bo[0]$d8bs[0]")."%}",     # Year    zsh (wrapping ANSI)
          "%{".S("$d8bl[1]:$d8bo[1]$d8bs[1]")."%}",     # Month
          "%{".S("$d8bl[2]:$d8bo[2]$d8bs[2]")."%}",     # Day
          "%{".S("$d8bl[3]:$d8bo[3]$d8bs[3]")."%}",     #  zone
          "%{".S("$d8bl[4]:$d8bo[4]$d8bs[4]")."%}",     #  hour
          "%{".S("$d8bl[5]:$d8bo[5]$d8bs[5]")."%}",     #  minute
          "%{".S("$d8bl[6]:$d8bo[6]$d8bs[6]")."%}",     #  second
          "%{".S("$d8bl[7]:$d8bo[7]$d8bs[7]")."%}"],);  #  phass  # below try2only use new exclusively dflt Bold colrs from 256 palette where they are supported
if(exists($ENV{'DISPLAY'}) || (exists($ENV{'TERM'}) && $ENV{'TERM'}=~ /^(sakura|u?rxvt|st|u?xterm)/ && $ENV{'TERM'} ne 'linux')){$_fielclrz{'a'} = [
  # maybe there are yet better ways to detect when most likely wanting colors from the full-screen text console(in.zshrc?) or betr thngz mising?
               S("$d8bl[0]:$d8bo[0]$d8bs[0]"),          # Year    ANSI (calling a8:S to gener8 SKp codez)
               S("$d8bl[1]:$d8bo[1]$d8bs[1]"),          # Month
               S("$d8bl[2]:$d8bo[2]$d8bs[2]"),          # Day
               S("$d8bl[3]:$d8bo[3]$d8bs[3]"),          #  zone
               S("$d8bl[4]:$d8bo[4]$d8bs[4]"),          #  hour
               S("$d8bl[5]:$d8bo[5]$d8bs[5]"),          #  minute
               S("$d8bl[6]:$d8bo[6]$d8bs[6]"),          #  second
               S("$d8bl[7]:$d8bo[7]$d8bs[7]")];         #  phass
  $_fielclrz{'z'} = [
          "%{".S("$d8bl[0]:$d8bo[0]$d8bs[0]")."%}",     # Year    zsh (wrapping ANSI)
          "%{".S("$d8bl[1]:$d8bo[1]$d8bs[1]")."%}",     # Month
          "%{".S("$d8bl[2]:$d8bo[2]$d8bs[2]")."%}",     # Day
          "%{".S("$d8bl[3]:$d8bo[3]$d8bs[3]")."%}",     #  zone
          "%{".S("$d8bl[4]:$d8bo[4]$d8bs[4]")."%}",     #  hour
          "%{".S("$d8bl[5]:$d8bo[5]$d8bs[5]")."%}",     #  minute
          "%{".S("$d8bl[6]:$d8bo[6]$d8bs[6]")."%}",     #  second
          "%{".S("$d8bl[7]:$d8bo[7]$d8bs[7]")."%}"]; }  #  phass
sub _default_value{my($self,$attr)=@_;$_attrdflt{$attr}} # methods
sub _attribute_names{@_attrnamz}
sub _Time_Local{$locl} # can Time::Local be used?
sub _Time_HiRes{$hirs} # can Time::HiRes be used?
sub _sift{ # settles fields into standard ranges (for overflow from add/sub)
  my $self=shift;my $mdon=shift||0;my $dinf=0;
  unless($mdon){
    while($self->{'p'}< 0                                   ){
      $self->{    'p'}+=    $self->{'_pps'};$self->{'s'}--;  }
    while(                  $self->{'p'}  >=$self->{'_pps'} ){
      $self->{    'p'}-=    $self->{'_pps'};$self->{'s'}++;  }
    while($self->{'s'}< 0                                   ){
      $self->{    's'}+=                 60;$self->{'m'}--;  }
    while(                  $self->{'s'}  >=              60){
      $self->{    's'}-=                 60;$self->{'m'}++;  }
    while($self->{'m'}< 0                                   ){
      $self->{    'm'}+=                 60;$self->{'h'}--;  }
    while(                  $self->{'m'}  >=              60){
      $self->{    'm'}-=                 60;$self->{'h'}++;  }
    while($self->{'h'}< 0                                   ){
      $self->{    'h'}+=                 24;$self->{'D'}--;$self->{'D'}-- unless($self->D());} # decrement again past 0
    while(                  $self->{'h'}  >=              24){
      $self->{    'h'}-=                 24;$self->{'D'}++;  }
#   $dinf=1 unless(defined($self->{'M'}) && $self->{'M'});
#   $self->{'M'}=1 if($dinf); # probably will need special handling of allowable 0 Day or Month which shouldn't alter larger field
#   while($self->{'D'}< 0                                   ){ # this will probably also need to lookup adjacent days_in values to alter most logically
#     $self->{    'D'}+= days_in($self->YM);$self->{'M'}--;$self->{'M'}-- unless($self->M());}
#   while(                  $self->{'D'}> days_in($self->YM)){ # maybe just days_in is breaking d8obj += dur8obj?
#     $self->{    'D'}-= days_in($self->YM);$self->{'M'}++;  }
    while($self->{'M'}< 0                                   ){
      $self->{    'M'}+=                 12;$self->{'Y'}--;  }
    while(                  $self->{'M'}>                 12){
      $self->{    'M'}-=                 12;$self->{'Y'}++;  }
#   $self->{'M'}-- if($dinf);
  }else{
    while($self->{'M'}< 0                                   ){
      $self->{    'M'}+=                 12;$self->{'Y'}--;  }
    while(                  $self->{'M'}>                 12){
      $self->{    'M'}-=                 12;$self->{'Y'}++;  }}}
sub w8{my $self=shift(@_);my $dur8;my $durs; # crE8 a new 'wait' method which should maybe just export from dur8.pm instead? expects dur8 obj or dur8 str param
  if  ( $self->isa('Octology::d8::dur8')){$dur8=$self;} # from HTTPS://PerlDoc.Perl.Org/functions/ref.html && ../perlobj.html betr2 UNIVERSAL->isa($class)
  else{   $dur8=shift(@_) || '0';
    if(!$dur8->isa('Octology::d8::dur8')){$dur8=~ s/[^0-9A-Za-z._]+//g; # strip non-b64 characters before trying to crE8 a new dur8 object from string param
          $dur8=  Octology::d8::dur8->new($dur8);}} # 2du:allow float b64 phasses ('F%W') above or in dur8 new to enable more precise HiRes w8ing here
  $durs= "$dur8"; # get a valid dur8ion object stringified to valid8 field values against
  if(length($durs) && $durs=~ /[1-9A-Za-z._]/){my $dsec=0 ; # valid dur8ion string should contain a non-zero b64 char (probably actually only up to 'x' 59)
    $dsec+= $dur8->{'s'}              if($dur8->{'s'} > 0);
    $dsec+= $dur8->{'m'}*60           if($dur8->{'m'} > 0);
    $dsec+= $dur8->{'h'}*60*60        if($dur8->{'h'} > 0); # eventually would probably be good to take zone offsetting hour into account somehow here too
    $dsec+= $dur8->{'D'}*60*60*24     if($dur8->{'D'} > 0);
    $dsec+= $dur8->{'M'}*60*60*24*30  if($dur8->{'M'} > 0); # maybe Month shouldn't always be exactly 30 days,but any w8 that long should be by cronjob anyway
    $dsec+= $dur8->{'Y'}*60*60*24*365 if($dur8->{'Y'} > 0);
    if     ($dur8->{'p'}                              > 0){ # could also Time::HiRes::sleep(dsec+frmz/60) instead of trying microsecs below
      if($hirs){usleep($dsec*1000000 + int((1000000.0/60.0)*$dur8->{'p'}     ));}  # get the floor of the dur8ion's phasses in microseconds to wait for
      else     {select(undef, undef, undef,($dsec*1.0 +     $dur8->{'p'}/60.0));}} # try select built-in with sub-sec precision as hopefully capable fallback
    else       { sleep($dsec);}}} # or just regular sleep whatever whole seconds are in the dur8ion object
# Octology::d8::fldz object constructor as class method or copy as object method.
# First param can be ref to copy. Not including optional ref from
#   copy, default is no params to create a new empty fldz object.
# If params are supplied, they must be a single key && a single value.
# The key must be one of the following 3 types of constructor
#   initialization mechanisms:
#     0) 'str'  => <packedB64InitString>  (eg. 'str'  => 'ABCDEFGH')
#     1) 'array'=> <arrayRef>             (eg. 'array'=> [0, 1, 2..7])
#     2) 'hash' => <hashRef>              (eg. 'hash' => {'h' => 8})
sub new{
  my($nvkr,$ityp,$idat)=@_;
  my $nobj=ref($nvkr); # 2du:replace all old obj ref class tests with isa instead
  my $clas=$ityp;
  $clas=$nobj|| $nvkr if(!defined($ityp)|| $ityp!~ /::/);
  my $self=bless({},$clas);
  for my $attr($self->_attribute_names()){
    $self->{$attr}=$self->_default_value($attr); # init defaults
    $self->{$attr}=$nvkr->{$attr} if($nobj);}    #  && copy if supposed to
  if(defined($ityp)&& $ityp!~ /::/){ # there were init params with no colon (classname)
    ($ityp,$idat)=('str',$ityp) unless(defined($idat));
    for my $attr($self->_attribute_names()){
      if    ($ityp=~ /^s/i){ # 'str'
        $self->{$attr}=b10($1) if($idat=~ s/^(.)//); # break down string
      }elsif($ityp=~ /^l/i){ # 'array'
        $self->{$attr}=shift(@{$idat}) if(@{$idat}); # shift array vals
      }elsif($ityp=~ /^h/i){ # 'hash'
        # do some searching to find hash key that matches
        for(keys(%{$idat})){
          if($attr=~ /$_/){
            $self->{$attr}=$idat->{$_};
            delete($idat->{$_});}}
      }else{croak "!*EROR*! Octology::d8::fldz::new initialization type: $ityp did not match 'str', 'array', or 'hash'!\n";}} # undetected init type
  }return($self);}
sub _field_colors{ # return the color code array associated with a type
  my $self=shift;my $type=shift;$type='a' unless(defined($type)&& exists($_fielclrz{lc($type)}));
  return($_fielclrz{lc($type)});}
# adds color codes corresponding to each field according to ColorTYPe
# (/^c/i) ? c8                  color codes (like Curses::Simp)
# (/^w/i) ? web links && font   color tag delimiters
# (/^4/i) ? 4NT verbose         color codes
# (/^v/i) ? vim User highlight  color codes
# (/^a/i) ? ANSI (default)      color escapes
# (/^z/i) ? ANSI wrapped in zsh color     delimiters like %{ $ANSI %};
sub _color_fields{ # return a color string for a fldz object
  my $self=shift;my $fstr=shift;$fstr=' 'x8 unless(defined($fstr)&& length($fstr)); # used to trunc8 trailing zeroes here
  my $ctyp=shift|| 'a';my @clrz=@{$self->_field_colors($ctyp)};my $coun=0;my $rstr='';
  if    ($ctyp=~ /^c/i){$rstr=join('',@clrz); # this will just be ROYGCBMP without field values, although maybe they should interleave?
  }elsif($ctyp=~ /^w/i){$_   ='<font color="#'.$_.'">'        for(@clrz); # wrap web HTML RRGGBB with colored font tags
    $rstr ='<a href="HTTP://Ax9.Org/d8?'.$fstr.'">';
    $rstr.=$clrz[$coun].substr($fstr,$coun++,1).'</font>' while(length($fstr)> $coun);
    $rstr.='</a>';
  }elsif($ctyp=~ /^4/i){$_   =   ' & color '  .$_.' & echos ' for(@clrz); # wrap 4NT with verbose tags
    $rstr.=$clrz[$coun].substr($fstr,$coun++,1)           while(length($fstr)> $coun);
  }elsif($ctyp=~ /^v/i){
    for(my $i=0;$i<=length($fstr);$i++){$clrz[$i]='%'.($i+1).'*';} # gener8 vim ascending index codes
    $rstr.=$clrz[$coun].substr($fstr,$coun++,1)           while(length($fstr)> $coun);
  }else{ # default anything else assumes 'a' (or 'z' wrapping) ANSI
   #$rstr.=$clrz[$coun].substr($fstr,$coun++,1)           while(length($fstr)> $coun);if($ctyp=~ /^z/i){$rstr.='%{'.$z.'%}';}else{$rstr.=$z;}
   # this whole looping approach completely assumes max-length is 8, so coun should never exceed boundz of @clrz but obvious super-Xpanded 4m@ aparNtly 41long
    if   (length($fstr)> 8    ){substr($fstr,8,(length($fstr)-8),'');$fstr=~ s/[^0-9a-z._]/-/gi;} # chop longz off, until betr Dtectn && resolv is Dtermind?
    while(length($fstr)> $coun){my $tccs=$z;$tccs=$clrz[$coun] if(defined($clrz[$coun])); # try to mitig8 uninit val in cat or strng warnz wi TmpClrzCounStr
     #if (!defined($clrz[$coun])){$rstr.="WarnCoun:$coun;";} # du special output of which counz are undefined in clrz 2 help find orig lsd8 failz getng hEr
      # for whatever the `l ~/dox/putr/NetRtrG8Wz/*Fs*` is trying to coerce into colored d8 here, the coun overagez are running from 8..40 at the moment
      # it's actually the *-2GT624v3-* product-code partz of those filenamez including G for the Month which triez to shift Year into some bad super-Xpanding
      #   && each of thoz codez are found twice in each filename (just to be aware of), but that's probably not the source of the long expansion && colr probz
      $rstr.=$tccs.substr($fstr,$coun++,1);} $rstr.='%{' if($ctyp=~ /^z/i);$rstr.=$z; # apNd special ZshL prmpt wraprz around fInal $z SKp cOd2 zerO reset...
    $rstr  .=                                       '%}' if($ctyp=~ /^z/i);           #   which concludez gNr8d colrd output sEquNcez for ANSI or ZSH ctypz
  }return($rstr);}
sub colr{my $self=shift;my $fstr="$self";return($self->_color_fields($fstr,@_));} # generic self colr method to call overloaded subclass colorfields
sub     time{my $self=shift;return($self->hmsp(    @_));}
sub  alltime{my $self=shift;return($self->zhmsp(   @_));}
sub     date{my $self=shift;return($self->YMD(     @_));}
sub  alldate{my $self=shift;return($self->YMD(     @_));}
sub  all    {my $self=shift;return($self->YMDzhmsp(@_));}
sub     dt  {my $self=shift;return($self->YMDzhmsp(@_));}
sub datetime{return(sprintf("%04d-%02d-%02dT%02d:%02d:%02d",$_[0]->YMDhms()));} # 2000-02-29T12:34:56 (ISO 8601)
sub time_separator{$_[0]->{'_time_separator'}=$_[1] if(@_>1); # set the default separator (default ":")
  return($_[0]->{'_time_separator'});}
sub date_separator{$_[0]->{'_date_separator'}=$_[1] if(@_>1); # set the default separator (default "-")
  return($_[0]->{'_date_separator'});}
sub day_list{my $self=shift; # set the default weekdays
  return(Time::DayOfWeek::DayNames(@_));}
sub mon_list{my $self=shift; # set the default months
  return(Time::DayOfWeek::MonthNames(@_));}
sub AUTOLOAD{ # methods (created as necessary)
  no strict 'refs';
  my($self,$nwvl)=@_;
  if    ($AUTOLOAD=~ /.*::([YMDzhmsp][YMDzhmsp]+)$/i){ # all joint field methods (eg. YMD, mdy, hms(), etc.)
    my @fldl=split(//,$1);
    my($self,@nval)=@_;my @rval=();my $atnm='';my $rgex;
    for(my $i=0;$i<$#fldl;$i++){ # handle Month / minute exceptions
      $fldl[$i+1]='M' if($fldl[$i]=~ /[yd]/i && $fldl[$i+1]eq 'm');
      $fldl[$i  ]='M' if($fldl[$i]eq 'm'     && $fldl[$i+1]=~ /[yd]/i);}
    *{$AUTOLOAD}=sub{
      my($self,@nval)=@_;my @rval=();
      for(my $i=0;$i<@fldl;$i++){
        for my $attr($self->_attribute_names()){
          if(lc($attr)eq 'm'){if($fldl[$i]=~ /^$attr/ ){$self->{$attr}=$nval[$i] if($i<@nval);push(@rval,$self->{$attr});}}
          else               {if($fldl[$i]=~ /^$attr/i){$self->{$attr}=$nval[$i] if($i<@nval);push(@rval,$self->{$attr});}}}
      }return(@rval);};
    for(my $i=0;$i<@fldl;$i++){
      for my $attr($self->_attribute_names()){
        if(lc($attr)eq 'm'){if($fldl[$i]=~ /^$attr/ ){$self->{$attr}=$nval[$i] if($i<@nval);push(@rval,$self->{$attr});}}
        else               {if($fldl[$i]=~ /^$attr/i){$self->{$attr}=$nval[$i] if($i<@nval);push(@rval,$self->{$attr});}}}
    }return(@rval);
  }elsif($AUTOLOAD=~ /.*::_?([YMDzhmsp])(.)?/){ # sweeping matches to handle partial keys, should probably be case-insensitive again l8r
    my($atl1,$atl2)=($1,$2);my $atnm;
    $atl1='M' if($atl1 eq 'm'&& defined($atl2)&& lc($atl2)eq 'o');
    $atl1='m' if($atl1 eq 'M'&& defined($atl2)&& lc($atl2)eq 'i');
    if($atl1 eq 'M'){
      if($AUTOLOAD=~ /.*::_/){ # 0-based _month
        *{$AUTOLOAD}=sub{$_[0]->{$atl1}=($_[1]+1) if(@_>1);return($_[0]->{$atl1}-1);};
        $self->{$atl1}=($nwvl+1) if(@_>1);
        return($self->{$atl1}-1);}}
    *{$AUTOLOAD}=sub{$_[0]->{$atl1}=$_[1] if(@_>1);return($_[0]->{$atl1});};
    $self->{$atl1}=$nwvl if(@_>1);
    return($self->{$atl1});
  }else{croak "No such method: $AUTOLOAD\n";}}
sub DESTROY{ } # do nothing but define in case && to calm warning in test.pl
8;
# Notz:
#   timelocal($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
#   Unix epoch 1970-2036 or something
#   PT   epoch 1361-2631
#   potential smaller fields:
#       kink as 60th-of-a-jink? tink as 60th-of-a-kink? ... X as 60th-of-a-Y
#     phass 0.0166666666666667        CYMDhmspjktbfaz
#     jink  0.000277777777777778               0.3 milliseconds (thousanths)
#     kink  0.00000462962962962963             5   microseconds (millionths)
#     tink  0.0000000771604938271605          77   nano seconds (billionths)
#     blip  0.00000000128600823045267          1   nano second
#       RealTimeOperatingSystems may need micro or nano second precision
#     flip  0.0000000000214334705075446       21   pico seconds (trillionths)
#     ax    0.000000000000357224508459076      0.4 pico seconds
#           0.00000000000000595374180765127    6   femtoseconds (10e-15)
#           0.0000000000000000992290301275212 99   atto seconds (10e-18)
#           0.00000000000000000165381716879202 2   atto seconds
#           0.000000000000000000027563619479867            27   zepto   -21
#           0.000000000000000000000459393657997783          0.5 zepto
#           0.00000000000000000000000765656096662972        8   yocto   -24
#           0.000000000000000000000000127609349443829       0.1 yocto
#           0.00000000000000000000000000212682249073048     2   harpo   -27
#           0.0000000000000000000000000000354470415121746  35   groucho -30
#           0.000000000000000000000000000000590784025202911 0.6 groucho
#      zepto (10e-21) yocto (10e-24) harpo (10e-27) groucho (10e-30)
#      zeppo (10e-33) gummo (10e-36) chico (10e-39)

=head1 NAME

Octology::d8::fldz - abstract objects to store distinct d8 and time fields

=head1 VERSION

This documentation refers to version pAKGvERS of Octology::d8::fldz, which was released on d8VSD8vs.

=head1 SYNOPSIS

  package Octology::d8::fldz::NewChildPackageOfd8fldz;
  use base qw(Octology::d8::fldz);

  # NewChildPackageOfd8fldz definition...

=head1 DESCRIPTION

Octology::d8::fldz defines simple d8time objects with 8 distinct fields for:

  Year, Month, Day, zone, hour, minute, second, phass

along with methods to manipul8 those fields and modify their default present8ion. A phass is one 60th-of-a-second.
fldz d8a and methods are meant to be inherited by other classes (namely L<Octology::d8> and L<Octology::d8::dur8>) which implement specific useful
interpret8ions of individual Octology::d8::fldz.

=head1 2DU

=over 2

=item -     What else does fldz need?

=back

=head1 WHY?

The reason I crE8d fldz was that I have grown so enamored with Base64 representations of everything around me that I was compelled to write a simple clock
utility ( `d8ok` ) using Base64. This demonstr8d the benefit to be gained from time objects with distinct fields and configurable precision. Thus,
Octology::d8::fldz was written to be the abstract base class for:

  Octology::d8        ( crE8s objects for instants in time )
    and
  Octology::d8::dur8  ( crE8s objects for dur8ions of time )

=head1 USAGE

Many of Octology::d8::fldz's methods have been patterned after the excellent L<Time::Piece> module written by Matt Sergeant <matt@sergeant.org> and
Jarkko Hietaniemi <jhi@iki.fi>.

=head2 new(<InitType>, <InitData>)

Octology::d8::fldz's constructor can be called as a class method to create a brand new object or as an object method to copy an existing object.
Beyond that, new() can initialize fldz objects the following ways:

  * <packedB64InitStringImplies'str'>
    eg. Octology::d8::fldz->new('01234567');
  * 'str'  => <packedB64InitString>
    eg. Octology::d8::fldz->new('str'  => 'ABCDEFGH');
  * 'array'=> <arrayRef>
    eg. Octology::d8::fldz->new('array'=> [0, 1, 2..7]);
  * 'hash' => <hashRef>
    eg. Octology::d8::fldz->new('hash' => {'phass' => 7, 'year' => 2014})

b<*Note*> If only a valid 'str'-type parameter is given to new (but no accompanying initializ8ion value), the parameter is interpreted as an implied 'str'
value.

  eg. Octology::d8::fldz->new('01234567');

This implied 'str'-type initializ8ion will probably be the most common Octology::d8::fldz object crE8ion mechanism when individual fields do not exceed 64
since this efficient represent8ion is why the module was crE8d.

The following methods allow access to individual fields of existent Octology::d8::fldz objects:

  $t->Y  # Year
  $t->M  # Month
  $t->D  # Day
  $t->z  # zone
  $t->h  # hour
  $t->m  # minute
  $t->s  # second
  $t->p  # phass

Any combination of above single letters can be used as well.
Following are some common useful examples:

  $t->hms                 # returns list of fields eg. [12, 34, 56]
  $t->hms(12, 56, 34)     # sets fields: h = 12, m = 56, s = 34
  $t->hmsp                # [12, 34, 56, 12]
  $t->zhmsp               # [22, 12, 34, 56, 12]
  $t->time                # same as $t->hms
  $t->alltime             # same as $t->zhmsp
  $t->YMD                 # [2000,  2,   29]
  $t->MDY                 # [   2, 29, 2000]
  $t->DMY                 # [  29,  2, 2000]
  $t->date                # same as $t->YMD
  $t->alldate             # same as $t->YMD
  $t->YMDzhmsp            # [2014,  2, 29, 22, 12, 13, 56, 12]
  $t->dt                  # same as $t->YMDzhmsp
  $t->all                 # same as $t->YMDzhmsp
  "$t"                    # same as $t->YMDzhmsp

=head2 Month / minute Exceptions

fldz object method names can be in any case with the following exceptions. Special handling exists to resolve ambiguity between the Month and minute fields.
If a lowercase 'm' is used adjacent to a 'y' or 'd' of either case, it is interpreted as Month. Otherwise, the case of the 'm' distinguishes Month from minute.
An uppercase 'M' is ALWAYS Month. An adjacent uppercase 'H' or 'S' will not turn an uppercase 'M' into minute.

  $t->ymd                 # same as $t->YMD
  $t->dmy                 # same as $t->DMY
  $t->MmMm                # Month minute Month minute
  $t->HMS                 # hour Month second! NOT same as $t->hms

=head1 NOTES

Whenever individual Octology::d8::fldz attributes are going to be printed or an entire object can be printed with multi-colors,
the following mapping should be employed whenever possible:

  D  Year    -> Red
  A  Month   -> Orange
  T  Day     -> Yellow
  E   zone   -> Green
   t  hour   -> Cyan
   i  minute -> Blue
   m  second -> Magenta
   e  phass  -> Purple

Even though Octology::d8::fldz is designed to be an abstract base class, it has not been written to croak on direct usage and object
instantE8ion because simple fldz objects may already be worthwhile.

I hope you find Octology::d8::fldz useful. Please feel free to e-mail me any suggestions or coding tips or notes of appreC8ion. Thank you. TTFN.

=head1 CHANGES

Revision history for Perl extension Octology::d8::fldz:

=over 4

=item - pAKGvERS  d8VSD8vs

* replaced all c8 && eScape Orange && Purple with o && p to also newly benefit from last quarter of d8 finally also being bold in promptz

* migr8d old Time::Fields over to new Octology::d8::fldz name

* updated license copyright years (already had GPLv3)

* combined Fields, Frame, && PT into one pkg (so see PT CHANGES section
    for updates to Fields or Frame)

=item - 1.0.3CCA4Eh  Fri Dec 12 10:04:14:43 2003

* removed indenting from POD NAME field

=item - 1.0.3CB7Qb0  Thu Dec 11 07:26:37:00 2003

* updated pod && prepared for release

=item - 1.0.3CA8oiI  Wed Dec 10 08:50:44:18 2003

* cleaned up documentation

* implemented use methods

* overloaded for stringification

=item - 1.0.39GHeCl  Tue Sep 16 17:40:12:47 2003

* incorporated stuff learned from ObjectOrientedPerl (Conway)

=item - 1.0.382DLbX  Sat Aug  2 13:21:37:33 2003

* fleshed out documentation && ideas

=item - 1.0.37VG26k  Thu Jul 31 16:02:06:46 2003

* original version

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install Octology::d8"`

or uncompress the package && run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::d8::fldz requires:

L<Carp>                to allow errors to croak() from calling sub

L<Octology::b8>        to handle number-base transl8ion

Octology::d8::fldz utilizes (if available):

L<Time::HiRes>         to provide sub-second time precision

L<Time::Local>         to provide Unix time conversion options

=head1 SEE ALSO

L<Octology::d8> and L<Octology::d8::dur8>

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2003-2014, Pip Stuart.
Copyleft : This software is licensed under the GNU General Public License (version 3). Please see the Free Software Foundation (HTTP://FSF.Org)
  for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
