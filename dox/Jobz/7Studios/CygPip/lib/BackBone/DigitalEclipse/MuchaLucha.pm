#!/usr/bin/perl -w
# 44F422h - BackBone::DigitalEclipse::MuchaLucha.pm
#   created by Pip Stuart <Pip@CPAN.Org>, <PipS@DigitalEclipse.Com> to
#   export useful functions for our Mucha Lucha PlayStation2 project.

=head1 NAME

BackBone::DigitalEclipse::MuchaLucha - useful MuchaLucha project functions

=head1 VERSION

This documentation refers to version 1.0.44F422h of 
BackBone::DigitalEclipse::MuchaLucha,
which was released on Thu Apr 15 04:02:02:43 2004.

=head1 SYNOPSIS

  use BackBone::DigitalEclipse::MuchaLucha;

  foreach my $char_code (CharCodes()) {
    my $char_name = Code2Name($char_code);
    print "Char Code: $char_code  is short for: $char_name\n";
  }

=head1 DESCRIPTION

This module just exports a few useful functions for the MuchaLucha
project.

=head1 2DO

=over 2

=item -     What else does MuchaLucha need?

=back

=head1 USAGE

=head2 CharCodes()

Returns an array of scalar strings which are the character name
abbreviation codes used in many filenames throughout our project.

=head2 CharNames()

Returns an array of scalar strings which are the full character
names for all the characters in our project.

=head2 Code2Name($char_code)

Returns the corresponding full character name for the passed in
$char_code.

=head2 Name2Code($char_name)

Returns the corresponding character code for the passed in 
$char_name.

=head1 CHANGES

Revision history for Perl extension BackBone::DigitalEclipse::MuchaLucha:

=over 4

=item - 1.0.44F5Zrm  Thu Apr 15 05:35:53:48 2004

* made function names more consistent && updated pod

=item - 1.0.44F422h  Thu Apr 15 04:02:02:43 2004

* original version

=back

=head1 INSTALL

If you're using ActiveState, you probably need to make 'BackBone\
  DigitalEclipse\DesignerDataTool\XML\' in your 'C:\Perl\site\lib\'
  && copy this file there.
  
If you don't understand how to do this, please ask me or support for
  assistance.

=head1 FILES

BackBone::DigitalEclipse::MuchaLucha requires:

L<Carp>                to allow errors to croak() from calling sub

=head1 LICENSE

This code is Copyright (c) Pip Stuart && BackBone Entertainment 2004.
All rights reserved.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>, <PipS@DigitalEclipse.Com>

=cut

package BackBone::DigitalEclipse::MuchaLucha;
require Exporter;
use warnings;
use strict;
use base qw( Exporter );
use Carp;
our $VERSION     = '1.0.44G7qmd'; # major . minor . PipTimeStamp
our $PTVR        = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major and minor
# See http://Ax9.Org/pt?$PTVR and `perldoc Time::PT`
our @EXPORT      = qw( CharCodes CharNames Code2Name Name2Code );
my $DEBUG_MODE   = 0;
my @CHAR_NAME_DATA = ( # *NOTE* Question marks '?' in codes mean I'm not sure
  ['DFLT', 'Default'           ],
  ['RI'  , 'Rikochet'          ],
  ['BG'  , 'Buena Girl'        ],
  ['FL'  , 'Flea'              ],
  ['PP'  , 'Penny Plutonium'   ],
  ['DF?' , 'Dragonfly'         ],
  ['FT'  , 'French Twist'      ],
  ['PJ'  , 'Potato Potata Jr.' ],
  ['SK?' , 'Skellantonio'      ],
  ['EF?' , 'Ensalada de Frutas'],
  ['MT'  , 'Minotoro'          ],
  ['RM?' , 'Ratman'            ],
  ['ZK?' , 'Zero Kelvin'       ],
  ['NN?' , 'Double Ninja Ninja'],
  ['PS?' , 'Perro Slavaje'     ],
  ['SS?' , 'Sonic Sumo'        ],
  ['TT?' , 'Tibor the Terrible'],
  ['MG?' , 'Mysterioso Grande' ],
  ['MD?' , 'Masked Dog'        ],
  ['ER?' , 'El Rey'            ],
  ['SP?' , 'Snow Pea'          ],
  ['WT'  , 'Werewolf Thug'     ],
  ['ES?' , 'El Scientifico'    ],
  ['HM?' , 'Head Mistress'     ],
  ['HB?' , 'Hasbeena'          ],
  ['MC?' , 'Midcarda'          ],
  ['UC?' , 'Unicorn'           ],
);

sub CharCodes { # return all character codes
  my @code = ();
  foreach(@CHAR_NAME_DATA) { push(@code, $_->[0]); }
  return(@code);
}
sub CharNames { # return all character names
  my @name = ();
  foreach(@CHAR_NAME_DATA) { push(@name, $_->[1]); }
  return(@name);
}
sub Code2Name { # return the corresponding name for the passed in code
  my $code = shift || return(0);
  foreach(@CHAR_NAME_DATA) {
    return($_->[1]) if($_->[0] eq $code);
  }
  return(0);
}
sub Name2Code { # return the corresponding code for the passed in name
  my $name = shift || return(0); $name =~ s/_/ /g;
  foreach(@CHAR_NAME_DATA) {
    return($_->[0]) if($_->[1] =~ /$name/i);
  }
  return(0);
}

127;
