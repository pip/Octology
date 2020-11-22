#!/usr/bin/perl -w
# 43KNlxM - fULnAME.pm created by Pip Stuart <Pip@CPAN.Org> to provide Poker functions using only Perl.

=head1 NAME

fULnAME - Pure Perl Poker functions

=head1 VERSION

This documentation refers to version pKGvERS of fULnAME, which was released on ptptIME.

=head1 SYNOPSIS

  # SAMPLE REGULAR POKER GAME
  use fULnAME;
  # Deal four (4) players hands and score them...
  my $players   = 4; # number of players to get hands dealt
  my $hand_size = 5; # number of cards to deal to each player
  my @hands     = ();# player hand data
  my @deck      = Shuffle(Deck());
  while($players--) {
    push(@{$hands[$players]},   pop(@deck))  for(1..$hand_size);
    printf("Player$players score:%4d hand:@{$hands[$players]}\n",
                                HandScore(@{$hands[$players]}));
  }

  # SAMPLE TEXAS HOLD'EM GAME
  use fULnAME;
  # Deal five (5) board cards and ten (10) players holes and score them...
  my $board_size =    5; # number of cards to deal to the community board
  my $players    =   10; # number of players to get hands dealt
  my @holes      =   (); # player hole  data
  my @board      =   (); # board (first 3 are flop, next turn, last river)
  my @best_score =   (); # player score data
  my @found      =   (); # list of players found with certain best scores
  my @deck       = Shuffle(Deck());
  my $winners    =  'P'; # list of indices of winning players
  my $win_points =    0; # the awarded win_score (fractional if tied)
  my $win_score  = 7462; # the lowest score that won the game
  while($board_size--) { push(@board, shift(@deck)); }
  printf("Board(    flop:%9s     turn: $board[3]     " .
         "river: $board[4]    )\n", join(' ', SortCards(@board[0..2])));
  for(0..($players - 1)) { # Deal hands
    @{$holes[   $_]} = SortCards(shift(@deck), shift(@deck));
    $best_score[$_]  = HandScore(BestHand(@{$holes[$_]}, @board));
  }
  for(reverse(sort { $a <=> $b } @best_score)) { # print hands worst to best
    for my $player (0..($players - 1)) { # match score back to player(s)
      if((@found < $player || !$found[$player]) &&
         ($best_score[$player] == $_          )) {
        $found[$player]++;
        printf("Player$player: @{$holes[$player]}  ShortHand: %-4s",
                     ShortHand(@{$holes[$player]}));
        printf("  BestHand: %14s",
             join(' ', SortCards(BestHand(@{$holes[$player]}, @board))));
        printf("        Score: %4d\n", $best_score[$player]);
      }
    }
    $win_score = $_; # last scores should be best (i.e., lowest) and win
  }
  for(0..($players - 1)) { # build winners list and count point split
    if($win_score == $best_score[$_]) { $winners .= "$_,"; $win_points++; }
  }
  chop($winners); # strip the extra comma from the end
  if($win_points) { $win_points = (1.0 / $win_points); }
  else            { $win_points =  1.0;                }
  printf("%-7s:     awarded WinPoints: %1.4f                " .
         "for lowest Score: %4d\n  HandName:%s  VerboseHandName:%s\n",
         $winners, $win_points, $win_score, HandName($win_score),
         VerboseHandName($win_score));

  # SAMPLE BLACKJACK GAME
  use fULnAME qw(:blak);
  # Deal four (4) players hands and score them against a dealer...
  my $players   = 4; # number of players to get hands dealt (including dealer)
  my $shoe_size = 4; # number of decks to load into shoe
  my $hand_size = 2; # number of cards to deal to each player
  my @hands     = ();# player hand card  data
  my @scores    = ();# player hand score data && purse bank-roll data below
  my @purses    = (1000000.0); for(my $p=($players-1);$p>=0;$p--) { # funding
    $purses[$p] = 10.0 if($p);printf("Player$p Purse:\$%6.2f\n",$purses[$p]);}
  my @shoe      = ();
  for my $round (0..(shift() || 3)) {
    while($players--) {
      if(scalar(@shoe) <= ($players       * ($hand_size + 5)) &&
         scalar(@shoe) <  (scalar(Deck()) *  $shoe_size     )) {
      push(@shoe, Deck())  for(1..$shoe_size); Shuffle(\@shoe);} # mk shoe full
      push(@{$hands[$players]},   pop(@shoe))  for(1..$hand_size);
            $scores[$players] = BJHandScore(@{$hands[$players]});
      if(           $players) { print 'Play'; }
      else                    { print 'Deal';
                                while(  $scores[0] < 17) {
                                  push(@{$hands[0]}, pop(@shoe));
                                        $scores[0] = BJHandScore(@{$hands[0]});
                                } }
      printf(    "er$players Score:%4d hand:@{$hands[$players]}",
                                             $scores[$players]);
      print  ' Busted!'               if(    $scores[$players] >21);
      print  ' BlackJack!'            if(BJ(@{$hands[$players]})  );print "\n";
    }       $players = scalar(@scores);
    while(--$players) { my $amount = 0.0;
      $amount = (BJ(@{$hands[$players]})) ? 1.5 :
                 BJCmp($scores[0], $scores[$players]);
      printf("Player$players CmpD0: %6.2f\n", $amount); $purses[0] -= $amount;
                                                 $purses[$players] += $amount;
    }     $players = scalar(@scores); @hands = (); # reset data @ end of round
  }
  for(my $p=($players-1);$p>=0;$p--) {
    printf("Player$p Purse:\$%6.2f\n", $purses[$p]); } # show end-game purses

=head1 DESCRIPTION

pKGnAME provides a few functions for creating decks of
cards and manipulating them for simple Poker games or simulations.

=head1 2DO

=over 2

=item - at least imp fast score in C version if not also here (from Nov2005 GameDevMag): 6 4-bit nibbles, 6-elem array, 6-char string (or b13 int?) - First is
          type, rest are ranks in significance order.  Benchmark diff approaches.  Type: 0==HighCard,1==Pair,2==2Pair..9==Royal.  Straights only need 2nd elem
          to track highest card rank.

=item - rm all %pdat ways data (since all can be determined easily)

=item - mk CalcOdds() work accurately and for more opponents and factor in stages beyond hole

=item - better error checking

=item -    What else does pKGnAME need?

=back

=head1 USAGE

=head2 Deck()

Returns a new array of scalars with the abbreviated Poker names of
cards (e.g., 'As' for 'Ace of Spades', 'Td' for 'Ten of Diamonds',
'2c' for 'Two of Clubs', etc.).

Use CardName() to expand abbreviated cards into their full names.

=head2 Shuffle(@cards)

Shuffles the passed in @cards array in one quick pass.  Shuffle()
returns a shuffled copy of the @cards array.

Shuffle() can also take an arrayref parameter instead of an explicit
@cards array in which case, the passed in arrayref will be shuffled
in place so the return value does not need to be reassigned.

=head2 SortCards(@cards)

Sorts the passed in @cards array.  SortCards() returns a sorted copy of the @cards array.

SortCards() can also take an arrayref parameter instead of an explicit @cards array in which case, the passed in arrayref will be sorted in place so the
return value does not need to be reassigned.

SortCards() works consistently on the return values of ShortHand() as well as abbreviated cards (e.g., 'AAA', 'AAK'..'AKQs', 'AKQ'..'222').

=head2 ShortHand(@hand)

Returns a scalar string containing the abbreviated Poker description
of @hand (e.g., 'AKQJTs' for any of the four possible 'Royal Flush'
hands, 'QQ993' as a specific example of one of the many possible
'Two Pair' hands comprised of Queens and Nines with a Three kicker,
etc.).

ShortHand() calls SortCards() on its parameter before doing the abbreviation in order to make sure that the return value is consistent (even knowing
that this is typically a redundant operation).

