#!/usr/bin/perl
# 654FD2A - OddsQuery.pm created by Pip Stuart <Pip@CPAN.Org> to query pre-computed Hold'Em odds
package Games::Cards::Poker::OddsQuery;
require Exporter;
use base qw(Exporter);
our @EXPORT = qw(OddsQuer);
use Math::BaseCnv       qw(:all);
use Games::Cards::Poker qw(:all);
use XML::Tidy;
sub OddsQuer {
  my @crdz = @_; my @deck = Deck(); my @sutz; my @bord; my @hole; my %slut; my $suit; my $dirf; my $hstr; my %oatz; my @sord = ('s', 'h', 'd', 'c');
  my $oflg = 0; my $oppo = 1; my @smap = (); my %mopo = (); my @ways = (); my %dros = ('s' => 0, 'h' => 1, 'd' => 2, 'c' => 3); my $verb = 0;
  for(0..$#crdz) { # search for opponent parameter -o#
    if($crdz[$_] =~ /^-o(\d+)$/i) {
      $oppo = $1;
      $oflg =  1 if($oppo > 1);
      splice(@crdz, $_, 1); # remove opponent parameter
      last;
    }
  }
  @crdz = B64Hand(@crdz) if(@crdz == 1 && length($crdz[0]) > 1); # split a compressed B64 hand string apart
  if(@crdz < 2 || @crdz == 3 || @crdz == 4 || @crdz > 7) {
    if($verb) {
      print "!*EROR*! Unsupported number of cards passed as parameters!\n  Please provide only 2, 5, 6, or 7 total cards.\n";
    }
  } else {
    if($verb) {
      print "Searching on cards:@crdz with $oppo opponent"; print 's' if($oppo > 1); print "...\n";
    }
    if     (@crdz == 2) {
      @hole = @crdz;
      SortCards(\@hole);
      print "      Sorted cards:@hole\n" if($verb);
      for(@hole) {
        $suit = substr($_, 1, 1);
        if((@sutz == 0                                                               ) ||
           (@sutz == 1 && $sutz[0] ne $suit                                          ) ||
           (@sutz == 2 && $sutz[0] ne $suit && $sutz[1] ne $suit                     ) ||
           (@sutz == 3 && $sutz[0] ne $suit && $sutz[1] ne $suit && $sutz[2] ne $suit)) {
          push(@sutz, $suit);
        }
      }
      for(0..$#sutz) { $slut{$sutz[$_]} = $sord[$_]; }
      if($verb) {
        print '             suits: ' . join('  ', @sutz), "\n";
        print "Translated   cards:\n";
      }
      $dirf = 'hole.xml'; $hstr = '';
      for(@hole) { s/(.)(.)/$1$slut{$2}/; } SortCards(\@hole);
      for(@hole) {
        my($rank, $suit)= split(//, $_);
        print "                   $rank$suit => " . CardB64("$rank$suit") . "\n" if($verb);
        $hstr .= CardB64("$rank$suit");
      }
      if(-e $dirf) {
        printf("  File:%-6s", $dirf) if($verb);
        my $tidy = XML::Tidy->new($dirf);
        my($hnod)= $tidy->findnodes("/hole/$hstr");
        print " hole:      $hstr\n" if($verb);
        for my $attr ($hnod->getAttributes()) {
          printf('    ' . $attr->getName() . " => %12s\n", $attr->getNodeValue()) if($verb);
          $oatz{$attr->getName()} = $attr->getNodeValue();
        }
        $oatz{'ottl'} = $oatz{'abov'} + $oatz{'same'} + $oatz{'belo'};
        if($verb) {
          print "Heads-Up Odds:\n";
          printf("    Wins:   %11.7f%%\n", ($oatz{'belo'} * 100.0 / $oatz{'ottl'}));
          printf("    Ties:   %11.7f%%\n", ($oatz{'same'} * 100.0 / $oatz{'ottl'}));
          printf("    Lose:   %11.7f%%\n", ($oatz{'abov'} * 100.0 / $oatz{'ottl'}));
        }
      } else {
        print "  File:$dirf not found!\n" if($verb);
      }
    } elsif(@crdz == 5) {
      @hole = ($crdz[-2], $crdz[-1]);
      SortCards(\@hole);
      SortCards(\@crdz);
      print "      Sorted cards:@crdz\n" if($verb);
      $_ = CardDec($_) for(@crdz);
      @crdz = SABM(@crdz);
      @smap = SMAP();
      $_ = DecCard($_) for(@crdz);
      print "Translated   cards:\n" if($verb);
      $dirf = HandB64(@crdz); substr($dirf, 3, 0, '/');
      $hole[0] .= $sord[$smap[$dros{chop($hole[0])}]];
      $hole[1] .= $sord[$smap[$dros{chop($hole[1])}]];
      $hstr = HandB64(@hole); # suit-abstracted hole cards (last two of the five provided) for odds look-up
      for(@crdz) {
        my($rank, $suit)= split(//, $_);
        print "                   $rank$suit => " . CardB64("$rank$suit") . "\n" if($verb);
      }
      if(-e $dirf) {
        printf("  File:%-6s", $dirf) if($verb);
        my $tidy = XML::Tidy->new($dirf);
        my($hnod)= $tidy->findnodes("/*/hole/$hstr");
        print " hole:      $hstr\n" if($verb);
        for my $attr ($hnod->getAttributes()) {
          printf('    ' . $attr->getName() . " => %12s\n", $attr->getNodeValue()) if($verb);
          $oatz{$attr->getName()} = $attr->getNodeValue();
        }
        $oatz{'ottl'} = $oatz{'abov'} + $oatz{'same'} + $oatz{'belo'};
        if($verb) {
          print "Heads-Up Odds:\n";
          printf("    Wins:   %11.7f%%\n", ($oatz{'belo'} * 100.0 / $oatz{'ottl'}));
          printf("    Ties:   %11.7f%%\n", ($oatz{'same'} * 100.0 / $oatz{'ottl'}));
          printf("    Lose:   %11.7f%%\n", ($oatz{'abov'} * 100.0 / $oatz{'ottl'}));
        }
      } else {
        print "  File:$dirf not found!\n" if($verb);
      }
    } elsif(@crdz == 6) { # add post-turn stuff here once stage 2 is done
    } elsif(@crdz == 7) {
      @hole = (pop(@crdz), pop(@crdz));
      SortCards(\@hole);
      SortCards(\@crdz);
      print "      Sorted cards:@crdz @hole\n" if($verb);
      $_ = CardDec($_) for(@crdz);
      @crdz = SABM(@crdz);
      $_ = DecCard($_) for(@crdz);
      push(@crdz, @hole);
      print "Translated   cards:\n" if($verb);
      $dirf = HandB64(@crdz); $hstr = substr($dirf, -2, 2, ''); substr($dirf, 3, 0, '/');
      for(@crdz) {
        my($rank, $suit)= split(//, $_);
        print "                   $rank$suit => " . CardB64("$rank$suit") . "\n" if($verb);
      }
      if(-e $dirf) {
        printf("  File:%-6s", $dirf) if($verb);
        my $tidy = XML::Tidy->new($dirf);
        my($hnod)= $tidy->findnodes("/*/grup/oddz/$hstr");
        print " hole:      $hstr\n" if($verb);
        for my $attr ($hnod->getParentNode()->getAttributes()) {
          printf('    ' . $attr->getName() . " => %12s\n", $attr->getNodeValue()) if($verb);
          $oatz{$attr->getName()} = $attr->getNodeValue();
        }
        $oatz{'ottl'} = $oatz{'abov'} + $oatz{'same'} + $oatz{'belo'};
        if($verb) {
          print "Heads-Up Odds:\n";
          printf("    Wins:   %11.7f%%\n", ($oatz{'belo'} * 100.0 / $oatz{'ottl'}));
          printf("    Ties:   %11.7f%%\n", ($oatz{'same'} * 100.0 / $oatz{'ottl'}));
          printf("    Lose:   %11.7f%%\n", ($oatz{'abov'} * 100.0 / $oatz{'ottl'}));
        }
      } else {
        print "  File:$dirf not found!\n" if($verb);
      }
    }
    if($oppo > 1) { # extrapolate odds for multiple opponents from known heads-up odds
      print "Opponent Odds: ($oppo)\n" if($verb);
      $mopo{'win'} = ($oatz{'belo'} * 1.0 / $oatz{'ottl'}); # single win likelihood
      $mopo{'tie'} = ($oatz{'same'} * 1.0 / $oatz{'ottl'}); # single tie likelihood
      for(0..((2 ** $oppo) - 1)) { # compute all combinations of just getting wins and ties...
        my $bits = cnv($_, 10, 2); # mk the next binary number
        my $tcou = 0;  $tcou++ while($bits =~ s/1//); # count up the tie bits
        $ways[$tcou]++; # keep track of how many ways have been discovered to get this number of ties
        $mopo{"ties$tcou"} = ($mopo{'win'} ** ($oppo - $tcou)) * ($mopo{'tie'} ** $tcou) unless(exists($mopo{"ties$tcou"}));
      }
      $mopo{'wins'} = ($mopo{'win'} ** $oppo);
      printf("    Wins:   %11.7f%%\n", ($mopo{'wins'} * 100.0)) if($verb);
      for(1..$#ways) {
        printf("    Ties$_:  %11.7f%%  ways:%-3d mopo:%-11f\n", ($mopo{"ties$_"} * $ways[$_] * 100.0), $ways[$_], $mopo{"ties$_"}) if($verb);
        $mopo{'ties'} += ($mopo{"ties$_"} * $ways[$_]);
      }
      printf("    Ties:   %11.7f%%\n", ($mopo{'ties'} * 100.0)) if($verb);
      $mopo{'lose'} = 1.0 - ($mopo{'wins'} + $mopo{'ties'});
      printf("    Lose:   %11.7f%%\n", ($mopo{'lose'} * 100.0)) if($verb);
    } else {
      $mopo{'wins'} = sprintf("%11.7f", ($oatz{'belo'} / $oatz{'ottl'}));
      $mopo{'ties'} = sprintf("%11.7f", ($oatz{'same'} / $oatz{'ottl'}));
      $mopo{'lose'} = sprintf("%11.7f", ($oatz{'abov'} / $oatz{'ottl'}));
    }
  }
  return(($mopo{'wins'} * 100.0) . ' ' . ($mopo{'ties'} * 100.0) . ' ' . ($mopo{'lose'} * 100.0));
}
