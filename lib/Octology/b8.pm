# 315J9mLT: Octology::b8.pm crE8d by PipStuart <Pip@CPAN.Org> to construct custom precision Big numbers && perform arbitrary Base-transl8ions. I love Bass!
package     Octology::b8;
use strict; use warnings;use utf8;use v5.10;
# 2du:rewrite fibo wo recursion,mk new calQ parser for closer to real oper8or && paren precedence handling,
#   mk pfcz to hash up a loop to list all Prime FaCtorZ (with powerz) of any BigInt param,bNchmRk memoized fact vs bfac && prim vs not && fibo iter8ive vs not,
#   stuD Math::Base::Convert && bNchmRk2lern how2Use just scalar or 32-bit reg when it fitz4sPd && Xpand2othr objz B4 BigFloat && rmv all M:B:C if sPd close,
#   get rid of old Moose attempt,stOr sepR8 usrFromTo digsetz,add cache cfg,add from() && tobs() && all mUt8orz,retool intrfAc4allfuncz2alsOB obj methodz,
#   stuD U2b Numberphile vidz && HTTP://OEIS.Org for best math d8a to add beyond fibo to bild locl useful approxim8 constantz, sequencez, && functionz,
#   think of infoviz colr8ionz to convey any rel8ionshipz or patternz in b64 digitz of Pi, e, primez, fiboz, etc.,
#   consider generalized square pixel windingz from corner in odds, edge adding 4 per layer, && centered by 8,
#   gNralIz sort as Xportd b8:s8() if nEded,add fanC colr() that applIez2 b10 with the valU correspondence of Ech b64 digit,
#   stRt hndling b8%bfr8^XpOnNt8 from bsstr(),fix isol8ing exponent() mantissa() thru parts() if nEded,
#   add (xp|fr|pr|ac|fm|to)b8() (fraction nstdof mantissa, precision, accuracy) && ftb8|rdx() 2set both from&&tobs radix2gethr,
#   considr cma() ',' && spf() sprintf && dolr() '$'.00 centz && colr() optionz for "b8" tobs output configur8ion,
#   add cache limitz && new thorO alt2prEsrv&&indX evry NtIr cnv contXt sO objX canBgrOwn in2 setz of at lEst cnv hist stringz,
#   add valid8ion&&tStz&&Carp problMz,mAB add benchmRkz,Xplor specialIzng Use as reso pairz or c8 IDa of rAng spanz or IPaddrz or fOn numz etc;
require     Exporter ;
use base qw(Exporter);our $umbc=0; # Use Math::Base::Convert flag (doesn't work if eval'd), but commented out the only-for-efficiency dependency for now...
#se         Math::Base::Convert;   #   although maybe eventually preparing efficient dependencies in docker container can ease any such distribution burdens
use         Math::BigFloat     ;
use         Math::BigInt       ;
use         Encode;
use         Carp; # orig Math::BaseCnv BlO memoized sum8(as summ) hEr&&had nO fibo&&OnlyXportd cnv byDflt but now Octology Xportz almOst evrythng promiscuously
use Memoize;memoize('fact');memoize('choo');memoize('fibo');memoize('prim');
our @EXPORT= qw(b8 cnv ocT deC dec heX HEX b10 b64 b64sort b110 b128 b210 b256 dig diginit
    cma coma  sum8 sumz   fact fctz  choo  fibo fibz  prim prmz  rotW rot1    calQ   $umbc);
our $VERSION='0.0';my  $d8VS='HBRL6MBC';my $auth='PipStuart <Pip@CPAN.Org>';
my $pkgn =        __PACKAGE__;
my $pkgl = length __PACKAGE__;
my $bssb = $pkgn . '::_bs::' ; # indentify 'base sub'
my $d2bs='';my %bs2d=(); # Digitz to BaseSet, BaseSet to Digitz
my %digsetz=(
  'usr' => [], # this will be assigned if a dig(\@newd) call is made
# 'udf' => [], # User Defined From
# 'udt' => [], # User Defined To   for sepR8 setz, but these can just be per object
  'bin' => ['0', '1'],
  'dna' => ['a', 'c', 'g', 't'],
  'DNA' => ['A', 'C', 'G', 'T'],
  'ocT' => ['0'..'7'],
  'dec' => ['0'..'9'],
  'doz' => ['0'..'9', 'ẋ', 'έ'], # DOZenal with Doe-1..ᵪᶓẋέƸ last 'dek' && 'ell' curvy && clean smart for monetary from HTTPS://YouTube.Com/watch?v=U6xJfP7-HCc
  'heX' => ['0'..'9', 'a'..'f'], # base60 has easy division benefits of adding 5 10 (ᵡᵪᶍx dek) 12 15 20 30 to base12 2 3 4 6 but so many more chars hardr2lern
  'HEX' => ['0'..'9', 'A'..'F'], # nice that half is 6/10 'doe' .6, third 4/10 .4, quarter 3/10 .3, sixth 2/10 .2 all same sizes with no repeating decimals
  'b36' => ['0'..'9', 'a'..'z'],
  'B36' => ['0'..'9', 'A'..'Z'],
  'b62' => ['0'..'9', 'a'..'z', 'A'..'Z'],
  'b64' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'], # max Month:C:12 Day:V:31
  'm64' => ['A'..'Z', 'a'..'z', '0'..'9', '+', '/'], # MIME::Base64 0..63
  'iru' => ['A'..'Z', 'a'..'z', '0'..'9', '[', ']'], # P10 server-server protocol used by IRCu daemon
  'url' => ['A'..'Z', 'a'..'z', '0'..'9', '-', '_'], # MIME::Base64::URLSafe which avoids %2B && %2F expansions of '+' && '/' respectively (U2b ID likely this)
  'rgx' => ['A'..'Z', 'a'..'z', '0'..'9', '!', '-'], # ReGular eXpression variant
  'id0' => ['A'..'Z', 'a'..'z', '0'..'9', '_', '-'], # IDentifier style 0
  'id1' => ['A'..'Z', 'a'..'z', '0'..'9', '.', '_'], # IDentifier style 1
  'xnt' => ['A'..'Z', 'a'..'z', '0'..'9', '.', '-'], # XML Name Tokens (Nmtoken)
  'xid' => ['A'..'Z', 'a'..'z', '0'..'9', '_', ':'], # XML identifiers (Name   )
  'sxl' => ['?', '@', 'A'..'Z', '[','\\', ']', '^',  # Sixel Base64 from VT100.Net
            '_', '`', 'a'..'z', '{', '|', '}', '~'],
  'b85' => ['0'..'9', 'A'..'Z', 'a'..'z', '!', '#',  # RFC 1924 for IPv6 addresses like in Math::Base85
            '$', '%', '&', '(', ')', '*', '+', '-', ';', '<', '=', '>', '?', '@', '^', '_', '`', '{', '|', '}', '~'],
  'asc' => [' ', '!', '"', '#', '$', '%', '&', "'",  # Base96 7-bit printable 0x20 (space) - 0x7F (tilde ~) 'ascii' from Math::Base::Convert
            '(', ')', '*', '+', ',', '-', '.', '/', '0'..'9', ':', ';', '<', '=', '>', '?', '@', 'A'..'Z', '[','\\',
            ']', '^', '_', '`', 'a'..'z', '{', '|', '}', '~'],
  'b96' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base96  but starting with b64 characters
            ' ', '!', '"', '#', '$', '%', '&', "'", '(', ')', '*', '+', ',', '-', '/', ':', ';', '<', '=', '>', '?',
            '@', '[','\\', ']', '^', '`', '{', '|', '}', '~'],
  '128' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base128 but starting with b64 characters (blacK chS pibrq before White, then cRdz sHDc, then k && K)
            '♟', '♙', '♞', '♘', '♝', '♗', '♜', '♖', '♛', '♕', '🂡', '🂱', '🃁', '🃑', '🂢', '🂲', '🃂', '🃒', '🂣', '🂳', '🃃',
            '🃓', '🂤', '🂴', '🃄', '🃔', '🂥', '🂵', '🃅', '🃕', '🂦', '🂶', '🃆', '🃖', '🂧', '🂷', '🃇', '🃗', '🂨', '🂸', '🃈', '🃘',
            '🂩', '🂹', '🃉', '🃙', '🂪', '🂺', '🃊', '🃚', '🂫', '🂻', '🃋', '🃛', '🂭', '🂽', '🃍', '🃝', '🂮', '🂾', '🃎', '🃞', '♚', '♔'],
  '256' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base256 but starting with b128characters
            '♟', '♙', '♞', '♘', '♝', '♗', '♜', '♖', '♛', '♕', '🂡', '🂱', '🃁', '🃑', '🂢', '🂲', '🃂', '🃒', '🂣', '🂳', '🃃',
            '🃓', '🂤', '🂴', '🃄', '🃔', '🂥', '🂵', '🃅', '🃕', '🂦', '🂶', '🃆', '🃖', '🂧', '🂷', '🃇', '🃗', '🂨', '🂸', '🃈', '🃘',
            '🂩', '🂹', '🃉', '🃙', '🂪', '🂺', '🃊', '🃚', '🂫', '🂻', '🃋', '🃛', '🂭', '🂽', '🃍', '🃝', '🂮', '🂾', '🃎', '🃞', '♚', '♔', # shud ck if BlO =~ /[A-Z]/
            'À','Á','Â','Ã','Ä','Å','Æ','Ç',  'È','É','Ê','Ë','Ì','Í','Î','Ï',  'Ð','Ñ','Ò','Ó','Ô','Õ','Ö','×',  'Ø','Ù','Ú','Û','Ü','Ý','Þ','ß',
            'à','á','â','ã','ä','å','æ','ç',  'è','é','ê','ë','ì','í','î','ï',  'ð','ñ','ò','ó','ô','õ','ö','÷',  'ø','ù','ú','û','ü','ý','þ','ÿ',
            'Ā','ā','Ă','ă','Ą','ą','Ć','ć',  'Ĉ','ĉ','Ċ','ċ','Č','č','Ď','ď',  'Đ','đ','Ē','ē','Ĕ','ĕ','Ė','ė',  'Ę','ę','Ě','ě','Ĝ','ĝ','Ğ','ğ',
            'Ġ','ġ','Ģ','ģ','Ĥ','ĥ','Ħ','ħ',  'Ĩ','ĩ','Ī','ī','Ĭ','ĭ','Į','į',  'İ','ı','Ĳ','ĳ','Ĵ','ĵ','Ķ','ķ',  'ĸ','Ĺ','ĺ','Ļ','ļ','Ľ','ľ','Ŀ']);