ShortHand() can be called on fewer cards than a full @hand of 5 to
obtain other useful abbreviations (e.g., ShortHand(@hole) will return
the abbreviated form of a player's two hole [pocket] cards or
ShortHand(@flop) will abbreviate the three community cards which
flop onto the board in Hold'Em).

=head2 HandScore(@hand)

Returns an integer score (where lower is better) for the passed in Poker @hand.  This means 0 (zero) is returned for a Royal Flush and the worst
possible score of 7461 is awarded to 7, 5, 4, 3, 2 unsuited.

If you want higher scores to mean higher hands, just subtract the return value from 7461.

All suits are considered to have equal value in this scoring function. It should be easy to use HandScore() as a first pass where ties can be resolved
by another suit-comparison function if you require such behavior.

This function does the inverse of ScoreHand() by accepting an array of cards or a ShortHand() string and returning the proper associated Poker score.

This version simply indexes the string as a key into a hash of corresponding score values so it is quite fast.

=head2 ScoreHand($score)

This function is the opposite of HandScore().  It takes an integer
$score parameter and returns the corresponding ShortHand() string.

ScoreHand() uses a fully enumerated table to simply index the associated ShortHand() so it is quite fast.  The table was generated by running
OrigHandScore() on every possible hand and sorting the resultant unique ShortHand() values by their associated scores.

=head1 ADVANCED USAGE

=head2 BestIndices(@cards)

BestIndices() takes 5 or more cards (normally 7) which can be
split among separate arrays (like BestIndices(@hole, @board) for
Hold'Em) and returns an array of the indices of the 5 cards (hand)
which yield the best score.

=head2 BestHand(@best, @cards)

BestHand() takes the return value of BestIndices() as the
first parameter (which is an array of the best indices) and then the
same other parameters (@cards) or (@hole, @board) to give you a copy
of just the best cards.  The return value of this function can be
passed to HandScore() to get the score of the best hand.

BestHand() can optionally take just the @cards like
BestIndices() and it will automagically call BestIndices()
first to obtain @best.  It will then return copies of those indexed
cards from the @cards.

=head2 HandName($score)

HandName() takes a HandScore() parameter (e.g., 0, 2000, 7000) and
returns the name of the corresponding hand scoring category it falls
under (e.g., 'Royal Flush', 'Three-of-a-Kind', 'High Card').

HandName() can optionally accept an arrayref to a hand, the @hand
itself, or a ShortHand instead of the $score parameter.

=head2 VerboseHandName($score)

VerboseHandName() takes a HandScore() parameter (e.g., 0, 2000, 7000)
and returns the name of the corresponding verbose (i.e., commonly
spoken) description of the hand (e.g., 'Aces over Kings',
'Tens, Jack kicker', 'Queen high, Ten kicker').  VerboseHandName()
should normally be used in conjunction with HandName() as a further
clarification of a specific hand's description.

VerboseHandName() can optionally accept an arrayref to a hand,
the @hand itself, or a ShortHand instead of the $score parameter.

=head2 NameCard($name)

NameCard() does the opposite of CardName() by taking an expanded
full $name (e.g., 'Queen of Diamonds', 'Jack of Hearts', 'Ten of Clubs')
and returning the abbreviated card (e.g., 'Qd', 'Jh', 'Tc').

=head2 CardName($card)

CardName() takes an abbreviated $card (e.g., 'As', 'Kh', '2c') and
returns the expanded full name of the card ('Ace of Spades',
'King of Hearts', 'Two of Clubs').

=head2 B64Card($b64c)

B64Card() does the opposite of CardB64() by taking a base-64 card
($b64c) representation (e.g., 'K', 'N', 'T') and returning the abbreviated
card (e.g., 'Qd', 'Jh', 'Tc').

=head2 CardB64($card)

CardB64() takes an abbreviated $card (e.g., 'As', 'Kh', '2c') and
returns the single character (only letters) base-64 representation
of the card ('A', 'F', 'z');

Please see the L<"NOTES"> section below for the complete B64 <-> Card
conversion table.

=head2 B64Hand($b64h)

B64Hand() does the opposite of HandB64() by taking a string containing
several concatenated base-64 card abbreviations and converting it into
a list of the cards.

=head2 HandB64(@hand)

HandB64() takes a list of cards which make up a @hand (or a reference to
such an array) and returns a base-64 abbreviation string.

=head2 DecCard($decc)

DecCard() does the opposite of CardDec() by taking a decimal card
($decc) representation (e.g., '0', '3', '51') and returning the abbreviated
card (e.g., 'As', 'Ac', '2c').

=head2 CardDec($card)

CardDec() takes an abbreviated $card (e.g., 'As', 'Kh', '2c') and
returns the corresponding decimal card representation ('0', '15', '51').

=head2 DecHand($dech)

DecHand() does the opposite of HandDec() by taking a string containing
several concatenated decimal card abbreviations and converting it into
a list of the cards.

=head2 HandDec(@hand)

HandDec() takes a list of cards which make up a @hand (or a reference to
such an array) and returns an array of decimal abbreviations.

=head2 RemoveCard($card, @cards)

Returns a copy of @cards with abbreviated $card (e.g., 'Td') removed.

RemoveCard() can also take an arrayref parameter instead of an explicit
@cards array in which case, the passed in arrayref will be updated
in place so the return value does not need to be reassigned.

=head2 WorstHand(@cards)

Returns the ShortHand description of the worst hand possible using
@cards.  This means that if there are fewer than 5 @cards, it returns
simply the worst hand containing all of them however if there are 5 or
more cards, it returns the same result as the abbreviated best hand
(i.e., ShortHand(BestHand(BestIndices(@cards), @cards)) )since that is also
the worst hand you are guaranteed to at least have out of your @cards.

WorstHand() can also accept an arrayref or ShortHand parameter in place
of a list of cards.

WorstHand() is useful for calculating odds when you have a chance to
improve your hand by future cards but you want to know the minimum hand
or score you are guaranteed of.

=head2 CountWays($bad_score_limit [,$good_score_limit])

CountWays() helps calculate odds by summing the ways to get a range of
abbreviated card sets (normally just ShortHands) between the
$bad_score_limit (which starts from 7461, the bad 'High Card' end of
hands) to the optional $good_score_limit (which starts from 0, the good
'Royal Flush' end of hands).

=head2 CalcOdds($hole_index)

CalcOdds() takes the index of a hole abbreviation (e.g., %zloh = Zloh;
CalcOdds($zloh{'AA'})) from a Hold'Em game and returns the percent that
will win against all possibilities.

CalcOdds() is currently a failed experiment at approximation for heads up
situations but it will hopefully be improved later as more Poker
statistics can be understood and incorporated.

=head2 OrigHandScore(@hand)

This is the original computational method used to derive scores for Poker hands.  It uses combinatorics && a lot of evaluation of relative ranks &&
suits.  It is therefore much slower && has been deprecated in favor of the direct look-up available through HandScore().  It is kept around for
posterity because it was a thoroughly interesting mathematical challenge to compute perfectly compressed scoring in this fashion.

=head2 PDat() and Other Poker Data Accessors

PDat() is my global Poker Data structure which contains all of the data
used to populate each of the smaller structures below.  These can all
be accessed with the :data export tag with:

  use fULnAME qw(:data);

RPrV() - Simple accessor to my Rank Progression Value hash where ranks
are keys and their indices in RPrg() are values.

RPrg() - Simple accessor to my Rank Progression array: 'A'..'2'

SPrg() - Simple accessor to my Suit Progression array: 's'..'c'

RNam() - Simple accessor to my Rank Name array: 'Ace'..'Two'

SNam() - Simple accessor to my Suit Name array: 'Spades'..'Clubs'

Namz() - Simple accessor to my Hand Name hash where keys are score
thresholds and values are full names of hand categories.

Zman() - The reverse of Namz() where values and keys switch.

Hndz() - Simple accessor to my ShortHands array in score order.

Zdnh() - The reverse of Hndz() as a hash where ShortHands key their
score value.

Holz() - Simple accessor to my ShortHands array of possible holes.

Zloh() - The reverse of Holz() as a hash where ShortHands key their
index value.

Flpz() - Simple accessor to my ShortHands array of possible flops.

Zplf() - The reverse of Flpz() as a hash where ShortHands key their
index value.

=head1 EXPORT TAGS

fULnAME normally only exports a few key Poker functions (Deck Shuffle SortCards ShortHand ScoreHand HandScore) into your local namespace when you:

  use fULnAME;

You can specify additional export tags such as:

  use fULnAME qw(:all);

for when you want to utilize more than just the above default functions.

=head2 :all

Exports everything!

  Shuffle Deck SortCards ShortHand HandName VerboseHandName
  BestIndices CardB64 B64Hand CardDec DecHand ScoreHand CardName
  BestHand    B64Card HandB64 DecCard HandDec HandScore NameCard
  WorstHand RemoveCard CountWays CalcOdds OrigHandScore
  RPrg RNam Namz Hndz Holz Flpz RPrV SPrg SNam Zman Zdnh Zloh Zplf PDat
                                   BJ BJCmp BJHandScore

=head2 :best

This tag just exports functions for finding the best hand out of some
list of more than 5 cards.

  BestIndices BestHand

=head2 :name

This tag exports functions which convert between verbose names for cards
and hands.

  CardName NameCard HandName VerboseHandName

=head2 :b64

This tag exports functions which convert between base-64 representations
of cards and hands.

  CardB64 B64Card HandB64 B64Hand

=head2 :dec

This tag exports functions which convert between decimal representations
of cards and hands.

  CardDec DecCard HandDec DecHand

=head2 :odds

This tag exports functions which should be useful in calculating odds.

  WorstHand RemoveCard CountWays CalcOdds OrigHandScore

=head2 :blak

This tag just exports functions useful for BlackJack.

  BJ BJCmp BJHandScore

=head2 :data

This tag exports all internal data sets in case direct access to them
is beneficial.

  RPrg RNam Namz Hndz Holz Flpz RPrV SPrg SNam Zman Zdnh Zloh Zplf PDat

=head1 WHY?

Games::Poker::* wouldn't compile correctly for me since it had some
  weird broken .xs dependencies I couldn't figure out so I thought it
  shouldn't take too long to write my own Poker module purely in Perl. =)
  It was certainly a fun problem...  much trickier than I first imagined
  but I think I have solved the problem elegantly once and for all.

=head1 NOTES

Suits are: s,h,d,c (Spade,Heart,Diamond,Club) like bridge (anti-alphabetical).
  Although they are sorted and appear in this order, suits are ignored for
  scoring by default (but can be optionally reordered and scored later)

B64 notes: Cards map perfectly into A..Z,a..z (indx += 10) for one letter rep

                                                                        Suits:
  B64 Cards: A.As E.Ks I.Qs M.Js Q.Ts U.9s Y.8s c.7s g.6s k.5s o.4s s.3s w.2s 0
             B.Ah F.Kh J.Qh N.Jh R.Th V.9h Z.8h d.7h h.6h l.5h p.4h t.3h x.2h 1
             C.Ad G.Kd K.Qd O.Jd S.Td W.9d a.8d e.7d i.6d m.5d q.4d u.3d y.2d 2
             D.Ac H.Kc L.Qc P.Jc T.Tc X.9c b.8c f.7c j.6c n.5c r.4c v.3c z.2c 3
      Ranks:   0    1    2    3    4    5    6    7    8    9    A    B    C

  B64 Cards: A.As B.Ah C.Ad D.Ac Ranks: 0
             E.Ks F.Kh G.Kd H.Kc        1
             I.Qs J.Qh K.Qd L.Qc        2
             M.Js N.Jh O.Jd P.Jc        3
             Q.Ts R.Th S.Td T.Tc        4
             U.9s V.9h W.9d X.9c        5
             Y.8s Z.8h a.8d b.8c        6
             c.7s d.7h e.7d f.7c        7
             g.6s h.6h i.6d j.6c        8
             k.5s l.5h m.5d n.5c        9
             o.4s p.4h q.4d r.4c        A
             s.3s t.3h u.3d v.3c        B
             w.2s x.2h y.2d z.2c        C
             0.Jokr                    -1
      Suits:    0    1    2    3

Error checking is minimal.

I hope you find fULnAME useful.  Please feel free to e-mail
me any suggestions or coding tips or notes of appreciation
("app-ree-see-ay-shun").  Thank you.  TTFN.

=head1 CHANGES

Revision history for Perl extension fULnAME:

=over 4

=item - pKGvERS  ptptIME

* s/Slow//g && further downplay OrigHandScore

* s/(Hand|Score)(Score|Hand)/$2$1/g to be consistent with others (e.g., CardB64 implying X-to-Y)

* s/(for)each/$1/g

* fixed DecCard(0) to return 'As' error reported by Dan C.

* restored code &&'s, reverted license

=item - 1.2.565CHh5  Sun Jun  5 12:17:43:05 2005

* added VerboseHandName() from code contributed by Roy Lyons

* fixed Shuffle() off-by-one results skewing error reported by Lee

=item - 1.2.4CCJ12M  Sun Dec 12 19:01:02:22 2004

* added MySQL and XML and .c and Tk scripts to bin/

* fixed pod typo and updated License

=item - 1.2.46QD4ax  Sat Jun 26 13:04:36:59 2004

* added Dec functions

=item - 1.2.4610lBw  Tue Jun  1 00:47:11:58 2004

* removed benchmrk.pl since it's not worth including in pkg

* fixed some out-of-date POD and rearranged USAGE

=item - 1.2.45UGmiC  Sun May 30 16:48:44:12 2004

* upped minor version number since CPAN doesn't recognize my PTVR

* split test.pl into t/*.t and added those + bin/pokr to MANIFEST

* added separate EXPORT_TAGS and added ADVANCED USAGE POD

* added RemoveCard(), WorstHand(), CountWays(), and CalcOdds()

* added %pdat as common structure for all my Poker Data and Counts

* added B64Hand and HandB64 functions

* added simple accessors to internal data

* added possible hole and flop data

* made CardName take either of just rank or suit

* made new b64 card conversion functions: CardB64() and B64Card()

* changed b64 maps to use letters

=item - 1.0.44P0KER  Sun Apr 25 00:20:14:27 2004

* made CardName() to return 'Ace of Spades' or 'Two of Clubs' for
          'As'or'A' or '2c'or'z' and NameCard() to do inverse

* made HandName() to return 'Royal Flush' or 'High Card' for
          ScoreHand() or ShortHand() or @hand or \@hand and NameHand()

* rewrote SortCards() to accept any length ShortHand() params

* s/valu/rank/g s/scor/score/g s/bord/board/g

=item - 1.0.44LCEw8  Wed Apr 21 12:14:58:08 2004

* s/HoldEm//g; on advice from Joe since Best*() are useful for more
    than just Hold'Em (like 7-card stud)

* fixed minor typos in POD

=item - 1.0.44KFNKP  Tue Apr 20 15:23:20:25 2004

* wrote UseSlow() so that benchmrk.pl would still work without Best()
    and in case anyone would rather have ScoreHand() call
    SlowScoreHand() every time instead.

* since my old Best() was actually slower than BestHoldEmIndices() =O
    I removed Best().

* since old Scor() was so much faster than old ScoreHand(), I renamed
    them to ScoreHand() and SlowScoreHand() respectively since
    computational version is unnecessary now.

* wrote benchmrk.pl to test BestHoldEmIndices() + ScoreHand() against
    Best() + Scor().  Best()+Scor() only took 60% as long to run.

* added SortCards() call on ShortHand() param just in case

=item - 1.0.44ILBKV  Sun Apr 18 21:11:20:31 2004

* wrote Scor() with gen'd enumerated hash of ShortHand => Score

* wrote HandScore() to just lookup index of a ShortHand from a score

* squashed 4 scoring bugs in one pair section

* used Algorithm::ChooseSubsets for new BestHoldEmIndices
    (on Jan's recommendation)

* renamed enumerated BestHoldEmIndices() as Best()

* gave ScoreHand() optional arrayref param like others

* gave ScoreHand() optional ShortHand() string param

* updated 2do and tidied up documentation a bit

=item - 1.0.44H2DUS  Sat Apr 17 02:13:30:28 2004

* added BestHoldEmIndices() and BestHoldEmHand() for Tim and Jan

* commented unnecessary Games::Cards inheritance since I haven't written
any compatability / object interface yet

=item - 1.0.44F2Q8F  Thu Apr 15 02:26:08:15 2004

* original version

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install fULnAME"`

or uncompress the package and run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 LICENSE

Most source code should be Free!
  Code I have lawful authority over is && shall be!
Copyright: (c) 2004-2005, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public
  License (version 2).  Please consult the Free Software Foundation
  (http://FSF.Org) for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut

package Games::Cards::Poker;
require              Exporter;
use strict;
use base          qw(Exporter);
use Math::BaseCnv qw(:all    );
use Algorithm::ChooseSubsets;
our @EXPORT      = qw(Shuffle Deck SortCards ShortHand ScoreHand HandScore);
our @EXPORT_OK   = qw(HandName VerboseHandName OrigHandScore
                      BestIndices  CardB64 B64Hand CardDec DecHand  CardName
                      BestHand     B64Card HandB64 DecCard HandDec  NameCard
                      WorstHand RemoveCard CountWays CalcOdds  BJHandScore BJ BJCmp
                       RPrg  RNam  Namz  Hndz  Holz  Flpz  RPrV  SPrg  SNam  Zman  Zdnh  Zloh  Zplf  PDat
                      @rprg @rnam %namz @hndz @holz @flpz %rprv @sprg @snam %zman %zdnh %zloh %zplf %pdat);
our %EXPORT_TAGS = ( 'all' => [ qw(Shuffle Deck SortCards ShortHand
                             HandName VerboseHandName OrigHandScore
             BestIndices  CardB64 B64Hand CardDec DecHand ScoreHand CardName
             BestHand     B64Card HandB64 DecCard HandDec HandScore NameCard
             WorstHand RemoveCard CountWays CalcOdds BJ BJHandScore BJCmp
             RPrg RNam Namz Hndz Holz Flpz RPrV SPrg SNam Zman Zdnh Zloh Zplf PDat) ],
                     'best' => [ qw(BestIndices  BestHand) ],
                     'name' => [ qw(CardName NameCard HandName VerboseHandName) ],
                     'b64'  => [ qw(CardB64   B64Card HandB64  B64Hand) ],
                     'dec'  => [ qw(CardDec   DecCard HandDec  DecHand) ],
                     'odds' => [ qw(WorstHand RemoveCard CountWays CalcOdds OrigHandScore) ],
                     'blak' => [ qw(Shuffle Deck SortCards ShortHand BJ BJCmp BJHandScore) ],
                     'data' => [ qw(RPrg RNam Namz Hndz Holz Flpz RPrV SPrg SNam Zman Zdnh Zloh Zplf PDat) ] );
our $VERSION     = '1.2.pIPtIME'; # major . minor . PipTimeStamp
our $PTVR        = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major and minor
# Please see `perldoc Time::PT` for an explanation of $PTVR.
my %pdat; # global Poker Data hash which all lower data is built from
my @rprg; my @sprg; my @rnam; my @snam; my %rprv; my $indx;
my %namz; my %zman; # hash for score => handname and <= lookups
my @hndz; my %zdnh; # array and hash for faster ShortHand => score
my @holz; my %zloh; # array and hash of possible holes
my @flpz; my %zplf; # array and hash of possible flops
# simple accessors to internal data sets (all are defined at bottom of code)
sub PDat { return(%pdat); } sub RPrV { return(%rprv); }
sub RPrg { return(@rprg); } sub RNam { return(@rnam); }
sub SPrg { return(@sprg); } sub SNam { return(@snam); }
sub Namz { return(%namz); } sub Hndz { return(@hndz); }
sub Zman { return(%zman); } sub Zdnh { return(%zdnh); }
sub Holz { return(@holz); } sub Flpz { return(@flpz); }
sub Zloh { return(%zloh); } sub Zplf { return(%zplf); }
sub Deck { # return an array of cards as a whole new deck in clean new order
  my @deck = ();
  for   my $rank (@rprg) {
    for my $suit (@sprg)   { push(@deck, "$rank$suit"); }
  }
  return(@deck);
}
sub Shuffle { # takes an arrayref or list of items to shuffle
  return(0) unless(@_); # must have at least one parameter
  my $aflg = 0; $aflg = 1 if(ref($_[0]) eq 'ARRAY');
  my $size = 0; my $aref; my @data = @_;
  if($aflg) { $aref =  $_[0]; }
  else      { $aref = \@data; }
  $size = @{$aref};
  for(my $indx = ($size - 1); $indx; $indx--) {
    my $rand  = int(rand($indx+1));
    if($rand != $indx) {
      ($aref->[$indx], $aref->[$rand]) = ($aref->[$rand], $aref->[$indx]);
    }
  }
  if($aflg) { return($aref); }
  else      { return(@data); }
}
sub SortCards { # takes an arrayref or list of cards to sort
  return(0) unless(@_); # must have at least one parameter
  my $aflg = 0; $aflg = 1 if(ref($_[0]) eq 'ARRAY'); my $aref; my @data = @_;
  if($aflg) { $aref = $_[0];  }
  else      { $aref = \@data; }
# what needs to sort:
#  'A'..'2'
#  'As'..'Ac'
#  'AA','AKs','AK'..'A2'
#  'AAA','AAK'..'AKQs','AKQ'..'222'
#  'AAAAK','AAAAQ'..'AKQJTs','AKQJT'..'32222' # based on rank values not scores
  @{$aref} = sort {
    my $indx = 0;
    my $suba = 0;
    my $subb = 0;
    while($suba eq $subb && $indx < length($a)
                         && $indx < length($b)) {
      $suba = substr($a, $indx, 1);
      $subb = substr($b, $indx, 1);
      $indx++;
    } # find first different char
    if   ($suba eq 'A' && $subb ne 'A') { return(-1); }
    elsif($suba ne 'A' && $subb eq 'A') { return( 1); }
    elsif($suba eq 'K' && $subb ne 'K') { return(-1); }
    elsif($suba ne 'K' && $subb eq 'K') { return( 1); }
    elsif($suba eq 'Q' && $subb ne 'Q') { return(-1); }
    elsif($suba ne 'Q' && $subb eq 'Q') { return( 1); }
    elsif($suba eq 'J' && $subb ne 'J') { return(-1); }
    elsif($suba ne 'J' && $subb eq 'J') { return( 1); }
    elsif($suba eq 'T' && $subb ne 'T') { return(-1); }
    elsif($suba ne 'T' && $subb eq 'T') { return( 1); }
    elsif($suba eq $subb)               {
      if   (length($a) >  $indx) { return(-1); }
      elsif(length($b) >  $indx) { return( 1); }
      else                       { return( 0); }
    } else                              { return($b cmp $a); }
  } @{$aref};
  if($aflg) { return($aref); }
  else      { return(@data); }
}
sub ShortHand { # takes an arrayref or list of cards to abbrev.
  return(0) unless(@_); # must have at least one parameter
  my $aflg = 0; $aflg = 1 if(ref($_[0]) eq 'ARRAY'); my $aref; my @data = @_;
  my $suit = 1; my $shrt = '';
  if($aflg) { $aref = $_[0];  }
  else      { $aref = \@data; }
  SortCards($aref) unless(@{$aref} == 1); # make sure cards are sorted first, or leave sorting to the app to perform only when it's needed
  for(@{$aref}) {
    $shrt .=                                  substr($_,         0, 1);
    $suit  = 0 if($suit && (length($_) < 2 || substr($_,         1, 1) ne
                                              substr($aref->[0], 1, 1)));
  }
  $shrt .= 's' if($suit);
  return($shrt);
}
sub OrigHandScore { # takes 1 ShortHand or 5 cards and returns Poker hand score
  my @hand = @_; return(0) unless(@hand == 1 || @hand == 5);
  my $aflg = 0; $aflg = 1 if(ref( $hand[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $hand[0]; }
  else      { $aref = \@hand;    }
  my $scor = 7462; my @data = (); my $flsh = 0; my $strt = 0;
  my ($set0, $set1);                      # temp values for matched sets
  my ($xtr0, $xtr1, $xtr2, $xtr3, $xtr4); # temp values for extra cards
  SortCards($aref) unless(@{$aref} == 1);
  for(my $indx=0; $indx<5; $indx++) {
    if(@{$aref} == 1) {
      ($data[$indx]{'rank'}, $data[$indx]{'suit'}) = (substr($aref->[0], $indx, 1), 's');
    } else {
      ($data[$indx]{'rank'}, $data[$indx]{'suit'}) = split(//, $aref->[$indx]);
    }
  }
  # make data unsuited if ShortHand param only had 5 ranks (no 's' on the end)
  $data[0]{'suit'} = 'h' if(@{$aref} == 1 && length($aref->[0]) == 5);
#  Hand            ScoreRange  Size  Description
#--------------------------------------------------------
#  Royal    Flush     0           1  only one
#  Straight Flush     1..   9     9  King High through 5 High
#  Four-of-a-Kind    10.. 165   156  (13 choose 2) * 2
#  Full House       166.. 321   156  (13 choose 2) * 2
#           Flush   322..1598  1277  (13 choose 5) - 9
#  Straight        1599..1608    10  Ace  High through 5 High
#  Three-of-a-Kind 1609..2466   858  (13 choose 3) * 3
#  Two Pair        2467..3324   858  (13 choose 3) * 3
#  One Pair        3325..6184  2860  (13 choose 4) * 4
#  High Card       6185..7461  1277  (13 choose 5) - 9
#  general straight test
  if     (@rprg            >         ( $rprv{$data[1]{'rank'}} + 1 )   and
          $data[2]{'rank'} eq $rprg[ ( $rprv{$data[1]{'rank'}} + 1 ) ] and
          @rprg            >         ( $rprv{$data[1]{'rank'}} + 2 )   and
          $data[3]{'rank'} eq $rprg[ ( $rprv{$data[1]{'rank'}} + 2 ) ] and
          @rprg            >         ( $rprv{$data[1]{'rank'}} + 3 )   and
          $data[4]{'rank'} eq $rprg[ ( $rprv{$data[1]{'rank'}} + 3 ) ] and
        ((                             $rprv{$data[1]{'rank'}}         and
          $data[0]{'rank'} eq $rprg[ ( $rprv{$data[1]{'rank'}} - 1 ) ] ) ||
         ($data[0]{'rank'} eq 'A' && $data[1]{'rank'} eq '5'))) { $strt = 1; }
#  general flush    test
  if     ($data[0]{'suit'} eq $data[1]{'suit'} and
          $data[0]{'suit'} eq $data[2]{'suit'} and
          $data[0]{'suit'} eq $data[3]{'suit'} and
          $data[0]{'suit'} eq $data[4]{'suit'})                 { $flsh = 1; }
#  Royal    Flush     0           1  only one
  if     ($data[1]{'rank'} eq 'K' && $strt && $flsh) {
    $scor = 0;
#  Straight Flush     1..   9     9  King High through 5 High
  } elsif($strt && $flsh) {
    $scor =       $rprv{$data[0]{'rank'}};
    $scor =  9 if(      $data[0]{'rank'} eq 'A' and
                        $data[1]{'rank'} eq '5');
#  Four-of-a-Kind    10.. 165   156  (13 choose 2) * 2
  } elsif($data[1]{'rank'} eq $data[2]{'rank'} and
          $data[1]{'rank'} eq $data[3]{'rank'} and
         ($data[1]{'rank'} eq $data[4]{'rank'} ||
          $data[1]{'rank'} eq $data[0]{'rank'})) {
    if($data[1]{'rank'} eq $data[0]{'rank'}) { # xxxx y
      $set0 = $rprv{$data[0]{'rank'}};
      $xtr0 = $rprv{$data[4]{'rank'}} - 1;
    } else {                                   # x yyyy
      $set0 = $rprv{$data[4]{'rank'}};
      $xtr0 = $rprv{$data[0]{'rank'}};
    }
    $scor = (10 + ($set0 * 12) + $xtr0);
#  Full House       166.. 321   156  (13 choose 2) * 2
  } elsif($data[0]{'rank'} eq $data[1]{'rank'} and
          $data[3]{'rank'} eq $data[4]{'rank'} and
         ($data[0]{'rank'} eq $data[2]{'rank'} ||
          $data[3]{'rank'} eq $data[2]{'rank'})) {
    if($data[0]{'rank'} eq $data[2]{'rank'}) { # xxx yy
      $set0 = $rprv{$data[0]{'rank'}};
      $set1 = $rprv{$data[4]{'rank'}} - 1;
    } else {                                   # xx yyy
      $set0 = $rprv{$data[4]{'rank'}};
      $set1 = $rprv{$data[0]{'rank'}};
    }
    $scor = (166 + ($set0 * 12) + $set1);
#           Flush   322..1598  1277  (13 choose 5) - 9
  } elsif($flsh) {
    $xtr0 = $rprv{$data[0]{'rank'}};
    $xtr1 = $rprv{$data[1]{'rank'}};
    $xtr2 = $rprv{$data[2]{'rank'}};
    $xtr3 = $rprv{$data[3]{'rank'}};
    $xtr4 = $rprv{$data[4]{'rank'}} - $xtr3;
    $scor = 322;
    $scor-- if($xtr0);
    $scor++ if($xtr1 ==  9);
    $scor++ if($xtr2 == 10);
    while($xtr0-- > 0) { $scor += (choo((11 - $xtr0), 4) - 1); }
    while($xtr1-- > 1) { $scor +=  choo((11 - $xtr1), 3)     ; }
    while($xtr2-- > 2) { $scor +=  choo((11 - $xtr2), 2)     ; }
    while($xtr3-- > 3) { $scor +=       (12 - $xtr3)         ; }
                         $scor += (           $xtr4      - 2);
#  Straight        1599..1608    10  King High through 5 High
  } elsif($strt) {
    $scor = (1599 +  $rprv{$data[0]{'rank'}});
    $scor =  1608 if(      $data[0]{'rank'} eq 'A' and
                           $data[1]{'rank'} eq '5');
#  Three-of-a-Kind 1609..2466   858  (13 choose 3) * 3
  } elsif(($data[0]{'rank'} eq $data[1]{'rank'} and
           $data[0]{'rank'} eq $data[2]{'rank'}) || # xxx y z
          ($data[1]{'rank'} eq $data[2]{'rank'} and
           $data[2]{'rank'} eq $data[3]{'rank'}) || # x yyy z
          ($data[2]{'rank'} eq $data[3]{'rank'} and
           $data[3]{'rank'} eq $data[4]{'rank'})) { # x y zzz
    if     ($data[0]{'rank'} eq $data[2]{'rank'}) { # xxx y z
      $set0 = $rprv{$data[0]{'rank'}};
      $xtr0 = $rprv{$data[3]{'rank'}} - 1;
      $xtr1 = $rprv{$data[4]{'rank'}} - 2;
    } elsif($data[1]{'rank'} eq $data[3]{'rank'}) { # x yyy z
      $xtr0 = $rprv{$data[0]{'rank'}};
      $set0 = $rprv{$data[1]{'rank'}};
      $xtr1 = $rprv{$data[4]{'rank'}} - 2;
    } else {                                        # x y zzz
      $xtr0 = $rprv{$data[0]{'rank'}};
      $xtr1 = $rprv{$data[1]{'rank'}} - 1;
      $set0 = $rprv{$data[2]{'rank'}};
    }
    $scor = (1609 +
             (      $set0  * summ(  11 )) +
             ((12 * $xtr0) - summ($xtr0)) +
             (      $xtr1  -      $xtr0 ));
#  Two Pair        2467..3324   858  (13 choose 3) * 3
  } elsif(($data[0]{'rank'} eq $data[1]{'rank'} and
           $data[2]{'rank'} eq $data[3]{'rank'}) || # xx yy z
          ($data[0]{'rank'} eq $data[1]{'rank'} and
           $data[3]{'rank'} eq $data[4]{'rank'}) || # xx y zz
          ($data[1]{'rank'} eq $data[2]{'rank'} and
           $data[3]{'rank'} eq $data[4]{'rank'})) { # x yy zz
    if($data[0]{'rank'} eq $data[1]{'rank'}) {      # xx
      if($data[2]{'rank'} eq $data[3]{'rank'}) {    #    yy z
        $set0 = $rprv{$data[0]{'rank'}};
        $set1 = $rprv{$data[2]{'rank'}} - 1;
        $xtr0 = $rprv{$data[4]{'rank'}} - 2;
      } else {                                      #    y zz
        $set0 = $rprv{$data[0]{'rank'}};
        $xtr0 = $rprv{$data[2]{'rank'}} - 1;
        $set1 = $rprv{$data[3]{'rank'}} - 1;
      }
    } else {                                        # x yy zz
      $xtr0 = $rprv{$data[0]{'rank'}};
      $set0 = $rprv{$data[1]{'rank'}};
      $set1 = $rprv{$data[3]{'rank'}} - 1;
    }
    $scor = (2467 +
             (((13*$set0) - summ($set0)) * 11) +
             ((    $set1  -      $set0 ) * 11) +
                   $xtr0                      );
#  One Pair        3325..6184  2860  (13 choose 4) * 4
  } elsif($data[0]{'rank'} eq $data[1]{'rank'} ||   # ww x y z
          $data[1]{'rank'} eq $data[2]{'rank'} ||   # w xx y z
          $data[2]{'rank'} eq $data[3]{'rank'} ||   # w x yy z
          $data[3]{'rank'} eq $data[4]{'rank'}) {   # w x y zz
    if     ($data[0]{'rank'} eq $data[1]{'rank'}) { # ww
      $set0 = $rprv{$data[0]{'rank'}};
      $xtr0 = $rprv{$data[2]{'rank'}} - 1;
      $xtr1 = $rprv{$data[3]{'rank'}} - 1;
      $xtr2 = $rprv{$data[4]{'rank'}} - 1;
    } elsif($data[1]{'rank'} eq $data[2]{'rank'}) { #   xx
      $xtr0 = $rprv{$data[0]{'rank'}};
      $set0 = $rprv{$data[1]{'rank'}};
      $xtr1 = $rprv{$data[3]{'rank'}} - 1;
      $xtr2 = $rprv{$data[4]{'rank'}} - 1;
    } elsif($data[2]{'rank'} eq $data[3]{'rank'}) { #     yy
      $xtr0 = $rprv{$data[0]{'rank'}};
      $xtr1 = $rprv{$data[1]{'rank'}};
      $set0 = $rprv{$data[2]{'rank'}};
      $xtr2 = $rprv{$data[4]{'rank'}} - 1;
    } else {                                        #       zz
      $xtr0 = $rprv{$data[0]{'rank'}};
      $xtr1 = $rprv{$data[1]{'rank'}};
      $xtr2 = $rprv{$data[2]{'rank'}};
      $set0 = $rprv{$data[3]{'rank'}};
    }
    $scor  = 3325;
    $scor +=  ($set0 * choo(12, 3));
    $scor++ if($xtr0 == 9);
    $xtr2 -=  ($xtr1 +  1);
    while($xtr0-- > 0) { $scor +=  choo((10 - $xtr0), 2)     ; }
    while($xtr1-- > 1) { $scor += (     (12 - $xtr1)     - 1); }
                         $scor +=             $xtr2          ;
#  High Card       6185..7461  1277  (13 choose 5) - 9
  } else {
    $xtr0 = $rprv{$data[0]{'rank'}};
    $xtr1 = $rprv{$data[1]{'rank'}};
    $xtr2 = $rprv{$data[2]{'rank'}};
    $xtr3 = $rprv{$data[3]{'rank'}};
    $xtr4 = $rprv{$data[4]{'rank'}} - $xtr3;
    $scor = 6185;
    $scor-- if($xtr0);
    $scor++ if($xtr1 ==  9);
    $scor++ if($xtr2 == 10);
    while($xtr0-- > 0) { $scor += (choo((11 - $xtr0), 4) - 1); }
    while($xtr1-- > 1) { $scor +=  choo((11 - $xtr1), 3)     ; }
    while($xtr2-- > 2) { $scor +=  choo((11 - $xtr2), 2)     ; }
    while($xtr3-- > 3) { $scor +=       (12 - $xtr3)         ; }
                         $scor += (           $xtr4      - 2);
  }
  return($scor);
}
sub BestIndices { # takes 5+ cards (7) and returns indices of the best 5
  my @crdz = @_; return(0) unless(@crdz >= 5); my @best = (); my @bhnd = ();
  my $choo = Algorithm::ChooseSubsets->new(scalar(@crdz), 5);
  while(my $choi = $choo->next()) {
    my @hand = ();
    for(my $cndx = 0; $cndx < 5; $cndx++) {
      push(@hand, $crdz[ $choi->[ $cndx ] ]);
      if(@hand == 5 && (!@best || HandScore(@bhnd) > HandScore(@hand))) {
        @best = @{$choi}; @bhnd = ();
        push(@bhnd, $crdz[$_]) for(@best);
      }
    }
  }
  return(@best);
}
sub BestHand { # takes return value of BestIndices() and all cards
  my @best = (shift, shift, shift, shift, shift); # get best indices
  my @crdz = @_;
  if(@crdz <= 2) { # if only 7 params given, pass onto Indices first
    unshift(@crdz, @best);
    @best = BestIndices(@crdz);
  }
  return(0) unless(@best == 5 && @crdz >= 5); # ck for valid sizes
  my @hand = (); push(@hand, $crdz[$_]) for(@best); # copy best cards
  return(@hand);
}
sub ScoreHand { # returns the ShortHand representation of passed in score param
  return($hndz[(shift || 0)]);
}
sub HandScore { # returns the score of the passed in @hand or ShortHand
  my @hand = @_; return(7462) unless(@hand == 1 || @hand == 5); my $shrt;
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if(  $aflg      ) { $aref =    $hand[0];          }
  else              { $aref =   \@hand;             }
  if(@{$aref} == 1) { $shrt =  $aref->[0];          }
  else              { $shrt =    ShortHand($aref);  }
  return(       $zdnh{$shrt});
}
sub BJ { # returns the boolean value of whether the passed in @hand or ShortHand *is* a BlackJack
  my @hand = @_; return(-1) unless(@hand); my $shrt; my $scor;
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if(  $aflg      ) { $aref =    $hand[0];          }
  else              { $aref =   \@hand;             }
  SortCards($aref) unless(@{$aref} == 1); # make sure cards are sorted first
  if(@{$aref} == 1) { $shrt =  $aref->[0];          }
  else              { $shrt =    ShortHand($aref);  }
  $shrt =~ s/s$//; # BlackJack doesn't care about suitedness flags so strip any off
  return(1) if($shrt =~ /^A[KQJT]$/);
  return(0);
}
sub BJHandScore { # returns the score of the passed in @hand or ShortHand for BlackJack
  my @hand = @_; return(-1) unless(@hand); my $shrt; my $scor;
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if(  $aflg      ) { $aref =    $hand[0];          }
  else              { $aref =   \@hand;             }
  if(@{$aref} == 1) { $shrt =  $aref->[0];          }
  else              { $shrt =    ShortHand($aref);  }
  $shrt =~ s/s$//; # BlackJack doesn't care about suitedness flags so strip any off
  for(split(//, $shrt)) {
    if   (/^\d$/    ) { $scor += $_; }
    elsif(/^[KQJT]$/) { $scor += 10; }
    elsif(/^A$/     ) { $scor += 11; $scor -= 10 if($scor >  21); }
  }
  return($scor);
}
sub BJCmp { # Similar to <=> between the two BlackJack scores passed as parameters
  my $scr0 = shift() || 0; my $scr1 = shift() || 0;
  return(undef) unless($scr0 =~ /^\d+$/ && $scr1 =~ /^\d+$/);
  return(    0) if($scr0 == $scr1 || ($scr0 >  21 && $scr1 >    21)); # push
  return(    1) if($scr0 >     21 || ($scr1 <= 21 && $scr1 > $scr0)); # scr1 wins (right)
  return(   -1)#if($scr1 >     21 || ($scr0 <= 21 && $scr0 > $scr1)); # scr0 wins ( left)
}
sub CardName { # takes an abbreviated card (e.g., 'As') and returns full name
  my $card = shift() || return(0); my $name; my %data;
  if(length($card) == 1) { # just rank or suit was provided
    if($card =~ /^[shdc]$/i) { $data{'suit'} = $card; } # just suit so set card
    else                     { $data{'rank'} = $card; } # just rank so set card
  } else {
    ($data{'rank'}, $data{'suit'}) = split(//, $card);
  }
  if(exists($data{'rank'})) {
    $name .= $rnam[$rprv{$data{'rank'}}];
    $name .= ' of ' if(exists($data{'suit'}));
  }
  if(exists($data{'suit'})) {
    for(@snam) { $name .= $_ if(/^$data{'suit'}/i); }
  }
  return($name);
}
sub NameCard { # takes a full card name (e.g., 'Ace of Spades') and returns abbrev
  my $name = shift() || return(0); my $card;
  $name =~ s/\s+of\s+//gi; $name =~ s/\s+//g;
  for my $indx (0..$#rnam) {
    if($name =~ s/$rnam[$indx]//i) { $card = $rprg[$indx]; last; }
  }
  for(@snam) {
    if($name =~ s/$_//i) { $card .= lc(substr($_, 0, 1));  last; }
  }
  return($card);
}
sub CardB64 { # takes an abbreviated card (e.g., 'As') and returns b64 rep
  return(b64(CardDec(@_) + 10));
}
sub B64Card { # takes a b64 card and returns abbrev
  my $card = shift() || return(0); my @deck = Deck();
  return($deck[ b10($card) - 10 ]);
}
sub CardDec { # takes an abbreviated card (e.g., 'As') and returns decimal rep
  my $card = shift() || return(0); my @deck = Deck();
  if(length($card) == 1) { # only rank or suit was provided
    if($card =~ /^[shdc]$/i) { $card  = "A$card"; } # just suit so add Ace
    else                     { $card .= 's';      } # just rank so add Spade
  }
  for my $indx (0..$#deck) {
    return($indx) if($card eq $deck[$indx]);
  }
  return(52);
}
sub DecCard { # takes a decimal card and returns abbrev
  my $card = shift() || return('As'); my @deck = Deck(); return($deck[$card]);
}
sub HandName { # takes a \@handref, @hand, ShortHand, or score and returns name
  my @hand = @_; return(0) unless(@hand == 1 || @hand == 5); my $shrt; my $scor;
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $hand[0]; }
  else      { $aref = \@hand;    }
  if(@{$aref} == 1) { $shrt = $aref->[0];       }
  else              { $shrt = ShortHand($aref); }
  if(length($shrt) < 5 && $shrt =~ /^\d+$/) { $scor = $shrt; $shrt = ScoreHand($scor); }
  else                                      { $scor =                HandScore($shrt); }
  for(sort { $b <=> $a } keys(%namz)) { return($namz{$_}) if($scor >= $_); }
  return('!*EROR*! Hand Not Found!');
}
sub VerboseHandName { # takes same params as HandName() and returns verbose name description
  my $hnam = HandName(@_);
  my @hand = @_; return(0) unless(@hand == 1 || @hand == 5); my $shrt; my $scor; my @crdz; my $set0; my $set1; my $kick;
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $hand[0]; }
  else      { $aref = \@hand;    }
  if(@{$aref} == 1) { $shrt = $aref->[0];       }
  else              { $shrt = ShortHand($aref); }
  if(length($shrt) < 5 && $shrt =~ /^\d+$/) { $scor = $shrt; $shrt = ScoreHand($scor); }
  else                                      { $scor =                HandScore($shrt); }
  @crdz = split(//, $shrt);
  if     ($hnam =~ /^(High Card|Flush)$/) {
    $set0 = CardName($crdz[0]); $kick = CardName($crdz[1]);
    return("$set0 high, $kick kicker");
  } elsif($hnam eq 'One Pair') {
    for(1..4) {
      if($crdz[($_ - 1)] eq $crdz[$_]) {
        $set0 = CardName($crdz[$_]);
        if($_ == 1) { $kick = CardName($crdz[2]); }
        else        { $kick = CardName($crdz[0]); }
        last;
      }
    }
    return("$set0\'s, $kick kicker");
  } elsif($hnam eq 'Two Pair') {
    my $ndx0;
    for(1..4) {
      if($crdz[($_ - 1)] eq $crdz[$_]) {
        if(defined($set0)) {
          $set1 = CardName($crdz[$_]);
          if   ($_    == 3) { $kick = CardName($crdz[4]); }
          elsif($ndx0 == 1) { $kick = CardName($crdz[2]); }
          else              { $kick = CardName($crdz[0]); }
          last;
        } else {
          $set0 = CardName($crdz[$_]); $ndx0 = $_;
        }
      }
    }
    return("$set0\'s and $set1\'s, $kick kicker");
  } elsif($hnam eq 'Three-of-a-Kind') {
    for(1..3) {
      if($crdz[($_ - 1)] eq $crdz[$_] &&
         $crdz[($_ + 1)] eq $crdz[$_]) {
        $set0 = CardName($crdz[$_]);
        if($_ == 1) { $kick = CardName($crdz[3]); }
        else        { $kick = CardName($crdz[0]); }
        last;
      }
    }
    return("$set0\'s, $kick kicker");
  } elsif($hnam =~ /(^Straight|Flush$)/) {
    if($crdz[0] eq 'A' && $crdz[1] eq '5') {
      $set0 = CardName($crdz[1]);
      $set1 = CardName($crdz[0]);
    } else {
      $set0 = CardName($crdz[0]);
      $set1 = CardName($crdz[4]);
    }
    return("$set0 down to $set1");
  } elsif($hnam eq 'Full House') {
    if($crdz[1] eq $crdz[2]) {
      $set0 = CardName($crdz[2]);
      $set1 = CardName($crdz[3]);
    } else {
      $set0 = CardName($crdz[2]);
      $set1 = CardName($crdz[1]);
    }
    return("$set0\'s over $set1\'s");
  } elsif($hnam eq 'Four-of-a-Kind') {
    if($crdz[0] eq $crdz[1]) {
      $set0 = CardName($crdz[0]);
    } else {
      $set0 = CardName($crdz[1]);
    }
    return("$set0\'s");
  }
  return('!*EROR*! Hand Not Found!');
}
sub HandB64 { # takes a \@handref or @hand and returns b64 $hand
  my @hand = @_; return(0) unless(@hand >= 1); my $b64h = '';
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $hand[0]; }
  else      { $aref = \@hand;    }
  for(@{$aref}) { $b64h .= CardB64($_); }
  return($b64h);
}
sub B64Hand { # takes a b64 $hand and returns @hand of abbrev. cards e.g., 'As'
  my $b64h = shift() || return(0); my @hand;
  for(split(//, $b64h)) { push(@hand, B64Card($_)); }
  return(@hand);
}
sub HandDec { # takes a \@handref or @hand and returns dec $hand
  my @hand = @_; return(0) unless(@hand >= 1); my @dech = ();
  my $aflg = 0; $aflg = 1 if(ref($hand[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $hand[0]; }
  else      { $aref = \@hand;    }
  for(@{$aref}) { push(@dech, CardDec($_)); }
  return(@dech);
}
sub DecHand { # takes a decimal @dech and returns a @hand of abbrev. cards
  my @dech = @_; return(0) unless(@dech >= 1); my @hand = ();
  my $aflg = 0; $aflg = 1 if(ref($dech[0]) eq 'ARRAY'); my $aref;
  if($aflg) { $aref =  $dech[0]; }
  else      { $aref = \@dech;    }
  for(@{$aref}) { push(@hand, DecCard($_)); }
  return(@hand);
}
sub RemoveCard { # takes a card and an arrayref or list of items to remove from
  return(0) unless(@_); # must have at least one parameter
  my $card = shift();
     $card =  B64Card($card) if(length($card) == 1);
     $card = NameCard($card) if(       $card  =~ / of /);
  my $aflg = 0; $aflg = 1 if(ref($_[0]) eq 'ARRAY');
  my $size = 0; my $aref; my @data = @_;
  if($aflg) { $aref = $_[0];  }
  else      { $aref = \@data; }
  $size = @{$aref};
  for(my $indx = 0; $indx < $size; $indx++) {
    if($aref->[$indx] eq $card) { # found card...
      splice(@{$aref}, $indx, 1); #   so remove it
      last;
    }
  }
  if($aflg) { return($aref); }
  else      { return(@data); }
}
sub WorstHand { # takes some cards and returns worst possible ShortHand
  my @crdz = @_;
  return(ShortHand(BestHand(BestIndices(@crdz), @crdz))) if(@crdz >= 5);
  my $aflg = 0; $aflg = 1 if(ref($crdz[0]) eq 'ARRAY'); my $aref; my $cshr;
  if   ($aflg    ) { $aref = $crdz[0]; $cshr = ShortHand(@{$aref});  }
  elsif(@crdz > 1) { $aref = \@crdz;   $cshr = ShortHand(@{$aref});  }
  else             {                   $cshr =             $crdz[0]; }
  $cshr =~ s/s$//; # strip suited flag if there
  for(reverse(@hndz)) {
    return($_) if(/$cshr/);
  }
}
sub CountWays { # counts the number of ways to get a particular set of hands
  my $blim = shift(); $blim = 7461 unless(defined($blim) && $blim < 7462);
  my $glim = shift(); $glim =    0 unless(defined($glim) && $glim < 7462);
  my $scop = shift() || 'hndz';
  my $summ = 0;
  $summ += $_->[1] for(@{$pdat{$scop}}[$glim..$blim]);
  return($summ);
}
# NOTE: CalcOdds() doesn't work accurately yet... I'm just experimenting with
#   some calculations in hopes of determining a thorough way to find any odds
sub CalcOdds { # calculate the odds of winning with certain cards
  my $hole = shift(); $hole =    0 unless(defined($hole) and
                      $hole < $pdat{'coun'}{'shorthand_holes'});
  my $flop = shift(); $flop =   -1 unless(defined($flop) and
                      $flop < $pdat{'coun'}{'shorthand_flops'});
  my $turn = shift(); $turn =   -1 unless(defined($turn) and
                      $turn <   13);
  my $rivr = shift(); $rivr =   -1 unless(defined($rivr) and
                      $rivr <   13);
  my $blim = 7461; my $glim =    0; my $scop = 'hndz'; my $odds = 0;
  $blim = HandScore(WorstHand($holz[$hole]));
#$blim = 4;
#$blim = $zloh{'AA'}; # 84.93%
#$blim = $zloh{'22'}; # 49.39%
  my $ways = CountWays($blim);
#print "glim:$glim\nblim:$blim\nways:$ways\n";
  for my $step ($glim..$blim) {
    my $coun = CountWays($step);
    my $lprt = $pdat{$scop}[$step][1] / $ways;
    my $bprt = $pdat{$scop}[$step][1] / $pdat{'coun'}{'hands'};
    my $winp = ($pdat{'coun'}{'hands'} - $coun) / $pdat{'coun'}{'hands'};
    $odds += $lprt * $winp;
#printf(" step:%4d lprt:%2.9f bprt:%2.9f winp:%2.9f odds:%2.9f\n", $step, $lprt, $bprt, $winp, $odds);
  }
  $odds = abs(1 - (2 * (1 - $odds)));
  return($odds);
}
%pdat = ( # Global Poker Data
  'holz' => [ # possible ShortHand holes                  ['abbrev', ways]
    ['AA'    ,    6], ['AKs'   ,    4], ['AK'    ,   12], ['AQs'   ,    4],
    ['AQ'    ,   12], ['AJs'   ,    4], ['AJ'    ,   12], ['ATs'   ,    4],
    ['AT'    ,   12], ['A9s'   ,    4], ['A9'    ,   12], ['A8s'   ,    4],
    ['A8'    ,   12], ['A7s'   ,    4], ['A7'    ,   12], ['A6s'   ,    4],
    ['A6'    ,   12], ['A5s'   ,    4], ['A5'    ,   12], ['A4s'   ,    4],
    ['A4'    ,   12], ['A3s'   ,    4], ['A3'    ,   12], ['A2s'   ,    4],
    ['A2'    ,   12], ['KK'    ,    6], ['KQs'   ,    4], ['KQ'    ,   12],
    ['KJs'   ,    4], ['KJ'    ,   12], ['KTs'   ,    4], ['KT'    ,   12],
    ['K9s'   ,    4], ['K9'    ,   12], ['K8s'   ,    4], ['K8'    ,   12],
    ['K7s'   ,    4], ['K7'    ,   12], ['K6s'   ,    4], ['K6'    ,   12],
    ['K5s'   ,    4], ['K5'    ,   12], ['K4s'   ,    4], ['K4'    ,   12],
    ['K3s'   ,    4], ['K3'    ,   12], ['K2s'   ,    4], ['K2'    ,   12],
    ['QQ'    ,    6], ['QJs'   ,    4], ['QJ'    ,   12], ['QTs'   ,    4],
    ['QT'    ,   12], ['Q9s'   ,    4], ['Q9'    ,   12], ['Q8s'   ,    4],
    ['Q8'    ,   12], ['Q7s'   ,    4], ['Q7'    ,   12], ['Q6s'   ,    4],
    ['Q6'    ,   12], ['Q5s'   ,    4], ['Q5'    ,   12], ['Q4s'   ,    4],
    ['Q4'    ,   12], ['Q3s'   ,    4], ['Q3'    ,   12], ['Q2s'   ,    4],
    ['Q2'    ,   12], ['JJ'    ,    6], ['JTs'   ,    4], ['JT'    ,   12],
    ['J9s'   ,    4], ['J9'    ,   12], ['J8s'   ,    4], ['J8'    ,   12],
    ['J7s'   ,    4], ['J7'    ,   12], ['J6s'   ,    4], ['J6'    ,   12],
    ['J5s'   ,    4], ['J5'    ,   12], ['J4s'   ,    4], ['J4'    ,   12],
    ['J3s'   ,    4], ['J3'    ,   12], ['J2s'   ,    4], ['J2'    ,   12],
    ['TT'    ,    6], ['T9s'   ,    4], ['T9'    ,   12], ['T8s'   ,    4],
    ['T8'    ,   12], ['T7s'   ,    4], ['T7'    ,   12], ['T6s'   ,    4],
    ['T6'    ,   12], ['T5s'   ,    4], ['T5'    ,   12], ['T4s'   ,    4],
    ['T4'    ,   12], ['T3s'   ,    4], ['T3'    ,   12], ['T2s'   ,    4],
    ['T2'    ,   12], ['99'    ,    6], ['98s'   ,    4], ['98'    ,   12],
    ['97s'   ,    4], ['97'    ,   12], ['96s'   ,    4], ['96'    ,   12],
    ['95s'   ,    4], ['95'    ,   12], ['94s'   ,    4], ['94'    ,   12],
    ['93s'   ,    4], ['93'    ,   12], ['92s'   ,    4], ['92'    ,   12],
    ['88'    ,    6], ['87s'   ,    4], ['87'    ,   12], ['86s'   ,    4],
    ['86'    ,   12], ['85s'   ,    4], ['85'    ,   12], ['84s'   ,    4],
    ['84'    ,   12], ['83s'   ,    4], ['83'    ,   12], ['82s'   ,    4],
    ['82'    ,   12], ['77'    ,    6], ['76s'   ,    4], ['76'    ,   12],
    ['75s'   ,    4], ['75'    ,   12], ['74s'   ,    4], ['74'    ,   12],
    ['73s'   ,    4], ['73'    ,   12], ['72s'   ,    4], ['72'    ,   12],
    ['66'    ,    6], ['65s'   ,    4], ['65'    ,   12], ['64s'   ,    4],
    ['64'    ,   12], ['63s'   ,    4], ['63'    ,   12], ['62s'   ,    4],
    ['62'    ,   12], ['55'    ,    6], ['54s'   ,    4], ['54'    ,   12],
    ['53s'   ,    4], ['53'    ,   12], ['52s'   ,    4], ['52'    ,   12],
    ['44'    ,    6], ['43s'   ,    4], ['43'    ,   12], ['42s'   ,    4],
    ['42'    ,   12], ['33'    ,    6], ['32s'   ,    4], ['32'    ,   12],
    ['22'    ,    6],
  ],
  'flpz' => [ # possible ShortHand flops
    ['AAA'   ,    4], ['AAK'   ,   24], ['AAQ'   ,   24], ['AAJ'   ,   24],
    ['AAT'   ,   24], ['AA9'   ,   24], ['AA8'   ,   24], ['AA7'   ,   24],
    ['AA6'   ,   24], ['AA5'   ,   24], ['AA4'   ,   24], ['AA3'   ,   24],
    ['AA2'   ,   24], ['AKK'   ,   24], ['AKQs'  ,    4], ['AKQ'   ,   60],
    ['AKJs'  ,    4], ['AKJ'   ,   60], ['AKTs'  ,    4], ['AKT'   ,   60],
    ['AK9s'  ,    4], ['AK9'   ,   60], ['AK8s'  ,    4], ['AK8'   ,   60],
    ['AK7s'  ,    4], ['AK7'   ,   60], ['AK6s'  ,    4], ['AK6'   ,   60],
    ['AK5s'  ,    4], ['AK5'   ,   60], ['AK4s'  ,    4], ['AK4'   ,   60],
    ['AK3s'  ,    4], ['AK3'   ,   60], ['AK2s'  ,    4], ['AK2'   ,   60],
    ['AQQ'   ,   24], ['AQJs'  ,    4], ['AQJ'   ,   60], ['AQTs'  ,    4],
    ['AQT'   ,   60], ['AQ9s'  ,    4], ['AQ9'   ,   60], ['AQ8s'  ,    4],
    ['AQ8'   ,   60], ['AQ7s'  ,    4], ['AQ7'   ,   60], ['AQ6s'  ,    4],
    ['AQ6'   ,   60], ['AQ5s'  ,    4], ['AQ5'   ,   60], ['AQ4s'  ,    4],
    ['AQ4'   ,   60], ['AQ3s'  ,    4], ['AQ3'   ,   60], ['AQ2s'  ,    4],
    ['AQ2'   ,   60], ['AJJ'   ,   24], ['AJTs'  ,    4], ['AJT'   ,   60],
    ['AJ9s'  ,    4], ['AJ9'   ,   60], ['AJ8s'  ,    4], ['AJ8'   ,   60],
    ['AJ7s'  ,    4], ['AJ7'   ,   60], ['AJ6s'  ,    4], ['AJ6'   ,   60],
    ['AJ5s'  ,    4], ['AJ5'   ,   60], ['AJ4s'  ,    4], ['AJ4'   ,   60],
    ['AJ3s'  ,    4], ['AJ3'   ,   60], ['AJ2s'  ,    4], ['AJ2'   ,   60],
    ['ATT'   ,   24], ['AT9s'  ,    4], ['AT9'   ,   60], ['AT8s'  ,    4],
    ['AT8'   ,   60], ['AT7s'  ,    4], ['AT7'   ,   60], ['AT6s'  ,    4],
    ['AT6'   ,   60], ['AT5s'  ,    4], ['AT5'   ,   60], ['AT4s'  ,    4],
    ['AT4'   ,   60], ['AT3s'  ,    4], ['AT3'   ,   60], ['AT2s'  ,    4],
    ['AT2'   ,   60], ['A99'   ,   24], ['A98s'  ,    4], ['A98'   ,   60],
    ['A97s'  ,    4], ['A97'   ,   60], ['A96s'  ,    4], ['A96'   ,   60],
    ['A95s'  ,    4], ['A95'   ,   60], ['A94s'  ,    4], ['A94'   ,   60],
    ['A93s'  ,    4], ['A93'   ,   60], ['A92s'  ,    4], ['A92'   ,   60],
    ['A88'   ,   24], ['A87s'  ,    4], ['A87'   ,   60], ['A86s'  ,    4],
    ['A86'   ,   60], ['A85s'  ,    4], ['A85'   ,   60], ['A84s'  ,    4],
    ['A84'   ,   60], ['A83s'  ,    4], ['A83'   ,   60], ['A82s'  ,    4],
    ['A82'   ,   60], ['A77'   ,   24], ['A76s'  ,    4], ['A76'   ,   60],
    ['A75s'  ,    4], ['A75'   ,   60], ['A74s'  ,    4], ['A74'   ,   60],
    ['A73s'  ,    4], ['A73'   ,   60], ['A72s'  ,    4], ['A72'   ,   60],
    ['A66'   ,   24], ['A65s'  ,    4], ['A65'   ,   60], ['A64s'  ,    4],
    ['A64'   ,   60], ['A63s'  ,    4], ['A63'   ,   60], ['A62s'  ,    4],
    ['A62'   ,   60], ['A55'   ,   24], ['A54s'  ,    4], ['A54'   ,   60],
    ['A53s'  ,    4], ['A53'   ,   60], ['A52s'  ,    4], ['A52'   ,   60],
    ['A44'   ,   24], ['A43s'  ,    4], ['A43'   ,   60], ['A42s'  ,    4],
    ['A42'   ,   60], ['A33'   ,   24], ['A32s'  ,    4], ['A32'   ,   60],
    ['A22'   ,   24], ['KKK'   ,    4], ['KKQ'   ,   24], ['KKJ'   ,   24],
    ['KKT'   ,   24], ['KK9'   ,   24], ['KK8'   ,   24], ['KK7'   ,   24],
    ['KK6'   ,   24], ['KK5'   ,   24], ['KK4'   ,   24], ['KK3'   ,   24],
    ['KK2'   ,   24], ['KQQ'   ,   24], ['KQJs'  ,    4], ['KQJ'   ,   60],
    ['KQTs'  ,    4], ['KQT'   ,   60], ['KQ9s'  ,    4], ['KQ9'   ,   60],
    ['KQ8s'  ,    4], ['KQ8'   ,   60], ['KQ7s'  ,    4], ['KQ7'   ,   60],
    ['KQ6s'  ,    4], ['KQ6'   ,   60], ['KQ5s'  ,    4], ['KQ5'   ,   60],
    ['KQ4s'  ,    4], ['KQ4'   ,   60], ['KQ3s'  ,    4], ['KQ3'   ,   60],
    ['KQ2s'  ,    4], ['KQ2'   ,   60], ['KJJ'   ,   24], ['KJTs'  ,    4],
    ['KJT'   ,   60], ['KJ9s'  ,    4], ['KJ9'   ,   60], ['KJ8s'  ,    4],
    ['KJ8'   ,   60], ['KJ7s'  ,    4], ['KJ7'   ,   60], ['KJ6s'  ,    4],
    ['KJ6'   ,   60], ['KJ5s'  ,    4], ['KJ5'   ,   60], ['KJ4s'  ,    4],
    ['KJ4'   ,   60], ['KJ3s'  ,    4], ['KJ3'   ,   60], ['KJ2s'  ,    4],
    ['KJ2'   ,   60], ['KTT'   ,   24], ['KT9s'  ,    4], ['KT9'   ,   60],
    ['KT8s'  ,    4], ['KT8'   ,   60], ['KT7s'  ,    4], ['KT7'   ,   60],
    ['KT6s'  ,    4], ['KT6'   ,   60], ['KT5s'  ,    4], ['KT5'   ,   60],
    ['KT4s'  ,    4], ['KT4'   ,   60], ['KT3s'  ,    4], ['KT3'   ,   60],
    ['KT2s'  ,    4], ['KT2'   ,   60], ['K99'   ,   24], ['K98s'  ,    4],
    ['K98'   ,   60], ['K97s'  ,    4], ['K97'   ,   60], ['K96s'  ,    4],
    ['K96'   ,   60], ['K95s'  ,    4], ['K95'   ,   60], ['K94s'  ,    4],
    ['K94'   ,   60], ['K93s'  ,    4], ['K93'   ,   60], ['K92s'  ,    4],
    ['K92'   ,   60], ['K88'   ,   24], ['K87s'  ,    4], ['K87'   ,   60],
    ['K86s'  ,    4], ['K86'   ,   60], ['K85s'  ,    4], ['K85'   ,   60],
    ['K84s'  ,    4], ['K84'   ,   60], ['K83s'  ,    4], ['K83'   ,   60],
    ['K82s'  ,    4], ['K82'   ,   60], ['K77'   ,   24], ['K76s'  ,    4],
    ['K76'   ,   60], ['K75s'  ,    4], ['K75'   ,   60], ['K74s'  ,    4],
    ['K74'   ,   60], ['K73s'  ,    4], ['K73'   ,   60], ['K72s'  ,    4],
    ['K72'   ,   60], ['K66'   ,   24], ['K65s'  ,    4], ['K65'   ,   60],
    ['K64s'  ,    4], ['K64'   ,   60], ['K63s'  ,    4], ['K63'   ,   60],
    ['K62s'  ,    4], ['K62'   ,   60], ['K55'   ,   24], ['K54s'  ,    4],
    ['K54'   ,   60], ['K53s'  ,    4], ['K53'   ,   60], ['K52s'  ,    4],
    ['K52'   ,   60], ['K44'   ,   24], ['K43s'  ,    4], ['K43'   ,   60],
    ['K42s'  ,    4], ['K42'   ,   60], ['K33'   ,   24], ['K32s'  ,    4],
    ['K32'   ,   60], ['K22'   ,   24], ['QQQ'   ,    4], ['QQJ'   ,   24],
    ['QQT'   ,   24], ['QQ9'   ,   24], ['QQ8'   ,   24], ['QQ7'   ,   24],
    ['QQ6'   ,   24], ['QQ5'   ,   24], ['QQ4'   ,   24], ['QQ3'   ,   24],
    ['QQ2'   ,   24], ['QJJ'   ,   24], ['QJTs'  ,    4], ['QJT'   ,   60],
    ['QJ9s'  ,    4], ['QJ9'   ,   60], ['QJ8s'  ,    4], ['QJ8'   ,   60],
    ['QJ7s'  ,    4], ['QJ7'   ,   60], ['QJ6s'  ,    4], ['QJ6'   ,   60],
    ['QJ5s'  ,    4], ['QJ5'   ,   60], ['QJ4s'  ,    4], ['QJ4'   ,   60],
    ['QJ3s'  ,    4], ['QJ3'   ,   60], ['QJ2s'  ,    4], ['QJ2'   ,   60],
    ['QTT'   ,   24], ['QT9s'  ,    4], ['QT9'   ,   60], ['QT8s'  ,    4],
    ['QT8'   ,   60], ['QT7s'  ,    4], ['QT7'   ,   60], ['QT6s'  ,    4],
    ['QT6'   ,   60], ['QT5s'  ,    4], ['QT5'   ,   60], ['QT4s'  ,    4],
    ['QT4'   ,   60], ['QT3s'  ,    4], ['QT3'   ,   60], ['QT2s'  ,    4],
    ['QT2'   ,   60], ['Q99'   ,   24], ['Q98s'  ,    4], ['Q98'   ,   60],
    ['Q97s'  ,    4], ['Q97'   ,   60], ['Q96s'  ,    4], ['Q96'   ,   60],
    ['Q95s'  ,    4], ['Q95'   ,   60], ['Q94s'  ,    4], ['Q94'   ,   60],
    ['Q93s'  ,    4], ['Q93'   ,   60], ['Q92s'  ,    4], ['Q92'   ,   60],
    ['Q88'   ,   24], ['Q87s'  ,    4], ['Q87'   ,   60], ['Q86s'  ,    4],
    ['Q86'   ,   60], ['Q85s'  ,    4], ['Q85'   ,   60], ['Q84s'  ,    4],
    ['Q84'   ,   60], ['Q83s'  ,    4], ['Q83'   ,   60], ['Q82s'  ,    4],
    ['Q82'   ,   60], ['Q77'   ,   24], ['Q76s'  ,    4], ['Q76'   ,   60],
    ['Q75s'  ,    4], ['Q75'   ,   60], ['Q74s'  ,    4], ['Q74'   ,   60],
    ['Q73s'  ,    4], ['Q73'   ,   60], ['Q72s'  ,    4], ['Q72'   ,   60],
    ['Q66'   ,   24], ['Q65s'  ,    4], ['Q65'   ,   60], ['Q64s'  ,    4],
    ['Q64'   ,   60], ['Q63s'  ,    4], ['Q63'   ,   60], ['Q62s'  ,    4],
    ['Q62'   ,   60], ['Q55'   ,   24], ['Q54s'  ,    4], ['Q54'   ,   60],
    ['Q53s'  ,    4], ['Q53'   ,   60], ['Q52s'  ,    4], ['Q52'   ,   60],
    ['Q44'   ,   24], ['Q43s'  ,    4], ['Q43'   ,   60], ['Q42s'  ,    4],
    ['Q42'   ,   60], ['Q33'   ,   24], ['Q32s'  ,    4], ['Q32'   ,   60],
    ['Q22'   ,   24], ['JJJ'   ,    4], ['JJT'   ,   24], ['JJ9'   ,   24],
    ['JJ8'   ,   24], ['JJ7'   ,   24], ['JJ6'   ,   24], ['JJ5'   ,   24],
    ['JJ4'   ,   24], ['JJ3'   ,   24], ['JJ2'   ,   24], ['JTT'   ,   24],
    ['JT9s'  ,    4], ['JT9'   ,   60], ['JT8s'  ,    4], ['JT8'   ,   60],
    ['JT7s'  ,    4], ['JT7'   ,   60], ['JT6s'  ,    4], ['JT6'   ,   60],
    ['JT5s'  ,    4], ['JT5'   ,   60], ['JT4s'  ,    4], ['JT4'   ,   60],
    ['JT3s'  ,    4], ['JT3'   ,   60], ['JT2s'  ,    4], ['JT2'   ,   60],
    ['J99'   ,   24], ['J98s'  ,    4], ['J98'   ,   60], ['J97s'  ,    4],
    ['J97'   ,   60], ['J96s'  ,    4], ['J96'   ,   60], ['J95s'  ,    4],
    ['J95'   ,   60], ['J94s'  ,    4], ['J94'   ,   60], ['J93s'  ,    4],
    ['J93'   ,   60], ['J92s'  ,    4], ['J92'   ,   60], ['J88'   ,   24],
    ['J87s'  ,    4], ['J87'   ,   60], ['J86s'  ,    4], ['J86'   ,   60],
    ['J85s'  ,    4], ['J85'   ,   60], ['J84s'  ,    4], ['J84'   ,   60],
    ['J83s'  ,    4], ['J83'   ,   60], ['J82s'  ,    4], ['J82'   ,   60],
    ['J77'   ,   24], ['J76s'  ,    4], ['J76'   ,   60], ['J75s'  ,    4],
    ['J75'   ,   60], ['J74s'  ,    4], ['J74'   ,   60], ['J73s'  ,    4],
    ['J73'   ,   60], ['J72s'  ,    4], ['J72'   ,   60], ['J66'   ,   24],
    ['J65s'  ,    4], ['J65'   ,   60], ['J64s'  ,    4], ['J64'   ,   60],
    ['J63s'  ,    4], ['J63'   ,   60], ['J62s'  ,    4], ['J62'   ,   60],
    ['J55'   ,   24], ['J54s'  ,    4], ['J54'   ,   60], ['J53s'  ,    4],
    ['J53'   ,   60], ['J52s'  ,    4], ['J52'   ,   60], ['J44'   ,   24],
    ['J43s'  ,    4], ['J43'   ,   60], ['J42s'  ,    4], ['J42'   ,   60],
    ['J33'   ,   24], ['J32s'  ,    4], ['J32'   ,   60], ['J22'   ,   24],
    ['TTT'   ,    4], ['TT9'   ,   24], ['TT8'   ,   24], ['TT7'   ,   24],
    ['TT6'   ,   24], ['TT5'   ,   24], ['TT4'   ,   24], ['TT3'   ,   24],
    ['TT2'   ,   24], ['T99'   ,   24], ['T98s'  ,    4], ['T98'   ,   60],
    ['T97s'  ,    4], ['T97'   ,   60], ['T96s'  ,    4], ['T96'   ,   60],
    ['T95s'  ,    4], ['T95'   ,   60], ['T94s'  ,    4], ['T94'   ,   60],
    ['T93s'  ,    4], ['T93'   ,   60], ['T92s'  ,    4], ['T92'   ,   60],
    ['T88'   ,   24], ['T87s'  ,    4], ['T87'   ,   60], ['T86s'  ,    4],
    ['T86'   ,   60], ['T85s'  ,    4], ['T85'   ,   60], ['T84s'  ,    4],
    ['T84'   ,   60], ['T83s'  ,    4], ['T83'   ,   60], ['T82s'  ,    4],
    ['T82'   ,   60], ['T77'   ,   24], ['T76s'  ,    4], ['T76'   ,   60],
    ['T75s'  ,    4], ['T75'   ,   60], ['T74s'  ,    4], ['T74'   ,   60],
    ['T73s'  ,    4], ['T73'   ,   60], ['T72s'  ,    4], ['T72'   ,   60],
    ['T66'   ,   24], ['T65s'  ,    4], ['T65'   ,   60], ['T64s'  ,    4],
    ['T64'   ,   60], ['T63s'  ,    4], ['T63'   ,   60], ['T62s'  ,    4],
    ['T62'   ,   60], ['T55'   ,   24], ['T54s'  ,    4], ['T54'   ,   60],
    ['T53s'  ,    4], ['T53'   ,   60], ['T52s'  ,    4], ['T52'   ,   60],
    ['T44'   ,   24], ['T43s'  ,    4], ['T43'   ,   60], ['T42s'  ,    4],
    ['T42'   ,   60], ['T33'   ,   24], ['T32s'  ,    4], ['T32'   ,   60],
    ['T22'   ,   24], ['999'   ,    4], ['998'   ,   24], ['997'   ,   24],
    ['996'   ,   24], ['995'   ,   24], ['994'   ,   24], ['993'   ,   24],
    ['992'   ,   24], ['988'   ,   24], ['987s'  ,    4], ['987'   ,   60],
    ['986s'  ,    4], ['986'   ,   60], ['985s'  ,    4], ['985'   ,   60],
    ['984s'  ,    4], ['984'   ,   60], ['983s'  ,    4], ['983'   ,   60],
    ['982s'  ,    4], ['982'   ,   60], ['977'   ,   24], ['976s'  ,    4],
    ['976'   ,   60], ['975s'  ,    4], ['975'   ,   60], ['974s'  ,    4],
    ['974'   ,   60], ['973s'  ,    4], ['973'   ,   60], ['972s'  ,    4],
    ['972'   ,   60], ['966'   ,   24], ['965s'  ,    4], ['965'   ,   60],
    ['964s'  ,    4], ['964'   ,   60], ['963s'  ,    4], ['963'   ,   60],
    ['962s'  ,    4], ['962'   ,   60], ['955'   ,   24], ['954s'  ,    4],
    ['954'   ,   60], ['953s'  ,    4], ['953'   ,   60], ['952s'  ,    4],
    ['952'   ,   60], ['944'   ,   24], ['943s'  ,    4], ['943'   ,   60],
    ['942s'  ,    4], ['942'   ,   60], ['933'   ,   24], ['932s'  ,    4],
    ['932'   ,   60], ['922'   ,   24], ['888'   ,    4], ['887'   ,   24],
    ['886'   ,   24], ['885'   ,   24], ['884'   ,   24], ['883'   ,   24],
    ['882'   ,   24], ['877'   ,   24], ['876s'  ,    4], ['876'   ,   60],
    ['875s'  ,    4], ['875'   ,   60], ['874s'  ,    4], ['874'   ,   60],
    ['873s'  ,    4], ['873'   ,   60], ['872s'  ,    4], ['872'   ,   60],
    ['866'   ,   24], ['865s'  ,    4], ['865'   ,   60], ['864s'  ,    4],
    ['864'   ,   60], ['863s'  ,    4], ['863'   ,   60], ['862s'  ,    4],
    ['862'   ,   60], ['855'   ,   24], ['854s'  ,    4], ['854'   ,   60],
    ['853s'  ,    4], ['853'   ,   60], ['852s'  ,    4], ['852'   ,   60],
    ['844'   ,   24], ['843s'  ,    4], ['843'   ,   60], ['842s'  ,    4],
    ['842'   ,   60], ['833'   ,   24], ['832s'  ,    4], ['832'   ,   60],
    ['822'   ,   24], ['777'   ,    4], ['776'   ,   24], ['775'   ,   24],
    ['774'   ,   24], ['773'   ,   24], ['772'   ,   24], ['766'   ,   24],
    ['765s'  ,    4], ['765'   ,   60], ['764s'  ,    4], ['764'   ,   60],
    ['763s'  ,    4], ['763'   ,   60], ['762s'  ,    4], ['762'   ,   60],
    ['755'   ,   24], ['754s'  ,    4], ['754'   ,   60], ['753s'  ,    4],
    ['753'   ,   60], ['752s'  ,    4], ['752'   ,   60], ['744'   ,   24],
    ['743s'  ,    4], ['743'   ,   60], ['742s'  ,    4], ['742'   ,   60],
    ['733'   ,   24], ['732s'  ,    4], ['732'   ,   60], ['722'   ,   24],
    ['666'   ,    4], ['665'   ,   24], ['664'   ,   24], ['663'   ,   24],
    ['662'   ,   24], ['655'   ,   24], ['654s'  ,    4], ['654'   ,   60],
    ['653s'  ,    4], ['653'   ,   60], ['652s'  ,    4], ['652'   ,   60],
    ['644'   ,   24], ['643s'  ,    4], ['643'   ,   60], ['642s'  ,    4],
    ['642'   ,   60], ['633'   ,   24], ['632s'  ,    4], ['632'   ,   60],
    ['622'   ,   24], ['555'   ,    4], ['554'   ,   24], ['553'   ,   24],
    ['552'   ,   24], ['544'   ,   24], ['543s'  ,    4], ['543'   ,   60],
    ['542s'  ,    4], ['542'   ,   60], ['533'   ,   24], ['532s'  ,    4],
    ['532'   ,   60], ['522'   ,   24], ['444'   ,    4], ['443'   ,   24],
    ['442'   ,   24], ['433'   ,   24], ['432s'  ,    4], ['432'   ,   60],
    ['422'   ,   24], ['333'   ,    4], ['332'   ,   24], ['322'   ,   24],
    ['222'   ,    4],
  ],
  'hndz' => [ # possible ShortHands (originally generated by OrigHandScore)
    ['AKQJTs',    4], ['KQJT9s',    4], ['QJT98s',    4], ['JT987s',    4],
    ['T9876s',    4], ['98765s',    4], ['87654s',    4], ['76543s',    4],
    ['65432s',    4], ['A5432s',    4], ['AAAAK' ,    4], ['AAAAQ' ,    4],
    ['AAAAJ' ,    4], ['AAAAT' ,    4], ['AAAA9' ,    4], ['AAAA8' ,    4],
    ['AAAA7' ,    4], ['AAAA6' ,    4], ['AAAA5' ,    4], ['AAAA4' ,    4],
    ['AAAA3' ,    4], ['AAAA2' ,    4], ['AKKKK' ,    4], ['KKKKQ' ,    4],
    ['KKKKJ' ,    4], ['KKKKT' ,    4], ['KKKK9' ,    4], ['KKKK8' ,    4],
    ['KKKK7' ,    4], ['KKKK6' ,    4], ['KKKK5' ,    4], ['KKKK4' ,    4],
    ['KKKK3' ,    4], ['KKKK2' ,    4], ['AQQQQ' ,    4], ['KQQQQ' ,    4],
    ['QQQQJ' ,    4], ['QQQQT' ,    4], ['QQQQ9' ,    4], ['QQQQ8' ,    4],
    ['QQQQ7' ,    4], ['QQQQ6' ,    4], ['QQQQ5' ,    4], ['QQQQ4' ,    4],
    ['QQQQ3' ,    4], ['QQQQ2' ,    4], ['AJJJJ' ,    4], ['KJJJJ' ,    4],
    ['QJJJJ' ,    4], ['JJJJT' ,    4], ['JJJJ9' ,    4], ['JJJJ8' ,    4],
    ['JJJJ7' ,    4], ['JJJJ6' ,    4], ['JJJJ5' ,    4], ['JJJJ4' ,    4],
    ['JJJJ3' ,    4], ['JJJJ2' ,    4], ['ATTTT' ,    4], ['KTTTT' ,    4],
    ['QTTTT' ,    4], ['JTTTT' ,    4], ['TTTT9' ,    4], ['TTTT8' ,    4],
    ['TTTT7' ,    4], ['TTTT6' ,    4], ['TTTT5' ,    4], ['TTTT4' ,    4],
    ['TTTT3' ,    4], ['TTTT2' ,    4], ['A9999' ,    4], ['K9999' ,    4],
    ['Q9999' ,    4], ['J9999' ,    4], ['T9999' ,    4], ['99998' ,    4],
    ['99997' ,    4], ['99996' ,    4], ['99995' ,    4], ['99994' ,    4],
    ['99993' ,    4], ['99992' ,    4], ['A8888' ,    4], ['K8888' ,    4],
    ['Q8888' ,    4], ['J8888' ,    4], ['T8888' ,    4], ['98888' ,    4],
    ['88887' ,    4], ['88886' ,    4], ['88885' ,    4], ['88884' ,    4],
    ['88883' ,    4], ['88882' ,    4], ['A7777' ,    4], ['K7777' ,    4],
    ['Q7777' ,    4], ['J7777' ,    4], ['T7777' ,    4], ['97777' ,    4],
    ['87777' ,    4], ['77776' ,    4], ['77775' ,    4], ['77774' ,    4],
    ['77773' ,    4], ['77772' ,    4], ['A6666' ,    4], ['K6666' ,    4],
    ['Q6666' ,    4], ['J6666' ,    4], ['T6666' ,    4], ['96666' ,    4],
    ['86666' ,    4], ['76666' ,    4], ['66665' ,    4], ['66664' ,    4],
    ['66663' ,    4], ['66662' ,    4], ['A5555' ,    4], ['K5555' ,    4],
    ['Q5555' ,    4], ['J5555' ,    4], ['T5555' ,    4], ['95555' ,    4],
    ['85555' ,    4], ['75555' ,    4], ['65555' ,    4], ['55554' ,    4],
    ['55553' ,    4], ['55552' ,    4], ['A4444' ,    4], ['K4444' ,    4],
    ['Q4444' ,    4], ['J4444' ,    4], ['T4444' ,    4], ['94444' ,    4],
    ['84444' ,    4], ['74444' ,    4], ['64444' ,    4], ['54444' ,    4],
    ['44443' ,    4], ['44442' ,    4], ['A3333' ,    4], ['K3333' ,    4],
    ['Q3333' ,    4], ['J3333' ,    4], ['T3333' ,    4], ['93333' ,    4],
    ['83333' ,    4], ['73333' ,    4], ['63333' ,    4], ['53333' ,    4],
    ['43333' ,    4], ['33332' ,    4], ['A2222' ,    4], ['K2222' ,    4],
    ['Q2222' ,    4], ['J2222' ,    4], ['T2222' ,    4], ['92222' ,    4],
    ['82222' ,    4], ['72222' ,    4], ['62222' ,    4], ['52222' ,    4],
    ['42222' ,    4], ['32222' ,    4], ['AAAKK' ,   24], ['AAAQQ' ,   24],
    ['AAAJJ' ,   24], ['AAATT' ,   24], ['AAA99' ,   24], ['AAA88' ,   24],
    ['AAA77' ,   24], ['AAA66' ,   24], ['AAA55' ,   24], ['AAA44' ,   24],
    ['AAA33' ,   24], ['AAA22' ,   24], ['AAKKK' ,   24], ['KKKQQ' ,   24],
    ['KKKJJ' ,   24], ['KKKTT' ,   24], ['KKK99' ,   24], ['KKK88' ,   24],
    ['KKK77' ,   24], ['KKK66' ,   24], ['KKK55' ,   24], ['KKK44' ,   24],
    ['KKK33' ,   24], ['KKK22' ,   24], ['AAQQQ' ,   24], ['KKQQQ' ,   24],
    ['QQQJJ' ,   24], ['QQQTT' ,   24], ['QQQ99' ,   24], ['QQQ88' ,   24],
    ['QQQ77' ,   24], ['QQQ66' ,   24], ['QQQ55' ,   24], ['QQQ44' ,   24],
    ['QQQ33' ,   24], ['QQQ22' ,   24], ['AAJJJ' ,   24], ['KKJJJ' ,   24],
    ['QQJJJ' ,   24], ['JJJTT' ,   24], ['JJJ99' ,   24], ['JJJ88' ,   24],
    ['JJJ77' ,   24], ['JJJ66' ,   24], ['JJJ55' ,   24], ['JJJ44' ,   24],
    ['JJJ33' ,   24], ['JJJ22' ,   24], ['AATTT' ,   24], ['KKTTT' ,   24],
    ['QQTTT' ,   24], ['JJTTT' ,   24], ['TTT99' ,   24], ['TTT88' ,   24],
    ['TTT77' ,   24], ['TTT66' ,   24], ['TTT55' ,   24], ['TTT44' ,   24],
    ['TTT33' ,   24], ['TTT22' ,   24], ['AA999' ,   24], ['KK999' ,   24],
    ['QQ999' ,   24], ['JJ999' ,   24], ['TT999' ,   24], ['99988' ,   24],
    ['99977' ,   24], ['99966' ,   24], ['99955' ,   24], ['99944' ,   24],
    ['99933' ,   24], ['99922' ,   24], ['AA888' ,   24], ['KK888' ,   24],
    ['QQ888' ,   24], ['JJ888' ,   24], ['TT888' ,   24], ['99888' ,   24],
    ['88877' ,   24], ['88866' ,   24], ['88855' ,   24], ['88844' ,   24],
    ['88833' ,   24], ['88822' ,   24], ['AA777' ,   24], ['KK777' ,   24],
    ['QQ777' ,   24], ['JJ777' ,   24], ['TT777' ,   24], ['99777' ,   24],
    ['88777' ,   24], ['77766' ,   24], ['77755' ,   24], ['77744' ,   24],
    ['77733' ,   24], ['77722' ,   24], ['AA666' ,   24], ['KK666' ,   24],
    ['QQ666' ,   24], ['JJ666' ,   24], ['TT666' ,   24], ['99666' ,   24],
    ['88666' ,   24], ['77666' ,   24], ['66655' ,   24], ['66644' ,   24],
    ['66633' ,   24], ['66622' ,   24], ['AA555' ,   24], ['KK555' ,   24],
    ['QQ555' ,   24], ['JJ555' ,   24], ['TT555' ,   24], ['99555' ,   24],
    ['88555' ,   24], ['77555' ,   24], ['66555' ,   24], ['55544' ,   24],
    ['55533' ,   24], ['55522' ,   24], ['AA444' ,   24], ['KK444' ,   24],
    ['QQ444' ,   24], ['JJ444' ,   24], ['TT444' ,   24], ['99444' ,   24],
    ['88444' ,   24], ['77444' ,   24], ['66444' ,   24], ['55444' ,   24],
    ['44433' ,   24], ['44422' ,   24], ['AA333' ,   24], ['KK333' ,   24],
    ['QQ333' ,   24], ['JJ333' ,   24], ['TT333' ,   24], ['99333' ,   24],
    ['88333' ,   24], ['77333' ,   24], ['66333' ,   24], ['55333' ,   24],
    ['44333' ,   24], ['33322' ,   24], ['AA222' ,   24], ['KK222' ,   24],
    ['QQ222' ,   24], ['JJ222' ,   24], ['TT222' ,   24], ['99222' ,   24],
    ['88222' ,   24], ['77222' ,   24], ['66222' ,   24], ['55222' ,   24],
    ['44222' ,   24], ['33222' ,   24], ['AKQJ9s',    4], ['AKQJ8s',    4],
    ['AKQJ7s',    4], ['AKQJ6s',    4], ['AKQJ5s',    4], ['AKQJ4s',    4],
    ['AKQJ3s',    4], ['AKQJ2s',    4], ['AKQT9s',    4], ['AKQT8s',    4],
    ['AKQT7s',    4], ['AKQT6s',    4], ['AKQT5s',    4], ['AKQT4s',    4],
    ['AKQT3s',    4], ['AKQT2s',    4], ['AKQ98s',    4], ['AKQ97s',    4],
    ['AKQ96s',    4], ['AKQ95s',    4], ['AKQ94s',    4], ['AKQ93s',    4],
    ['AKQ92s',    4], ['AKQ87s',    4], ['AKQ86s',    4], ['AKQ85s',    4],
    ['AKQ84s',    4], ['AKQ83s',    4], ['AKQ82s',    4], ['AKQ76s',    4],
    ['AKQ75s',    4], ['AKQ74s',    4], ['AKQ73s',    4], ['AKQ72s',    4],
    ['AKQ65s',    4], ['AKQ64s',    4], ['AKQ63s',    4], ['AKQ62s',    4],
    ['AKQ54s',    4], ['AKQ53s',    4], ['AKQ52s',    4], ['AKQ43s',    4],
    ['AKQ42s',    4], ['AKQ32s',    4], ['AKJT9s',    4], ['AKJT8s',    4],
    ['AKJT7s',    4], ['AKJT6s',    4], ['AKJT5s',    4], ['AKJT4s',    4],
    ['AKJT3s',    4], ['AKJT2s',    4], ['AKJ98s',    4], ['AKJ97s',    4],
    ['AKJ96s',    4], ['AKJ95s',    4], ['AKJ94s',    4], ['AKJ93s',    4],
    ['AKJ92s',    4], ['AKJ87s',    4], ['AKJ86s',    4], ['AKJ85s',    4],
    ['AKJ84s',    4], ['AKJ83s',    4], ['AKJ82s',    4], ['AKJ76s',    4],
    ['AKJ75s',    4], ['AKJ74s',    4], ['AKJ73s',    4], ['AKJ72s',    4],
    ['AKJ65s',    4], ['AKJ64s',    4], ['AKJ63s',    4], ['AKJ62s',    4],
    ['AKJ54s',    4], ['AKJ53s',    4], ['AKJ52s',    4], ['AKJ43s',    4],
    ['AKJ42s',    4], ['AKJ32s',    4], ['AKT98s',    4], ['AKT97s',    4],
    ['AKT96s',    4], ['AKT95s',    4], ['AKT94s',    4], ['AKT93s',    4],
    ['AKT92s',    4], ['AKT87s',    4], ['AKT86s',    4], ['AKT85s',    4],
    ['AKT84s',    4], ['AKT83s',    4], ['AKT82s',    4], ['AKT76s',    4],
    ['AKT75s',    4], ['AKT74s',    4], ['AKT73s',    4], ['AKT72s',    4],
    ['AKT65s',    4], ['AKT64s',    4], ['AKT63s',    4], ['AKT62s',    4],
    ['AKT54s',    4], ['AKT53s',    4], ['AKT52s',    4], ['AKT43s',    4],
    ['AKT42s',    4], ['AKT32s',    4], ['AK987s',    4], ['AK986s',    4],
    ['AK985s',    4], ['AK984s',    4], ['AK983s',    4], ['AK982s',    4],
    ['AK976s',    4], ['AK975s',    4], ['AK974s',    4], ['AK973s',    4],
    ['AK972s',    4], ['AK965s',    4], ['AK964s',    4], ['AK963s',    4],
    ['AK962s',    4], ['AK954s',    4], ['AK953s',    4], ['AK952s',    4],
    ['AK943s',    4], ['AK942s',    4], ['AK932s',    4], ['AK876s',    4],
    ['AK875s',    4], ['AK874s',    4], ['AK873s',    4], ['AK872s',    4],
    ['AK865s',    4], ['AK864s',    4], ['AK863s',    4], ['AK862s',    4],
    ['AK854s',    4], ['AK853s',    4], ['AK852s',    4], ['AK843s',    4],
    ['AK842s',    4], ['AK832s',    4], ['AK765s',    4], ['AK764s',    4],
    ['AK763s',    4], ['AK762s',    4], ['AK754s',    4], ['AK753s',    4],
    ['AK752s',    4], ['AK743s',    4], ['AK742s',    4], ['AK732s',    4],
    ['AK654s',    4], ['AK653s',    4], ['AK652s',    4], ['AK643s',    4],
    ['AK642s',    4], ['AK632s',    4], ['AK543s',    4], ['AK542s',    4],
    ['AK532s',    4], ['AK432s',    4], ['AQJT9s',    4], ['AQJT8s',    4],
    ['AQJT7s',    4], ['AQJT6s',    4], ['AQJT5s',    4], ['AQJT4s',    4],
    ['AQJT3s',    4], ['AQJT2s',    4], ['AQJ98s',    4], ['AQJ97s',    4],
    ['AQJ96s',    4], ['AQJ95s',    4], ['AQJ94s',    4], ['AQJ93s',    4],
    ['AQJ92s',    4], ['AQJ87s',    4], ['AQJ86s',    4], ['AQJ85s',    4],
    ['AQJ84s',    4], ['AQJ83s',    4], ['AQJ82s',    4], ['AQJ76s',    4],
    ['AQJ75s',    4], ['AQJ74s',    4], ['AQJ73s',    4], ['AQJ72s',    4],
    ['AQJ65s',    4], ['AQJ64s',    4], ['AQJ63s',    4], ['AQJ62s',    4],
    ['AQJ54s',    4], ['AQJ53s',    4], ['AQJ52s',    4], ['AQJ43s',    4],
    ['AQJ42s',    4], ['AQJ32s',    4], ['AQT98s',    4], ['AQT97s',    4],
    ['AQT96s',    4], ['AQT95s',    4], ['AQT94s',    4], ['AQT93s',    4],
    ['AQT92s',    4], ['AQT87s',    4], ['AQT86s',    4], ['AQT85s',    4],
    ['AQT84s',    4], ['AQT83s',    4], ['AQT82s',    4], ['AQT76s',    4],
    ['AQT75s',    4], ['AQT74s',    4], ['AQT73s',    4], ['AQT72s',    4],
    ['AQT65s',    4], ['AQT64s',    4], ['AQT63s',    4], ['AQT62s',    4],
    ['AQT54s',    4], ['AQT53s',    4], ['AQT52s',    4], ['AQT43s',    4],
    ['AQT42s',    4], ['AQT32s',    4], ['AQ987s',    4], ['AQ986s',    4],
    ['AQ985s',    4], ['AQ984s',    4], ['AQ983s',    4], ['AQ982s',    4],
    ['AQ976s',    4], ['AQ975s',    4], ['AQ974s',    4], ['AQ973s',    4],
    ['AQ972s',    4], ['AQ965s',    4], ['AQ964s',    4], ['AQ963s',    4],
    ['AQ962s',    4], ['AQ954s',    4], ['AQ953s',    4], ['AQ952s',    4],
    ['AQ943s',    4], ['AQ942s',    4], ['AQ932s',    4], ['AQ876s',    4],
    ['AQ875s',    4], ['AQ874s',    4], ['AQ873s',    4], ['AQ872s',    4],
    ['AQ865s',    4], ['AQ864s',    4], ['AQ863s',    4], ['AQ862s',    4],
    ['AQ854s',    4], ['AQ853s',    4], ['AQ852s',    4], ['AQ843s',    4],
    ['AQ842s',    4], ['AQ832s',    4], ['AQ765s',    4], ['AQ764s',    4],
    ['AQ763s',    4], ['AQ762s',    4], ['AQ754s',    4], ['AQ753s',    4],
    ['AQ752s',    4], ['AQ743s',    4], ['AQ742s',    4], ['AQ732s',    4],
    ['AQ654s',    4], ['AQ653s',    4], ['AQ652s',    4], ['AQ643s',    4],
    ['AQ642s',    4], ['AQ632s',    4], ['AQ543s',    4], ['AQ542s',    4],
    ['AQ532s',    4], ['AQ432s',    4], ['AJT98s',    4], ['AJT97s',    4],
    ['AJT96s',    4], ['AJT95s',    4], ['AJT94s',    4], ['AJT93s',    4],
    ['AJT92s',    4], ['AJT87s',    4], ['AJT86s',    4], ['AJT85s',    4],
    ['AJT84s',    4], ['AJT83s',    4], ['AJT82s',    4], ['AJT76s',    4],
    ['AJT75s',    4], ['AJT74s',    4], ['AJT73s',    4], ['AJT72s',    4],
    ['AJT65s',    4], ['AJT64s',    4], ['AJT63s',    4], ['AJT62s',    4],
    ['AJT54s',    4], ['AJT53s',    4], ['AJT52s',    4], ['AJT43s',    4],
    ['AJT42s',    4], ['AJT32s',    4], ['AJ987s',    4], ['AJ986s',    4],
    ['AJ985s',    4], ['AJ984s',    4], ['AJ983s',    4], ['AJ982s',    4],
    ['AJ976s',    4], ['AJ975s',    4], ['AJ974s',    4], ['AJ973s',    4],
    ['AJ972s',    4], ['AJ965s',    4], ['AJ964s',    4], ['AJ963s',    4],
    ['AJ962s',    4], ['AJ954s',    4], ['AJ953s',    4], ['AJ952s',    4],
    ['AJ943s',    4], ['AJ942s',    4], ['AJ932s',    4], ['AJ876s',    4],
    ['AJ875s',    4], ['AJ874s',    4], ['AJ873s',    4], ['AJ872s',    4],
    ['AJ865s',    4], ['AJ864s',    4], ['AJ863s',    4], ['AJ862s',    4],
    ['AJ854s',    4], ['AJ853s',    4], ['AJ852s',    4], ['AJ843s',    4],
    ['AJ842s',    4], ['AJ832s',    4], ['AJ765s',    4], ['AJ764s',    4],
    ['AJ763s',    4], ['AJ762s',    4], ['AJ754s',    4], ['AJ753s',    4],
    ['AJ752s',    4], ['AJ743s',    4], ['AJ742s',    4], ['AJ732s',    4],
    ['AJ654s',    4], ['AJ653s',    4], ['AJ652s',    4], ['AJ643s',    4],
    ['AJ642s',    4], ['AJ632s',    4], ['AJ543s',    4], ['AJ542s',    4],
    ['AJ532s',    4], ['AJ432s',    4], ['AT987s',    4], ['AT986s',    4],
    ['AT985s',    4], ['AT984s',    4], ['AT983s',    4], ['AT982s',    4],
    ['AT976s',    4], ['AT975s',    4], ['AT974s',    4], ['AT973s',    4],
    ['AT972s',    4], ['AT965s',    4], ['AT964s',    4], ['AT963s',    4],
    ['AT962s',    4], ['AT954s',    4], ['AT953s',    4], ['AT952s',    4],
    ['AT943s',    4], ['AT942s',    4], ['AT932s',    4], ['AT876s',    4],
    ['AT875s',    4], ['AT874s',    4], ['AT873s',    4], ['AT872s',    4],
    ['AT865s',    4], ['AT864s',    4], ['AT863s',    4], ['AT862s',    4],
    ['AT854s',    4], ['AT853s',    4], ['AT852s',    4], ['AT843s',    4],
    ['AT842s',    4], ['AT832s',    4], ['AT765s',    4], ['AT764s',    4],
    ['AT763s',    4], ['AT762s',    4], ['AT754s',    4], ['AT753s',    4],
    ['AT752s',    4], ['AT743s',    4], ['AT742s',    4], ['AT732s',    4],
    ['AT654s',    4], ['AT653s',    4], ['AT652s',    4], ['AT643s',    4],
    ['AT642s',    4], ['AT632s',    4], ['AT543s',    4], ['AT542s',    4],
    ['AT532s',    4], ['AT432s',    4], ['A9876s',    4], ['A9875s',    4],
    ['A9874s',    4], ['A9873s',    4], ['A9872s',    4], ['A9865s',    4],
    ['A9864s',    4], ['A9863s',    4], ['A9862s',    4], ['A9854s',    4],
    ['A9853s',    4], ['A9852s',    4], ['A9843s',    4], ['A9842s',    4],
    ['A9832s',    4], ['A9765s',    4], ['A9764s',    4], ['A9763s',    4],
    ['A9762s',    4], ['A9754s',    4], ['A9753s',    4], ['A9752s',    4],
    ['A9743s',    4], ['A9742s',    4], ['A9732s',    4], ['A9654s',    4],
    ['A9653s',    4], ['A9652s',    4], ['A9643s',    4], ['A9642s',    4],
    ['A9632s',    4], ['A9543s',    4], ['A9542s',    4], ['A9532s',    4],
    ['A9432s',    4], ['A8765s',    4], ['A8764s',    4], ['A8763s',    4],
    ['A8762s',    4], ['A8754s',    4], ['A8753s',    4], ['A8752s',    4],
    ['A8743s',    4], ['A8742s',    4], ['A8732s',    4], ['A8654s',    4],
    ['A8653s',    4], ['A8652s',    4], ['A8643s',    4], ['A8642s',    4],
    ['A8632s',    4], ['A8543s',    4], ['A8542s',    4], ['A8532s',    4],
    ['A8432s',    4], ['A7654s',    4], ['A7653s',    4], ['A7652s',    4],
    ['A7643s',    4], ['A7642s',    4], ['A7632s',    4], ['A7543s',    4],
    ['A7542s',    4], ['A7532s',    4], ['A7432s',    4], ['A6543s',    4],
    ['A6542s',    4], ['A6532s',    4], ['A6432s',    4], ['KQJT8s',    4],
    ['KQJT7s',    4], ['KQJT6s',    4], ['KQJT5s',    4], ['KQJT4s',    4],
    ['KQJT3s',    4], ['KQJT2s',    4], ['KQJ98s',    4], ['KQJ97s',    4],
    ['KQJ96s',    4], ['KQJ95s',    4], ['KQJ94s',    4], ['KQJ93s',    4],
    ['KQJ92s',    4], ['KQJ87s',    4], ['KQJ86s',    4], ['KQJ85s',    4],
    ['KQJ84s',    4], ['KQJ83s',    4], ['KQJ82s',    4], ['KQJ76s',    4],
    ['KQJ75s',    4], ['KQJ74s',    4], ['KQJ73s',    4], ['KQJ72s',    4],
    ['KQJ65s',    4], ['KQJ64s',    4], ['KQJ63s',    4], ['KQJ62s',    4],
    ['KQJ54s',    4], ['KQJ53s',    4], ['KQJ52s',    4], ['KQJ43s',    4],
    ['KQJ42s',    4], ['KQJ32s',    4], ['KQT98s',    4], ['KQT97s',    4],
    ['KQT96s',    4], ['KQT95s',    4], ['KQT94s',    4], ['KQT93s',    4],
    ['KQT92s',    4], ['KQT87s',    4], ['KQT86s',    4], ['KQT85s',    4],
    ['KQT84s',    4], ['KQT83s',    4], ['KQT82s',    4], ['KQT76s',    4],
    ['KQT75s',    4], ['KQT74s',    4], ['KQT73s',    4], ['KQT72s',    4],
    ['KQT65s',    4], ['KQT64s',    4], ['KQT63s',    4], ['KQT62s',    4],
    ['KQT54s',    4], ['KQT53s',    4], ['KQT52s',    4], ['KQT43s',    4],
    ['KQT42s',    4], ['KQT32s',    4], ['KQ987s',    4], ['KQ986s',    4],
    ['KQ985s',    4], ['KQ984s',    4], ['KQ983s',    4], ['KQ982s',    4],
    ['KQ976s',    4], ['KQ975s',    4], ['KQ974s',    4], ['KQ973s',    4],
    ['KQ972s',    4], ['KQ965s',    4], ['KQ964s',    4], ['KQ963s',    4],
    ['KQ962s',    4], ['KQ954s',    4], ['KQ953s',    4], ['KQ952s',    4],
    ['KQ943s',    4], ['KQ942s',    4], ['KQ932s',    4], ['KQ876s',    4],
    ['KQ875s',    4], ['KQ874s',    4], ['KQ873s',    4], ['KQ872s',    4],
    ['KQ865s',    4], ['KQ864s',    4], ['KQ863s',    4], ['KQ862s',    4],
    ['KQ854s',    4], ['KQ853s',    4], ['KQ852s',    4], ['KQ843s',    4],
    ['KQ842s',    4], ['KQ832s',    4], ['KQ765s',    4], ['KQ764s',    4],
    ['KQ763s',    4], ['KQ762s',    4], ['KQ754s',    4], ['KQ753s',    4],
    ['KQ752s',    4], ['KQ743s',    4], ['KQ742s',    4], ['KQ732s',    4],
    ['KQ654s',    4], ['KQ653s',    4], ['KQ652s',    4], ['KQ643s',    4],
    ['KQ642s',    4], ['KQ632s',    4], ['KQ543s',    4], ['KQ542s',    4],
    ['KQ532s',    4], ['KQ432s',    4], ['KJT98s',    4], ['KJT97s',    4],
    ['KJT96s',    4], ['KJT95s',    4], ['KJT94s',    4], ['KJT93s',    4],
    ['KJT92s',    4], ['KJT87s',    4], ['KJT86s',    4], ['KJT85s',    4],
    ['KJT84s',    4], ['KJT83s',    4], ['KJT82s',    4], ['KJT76s',    4],
    ['KJT75s',    4], ['KJT74s',    4], ['KJT73s',    4], ['KJT72s',    4],
    ['KJT65s',    4], ['KJT64s',    4], ['KJT63s',    4], ['KJT62s',    4],
    ['KJT54s',    4], ['KJT53s',    4], ['KJT52s',    4], ['KJT43s',    4],
    ['KJT42s',    4], ['KJT32s',    4], ['KJ987s',    4], ['KJ986s',    4],
    ['KJ985s',    4], ['KJ984s',    4], ['KJ983s',    4], ['KJ982s',    4],
    ['KJ976s',    4], ['KJ975s',    4], ['KJ974s',    4], ['KJ973s',    4],
    ['KJ972s',    4], ['KJ965s',    4], ['KJ964s',    4], ['KJ963s',    4],
    ['KJ962s',    4], ['KJ954s',    4], ['KJ953s',    4], ['KJ952s',    4],
    ['KJ943s',    4], ['KJ942s',    4], ['KJ932s',    4], ['KJ876s',    4],
    ['KJ875s',    4], ['KJ874s',    4], ['KJ873s',    4], ['KJ872s',    4],
    ['KJ865s',    4], ['KJ864s',    4], ['KJ863s',    4], ['KJ862s',    4],
    ['KJ854s',    4], ['KJ853s',    4], ['KJ852s',    4], ['KJ843s',    4],
    ['KJ842s',    4], ['KJ832s',    4], ['KJ765s',    4], ['KJ764s',    4],
    ['KJ763s',    4], ['KJ762s',    4], ['KJ754s',    4], ['KJ753s',    4],
    ['KJ752s',    4], ['KJ743s',    4], ['KJ742s',    4], ['KJ732s',    4],
    ['KJ654s',    4], ['KJ653s',    4], ['KJ652s',    4], ['KJ643s',    4],
    ['KJ642s',    4], ['KJ632s',    4], ['KJ543s',    4], ['KJ542s',    4],
    ['KJ532s',    4], ['KJ432s',    4], ['KT987s',    4], ['KT986s',    4],
    ['KT985s',    4], ['KT984s',    4], ['KT983s',    4], ['KT982s',    4],
    ['KT976s',    4], ['KT975s',    4], ['KT974s',    4], ['KT973s',    4],
    ['KT972s',    4], ['KT965s',    4], ['KT964s',    4], ['KT963s',    4],
    ['KT962s',    4], ['KT954s',    4], ['KT953s',    4], ['KT952s',    4],
    ['KT943s',    4], ['KT942s',    4], ['KT932s',    4], ['KT876s',    4],
    ['KT875s',    4], ['KT874s',    4], ['KT873s',    4], ['KT872s',    4],
    ['KT865s',    4], ['KT864s',    4], ['KT863s',    4], ['KT862s',    4],
    ['KT854s',    4], ['KT853s',    4], ['KT852s',    4], ['KT843s',    4],
    ['KT842s',    4], ['KT832s',    4], ['KT765s',    4], ['KT764s',    4],
    ['KT763s',    4], ['KT762s',    4], ['KT754s',    4], ['KT753s',    4],
    ['KT752s',    4], ['KT743s',    4], ['KT742s',    4], ['KT732s',    4],
    ['KT654s',    4], ['KT653s',    4], ['KT652s',    4], ['KT643s',    4],
    ['KT642s',    4], ['KT632s',    4], ['KT543s',    4], ['KT542s',    4],
    ['KT532s',    4], ['KT432s',    4], ['K9876s',    4], ['K9875s',    4],
    ['K9874s',    4], ['K9873s',    4], ['K9872s',    4], ['K9865s',    4],
    ['K9864s',    4], ['K9863s',    4], ['K9862s',    4], ['K9854s',    4],
    ['K9853s',    4], ['K9852s',    4], ['K9843s',    4], ['K9842s',    4],
    ['K9832s',    4], ['K9765s',    4], ['K9764s',    4], ['K9763s',    4],
    ['K9762s',    4], ['K9754s',    4], ['K9753s',    4], ['K9752s',    4],
    ['K9743s',    4], ['K9742s',    4], ['K9732s',    4], ['K9654s',    4],
    ['K9653s',    4], ['K9652s',    4], ['K9643s',    4], ['K9642s',    4],
    ['K9632s',    4], ['K9543s',    4], ['K9542s',    4], ['K9532s',    4],
    ['K9432s',    4], ['K8765s',    4], ['K8764s',    4], ['K8763s',    4],
    ['K8762s',    4], ['K8754s',    4], ['K8753s',    4], ['K8752s',    4],
    ['K8743s',    4], ['K8742s',    4], ['K8732s',    4], ['K8654s',    4],
    ['K8653s',    4], ['K8652s',    4], ['K8643s',    4], ['K8642s',    4],
    ['K8632s',    4], ['K8543s',    4], ['K8542s',    4], ['K8532s',    4],
    ['K8432s',    4], ['K7654s',    4], ['K7653s',    4], ['K7652s',    4],
    ['K7643s',    4], ['K7642s',    4], ['K7632s',    4], ['K7543s',    4],
    ['K7542s',    4], ['K7532s',    4], ['K7432s',    4], ['K6543s',    4],
    ['K6542s',    4], ['K6532s',    4], ['K6432s',    4], ['K5432s',    4],
    ['QJT97s',    4], ['QJT96s',    4], ['QJT95s',    4], ['QJT94s',    4],
    ['QJT93s',    4], ['QJT92s',    4], ['QJT87s',    4], ['QJT86s',    4],
    ['QJT85s',    4], ['QJT84s',    4], ['QJT83s',    4], ['QJT82s',    4],
    ['QJT76s',    4], ['QJT75s',    4], ['QJT74s',    4], ['QJT73s',    4],
    ['QJT72s',    4], ['QJT65s',    4], ['QJT64s',    4], ['QJT63s',    4],
    ['QJT62s',    4], ['QJT54s',    4], ['QJT53s',    4], ['QJT52s',    4],
    ['QJT43s',    4], ['QJT42s',    4], ['QJT32s',    4], ['QJ987s',    4],
    ['QJ986s',    4], ['QJ985s',    4], ['QJ984s',    4], ['QJ983s',    4],
    ['QJ982s',    4], ['QJ976s',    4], ['QJ975s',    4], ['QJ974s',    4],
    ['QJ973s',    4], ['QJ972s',    4], ['QJ965s',    4], ['QJ964s',    4],
    ['QJ963s',    4], ['QJ962s',    4], ['QJ954s',    4], ['QJ953s',    4],
    ['QJ952s',    4], ['QJ943s',    4], ['QJ942s',    4], ['QJ932s',    4],
    ['QJ876s',    4], ['QJ875s',    4], ['QJ874s',    4], ['QJ873s',    4],
    ['QJ872s',    4], ['QJ865s',    4], ['QJ864s',    4], ['QJ863s',    4],
    ['QJ862s',    4], ['QJ854s',    4], ['QJ853s',    4], ['QJ852s',    4],
    ['QJ843s',    4], ['QJ842s',    4], ['QJ832s',    4], ['QJ765s',    4],
    ['QJ764s',    4], ['QJ763s',    4], ['QJ762s',    4], ['QJ754s',    4],
    ['QJ753s',    4], ['QJ752s',    4], ['QJ743s',    4], ['QJ742s',    4],
    ['QJ732s',    4], ['QJ654s',    4], ['QJ653s',    4], ['QJ652s',    4],
    ['QJ643s',    4], ['QJ642s',    4], ['QJ632s',    4], ['QJ543s',    4],
    ['QJ542s',    4], ['QJ532s',    4], ['QJ432s',    4], ['QT987s',    4],
    ['QT986s',    4], ['QT985s',    4], ['QT984s',    4], ['QT983s',    4],
    ['QT982s',    4], ['QT976s',    4], ['QT975s',    4], ['QT974s',    4],
    ['QT973s',    4], ['QT972s',    4], ['QT965s',    4], ['QT964s',    4],
    ['QT963s',    4], ['QT962s',    4], ['QT954s',    4], ['QT953s',    4],
    ['QT952s',    4], ['QT943s',    4], ['QT942s',    4], ['QT932s',    4],
    ['QT876s',    4], ['QT875s',    4], ['QT874s',    4], ['QT873s',    4],
    ['QT872s',    4], ['QT865s',    4], ['QT864s',    4], ['QT863s',    4],
    ['QT862s',    4], ['QT854s',    4], ['QT853s',    4], ['QT852s',    4],
    ['QT843s',    4], ['QT842s',    4], ['QT832s',    4], ['QT765s',    4],
    ['QT764s',    4], ['QT763s',    4], ['QT762s',    4], ['QT754s',    4],
    ['QT753s',    4], ['QT752s',    4], ['QT743s',    4], ['QT742s',    4],
    ['QT732s',    4], ['QT654s',    4], ['QT653s',    4], ['QT652s',    4],
    ['QT643s',    4], ['QT642s',    4], ['QT632s',    4], ['QT543s',    4],
    ['QT542s',    4], ['QT532s',    4], ['QT432s',    4], ['Q9876s',    4],
    ['Q9875s',    4], ['Q9874s',    4], ['Q9873s',    4], ['Q9872s',    4],
    ['Q9865s',    4], ['Q9864s',    4], ['Q9863s',    4], ['Q9862s',    4],
    ['Q9854s',    4], ['Q9853s',    4], ['Q9852s',    4], ['Q9843s',    4],
    ['Q9842s',    4], ['Q9832s',    4], ['Q9765s',    4], ['Q9764s',    4],
    ['Q9763s',    4], ['Q9762s',    4], ['Q9754s',    4], ['Q9753s',    4],
    ['Q9752s',    4], ['Q9743s',    4], ['Q9742s',    4], ['Q9732s',    4],
    ['Q9654s',    4], ['Q9653s',    4], ['Q9652s',    4], ['Q9643s',    4],
    ['Q9642s',    4], ['Q9632s',    4], ['Q9543s',    4], ['Q9542s',    4],
    ['Q9532s',    4], ['Q9432s',    4], ['Q8765s',    4], ['Q8764s',    4],
    ['Q8763s',    4], ['Q8762s',    4], ['Q8754s',    4], ['Q8753s',    4],
    ['Q8752s',    4], ['Q8743s',    4], ['Q8742s',    4], ['Q8732s',    4],
    ['Q8654s',    4], ['Q8653s',    4], ['Q8652s',    4], ['Q8643s',    4],
    ['Q8642s',    4], ['Q8632s',    4], ['Q8543s',    4], ['Q8542s',    4],
    ['Q8532s',    4], ['Q8432s',    4], ['Q7654s',    4], ['Q7653s',    4],
    ['Q7652s',    4], ['Q7643s',    4], ['Q7642s',    4], ['Q7632s',    4],
    ['Q7543s',    4], ['Q7542s',    4], ['Q7532s',    4], ['Q7432s',    4],
    ['Q6543s',    4], ['Q6542s',    4], ['Q6532s',    4], ['Q6432s',    4],
    ['Q5432s',    4], ['JT986s',    4], ['JT985s',    4], ['JT984s',    4],
    ['JT983s',    4], ['JT982s',    4], ['JT976s',    4], ['JT975s',    4],
    ['JT974s',    4], ['JT973s',    4], ['JT972s',    4], ['JT965s',    4],
    ['JT964s',    4], ['JT963s',    4], ['JT962s',    4], ['JT954s',    4],
    ['JT953s',    4], ['JT952s',    4], ['JT943s',    4], ['JT942s',    4],
    ['JT932s',    4], ['JT876s',    4], ['JT875s',    4], ['JT874s',    4],
    ['JT873s',    4], ['JT872s',    4], ['JT865s',    4], ['JT864s',    4],
    ['JT863s',    4], ['JT862s',    4], ['JT854s',    4], ['JT853s',    4],
    ['JT852s',    4], ['JT843s',    4], ['JT842s',    4], ['JT832s',    4],
    ['JT765s',    4], ['JT764s',    4], ['JT763s',    4], ['JT762s',    4],
    ['JT754s',    4], ['JT753s',    4], ['JT752s',    4], ['JT743s',    4],
    ['JT742s',    4], ['JT732s',    4], ['JT654s',    4], ['JT653s',    4],
    ['JT652s',    4], ['JT643s',    4], ['JT642s',    4], ['JT632s',    4],
    ['JT543s',    4], ['JT542s',    4], ['JT532s',    4], ['JT432s',    4],
    ['J9876s',    4], ['J9875s',    4], ['J9874s',    4], ['J9873s',    4],
    ['J9872s',    4], ['J9865s',    4], ['J9864s',    4], ['J9863s',    4],
    ['J9862s',    4], ['J9854s',    4], ['J9853s',    4], ['J9852s',    4],
    ['J9843s',    4], ['J9842s',    4], ['J9832s',    4], ['J9765s',    4],
    ['J9764s',    4], ['J9763s',    4], ['J9762s',    4], ['J9754s',    4],
    ['J9753s',    4], ['J9752s',    4], ['J9743s',    4], ['J9742s',    4],
    ['J9732s',    4], ['J9654s',    4], ['J9653s',    4], ['J9652s',    4],
    ['J9643s',    4], ['J9642s',    4], ['J9632s',    4], ['J9543s',    4],
    ['J9542s',    4], ['J9532s',    4], ['J9432s',    4], ['J8765s',    4],
    ['J8764s',    4], ['J8763s',    4], ['J8762s',    4], ['J8754s',    4],
    ['J8753s',    4], ['J8752s',    4], ['J8743s',    4], ['J8742s',    4],
    ['J8732s',    4], ['J8654s',    4], ['J8653s',    4], ['J8652s',    4],
    ['J8643s',    4], ['J8642s',    4], ['J8632s',    4], ['J8543s',    4],
    ['J8542s',    4], ['J8532s',    4], ['J8432s',    4], ['J7654s',    4],
    ['J7653s',    4], ['J7652s',    4], ['J7643s',    4], ['J7642s',    4],
    ['J7632s',    4], ['J7543s',    4], ['J7542s',    4], ['J7532s',    4],
    ['J7432s',    4], ['J6543s',    4], ['J6542s',    4], ['J6532s',    4],
    ['J6432s',    4], ['J5432s',    4], ['T9875s',    4], ['T9874s',    4],
    ['T9873s',    4], ['T9872s',    4], ['T9865s',    4], ['T9864s',    4],
    ['T9863s',    4], ['T9862s',    4], ['T9854s',    4], ['T9853s',    4],
    ['T9852s',    4], ['T9843s',    4], ['T9842s',    4], ['T9832s',    4],
    ['T9765s',    4], ['T9764s',    4], ['T9763s',    4], ['T9762s',    4],
    ['T9754s',    4], ['T9753s',    4], ['T9752s',    4], ['T9743s',    4],
    ['T9742s',    4], ['T9732s',    4], ['T9654s',    4], ['T9653s',    4],
    ['T9652s',    4], ['T9643s',    4], ['T9642s',    4], ['T9632s',    4],
    ['T9543s',    4], ['T9542s',    4], ['T9532s',    4], ['T9432s',    4],
    ['T8765s',    4], ['T8764s',    4], ['T8763s',    4], ['T8762s',    4],
    ['T8754s',    4], ['T8753s',    4], ['T8752s',    4], ['T8743s',    4],
    ['T8742s',    4], ['T8732s',    4], ['T8654s',    4], ['T8653s',    4],
    ['T8652s',    4], ['T8643s',    4], ['T8642s',    4], ['T8632s',    4],
    ['T8543s',    4], ['T8542s',    4], ['T8532s',    4], ['T8432s',    4],
    ['T7654s',    4], ['T7653s',    4], ['T7652s',    4], ['T7643s',    4],
    ['T7642s',    4], ['T7632s',    4], ['T7543s',    4], ['T7542s',    4],
    ['T7532s',    4], ['T7432s',    4], ['T6543s',    4], ['T6542s',    4],
    ['T6532s',    4], ['T6432s',    4], ['T5432s',    4], ['98764s',    4],
    ['98763s',    4], ['98762s',    4], ['98754s',    4], ['98753s',    4],
    ['98752s',    4], ['98743s',    4], ['98742s',    4], ['98732s',    4],
    ['98654s',    4], ['98653s',    4], ['98652s',    4], ['98643s',    4],
    ['98642s',    4], ['98632s',    4], ['98543s',    4], ['98542s',    4],
    ['98532s',    4], ['98432s',    4], ['97654s',    4], ['97653s',    4],
    ['97652s',    4], ['97643s',    4], ['97642s',    4], ['97632s',    4],
    ['97543s',    4], ['97542s',    4], ['97532s',    4], ['97432s',    4],
    ['96543s',    4], ['96542s',    4], ['96532s',    4], ['96432s',    4],
    ['95432s',    4], ['87653s',    4], ['87652s',    4], ['87643s',    4],
    ['87642s',    4], ['87632s',    4], ['87543s',    4], ['87542s',    4],
    ['87532s',    4], ['87432s',    4], ['86543s',    4], ['86542s',    4],
    ['86532s',    4], ['86432s',    4], ['85432s',    4], ['76542s',    4],
    ['76532s',    4], ['76432s',    4], ['75432s',    4], ['AKQJT' , 1020],
    ['KQJT9' , 1020], ['QJT98' , 1020], ['JT987' , 1020], ['T9876' , 1020],
    ['98765' , 1020], ['87654' , 1020], ['76543' , 1020], ['65432' , 1020],
    ['A5432' , 1020], ['AAAKQ' ,   64], ['AAAKJ' ,   64], ['AAAKT' ,   64],
    ['AAAK9' ,   64], ['AAAK8' ,   64], ['AAAK7' ,   64], ['AAAK6' ,   64],
    ['AAAK5' ,   64], ['AAAK4' ,   64], ['AAAK3' ,   64], ['AAAK2' ,   64],
    ['AAAQJ' ,   64], ['AAAQT' ,   64], ['AAAQ9' ,   64], ['AAAQ8' ,   64],
    ['AAAQ7' ,   64], ['AAAQ6' ,   64], ['AAAQ5' ,   64], ['AAAQ4' ,   64],
    ['AAAQ3' ,   64], ['AAAQ2' ,   64], ['AAAJT' ,   64], ['AAAJ9' ,   64],
    ['AAAJ8' ,   64], ['AAAJ7' ,   64], ['AAAJ6' ,   64], ['AAAJ5' ,   64],
    ['AAAJ4' ,   64], ['AAAJ3' ,   64], ['AAAJ2' ,   64], ['AAAT9' ,   64],
    ['AAAT8' ,   64], ['AAAT7' ,   64], ['AAAT6' ,   64], ['AAAT5' ,   64],
    ['AAAT4' ,   64], ['AAAT3' ,   64], ['AAAT2' ,   64], ['AAA98' ,   64],
    ['AAA97' ,   64], ['AAA96' ,   64], ['AAA95' ,   64], ['AAA94' ,   64],
    ['AAA93' ,   64], ['AAA92' ,   64], ['AAA87' ,   64], ['AAA86' ,   64],
    ['AAA85' ,   64], ['AAA84' ,   64], ['AAA83' ,   64], ['AAA82' ,   64],
    ['AAA76' ,   64], ['AAA75' ,   64], ['AAA74' ,   64], ['AAA73' ,   64],
    ['AAA72' ,   64], ['AAA65' ,   64], ['AAA64' ,   64], ['AAA63' ,   64],
    ['AAA62' ,   64], ['AAA54' ,   64], ['AAA53' ,   64], ['AAA52' ,   64],
    ['AAA43' ,   64], ['AAA42' ,   64], ['AAA32' ,   64], ['AKKKQ' ,   64],
    ['AKKKJ' ,   64], ['AKKKT' ,   64], ['AKKK9' ,   64], ['AKKK8' ,   64],
    ['AKKK7' ,   64], ['AKKK6' ,   64], ['AKKK5' ,   64], ['AKKK4' ,   64],
    ['AKKK3' ,   64], ['AKKK2' ,   64], ['KKKQJ' ,   64], ['KKKQT' ,   64],
    ['KKKQ9' ,   64], ['KKKQ8' ,   64], ['KKKQ7' ,   64], ['KKKQ6' ,   64],
    ['KKKQ5' ,   64], ['KKKQ4' ,   64], ['KKKQ3' ,   64], ['KKKQ2' ,   64],
    ['KKKJT' ,   64], ['KKKJ9' ,   64], ['KKKJ8' ,   64], ['KKKJ7' ,   64],
    ['KKKJ6' ,   64], ['KKKJ5' ,   64], ['KKKJ4' ,   64], ['KKKJ3' ,   64],
    ['KKKJ2' ,   64], ['KKKT9' ,   64], ['KKKT8' ,   64], ['KKKT7' ,   64],
    ['KKKT6' ,   64], ['KKKT5' ,   64], ['KKKT4' ,   64], ['KKKT3' ,   64],
    ['KKKT2' ,   64], ['KKK98' ,   64], ['KKK97' ,   64], ['KKK96' ,   64],
    ['KKK95' ,   64], ['KKK94' ,   64], ['KKK93' ,   64], ['KKK92' ,   64],
    ['KKK87' ,   64], ['KKK86' ,   64], ['KKK85' ,   64], ['KKK84' ,   64],
    ['KKK83' ,   64], ['KKK82' ,   64], ['KKK76' ,   64], ['KKK75' ,   64],
    ['KKK74' ,   64], ['KKK73' ,   64], ['KKK72' ,   64], ['KKK65' ,   64],
    ['KKK64' ,   64], ['KKK63' ,   64], ['KKK62' ,   64], ['KKK54' ,   64],
    ['KKK53' ,   64], ['KKK52' ,   64], ['KKK43' ,   64], ['KKK42' ,   64],
    ['KKK32' ,   64], ['AKQQQ' ,   64], ['AQQQJ' ,   64], ['AQQQT' ,   64],
    ['AQQQ9' ,   64], ['AQQQ8' ,   64], ['AQQQ7' ,   64], ['AQQQ6' ,   64],
    ['AQQQ5' ,   64], ['AQQQ4' ,   64], ['AQQQ3' ,   64], ['AQQQ2' ,   64],
    ['KQQQJ' ,   64], ['KQQQT' ,   64], ['KQQQ9' ,   64], ['KQQQ8' ,   64],
    ['KQQQ7' ,   64], ['KQQQ6' ,   64], ['KQQQ5' ,   64], ['KQQQ4' ,   64],
    ['KQQQ3' ,   64], ['KQQQ2' ,   64], ['QQQJT' ,   64], ['QQQJ9' ,   64],
    ['QQQJ8' ,   64], ['QQQJ7' ,   64], ['QQQJ6' ,   64], ['QQQJ5' ,   64],
    ['QQQJ4' ,   64], ['QQQJ3' ,   64], ['QQQJ2' ,   64], ['QQQT9' ,   64],
    ['QQQT8' ,   64], ['QQQT7' ,   64], ['QQQT6' ,   64], ['QQQT5' ,   64],
    ['QQQT4' ,   64], ['QQQT3' ,   64], ['QQQT2' ,   64], ['QQQ98' ,   64],
    ['QQQ97' ,   64], ['QQQ96' ,   64], ['QQQ95' ,   64], ['QQQ94' ,   64],
    ['QQQ93' ,   64], ['QQQ92' ,   64], ['QQQ87' ,   64], ['QQQ86' ,   64],
    ['QQQ85' ,   64], ['QQQ84' ,   64], ['QQQ83' ,   64], ['QQQ82' ,   64],
    ['QQQ76' ,   64], ['QQQ75' ,   64], ['QQQ74' ,   64], ['QQQ73' ,   64],
    ['QQQ72' ,   64], ['QQQ65' ,   64], ['QQQ64' ,   64], ['QQQ63' ,   64],
    ['QQQ62' ,   64], ['QQQ54' ,   64], ['QQQ53' ,   64], ['QQQ52' ,   64],
    ['QQQ43' ,   64], ['QQQ42' ,   64], ['QQQ32' ,   64], ['AKJJJ' ,   64],
    ['AQJJJ' ,   64], ['AJJJT' ,   64], ['AJJJ9' ,   64], ['AJJJ8' ,   64],
    ['AJJJ7' ,   64], ['AJJJ6' ,   64], ['AJJJ5' ,   64], ['AJJJ4' ,   64],
    ['AJJJ3' ,   64], ['AJJJ2' ,   64], ['KQJJJ' ,   64], ['KJJJT' ,   64],
    ['KJJJ9' ,   64], ['KJJJ8' ,   64], ['KJJJ7' ,   64], ['KJJJ6' ,   64],
    ['KJJJ5' ,   64], ['KJJJ4' ,   64], ['KJJJ3' ,   64], ['KJJJ2' ,   64],
    ['QJJJT' ,   64], ['QJJJ9' ,   64], ['QJJJ8' ,   64], ['QJJJ7' ,   64],
    ['QJJJ6' ,   64], ['QJJJ5' ,   64], ['QJJJ4' ,   64], ['QJJJ3' ,   64],
    ['QJJJ2' ,   64], ['JJJT9' ,   64], ['JJJT8' ,   64], ['JJJT7' ,   64],
    ['JJJT6' ,   64], ['JJJT5' ,   64], ['JJJT4' ,   64], ['JJJT3' ,   64],
    ['JJJT2' ,   64], ['JJJ98' ,   64], ['JJJ97' ,   64], ['JJJ96' ,   64],
    ['JJJ95' ,   64], ['JJJ94' ,   64], ['JJJ93' ,   64], ['JJJ92' ,   64],
    ['JJJ87' ,   64], ['JJJ86' ,   64], ['JJJ85' ,   64], ['JJJ84' ,   64],
    ['JJJ83' ,   64], ['JJJ82' ,   64], ['JJJ76' ,   64], ['JJJ75' ,   64],
    ['JJJ74' ,   64], ['JJJ73' ,   64], ['JJJ72' ,   64], ['JJJ65' ,   64],
    ['JJJ64' ,   64], ['JJJ63' ,   64], ['JJJ62' ,   64], ['JJJ54' ,   64],
    ['JJJ53' ,   64], ['JJJ52' ,   64], ['JJJ43' ,   64], ['JJJ42' ,   64],
    ['JJJ32' ,   64], ['AKTTT' ,   64], ['AQTTT' ,   64], ['AJTTT' ,   64],
    ['ATTT9' ,   64], ['ATTT8' ,   64], ['ATTT7' ,   64], ['ATTT6' ,   64],
    ['ATTT5' ,   64], ['ATTT4' ,   64], ['ATTT3' ,   64], ['ATTT2' ,   64],
    ['KQTTT' ,   64], ['KJTTT' ,   64], ['KTTT9' ,   64], ['KTTT8' ,   64],
    ['KTTT7' ,   64], ['KTTT6' ,   64], ['KTTT5' ,   64], ['KTTT4' ,   64],
    ['KTTT3' ,   64], ['KTTT2' ,   64], ['QJTTT' ,   64], ['QTTT9' ,   64],
    ['QTTT8' ,   64], ['QTTT7' ,   64], ['QTTT6' ,   64], ['QTTT5' ,   64],
    ['QTTT4' ,   64], ['QTTT3' ,   64], ['QTTT2' ,   64], ['JTTT9' ,   64],
    ['JTTT8' ,   64], ['JTTT7' ,   64], ['JTTT6' ,   64], ['JTTT5' ,   64],
    ['JTTT4' ,   64], ['JTTT3' ,   64], ['JTTT2' ,   64], ['TTT98' ,   64],
    ['TTT97' ,   64], ['TTT96' ,   64], ['TTT95' ,   64], ['TTT94' ,   64],
    ['TTT93' ,   64], ['TTT92' ,   64], ['TTT87' ,   64], ['TTT86' ,   64],
    ['TTT85' ,   64], ['TTT84' ,   64], ['TTT83' ,   64], ['TTT82' ,   64],
    ['TTT76' ,   64], ['TTT75' ,   64], ['TTT74' ,   64], ['TTT73' ,   64],
    ['TTT72' ,   64], ['TTT65' ,   64], ['TTT64' ,   64], ['TTT63' ,   64],
    ['TTT62' ,   64], ['TTT54' ,   64], ['TTT53' ,   64], ['TTT52' ,   64],
    ['TTT43' ,   64], ['TTT42' ,   64], ['TTT32' ,   64], ['AK999' ,   64],
    ['AQ999' ,   64], ['AJ999' ,   64], ['AT999' ,   64], ['A9998' ,   64],
    ['A9997' ,   64], ['A9996' ,   64], ['A9995' ,   64], ['A9994' ,   64],
    ['A9993' ,   64], ['A9992' ,   64], ['KQ999' ,   64], ['KJ999' ,   64],
    ['KT999' ,   64], ['K9998' ,   64], ['K9997' ,   64], ['K9996' ,   64],
    ['K9995' ,   64], ['K9994' ,   64], ['K9993' ,   64], ['K9992' ,   64],
    ['QJ999' ,   64], ['QT999' ,   64], ['Q9998' ,   64], ['Q9997' ,   64],
    ['Q9996' ,   64], ['Q9995' ,   64], ['Q9994' ,   64], ['Q9993' ,   64],
    ['Q9992' ,   64], ['JT999' ,   64], ['J9998' ,   64], ['J9997' ,   64],
    ['J9996' ,   64], ['J9995' ,   64], ['J9994' ,   64], ['J9993' ,   64],
    ['J9992' ,   64], ['T9998' ,   64], ['T9997' ,   64], ['T9996' ,   64],
    ['T9995' ,   64], ['T9994' ,   64], ['T9993' ,   64], ['T9992' ,   64],
    ['99987' ,   64], ['99986' ,   64], ['99985' ,   64], ['99984' ,   64],
    ['99983' ,   64], ['99982' ,   64], ['99976' ,   64], ['99975' ,   64],
    ['99974' ,   64], ['99973' ,   64], ['99972' ,   64], ['99965' ,   64],
    ['99964' ,   64], ['99963' ,   64], ['99962' ,   64], ['99954' ,   64],
    ['99953' ,   64], ['99952' ,   64], ['99943' ,   64], ['99942' ,   64],
    ['99932' ,   64], ['AK888' ,   64], ['AQ888' ,   64], ['AJ888' ,   64],
    ['AT888' ,   64], ['A9888' ,   64], ['A8887' ,   64], ['A8886' ,   64],
    ['A8885' ,   64], ['A8884' ,   64], ['A8883' ,   64], ['A8882' ,   64],
    ['KQ888' ,   64], ['KJ888' ,   64], ['KT888' ,   64], ['K9888' ,   64],
    ['K8887' ,   64], ['K8886' ,   64], ['K8885' ,   64], ['K8884' ,   64],
    ['K8883' ,   64], ['K8882' ,   64], ['QJ888' ,   64], ['QT888' ,   64],
    ['Q9888' ,   64], ['Q8887' ,   64], ['Q8886' ,   64], ['Q8885' ,   64],
    ['Q8884' ,   64], ['Q8883' ,   64], ['Q8882' ,   64], ['JT888' ,   64],
    ['J9888' ,   64], ['J8887' ,   64], ['J8886' ,   64], ['J8885' ,   64],
    ['J8884' ,   64], ['J8883' ,   64], ['J8882' ,   64], ['T9888' ,   64],
    ['T8887' ,   64], ['T8886' ,   64], ['T8885' ,   64], ['T8884' ,   64],
    ['T8883' ,   64], ['T8882' ,   64], ['98887' ,   64], ['98886' ,   64],
    ['98885' ,   64], ['98884' ,   64], ['98883' ,   64], ['98882' ,   64],
    ['88876' ,   64], ['88875' ,   64], ['88874' ,   64], ['88873' ,   64],
    ['88872' ,   64], ['88865' ,   64], ['88864' ,   64], ['88863' ,   64],
    ['88862' ,   64], ['88854' ,   64], ['88853' ,   64], ['88852' ,   64],
    ['88843' ,   64], ['88842' ,   64], ['88832' ,   64], ['AK777' ,   64],
    ['AQ777' ,   64], ['AJ777' ,   64], ['AT777' ,   64], ['A9777' ,   64],
    ['A8777' ,   64], ['A7776' ,   64], ['A7775' ,   64], ['A7774' ,   64],
    ['A7773' ,   64], ['A7772' ,   64], ['KQ777' ,   64], ['KJ777' ,   64],
    ['KT777' ,   64], ['K9777' ,   64], ['K8777' ,   64], ['K7776' ,   64],
    ['K7775' ,   64], ['K7774' ,   64], ['K7773' ,   64], ['K7772' ,   64],
    ['QJ777' ,   64], ['QT777' ,   64], ['Q9777' ,   64], ['Q8777' ,   64],
    ['Q7776' ,   64], ['Q7775' ,   64], ['Q7774' ,   64], ['Q7773' ,   64],
    ['Q7772' ,   64], ['JT777' ,   64], ['J9777' ,   64], ['J8777' ,   64],
    ['J7776' ,   64], ['J7775' ,   64], ['J7774' ,   64], ['J7773' ,   64],
    ['J7772' ,   64], ['T9777' ,   64], ['T8777' ,   64], ['T7776' ,   64],
    ['T7775' ,   64], ['T7774' ,   64], ['T7773' ,   64], ['T7772' ,   64],
    ['98777' ,   64], ['97776' ,   64], ['97775' ,   64], ['97774' ,   64],
    ['97773' ,   64], ['97772' ,   64], ['87776' ,   64], ['87775' ,   64],
    ['87774' ,   64], ['87773' ,   64], ['87772' ,   64], ['77765' ,   64],
    ['77764' ,   64], ['77763' ,   64], ['77762' ,   64], ['77754' ,   64],
    ['77753' ,   64], ['77752' ,   64], ['77743' ,   64], ['77742' ,   64],
    ['77732' ,   64], ['AK666' ,   64], ['AQ666' ,   64], ['AJ666' ,   64],
    ['AT666' ,   64], ['A9666' ,   64], ['A8666' ,   64], ['A7666' ,   64],
    ['A6665' ,   64], ['A6664' ,   64], ['A6663' ,   64], ['A6662' ,   64],
    ['KQ666' ,   64], ['KJ666' ,   64], ['KT666' ,   64], ['K9666' ,   64],
    ['K8666' ,   64], ['K7666' ,   64], ['K6665' ,   64], ['K6664' ,   64],
    ['K6663' ,   64], ['K6662' ,   64], ['QJ666' ,   64], ['QT666' ,   64],
    ['Q9666' ,   64], ['Q8666' ,   64], ['Q7666' ,   64], ['Q6665' ,   64],
    ['Q6664' ,   64], ['Q6663' ,   64], ['Q6662' ,   64], ['JT666' ,   64],
    ['J9666' ,   64], ['J8666' ,   64], ['J7666' ,   64], ['J6665' ,   64],
    ['J6664' ,   64], ['J6663' ,   64], ['J6662' ,   64], ['T9666' ,   64],
    ['T8666' ,   64], ['T7666' ,   64], ['T6665' ,   64], ['T6664' ,   64],
    ['T6663' ,   64], ['T6662' ,   64], ['98666' ,   64], ['97666' ,   64],
    ['96665' ,   64], ['96664' ,   64], ['96663' ,   64], ['96662' ,   64],
    ['87666' ,   64], ['86665' ,   64], ['86664' ,   64], ['86663' ,   64],
    ['86662' ,   64], ['76665' ,   64], ['76664' ,   64], ['76663' ,   64],
    ['76662' ,   64], ['66654' ,   64], ['66653' ,   64], ['66652' ,   64],
    ['66643' ,   64], ['66642' ,   64], ['66632' ,   64], ['AK555' ,   64],
    ['AQ555' ,   64], ['AJ555' ,   64], ['AT555' ,   64], ['A9555' ,   64],
    ['A8555' ,   64], ['A7555' ,   64], ['A6555' ,   64], ['A5554' ,   64],
    ['A5553' ,   64], ['A5552' ,   64], ['KQ555' ,   64], ['KJ555' ,   64],
    ['KT555' ,   64], ['K9555' ,   64], ['K8555' ,   64], ['K7555' ,   64],
    ['K6555' ,   64], ['K5554' ,   64], ['K5553' ,   64], ['K5552' ,   64],
    ['QJ555' ,   64], ['QT555' ,   64], ['Q9555' ,   64], ['Q8555' ,   64],
    ['Q7555' ,   64], ['Q6555' ,   64], ['Q5554' ,   64], ['Q5553' ,   64],
    ['Q5552' ,   64], ['JT555' ,   64], ['J9555' ,   64], ['J8555' ,   64],
    ['J7555' ,   64], ['J6555' ,   64], ['J5554' ,   64], ['J5553' ,   64],
    ['J5552' ,   64], ['T9555' ,   64], ['T8555' ,   64], ['T7555' ,   64],
    ['T6555' ,   64], ['T5554' ,   64], ['T5553' ,   64], ['T5552' ,   64],
    ['98555' ,   64], ['97555' ,   64], ['96555' ,   64], ['95554' ,   64],
    ['95553' ,   64], ['95552' ,   64], ['87555' ,   64], ['86555' ,   64],
    ['85554' ,   64], ['85553' ,   64], ['85552' ,   64], ['76555' ,   64],
    ['75554' ,   64], ['75553' ,   64], ['75552' ,   64], ['65554' ,   64],
    ['65553' ,   64], ['65552' ,   64], ['55543' ,   64], ['55542' ,   64],
    ['55532' ,   64], ['AK444' ,   64], ['AQ444' ,   64], ['AJ444' ,   64],
    ['AT444' ,   64], ['A9444' ,   64], ['A8444' ,   64], ['A7444' ,   64],
    ['A6444' ,   64], ['A5444' ,   64], ['A4443' ,   64], ['A4442' ,   64],
    ['KQ444' ,   64], ['KJ444' ,   64], ['KT444' ,   64], ['K9444' ,   64],
    ['K8444' ,   64], ['K7444' ,   64], ['K6444' ,   64], ['K5444' ,   64],
    ['K4443' ,   64], ['K4442' ,   64], ['QJ444' ,   64], ['QT444' ,   64],
    ['Q9444' ,   64], ['Q8444' ,   64], ['Q7444' ,   64], ['Q6444' ,   64],
    ['Q5444' ,   64], ['Q4443' ,   64], ['Q4442' ,   64], ['JT444' ,   64],
    ['J9444' ,   64], ['J8444' ,   64], ['J7444' ,   64], ['J6444' ,   64],
    ['J5444' ,   64], ['J4443' ,   64], ['J4442' ,   64], ['T9444' ,   64],
    ['T8444' ,   64], ['T7444' ,   64], ['T6444' ,   64], ['T5444' ,   64],
    ['T4443' ,   64], ['T4442' ,   64], ['98444' ,   64], ['97444' ,   64],
    ['96444' ,   64], ['95444' ,   64], ['94443' ,   64], ['94442' ,   64],
    ['87444' ,   64], ['86444' ,   64], ['85444' ,   64], ['84443' ,   64],
    ['84442' ,   64], ['76444' ,   64], ['75444' ,   64], ['74443' ,   64],
    ['74442' ,   64], ['65444' ,   64], ['64443' ,   64], ['64442' ,   64],
    ['54443' ,   64], ['54442' ,   64], ['44432' ,   64], ['AK333' ,   64],
    ['AQ333' ,   64], ['AJ333' ,   64], ['AT333' ,   64], ['A9333' ,   64],
    ['A8333' ,   64], ['A7333' ,   64], ['A6333' ,   64], ['A5333' ,   64],
    ['A4333' ,   64], ['A3332' ,   64], ['KQ333' ,   64], ['KJ333' ,   64],
    ['KT333' ,   64], ['K9333' ,   64], ['K8333' ,   64], ['K7333' ,   64],
    ['K6333' ,   64], ['K5333' ,   64], ['K4333' ,   64], ['K3332' ,   64],
    ['QJ333' ,   64], ['QT333' ,   64], ['Q9333' ,   64], ['Q8333' ,   64],
    ['Q7333' ,   64], ['Q6333' ,   64], ['Q5333' ,   64], ['Q4333' ,   64],
    ['Q3332' ,   64], ['JT333' ,   64], ['J9333' ,   64], ['J8333' ,   64],
    ['J7333' ,   64], ['J6333' ,   64], ['J5333' ,   64], ['J4333' ,   64],
    ['J3332' ,   64], ['T9333' ,   64], ['T8333' ,   64], ['T7333' ,   64],
    ['T6333' ,   64], ['T5333' ,   64], ['T4333' ,   64], ['T3332' ,   64],
    ['98333' ,   64], ['97333' ,   64], ['96333' ,   64], ['95333' ,   64],
    ['94333' ,   64], ['93332' ,   64], ['87333' ,   64], ['86333' ,   64],
    ['85333' ,   64], ['84333' ,   64], ['83332' ,   64], ['76333' ,   64],
    ['75333' ,   64], ['74333' ,   64], ['73332' ,   64], ['65333' ,   64],
    ['64333' ,   64], ['63332' ,   64], ['54333' ,   64], ['53332' ,   64],
    ['43332' ,   64], ['AK222' ,   64], ['AQ222' ,   64], ['AJ222' ,   64],
    ['AT222' ,   64], ['A9222' ,   64], ['A8222' ,   64], ['A7222' ,   64],
    ['A6222' ,   64], ['A5222' ,   64], ['A4222' ,   64], ['A3222' ,   64],
    ['KQ222' ,   64], ['KJ222' ,   64], ['KT222' ,   64], ['K9222' ,   64],
    ['K8222' ,   64], ['K7222' ,   64], ['K6222' ,   64], ['K5222' ,   64],
    ['K4222' ,   64], ['K3222' ,   64], ['QJ222' ,   64], ['QT222' ,   64],
    ['Q9222' ,   64], ['Q8222' ,   64], ['Q7222' ,   64], ['Q6222' ,   64],
    ['Q5222' ,   64], ['Q4222' ,   64], ['Q3222' ,   64], ['JT222' ,   64],
    ['J9222' ,   64], ['J8222' ,   64], ['J7222' ,   64], ['J6222' ,   64],
    ['J5222' ,   64], ['J4222' ,   64], ['J3222' ,   64], ['T9222' ,   64],
    ['T8222' ,   64], ['T7222' ,   64], ['T6222' ,   64], ['T5222' ,   64],
    ['T4222' ,   64], ['T3222' ,   64], ['98222' ,   64], ['97222' ,   64],
    ['96222' ,   64], ['95222' ,   64], ['94222' ,   64], ['93222' ,   64],
    ['87222' ,   64], ['86222' ,   64], ['85222' ,   64], ['84222' ,   64],
    ['83222' ,   64], ['76222' ,   64], ['75222' ,   64], ['74222' ,   64],
    ['73222' ,   64], ['65222' ,   64], ['64222' ,   64], ['63222' ,   64],
    ['54222' ,   64], ['53222' ,   64], ['43222' ,   64], ['AAKKQ' ,  144],
    ['AAKKJ' ,  144], ['AAKKT' ,  144], ['AAKK9' ,  144], ['AAKK8' ,  144],
    ['AAKK7' ,  144], ['AAKK6' ,  144], ['AAKK5' ,  144], ['AAKK4' ,  144],
    ['AAKK3' ,  144], ['AAKK2' ,  144], ['AAKQQ' ,  144], ['AAQQJ' ,  144],
    ['AAQQT' ,  144], ['AAQQ9' ,  144], ['AAQQ8' ,  144], ['AAQQ7' ,  144],
    ['AAQQ6' ,  144], ['AAQQ5' ,  144], ['AAQQ4' ,  144], ['AAQQ3' ,  144],
    ['AAQQ2' ,  144], ['AAKJJ' ,  144], ['AAQJJ' ,  144], ['AAJJT' ,  144],
    ['AAJJ9' ,  144], ['AAJJ8' ,  144], ['AAJJ7' ,  144], ['AAJJ6' ,  144],
    ['AAJJ5' ,  144], ['AAJJ4' ,  144], ['AAJJ3' ,  144], ['AAJJ2' ,  144],
    ['AAKTT' ,  144], ['AAQTT' ,  144], ['AAJTT' ,  144], ['AATT9' ,  144],
    ['AATT8' ,  144], ['AATT7' ,  144], ['AATT6' ,  144], ['AATT5' ,  144],
    ['AATT4' ,  144], ['AATT3' ,  144], ['AATT2' ,  144], ['AAK99' ,  144],
    ['AAQ99' ,  144], ['AAJ99' ,  144], ['AAT99' ,  144], ['AA998' ,  144],
    ['AA997' ,  144], ['AA996' ,  144], ['AA995' ,  144], ['AA994' ,  144],
    ['AA993' ,  144], ['AA992' ,  144], ['AAK88' ,  144], ['AAQ88' ,  144],
    ['AAJ88' ,  144], ['AAT88' ,  144], ['AA988' ,  144], ['AA887' ,  144],
    ['AA886' ,  144], ['AA885' ,  144], ['AA884' ,  144], ['AA883' ,  144],
    ['AA882' ,  144], ['AAK77' ,  144], ['AAQ77' ,  144], ['AAJ77' ,  144],
    ['AAT77' ,  144], ['AA977' ,  144], ['AA877' ,  144], ['AA776' ,  144],
    ['AA775' ,  144], ['AA774' ,  144], ['AA773' ,  144], ['AA772' ,  144],
    ['AAK66' ,  144], ['AAQ66' ,  144], ['AAJ66' ,  144], ['AAT66' ,  144],
    ['AA966' ,  144], ['AA866' ,  144], ['AA766' ,  144], ['AA665' ,  144],
    ['AA664' ,  144], ['AA663' ,  144], ['AA662' ,  144], ['AAK55' ,  144],
    ['AAQ55' ,  144], ['AAJ55' ,  144], ['AAT55' ,  144], ['AA955' ,  144],
    ['AA855' ,  144], ['AA755' ,  144], ['AA655' ,  144], ['AA554' ,  144],
    ['AA553' ,  144], ['AA552' ,  144], ['AAK44' ,  144], ['AAQ44' ,  144],
    ['AAJ44' ,  144], ['AAT44' ,  144], ['AA944' ,  144], ['AA844' ,  144],
    ['AA744' ,  144], ['AA644' ,  144], ['AA544' ,  144], ['AA443' ,  144],
    ['AA442' ,  144], ['AAK33' ,  144], ['AAQ33' ,  144], ['AAJ33' ,  144],
    ['AAT33' ,  144], ['AA933' ,  144], ['AA833' ,  144], ['AA733' ,  144],
    ['AA633' ,  144], ['AA533' ,  144], ['AA433' ,  144], ['AA332' ,  144],
    ['AAK22' ,  144], ['AAQ22' ,  144], ['AAJ22' ,  144], ['AAT22' ,  144],
    ['AA922' ,  144], ['AA822' ,  144], ['AA722' ,  144], ['AA622' ,  144],
    ['AA522' ,  144], ['AA422' ,  144], ['AA322' ,  144], ['AKKQQ' ,  144],
    ['KKQQJ' ,  144], ['KKQQT' ,  144], ['KKQQ9' ,  144], ['KKQQ8' ,  144],
    ['KKQQ7' ,  144], ['KKQQ6' ,  144], ['KKQQ5' ,  144], ['KKQQ4' ,  144],
    ['KKQQ3' ,  144], ['KKQQ2' ,  144], ['AKKJJ' ,  144], ['KKQJJ' ,  144],
    ['KKJJT' ,  144], ['KKJJ9' ,  144], ['KKJJ8' ,  144], ['KKJJ7' ,  144],
    ['KKJJ6' ,  144], ['KKJJ5' ,  144], ['KKJJ4' ,  144], ['KKJJ3' ,  144],
    ['KKJJ2' ,  144], ['AKKTT' ,  144], ['KKQTT' ,  144], ['KKJTT' ,  144],
    ['KKTT9' ,  144], ['KKTT8' ,  144], ['KKTT7' ,  144], ['KKTT6' ,  144],
    ['KKTT5' ,  144], ['KKTT4' ,  144], ['KKTT3' ,  144], ['KKTT2' ,  144],
    ['AKK99' ,  144], ['KKQ99' ,  144], ['KKJ99' ,  144], ['KKT99' ,  144],
    ['KK998' ,  144], ['KK997' ,  144], ['KK996' ,  144], ['KK995' ,  144],
    ['KK994' ,  144], ['KK993' ,  144], ['KK992' ,  144], ['AKK88' ,  144],
    ['KKQ88' ,  144], ['KKJ88' ,  144], ['KKT88' ,  144], ['KK988' ,  144],
    ['KK887' ,  144], ['KK886' ,  144], ['KK885' ,  144], ['KK884' ,  144],
    ['KK883' ,  144], ['KK882' ,  144], ['AKK77' ,  144], ['KKQ77' ,  144],
    ['KKJ77' ,  144], ['KKT77' ,  144], ['KK977' ,  144], ['KK877' ,  144],
    ['KK776' ,  144], ['KK775' ,  144], ['KK774' ,  144], ['KK773' ,  144],
    ['KK772' ,  144], ['AKK66' ,  144], ['KKQ66' ,  144], ['KKJ66' ,  144],
    ['KKT66' ,  144], ['KK966' ,  144], ['KK866' ,  144], ['KK766' ,  144],
    ['KK665' ,  144], ['KK664' ,  144], ['KK663' ,  144], ['KK662' ,  144],
    ['AKK55' ,  144], ['KKQ55' ,  144], ['KKJ55' ,  144], ['KKT55' ,  144],
    ['KK955' ,  144], ['KK855' ,  144], ['KK755' ,  144], ['KK655' ,  144],
    ['KK554' ,  144], ['KK553' ,  144], ['KK552' ,  144], ['AKK44' ,  144],
    ['KKQ44' ,  144], ['KKJ44' ,  144], ['KKT44' ,  144], ['KK944' ,  144],
    ['KK844' ,  144], ['KK744' ,  144], ['KK644' ,  144], ['KK544' ,  144],
    ['KK443' ,  144], ['KK442' ,  144], ['AKK33' ,  144], ['KKQ33' ,  144],
    ['KKJ33' ,  144], ['KKT33' ,  144], ['KK933' ,  144], ['KK833' ,  144],
    ['KK733' ,  144], ['KK633' ,  144], ['KK533' ,  144], ['KK433' ,  144],
    ['KK332' ,  144], ['AKK22' ,  144], ['KKQ22' ,  144], ['KKJ22' ,  144],
    ['KKT22' ,  144], ['KK922' ,  144], ['KK822' ,  144], ['KK722' ,  144],
    ['KK622' ,  144], ['KK522' ,  144], ['KK422' ,  144], ['KK322' ,  144],
    ['AQQJJ' ,  144], ['KQQJJ' ,  144], ['QQJJT' ,  144], ['QQJJ9' ,  144],
    ['QQJJ8' ,  144], ['QQJJ7' ,  144], ['QQJJ6' ,  144], ['QQJJ5' ,  144],
    ['QQJJ4' ,  144], ['QQJJ3' ,  144], ['QQJJ2' ,  144], ['AQQTT' ,  144],
    ['KQQTT' ,  144], ['QQJTT' ,  144], ['QQTT9' ,  144], ['QQTT8' ,  144],
    ['QQTT7' ,  144], ['QQTT6' ,  144], ['QQTT5' ,  144], ['QQTT4' ,  144],
    ['QQTT3' ,  144], ['QQTT2' ,  144], ['AQQ99' ,  144], ['KQQ99' ,  144],
    ['QQJ99' ,  144], ['QQT99' ,  144], ['QQ998' ,  144], ['QQ997' ,  144],
    ['QQ996' ,  144], ['QQ995' ,  144], ['QQ994' ,  144], ['QQ993' ,  144],
    ['QQ992' ,  144], ['AQQ88' ,  144], ['KQQ88' ,  144], ['QQJ88' ,  144],
    ['QQT88' ,  144], ['QQ988' ,  144], ['QQ887' ,  144], ['QQ886' ,  144],
    ['QQ885' ,  144], ['QQ884' ,  144], ['QQ883' ,  144], ['QQ882' ,  144],
    ['AQQ77' ,  144], ['KQQ77' ,  144], ['QQJ77' ,  144], ['QQT77' ,  144],
    ['QQ977' ,  144], ['QQ877' ,  144], ['QQ776' ,  144], ['QQ775' ,  144],
    ['QQ774' ,  144], ['QQ773' ,  144], ['QQ772' ,  144], ['AQQ66' ,  144],
    ['KQQ66' ,  144], ['QQJ66' ,  144], ['QQT66' ,  144], ['QQ966' ,  144],
    ['QQ866' ,  144], ['QQ766' ,  144], ['QQ665' ,  144], ['QQ664' ,  144],
    ['QQ663' ,  144], ['QQ662' ,  144], ['AQQ55' ,  144], ['KQQ55' ,  144],
    ['QQJ55' ,  144], ['QQT55' ,  144], ['QQ955' ,  144], ['QQ855' ,  144],
    ['QQ755' ,  144], ['QQ655' ,  144], ['QQ554' ,  144], ['QQ553' ,  144],
    ['QQ552' ,  144], ['AQQ44' ,  144], ['KQQ44' ,  144], ['QQJ44' ,  144],
    ['QQT44' ,  144], ['QQ944' ,  144], ['QQ844' ,  144], ['QQ744' ,  144],
    ['QQ644' ,  144], ['QQ544' ,  144], ['QQ443' ,  144], ['QQ442' ,  144],
    ['AQQ33' ,  144], ['KQQ33' ,  144], ['QQJ33' ,  144], ['QQT33' ,  144],
    ['QQ933' ,  144], ['QQ833' ,  144], ['QQ733' ,  144], ['QQ633' ,  144],
    ['QQ533' ,  144], ['QQ433' ,  144], ['QQ332' ,  144], ['AQQ22' ,  144],
    ['KQQ22' ,  144], ['QQJ22' ,  144], ['QQT22' ,  144], ['QQ922' ,  144],
    ['QQ822' ,  144], ['QQ722' ,  144], ['QQ622' ,  144], ['QQ522' ,  144],
    ['QQ422' ,  144], ['QQ322' ,  144], ['AJJTT' ,  144], ['KJJTT' ,  144],
    ['QJJTT' ,  144], ['JJTT9' ,  144], ['JJTT8' ,  144], ['JJTT7' ,  144],
    ['JJTT6' ,  144], ['JJTT5' ,  144], ['JJTT4' ,  144], ['JJTT3' ,  144],
    ['JJTT2' ,  144], ['AJJ99' ,  144], ['KJJ99' ,  144], ['QJJ99' ,  144],
    ['JJT99' ,  144], ['JJ998' ,  144], ['JJ997' ,  144], ['JJ996' ,  144],
    ['JJ995' ,  144], ['JJ994' ,  144], ['JJ993' ,  144], ['JJ992' ,  144],
    ['AJJ88' ,  144], ['KJJ88' ,  144], ['QJJ88' ,  144], ['JJT88' ,  144],
    ['JJ988' ,  144], ['JJ887' ,  144], ['JJ886' ,  144], ['JJ885' ,  144],
    ['JJ884' ,  144], ['JJ883' ,  144], ['JJ882' ,  144], ['AJJ77' ,  144],
    ['KJJ77' ,  144], ['QJJ77' ,  144], ['JJT77' ,  144], ['JJ977' ,  144],
    ['JJ877' ,  144], ['JJ776' ,  144], ['JJ775' ,  144], ['JJ774' ,  144],
    ['JJ773' ,  144], ['JJ772' ,  144], ['AJJ66' ,  144], ['KJJ66' ,  144],
    ['QJJ66' ,  144], ['JJT66' ,  144], ['JJ966' ,  144], ['JJ866' ,  144],
    ['JJ766' ,  144], ['JJ665' ,  144], ['JJ664' ,  144], ['JJ663' ,  144],
    ['JJ662' ,  144], ['AJJ55' ,  144], ['KJJ55' ,  144], ['QJJ55' ,  144],
    ['JJT55' ,  144], ['JJ955' ,  144], ['JJ855' ,  144], ['JJ755' ,  144],
    ['JJ655' ,  144], ['JJ554' ,  144], ['JJ553' ,  144], ['JJ552' ,  144],
    ['AJJ44' ,  144], ['KJJ44' ,  144], ['QJJ44' ,  144], ['JJT44' ,  144],
    ['JJ944' ,  144], ['JJ844' ,  144], ['JJ744' ,  144], ['JJ644' ,  144],
    ['JJ544' ,  144], ['JJ443' ,  144], ['JJ442' ,  144], ['AJJ33' ,  144],
    ['KJJ33' ,  144], ['QJJ33' ,  144], ['JJT33' ,  144], ['JJ933' ,  144],
    ['JJ833' ,  144], ['JJ733' ,  144], ['JJ633' ,  144], ['JJ533' ,  144],
    ['JJ433' ,  144], ['JJ332' ,  144], ['AJJ22' ,  144], ['KJJ22' ,  144],
    ['QJJ22' ,  144], ['JJT22' ,  144], ['JJ922' ,  144], ['JJ822' ,  144],
    ['JJ722' ,  144], ['JJ622' ,  144], ['JJ522' ,  144], ['JJ422' ,  144],
    ['JJ322' ,  144], ['ATT99' ,  144], ['KTT99' ,  144], ['QTT99' ,  144],
    ['JTT99' ,  144], ['TT998' ,  144], ['TT997' ,  144], ['TT996' ,  144],
    ['TT995' ,  144], ['TT994' ,  144], ['TT993' ,  144], ['TT992' ,  144],
    ['ATT88' ,  144], ['KTT88' ,  144], ['QTT88' ,  144], ['JTT88' ,  144],
    ['TT988' ,  144], ['TT887' ,  144], ['TT886' ,  144], ['TT885' ,  144],
    ['TT884' ,  144], ['TT883' ,  144], ['TT882' ,  144], ['ATT77' ,  144],
    ['KTT77' ,  144], ['QTT77' ,  144], ['JTT77' ,  144], ['TT977' ,  144],
    ['TT877' ,  144], ['TT776' ,  144], ['TT775' ,  144], ['TT774' ,  144],
    ['TT773' ,  144], ['TT772' ,  144], ['ATT66' ,  144], ['KTT66' ,  144],
    ['QTT66' ,  144], ['JTT66' ,  144], ['TT966' ,  144], ['TT866' ,  144],
    ['TT766' ,  144], ['TT665' ,  144], ['TT664' ,  144], ['TT663' ,  144],
    ['TT662' ,  144], ['ATT55' ,  144], ['KTT55' ,  144], ['QTT55' ,  144],
    ['JTT55' ,  144], ['TT955' ,  144], ['TT855' ,  144], ['TT755' ,  144],
    ['TT655' ,  144], ['TT554' ,  144], ['TT553' ,  144], ['TT552' ,  144],
    ['ATT44' ,  144], ['KTT44' ,  144], ['QTT44' ,  144], ['JTT44' ,  144],
    ['TT944' ,  144], ['TT844' ,  144], ['TT744' ,  144], ['TT644' ,  144],
    ['TT544' ,  144], ['TT443' ,  144], ['TT442' ,  144], ['ATT33' ,  144],
    ['KTT33' ,  144], ['QTT33' ,  144], ['JTT33' ,  144], ['TT933' ,  144],
    ['TT833' ,  144], ['TT733' ,  144], ['TT633' ,  144], ['TT533' ,  144],
    ['TT433' ,  144], ['TT332' ,  144], ['ATT22' ,  144], ['KTT22' ,  144],
    ['QTT22' ,  144], ['JTT22' ,  144], ['TT922' ,  144], ['TT822' ,  144],
    ['TT722' ,  144], ['TT622' ,  144], ['TT522' ,  144], ['TT422' ,  144],
    ['TT322' ,  144], ['A9988' ,  144], ['K9988' ,  144], ['Q9988' ,  144],
    ['J9988' ,  144], ['T9988' ,  144], ['99887' ,  144], ['99886' ,  144],
    ['99885' ,  144], ['99884' ,  144], ['99883' ,  144], ['99882' ,  144],
    ['A9977' ,  144], ['K9977' ,  144], ['Q9977' ,  144], ['J9977' ,  144],
    ['T9977' ,  144], ['99877' ,  144], ['99776' ,  144], ['99775' ,  144],
    ['99774' ,  144], ['99773' ,  144], ['99772' ,  144], ['A9966' ,  144],
    ['K9966' ,  144], ['Q9966' ,  144], ['J9966' ,  144], ['T9966' ,  144],
    ['99866' ,  144], ['99766' ,  144], ['99665' ,  144], ['99664' ,  144],
    ['99663' ,  144], ['99662' ,  144], ['A9955' ,  144], ['K9955' ,  144],
    ['Q9955' ,  144], ['J9955' ,  144], ['T9955' ,  144], ['99855' ,  144],
    ['99755' ,  144], ['99655' ,  144], ['99554' ,  144], ['99553' ,  144],
    ['99552' ,  144], ['A9944' ,  144], ['K9944' ,  144], ['Q9944' ,  144],
    ['J9944' ,  144], ['T9944' ,  144], ['99844' ,  144], ['99744' ,  144],
    ['99644' ,  144], ['99544' ,  144], ['99443' ,  144], ['99442' ,  144],
    ['A9933' ,  144], ['K9933' ,  144], ['Q9933' ,  144], ['J9933' ,  144],
    ['T9933' ,  144], ['99833' ,  144], ['99733' ,  144], ['99633' ,  144],
    ['99533' ,  144], ['99433' ,  144], ['99332' ,  144], ['A9922' ,  144],
    ['K9922' ,  144], ['Q9922' ,  144], ['J9922' ,  144], ['T9922' ,  144],
    ['99822' ,  144], ['99722' ,  144], ['99622' ,  144], ['99522' ,  144],
    ['99422' ,  144], ['99322' ,  144], ['A8877' ,  144], ['K8877' ,  144],
    ['Q8877' ,  144], ['J8877' ,  144], ['T8877' ,  144], ['98877' ,  144],
    ['88776' ,  144], ['88775' ,  144], ['88774' ,  144], ['88773' ,  144],
    ['88772' ,  144], ['A8866' ,  144], ['K8866' ,  144], ['Q8866' ,  144],
    ['J8866' ,  144], ['T8866' ,  144], ['98866' ,  144], ['88766' ,  144],
    ['88665' ,  144], ['88664' ,  144], ['88663' ,  144], ['88662' ,  144],
    ['A8855' ,  144], ['K8855' ,  144], ['Q8855' ,  144], ['J8855' ,  144],
    ['T8855' ,  144], ['98855' ,  144], ['88755' ,  144], ['88655' ,  144],
    ['88554' ,  144], ['88553' ,  144], ['88552' ,  144], ['A8844' ,  144],
    ['K8844' ,  144], ['Q8844' ,  144], ['J8844' ,  144], ['T8844' ,  144],
    ['98844' ,  144], ['88744' ,  144], ['88644' ,  144], ['88544' ,  144],
    ['88443' ,  144], ['88442' ,  144], ['A8833' ,  144], ['K8833' ,  144],
    ['Q8833' ,  144], ['J8833' ,  144], ['T8833' ,  144], ['98833' ,  144],
    ['88733' ,  144], ['88633' ,  144], ['88533' ,  144], ['88433' ,  144],
    ['88332' ,  144], ['A8822' ,  144], ['K8822' ,  144], ['Q8822' ,  144],
    ['J8822' ,  144], ['T8822' ,  144], ['98822' ,  144], ['88722' ,  144],
    ['88622' ,  144], ['88522' ,  144], ['88422' ,  144], ['88322' ,  144],
    ['A7766' ,  144], ['K7766' ,  144], ['Q7766' ,  144], ['J7766' ,  144],
    ['T7766' ,  144], ['97766' ,  144], ['87766' ,  144], ['77665' ,  144],
    ['77664' ,  144], ['77663' ,  144], ['77662' ,  144], ['A7755' ,  144],
    ['K7755' ,  144], ['Q7755' ,  144], ['J7755' ,  144], ['T7755' ,  144],
    ['97755' ,  144], ['87755' ,  144], ['77655' ,  144], ['77554' ,  144],
    ['77553' ,  144], ['77552' ,  144], ['A7744' ,  144], ['K7744' ,  144],
    ['Q7744' ,  144], ['J7744' ,  144], ['T7744' ,  144], ['97744' ,  144],
    ['87744' ,  144], ['77644' ,  144], ['77544' ,  144], ['77443' ,  144],
    ['77442' ,  144], ['A7733' ,  144], ['K7733' ,  144], ['Q7733' ,  144],
    ['J7733' ,  144], ['T7733' ,  144], ['97733' ,  144], ['87733' ,  144],
    ['77633' ,  144], ['77533' ,  144], ['77433' ,  144], ['77332' ,  144],
    ['A7722' ,  144], ['K7722' ,  144], ['Q7722' ,  144], ['J7722' ,  144],
    ['T7722' ,  144], ['97722' ,  144], ['87722' ,  144], ['77622' ,  144],
    ['77522' ,  144], ['77422' ,  144], ['77322' ,  144], ['A6655' ,  144],
    ['K6655' ,  144], ['Q6655' ,  144], ['J6655' ,  144], ['T6655' ,  144],
    ['96655' ,  144], ['86655' ,  144], ['76655' ,  144], ['66554' ,  144],
    ['66553' ,  144], ['66552' ,  144], ['A6644' ,  144], ['K6644' ,  144],
    ['Q6644' ,  144], ['J6644' ,  144], ['T6644' ,  144], ['96644' ,  144],
    ['86644' ,  144], ['76644' ,  144], ['66544' ,  144], ['66443' ,  144],
    ['66442' ,  144], ['A6633' ,  144], ['K6633' ,  144], ['Q6633' ,  144],
    ['J6633' ,  144], ['T6633' ,  144], ['96633' ,  144], ['86633' ,  144],
    ['76633' ,  144], ['66533' ,  144], ['66433' ,  144], ['66332' ,  144],
    ['A6622' ,  144], ['K6622' ,  144], ['Q6622' ,  144], ['J6622' ,  144],
    ['T6622' ,  144], ['96622' ,  144], ['86622' ,  144], ['76622' ,  144],
    ['66522' ,  144], ['66422' ,  144], ['66322' ,  144], ['A5544' ,  144],
    ['K5544' ,  144], ['Q5544' ,  144], ['J5544' ,  144], ['T5544' ,  144],
    ['95544' ,  144], ['85544' ,  144], ['75544' ,  144], ['65544' ,  144],
    ['55443' ,  144], ['55442' ,  144], ['A5533' ,  144], ['K5533' ,  144],
    ['Q5533' ,  144], ['J5533' ,  144], ['T5533' ,  144], ['95533' ,  144],
    ['85533' ,  144], ['75533' ,  144], ['65533' ,  144], ['55433' ,  144],
    ['55332' ,  144], ['A5522' ,  144], ['K5522' ,  144], ['Q5522' ,  144],
    ['J5522' ,  144], ['T5522' ,  144], ['95522' ,  144], ['85522' ,  144],
    ['75522' ,  144], ['65522' ,  144], ['55422' ,  144], ['55322' ,  144],
    ['A4433' ,  144], ['K4433' ,  144], ['Q4433' ,  144], ['J4433' ,  144],
    ['T4433' ,  144], ['94433' ,  144], ['84433' ,  144], ['74433' ,  144],
    ['64433' ,  144], ['54433' ,  144], ['44332' ,  144], ['A4422' ,  144],
    ['K4422' ,  144], ['Q4422' ,  144], ['J4422' ,  144], ['T4422' ,  144],
    ['94422' ,  144], ['84422' ,  144], ['74422' ,  144], ['64422' ,  144],
    ['54422' ,  144], ['44322' ,  144], ['A3322' ,  144], ['K3322' ,  144],
    ['Q3322' ,  144], ['J3322' ,  144], ['T3322' ,  144], ['93322' ,  144],
    ['83322' ,  144], ['73322' ,  144], ['63322' ,  144], ['53322' ,  144],
    ['43322' ,  144], ['AAKQJ' ,  384], ['AAKQT' ,  384], ['AAKQ9' ,  384],
    ['AAKQ8' ,  384], ['AAKQ7' ,  384], ['AAKQ6' ,  384], ['AAKQ5' ,  384],
    ['AAKQ4' ,  384], ['AAKQ3' ,  384], ['AAKQ2' ,  384], ['AAKJT' ,  384],
    ['AAKJ9' ,  384], ['AAKJ8' ,  384], ['AAKJ7' ,  384], ['AAKJ6' ,  384],
    ['AAKJ5' ,  384], ['AAKJ4' ,  384], ['AAKJ3' ,  384], ['AAKJ2' ,  384],
    ['AAKT9' ,  384], ['AAKT8' ,  384], ['AAKT7' ,  384], ['AAKT6' ,  384],
    ['AAKT5' ,  384], ['AAKT4' ,  384], ['AAKT3' ,  384], ['AAKT2' ,  384],
    ['AAK98' ,  384], ['AAK97' ,  384], ['AAK96' ,  384], ['AAK95' ,  384],
    ['AAK94' ,  384], ['AAK93' ,  384], ['AAK92' ,  384], ['AAK87' ,  384],
    ['AAK86' ,  384], ['AAK85' ,  384], ['AAK84' ,  384], ['AAK83' ,  384],
    ['AAK82' ,  384], ['AAK76' ,  384], ['AAK75' ,  384], ['AAK74' ,  384],
    ['AAK73' ,  384], ['AAK72' ,  384], ['AAK65' ,  384], ['AAK64' ,  384],
    ['AAK63' ,  384], ['AAK62' ,  384], ['AAK54' ,  384], ['AAK53' ,  384],
    ['AAK52' ,  384], ['AAK43' ,  384], ['AAK42' ,  384], ['AAK32' ,  384],
    ['AAQJT' ,  384], ['AAQJ9' ,  384], ['AAQJ8' ,  384], ['AAQJ7' ,  384],
    ['AAQJ6' ,  384], ['AAQJ5' ,  384], ['AAQJ4' ,  384], ['AAQJ3' ,  384],
    ['AAQJ2' ,  384], ['AAQT9' ,  384], ['AAQT8' ,  384], ['AAQT7' ,  384],
    ['AAQT6' ,  384], ['AAQT5' ,  384], ['AAQT4' ,  384], ['AAQT3' ,  384],
    ['AAQT2' ,  384], ['AAQ98' ,  384], ['AAQ97' ,  384], ['AAQ96' ,  384],
    ['AAQ95' ,  384], ['AAQ94' ,  384], ['AAQ93' ,  384], ['AAQ92' ,  384],
    ['AAQ87' ,  384], ['AAQ86' ,  384], ['AAQ85' ,  384], ['AAQ84' ,  384],
    ['AAQ83' ,  384], ['AAQ82' ,  384], ['AAQ76' ,  384], ['AAQ75' ,  384],
    ['AAQ74' ,  384], ['AAQ73' ,  384], ['AAQ72' ,  384], ['AAQ65' ,  384],
    ['AAQ64' ,  384], ['AAQ63' ,  384], ['AAQ62' ,  384], ['AAQ54' ,  384],
    ['AAQ53' ,  384], ['AAQ52' ,  384], ['AAQ43' ,  384], ['AAQ42' ,  384],
    ['AAQ32' ,  384], ['AAJT9' ,  384], ['AAJT8' ,  384], ['AAJT7' ,  384],
    ['AAJT6' ,  384], ['AAJT5' ,  384], ['AAJT4' ,  384], ['AAJT3' ,  384],
    ['AAJT2' ,  384], ['AAJ98' ,  384], ['AAJ97' ,  384], ['AAJ96' ,  384],
    ['AAJ95' ,  384], ['AAJ94' ,  384], ['AAJ93' ,  384], ['AAJ92' ,  384],
    ['AAJ87' ,  384], ['AAJ86' ,  384], ['AAJ85' ,  384], ['AAJ84' ,  384],
    ['AAJ83' ,  384], ['AAJ82' ,  384], ['AAJ76' ,  384], ['AAJ75' ,  384],
    ['AAJ74' ,  384], ['AAJ73' ,  384], ['AAJ72' ,  384], ['AAJ65' ,  384],
    ['AAJ64' ,  384], ['AAJ63' ,  384], ['AAJ62' ,  384], ['AAJ54' ,  384],
    ['AAJ53' ,  384], ['AAJ52' ,  384], ['AAJ43' ,  384], ['AAJ42' ,  384],
    ['AAJ32' ,  384], ['AAT98' ,  384], ['AAT97' ,  384], ['AAT96' ,  384],
    ['AAT95' ,  384], ['AAT94' ,  384], ['AAT93' ,  384], ['AAT92' ,  384],
    ['AAT87' ,  384], ['AAT86' ,  384], ['AAT85' ,  384], ['AAT84' ,  384],
    ['AAT83' ,  384], ['AAT82' ,  384], ['AAT76' ,  384], ['AAT75' ,  384],
    ['AAT74' ,  384], ['AAT73' ,  384], ['AAT72' ,  384], ['AAT65' ,  384],
    ['AAT64' ,  384], ['AAT63' ,  384], ['AAT62' ,  384], ['AAT54' ,  384],
    ['AAT53' ,  384], ['AAT52' ,  384], ['AAT43' ,  384], ['AAT42' ,  384],
    ['AAT32' ,  384], ['AA987' ,  384], ['AA986' ,  384], ['AA985' ,  384],
    ['AA984' ,  384], ['AA983' ,  384], ['AA982' ,  384], ['AA976' ,  384],
    ['AA975' ,  384], ['AA974' ,  384], ['AA973' ,  384], ['AA972' ,  384],
    ['AA965' ,  384], ['AA964' ,  384], ['AA963' ,  384], ['AA962' ,  384],
    ['AA954' ,  384], ['AA953' ,  384], ['AA952' ,  384], ['AA943' ,  384],
    ['AA942' ,  384], ['AA932' ,  384], ['AA876' ,  384], ['AA875' ,  384],
    ['AA874' ,  384], ['AA873' ,  384], ['AA872' ,  384], ['AA865' ,  384],
    ['AA864' ,  384], ['AA863' ,  384], ['AA862' ,  384], ['AA854' ,  384],
    ['AA853' ,  384], ['AA852' ,  384], ['AA843' ,  384], ['AA842' ,  384],
    ['AA832' ,  384], ['AA765' ,  384], ['AA764' ,  384], ['AA763' ,  384],
    ['AA762' ,  384], ['AA754' ,  384], ['AA753' ,  384], ['AA752' ,  384],
    ['AA743' ,  384], ['AA742' ,  384], ['AA732' ,  384], ['AA654' ,  384],
    ['AA653' ,  384], ['AA652' ,  384], ['AA643' ,  384], ['AA642' ,  384],
    ['AA632' ,  384], ['AA543' ,  384], ['AA542' ,  384], ['AA532' ,  384],
    ['AA432' ,  384], ['AKKQJ' ,  384], ['AKKQT' ,  384], ['AKKQ9' ,  384],
    ['AKKQ8' ,  384], ['AKKQ7' ,  384], ['AKKQ6' ,  384], ['AKKQ5' ,  384],
    ['AKKQ4' ,  384], ['AKKQ3' ,  384], ['AKKQ2' ,  384], ['AKKJT' ,  384],
    ['AKKJ9' ,  384], ['AKKJ8' ,  384], ['AKKJ7' ,  384], ['AKKJ6' ,  384],
    ['AKKJ5' ,  384], ['AKKJ4' ,  384], ['AKKJ3' ,  384], ['AKKJ2' ,  384],
    ['AKKT9' ,  384], ['AKKT8' ,  384], ['AKKT7' ,  384], ['AKKT6' ,  384],
    ['AKKT5' ,  384], ['AKKT4' ,  384], ['AKKT3' ,  384], ['AKKT2' ,  384],
    ['AKK98' ,  384], ['AKK97' ,  384], ['AKK96' ,  384], ['AKK95' ,  384],
    ['AKK94' ,  384], ['AKK93' ,  384], ['AKK92' ,  384], ['AKK87' ,  384],
    ['AKK86' ,  384], ['AKK85' ,  384], ['AKK84' ,  384], ['AKK83' ,  384],
    ['AKK82' ,  384], ['AKK76' ,  384], ['AKK75' ,  384], ['AKK74' ,  384],
    ['AKK73' ,  384], ['AKK72' ,  384], ['AKK65' ,  384], ['AKK64' ,  384],
    ['AKK63' ,  384], ['AKK62' ,  384], ['AKK54' ,  384], ['AKK53' ,  384],
    ['AKK52' ,  384], ['AKK43' ,  384], ['AKK42' ,  384], ['AKK32' ,  384],
    ['KKQJT' ,  384], ['KKQJ9' ,  384], ['KKQJ8' ,  384], ['KKQJ7' ,  384],
    ['KKQJ6' ,  384], ['KKQJ5' ,  384], ['KKQJ4' ,  384], ['KKQJ3' ,  384],
    ['KKQJ2' ,  384], ['KKQT9' ,  384], ['KKQT8' ,  384], ['KKQT7' ,  384],
    ['KKQT6' ,  384], ['KKQT5' ,  384], ['KKQT4' ,  384], ['KKQT3' ,  384],
    ['KKQT2' ,  384], ['KKQ98' ,  384], ['KKQ97' ,  384], ['KKQ96' ,  384],
    ['KKQ95' ,  384], ['KKQ94' ,  384], ['KKQ93' ,  384], ['KKQ92' ,  384],
    ['KKQ87' ,  384], ['KKQ86' ,  384], ['KKQ85' ,  384], ['KKQ84' ,  384],
    ['KKQ83' ,  384], ['KKQ82' ,  384], ['KKQ76' ,  384], ['KKQ75' ,  384],
    ['KKQ74' ,  384], ['KKQ73' ,  384], ['KKQ72' ,  384], ['KKQ65' ,  384],
    ['KKQ64' ,  384], ['KKQ63' ,  384], ['KKQ62' ,  384], ['KKQ54' ,  384],
    ['KKQ53' ,  384], ['KKQ52' ,  384], ['KKQ43' ,  384], ['KKQ42' ,  384],
    ['KKQ32' ,  384], ['KKJT9' ,  384], ['KKJT8' ,  384], ['KKJT7' ,  384],
    ['KKJT6' ,  384], ['KKJT5' ,  384], ['KKJT4' ,  384], ['KKJT3' ,  384],
    ['KKJT2' ,  384], ['KKJ98' ,  384], ['KKJ97' ,  384], ['KKJ96' ,  384],
    ['KKJ95' ,  384], ['KKJ94' ,  384], ['KKJ93' ,  384], ['KKJ92' ,  384],
    ['KKJ87' ,  384], ['KKJ86' ,  384], ['KKJ85' ,  384], ['KKJ84' ,  384],
    ['KKJ83' ,  384], ['KKJ82' ,  384], ['KKJ76' ,  384], ['KKJ75' ,  384],
    ['KKJ74' ,  384], ['KKJ73' ,  384], ['KKJ72' ,  384], ['KKJ65' ,  384],
    ['KKJ64' ,  384], ['KKJ63' ,  384], ['KKJ62' ,  384], ['KKJ54' ,  384],
    ['KKJ53' ,  384], ['KKJ52' ,  384], ['KKJ43' ,  384], ['KKJ42' ,  384],
    ['KKJ32' ,  384], ['KKT98' ,  384], ['KKT97' ,  384], ['KKT96' ,  384],
    ['KKT95' ,  384], ['KKT94' ,  384], ['KKT93' ,  384], ['KKT92' ,  384],
    ['KKT87' ,  384], ['KKT86' ,  384], ['KKT85' ,  384], ['KKT84' ,  384],
    ['KKT83' ,  384], ['KKT82' ,  384], ['KKT76' ,  384], ['KKT75' ,  384],
    ['KKT74' ,  384], ['KKT73' ,  384], ['KKT72' ,  384], ['KKT65' ,  384],
    ['KKT64' ,  384], ['KKT63' ,  384], ['KKT62' ,  384], ['KKT54' ,  384],
    ['KKT53' ,  384], ['KKT52' ,  384], ['KKT43' ,  384], ['KKT42' ,  384],
    ['KKT32' ,  384], ['KK987' ,  384], ['KK986' ,  384], ['KK985' ,  384],
    ['KK984' ,  384], ['KK983' ,  384], ['KK982' ,  384], ['KK976' ,  384],
    ['KK975' ,  384], ['KK974' ,  384], ['KK973' ,  384], ['KK972' ,  384],
    ['KK965' ,  384], ['KK964' ,  384], ['KK963' ,  384], ['KK962' ,  384],
    ['KK954' ,  384], ['KK953' ,  384], ['KK952' ,  384], ['KK943' ,  384],
    ['KK942' ,  384], ['KK932' ,  384], ['KK876' ,  384], ['KK875' ,  384],
    ['KK874' ,  384], ['KK873' ,  384], ['KK872' ,  384], ['KK865' ,  384],
    ['KK864' ,  384], ['KK863' ,  384], ['KK862' ,  384], ['KK854' ,  384],
    ['KK853' ,  384], ['KK852' ,  384], ['KK843' ,  384], ['KK842' ,  384],
    ['KK832' ,  384], ['KK765' ,  384], ['KK764' ,  384], ['KK763' ,  384],
    ['KK762' ,  384], ['KK754' ,  384], ['KK753' ,  384], ['KK752' ,  384],
    ['KK743' ,  384], ['KK742' ,  384], ['KK732' ,  384], ['KK654' ,  384],
    ['KK653' ,  384], ['KK652' ,  384], ['KK643' ,  384], ['KK642' ,  384],
    ['KK632' ,  384], ['KK543' ,  384], ['KK542' ,  384], ['KK532' ,  384],
    ['KK432' ,  384], ['AKQQJ' ,  384], ['AKQQT' ,  384], ['AKQQ9' ,  384],
    ['AKQQ8' ,  384], ['AKQQ7' ,  384], ['AKQQ6' ,  384], ['AKQQ5' ,  384],
    ['AKQQ4' ,  384], ['AKQQ3' ,  384], ['AKQQ2' ,  384], ['AQQJT' ,  384],
    ['AQQJ9' ,  384], ['AQQJ8' ,  384], ['AQQJ7' ,  384], ['AQQJ6' ,  384],
    ['AQQJ5' ,  384], ['AQQJ4' ,  384], ['AQQJ3' ,  384], ['AQQJ2' ,  384],
    ['AQQT9' ,  384], ['AQQT8' ,  384], ['AQQT7' ,  384], ['AQQT6' ,  384],
    ['AQQT5' ,  384], ['AQQT4' ,  384], ['AQQT3' ,  384], ['AQQT2' ,  384],
    ['AQQ98' ,  384], ['AQQ97' ,  384], ['AQQ96' ,  384], ['AQQ95' ,  384],
    ['AQQ94' ,  384], ['AQQ93' ,  384], ['AQQ92' ,  384], ['AQQ87' ,  384],
    ['AQQ86' ,  384], ['AQQ85' ,  384], ['AQQ84' ,  384], ['AQQ83' ,  384],
    ['AQQ82' ,  384], ['AQQ76' ,  384], ['AQQ75' ,  384], ['AQQ74' ,  384],
    ['AQQ73' ,  384], ['AQQ72' ,  384], ['AQQ65' ,  384], ['AQQ64' ,  384],
    ['AQQ63' ,  384], ['AQQ62' ,  384], ['AQQ54' ,  384], ['AQQ53' ,  384],
    ['AQQ52' ,  384], ['AQQ43' ,  384], ['AQQ42' ,  384], ['AQQ32' ,  384],
    ['KQQJT' ,  384], ['KQQJ9' ,  384], ['KQQJ8' ,  384], ['KQQJ7' ,  384],
    ['KQQJ6' ,  384], ['KQQJ5' ,  384], ['KQQJ4' ,  384], ['KQQJ3' ,  384],
    ['KQQJ2' ,  384], ['KQQT9' ,  384], ['KQQT8' ,  384], ['KQQT7' ,  384],
    ['KQQT6' ,  384], ['KQQT5' ,  384], ['KQQT4' ,  384], ['KQQT3' ,  384],
    ['KQQT2' ,  384], ['KQQ98' ,  384], ['KQQ97' ,  384], ['KQQ96' ,  384],
    ['KQQ95' ,  384], ['KQQ94' ,  384], ['KQQ93' ,  384], ['KQQ92' ,  384],
    ['KQQ87' ,  384], ['KQQ86' ,  384], ['KQQ85' ,  384], ['KQQ84' ,  384],
    ['KQQ83' ,  384], ['KQQ82' ,  384], ['KQQ76' ,  384], ['KQQ75' ,  384],
    ['KQQ74' ,  384], ['KQQ73' ,  384], ['KQQ72' ,  384], ['KQQ65' ,  384],
    ['KQQ64' ,  384], ['KQQ63' ,  384], ['KQQ62' ,  384], ['KQQ54' ,  384],
    ['KQQ53' ,  384], ['KQQ52' ,  384], ['KQQ43' ,  384], ['KQQ42' ,  384],
    ['KQQ32' ,  384], ['QQJT9' ,  384], ['QQJT8' ,  384], ['QQJT7' ,  384],
    ['QQJT6' ,  384], ['QQJT5' ,  384], ['QQJT4' ,  384], ['QQJT3' ,  384],
    ['QQJT2' ,  384], ['QQJ98' ,  384], ['QQJ97' ,  384], ['QQJ96' ,  384],
    ['QQJ95' ,  384], ['QQJ94' ,  384], ['QQJ93' ,  384], ['QQJ92' ,  384],
    ['QQJ87' ,  384], ['QQJ86' ,  384], ['QQJ85' ,  384], ['QQJ84' ,  384],
    ['QQJ83' ,  384], ['QQJ82' ,  384], ['QQJ76' ,  384], ['QQJ75' ,  384],
    ['QQJ74' ,  384], ['QQJ73' ,  384], ['QQJ72' ,  384], ['QQJ65' ,  384],
    ['QQJ64' ,  384], ['QQJ63' ,  384], ['QQJ62' ,  384], ['QQJ54' ,  384],
    ['QQJ53' ,  384], ['QQJ52' ,  384], ['QQJ43' ,  384], ['QQJ42' ,  384],
    ['QQJ32' ,  384], ['QQT98' ,  384], ['QQT97' ,  384], ['QQT96' ,  384],
    ['QQT95' ,  384], ['QQT94' ,  384], ['QQT93' ,  384], ['QQT92' ,  384],
    ['QQT87' ,  384], ['QQT86' ,  384], ['QQT85' ,  384], ['QQT84' ,  384],
    ['QQT83' ,  384], ['QQT82' ,  384], ['QQT76' ,  384], ['QQT75' ,  384],
    ['QQT74' ,  384], ['QQT73' ,  384], ['QQT72' ,  384], ['QQT65' ,  384],
    ['QQT64' ,  384], ['QQT63' ,  384], ['QQT62' ,  384], ['QQT54' ,  384],
    ['QQT53' ,  384], ['QQT52' ,  384], ['QQT43' ,  384], ['QQT42' ,  384],
    ['QQT32' ,  384], ['QQ987' ,  384], ['QQ986' ,  384], ['QQ985' ,  384],
    ['QQ984' ,  384], ['QQ983' ,  384], ['QQ982' ,  384], ['QQ976' ,  384],
    ['QQ975' ,  384], ['QQ974' ,  384], ['QQ973' ,  384], ['QQ972' ,  384],
    ['QQ965' ,  384], ['QQ964' ,  384], ['QQ963' ,  384], ['QQ962' ,  384],
    ['QQ954' ,  384], ['QQ953' ,  384], ['QQ952' ,  384], ['QQ943' ,  384],
    ['QQ942' ,  384], ['QQ932' ,  384], ['QQ876' ,  384], ['QQ875' ,  384],
    ['QQ874' ,  384], ['QQ873' ,  384], ['QQ872' ,  384], ['QQ865' ,  384],
    ['QQ864' ,  384], ['QQ863' ,  384], ['QQ862' ,  384], ['QQ854' ,  384],
    ['QQ853' ,  384], ['QQ852' ,  384], ['QQ843' ,  384], ['QQ842' ,  384],
    ['QQ832' ,  384], ['QQ765' ,  384], ['QQ764' ,  384], ['QQ763' ,  384],
    ['QQ762' ,  384], ['QQ754' ,  384], ['QQ753' ,  384], ['QQ752' ,  384],
    ['QQ743' ,  384], ['QQ742' ,  384], ['QQ732' ,  384], ['QQ654' ,  384],
    ['QQ653' ,  384], ['QQ652' ,  384], ['QQ643' ,  384], ['QQ642' ,  384],
    ['QQ632' ,  384], ['QQ543' ,  384], ['QQ542' ,  384], ['QQ532' ,  384],
    ['QQ432' ,  384], ['AKQJJ' ,  384], ['AKJJT' ,  384], ['AKJJ9' ,  384],
    ['AKJJ8' ,  384], ['AKJJ7' ,  384], ['AKJJ6' ,  384], ['AKJJ5' ,  384],
    ['AKJJ4' ,  384], ['AKJJ3' ,  384], ['AKJJ2' ,  384], ['AQJJT' ,  384],
    ['AQJJ9' ,  384], ['AQJJ8' ,  384], ['AQJJ7' ,  384], ['AQJJ6' ,  384],
    ['AQJJ5' ,  384], ['AQJJ4' ,  384], ['AQJJ3' ,  384], ['AQJJ2' ,  384],
    ['AJJT9' ,  384], ['AJJT8' ,  384], ['AJJT7' ,  384], ['AJJT6' ,  384],
    ['AJJT5' ,  384], ['AJJT4' ,  384], ['AJJT3' ,  384], ['AJJT2' ,  384],
    ['AJJ98' ,  384], ['AJJ97' ,  384], ['AJJ96' ,  384], ['AJJ95' ,  384],
    ['AJJ94' ,  384], ['AJJ93' ,  384], ['AJJ92' ,  384], ['AJJ87' ,  384],
    ['AJJ86' ,  384], ['AJJ85' ,  384], ['AJJ84' ,  384], ['AJJ83' ,  384],
    ['AJJ82' ,  384], ['AJJ76' ,  384], ['AJJ75' ,  384], ['AJJ74' ,  384],
    ['AJJ73' ,  384], ['AJJ72' ,  384], ['AJJ65' ,  384], ['AJJ64' ,  384],
    ['AJJ63' ,  384], ['AJJ62' ,  384], ['AJJ54' ,  384], ['AJJ53' ,  384],
    ['AJJ52' ,  384], ['AJJ43' ,  384], ['AJJ42' ,  384], ['AJJ32' ,  384],
    ['KQJJT' ,  384], ['KQJJ9' ,  384], ['KQJJ8' ,  384], ['KQJJ7' ,  384],
    ['KQJJ6' ,  384], ['KQJJ5' ,  384], ['KQJJ4' ,  384], ['KQJJ3' ,  384],
    ['KQJJ2' ,  384], ['KJJT9' ,  384], ['KJJT8' ,  384], ['KJJT7' ,  384],
    ['KJJT6' ,  384], ['KJJT5' ,  384], ['KJJT4' ,  384], ['KJJT3' ,  384],
    ['KJJT2' ,  384], ['KJJ98' ,  384], ['KJJ97' ,  384], ['KJJ96' ,  384],
    ['KJJ95' ,  384], ['KJJ94' ,  384], ['KJJ93' ,  384], ['KJJ92' ,  384],
    ['KJJ87' ,  384], ['KJJ86' ,  384], ['KJJ85' ,  384], ['KJJ84' ,  384],
    ['KJJ83' ,  384], ['KJJ82' ,  384], ['KJJ76' ,  384], ['KJJ75' ,  384],
    ['KJJ74' ,  384], ['KJJ73' ,  384], ['KJJ72' ,  384], ['KJJ65' ,  384],
    ['KJJ64' ,  384], ['KJJ63' ,  384], ['KJJ62' ,  384], ['KJJ54' ,  384],
    ['KJJ53' ,  384], ['KJJ52' ,  384], ['KJJ43' ,  384], ['KJJ42' ,  384],
    ['KJJ32' ,  384], ['QJJT9' ,  384], ['QJJT8' ,  384], ['QJJT7' ,  384],
    ['QJJT6' ,  384], ['QJJT5' ,  384], ['QJJT4' ,  384], ['QJJT3' ,  384],
    ['QJJT2' ,  384], ['QJJ98' ,  384], ['QJJ97' ,  384], ['QJJ96' ,  384],
    ['QJJ95' ,  384], ['QJJ94' ,  384], ['QJJ93' ,  384], ['QJJ92' ,  384],
    ['QJJ87' ,  384], ['QJJ86' ,  384], ['QJJ85' ,  384], ['QJJ84' ,  384],
    ['QJJ83' ,  384], ['QJJ82' ,  384], ['QJJ76' ,  384], ['QJJ75' ,  384],
    ['QJJ74' ,  384], ['QJJ73' ,  384], ['QJJ72' ,  384], ['QJJ65' ,  384],
    ['QJJ64' ,  384], ['QJJ63' ,  384], ['QJJ62' ,  384], ['QJJ54' ,  384],
    ['QJJ53' ,  384], ['QJJ52' ,  384], ['QJJ43' ,  384], ['QJJ42' ,  384],
    ['QJJ32' ,  384], ['JJT98' ,  384], ['JJT97' ,  384], ['JJT96' ,  384],
    ['JJT95' ,  384], ['JJT94' ,  384], ['JJT93' ,  384], ['JJT92' ,  384],
    ['JJT87' ,  384], ['JJT86' ,  384], ['JJT85' ,  384], ['JJT84' ,  384],
    ['JJT83' ,  384], ['JJT82' ,  384], ['JJT76' ,  384], ['JJT75' ,  384],
    ['JJT74' ,  384], ['JJT73' ,  384], ['JJT72' ,  384], ['JJT65' ,  384],
    ['JJT64' ,  384], ['JJT63' ,  384], ['JJT62' ,  384], ['JJT54' ,  384],
    ['JJT53' ,  384], ['JJT52' ,  384], ['JJT43' ,  384], ['JJT42' ,  384],
    ['JJT32' ,  384], ['JJ987' ,  384], ['JJ986' ,  384], ['JJ985' ,  384],
    ['JJ984' ,  384], ['JJ983' ,  384], ['JJ982' ,  384], ['JJ976' ,  384],
    ['JJ975' ,  384], ['JJ974' ,  384], ['JJ973' ,  384], ['JJ972' ,  384],
    ['JJ965' ,  384], ['JJ964' ,  384], ['JJ963' ,  384], ['JJ962' ,  384],
    ['JJ954' ,  384], ['JJ953' ,  384], ['JJ952' ,  384], ['JJ943' ,  384],
    ['JJ942' ,  384], ['JJ932' ,  384], ['JJ876' ,  384], ['JJ875' ,  384],
    ['JJ874' ,  384], ['JJ873' ,  384], ['JJ872' ,  384], ['JJ865' ,  384],
    ['JJ864' ,  384], ['JJ863' ,  384], ['JJ862' ,  384], ['JJ854' ,  384],
    ['JJ853' ,  384], ['JJ852' ,  384], ['JJ843' ,  384], ['JJ842' ,  384],
    ['JJ832' ,  384], ['JJ765' ,  384], ['JJ764' ,  384], ['JJ763' ,  384],
    ['JJ762' ,  384], ['JJ754' ,  384], ['JJ753' ,  384], ['JJ752' ,  384],
    ['JJ743' ,  384], ['JJ742' ,  384], ['JJ732' ,  384], ['JJ654' ,  384],
    ['JJ653' ,  384], ['JJ652' ,  384], ['JJ643' ,  384], ['JJ642' ,  384],
    ['JJ632' ,  384], ['JJ543' ,  384], ['JJ542' ,  384], ['JJ532' ,  384],
    ['JJ432' ,  384], ['AKQTT' ,  384], ['AKJTT' ,  384], ['AKTT9' ,  384],
    ['AKTT8' ,  384], ['AKTT7' ,  384], ['AKTT6' ,  384], ['AKTT5' ,  384],
    ['AKTT4' ,  384], ['AKTT3' ,  384], ['AKTT2' ,  384], ['AQJTT' ,  384],
    ['AQTT9' ,  384], ['AQTT8' ,  384], ['AQTT7' ,  384], ['AQTT6' ,  384],
    ['AQTT5' ,  384], ['AQTT4' ,  384], ['AQTT3' ,  384], ['AQTT2' ,  384],
    ['AJTT9' ,  384], ['AJTT8' ,  384], ['AJTT7' ,  384], ['AJTT6' ,  384],
    ['AJTT5' ,  384], ['AJTT4' ,  384], ['AJTT3' ,  384], ['AJTT2' ,  384],
    ['ATT98' ,  384], ['ATT97' ,  384], ['ATT96' ,  384], ['ATT95' ,  384],
    ['ATT94' ,  384], ['ATT93' ,  384], ['ATT92' ,  384], ['ATT87' ,  384],
    ['ATT86' ,  384], ['ATT85' ,  384], ['ATT84' ,  384], ['ATT83' ,  384],
    ['ATT82' ,  384], ['ATT76' ,  384], ['ATT75' ,  384], ['ATT74' ,  384],
    ['ATT73' ,  384], ['ATT72' ,  384], ['ATT65' ,  384], ['ATT64' ,  384],
    ['ATT63' ,  384], ['ATT62' ,  384], ['ATT54' ,  384], ['ATT53' ,  384],
    ['ATT52' ,  384], ['ATT43' ,  384], ['ATT42' ,  384], ['ATT32' ,  384],
    ['KQJTT' ,  384], ['KQTT9' ,  384], ['KQTT8' ,  384], ['KQTT7' ,  384],
    ['KQTT6' ,  384], ['KQTT5' ,  384], ['KQTT4' ,  384], ['KQTT3' ,  384],
    ['KQTT2' ,  384], ['KJTT9' ,  384], ['KJTT8' ,  384], ['KJTT7' ,  384],
    ['KJTT6' ,  384], ['KJTT5' ,  384], ['KJTT4' ,  384], ['KJTT3' ,  384],
    ['KJTT2' ,  384], ['KTT98' ,  384], ['KTT97' ,  384], ['KTT96' ,  384],
    ['KTT95' ,  384], ['KTT94' ,  384], ['KTT93' ,  384], ['KTT92' ,  384],
    ['KTT87' ,  384], ['KTT86' ,  384], ['KTT85' ,  384], ['KTT84' ,  384],
    ['KTT83' ,  384], ['KTT82' ,  384], ['KTT76' ,  384], ['KTT75' ,  384],
    ['KTT74' ,  384], ['KTT73' ,  384], ['KTT72' ,  384], ['KTT65' ,  384],
    ['KTT64' ,  384], ['KTT63' ,  384], ['KTT62' ,  384], ['KTT54' ,  384],
    ['KTT53' ,  384], ['KTT52' ,  384], ['KTT43' ,  384], ['KTT42' ,  384],
    ['KTT32' ,  384], ['QJTT9' ,  384], ['QJTT8' ,  384], ['QJTT7' ,  384],
    ['QJTT6' ,  384], ['QJTT5' ,  384], ['QJTT4' ,  384], ['QJTT3' ,  384],
    ['QJTT2' ,  384], ['QTT98' ,  384], ['QTT97' ,  384], ['QTT96' ,  384],
    ['QTT95' ,  384], ['QTT94' ,  384], ['QTT93' ,  384], ['QTT92' ,  384],
    ['QTT87' ,  384], ['QTT86' ,  384], ['QTT85' ,  384], ['QTT84' ,  384],
    ['QTT83' ,  384], ['QTT82' ,  384], ['QTT76' ,  384], ['QTT75' ,  384],
    ['QTT74' ,  384], ['QTT73' ,  384], ['QTT72' ,  384], ['QTT65' ,  384],
    ['QTT64' ,  384], ['QTT63' ,  384], ['QTT62' ,  384], ['QTT54' ,  384],
    ['QTT53' ,  384], ['QTT52' ,  384], ['QTT43' ,  384], ['QTT42' ,  384],
    ['QTT32' ,  384], ['JTT98' ,  384], ['JTT97' ,  384], ['JTT96' ,  384],
    ['JTT95' ,  384], ['JTT94' ,  384], ['JTT93' ,  384], ['JTT92' ,  384],
    ['JTT87' ,  384], ['JTT86' ,  384], ['JTT85' ,  384], ['JTT84' ,  384],
    ['JTT83' ,  384], ['JTT82' ,  384], ['JTT76' ,  384], ['JTT75' ,  384],
    ['JTT74' ,  384], ['JTT73' ,  384], ['JTT72' ,  384], ['JTT65' ,  384],
    ['JTT64' ,  384], ['JTT63' ,  384], ['JTT62' ,  384], ['JTT54' ,  384],
    ['JTT53' ,  384], ['JTT52' ,  384], ['JTT43' ,  384], ['JTT42' ,  384],
    ['JTT32' ,  384], ['TT987' ,  384], ['TT986' ,  384], ['TT985' ,  384],
    ['TT984' ,  384], ['TT983' ,  384], ['TT982' ,  384], ['TT976' ,  384],
    ['TT975' ,  384], ['TT974' ,  384], ['TT973' ,  384], ['TT972' ,  384],
    ['TT965' ,  384], ['TT964' ,  384], ['TT963' ,  384], ['TT962' ,  384],
    ['TT954' ,  384], ['TT953' ,  384], ['TT952' ,  384], ['TT943' ,  384],
    ['TT942' ,  384], ['TT932' ,  384], ['TT876' ,  384], ['TT875' ,  384],
    ['TT874' ,  384], ['TT873' ,  384], ['TT872' ,  384], ['TT865' ,  384],
    ['TT864' ,  384], ['TT863' ,  384], ['TT862' ,  384], ['TT854' ,  384],
    ['TT853' ,  384], ['TT852' ,  384], ['TT843' ,  384], ['TT842' ,  384],
    ['TT832' ,  384], ['TT765' ,  384], ['TT764' ,  384], ['TT763' ,  384],
    ['TT762' ,  384], ['TT754' ,  384], ['TT753' ,  384], ['TT752' ,  384],
    ['TT743' ,  384], ['TT742' ,  384], ['TT732' ,  384], ['TT654' ,  384],
    ['TT653' ,  384], ['TT652' ,  384], ['TT643' ,  384], ['TT642' ,  384],
    ['TT632' ,  384], ['TT543' ,  384], ['TT542' ,  384], ['TT532' ,  384],
    ['TT432' ,  384], ['AKQ99' ,  384], ['AKJ99' ,  384], ['AKT99' ,  384],
    ['AK998' ,  384], ['AK997' ,  384], ['AK996' ,  384], ['AK995' ,  384],
    ['AK994' ,  384], ['AK993' ,  384], ['AK992' ,  384], ['AQJ99' ,  384],
    ['AQT99' ,  384], ['AQ998' ,  384], ['AQ997' ,  384], ['AQ996' ,  384],
    ['AQ995' ,  384], ['AQ994' ,  384], ['AQ993' ,  384], ['AQ992' ,  384],
    ['AJT99' ,  384], ['AJ998' ,  384], ['AJ997' ,  384], ['AJ996' ,  384],
    ['AJ995' ,  384], ['AJ994' ,  384], ['AJ993' ,  384], ['AJ992' ,  384],
    ['AT998' ,  384], ['AT997' ,  384], ['AT996' ,  384], ['AT995' ,  384],
    ['AT994' ,  384], ['AT993' ,  384], ['AT992' ,  384], ['A9987' ,  384],
    ['A9986' ,  384], ['A9985' ,  384], ['A9984' ,  384], ['A9983' ,  384],
    ['A9982' ,  384], ['A9976' ,  384], ['A9975' ,  384], ['A9974' ,  384],
    ['A9973' ,  384], ['A9972' ,  384], ['A9965' ,  384], ['A9964' ,  384],
    ['A9963' ,  384], ['A9962' ,  384], ['A9954' ,  384], ['A9953' ,  384],
    ['A9952' ,  384], ['A9943' ,  384], ['A9942' ,  384], ['A9932' ,  384],
    ['KQJ99' ,  384], ['KQT99' ,  384], ['KQ998' ,  384], ['KQ997' ,  384],
    ['KQ996' ,  384], ['KQ995' ,  384], ['KQ994' ,  384], ['KQ993' ,  384],
    ['KQ992' ,  384], ['KJT99' ,  384], ['KJ998' ,  384], ['KJ997' ,  384],
    ['KJ996' ,  384], ['KJ995' ,  384], ['KJ994' ,  384], ['KJ993' ,  384],
    ['KJ992' ,  384], ['KT998' ,  384], ['KT997' ,  384], ['KT996' ,  384],
    ['KT995' ,  384], ['KT994' ,  384], ['KT993' ,  384], ['KT992' ,  384],
    ['K9987' ,  384], ['K9986' ,  384], ['K9985' ,  384], ['K9984' ,  384],
    ['K9983' ,  384], ['K9982' ,  384], ['K9976' ,  384], ['K9975' ,  384],
    ['K9974' ,  384], ['K9973' ,  384], ['K9972' ,  384], ['K9965' ,  384],
    ['K9964' ,  384], ['K9963' ,  384], ['K9962' ,  384], ['K9954' ,  384],
    ['K9953' ,  384], ['K9952' ,  384], ['K9943' ,  384], ['K9942' ,  384],
    ['K9932' ,  384], ['QJT99' ,  384], ['QJ998' ,  384], ['QJ997' ,  384],
    ['QJ996' ,  384], ['QJ995' ,  384], ['QJ994' ,  384], ['QJ993' ,  384],
    ['QJ992' ,  384], ['QT998' ,  384], ['QT997' ,  384], ['QT996' ,  384],
    ['QT995' ,  384], ['QT994' ,  384], ['QT993' ,  384], ['QT992' ,  384],
    ['Q9987' ,  384], ['Q9986' ,  384], ['Q9985' ,  384], ['Q9984' ,  384],
    ['Q9983' ,  384], ['Q9982' ,  384], ['Q9976' ,  384], ['Q9975' ,  384],
    ['Q9974' ,  384], ['Q9973' ,  384], ['Q9972' ,  384], ['Q9965' ,  384],
    ['Q9964' ,  384], ['Q9963' ,  384], ['Q9962' ,  384], ['Q9954' ,  384],
    ['Q9953' ,  384], ['Q9952' ,  384], ['Q9943' ,  384], ['Q9942' ,  384],
    ['Q9932' ,  384], ['JT998' ,  384], ['JT997' ,  384], ['JT996' ,  384],
    ['JT995' ,  384], ['JT994' ,  384], ['JT993' ,  384], ['JT992' ,  384],
    ['J9987' ,  384], ['J9986' ,  384], ['J9985' ,  384], ['J9984' ,  384],
    ['J9983' ,  384], ['J9982' ,  384], ['J9976' ,  384], ['J9975' ,  384],
    ['J9974' ,  384], ['J9973' ,  384], ['J9972' ,  384], ['J9965' ,  384],
    ['J9964' ,  384], ['J9963' ,  384], ['J9962' ,  384], ['J9954' ,  384],
    ['J9953' ,  384], ['J9952' ,  384], ['J9943' ,  384], ['J9942' ,  384],
    ['J9932' ,  384], ['T9987' ,  384], ['T9986' ,  384], ['T9985' ,  384],
    ['T9984' ,  384], ['T9983' ,  384], ['T9982' ,  384], ['T9976' ,  384],
    ['T9975' ,  384], ['T9974' ,  384], ['T9973' ,  384], ['T9972' ,  384],
    ['T9965' ,  384], ['T9964' ,  384], ['T9963' ,  384], ['T9962' ,  384],
    ['T9954' ,  384], ['T9953' ,  384], ['T9952' ,  384], ['T9943' ,  384],
    ['T9942' ,  384], ['T9932' ,  384], ['99876' ,  384], ['99875' ,  384],
    ['99874' ,  384], ['99873' ,  384], ['99872' ,  384], ['99865' ,  384],
    ['99864' ,  384], ['99863' ,  384], ['99862' ,  384], ['99854' ,  384],
    ['99853' ,  384], ['99852' ,  384], ['99843' ,  384], ['99842' ,  384],
    ['99832' ,  384], ['99765' ,  384], ['99764' ,  384], ['99763' ,  384],
    ['99762' ,  384], ['99754' ,  384], ['99753' ,  384], ['99752' ,  384],
    ['99743' ,  384], ['99742' ,  384], ['99732' ,  384], ['99654' ,  384],
    ['99653' ,  384], ['99652' ,  384], ['99643' ,  384], ['99642' ,  384],
    ['99632' ,  384], ['99543' ,  384], ['99542' ,  384], ['99532' ,  384],
    ['99432' ,  384], ['AKQ88' ,  384], ['AKJ88' ,  384], ['AKT88' ,  384],
    ['AK988' ,  384], ['AK887' ,  384], ['AK886' ,  384], ['AK885' ,  384],
    ['AK884' ,  384], ['AK883' ,  384], ['AK882' ,  384], ['AQJ88' ,  384],
    ['AQT88' ,  384], ['AQ988' ,  384], ['AQ887' ,  384], ['AQ886' ,  384],
    ['AQ885' ,  384], ['AQ884' ,  384], ['AQ883' ,  384], ['AQ882' ,  384],
    ['AJT88' ,  384], ['AJ988' ,  384], ['AJ887' ,  384], ['AJ886' ,  384],
    ['AJ885' ,  384], ['AJ884' ,  384], ['AJ883' ,  384], ['AJ882' ,  384],
    ['AT988' ,  384], ['AT887' ,  384], ['AT886' ,  384], ['AT885' ,  384],
    ['AT884' ,  384], ['AT883' ,  384], ['AT882' ,  384], ['A9887' ,  384],
    ['A9886' ,  384], ['A9885' ,  384], ['A9884' ,  384], ['A9883' ,  384],
    ['A9882' ,  384], ['A8876' ,  384], ['A8875' ,  384], ['A8874' ,  384],
    ['A8873' ,  384], ['A8872' ,  384], ['A8865' ,  384], ['A8864' ,  384],
    ['A8863' ,  384], ['A8862' ,  384], ['A8854' ,  384], ['A8853' ,  384],
    ['A8852' ,  384], ['A8843' ,  384], ['A8842' ,  384], ['A8832' ,  384],
    ['KQJ88' ,  384], ['KQT88' ,  384], ['KQ988' ,  384], ['KQ887' ,  384],
    ['KQ886' ,  384], ['KQ885' ,  384], ['KQ884' ,  384], ['KQ883' ,  384],
    ['KQ882' ,  384], ['KJT88' ,  384], ['KJ988' ,  384], ['KJ887' ,  384],
    ['KJ886' ,  384], ['KJ885' ,  384], ['KJ884' ,  384], ['KJ883' ,  384],
    ['KJ882' ,  384], ['KT988' ,  384], ['KT887' ,  384], ['KT886' ,  384],
    ['KT885' ,  384], ['KT884' ,  384], ['KT883' ,  384], ['KT882' ,  384],
    ['K9887' ,  384], ['K9886' ,  384], ['K9885' ,  384], ['K9884' ,  384],
    ['K9883' ,  384], ['K9882' ,  384], ['K8876' ,  384], ['K8875' ,  384],
    ['K8874' ,  384], ['K8873' ,  384], ['K8872' ,  384], ['K8865' ,  384],
    ['K8864' ,  384], ['K8863' ,  384], ['K8862' ,  384], ['K8854' ,  384],
    ['K8853' ,  384], ['K8852' ,  384], ['K8843' ,  384], ['K8842' ,  384],
    ['K8832' ,  384], ['QJT88' ,  384], ['QJ988' ,  384], ['QJ887' ,  384],
    ['QJ886' ,  384], ['QJ885' ,  384], ['QJ884' ,  384], ['QJ883' ,  384],
    ['QJ882' ,  384], ['QT988' ,  384], ['QT887' ,  384], ['QT886' ,  384],
    ['QT885' ,  384], ['QT884' ,  384], ['QT883' ,  384], ['QT882' ,  384],
    ['Q9887' ,  384], ['Q9886' ,  384], ['Q9885' ,  384], ['Q9884' ,  384],
    ['Q9883' ,  384], ['Q9882' ,  384], ['Q8876' ,  384], ['Q8875' ,  384],
    ['Q8874' ,  384], ['Q8873' ,  384], ['Q8872' ,  384], ['Q8865' ,  384],
    ['Q8864' ,  384], ['Q8863' ,  384], ['Q8862' ,  384], ['Q8854' ,  384],
    ['Q8853' ,  384], ['Q8852' ,  384], ['Q8843' ,  384], ['Q8842' ,  384],
    ['Q8832' ,  384], ['JT988' ,  384], ['JT887' ,  384], ['JT886' ,  384],
    ['JT885' ,  384], ['JT884' ,  384], ['JT883' ,  384], ['JT882' ,  384],
    ['J9887' ,  384], ['J9886' ,  384], ['J9885' ,  384], ['J9884' ,  384],
    ['J9883' ,  384], ['J9882' ,  384], ['J8876' ,  384], ['J8875' ,  384],
    ['J8874' ,  384], ['J8873' ,  384], ['J8872' ,  384], ['J8865' ,  384],
    ['J8864' ,  384], ['J8863' ,  384], ['J8862' ,  384], ['J8854' ,  384],
    ['J8853' ,  384], ['J8852' ,  384], ['J8843' ,  384], ['J8842' ,  384],
    ['J8832' ,  384], ['T9887' ,  384], ['T9886' ,  384], ['T9885' ,  384],
    ['T9884' ,  384], ['T9883' ,  384], ['T9882' ,  384], ['T8876' ,  384],
    ['T8875' ,  384], ['T8874' ,  384], ['T8873' ,  384], ['T8872' ,  384],
    ['T8865' ,  384], ['T8864' ,  384], ['T8863' ,  384], ['T8862' ,  384],
    ['T8854' ,  384], ['T8853' ,  384], ['T8852' ,  384], ['T8843' ,  384],
    ['T8842' ,  384], ['T8832' ,  384], ['98876' ,  384], ['98875' ,  384],
    ['98874' ,  384], ['98873' ,  384], ['98872' ,  384], ['98865' ,  384],
    ['98864' ,  384], ['98863' ,  384], ['98862' ,  384], ['98854' ,  384],
    ['98853' ,  384], ['98852' ,  384], ['98843' ,  384], ['98842' ,  384],
    ['98832' ,  384], ['88765' ,  384], ['88764' ,  384], ['88763' ,  384],
    ['88762' ,  384], ['88754' ,  384], ['88753' ,  384], ['88752' ,  384],
    ['88743' ,  384], ['88742' ,  384], ['88732' ,  384], ['88654' ,  384],
    ['88653' ,  384], ['88652' ,  384], ['88643' ,  384], ['88642' ,  384],
    ['88632' ,  384], ['88543' ,  384], ['88542' ,  384], ['88532' ,  384],
    ['88432' ,  384], ['AKQ77' ,  384], ['AKJ77' ,  384], ['AKT77' ,  384],
    ['AK977' ,  384], ['AK877' ,  384], ['AK776' ,  384], ['AK775' ,  384],
    ['AK774' ,  384], ['AK773' ,  384], ['AK772' ,  384], ['AQJ77' ,  384],
    ['AQT77' ,  384], ['AQ977' ,  384], ['AQ877' ,  384], ['AQ776' ,  384],
    ['AQ775' ,  384], ['AQ774' ,  384], ['AQ773' ,  384], ['AQ772' ,  384],
    ['AJT77' ,  384], ['AJ977' ,  384], ['AJ877' ,  384], ['AJ776' ,  384],
    ['AJ775' ,  384], ['AJ774' ,  384], ['AJ773' ,  384], ['AJ772' ,  384],
    ['AT977' ,  384], ['AT877' ,  384], ['AT776' ,  384], ['AT775' ,  384],
    ['AT774' ,  384], ['AT773' ,  384], ['AT772' ,  384], ['A9877' ,  384],
    ['A9776' ,  384], ['A9775' ,  384], ['A9774' ,  384], ['A9773' ,  384],
    ['A9772' ,  384], ['A8776' ,  384], ['A8775' ,  384], ['A8774' ,  384],
    ['A8773' ,  384], ['A8772' ,  384], ['A7765' ,  384], ['A7764' ,  384],
    ['A7763' ,  384], ['A7762' ,  384], ['A7754' ,  384], ['A7753' ,  384],
    ['A7752' ,  384], ['A7743' ,  384], ['A7742' ,  384], ['A7732' ,  384],
    ['KQJ77' ,  384], ['KQT77' ,  384], ['KQ977' ,  384], ['KQ877' ,  384],
    ['KQ776' ,  384], ['KQ775' ,  384], ['KQ774' ,  384], ['KQ773' ,  384],
    ['KQ772' ,  384], ['KJT77' ,  384], ['KJ977' ,  384], ['KJ877' ,  384],
    ['KJ776' ,  384], ['KJ775' ,  384], ['KJ774' ,  384], ['KJ773' ,  384],
    ['KJ772' ,  384], ['KT977' ,  384], ['KT877' ,  384], ['KT776' ,  384],
    ['KT775' ,  384], ['KT774' ,  384], ['KT773' ,  384], ['KT772' ,  384],
    ['K9877' ,  384], ['K9776' ,  384], ['K9775' ,  384], ['K9774' ,  384],
    ['K9773' ,  384], ['K9772' ,  384], ['K8776' ,  384], ['K8775' ,  384],
    ['K8774' ,  384], ['K8773' ,  384], ['K8772' ,  384], ['K7765' ,  384],
    ['K7764' ,  384], ['K7763' ,  384], ['K7762' ,  384], ['K7754' ,  384],
    ['K7753' ,  384], ['K7752' ,  384], ['K7743' ,  384], ['K7742' ,  384],
    ['K7732' ,  384], ['QJT77' ,  384], ['QJ977' ,  384], ['QJ877' ,  384],
    ['QJ776' ,  384], ['QJ775' ,  384], ['QJ774' ,  384], ['QJ773' ,  384],
    ['QJ772' ,  384], ['QT977' ,  384], ['QT877' ,  384], ['QT776' ,  384],
    ['QT775' ,  384], ['QT774' ,  384], ['QT773' ,  384], ['QT772' ,  384],
    ['Q9877' ,  384], ['Q9776' ,  384], ['Q9775' ,  384], ['Q9774' ,  384],
    ['Q9773' ,  384], ['Q9772' ,  384], ['Q8776' ,  384], ['Q8775' ,  384],
    ['Q8774' ,  384], ['Q8773' ,  384], ['Q8772' ,  384], ['Q7765' ,  384],
    ['Q7764' ,  384], ['Q7763' ,  384], ['Q7762' ,  384], ['Q7754' ,  384],
    ['Q7753' ,  384], ['Q7752' ,  384], ['Q7743' ,  384], ['Q7742' ,  384],
    ['Q7732' ,  384], ['JT977' ,  384], ['JT877' ,  384], ['JT776' ,  384],
    ['JT775' ,  384], ['JT774' ,  384], ['JT773' ,  384], ['JT772' ,  384],
    ['J9877' ,  384], ['J9776' ,  384], ['J9775' ,  384], ['J9774' ,  384],
    ['J9773' ,  384], ['J9772' ,  384], ['J8776' ,  384], ['J8775' ,  384],
    ['J8774' ,  384], ['J8773' ,  384], ['J8772' ,  384], ['J7765' ,  384],
    ['J7764' ,  384], ['J7763' ,  384], ['J7762' ,  384], ['J7754' ,  384],
    ['J7753' ,  384], ['J7752' ,  384], ['J7743' ,  384], ['J7742' ,  384],
    ['J7732' ,  384], ['T9877' ,  384], ['T9776' ,  384], ['T9775' ,  384],
    ['T9774' ,  384], ['T9773' ,  384], ['T9772' ,  384], ['T8776' ,  384],
    ['T8775' ,  384], ['T8774' ,  384], ['T8773' ,  384], ['T8772' ,  384],
    ['T7765' ,  384], ['T7764' ,  384], ['T7763' ,  384], ['T7762' ,  384],
    ['T7754' ,  384], ['T7753' ,  384], ['T7752' ,  384], ['T7743' ,  384],
    ['T7742' ,  384], ['T7732' ,  384], ['98776' ,  384], ['98775' ,  384],
    ['98774' ,  384], ['98773' ,  384], ['98772' ,  384], ['97765' ,  384],
    ['97764' ,  384], ['97763' ,  384], ['97762' ,  384], ['97754' ,  384],
    ['97753' ,  384], ['97752' ,  384], ['97743' ,  384], ['97742' ,  384],
    ['97732' ,  384], ['87765' ,  384], ['87764' ,  384], ['87763' ,  384],
    ['87762' ,  384], ['87754' ,  384], ['87753' ,  384], ['87752' ,  384],
    ['87743' ,  384], ['87742' ,  384], ['87732' ,  384], ['77654' ,  384],
    ['77653' ,  384], ['77652' ,  384], ['77643' ,  384], ['77642' ,  384],
    ['77632' ,  384], ['77543' ,  384], ['77542' ,  384], ['77532' ,  384],
    ['77432' ,  384], ['AKQ66' ,  384], ['AKJ66' ,  384], ['AKT66' ,  384],
    ['AK966' ,  384], ['AK866' ,  384], ['AK766' ,  384], ['AK665' ,  384],
    ['AK664' ,  384], ['AK663' ,  384], ['AK662' ,  384], ['AQJ66' ,  384],
    ['AQT66' ,  384], ['AQ966' ,  384], ['AQ866' ,  384], ['AQ766' ,  384],
    ['AQ665' ,  384], ['AQ664' ,  384], ['AQ663' ,  384], ['AQ662' ,  384],
    ['AJT66' ,  384], ['AJ966' ,  384], ['AJ866' ,  384], ['AJ766' ,  384],
    ['AJ665' ,  384], ['AJ664' ,  384], ['AJ663' ,  384], ['AJ662' ,  384],
    ['AT966' ,  384], ['AT866' ,  384], ['AT766' ,  384], ['AT665' ,  384],
    ['AT664' ,  384], ['AT663' ,  384], ['AT662' ,  384], ['A9866' ,  384],
    ['A9766' ,  384], ['A9665' ,  384], ['A9664' ,  384], ['A9663' ,  384],
    ['A9662' ,  384], ['A8766' ,  384], ['A8665' ,  384], ['A8664' ,  384],
    ['A8663' ,  384], ['A8662' ,  384], ['A7665' ,  384], ['A7664' ,  384],
    ['A7663' ,  384], ['A7662' ,  384], ['A6654' ,  384], ['A6653' ,  384],
    ['A6652' ,  384], ['A6643' ,  384], ['A6642' ,  384], ['A6632' ,  384],
    ['KQJ66' ,  384], ['KQT66' ,  384], ['KQ966' ,  384], ['KQ866' ,  384],
    ['KQ766' ,  384], ['KQ665' ,  384], ['KQ664' ,  384], ['KQ663' ,  384],
    ['KQ662' ,  384], ['KJT66' ,  384], ['KJ966' ,  384], ['KJ866' ,  384],
    ['KJ766' ,  384], ['KJ665' ,  384], ['KJ664' ,  384], ['KJ663' ,  384],
    ['KJ662' ,  384], ['KT966' ,  384], ['KT866' ,  384], ['KT766' ,  384],
    ['KT665' ,  384], ['KT664' ,  384], ['KT663' ,  384], ['KT662' ,  384],
    ['K9866' ,  384], ['K9766' ,  384], ['K9665' ,  384], ['K9664' ,  384],
    ['K9663' ,  384], ['K9662' ,  384], ['K8766' ,  384], ['K8665' ,  384],
    ['K8664' ,  384], ['K8663' ,  384], ['K8662' ,  384], ['K7665' ,  384],
    ['K7664' ,  384], ['K7663' ,  384], ['K7662' ,  384], ['K6654' ,  384],
    ['K6653' ,  384], ['K6652' ,  384], ['K6643' ,  384], ['K6642' ,  384],
    ['K6632' ,  384], ['QJT66' ,  384], ['QJ966' ,  384], ['QJ866' ,  384],
    ['QJ766' ,  384], ['QJ665' ,  384], ['QJ664' ,  384], ['QJ663' ,  384],
    ['QJ662' ,  384], ['QT966' ,  384], ['QT866' ,  384], ['QT766' ,  384],
    ['QT665' ,  384], ['QT664' ,  384], ['QT663' ,  384], ['QT662' ,  384],
    ['Q9866' ,  384], ['Q9766' ,  384], ['Q9665' ,  384], ['Q9664' ,  384],
    ['Q9663' ,  384], ['Q9662' ,  384], ['Q8766' ,  384], ['Q8665' ,  384],
    ['Q8664' ,  384], ['Q8663' ,  384], ['Q8662' ,  384], ['Q7665' ,  384],
    ['Q7664' ,  384], ['Q7663' ,  384], ['Q7662' ,  384], ['Q6654' ,  384],
    ['Q6653' ,  384], ['Q6652' ,  384], ['Q6643' ,  384], ['Q6642' ,  384],
    ['Q6632' ,  384], ['JT966' ,  384], ['JT866' ,  384], ['JT766' ,  384],
    ['JT665' ,  384], ['JT664' ,  384], ['JT663' ,  384], ['JT662' ,  384],
    ['J9866' ,  384], ['J9766' ,  384], ['J9665' ,  384], ['J9664' ,  384],
    ['J9663' ,  384], ['J9662' ,  384], ['J8766' ,  384], ['J8665' ,  384],
    ['J8664' ,  384], ['J8663' ,  384], ['J8662' ,  384], ['J7665' ,  384],
    ['J7664' ,  384], ['J7663' ,  384], ['J7662' ,  384], ['J6654' ,  384],
    ['J6653' ,  384], ['J6652' ,  384], ['J6643' ,  384], ['J6642' ,  384],
    ['J6632' ,  384], ['T9866' ,  384], ['T9766' ,  384], ['T9665' ,  384],
    ['T9664' ,  384], ['T9663' ,  384], ['T9662' ,  384], ['T8766' ,  384],
    ['T8665' ,  384], ['T8664' ,  384], ['T8663' ,  384], ['T8662' ,  384],
    ['T7665' ,  384], ['T7664' ,  384], ['T7663' ,  384], ['T7662' ,  384],
    ['T6654' ,  384], ['T6653' ,  384], ['T6652' ,  384], ['T6643' ,  384],
    ['T6642' ,  384], ['T6632' ,  384], ['98766' ,  384], ['98665' ,  384],
    ['98664' ,  384], ['98663' ,  384], ['98662' ,  384], ['97665' ,  384],
    ['97664' ,  384], ['97663' ,  384], ['97662' ,  384], ['96654' ,  384],
    ['96653' ,  384], ['96652' ,  384], ['96643' ,  384], ['96642' ,  384],
    ['96632' ,  384], ['87665' ,  384], ['87664' ,  384], ['87663' ,  384],
    ['87662' ,  384], ['86654' ,  384], ['86653' ,  384], ['86652' ,  384],
    ['86643' ,  384], ['86642' ,  384], ['86632' ,  384], ['76654' ,  384],
    ['76653' ,  384], ['76652' ,  384], ['76643' ,  384], ['76642' ,  384],
    ['76632' ,  384], ['66543' ,  384], ['66542' ,  384], ['66532' ,  384],
    ['66432' ,  384], ['AKQ55' ,  384], ['AKJ55' ,  384], ['AKT55' ,  384],
    ['AK955' ,  384], ['AK855' ,  384], ['AK755' ,  384], ['AK655' ,  384],
    ['AK554' ,  384], ['AK553' ,  384], ['AK552' ,  384], ['AQJ55' ,  384],
    ['AQT55' ,  384], ['AQ955' ,  384], ['AQ855' ,  384], ['AQ755' ,  384],
    ['AQ655' ,  384], ['AQ554' ,  384], ['AQ553' ,  384], ['AQ552' ,  384],
    ['AJT55' ,  384], ['AJ955' ,  384], ['AJ855' ,  384], ['AJ755' ,  384],
    ['AJ655' ,  384], ['AJ554' ,  384], ['AJ553' ,  384], ['AJ552' ,  384],
    ['AT955' ,  384], ['AT855' ,  384], ['AT755' ,  384], ['AT655' ,  384],
    ['AT554' ,  384], ['AT553' ,  384], ['AT552' ,  384], ['A9855' ,  384],
    ['A9755' ,  384], ['A9655' ,  384], ['A9554' ,  384], ['A9553' ,  384],
    ['A9552' ,  384], ['A8755' ,  384], ['A8655' ,  384], ['A8554' ,  384],
    ['A8553' ,  384], ['A8552' ,  384], ['A7655' ,  384], ['A7554' ,  384],
    ['A7553' ,  384], ['A7552' ,  384], ['A6554' ,  384], ['A6553' ,  384],
    ['A6552' ,  384], ['A5543' ,  384], ['A5542' ,  384], ['A5532' ,  384],
    ['KQJ55' ,  384], ['KQT55' ,  384], ['KQ955' ,  384], ['KQ855' ,  384],
    ['KQ755' ,  384], ['KQ655' ,  384], ['KQ554' ,  384], ['KQ553' ,  384],
    ['KQ552' ,  384], ['KJT55' ,  384], ['KJ955' ,  384], ['KJ855' ,  384],
    ['KJ755' ,  384], ['KJ655' ,  384], ['KJ554' ,  384], ['KJ553' ,  384],
    ['KJ552' ,  384], ['KT955' ,  384], ['KT855' ,  384], ['KT755' ,  384],
    ['KT655' ,  384], ['KT554' ,  384], ['KT553' ,  384], ['KT552' ,  384],
    ['K9855' ,  384], ['K9755' ,  384], ['K9655' ,  384], ['K9554' ,  384],
    ['K9553' ,  384], ['K9552' ,  384], ['K8755' ,  384], ['K8655' ,  384],
    ['K8554' ,  384], ['K8553' ,  384], ['K8552' ,  384], ['K7655' ,  384],
    ['K7554' ,  384], ['K7553' ,  384], ['K7552' ,  384], ['K6554' ,  384],
    ['K6553' ,  384], ['K6552' ,  384], ['K5543' ,  384], ['K5542' ,  384],
    ['K5532' ,  384], ['QJT55' ,  384], ['QJ955' ,  384], ['QJ855' ,  384],
    ['QJ755' ,  384], ['QJ655' ,  384], ['QJ554' ,  384], ['QJ553' ,  384],
    ['QJ552' ,  384], ['QT955' ,  384], ['QT855' ,  384], ['QT755' ,  384],
    ['QT655' ,  384], ['QT554' ,  384], ['QT553' ,  384], ['QT552' ,  384],
    ['Q9855' ,  384], ['Q9755' ,  384], ['Q9655' ,  384], ['Q9554' ,  384],
    ['Q9553' ,  384], ['Q9552' ,  384], ['Q8755' ,  384], ['Q8655' ,  384],
    ['Q8554' ,  384], ['Q8553' ,  384], ['Q8552' ,  384], ['Q7655' ,  384],
    ['Q7554' ,  384], ['Q7553' ,  384], ['Q7552' ,  384], ['Q6554' ,  384],
    ['Q6553' ,  384], ['Q6552' ,  384], ['Q5543' ,  384], ['Q5542' ,  384],
    ['Q5532' ,  384], ['JT955' ,  384], ['JT855' ,  384], ['JT755' ,  384],
    ['JT655' ,  384], ['JT554' ,  384], ['JT553' ,  384], ['JT552' ,  384],
    ['J9855' ,  384], ['J9755' ,  384], ['J9655' ,  384], ['J9554' ,  384],
    ['J9553' ,  384], ['J9552' ,  384], ['J8755' ,  384], ['J8655' ,  384],
    ['J8554' ,  384], ['J8553' ,  384], ['J8552' ,  384], ['J7655' ,  384],
    ['J7554' ,  384], ['J7553' ,  384], ['J7552' ,  384], ['J6554' ,  384],
    ['J6553' ,  384], ['J6552' ,  384], ['J5543' ,  384], ['J5542' ,  384],
    ['J5532' ,  384], ['T9855' ,  384], ['T9755' ,  384], ['T9655' ,  384],
    ['T9554' ,  384], ['T9553' ,  384], ['T9552' ,  384], ['T8755' ,  384],
    ['T8655' ,  384], ['T8554' ,  384], ['T8553' ,  384], ['T8552' ,  384],
    ['T7655' ,  384], ['T7554' ,  384], ['T7553' ,  384], ['T7552' ,  384],
    ['T6554' ,  384], ['T6553' ,  384], ['T6552' ,  384], ['T5543' ,  384],
    ['T5542' ,  384], ['T5532' ,  384], ['98755' ,  384], ['98655' ,  384],
    ['98554' ,  384], ['98553' ,  384], ['98552' ,  384], ['97655' ,  384],
    ['97554' ,  384], ['97553' ,  384], ['97552' ,  384], ['96554' ,  384],
    ['96553' ,  384], ['96552' ,  384], ['95543' ,  384], ['95542' ,  384],
    ['95532' ,  384], ['87655' ,  384], ['87554' ,  384], ['87553' ,  384],
    ['87552' ,  384], ['86554' ,  384], ['86553' ,  384], ['86552' ,  384],
    ['85543' ,  384], ['85542' ,  384], ['85532' ,  384], ['76554' ,  384],
    ['76553' ,  384], ['76552' ,  384], ['75543' ,  384], ['75542' ,  384],
    ['75532' ,  384], ['65543' ,  384], ['65542' ,  384], ['65532' ,  384],
    ['55432' ,  384], ['AKQ44' ,  384], ['AKJ44' ,  384], ['AKT44' ,  384],
    ['AK944' ,  384], ['AK844' ,  384], ['AK744' ,  384], ['AK644' ,  384],
    ['AK544' ,  384], ['AK443' ,  384], ['AK442' ,  384], ['AQJ44' ,  384],
    ['AQT44' ,  384], ['AQ944' ,  384], ['AQ844' ,  384], ['AQ744' ,  384],
    ['AQ644' ,  384], ['AQ544' ,  384], ['AQ443' ,  384], ['AQ442' ,  384],
    ['AJT44' ,  384], ['AJ944' ,  384], ['AJ844' ,  384], ['AJ744' ,  384],
    ['AJ644' ,  384], ['AJ544' ,  384], ['AJ443' ,  384], ['AJ442' ,  384],
    ['AT944' ,  384], ['AT844' ,  384], ['AT744' ,  384], ['AT644' ,  384],
    ['AT544' ,  384], ['AT443' ,  384], ['AT442' ,  384], ['A9844' ,  384],
    ['A9744' ,  384], ['A9644' ,  384], ['A9544' ,  384], ['A9443' ,  384],
    ['A9442' ,  384], ['A8744' ,  384], ['A8644' ,  384], ['A8544' ,  384],
    ['A8443' ,  384], ['A8442' ,  384], ['A7644' ,  384], ['A7544' ,  384],
    ['A7443' ,  384], ['A7442' ,  384], ['A6544' ,  384], ['A6443' ,  384],
    ['A6442' ,  384], ['A5443' ,  384], ['A5442' ,  384], ['A4432' ,  384],
    ['KQJ44' ,  384], ['KQT44' ,  384], ['KQ944' ,  384], ['KQ844' ,  384],
    ['KQ744' ,  384], ['KQ644' ,  384], ['KQ544' ,  384], ['KQ443' ,  384],
    ['KQ442' ,  384], ['KJT44' ,  384], ['KJ944' ,  384], ['KJ844' ,  384],
    ['KJ744' ,  384], ['KJ644' ,  384], ['KJ544' ,  384], ['KJ443' ,  384],
    ['KJ442' ,  384], ['KT944' ,  384], ['KT844' ,  384], ['KT744' ,  384],
    ['KT644' ,  384], ['KT544' ,  384], ['KT443' ,  384], ['KT442' ,  384],
    ['K9844' ,  384], ['K9744' ,  384], ['K9644' ,  384], ['K9544' ,  384],
    ['K9443' ,  384], ['K9442' ,  384], ['K8744' ,  384], ['K8644' ,  384],
    ['K8544' ,  384], ['K8443' ,  384], ['K8442' ,  384], ['K7644' ,  384],
    ['K7544' ,  384], ['K7443' ,  384], ['K7442' ,  384], ['K6544' ,  384],
    ['K6443' ,  384], ['K6442' ,  384], ['K5443' ,  384], ['K5442' ,  384],
    ['K4432' ,  384], ['QJT44' ,  384], ['QJ944' ,  384], ['QJ844' ,  384],
    ['QJ744' ,  384], ['QJ644' ,  384], ['QJ544' ,  384], ['QJ443' ,  384],
    ['QJ442' ,  384], ['QT944' ,  384], ['QT844' ,  384], ['QT744' ,  384],
    ['QT644' ,  384], ['QT544' ,  384], ['QT443' ,  384], ['QT442' ,  384],
    ['Q9844' ,  384], ['Q9744' ,  384], ['Q9644' ,  384], ['Q9544' ,  384],
    ['Q9443' ,  384], ['Q9442' ,  384], ['Q8744' ,  384], ['Q8644' ,  384],
    ['Q8544' ,  384], ['Q8443' ,  384], ['Q8442' ,  384], ['Q7644' ,  384],
    ['Q7544' ,  384], ['Q7443' ,  384], ['Q7442' ,  384], ['Q6544' ,  384],
    ['Q6443' ,  384], ['Q6442' ,  384], ['Q5443' ,  384], ['Q5442' ,  384],
    ['Q4432' ,  384], ['JT944' ,  384], ['JT844' ,  384], ['JT744' ,  384],
    ['JT644' ,  384], ['JT544' ,  384], ['JT443' ,  384], ['JT442' ,  384],
    ['J9844' ,  384], ['J9744' ,  384], ['J9644' ,  384], ['J9544' ,  384],
    ['J9443' ,  384], ['J9442' ,  384], ['J8744' ,  384], ['J8644' ,  384],
    ['J8544' ,  384], ['J8443' ,  384], ['J8442' ,  384], ['J7644' ,  384],
    ['J7544' ,  384], ['J7443' ,  384], ['J7442' ,  384], ['J6544' ,  384],
    ['J6443' ,  384], ['J6442' ,  384], ['J5443' ,  384], ['J5442' ,  384],
    ['J4432' ,  384], ['T9844' ,  384], ['T9744' ,  384], ['T9644' ,  384],
    ['T9544' ,  384], ['T9443' ,  384], ['T9442' ,  384], ['T8744' ,  384],
    ['T8644' ,  384], ['T8544' ,  384], ['T8443' ,  384], ['T8442' ,  384],
    ['T7644' ,  384], ['T7544' ,  384], ['T7443' ,  384], ['T7442' ,  384],
    ['T6544' ,  384], ['T6443' ,  384], ['T6442' ,  384], ['T5443' ,  384],
    ['T5442' ,  384], ['T4432' ,  384], ['98744' ,  384], ['98644' ,  384],
    ['98544' ,  384], ['98443' ,  384], ['98442' ,  384], ['97644' ,  384],
    ['97544' ,  384], ['97443' ,  384], ['97442' ,  384], ['96544' ,  384],
    ['96443' ,  384], ['96442' ,  384], ['95443' ,  384], ['95442' ,  384],
    ['94432' ,  384], ['87644' ,  384], ['87544' ,  384], ['87443' ,  384],
    ['87442' ,  384], ['86544' ,  384], ['86443' ,  384], ['86442' ,  384],
    ['85443' ,  384], ['85442' ,  384], ['84432' ,  384], ['76544' ,  384],
    ['76443' ,  384], ['76442' ,  384], ['75443' ,  384], ['75442' ,  384],
    ['74432' ,  384], ['65443' ,  384], ['65442' ,  384], ['64432' ,  384],
    ['54432' ,  384], ['AKQ33' ,  384], ['AKJ33' ,  384], ['AKT33' ,  384],
    ['AK933' ,  384], ['AK833' ,  384], ['AK733' ,  384], ['AK633' ,  384],
    ['AK533' ,  384], ['AK433' ,  384], ['AK332' ,  384], ['AQJ33' ,  384],
    ['AQT33' ,  384], ['AQ933' ,  384], ['AQ833' ,  384], ['AQ733' ,  384],
    ['AQ633' ,  384], ['AQ533' ,  384], ['AQ433' ,  384], ['AQ332' ,  384],
    ['AJT33' ,  384], ['AJ933' ,  384], ['AJ833' ,  384], ['AJ733' ,  384],
    ['AJ633' ,  384], ['AJ533' ,  384], ['AJ433' ,  384], ['AJ332' ,  384],
    ['AT933' ,  384], ['AT833' ,  384], ['AT733' ,  384], ['AT633' ,  384],
    ['AT533' ,  384], ['AT433' ,  384], ['AT332' ,  384], ['A9833' ,  384],
    ['A9733' ,  384], ['A9633' ,  384], ['A9533' ,  384], ['A9433' ,  384],
    ['A9332' ,  384], ['A8733' ,  384], ['A8633' ,  384], ['A8533' ,  384],
    ['A8433' ,  384], ['A8332' ,  384], ['A7633' ,  384], ['A7533' ,  384],
    ['A7433' ,  384], ['A7332' ,  384], ['A6533' ,  384], ['A6433' ,  384],
    ['A6332' ,  384], ['A5433' ,  384], ['A5332' ,  384], ['A4332' ,  384],
    ['KQJ33' ,  384], ['KQT33' ,  384], ['KQ933' ,  384], ['KQ833' ,  384],
    ['KQ733' ,  384], ['KQ633' ,  384], ['KQ533' ,  384], ['KQ433' ,  384],
    ['KQ332' ,  384], ['KJT33' ,  384], ['KJ933' ,  384], ['KJ833' ,  384],
    ['KJ733' ,  384], ['KJ633' ,  384], ['KJ533' ,  384], ['KJ433' ,  384],
    ['KJ332' ,  384], ['KT933' ,  384], ['KT833' ,  384], ['KT733' ,  384],
    ['KT633' ,  384], ['KT533' ,  384], ['KT433' ,  384], ['KT332' ,  384],
    ['K9833' ,  384], ['K9733' ,  384], ['K9633' ,  384], ['K9533' ,  384],
    ['K9433' ,  384], ['K9332' ,  384], ['K8733' ,  384], ['K8633' ,  384],
    ['K8533' ,  384], ['K8433' ,  384], ['K8332' ,  384], ['K7633' ,  384],
    ['K7533' ,  384], ['K7433' ,  384], ['K7332' ,  384], ['K6533' ,  384],
    ['K6433' ,  384], ['K6332' ,  384], ['K5433' ,  384], ['K5332' ,  384],
    ['K4332' ,  384], ['QJT33' ,  384], ['QJ933' ,  384], ['QJ833' ,  384],
    ['QJ733' ,  384], ['QJ633' ,  384], ['QJ533' ,  384], ['QJ433' ,  384],
    ['QJ332' ,  384], ['QT933' ,  384], ['QT833' ,  384], ['QT733' ,  384],
    ['QT633' ,  384], ['QT533' ,  384], ['QT433' ,  384], ['QT332' ,  384],
    ['Q9833' ,  384], ['Q9733' ,  384], ['Q9633' ,  384], ['Q9533' ,  384],
    ['Q9433' ,  384], ['Q9332' ,  384], ['Q8733' ,  384], ['Q8633' ,  384],
    ['Q8533' ,  384], ['Q8433' ,  384], ['Q8332' ,  384], ['Q7633' ,  384],
    ['Q7533' ,  384], ['Q7433' ,  384], ['Q7332' ,  384], ['Q6533' ,  384],
    ['Q6433' ,  384], ['Q6332' ,  384], ['Q5433' ,  384], ['Q5332' ,  384],
    ['Q4332' ,  384], ['JT933' ,  384], ['JT833' ,  384], ['JT733' ,  384],
    ['JT633' ,  384], ['JT533' ,  384], ['JT433' ,  384], ['JT332' ,  384],
    ['J9833' ,  384], ['J9733' ,  384], ['J9633' ,  384], ['J9533' ,  384],
    ['J9433' ,  384], ['J9332' ,  384], ['J8733' ,  384], ['J8633' ,  384],
    ['J8533' ,  384], ['J8433' ,  384], ['J8332' ,  384], ['J7633' ,  384],
    ['J7533' ,  384], ['J7433' ,  384], ['J7332' ,  384], ['J6533' ,  384],
    ['J6433' ,  384], ['J6332' ,  384], ['J5433' ,  384], ['J5332' ,  384],
    ['J4332' ,  384], ['T9833' ,  384], ['T9733' ,  384], ['T9633' ,  384],
    ['T9533' ,  384], ['T9433' ,  384], ['T9332' ,  384], ['T8733' ,  384],
    ['T8633' ,  384], ['T8533' ,  384], ['T8433' ,  384], ['T8332' ,  384],
    ['T7633' ,  384], ['T7533' ,  384], ['T7433' ,  384], ['T7332' ,  384],
    ['T6533' ,  384], ['T6433' ,  384], ['T6332' ,  384], ['T5433' ,  384],
    ['T5332' ,  384], ['T4332' ,  384], ['98733' ,  384], ['98633' ,  384],
    ['98533' ,  384], ['98433' ,  384], ['98332' ,  384], ['97633' ,  384],
    ['97533' ,  384], ['97433' ,  384], ['97332' ,  384], ['96533' ,  384],
    ['96433' ,  384], ['96332' ,  384], ['95433' ,  384], ['95332' ,  384],
    ['94332' ,  384], ['87633' ,  384], ['87533' ,  384], ['87433' ,  384],
    ['87332' ,  384], ['86533' ,  384], ['86433' ,  384], ['86332' ,  384],
    ['85433' ,  384], ['85332' ,  384], ['84332' ,  384], ['76533' ,  384],
    ['76433' ,  384], ['76332' ,  384], ['75433' ,  384], ['75332' ,  384],
    ['74332' ,  384], ['65433' ,  384], ['65332' ,  384], ['64332' ,  384],
    ['54332' ,  384], ['AKQ22' ,  384], ['AKJ22' ,  384], ['AKT22' ,  384],
    ['AK922' ,  384], ['AK822' ,  384], ['AK722' ,  384], ['AK622' ,  384],
    ['AK522' ,  384], ['AK422' ,  384], ['AK322' ,  384], ['AQJ22' ,  384],
    ['AQT22' ,  384], ['AQ922' ,  384], ['AQ822' ,  384], ['AQ722' ,  384],
    ['AQ622' ,  384], ['AQ522' ,  384], ['AQ422' ,  384], ['AQ322' ,  384],
    ['AJT22' ,  384], ['AJ922' ,  384], ['AJ822' ,  384], ['AJ722' ,  384],
    ['AJ622' ,  384], ['AJ522' ,  384], ['AJ422' ,  384], ['AJ322' ,  384],
    ['AT922' ,  384], ['AT822' ,  384], ['AT722' ,  384], ['AT622' ,  384],
    ['AT522' ,  384], ['AT422' ,  384], ['AT322' ,  384], ['A9822' ,  384],
    ['A9722' ,  384], ['A9622' ,  384], ['A9522' ,  384], ['A9422' ,  384],
    ['A9322' ,  384], ['A8722' ,  384], ['A8622' ,  384], ['A8522' ,  384],
    ['A8422' ,  384], ['A8322' ,  384], ['A7622' ,  384], ['A7522' ,  384],
    ['A7422' ,  384], ['A7322' ,  384], ['A6522' ,  384], ['A6422' ,  384],
    ['A6322' ,  384], ['A5422' ,  384], ['A5322' ,  384], ['A4322' ,  384],
    ['KQJ22' ,  384], ['KQT22' ,  384], ['KQ922' ,  384], ['KQ822' ,  384],
    ['KQ722' ,  384], ['KQ622' ,  384], ['KQ522' ,  384], ['KQ422' ,  384],
    ['KQ322' ,  384], ['KJT22' ,  384], ['KJ922' ,  384], ['KJ822' ,  384],
    ['KJ722' ,  384], ['KJ622' ,  384], ['KJ522' ,  384], ['KJ422' ,  384],
    ['KJ322' ,  384], ['KT922' ,  384], ['KT822' ,  384], ['KT722' ,  384],
    ['KT622' ,  384], ['KT522' ,  384], ['KT422' ,  384], ['KT322' ,  384],
    ['K9822' ,  384], ['K9722' ,  384], ['K9622' ,  384], ['K9522' ,  384],
    ['K9422' ,  384], ['K9322' ,  384], ['K8722' ,  384], ['K8622' ,  384],
    ['K8522' ,  384], ['K8422' ,  384], ['K8322' ,  384], ['K7622' ,  384],
    ['K7522' ,  384], ['K7422' ,  384], ['K7322' ,  384], ['K6522' ,  384],
    ['K6422' ,  384], ['K6322' ,  384], ['K5422' ,  384], ['K5322' ,  384],
    ['K4322' ,  384], ['QJT22' ,  384], ['QJ922' ,  384], ['QJ822' ,  384],
    ['QJ722' ,  384], ['QJ622' ,  384], ['QJ522' ,  384], ['QJ422' ,  384],
    ['QJ322' ,  384], ['QT922' ,  384], ['QT822' ,  384], ['QT722' ,  384],
    ['QT622' ,  384], ['QT522' ,  384], ['QT422' ,  384], ['QT322' ,  384],
    ['Q9822' ,  384], ['Q9722' ,  384], ['Q9622' ,  384], ['Q9522' ,  384],
    ['Q9422' ,  384], ['Q9322' ,  384], ['Q8722' ,  384], ['Q8622' ,  384],
    ['Q8522' ,  384], ['Q8422' ,  384], ['Q8322' ,  384], ['Q7622' ,  384],
    ['Q7522' ,  384], ['Q7422' ,  384], ['Q7322' ,  384], ['Q6522' ,  384],
    ['Q6422' ,  384], ['Q6322' ,  384], ['Q5422' ,  384], ['Q5322' ,  384],
    ['Q4322' ,  384], ['JT922' ,  384], ['JT822' ,  384], ['JT722' ,  384],
    ['JT622' ,  384], ['JT522' ,  384], ['JT422' ,  384], ['JT322' ,  384],
    ['J9822' ,  384], ['J9722' ,  384], ['J9622' ,  384], ['J9522' ,  384],
    ['J9422' ,  384], ['J9322' ,  384], ['J8722' ,  384], ['J8622' ,  384],
    ['J8522' ,  384], ['J8422' ,  384], ['J8322' ,  384], ['J7622' ,  384],
    ['J7522' ,  384], ['J7422' ,  384], ['J7322' ,  384], ['J6522' ,  384],
    ['J6422' ,  384], ['J6322' ,  384], ['J5422' ,  384], ['J5322' ,  384],
    ['J4322' ,  384], ['T9822' ,  384], ['T9722' ,  384], ['T9622' ,  384],
    ['T9522' ,  384], ['T9422' ,  384], ['T9322' ,  384], ['T8722' ,  384],
    ['T8622' ,  384], ['T8522' ,  384], ['T8422' ,  384], ['T8322' ,  384],
    ['T7622' ,  384], ['T7522' ,  384], ['T7422' ,  384], ['T7322' ,  384],
    ['T6522' ,  384], ['T6422' ,  384], ['T6322' ,  384], ['T5422' ,  384],
    ['T5322' ,  384], ['T4322' ,  384], ['98722' ,  384], ['98622' ,  384],
    ['98522' ,  384], ['98422' ,  384], ['98322' ,  384], ['97622' ,  384],
    ['97522' ,  384], ['97422' ,  384], ['97322' ,  384], ['96522' ,  384],
    ['96422' ,  384], ['96322' ,  384], ['95422' ,  384], ['95322' ,  384],
    ['94322' ,  384], ['87622' ,  384], ['87522' ,  384], ['87422' ,  384],
    ['87322' ,  384], ['86522' ,  384], ['86422' ,  384], ['86322' ,  384],
    ['85422' ,  384], ['85322' ,  384], ['84322' ,  384], ['76522' ,  384],
    ['76422' ,  384], ['76322' ,  384], ['75422' ,  384], ['75322' ,  384],
    ['74322' ,  384], ['65422' ,  384], ['65322' ,  384], ['64322' ,  384],
    ['54322' ,  384], ['AKQJ9' , 1020], ['AKQJ8' , 1020], ['AKQJ7' , 1020],
    ['AKQJ6' , 1020], ['AKQJ5' , 1020], ['AKQJ4' , 1020], ['AKQJ3' , 1020],
    ['AKQJ2' , 1020], ['AKQT9' , 1020], ['AKQT8' , 1020], ['AKQT7' , 1020],
    ['AKQT6' , 1020], ['AKQT5' , 1020], ['AKQT4' , 1020], ['AKQT3' , 1020],
    ['AKQT2' , 1020], ['AKQ98' , 1020], ['AKQ97' , 1020], ['AKQ96' , 1020],
    ['AKQ95' , 1020], ['AKQ94' , 1020], ['AKQ93' , 1020], ['AKQ92' , 1020],
    ['AKQ87' , 1020], ['AKQ86' , 1020], ['AKQ85' , 1020], ['AKQ84' , 1020],
    ['AKQ83' , 1020], ['AKQ82' , 1020], ['AKQ76' , 1020], ['AKQ75' , 1020],
    ['AKQ74' , 1020], ['AKQ73' , 1020], ['AKQ72' , 1020], ['AKQ65' , 1020],
    ['AKQ64' , 1020], ['AKQ63' , 1020], ['AKQ62' , 1020], ['AKQ54' , 1020],
    ['AKQ53' , 1020], ['AKQ52' , 1020], ['AKQ43' , 1020], ['AKQ42' , 1020],
    ['AKQ32' , 1020], ['AKJT9' , 1020], ['AKJT8' , 1020], ['AKJT7' , 1020],
    ['AKJT6' , 1020], ['AKJT5' , 1020], ['AKJT4' , 1020], ['AKJT3' , 1020],
    ['AKJT2' , 1020], ['AKJ98' , 1020], ['AKJ97' , 1020], ['AKJ96' , 1020],
    ['AKJ95' , 1020], ['AKJ94' , 1020], ['AKJ93' , 1020], ['AKJ92' , 1020],
    ['AKJ87' , 1020], ['AKJ86' , 1020], ['AKJ85' , 1020], ['AKJ84' , 1020],
    ['AKJ83' , 1020], ['AKJ82' , 1020], ['AKJ76' , 1020], ['AKJ75' , 1020],
    ['AKJ74' , 1020], ['AKJ73' , 1020], ['AKJ72' , 1020], ['AKJ65' , 1020],
    ['AKJ64' , 1020], ['AKJ63' , 1020], ['AKJ62' , 1020], ['AKJ54' , 1020],
    ['AKJ53' , 1020], ['AKJ52' , 1020], ['AKJ43' , 1020], ['AKJ42' , 1020],
    ['AKJ32' , 1020], ['AKT98' , 1020], ['AKT97' , 1020], ['AKT96' , 1020],
    ['AKT95' , 1020], ['AKT94' , 1020], ['AKT93' , 1020], ['AKT92' , 1020],
    ['AKT87' , 1020], ['AKT86' , 1020], ['AKT85' , 1020], ['AKT84' , 1020],
    ['AKT83' , 1020], ['AKT82' , 1020], ['AKT76' , 1020], ['AKT75' , 1020],
    ['AKT74' , 1020], ['AKT73' , 1020], ['AKT72' , 1020], ['AKT65' , 1020],
    ['AKT64' , 1020], ['AKT63' , 1020], ['AKT62' , 1020], ['AKT54' , 1020],
    ['AKT53' , 1020], ['AKT52' , 1020], ['AKT43' , 1020], ['AKT42' , 1020],
    ['AKT32' , 1020], ['AK987' , 1020], ['AK986' , 1020], ['AK985' , 1020],
    ['AK984' , 1020], ['AK983' , 1020], ['AK982' , 1020], ['AK976' , 1020],
    ['AK975' , 1020], ['AK974' , 1020], ['AK973' , 1020], ['AK972' , 1020],
    ['AK965' , 1020], ['AK964' , 1020], ['AK963' , 1020], ['AK962' , 1020],
    ['AK954' , 1020], ['AK953' , 1020], ['AK952' , 1020], ['AK943' , 1020],
    ['AK942' , 1020], ['AK932' , 1020], ['AK876' , 1020], ['AK875' , 1020],
    ['AK874' , 1020], ['AK873' , 1020], ['AK872' , 1020], ['AK865' , 1020],
    ['AK864' , 1020], ['AK863' , 1020], ['AK862' , 1020], ['AK854' , 1020],
    ['AK853' , 1020], ['AK852' , 1020], ['AK843' , 1020], ['AK842' , 1020],
    ['AK832' , 1020], ['AK765' , 1020], ['AK764' , 1020], ['AK763' , 1020],
    ['AK762' , 1020], ['AK754' , 1020], ['AK753' , 1020], ['AK752' , 1020],
    ['AK743' , 1020], ['AK742' , 1020], ['AK732' , 1020], ['AK654' , 1020],
    ['AK653' , 1020], ['AK652' , 1020], ['AK643' , 1020], ['AK642' , 1020],
    ['AK632' , 1020], ['AK543' , 1020], ['AK542' , 1020], ['AK532' , 1020],
    ['AK432' , 1020], ['AQJT9' , 1020], ['AQJT8' , 1020], ['AQJT7' , 1020],
    ['AQJT6' , 1020], ['AQJT5' , 1020], ['AQJT4' , 1020], ['AQJT3' , 1020],
    ['AQJT2' , 1020], ['AQJ98' , 1020], ['AQJ97' , 1020], ['AQJ96' , 1020],
    ['AQJ95' , 1020], ['AQJ94' , 1020], ['AQJ93' , 1020], ['AQJ92' , 1020],
    ['AQJ87' , 1020], ['AQJ86' , 1020], ['AQJ85' , 1020], ['AQJ84' , 1020],
    ['AQJ83' , 1020], ['AQJ82' , 1020], ['AQJ76' , 1020], ['AQJ75' , 1020],
    ['AQJ74' , 1020], ['AQJ73' , 1020], ['AQJ72' , 1020], ['AQJ65' , 1020],
    ['AQJ64' , 1020], ['AQJ63' , 1020], ['AQJ62' , 1020], ['AQJ54' , 1020],
    ['AQJ53' , 1020], ['AQJ52' , 1020], ['AQJ43' , 1020], ['AQJ42' , 1020],
    ['AQJ32' , 1020], ['AQT98' , 1020], ['AQT97' , 1020], ['AQT96' , 1020],
    ['AQT95' , 1020], ['AQT94' , 1020], ['AQT93' , 1020], ['AQT92' , 1020],
    ['AQT87' , 1020], ['AQT86' , 1020], ['AQT85' , 1020], ['AQT84' , 1020],
    ['AQT83' , 1020], ['AQT82' , 1020], ['AQT76' , 1020], ['AQT75' , 1020],
    ['AQT74' , 1020], ['AQT73' , 1020], ['AQT72' , 1020], ['AQT65' , 1020],
    ['AQT64' , 1020], ['AQT63' , 1020], ['AQT62' , 1020], ['AQT54' , 1020],
    ['AQT53' , 1020], ['AQT52' , 1020], ['AQT43' , 1020], ['AQT42' , 1020],
    ['AQT32' , 1020], ['AQ987' , 1020], ['AQ986' , 1020], ['AQ985' , 1020],
    ['AQ984' , 1020], ['AQ983' , 1020], ['AQ982' , 1020], ['AQ976' , 1020],
    ['AQ975' , 1020], ['AQ974' , 1020], ['AQ973' , 1020], ['AQ972' , 1020],
    ['AQ965' , 1020], ['AQ964' , 1020], ['AQ963' , 1020], ['AQ962' , 1020],
    ['AQ954' , 1020], ['AQ953' , 1020], ['AQ952' , 1020], ['AQ943' , 1020],
    ['AQ942' , 1020], ['AQ932' , 1020], ['AQ876' , 1020], ['AQ875' , 1020],
    ['AQ874' , 1020], ['AQ873' , 1020], ['AQ872' , 1020], ['AQ865' , 1020],
    ['AQ864' , 1020], ['AQ863' , 1020], ['AQ862' , 1020], ['AQ854' , 1020],
    ['AQ853' , 1020], ['AQ852' , 1020], ['AQ843' , 1020], ['AQ842' , 1020],
    ['AQ832' , 1020], ['AQ765' , 1020], ['AQ764' , 1020], ['AQ763' , 1020],
    ['AQ762' , 1020], ['AQ754' , 1020], ['AQ753' , 1020], ['AQ752' , 1020],
    ['AQ743' , 1020], ['AQ742' , 1020], ['AQ732' , 1020], ['AQ654' , 1020],
    ['AQ653' , 1020], ['AQ652' , 1020], ['AQ643' , 1020], ['AQ642' , 1020],
    ['AQ632' , 1020], ['AQ543' , 1020], ['AQ542' , 1020], ['AQ532' , 1020],
    ['AQ432' , 1020], ['AJT98' , 1020], ['AJT97' , 1020], ['AJT96' , 1020],
    ['AJT95' , 1020], ['AJT94' , 1020], ['AJT93' , 1020], ['AJT92' , 1020],
    ['AJT87' , 1020], ['AJT86' , 1020], ['AJT85' , 1020], ['AJT84' , 1020],
    ['AJT83' , 1020], ['AJT82' , 1020], ['AJT76' , 1020], ['AJT75' , 1020],
    ['AJT74' , 1020], ['AJT73' , 1020], ['AJT72' , 1020], ['AJT65' , 1020],
    ['AJT64' , 1020], ['AJT63' , 1020], ['AJT62' , 1020], ['AJT54' , 1020],
    ['AJT53' , 1020], ['AJT52' , 1020], ['AJT43' , 1020], ['AJT42' , 1020],
    ['AJT32' , 1020], ['AJ987' , 1020], ['AJ986' , 1020], ['AJ985' , 1020],
    ['AJ984' , 1020], ['AJ983' , 1020], ['AJ982' , 1020], ['AJ976' , 1020],
    ['AJ975' , 1020], ['AJ974' , 1020], ['AJ973' , 1020], ['AJ972' , 1020],
    ['AJ965' , 1020], ['AJ964' , 1020], ['AJ963' , 1020], ['AJ962' , 1020],
    ['AJ954' , 1020], ['AJ953' , 1020], ['AJ952' , 1020], ['AJ943' , 1020],
    ['AJ942' , 1020], ['AJ932' , 1020], ['AJ876' , 1020], ['AJ875' , 1020],
    ['AJ874' , 1020], ['AJ873' , 1020], ['AJ872' , 1020], ['AJ865' , 1020],
    ['AJ864' , 1020], ['AJ863' , 1020], ['AJ862' , 1020], ['AJ854' , 1020],
    ['AJ853' , 1020], ['AJ852' , 1020], ['AJ843' , 1020], ['AJ842' , 1020],
    ['AJ832' , 1020], ['AJ765' , 1020], ['AJ764' , 1020], ['AJ763' , 1020],
    ['AJ762' , 1020], ['AJ754' , 1020], ['AJ753' , 1020], ['AJ752' , 1020],
    ['AJ743' , 1020], ['AJ742' , 1020], ['AJ732' , 1020], ['AJ654' , 1020],
    ['AJ653' , 1020], ['AJ652' , 1020], ['AJ643' , 1020], ['AJ642' , 1020],
    ['AJ632' , 1020], ['AJ543' , 1020], ['AJ542' , 1020], ['AJ532' , 1020],
    ['AJ432' , 1020], ['AT987' , 1020], ['AT986' , 1020], ['AT985' , 1020],
    ['AT984' , 1020], ['AT983' , 1020], ['AT982' , 1020], ['AT976' , 1020],
    ['AT975' , 1020], ['AT974' , 1020], ['AT973' , 1020], ['AT972' , 1020],
    ['AT965' , 1020], ['AT964' , 1020], ['AT963' , 1020], ['AT962' , 1020],
    ['AT954' , 1020], ['AT953' , 1020], ['AT952' , 1020], ['AT943' , 1020],
    ['AT942' , 1020], ['AT932' , 1020], ['AT876' , 1020], ['AT875' , 1020],
    ['AT874' , 1020], ['AT873' , 1020], ['AT872' , 1020], ['AT865' , 1020],
    ['AT864' , 1020], ['AT863' , 1020], ['AT862' , 1020], ['AT854' , 1020],
    ['AT853' , 1020], ['AT852' , 1020], ['AT843' , 1020], ['AT842' , 1020],
    ['AT832' , 1020], ['AT765' , 1020], ['AT764' , 1020], ['AT763' , 1020],
    ['AT762' , 1020], ['AT754' , 1020], ['AT753' , 1020], ['AT752' , 1020],
    ['AT743' , 1020], ['AT742' , 1020], ['AT732' , 1020], ['AT654' , 1020],
    ['AT653' , 1020], ['AT652' , 1020], ['AT643' , 1020], ['AT642' , 1020],
    ['AT632' , 1020], ['AT543' , 1020], ['AT542' , 1020], ['AT532' , 1020],
    ['AT432' , 1020], ['A9876' , 1020], ['A9875' , 1020], ['A9874' , 1020],
    ['A9873' , 1020], ['A9872' , 1020], ['A9865' , 1020], ['A9864' , 1020],
    ['A9863' , 1020], ['A9862' , 1020], ['A9854' , 1020], ['A9853' , 1020],
    ['A9852' , 1020], ['A9843' , 1020], ['A9842' , 1020], ['A9832' , 1020],
    ['A9765' , 1020], ['A9764' , 1020], ['A9763' , 1020], ['A9762' , 1020],
    ['A9754' , 1020], ['A9753' , 1020], ['A9752' , 1020], ['A9743' , 1020],
    ['A9742' , 1020], ['A9732' , 1020], ['A9654' , 1020], ['A9653' , 1020],
    ['A9652' , 1020], ['A9643' , 1020], ['A9642' , 1020], ['A9632' , 1020],
    ['A9543' , 1020], ['A9542' , 1020], ['A9532' , 1020], ['A9432' , 1020],
    ['A8765' , 1020], ['A8764' , 1020], ['A8763' , 1020], ['A8762' , 1020],
    ['A8754' , 1020], ['A8753' , 1020], ['A8752' , 1020], ['A8743' , 1020],
    ['A8742' , 1020], ['A8732' , 1020], ['A8654' , 1020], ['A8653' , 1020],
    ['A8652' , 1020], ['A8643' , 1020], ['A8642' , 1020], ['A8632' , 1020],
    ['A8543' , 1020], ['A8542' , 1020], ['A8532' , 1020], ['A8432' , 1020],
    ['A7654' , 1020], ['A7653' , 1020], ['A7652' , 1020], ['A7643' , 1020],
    ['A7642' , 1020], ['A7632' , 1020], ['A7543' , 1020], ['A7542' , 1020],
    ['A7532' , 1020], ['A7432' , 1020], ['A6543' , 1020], ['A6542' , 1020],
    ['A6532' , 1020], ['A6432' , 1020], ['KQJT8' , 1020], ['KQJT7' , 1020],
    ['KQJT6' , 1020], ['KQJT5' , 1020], ['KQJT4' , 1020], ['KQJT3' , 1020],
    ['KQJT2' , 1020], ['KQJ98' , 1020], ['KQJ97' , 1020], ['KQJ96' , 1020],
    ['KQJ95' , 1020], ['KQJ94' , 1020], ['KQJ93' , 1020], ['KQJ92' , 1020],
    ['KQJ87' , 1020], ['KQJ86' , 1020], ['KQJ85' , 1020], ['KQJ84' , 1020],
    ['KQJ83' , 1020], ['KQJ82' , 1020], ['KQJ76' , 1020], ['KQJ75' , 1020],
    ['KQJ74' , 1020], ['KQJ73' , 1020], ['KQJ72' , 1020], ['KQJ65' , 1020],
    ['KQJ64' , 1020], ['KQJ63' , 1020], ['KQJ62' , 1020], ['KQJ54' , 1020],
    ['KQJ53' , 1020], ['KQJ52' , 1020], ['KQJ43' , 1020], ['KQJ42' , 1020],
    ['KQJ32' , 1020], ['KQT98' , 1020], ['KQT97' , 1020], ['KQT96' , 1020],
    ['KQT95' , 1020], ['KQT94' , 1020], ['KQT93' , 1020], ['KQT92' , 1020],
    ['KQT87' , 1020], ['KQT86' , 1020], ['KQT85' , 1020], ['KQT84' , 1020],
    ['KQT83' , 1020], ['KQT82' , 1020], ['KQT76' , 1020], ['KQT75' , 1020],
    ['KQT74' , 1020], ['KQT73' , 1020], ['KQT72' , 1020], ['KQT65' , 1020],
    ['KQT64' , 1020], ['KQT63' , 1020], ['KQT62' , 1020], ['KQT54' , 1020],
    ['KQT53' , 1020], ['KQT52' , 1020], ['KQT43' , 1020], ['KQT42' , 1020],
    ['KQT32' , 1020], ['KQ987' , 1020], ['KQ986' , 1020], ['KQ985' , 1020],
    ['KQ984' , 1020], ['KQ983' , 1020], ['KQ982' , 1020], ['KQ976' , 1020],
    ['KQ975' , 1020], ['KQ974' , 1020], ['KQ973' , 1020], ['KQ972' , 1020],
    ['KQ965' , 1020], ['KQ964' , 1020], ['KQ963' , 1020], ['KQ962' , 1020],
    ['KQ954' , 1020], ['KQ953' , 1020], ['KQ952' , 1020], ['KQ943' , 1020],
    ['KQ942' , 1020], ['KQ932' , 1020], ['KQ876' , 1020], ['KQ875' , 1020],
    ['KQ874' , 1020], ['KQ873' , 1020], ['KQ872' , 1020], ['KQ865' , 1020],
    ['KQ864' , 1020], ['KQ863' , 1020], ['KQ862' , 1020], ['KQ854' , 1020],
    ['KQ853' , 1020], ['KQ852' , 1020], ['KQ843' , 1020], ['KQ842' , 1020],
    ['KQ832' , 1020], ['KQ765' , 1020], ['KQ764' , 1020], ['KQ763' , 1020],
    ['KQ762' , 1020], ['KQ754' , 1020], ['KQ753' , 1020], ['KQ752' , 1020],
    ['KQ743' , 1020], ['KQ742' , 1020], ['KQ732' , 1020], ['KQ654' , 1020],
    ['KQ653' , 1020], ['KQ652' , 1020], ['KQ643' , 1020], ['KQ642' , 1020],
    ['KQ632' , 1020], ['KQ543' , 1020], ['KQ542' , 1020], ['KQ532' , 1020],
    ['KQ432' , 1020], ['KJT98' , 1020], ['KJT97' , 1020], ['KJT96' , 1020],
    ['KJT95' , 1020], ['KJT94' , 1020], ['KJT93' , 1020], ['KJT92' , 1020],
    ['KJT87' , 1020], ['KJT86' , 1020], ['KJT85' , 1020], ['KJT84' , 1020],
    ['KJT83' , 1020], ['KJT82' , 1020], ['KJT76' , 1020], ['KJT75' , 1020],
    ['KJT74' , 1020], ['KJT73' , 1020], ['KJT72' , 1020], ['KJT65' , 1020],
    ['KJT64' , 1020], ['KJT63' , 1020], ['KJT62' , 1020], ['KJT54' , 1020],
    ['KJT53' , 1020], ['KJT52' , 1020], ['KJT43' , 1020], ['KJT42' , 1020],
    ['KJT32' , 1020], ['KJ987' , 1020], ['KJ986' , 1020], ['KJ985' , 1020],
    ['KJ984' , 1020], ['KJ983' , 1020], ['KJ982' , 1020], ['KJ976' , 1020],
    ['KJ975' , 1020], ['KJ974' , 1020], ['KJ973' , 1020], ['KJ972' , 1020],
    ['KJ965' , 1020], ['KJ964' , 1020], ['KJ963' , 1020], ['KJ962' , 1020],
    ['KJ954' , 1020], ['KJ953' , 1020], ['KJ952' , 1020], ['KJ943' , 1020],
    ['KJ942' , 1020], ['KJ932' , 1020], ['KJ876' , 1020], ['KJ875' , 1020],
    ['KJ874' , 1020], ['KJ873' , 1020], ['KJ872' , 1020], ['KJ865' , 1020],
    ['KJ864' , 1020], ['KJ863' , 1020], ['KJ862' , 1020], ['KJ854' , 1020],
    ['KJ853' , 1020], ['KJ852' , 1020], ['KJ843' , 1020], ['KJ842' , 1020],
    ['KJ832' , 1020], ['KJ765' , 1020], ['KJ764' , 1020], ['KJ763' , 1020],
    ['KJ762' , 1020], ['KJ754' , 1020], ['KJ753' , 1020], ['KJ752' , 1020],
    ['KJ743' , 1020], ['KJ742' , 1020], ['KJ732' , 1020], ['KJ654' , 1020],
    ['KJ653' , 1020], ['KJ652' , 1020], ['KJ643' , 1020], ['KJ642' , 1020],
    ['KJ632' , 1020], ['KJ543' , 1020], ['KJ542' , 1020], ['KJ532' , 1020],
    ['KJ432' , 1020], ['KT987' , 1020], ['KT986' , 1020], ['KT985' , 1020],
    ['KT984' , 1020], ['KT983' , 1020], ['KT982' , 1020], ['KT976' , 1020],
    ['KT975' , 1020], ['KT974' , 1020], ['KT973' , 1020], ['KT972' , 1020],
    ['KT965' , 1020], ['KT964' , 1020], ['KT963' , 1020], ['KT962' , 1020],
    ['KT954' , 1020], ['KT953' , 1020], ['KT952' , 1020], ['KT943' , 1020],
    ['KT942' , 1020], ['KT932' , 1020], ['KT876' , 1020], ['KT875' , 1020],
    ['KT874' , 1020], ['KT873' , 1020], ['KT872' , 1020], ['KT865' , 1020],
    ['KT864' , 1020], ['KT863' , 1020], ['KT862' , 1020], ['KT854' , 1020],
    ['KT853' , 1020], ['KT852' , 1020], ['KT843' , 1020], ['KT842' , 1020],
    ['KT832' , 1020], ['KT765' , 1020], ['KT764' , 1020], ['KT763' , 1020],
    ['KT762' , 1020], ['KT754' , 1020], ['KT753' , 1020], ['KT752' , 1020],
    ['KT743' , 1020], ['KT742' , 1020], ['KT732' , 1020], ['KT654' , 1020],
    ['KT653' , 1020], ['KT652' , 1020], ['KT643' , 1020], ['KT642' , 1020],
    ['KT632' , 1020], ['KT543' , 1020], ['KT542' , 1020], ['KT532' , 1020],
    ['KT432' , 1020], ['K9876' , 1020], ['K9875' , 1020], ['K9874' , 1020],
    ['K9873' , 1020], ['K9872' , 1020], ['K9865' , 1020], ['K9864' , 1020],
    ['K9863' , 1020], ['K9862' , 1020], ['K9854' , 1020], ['K9853' , 1020],
    ['K9852' , 1020], ['K9843' , 1020], ['K9842' , 1020], ['K9832' , 1020],
    ['K9765' , 1020], ['K9764' , 1020], ['K9763' , 1020], ['K9762' , 1020],
    ['K9754' , 1020], ['K9753' , 1020], ['K9752' , 1020], ['K9743' , 1020],
    ['K9742' , 1020], ['K9732' , 1020], ['K9654' , 1020], ['K9653' , 1020],
    ['K9652' , 1020], ['K9643' , 1020], ['K9642' , 1020], ['K9632' , 1020],
    ['K9543' , 1020], ['K9542' , 1020], ['K9532' , 1020], ['K9432' , 1020],
    ['K8765' , 1020], ['K8764' , 1020], ['K8763' , 1020], ['K8762' , 1020],
    ['K8754' , 1020], ['K8753' , 1020], ['K8752' , 1020], ['K8743' , 1020],
    ['K8742' , 1020], ['K8732' , 1020], ['K8654' , 1020], ['K8653' , 1020],
    ['K8652' , 1020], ['K8643' , 1020], ['K8642' , 1020], ['K8632' , 1020],
    ['K8543' , 1020], ['K8542' , 1020], ['K8532' , 1020], ['K8432' , 1020],
    ['K7654' , 1020], ['K7653' , 1020], ['K7652' , 1020], ['K7643' , 1020],
    ['K7642' , 1020], ['K7632' , 1020], ['K7543' , 1020], ['K7542' , 1020],
    ['K7532' , 1020], ['K7432' , 1020], ['K6543' , 1020], ['K6542' , 1020],
    ['K6532' , 1020], ['K6432' , 1020], ['K5432' , 1020], ['QJT97' , 1020],
    ['QJT96' , 1020], ['QJT95' , 1020], ['QJT94' , 1020], ['QJT93' , 1020],
    ['QJT92' , 1020], ['QJT87' , 1020], ['QJT86' , 1020], ['QJT85' , 1020],
    ['QJT84' , 1020], ['QJT83' , 1020], ['QJT82' , 1020], ['QJT76' , 1020],
    ['QJT75' , 1020], ['QJT74' , 1020], ['QJT73' , 1020], ['QJT72' , 1020],
    ['QJT65' , 1020], ['QJT64' , 1020], ['QJT63' , 1020], ['QJT62' , 1020],
    ['QJT54' , 1020], ['QJT53' , 1020], ['QJT52' , 1020], ['QJT43' , 1020],
    ['QJT42' , 1020], ['QJT32' , 1020], ['QJ987' , 1020], ['QJ986' , 1020],
    ['QJ985' , 1020], ['QJ984' , 1020], ['QJ983' , 1020], ['QJ982' , 1020],
    ['QJ976' , 1020], ['QJ975' , 1020], ['QJ974' , 1020], ['QJ973' , 1020],
    ['QJ972' , 1020], ['QJ965' , 1020], ['QJ964' , 1020], ['QJ963' , 1020],
    ['QJ962' , 1020], ['QJ954' , 1020], ['QJ953' , 1020], ['QJ952' , 1020],
    ['QJ943' , 1020], ['QJ942' , 1020], ['QJ932' , 1020], ['QJ876' , 1020],
    ['QJ875' , 1020], ['QJ874' , 1020], ['QJ873' , 1020], ['QJ872' , 1020],
    ['QJ865' , 1020], ['QJ864' , 1020], ['QJ863' , 1020], ['QJ862' , 1020],
    ['QJ854' , 1020], ['QJ853' , 1020], ['QJ852' , 1020], ['QJ843' , 1020],
    ['QJ842' , 1020], ['QJ832' , 1020], ['QJ765' , 1020], ['QJ764' , 1020],
    ['QJ763' , 1020], ['QJ762' , 1020], ['QJ754' , 1020], ['QJ753' , 1020],
    ['QJ752' , 1020], ['QJ743' , 1020], ['QJ742' , 1020], ['QJ732' , 1020],
    ['QJ654' , 1020], ['QJ653' , 1020], ['QJ652' , 1020], ['QJ643' , 1020],
    ['QJ642' , 1020], ['QJ632' , 1020], ['QJ543' , 1020], ['QJ542' , 1020],
    ['QJ532' , 1020], ['QJ432' , 1020], ['QT987' , 1020], ['QT986' , 1020],
    ['QT985' , 1020], ['QT984' , 1020], ['QT983' , 1020], ['QT982' , 1020],
    ['QT976' , 1020], ['QT975' , 1020], ['QT974' , 1020], ['QT973' , 1020],
    ['QT972' , 1020], ['QT965' , 1020], ['QT964' , 1020], ['QT963' , 1020],
    ['QT962' , 1020], ['QT954' , 1020], ['QT953' , 1020], ['QT952' , 1020],
    ['QT943' , 1020], ['QT942' , 1020], ['QT932' , 1020], ['QT876' , 1020],
    ['QT875' , 1020], ['QT874' , 1020], ['QT873' , 1020], ['QT872' , 1020],
    ['QT865' , 1020], ['QT864' , 1020], ['QT863' , 1020], ['QT862' , 1020],
    ['QT854' , 1020], ['QT853' , 1020], ['QT852' , 1020], ['QT843' , 1020],
    ['QT842' , 1020], ['QT832' , 1020], ['QT765' , 1020], ['QT764' , 1020],
    ['QT763' , 1020], ['QT762' , 1020], ['QT754' , 1020], ['QT753' , 1020],
    ['QT752' , 1020], ['QT743' , 1020], ['QT742' , 1020], ['QT732' , 1020],
    ['QT654' , 1020], ['QT653' , 1020], ['QT652' , 1020], ['QT643' , 1020],
    ['QT642' , 1020], ['QT632' , 1020], ['QT543' , 1020], ['QT542' , 1020],
    ['QT532' , 1020], ['QT432' , 1020], ['Q9876' , 1020], ['Q9875' , 1020],
    ['Q9874' , 1020], ['Q9873' , 1020], ['Q9872' , 1020], ['Q9865' , 1020],
    ['Q9864' , 1020], ['Q9863' , 1020], ['Q9862' , 1020], ['Q9854' , 1020],
    ['Q9853' , 1020], ['Q9852' , 1020], ['Q9843' , 1020], ['Q9842' , 1020],
    ['Q9832' , 1020], ['Q9765' , 1020], ['Q9764' , 1020], ['Q9763' , 1020],
    ['Q9762' , 1020], ['Q9754' , 1020], ['Q9753' , 1020], ['Q9752' , 1020],
    ['Q9743' , 1020], ['Q9742' , 1020], ['Q9732' , 1020], ['Q9654' , 1020],
    ['Q9653' , 1020], ['Q9652' , 1020], ['Q9643' , 1020], ['Q9642' , 1020],
    ['Q9632' , 1020], ['Q9543' , 1020], ['Q9542' , 1020], ['Q9532' , 1020],
    ['Q9432' , 1020], ['Q8765' , 1020], ['Q8764' , 1020], ['Q8763' , 1020],
    ['Q8762' , 1020], ['Q8754' , 1020], ['Q8753' , 1020], ['Q8752' , 1020],
    ['Q8743' , 1020], ['Q8742' , 1020], ['Q8732' , 1020], ['Q8654' , 1020],
    ['Q8653' , 1020], ['Q8652' , 1020], ['Q8643' , 1020], ['Q8642' , 1020],
    ['Q8632' , 1020], ['Q8543' , 1020], ['Q8542' , 1020], ['Q8532' , 1020],
    ['Q8432' , 1020], ['Q7654' , 1020], ['Q7653' , 1020], ['Q7652' , 1020],
    ['Q7643' , 1020], ['Q7642' , 1020], ['Q7632' , 1020], ['Q7543' , 1020],
    ['Q7542' , 1020], ['Q7532' , 1020], ['Q7432' , 1020], ['Q6543' , 1020],
    ['Q6542' , 1020], ['Q6532' , 1020], ['Q6432' , 1020], ['Q5432' , 1020],
    ['JT986' , 1020], ['JT985' , 1020], ['JT984' , 1020], ['JT983' , 1020],
    ['JT982' , 1020], ['JT976' , 1020], ['JT975' , 1020], ['JT974' , 1020],
    ['JT973' , 1020], ['JT972' , 1020], ['JT965' , 1020], ['JT964' , 1020],
    ['JT963' , 1020], ['JT962' , 1020], ['JT954' , 1020], ['JT953' , 1020],
    ['JT952' , 1020], ['JT943' , 1020], ['JT942' , 1020], ['JT932' , 1020],
    ['JT876' , 1020], ['JT875' , 1020], ['JT874' , 1020], ['JT873' , 1020],
    ['JT872' , 1020], ['JT865' , 1020], ['JT864' , 1020], ['JT863' , 1020],
    ['JT862' , 1020], ['JT854' , 1020], ['JT853' , 1020], ['JT852' , 1020],
    ['JT843' , 1020], ['JT842' , 1020], ['JT832' , 1020], ['JT765' , 1020],
    ['JT764' , 1020], ['JT763' , 1020], ['JT762' , 1020], ['JT754' , 1020],
    ['JT753' , 1020], ['JT752' , 1020], ['JT743' , 1020], ['JT742' , 1020],
    ['JT732' , 1020], ['JT654' , 1020], ['JT653' , 1020], ['JT652' , 1020],
    ['JT643' , 1020], ['JT642' , 1020], ['JT632' , 1020], ['JT543' , 1020],
    ['JT542' , 1020], ['JT532' , 1020], ['JT432' , 1020], ['J9876' , 1020],
    ['J9875' , 1020], ['J9874' , 1020], ['J9873' , 1020], ['J9872' , 1020],
    ['J9865' , 1020], ['J9864' , 1020], ['J9863' , 1020], ['J9862' , 1020],
    ['J9854' , 1020], ['J9853' , 1020], ['J9852' , 1020], ['J9843' , 1020],
    ['J9842' , 1020], ['J9832' , 1020], ['J9765' , 1020], ['J9764' , 1020],
    ['J9763' , 1020], ['J9762' , 1020], ['J9754' , 1020], ['J9753' , 1020],
    ['J9752' , 1020], ['J9743' , 1020], ['J9742' , 1020], ['J9732' , 1020],
    ['J9654' , 1020], ['J9653' , 1020], ['J9652' , 1020], ['J9643' , 1020],
    ['J9642' , 1020], ['J9632' , 1020], ['J9543' , 1020], ['J9542' , 1020],
    ['J9532' , 1020], ['J9432' , 1020], ['J8765' , 1020], ['J8764' , 1020],
    ['J8763' , 1020], ['J8762' , 1020], ['J8754' , 1020], ['J8753' , 1020],
    ['J8752' , 1020], ['J8743' , 1020], ['J8742' , 1020], ['J8732' , 1020],
    ['J8654' , 1020], ['J8653' , 1020], ['J8652' , 1020], ['J8643' , 1020],
    ['J8642' , 1020], ['J8632' , 1020], ['J8543' , 1020], ['J8542' , 1020],
    ['J8532' , 1020], ['J8432' , 1020], ['J7654' , 1020], ['J7653' , 1020],
    ['J7652' , 1020], ['J7643' , 1020], ['J7642' , 1020], ['J7632' , 1020],
    ['J7543' , 1020], ['J7542' , 1020], ['J7532' , 1020], ['J7432' , 1020],
    ['J6543' , 1020], ['J6542' , 1020], ['J6532' , 1020], ['J6432' , 1020],
    ['J5432' , 1020], ['T9875' , 1020], ['T9874' , 1020], ['T9873' , 1020],
    ['T9872' , 1020], ['T9865' , 1020], ['T9864' , 1020], ['T9863' , 1020],
    ['T9862' , 1020], ['T9854' , 1020], ['T9853' , 1020], ['T9852' , 1020],
    ['T9843' , 1020], ['T9842' , 1020], ['T9832' , 1020], ['T9765' , 1020],
    ['T9764' , 1020], ['T9763' , 1020], ['T9762' , 1020], ['T9754' , 1020],
    ['T9753' , 1020], ['T9752' , 1020], ['T9743' , 1020], ['T9742' , 1020],
    ['T9732' , 1020], ['T9654' , 1020], ['T9653' , 1020], ['T9652' , 1020],
    ['T9643' , 1020], ['T9642' , 1020], ['T9632' , 1020], ['T9543' , 1020],
    ['T9542' , 1020], ['T9532' , 1020], ['T9432' , 1020], ['T8765' , 1020],
    ['T8764' , 1020], ['T8763' , 1020], ['T8762' , 1020], ['T8754' , 1020],
    ['T8753' , 1020], ['T8752' , 1020], ['T8743' , 1020], ['T8742' , 1020],
    ['T8732' , 1020], ['T8654' , 1020], ['T8653' , 1020], ['T8652' , 1020],
    ['T8643' , 1020], ['T8642' , 1020], ['T8632' , 1020], ['T8543' , 1020],
    ['T8542' , 1020], ['T8532' , 1020], ['T8432' , 1020], ['T7654' , 1020],
    ['T7653' , 1020], ['T7652' , 1020], ['T7643' , 1020], ['T7642' , 1020],
    ['T7632' , 1020], ['T7543' , 1020], ['T7542' , 1020], ['T7532' , 1020],
    ['T7432' , 1020], ['T6543' , 1020], ['T6542' , 1020], ['T6532' , 1020],
    ['T6432' , 1020], ['T5432' , 1020], ['98764' , 1020], ['98763' , 1020],
    ['98762' , 1020], ['98754' , 1020], ['98753' , 1020], ['98752' , 1020],
    ['98743' , 1020], ['98742' , 1020], ['98732' , 1020], ['98654' , 1020],
    ['98653' , 1020], ['98652' , 1020], ['98643' , 1020], ['98642' , 1020],
    ['98632' , 1020], ['98543' , 1020], ['98542' , 1020], ['98532' , 1020],
    ['98432' , 1020], ['97654' , 1020], ['97653' , 1020], ['97652' , 1020],
    ['97643' , 1020], ['97642' , 1020], ['97632' , 1020], ['97543' , 1020],
    ['97542' , 1020], ['97532' , 1020], ['97432' , 1020], ['96543' , 1020],
    ['96542' , 1020], ['96532' , 1020], ['96432' , 1020], ['95432' , 1020],
    ['87653' , 1020], ['87652' , 1020], ['87643' , 1020], ['87642' , 1020],
    ['87632' , 1020], ['87543' , 1020], ['87542' , 1020], ['87532' , 1020],
    ['87432' , 1020], ['86543' , 1020], ['86542' , 1020], ['86532' , 1020],
    ['86432' , 1020], ['85432' , 1020], ['76542' , 1020], ['76532' , 1020],
    ['76432' , 1020], ['75432' , 1020],
  ],
  'coun' => { # important Poker data counts and totals
    'rivers'                     =>         '46', # choo(46, 1) after turn
    'turns'                      =>         '47', # choo(47, 1) after hole+flop
    'shorthand_holes'            =>        '169',
    'shorthand_flops'            =>        '741',
    'heads_up_holes'             =>        '990', # choo(45, 2) after board
    'holes'                      =>       '1326', # choo(52, 2)
    'turns_&&_rivers'            =>       '2162',
    'turns_and_rivers'           =>       '2162',
    'shorthand_hands'            =>       '7462', #             same #of boards
    'flops_after_hole'           =>      '19600', # choo(50, 3)
    'flops'                      =>      '22100', # choo(52, 3)
    'boards_after_hole'          =>    '2118760', # choo(50, 5)
    'hands'                      =>    '2598960', # choo(52, 5) same #of boards
    'holes_&&_boards'            =>  '133784560', # choo(52, 7)
    'holes_and_boards'           =>  '133784560', # choo(52, 7)
    'heads_up_compares_per_hole' => '2097572400', # choo(50, 5) * choo(45, 2)
  },
  'namz' => { # hand score range starts and names
       '0' => 'Royal Flush',     #  Royal    Flush     0           1
       '1' => 'Straight Flush',  #  Straight Flush     1..   9     9
      '10' => 'Four-of-a-Kind',  #  Four-of-a-Kind    10.. 165   156
     '166' => 'Full House',      #  Full House       166.. 321   156
     '322' => 'Flush',           #           Flush   322..1598  1277
    '1599' => 'Straight',        #  Straight        1599..1608    10
    '1609' => 'Three-of-a-Kind', #  Three-of-a-Kind 1609..2466   858
    '2467' => 'Two Pair',        #  Two Pair        2467..3324   858
    '3325' => 'One Pair',        #  One Pair        3325..6184  2860
    '6185' => 'High Card',       #  High Card       6185..7461  1277
  },
# rank and suit progressions and names
  'rprg' => ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'],
  'sprg' => ['s', 'h', 'd', 'c'], # Spade, Heart, Diamond, Club  (Club, Diam)?
  'rnam' => ['Ace',   'King', 'Queen', 'Jack', 'Ten',   'Nine', 'Eight',
             'Seven', 'Six',  'Five',  'Four', 'Three', 'Two'], # Rank Names
  'snam' => ['Spades', 'Hearts', 'Diamonds', 'Clubs'],          # Suit Names
);
@rprg = @{$pdat{'rprg'}}; @rnam = @{$pdat{'rnam'}};
@sprg = @{$pdat{'sprg'}}; @snam = @{$pdat{'snam'}};
%namz = %{$pdat{'namz'}}; %zman = reverse(%namz);
for($indx = 0; $indx < @rprg; $indx++) { $rprv{$rprg[$indx]} = $indx; }
for(@{$pdat{'holz'}})                  { push(@holz, $_->[0]);        }
for($indx = 0; $indx < @holz; $indx++) { $zloh{$holz[$indx]} = $indx; }
for(@{$pdat{'flpz'}})                  { push(@flpz, $_->[0]);        }
for($indx = 0; $indx < @flpz; $indx++) { $zplf{$flpz[$indx]} = $indx; }
for(@{$pdat{'hndz'}})                  { push(@hndz, $_->[0]);        }
for($indx = 0; $indx < @hndz; $indx++) { $zdnh{$hndz[$indx]} = $indx; }
127;
