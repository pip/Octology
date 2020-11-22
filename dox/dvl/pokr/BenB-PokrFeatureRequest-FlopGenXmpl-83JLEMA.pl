#!/usr/bin/perl -X
#
# flop-gen.pl
#
# - Ben Breuninger, 3/7/08
#   pocketaces79@gmail.com

use Games::Cards::Poker qw(:all);

@deck=qw(
As:A:13:s:4:52 Ah:A:13:h:3:51 Ad:A:13:d:2:50 Ac:A:13:c:1:49
Ks:K:12:s:4:48 Kh:K:12:h:3:47 Kd:K:12:d:2:46 Kc:K:12:c:1:45
Qs:Q:11:s:4:44 Qh:Q:11:h:3:43 Qd:Q:11:d:2:42 Qc:Q:11:c:1:41
Js:J:10:s:4:40 Jh:J:10:h:3:39 Jd:J:10:d:2:38 Jc:J:10:c:1:37
Ts:T:9:s:4:36  Th:T:9:h:3:35  Td:T:9:d:2:34  Tc:T:9:c:1:33
9s:9:8:s:4:32  9h:9:8:h:3:31  9d:9:8:d:2:30  9c:9:8:c:1:29
8s:8:7:s:4:28  8h:8:7:h:3:27  8d:8:7:d:2:26  8c:8:7:c:1:25
7s:7:6:s:4:24  7h:7:6:h:3:23  7d:7:6:d:2:22  7c:7:6:c:1:21
6s:6:5:s:4:20  6h:6:5:h:3:19  6d:6:5:d:2:18  6c:6:5:c:1:17
5s:5:4:s:4:16  5h:5:4:h:3:15  5d:5:4:d:2:14  5c:5:4:c:1:13
4s:4:3:s:4:12  4h:4:3:h:3:11  4d:4:3:d:2:10  4c:4:3:c:1:9
3s:3:2:s:4:8   3h:3:2:h:3:7   3d:3:2:d:2:6   3c:3:2:c:1:5
2s:2:1:s:4:4   2h:2:1:h:3:3   2d:2:1:d:2:2   2c:2:1:c:1:1
);

# Variable definitions for @deck:
#
# @deck[0] Card Hand, ex: 'As' for Ace of Spades
# @deck[1] Card Rank Character, ex. 'A' for Ace
# @deck[2] Card Rank Value, ex. 'A' == 13
# @deck[3] Card Suit Character, ex. 'h' = Hearts
# @deck[4] Card Suit Value, ex. 'd' == 2
# @deck[5] Card Deck Order, from 52 to 1
# 

sub hole_cards {
 $hole="";
 @hole1=();
 @hole2=();
 foreach (@deck) { @h1=split(/:/,$_);
  foreach (@deck) { @h2=split(/:/,$_);
   if(@h1[5]>@h2[5]) {
    $hole.="@h1:@h2\n";
   }
  }
 }
 return $hole;
}


sub flop_cards {
 $flop="";
 foreach (@deck) { @f1=split(/:/,$_);
  foreach (@deck) { @f2=split(/:/,$_);
   foreach (@deck) { @f3=split(/:/,$_);
    if(@f1[5]>@f2[5] && @f2[5]>@f3[5]) {
     $flop.="@f1:@f2:@f3\n";
    }
   }
  }
 }
return $flop;
}



sub the_nuts {
 $ret="";
 @nuts=();
 $nuts="";
 $ret="";
 $cards="";
 @f1=split(' ',$f1);@f2=split(' ',$f2); @f3=split(' ',$f3);
 foreach(split(/\n/,&hole_cards)) {
  ($h1,$h2)=split(/:/,$_); @h1=split(' ',$h1); @h2=split(' ',$h2);
  if(@h1[0] ne @f1[0] && @h1[0] ne @f2[0] && @h1[0] ne @f3[0] && 
     @h2[0] ne @f1[0] && @h2[0] ne @f2[0] && @h2[0] ne @f3[0]) {
   @hand=(@h1[0],@h2[0],@f1[0],@f2[0],@f3[0]);
   $score=ScoreHand(@hand);
   $type=HandName($score);
   $nuts.="@f1[0]@f2[0]@f3[0]:@h1[0]@h2[0]:$score:$type\n";
  }
 }
 # sort it by $score lowest to highest
 @nuts=sort { (split ':', $a, 3)[2] <=> (split ':', $b, 3)[2] }split(/\n/,$nuts);
 $i=0;
 foreach(@nuts) {
  ($flop,$hole,$score,$type)=split(':',$_);
  @hry=split(//,$hole);
  $h1="@hry[0]@hry[1]";
  if($i==0) { $atype=$type;$ascore=$score;$ah1=$h1; }
  if($type eq $atype) {
   if($atype eq "Royal Flush") {$cards.="$hole,"; }
   elsif($atype eq "Straight Flush" && $ascore eq $score) {$cards.="$hole,";}
   elsif($atype eq "Four-of-a-Kind") {$cards.="$hole,";}
   elsif($atype eq "Full House") {} # REDUNDANT
   elsif($atype eq "Flush" && $ah1 eq $h1) {$cards.="$hole,";}
   elsif($atype eq "Straight" && $ascore eq $score) {$cards.="$hole,";}
   elsif($atype eq "Three-of-a-Kind" && $ascore eq $score) {$cards.="$hole,";}
  }
  $i++;
 }
 chop($cards);
 $pre="$flop:$cards:$atype";
 return $pre;
}

foreach $flop (split(/\n/,&flop_cards)) {
 ($f1,$f2,$f3)=split(':',$flop); 
 foreach(&the_nuts($f1,$f2,$f3)) { print "$_\n";$d++; }
}






exit 0;