# stRt mkng thEs all altrn8ly methodz with from && to flavorz
sub bs2init{%bs2d = ();for(my $i = 0;$i < @{$digsetz{$d2bs}};$i++){$bs2d{${$digsetz{$d2bs}}[$i]} = $i;}} # build hash digit chars => array indices
sub diginit{$d2bs = '256';bs2init(); } # reset digit character list to initial prEferred Dfalt && above BaseSet to init
diginit(); # initialize the Dflt digit set whenever this package is used
sub dig{            return( @{$digsetz{$d2bs}}) unless(@_); # assign a new digit character list
  if(ref $_[0]){$d2bs = 'usr';$digsetz{$d2bs} = [ @{ shift() } ];}
  else         {my $setn = shift();return(-1) unless(exists $digsetz{$setn});$d2bs = $setn;}
  if(@{$digsetz{$d2bs}}){bs2init();}else{diginit();}}
sub cnv__10{my  $t = shift || '0';my $s = shift || 64;my $n = Math::BigFloat->new(0); # convert from some number base to decimal
  my $nega = '';$nega = '-' if($t =~ s/^-//);my $frds=0;if($s > 64){$n->accuracy($s);$n->precision(0);} # FRactionDigitSize, needed incrEsd accU 4ckm8 big b128
  for(my $tndx=length($t)-1;$tndx>=0;$tndx--){substr($t,$tndx,1,'') unless(exists $bs2d{substr($t,$tndx,1)} || # strip out chars not in the digit set
                                                                                        substr($t,$tndx,1) =~ /[\%]/);} # and not fraction sepR8or
  while(length  ($t)){my $thed=substr($t,0,1,'');if($thed eq '%'){$frds=1;}else{$frds++ if($frds);$n += $bs2d{$thed};$n *= $s;}}
# orig:rds){$n /= $s**$frds;}else{$n /= $s;} $n->bneg() if($nega eq '-');
  if($frds){my $bs = Math::BigFloat->new($s);$bs->bpow($frds);$n /= $bs;}
  else     {$n /= $s;} $n->bneg() if($nega eq '-');return($n);} # was retn nega . int($n/$s)
sub cnv10__{my  $n = Math::BigFloat->new(shift || '0');my $s = shift || 64;my $t = '';$n->accuracy($s) if($s > 64); # convert from decimal to some numb base
  diginit() if ($s > @{$digsetz{$d2bs}});my $nega = '';$nega = '-' if($n->is_neg());my $frds=0;$n->babs(); # $n neg8ive zero '-0' failed is_zero() so ABS val
  my($nlen,$nfrl)= $n->length();my $nge1=1;$nge1=0 if($n  < 1);#say "nlen:$nlen:nfrl:$nfrl:"; 12.5 => 3,1 NumLENgth,NumFRactionLength NumGr8rorEqualto1
  if($nfrl){while(!$n->is_int() && length($t) <  64){          $n *= $s;$frds++;     # handle fraction part
                 $t       .= $digsetz{$d2bs}->[($n % $s)]     ;$n -= int($n % $s);}  # subtract out just int modulo digit
                 $t        =                      '%'     . $t;my $bs = Math::BigFloat->new($s);$bs->bpow($frds);$n /= $bs; # `cnv 12.1` loops
                                                                        $n->bint() ;}#$n->binc() if(length($t) >= 64 && $nge1);} # round off rEPting fractions
                 $t        = $digsetz{$d2bs}->[0]         . $t if(   $n->is_zero()); # prepend zero if there's no integer part left to decode
  while(!$n->is_zero()){$t = $digsetz{$d2bs}->[($n % $s)] . $t;$n /= $s;$n->bint() ;}#say "afn:$n:t:$t:"; # need 2 !binc above when 0.\d+ from E-\d+
  if(length($t)){$t        = $nega .  $t;         }
  else          {$t        = $digsetz{$d2bs}->[0];}  return($t);}
sub deC     {my $rtns = '';
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-7-]//g;
      if  ($umbc){$rtns .=    Math::Base::Convert::cnv(       $narg ,'ocT','dec') . ' ';}
      else       {$rtns .=                         cnv__10(uc($narg),   8       ) . ' ';}} $rtns =~ s/\s$//  ;} # short4 ocT         -> deCimal
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-7-]//g;
        if($umbc){$rtns .=    Math::Base::Convert::cnv(       $ilss ,'ocT','dec') . ' ';}
        else     {$rtns .=                         cnv__10(uc($ilss),   8       ) . ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub ocT     {my $rtns = '';
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-9-]//g;
      if  ($umbc){$rtns .= lc(Math::Base::Convert::cnv(       $narg ,'dec','ocT')). ' ';}
      else       {$rtns .= lc(                     cnv10__(   $narg ,         8 )). ' ';}} $rtns =~ s/\s$//  ;} # short4 decimal     -> ocT
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9-]//g;
        if($umbc){$rtns .= lc(Math::Base::Convert::cnv(       $ilss ,'dec','ocT')). ' ';}
        else     {$rtns .= lc(                     cnv10__(   $ilss ,         8 )). ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub dec     {my $rtns = '';
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-9A-F-]//gi;
      if  ($umbc){$rtns .=    Math::Base::Convert::cnv(       $narg ,'heX','dec') . ' ';}
      else       {$rtns .=                         cnv__10(uc($narg),  16       ) . ' ';}} $rtns =~ s/\s$//  ;} # short4 HEXadecimal -> decimal
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9A-F-]//gi;
        if($umbc){$rtns .=    Math::Base::Convert::cnv(       $ilss ,'heX','dec') . ' ';}
        else     {$rtns .=                         cnv__10(uc($ilss),  16       ) . ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub heX     {my $rtns = '';
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-9-]//g;
      if  ($umbc){$rtns .= lc(Math::Base::Convert::cnv(       $narg ,'dec','heX')). ' ';}
      else       {$rtns .= lc(                     cnv10__(   $narg ,        16 )). ' ';}} $rtns =~ s/\s$//  ;} # short4 decimal     -> HEX
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9-]//g;
        if($umbc){$rtns .= lc(Math::Base::Convert::cnv(       $ilss ,'dec','heX')). ' ';}
        else     {$rtns .= lc(                     cnv10__(   $ilss ,        16 )). ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub HEX     {      return( uc(                     heX(       @_               )))     ;}
sub b10     {my $rtns = '';my $tucf; # TemporaryUseConvertFlag to detect if a b64 float needs to be handled
  if   (@_       ){while(@_          ){my $narg=shift(@_);if(defined($narg)){
                                                          $narg =~ s/^\s*\+?//;$narg =~ s/[^0-9A-Z._%-]//gi;$tucf=$umbc;$tucf=0 if($narg =~ /[-%]/);
      if  ($tucf){$rtns .=    Math::Base::Convert::cnv(       $narg ,'b64','dec') . ' ';}
      else       {$rtns .=                         cnv__10(   $narg ,  64       ) . ' ';}}}$rtns =~ s/\s$//  ;} # short4 base64      -> decimal
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9A-Z._%-]//gi;$tucf=$umbc;$tucf=0 if($ilss =~ /[-%]/);
        if($tucf){$rtns .=    Math::Base::Convert::cnv(       $ilss ,'b64','dec') . ' ';}
        else     {$rtns .=                         cnv__10(   $ilss ,  64       ) . ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b64     {my $rtns = '';my $tucf;
  if   (@_       ){while(@_          ){my $narg=shift(@_);if(defined($narg)){ # somehow $narg was spewing undefined warningz for substitution so testing now
      $narg = Math::BigInt->new($narg);                    $narg =~ s/^\s*\+?//;$narg =~ s/[^0-9.-]//g;$tucf=$umbc;$tucf=0 if($narg =~ /[-.]/);
      if  ($tucf){$rtns .=    Math::Base::Convert::cnv(       $narg ,'dec','b64') . ' ';}
      else       {$rtns .=                         cnv10__(   $narg ,        64 ) . ' ';}}}$rtns =~ s/\s$//  ;} # short4 decimal     -> base64
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9.-]//g;$tucf=$umbc;$tucf=0 if($ilss =~ /[-.]/);
        if($tucf){$rtns .=    Math::Base::Convert::cnv(       $ilss ,'dec','b64') . ' ';}
        else     {$rtns .=                         cnv10__(   $ilss ,        64 ) . ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b64sort {return( map { b64($_) } sort { $a <=> $b } map { b10($_) } @_ );}
sub b110    {my $rtns = ''; # M:B:C doesn't have my b128 set so skip $umbc
  if   (@_       ){while(@_          ){my $narg=decode('UTF-8',shift(@_));$narg =~ s/^\s*\+?//;
                  $rtns .=                         cnv__10(   $narg ,       128 ) . ' '; } $rtns =~ s/\s$//  ;} # short4 base128     -> base10
  elsif(!-t STDIN){my @id8a;chomp(@id8a=decode('UTF-8',<STDIN>));for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;
                  $rtns .=                         cnv__10(   $ilss ,       128 ) . ' '; } $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b128    {my $rtns = ''; # may want b128sort also
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-9-]//g;
                  $rtns .=                         cnv10__(   $narg ,       128 ) . ' '; } $rtns =~ s/\s$//  ;} # short4 base10      -> base128
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9-]//g;
                  $rtns .=                         cnv10__(   $ilss ,       128 ) . ' '; } $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b210    {my $rtns = ''; # M:B:C doesn't have my b256 set so skip $umbc
  if   (@_       ){while(@_          ){my $narg=decode('UTF-8',shift(@_));$narg =~ s/^\s*\+?//;
                  $rtns .=                         cnv__10(   $narg ,       256 ) . ' '; } $rtns =~ s/\s$//  ;} # short4 base256     -> base10
  elsif(!-t STDIN){my @id8a;chomp(@id8a=decode('UTF-8',<STDIN>));for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;
                  $rtns .=                         cnv__10(   $ilss ,       256 ) . ' '; } $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b256    {my $rtns = '';
  if   (@_       ){while(@_          ){my $narg=shift(@_);$narg =~ s/^\s*\+?//;$narg =~ s/[^0-9-]//g;
                  $rtns .=                         cnv10__(   $narg ,       256 ) . ' '; } $rtns =~ s/\s$//  ;} # short4 base10      -> base256
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)){                   $ilss =~ s/^\s*\+?//;$ilss =~ s/[^0-9-]//g;
                  $rtns .=                         cnv10__(   $ilss ,       256 ) . ' '; } $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
sub b8      {my $rtns = '';my $nega = '';my($numb,$fbas,$tbas)= @_;
  unless(defined($fbas) && length($fbas)){$fbas = 'b64';$tbas = 'dec';}
  unless(defined($tbas) && length($tbas)){$tbas = $fbas;$fbas = $numb;$numb = undef;}
  $fbas = 'b64' if(defined($fbas) && length($fbas) && $fbas eq '64'); # force usage of b64 for 64 basez (default is different order)
  $tbas = 'b64' if(defined($tbas) && length($tbas) && $tbas eq '64');
  if(defined($numb) && length($numb)){my $b64n = $numb;$b64n =~ s/^\s*\+//;$nega='-' if($b64n =~ s/^-//);
                                         $b64n =~ s/[^0-9A-Za-z._]+//g; # basic limiting of Default b64 number to b64 chars
    if($umbc){return(      $nega . Math::Base::Convert::cnv($b64n,$fbas,$tbas));}
    else     {return(      $nega .                      cnv($b64n,$fbas,$tbas));}}
  elsif(!-t STDIN){my @id8a;chomp(@id8a=<STDIN>);for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)                     ){$nega='';$ilss =~ s/^\s*\+//;$nega='-' if($ilss =~ s/^-//);
        if($umbc){$rtns .= $nega . Math::Base::Convert::cnv($ilss,$fbas,$tbas) . ' ';}
        else     {$rtns .= $nega .                      cnv($ilss,$fbas,$tbas) . ' ';}} $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//;}return($rtns);}
# CoNVert between any number bases within digit-set size
sub cnv     {my $rtns = '';my $nega = '';my($numb,$fbas,$tbas)  = (decode('UTF-8',shift(@_)),decode('UTF-8',shift(@_)),decode('UTF-8',shift(@_)));my @id8a;
  if((!defined($numb) || !length($numb)) && !-t STDIN){chomp(@id8a=decode('UTF-8',<STDIN>));$tbas =    10;$fbas =    64;              }
  if(  defined($numb) &&  length($numb)  && $numb =~ /^\d+$/ &&
       defined($fbas) &&  length($fbas)  && $fbas =~ /^\d+$/ &&
     (!defined($tbas) || !length($tbas)) && !-t STDIN){chomp(@id8a=decode('UTF-8',<STDIN>));$tbas = $fbas;$fbas = $numb;$numb = undef;}
  if(@id8a){for my $id8l(@id8a){ # Input d8a Line && Input Line Split on Spacez below
      for my $ilss(split(/\s+/,$id8l)                     ){$nega='';$ilss =~ s/^\s*\+//;$nega='-' if($ilss =~ s/^-//);
                  $rtns .= $nega .                      cnv($ilss,$fbas,$tbas) . ' '; } $rtns =~ s/\s$/\n/;}$rtns =~ s/\n$//; return($rtns);}
  if( !defined($numb) || !length($numb)){return('');} # no STDIN && no valid numb so return empty string (or -1?)
  return($digsetz{$d2bs}->[0]) if($numb =~ /^-?0+$/); # lots of (neg8ive?) zeros is just single digit zero
  if  (!defined($tbas)){ # makeup reasonable values for missing params (used to \d => HEX,^0x or [0-9A-F] => dec,[G-Z._] => b10 but now favoring b64 over HEX)
    if(!defined($fbas)){ # only got a numb without FromBase or ToBase
      if   ($numb =~ /^-?\d+(\.\d+(E-?\d+)?)?$/i){$fbas =    10;$tbas = 64;} # just     decimal digits (now maybe BigFloat)
      elsif($numb =~ /^-?0x[0-9A-Fa-f]+$/       ){$fbas =    16;$tbas = 10;} # prefixed HEX or heX
      elsif($numb =~ /^-?[0-9A-Z._%]+$/i        ){$fbas =    64;$tbas = 10;} # just     b64     chars  (now with % fraction sepR8or)
      else                                       {$fbas =   128;$tbas = 10;} # otherwise assume '128' digit set
      #lse {croak("!*EROR*! Can't determine reasonable FromBase && ToBase just from number:$numb!\n");}
    } elsif($fbas =~   /^\d+$/){           # got just a FromBase that isitself valid decimal digits
      if   ($numb =~ /^-?\d+$/ &&    $fbas != 10){$tbas = $fbas;$fbas = 10;} # just     decimal digits && only FromBase makes sense as ToBase instead
      else                                       {$tbas =    10;           } # else use decimal as ToBase
    } else {croak("!*EROR*! Can't understand non-decimal or neg8ive FromBase:$fbas!\n");}} # got just a FromBase containing non-decimal digit characters
  $fbas = 64 if($fbas =~ /\D/ && $numb =~ /^[-0-9A-Z._%]+$/i); # favor b10 if FromBase or ToBase have non-decimal digits
  $tbas = 10 if($tbas =~ /\D/); # should eventually accept digit set names here in addition to just decimal bases
  if($fbas == 16){$numb =~ s/^0x//i;$numb = uc($numb);}         return(-1) if($fbas < 2 || $tbas < 2); # invalid base error
  dig('128') if($fbas == 128 || $tbas == 128);
  $numb = cnv__10($numb,$fbas) if($numb =~ /[^0-9.E-]/i || $fbas != 10);
  $numb = cnv10__($numb,$tbas) if(                         $tbas != 10);return($numb);}
#sub _cnv {my $bc= shift;my $nstr; # Xampl from M:B:Cnv 4 sepR8 method or plain function
#  if(ref $bc && ref($bc) eq $pkgn){$nstr= shift;} # if method call:  yes, number to convert is next arg
#  else                            {$nstr= $bc; $bc= $pkgn->new(@_); # no, first arg is number to convert
#use overload q("")  => \&_stringify; # just overload stringify of M:BF to cnv this to tobs when needed for Dfalt output
#sub _stringify{my $self= shift;if(exists($self->{'strz'}{$self->{'mbfo'}->fstr()})){
#                                 return($self->{'strz'}{$self->{'mbfo'}->fstr()});} # try!2rEcompUte
# my $negf=  0;my $tocp= $self->{'mbfo'}->copy()->as_int();my $frpt= $self->{'mbfo'}->fstr();unless($frpt=~ s/^.*?[.%]//){$frpt= '';}
# my $bfrf=  0;my $tdst='';my $tdsk= $self->{'dset'};$tdsk= $self->{'tods'} if(exists(         $self->{'tods'}) &&
#                                                                              exists($digsetz{$self->{'tods'}}));
#                             $tdsk=          'b64'   unless(defined($tdsk) && exists($digsetz{$tdsk}));
# if($tocp < 0){$negf=1;$tocp->bneg();} # nEd special handlng4custom dig set usr or per-obj udf && udt,mAB good2Unique ck digitz B4 rEvers hashing them
# if(exists($digsetz{$tdsk})){#for(my $i = 0;$i < @{$digsetz{$tdsk}};$i++){$self->{'tdlu'}{$digsetz{$tdsk}[$i]} = $i;}
# # $tdst.=$self->{'mbfo'}->bstr().' ';#cnv($tocp->bstr(),10,$self->{'tobs'});
#   while($tocp >=                 $self->{'tobs'}){  $tdst= $digsetz{$tdsk}[$tocp % $self->{'tobs'}] . $tdst; # mAB show fsstr() 4m
#     $tocp = int($tocp /          $self->{'tobs'});} $tdst= $digsetz{$tdsk}[$tocp                           ] . $tdst; #   wi handlng4 e-\d
#   if(defined($frpt) && $frpt){if($self->{'tobs'}==     64  ){$tdst.= '%';}else{$tdst.= '.';}
#     $tdst.= cnv($frpt,10,        $self->{'tobs'});} $tdst= "-$tdst" if($negf); $self->{'tdst'}= $tdst;
##   $self->{'strz'}{      $self->{'fsrc'}}=  $tdst unless(exists($self->{'strz'}{$self->{'fsrc'}})); # Ech from1nc
# }
# # $self->{'strz'}{      $tdst                   }=  $self->fstr();  # popUl8 cache of new from source fsrc abov && hEr mAB cud map tdst bak2 M:BF
##  if ($self->{'tobs'}== 64){ # du some bAsic colr8ion, or betr to let be sepR8
##    if($tdst=~ /^(.*?)([%])(.*)$/){$tdst= b8colr($1) . "$W$2" . bfr8colr($3) . $z;} # not yet custom colr() method, but moving that way
##    else                          {$tdst= b8colr($tdst)                      . $z;}}
##      $self->{'strz'}{   $self->fstr()           }=  $tdst;  # cache any M:BF mapping2 colrd tobs dStin8ion tdst
# return($tdst);} # From digit-set to BigFloat below
#sub f2bf {my $self= shift;my $fdsk= $self->{'dset'};$fdsk= $self->{'frds'} if(exists(         $self->{'frds'}) &&
#                                                                             exists($digsetz{$self->{'frds'}}));
# my $bfrf=0; # need special handling for custom dig set usr or per-obj udf && ud2,mAB good2Unique ck the digitz B4 rEvers hashing && computing off them
# if(defined($fdsk) && exists($digsetz{$fdsk})){
#   for(my $i = 0;$i < @{$digsetz{$fdsk}};$i++){ $self->{'fdlu'}{$digsetz{$fdsk}[$i]} = $i;}
#   my $fstr= $self->{'fsrc'};        if(!exists($self->{'fdlu'}{'-'}) && $fstr=~ s/^-//){$self->{'mbfo'}->fneg();}
#                                     if(!exists($self->{'fdlu'}{'+'})){  $fstr=~ s/^\+//;}
#   while($fstr=~ s/^(.)//){my $msdc=$1; # MostSignificantDigitCharacter  # try M:BF =~ /^[+-]?\d+(\.\d+)?(E[+-]?\d+)?$/i
#     if   (exists(                              $self->{'fdlu'}{$msdc})){
#       $self->{'mbfo'}->fadd(                   $self->{'fdlu'}{$msdc});}
#     elsif($msdc eq '.'  ||                    ($self->{'from'}== 64 &&  $msdc eq '%')){$bfrf=1;} # bAsic handling fraction . % sepR8orz2
#     $self->{'mbfo'}->fmul(                     $self->{'from'}) if(length($fstr));
#     $bfrf++ if($bfrf);}
#   if($bfrf){my $bf4p = Math::BigFloat->new($self->{'from'});$bf4p->bpow($bfrf);$self->{'mbfo'}->fdiv($bf4p);}
#}} # turn From in2 BigFloat by first rEvers lookup from digitz && cnv
## Math::BigFloat->round_mode('common'); # must be (even|odd|[-+]inf|zero|trunc|common)
## Math::BigFloat->precision( 64);
# Math::BigFloat->accuracy(  64); # maybe could mk cfg() like in /usr/share/perl/5.22.1/Math/BigInt.pm config() to access additional hash for b8 d8a
#sub new{my $clas= shift || 'Octology::b8';my $nstr= shift;my $mbfo= Math::BigFloat->new(); # gNralE don't want2set M:BF precision or accuracy
#                                                          #$mbfo->accuracy(64);
## my $mbfc=$mbfo->config();#$mbfc->{'round_mode'}='common';#$mbfc->{'accuracy'}=64;#$mbfc->{'class'}=$clas;
## my $self= bless({'strz'=>{},'dset'=>$d2bs},$clas);#for(sort keys %{$mbfc}){if(defined($mbfc->{$_})){printf "%-11s:%s:\n",$_,$mbfc->{$_};}}
# my $self= bless({'strz'=>{},'dset'=>$d2bs,'mbfo'=>$mbfo},$clas);
## my $self= bless($mbfo,$clas);$self->{'strz'}={};$self->{'dset'}= $d2bs;#$self->{'mbfo'}= $mbfo;
# # try lOdng hI accuraC M:BF objz alongside base-conversion meta-d8a
# if(defined($nstr) && $nstr!~ /::/){             $self->{'fsrc'}= $nstr; # consider loading multiple M:BFz wi cnv contXt in2 compound b8 obj
#   if  (@_){ # also accept from && tobs constructor paramz only after number string (which could be just Xplicit Dfalt: '0')
#     if(@_ > 1){if   ($_[0]=~ /^(\d+):(\S{3})$/){$self->{'from'}= $1;$self->{'frds'}= $2;}
#                elsif($_[0]=~ /^(\d+)$/        ){$self->{'from'}= $1;}
#                elsif(exists($digsetz{$_[0]})  ){$self->{'from'}= scalar(@{$digsetz{$_[0]}});
#                                                 $self->{'frds'}= $_[0];}
#                if   ($_[1]=~ /^(\d+):(\S{3})$/){$self->{'tobs'}= $1;$self->{'tods'}= $2;}
#                elsif($_[1]=~ /^(\d+)$/        ){$self->{'tobs'}= $1;}
#                elsif(exists($digsetz{$_[1]})  ){$self->{'tobs'}= scalar(@{$digsetz{$_[1]}});
#                                                 $self->{'tods'}= $_[1];}}
#     else      {$self->{'from'}=     10;$self->{'tobs'}= $_[0];}
#                if   ($_[0]=~ /^(\d+):(\S{3})$/){$self->{'tobs'}= $1;$self->{'tods'}= $2;}
#                elsif(exists($digsetz{$_[0]})  ){$self->{'tobs'}= scalar(@{$digsetz{$_[0]}});
#                                                 $self->{'tods'}= $_[0];}
#   } else{if   ($nstr=~ /^[-+]?[0-9_]+    (\.[0-9_]*    )?$/x){$self->{'from'}= 10;$self->{'tobs'}= 64;$self->{'mbfo'}->fadd(    $nstr );}
#          elsif($nstr=~ /^[-+]?[0-9A-Z._]+(\%[0-9A-Z._]*)?$/i){$self->{'from'}= 64;$self->{'tobs'}= 10;$self->{'mbfo'}->fadd(b10($nstr));}}}
# $self->{'from'}=  10 unless(exists($self->{'from'}) && defined($self->{'from'}) && $self->{'from'}=~  /^(\d+)$/);
# $self->{'tobs'}=  64 unless(exists($self->{'tobs'}) && defined($self->{'tobs'}) && $self->{'tobs'}=~  /^(\d+)$/);
# # mIt tSt4sPd doubling b64 in2 ocT && Using M:BI->from_oct($ostr) or ->as_oct() prEfixz0 2rEvers dIrection
# if    ($self->{'from'}==10 && $self->{'tobs'}==64){$self->{'strz'}{$self->{'fsrc'}}= b64($self->{'fsrc'});}
# elsif ($self->{'from'}==64 && $self->{'tobs'}==10){$self->{'strz'}{$self->{'fsrc'}}=     $self->{'mbfo'}->fstr();}
# else                                              {$self->f2bf();} # try to convert between other than b10 && b64
# return($self);}
sub cma {my $strn=shift;my $comc=shift||',';my $blok=shift||3; # ECKLNcb3:`cma`cre,8d2,add,com,mas,2lo,ng#,str
  if(!defined($strn) && !-t STDIN){$strn.=$_ while(<STDIN>);}  #   HTTP://Perl.Com/doc/manual/html/pod/perlfaq5.html#How_can_I_output_my_numbers_with
  if(!defined($strn)){$strn='';} # set to empty string if no param or pipe through loaded it
  my  @strz = split(/\n/,$strn); # H92MJK4D:cma && coma were exported from a8.pm for a while but have migr8d here to b8.pm since more applicable with Big numz;
  for(@strz){if(/^\s*[-+]?(\d+)/){my $word = $1; # Bl0Xmplfr0mPerlFAQ5Ab0v; Just:s/^(-?\d+)(\d{3})/$1,$2/g;
                                  my $cwrd =reverse $word;1 while $cwrd=~s/([^,\s]{$blok})([^,\s])/$1$comc$2/; # needs to reset each match or gets $blok+1
                                                          #        cwrd=~s/([^,\s]{$blok})([^,\s])/$1$comc$2/g;
                                     $cwrd =reverse $cwrd;#cwrd=~s/^(\s*)$comc/$1/g;
                                     s/$word/$cwrd/;}} # HBGL0kXa:2du add cma.aft,rde,cim,alp,oin,t as shud not be needing reverse since matchd Lt2Rt raD8 dot;
      $strn =  join("\n",@strz);return($strn);} # orig!enuf cuz must insrt coma,then recalc pos&&from:
sub coma{my $strn=shift;my $comc=shift||',';my $blok=shift||4; # ...like above but dflt comma charz between groups of 4 b64 charz
  if(!defined($strn) && !-t STDIN){$strn.= decode('UTF-8',$_) while(<STDIN>);}
  if(!defined($strn)){$strn='';} # set to empty string if no param or pipe through loaded it
  my  @strz = split(/\n/,$strn);
  for(@strz){if(/^\s*[-+]?([0-9A-Z._]+)(\%([0-9A-Z._]+))?/i){my $word = $1;my $fwrd = '';$fwrd = $3 if(defined($3));
      my $cwrd =reverse $word;1 while $cwrd=~s/([^$comc\s]{$blok})([^$comc\s])/$1$comc$2/; # needs to reset each match or gets $blok+1
         $cwrd =reverse $cwrd;
      my $rwrd =        $fwrd;1 while $rwrd=~s/([^$comc\s]{$blok})([^$comc\s])/$1$comc$2/;
      if(length($rwrd)){$fwrd=~s/^/%/;$rwrd=~s/^/%/;}
      s/$word$fwrd/$cwrd$rwrd/;}}
      $strn = join("\n",@strz);return($strn);} # orig!enuf cuz must insrt coma,then recalc pos&&from:
sub sum8{ # simple function to calcul8 summ8ion down to 1; # F1OL0L88:I just realized sum8 is actually a basic multiply near mid instead of while(--){+=}
  my $sum8= shift;return(0) unless(defined($sum8) && $sum8 && ($sum8 > 0));my $answ= Math::BigFloat->new($sum8);$answ *= (($answ/2.0) + 0.5); return($answ);}
sub sumz{my $llnn=shift(@_);my $lnsz=80;my $lcou=0;$lnsz=$ENV{'COLUMNS'}   if(exists($ENV{'COLUMNS'}));$llnn='-' if(!defined($llnn)); # LiNeSiZe, LastLiNeiNdex
  if       ($llnn=~ /-/){if(exists($ENV{'LINES'})){$llnn=$ENV{'LINES'  }-3;}else{$llnn=0;}}   my $scou=1;my $lbuf= sum8($scou);       #         , LineCOUnt
  my $b8l8= shift(@_) || 0;                                                     if($b8l8 == 1){$lbuf= b64($lbuf);}elsif($b8l8 == 2){$lbuf= b256($lbuf);}
  open   my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  while    ($lcou++ <= $llnn){                          my $nxts= sum8(++$scou);if($b8l8 == 1){$nxts= b64($nxts);}elsif($b8l8 == 2){$nxts= b256($nxts);}
    while  (length("$lbuf $nxts") < $lnsz){$lbuf.=" $nxts";$nxts= sum8(++$scou);if($b8l8 == 1){$nxts= b64($nxts);}elsif($b8l8 == 2){$nxts= b256($nxts);}}
    say     $out8   $lbuf;                 $lbuf =  $nxts ;}
  close     $out8             or die "Can't close duplic8 STDOUT handle: $!";}
sub fact{ # simple function to calcul8 factorials                                  # should be able to just use M:BI->bfac() but ck if this memoize is faster
  my $fact= shift;return(0) unless(defined($fact) && $fact && ($fact > 0));my $answ= Math::BigInt->new(  $fact);while(--$fact){$answ *=$fact;}return($answ);}
sub fctz{my $llnn=shift(@_);my $lnsz=80;my $lcou=0;$lnsz=$ENV{'COLUMNS'}   if(exists($ENV{'COLUMNS'}));$llnn='-' if(!defined($llnn)); # LiNeSiZe, LastLiNeiNdex
  if       ($llnn=~ /-/){if(exists($ENV{'LINES'})){$llnn=$ENV{'LINES'  }-3;}else{$llnn=0;}}   my $fcou=1;my $lbuf= fact($fcou);       #         , LineCOUnt
  my $b8l8= shift(@_) || 0;                                                     if($b8l8 == 1){$lbuf= b64($lbuf);}elsif($b8l8 == 2){$lbuf= b256($lbuf);}
  open   my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  while    ($lcou++ <= $llnn){                          my $nxtf= fact(++$fcou);if($b8l8 == 1){$nxtf= b64($nxtf);}elsif($b8l8 == 2){$nxtf= b256($nxtf);}
    while  (length("$lbuf $nxtf") < $lnsz){$lbuf.=" $nxtf";$nxtf= fact(++$fcou);if($b8l8 == 1){$nxtf= b64($nxtf);}elsif($b8l8 == 2){$nxtf= b256($nxtf);}}
    say     $out8   $lbuf;                 $lbuf =  $nxtf ;}
  close     $out8             or die "Can't close duplic8 STDOUT handle: $!";}
sub choo{ # simple function to calcul8 n choose m  (i.e., (n! / (m! * (n - m)!)))  # should be able to just use M:BI->bnok() && ck bpi() 4my l8r CLI U8:pi
  my $nstr= shift(@_);my $mstr= shift(@_);return('') unless(defined($nstr) && defined($mstr));
  my $ennn= Math::BigInt->new($nstr);my $emmm= Math::BigInt->new($mstr);return(0) unless(defined($ennn) && defined($emmm) && $ennn&& $emmm&& ($ennn!=$emmm));
  ($ennn,$emmm)=($emmm,$ennn) if($ennn < $emmm); # orig (n->bcmp(m) < 0) but just testing lessthan could be slightly more direct if obj method can be loc8d
  my $diff= $ennn->copy()->bsub($emmm);my $answ= $ennn->copy()->bfac();my $mfct= $emmm->copy()->bfac();my $dfct= $diff->copy()->bfac();$mfct->bmul($dfct);
  return(0) if($mfct->is_zero());$answ->bdiv($mfct);return($answ->bstr());}
sub fibo{ # simple function to calcul8 Fibonacci numbers with memoized recursive BigInt comput8ion (now iter8ing up instead of deep-recursing down)
  my $nthf= shift;return(0) unless(defined($nthf));$nthf= int($nthf);return(0) unless(  $nthf > 0);return(1) if(  $nthf <  3) ;
  my $answ= Math::BigInt->new('1');for(3..$nthf){$answ += Math::BigInt->new(fibo($_-1));$answ -= Math::BigInt->new(fibo($_-3));};return($answ);}
sub fibz{my $llnn=shift(@_);my $lnsz=80;my $lcou=0;$lnsz=$ENV{'COLUMNS'}   if(exists($ENV{'COLUMNS'}));$llnn='-' if(!defined($llnn)); # LiNeSiZe, LastLiNeiNdex
  if       ($llnn=~ /-/){if(exists($ENV{'LINES'})){$llnn=$ENV{'LINES'  }-3;}else{$llnn=0;}}   my $fcou=1;my $lbuf= fibo($fcou);       #         , LineCOUnt
  my $b8l8= shift(@_) || 0;                                                     if($b8l8 == 1){$lbuf= b64($lbuf);}elsif($b8l8 == 2){$lbuf= b256($lbuf);}
  open   my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  while    ($lcou++ <= $llnn){                          my $nxtf= fibo(++$fcou);if($b8l8 == 1){$nxtf= b64($nxtf);}elsif($b8l8 == 2){$nxtf= b256($nxtf);}
    while  (length("$lbuf $nxtf") < $lnsz){$lbuf.=" $nxtf";$nxtf= fibo(++$fcou);if($b8l8 == 1){$nxtf= b64($nxtf);}elsif($b8l8 == 2){$nxtf= b256($nxtf);}}
    say     $out8   $lbuf;                 $lbuf =  $nxtf ;}
  close     $out8             or die "Can't close duplic8 STDOUT handle: $!";}
my @prls=(2);my $mcnd=$#prls;my $mcsq=$prls[-1]**2; # PRimeLiSt, MaxCheckiNDex && MaxCheckSQuared all stored globally within module
sub prim{ # simple function to calcul8 prime     numbers with memoized && local     int comput8ion (redo wi BigInt?)
  my $nthp= shift(@_);return('') unless(defined($nthp));return($prls[$nthp - 1]) if(@prls >= $nthp);my $npnc=$prls[-1]; # simply return desired already found
  while     (@prls  <  $nthp){my $fail=0;$npnc += 2;$npnc-- if($npnc == 4);
    while   ($npnc  >= $mcsq){$mcnd++;$mcsq=$prls[$mcnd] ** 2;} # upd8 MaxCheck until at least NewCandid8 SQuared
    for   my $cndx (0..$mcnd){ # loop up to the MaxCheckiNDex
      unless($npnc  %  $prls[$cndx]){$fail=1;last;}} # testing for no remainder from dividing all primes up to square-root
    push    (@prls,    $npnc) unless($fail);} # keep appending next newest prime values until reaching the desired nth one to return
  return    ($prls[-1]);}
sub prmz{my $llnn=shift(@_);my $lnsz=80;my $lcou=0;$lnsz=$ENV{'COLUMNS'}   if(exists($ENV{'COLUMNS'}));$llnn='-' if(!defined($llnn)); # LiNeSiZe, LastLiNeiNdex
  if       ($llnn=~ /-/){if(exists($ENV{'LINES'})){$llnn=$ENV{'LINES'  }-3;}else{$llnn=0;}}   my $pcou=1;my $lbuf= prim($pcou);       #         , LineCOUnt
  my $b8l8= shift(@_) || 0;                                                     if($b8l8 == 1){$lbuf= b64($lbuf);}elsif($b8l8 == 2){$lbuf= b256($lbuf);}
  open   my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  while    ($lcou++ <= $llnn){                          my $nxtp= prim(++$pcou);if($b8l8 == 1){$nxtp= b64($nxtp);}elsif($b8l8 == 2){$nxtp= b256($nxtp);}
    while  (length("$lbuf $nxtp") < $lnsz){$lbuf.=" $nxtp";$nxtp= prim(++$pcou);if($b8l8 == 1){$nxtp= b64($nxtp);}elsif($b8l8 == 2){$nxtp= b256($nxtp);}}
    say     $out8   $lbuf;                 $lbuf =  $nxtp ;}
  close     $out8             or die "Can't close duplic8 STDOUT handle: $!";}
# might want to also add nth piii && eeee digitz here too (or maybe add b8 b64 or b256 input options) && would be pretty cool to build a new Simp app that
#   colorfully anim8z growing d8a filez for sumz fctz fibz prmz && piiz && eeez all integr8d together as screensaver like old prym
sub rotW{my @strz=();push(@strz, join(' ',@_))  if(@_); # similR2 vim Vsele g? rot13 but on 32 4b64 charz. Vsele thN :!rotW only works on whole linez (!C-v);
         my $rslt='';push(@strz,<STDIN>) if(!-t STDIN); # should accept @ARGV stringz to rot8 before STDIN (if not a TTY)
  for(@strz){y/0-9A-Za-z._/W-Za-z._0-9A-V/;$rslt .= $_;}  return($rslt);} # basic b64 char trnsl8n BlO (nOt th@Unicode mIt catch many accented charz in there)
sub rot1{my @strz=();push(@strz, decode('UTF-8', join(' ',@_)))  if(@_);  # this is similR2 rotW above but on 128 for b256 charz; # l8r cud proly gNr8 halves
         my $rslt='';push(@strz, decode('UTF-8',<STDIN>)) if(!-t STDIN);my $b2f1='';my $b2s1=''; # Base256 First&&Second128       #   from custom256 digset too
  for(0..127){$b2f1.=$digsetz{'256'}[$_];$b2s1.=$digsetz{'256'}[128+$_];} # not using rangez below since accented standard letterz might match in wrong order
  for(@strz){eval("y/$b2f1$b2s1/$b2s1$b2f1/");$rslt.=$_;} return($rslt);} # normal y/// transl8 does not interpol8 scalar halves so string needs to be evalU8d
sub calQ{my $ajps='';if(@_){$ajps=join('',@_);}elsif(!-t STDIN){$ajps=join('',<STDIN>);}$ajps=~ s/(\s|_|,)+//g;my $bgfl=''; # AllJoinedParamStringz && BiGFLoat
  if ($ajps=~ /h/i){$ajps='';$bgfl=" calQ v$VERSION d8VS:$d8VS crE8d by $auth to CALcul8 most standard math oper8ions using high-precision BigFloat objects;
   h - print this Help text and exit
       all spaces, underscores, and commas are stripped from input, so feel free to include them for clarity when entering particularly large numbers.
       all altern8s below are case-insensitive except 'x' times and 'X' Xor. two adjacent times characters like 'xx' can be used for exponentE8ion.
   l - altern8 for Left     ( parenthesis
   r - altern8 for Right    ) parenthesis
   b - altern8 for Bang     ! exclam8ion  (unary logical  neg8ion not implemented yet!)
   n - altern8 for Neg8     ~ tilde       (unary bit-wise neg8ion not implemented yet!)
   x - altern8 for multiply * asterisk    (this option is particularly useful for avoiding normal shell file-globbing behavior when asterisk is unescaped)
   d - altern8 for Divide   / slash
   m - altern8 for Modulo   % percent
   p - altern8 for add      + Plus
   s - altern8 for Subtract - minus
   a - altern8 for And      & AmpersAnd
   o - altern8 for Or       | pipe
   X - altern8 for Xor      ^ caret
       basic parens seem to work but some oper8or precedence will still be going simply left-to-right without following the proper priorities expected from
         HTTPS://PerlDoc.Perl.Org/perlop.html or other typical math utility functions like `bc` and `dc`. Reverse-Polish Not8ion in `orpie` side-steps this.
       calQ is exported from the Octology::b8 Perl Module and comes with a small executable wrapper script which is intended to be suitable for placing in a
         bin/ directory which is in the user's path. you might also find it useful to crE8 a symbolic-link to the script with a command like:
         `cd ~/bin/; ln -s calQ q` which will enable entering expressions like `q '64-(128/7)+15'` from the shell and ':r!q 4096xx2048-1' from within vim.
       2du:rewrite parsing to handle arbitrary expressions in parens, expand sub-expressions in real precedence order, handle unary oper8ors, add ++ and --;
";} # clear all other parameters && assign return value BiGFLoat to hold Help text instead
  $ajps=~ s/s/-/gi;$ajps=~ s/p/+/gi;$ajps=~ s/d/\//gi;$ajps=~ s/o/|/gi;$ajps=~ s/a/&/gi;$ajps=~ s/x/*/g;$ajps=~ s/X/^/g;$ajps=~ s/n/~/gi;$ajps=~ s/m/%/gi;
  $ajps=~ s/l/(/gi;$ajps=~ s/r/)/gi;$ajps=~ s/b/!/gi; # strips spaces,underscores,commas, then allows 'x' times to altern8 for multiply asterisk && also takes:
  # Left&&Right parens,Bang,Neg8,Divide,Modulo,Plus,Subtract,And,Or,Xor, all are case-insensitive except x times && Xor; # HTTPS://PerlDoc.Perl.Org/perlop.html
  while  ($ajps=~  / (\(                 (-?\.?\d+(\.\d+)?([Ee][-+]?\d+)?)
                     (\*\*|[-+*\/&|^!~%])(-?\.?\d+(\.\d+)?([Ee][-+]?\d+)?)\))/x){my $grup=$1;$bgfl=Math::BigFloat->new("$2"   );
                                                                                 my $oper=$5;my $nxtn = $6; # OPER8or  && NeXTNumber
  # to support proper precedence, probably need sepR8 parser that processes innermost parens first which right-assoC8s all ** first (maybe after adding
  #   handling for ++ and --), then gets right-assoC8ive unary ! and ~, then left assoC8s * / %, then left + -, then left &, and finally left | ^;
  # current paren handling will not manage multiple oper8ors like `q '3x(8-4-2)'` properly since it is only matching single enclosed numb pairs joined by oper;
    if     ($oper eq '**'){$bgfl**= Math::BigFloat->new("$nxtn");} # following unary oper8ors probably need to precede bgfl with no oper or nxtn match
  # elsif  ($oper eq  '!'){$bgfl  =                     !$bgfl  ;}elsif($oper    eq  '~'){$bgfl  =                     ~$bgfl  ;}
    elsif  ($oper eq  '*'){$bgfl *= Math::BigFloat->new("$nxtn");}elsif($oper    eq  '/'){$bgfl /= Math::BigFloat->new("$nxtn");}
    elsif  ($oper eq  '%'){$bgfl %= Math::BigFloat->new("$nxtn");}
    elsif  ($oper eq  '+'){$bgfl += Math::BigFloat->new("$nxtn");}elsif($oper    eq  '-'){$bgfl -= Math::BigFloat->new("$nxtn");}
    elsif  ($oper eq  '&'){$bgfl &= Math::BigFloat->new("$nxtn");}
    elsif  ($oper eq  '|'){$bgfl |= Math::BigFloat->new("$nxtn");}elsif($oper    eq  '^'){$bgfl ^= Math::BigFloat->new("$nxtn");}
  # $grup      =~ s/ (    [()+*\/&|^]   )/\\$1/gx; # not sure what else might need escaping yet; say "grup:$grup:oper:$oper:nxtn:$nxtn:bgfl:$bgfl:";sleep(1);
    $ajps      =~ s/\Q$grup\E/$bgfl/g;} # try to supplant most nested parens with their computed value before processing basic left-to-right on results below
  if     ($ajps=~ s/^                    (-?\.?\d+(\.\d+)?([Ee][-+]?\d+)?)  //x){         $bgfl  = Math::BigFloat->new("$1"   ); # mAB XtNd Dfalt precision?
    while($ajps=~ s/^(\*\*|[-+*\/&|^!~%])(-?\.?\d+(\.\d+)?([Ee][-+]?\d+)?)  //x){my $oper=$1;my $nxtn = $2; # OPER8or  && NeXTNumber
      if   ($oper eq '**'){$bgfl**= Math::BigFloat->new("$nxtn");}
  #   elsif($oper eq  '!'){$bgfl  =                     !$bgfl  ;}elsif($oper    eq  '~'){$bgfl  =                     ~$bgfl  ;}
      elsif($oper eq  '*'){$bgfl *= Math::BigFloat->new("$nxtn");}elsif($oper    eq  '/'){$bgfl /= Math::BigFloat->new("$nxtn");}
      elsif($oper eq  '%'){$bgfl %= Math::BigFloat->new("$nxtn");}
      elsif($oper eq  '+'){$bgfl += Math::BigFloat->new("$nxtn");}elsif($oper    eq  '-'){$bgfl -= Math::BigFloat->new("$nxtn");}
      elsif($oper eq  '&'){$bgfl &= Math::BigFloat->new("$nxtn");}
      elsif($oper eq  '|'){$bgfl |= Math::BigFloat->new("$nxtn");}elsif($oper    eq  '^'){$bgfl ^= Math::BigFloat->new("$nxtn");}}}
  return   ($bgfl);}
# used to prefer benchmarked fast module when possible, but needed clunky overrides below for interface compatibility, now commented probably l8r to be rmvd
#package Math::Base::Convert;no warnings;    # redefine vet subroutine to have b64 defaults (&& disable the redef warnings)
#sub vet{my $class = shift;my $from = shift || '';my $to = shift || '';
# $to   =~ s/\s+//g if $to   && !ref $to  ; # strip white space
# $from =~ s/\s+//g if $from && !ref $from;
# unless($from){$to   = &dec;  # was HEX    # defaults if not defined
#               $from = &b64;} # was dec
# else         {$from = validbase($from);
#   unless($to){$to   = &b64;} # was HEX
#   else       {$to   = validbase($to  );}}
# # convert sub ref's    to variables
# #    $to            =&$to  ;
# #   ($from,my $fhsh)=&$from;
# my $prefix =  ref     $to  ;
# if   ($prefix =~ /heX$/ ){$prefix = '';}#0x';}
# elsif($prefix =~ /ocT$/i){$prefix = '0' ;}
# elsif($prefix =~ /bin$/ ){$prefix = '0b';}
# else                     {$prefix =   '';}
# bless{to      =>          $to    ,
#       tbase   =>  scalar @$to    ,
#       from    =>          $from  ,
#       fhsh    =>  basemap($from) ,
#       fbase   =>  scalar @$from  ,
#       prefix  =>          $prefix,},$class;}
#my %maxdlen=(2  => 31,  # 2^1  # digits, key is base
#            4  => 16,  # 2^2
#            8  => 10,  # 2^3
#           16  =>  8,  # 2^4
#           32  =>  6,  # 2^5
#           64  =>  5,  # 2^6
#          128  =>  4,  # 2^7
#          256  =>  4); # 2^8
#sub cnvpre{my $bc = &_cnv;return $bc unless ref $bc;
# my($from,$fbase,$to,$tbase,$sign,$prefix,$nstr)=@{$bc}{qw(from fbase to tbase sign prefix nstr)};#$nstr =~ s/\s+//g;
# my $slen = length($nstr);
# my $tref =    ref($to  );
# unless(   $slen                   ){$nstr = $to->[0];}   # zero length input, return zero
# elsif (lc $tref eq lc ref($from)  ){ # no base conversion
#   if  (   $tref ne    ref($from)  ){ #   convert case?
#     if   ($tref =~ /(DNA|HEX|B36)/){$nstr = uc $nstr;}   #    force upper case
#     elsif($tref =~ /(dna|heX|b36)/){$nstr = lc $nstr;}}} # or force lower case
# else{ my $fblen = length($fbase);    # convert
#   if($fbase & $fbase -1 || $fblen > 256                             ){        $bc->useFROMbaseto32wide ;}  # from base is not power of 2, no shortcuts...
#   elsif(                   $fblen >  32 && !$slen > $maxdlen{$fbase}){        $bc->useFROMbaseto32wide ;}  # big  base && digit str fit32reg  # CalcPP faster
#   else                                                               {        $bc->useFROMbaseShortcuts;}  # shortcuts faster for big numbers
#   # input converted to base 2^32 #
#   if($tbase & $tbase -1 || $tbase > 256                             ){$nstr = $bc->use32wideTObase     ;}  # from base is not power of 2, no shortcuts...
#   elsif(                   $tbase >  32 && @{$bc->{b32str}} == 1    ){$nstr = $bc->use32wideTObase     ;}  # big  base && digit str fit32reg  # CalcPP faster
#   else                                                               {$nstr = $bc->useTObaseShortcuts  ;}} # shortcuts faster for big numbers
# $nstr = $to->[0] unless length($nstr);
# if   (    $tref =~ /(DNA|HEX|B36)/){$nstr = uc $nstr;}   #    force upper case
# elsif(    $tref =~ /(dna|heX|b36)/){$nstr = lc $nstr;}   # or force lower case
# return($sign,$prefix,$nstr) if wantarray;
# if(#$prefix ne '' &&  # 0x, 0, 0b
#    $tbase <= $signedBase && $tref ne 'user'){return($sign . $prefix . $nstr);} # base in signed set
#                                              return(        $prefix . $nstr);}
#package Octology::b8;
8;

=encoding utf8

=head1 NAME

Octology::b8 - Basic functions or BigFloat or Math::Base::Convert objects for Base-transl8ions

=head1 VERSION

This document8ion refers to version 0.0 of Octology::b8, which was released on 
.

=head1 SYNOPSIS

  #!/usr/bin/perl
  use strict;use warnings;use utf8;use v5.10;use Octology::b8;

       # Base-transl8       63 from base-10 (decimal) to base- 2 (binary )
  my $binary__63 = b8(      63 , 10,  2 );
       # Base-transl8   111111 from base- 2 (binary ) to base-16 (HEX    )
  my $HEX_____63 = b8(  111111 ,  2, 16 );
       # Base-transl8       3F from base-16 (HEX    ) to base-10 (decimal)
  my $decimal_63 = b8(     '3F', 16, 10 );
  say "63 dec->bin $binary__63 bin->HEX $HEX_____63 HEX->dec $decimal_63";

=head1 DESCRIPTION

b8 provides a few simple functions (which also should serve as similar object methods) for converting between arbitrary number bases.

=head1 PURPOSE

b8 was crE8d to intuitively handle transl8ions between arbitrary number bases as either exported functions or objects which inherit from BigFloat such that
they can be incorpor8d into rel8ively normal looking math equ8ions for manipul8ion but will stringify configurably into the destin8ion "to-base" by default.
Some attempt is made to store a cache of multiple values along with performed conversions within each object, to make repeated use more efficient.

=head1 USAGE

=head2 new()

This is the standard b8 object constructor.

=head2 b8($numb[,$from[,$tobs]])

Base-transl8 the number contained in $numb from its current number base ($from) into the result number base ($tobs).

Note: The rules corresponding to absent parameters described here may well be out-of-d8.

B<When only $numb is provided as a parameter:>

If $numb only contains valid decimal (base 10) digits, it will be converted to base 64.

If $numb only contains valid hexadecimal (base 16) digits && begins with '0x', it will be converted to decimal (base 10).

If $numb only contains valid base 64 characters                              , it will be converted to decimal (base 10).

B<When only $numb && $from are provided as parameters:>

If $numb only contains valid decimal (base 10) digits && $from is not equal to 10, $from will be used as $tobs && $from will become 10.

Otherwise $numb will be converted to decimal (base 10).

B<When all three parameters are provided:>

The normal (&& most clear) usage of b8() is to provide all three parameters where $numb is converted from $from base to $tobs.

=head2 cnv($numb[,$from[,$tobs]])

cnv() is an altern8 way to call b8(). It is short for CoNVert and is available for compatibility with the original L<Math::BaseCnv> interface.

=head2 b10($b64n)

A shortcut to convert the number given as a parameter ($b64n) from base 64 to decimal (base 10). b64() is the inverse of b10().

=head2 b64($b10n)

A shortcut to convert the number given as a parameter ($b10n) from decimal (base 10) to base 64. b10() is the inverse of b64().

=head2 b64sort(@b64s)

A way to sort b64 strings as though they were decimal numbers.

=head2 b128($b10n)

A shortcut to convert the number given as a parameter ($b10n ) from decimal (base 10) to base 128. b110() is the inverse of b128().
b128() uses UTF-8 Chess and Cards characters for the top 64 (half).

=head2 b110($b128n)

A shortcut to convert the number given as a parameter ($b128n) from base 128 to decimal (base 10). b128() is the inverse of b110().

=head2 b256($b10n)

A shortcut to convert the number given as a parameter ($b10n ) from decimal (base 10) to base 256. b210() is the inverse of b256().
b256() uses UTF-8 accent characters for the top 128 (half).

=head2 b210($b256n)

A shortcut to convert the number given as a parameter ($b256n) from base 256 to decimal (base 10). b256() is the inverse of b210().

=head2 dec($b16n)

A shortcut to convert the number given as a parameter ($b16n) from HEXadecimal (base 16) to decimal (base 10).  HEX() or heX() is the inverse of dec().
dec() is similar to Perl's built-in hex().

=head2 HEX($b10n)

A shortcut to convert the number given as a parameter ($b10n) from decimal (base 10) to HEXadecimal (base 16) uppercase. dec() is the inverse of HEX();

=head2 heX($b10n)

A shortcut to convert the number given as a parameter ($b10n) from decimal (base 10) to heXadecimal (base 16) lowercase. dec() is the inverse of heX();

Please read the L<"NOTES"> regarding heX().

=head2 deC($bs8n)

A shortcut to convert the number given as a parameter ($bs8n) from   ocTal (base  8) to decimal (base 10).

=head2 ocT($b10n)

A shortcut to convert the number given as a parameter ($b10n) from decimal (base 10) to   ocTal (base  8).

=head2 dig(\@newd)

Assign the new digit character list to be used in place of the default one. dig() can also alternately accept a string name matching one of the
following predefined digit sets:

  'bin' => ['0', '1'],
  'dna' => ['a', 'c', 'g', 't'],
  'DNA' => ['A', 'C', 'G', 'T'],
  'ocT' => ['0'..'7'],
  'dec' => ['0'..'9'],
  'heX' => ['0'..'9', 'a'..'f'],
  'HEX' => ['0'..'9', 'A'..'F'],
  'b36' => ['0'..'9', 'a'..'z'],
  'B36' => ['0'..'9', 'A'..'Z'],
  'b62' => ['0'..'9', 'a'..'z', 'A'..'Z'],
  'b64' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'], # max Month:C:12 Day:V:31
  'm64' => ['A'..'Z', 'a'..'z', '0'..'9', '+', '/'], # MIME::Base64 0..63
  'iru' => ['A'..'Z', 'a'..'z', '0'..'9', '[', ']'], # P10 server-server protocol used by IRCu daemon
  'url' => ['A'..'Z', 'a'..'z', '0'..'9', '-', '_'], # MIME::Base64::URLSafe which avoids %2B && %2F expansions of '+' && '/' respectively (U2b ID likely this)
  'rgx' => ['A'..'Z', 'a'..'z', '0'..'9', '!', '-'], # Regular EXpression variant
  'id0' => ['A'..'Z', 'a'..'z', '0'..'9', '_', '-'], # IDentifier style 0
  'id1' => ['A'..'Z', 'a'..'z', '0'..'9', '.', '_'], # IDentifier style 1
  'xnt' => ['A'..'Z', 'a'..'z', '0'..'9', '.', '-'], # XML Name Tokens (Nmtoken)
  'xid' => ['A'..'Z', 'a'..'z', '0'..'9', '_', ':'], # XML identifiers (Name   )
  'sxl' => ['?', '@', 'A'..'Z', '[','\\', ']', '^',  # Sixel Base64 from VT100.Net
            '_', '`', 'a'..'z', '{', '|', '}', '~'],
  'b85' => ['0'..'9', 'A'..'Z', 'a'..'z', '!', '#',  # RFC 1924 for IPv6 addresses like in Math::Base85
            '$', '%', '&', '(', ')', '*', '+', '-',
            ';', '<', '=', '>', '?', '@', '^', '_',
            '`', '{', '|', '}', '~'               ],
  'asc' => [' ', '!', '"', '#', '$', '%', '&', "'",  # Base96 7-bit printable 0x20 (space) - 0x7F
            '(', ')', '*', '+', ',', '-', '.', '/',  #   (tilde ~) 'ascii' from Math::Base::Convert
            '0'..'9', ':', ';', '<', '=', '>', '?',
            '@', 'A'..'Z', '[','\\', ']', '^', '_',
            '`', 'a'..'z', '{', '|', '}', '~'     ],
  'b96' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base96 but starting with b64 characters
            ' ', '!', '"', '#', '$', '%', '&', "'",
            '(', ')', '*', '+', ',', '-', '/', ':',
            ';', '<', '=', '>', '?', '@', '[','\\',
            ']', '^', '`', '{', '|', '}', '~'     ],
  '128' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base128 but starting with b64 characters (blacK chS pibrq before White, then cRdz sHDc, then k && K)
            '♟', '♙', '♞', '♘', '♝', '♗', '♜', '♖', '♛', '♕', '🂡', '🂱', '🃁', '🃑', '🂢', '🂲', '🃂', '🃒', '🂣', '🂳', '🃃',
            '🃓', '🂤', '🂴', '🃄', '🃔', '🂥', '🂵', '🃅', '🃕', '🂦', '🂶', '🃆', '🃖', '🂧', '🂷', '🃇', '🃗', '🂨', '🂸', '🃈', '🃘',
            '🂩', '🂹', '🃉', '🃙', '🂪', '🂺', '🃊', '🃚', '🂫', '🂻', '🃋', '🃛', '🂭', '🂽', '🃍', '🃝', '🂮', '🂾', '🃎', '🃞', '♚', '♔'],
  '256' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  # Base256 but starting with b128characters (then appending the 128 most common accented characters)
            '♟', '♙', '♞', '♘', '♝', '♗', '♜', '♖', '♛', '♕', '🂡', '🂱', '🃁', '🃑', '🂢', '🂲', '🃂', '🃒', '🂣', '🂳', '🃃',
            '🃓', '🂤', '🂴', '🃄', '🃔', '🂥', '🂵', '🃅', '🃕', '🂦', '🂶', '🃆', '🃖', '🂧', '🂷', '🃇', '🃗', '🂨', '🂸', '🃈', '🃘',
            '🂩', '🂹', '🃉', '🃙', '🂪', '🂺', '🃊', '🃚', '🂫', '🂻', '🃋', '🃛', '🂭', '🂽', '🃍', '🃝', '🂮', '🂾', '🃎', '🃞', '♚', '♔', # shud ck if BlO =~ /[A-Z]/
            'À','Á','Â','Ã','Ä','Å','Æ','Ç',  'È','É','Ê','Ë','Ì','Í','Î','Ï',  'Ð','Ñ','Ò','Ó','Ô','Õ','Ö','×',  'Ø','Ù','Ú','Û','Ü','Ý','Þ','ß',
            'à','á','â','ã','ä','å','æ','ç',  'è','é','ê','ë','ì','í','î','ï',  'ð','ñ','ò','ó','ô','õ','ö','÷',  'ø','ù','ú','û','ü','ý','þ','ÿ',
            'Ā','ā','Ă','ă','Ą','ą','Ć','ć',  'Ĉ','ĉ','Ċ','ċ','Č','č','Ď','ď',  'Đ','đ','Ē','ē','Ĕ','ĕ','Ė','ė',  'Ę','ę','Ě','ě','Ĝ','ĝ','Ğ','ğ',
            'Ġ','ġ','Ģ','ģ','Ĥ','ĥ','Ħ','ħ',  'Ĩ','ĩ','Ī','ī','Ĭ','ĭ','Į','į',  'İ','ı','Ĳ','ĳ','Ĵ','ĵ','Ķ','ķ',  'ĸ','Ĺ','ĺ','Ļ','ļ','Ľ','ľ','Ŀ']);

If no \@newd list or digit set name is provided as a parameter, dig() returns the current character list. It's fine to have many more characters
in your current digit set than will be used with your conversions (e.g., using dig('256') works fine for any b8() conversion call where $from and $tobs
parameters are less than or equal to 256).

An example of a \@newd parameter for a specified alternate digit set for base 9 conversions is:

  dig( [ qw( n a c h o z   y u m ) ] );

=head2 diginit()

Resets the used digit list to the initial default order of the predefined digit set: '256'. This is simply a shortcut for calling dig('256') for
reinitializ8ion purposes.

=head2 sum8($numb)

A simple function to calcul8 a          BigFloat summ8ion  of $numb down to 1. This used to loop down like fact, but was replaced with a basic multiply.

=head2 fact($numb)

A simple function to calcul8 a memoized BigInt   factorial of $numb.

=head2 choo($ennn, $emmm)

A simple function to calcul8 a memoized BigInt   function  of $ennn choose $emmm.

=head2 fibo($numb)

A simple function to calcul8 a memoized BigInt   Fibonacci    $numb.

=head2 rotW($b64s)

A simple function to rot8 the base-64  string $b64s  by  32. rotW() is similar to vim's Virtual selection then 'g?' rot13 command, just working with more
characters. Note that when you make a vim Virtual-mode selection then :!rotW in Command-mode, it only works on whole lines (not Ctrl-v column selections).

=head2 rot1($b256s)

A simple function to rot8 the base-256 string $b256s by 128. rot1() is similar to vim's Virtual selection then 'g?' rot13 command, just working with more
characters. Note that when you make a vim Virtual-mode selection then :!rot1 in Command-mode, it only works on whole lines (not Ctrl-v column selections).

=head1 NOTES

The Perl built-in hex() function takes a HEXadecimal string as a parameter and returns the decimal value (FromBase = 16, ToBase = 10). This not8ion was
counter-intuitive to me. I prefer to read the code as though my HEX() function will turn the parameter into HEXadecimal i.e., I think of HEX() as
going to "HEXify" my parameter, but Perl's built-in does the opposite. I initially decided to invert the not8ion from Perl's built-in for my similar functions,
so I originally redefined hex() with such reversed behavior, but I have since reconsidered the potential harm possible by introducing exported conflicting
opposite behavior into other people's maybe critical code-bases. So I have fallen back on employing unique letter-casing with my HEX() and heX() routines, and
I am now leaving the built-in hex() unmolested.

My b64() function takes a decimal number as a parameter and returns the base64 equivalent (FromBase = 10, ToBase = 64) and my b10() function takes a base64
number (string) and returns the decimal value (FromBase = 64, ToBase = 10). My HEX() and heX() functions oppose Perl's built-in hex() (which is similar to my
dec() routine). HEX() returns uppercase and heX() returns lowercase.

Please think of my dec() and HEX() + heX() functions as meaning "decify" and "HEXify". Also my preferred pronunC8ion of dec() is like "dess" (not "deck").

Error checking is minimal.

This module now handles preliminary fractional b64 numbers using the percent '%' character as the sepR8or from the integer component. Hopefully the caret '^'
can l8r be added as the sepR8or for an exponent field, with little conflict on the command-line. I think two carets in popular shells tries to substitute
within command history, but a single caret may be left alone and not require escaping.

sum8(), fact(), choo(), and fibo() are general Math function utilities which are unrel8d to number-base conversion but I didn't feel like making another
sepR8 module just for them so they snuck in here.

I hope you find Octology::b8 useful. L8r.

=head1 CHANGES

Revision history for Perl extension Octology::b8:

=over 2

=item - 0.0 H5MM2nT7  Mon May 22 02:49:29:07 -0500 2017

* renamed bb10 to b110 (as opposite of b128), which now better matches b210 (turning b256 into base-10 decimal)

=item - 0.0 G7OMBm7O  Sun Jul 24 11:48:07:24 -0500 2016

* added digit set 'b96' like 'asc' but starting with preferred default b64 characters

* renumbered and upd8d t/*.t

* rewrote originally memoized summ loop as sum8 with single BigFloat multiply && added fibo

* attempted to extend main conversion routines to allow piping values from STDIN as an altern8ive to the original parameter interface

* rewrote defaults to favor b64 && compacted spacing

* upd8d available dig lists (adding b36 && asc)

* added b64colr just for basic ANSI Escape coloring to start with, then generalized to b8color && moved it over to a8::b8colr

* migr8d Math::BaseCnv over to Octology::b8

=back

=head1 TODO

=over 2

=item - employ Math::Base::Convert objects beneath classic subroutine interface && start transitioning to objects

=item - handle neg8ion && fractional parts with percent as frac sep && caret for exponent, or pound, colon, or better sepR8ors

=item - allow cnv() to be piped thru like b8()

=item - better error checking && testing (&& benchmark?)

=back

=head1 INSTALL

From the command shell, please run:

  `perl -MCPAN -e "install Octology::b8"`

or uncompress the package and run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 FILES

Octology::b8 requires:

L<Math::Base::Convert>   to sub-class fast number objects from

L<Math::BigFloat>        to allow Big         sum8()            results

L<Math::BigInt>          to allow Big fact(), choo(), && fibo() results

L<Memoize>               to cache     fact(), choo(), && fibo() results

L<Carp>                  to allow errors  to croak() from calling sub

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2003-2016, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
