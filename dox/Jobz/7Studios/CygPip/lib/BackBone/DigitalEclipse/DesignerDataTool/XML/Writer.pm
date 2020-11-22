#!/usr/bin/perl -w
# 43B5Y9E - BackBone::DigitalEclipse::DesignerDataTool::XML::Writer.pm
#   created by Pip Stuart <Pip@CPAN.Org>, <PipS@DigitalEclipse.Com> to
#   export internal data structures to disk xml files which are valid
#   instances of our schemas.

=head1 NAME

BackBone::DigitalEclipse::DesignerDataTool::XML::Writer - save memory data structure to a valid instance of an XML schema

=head1 VERSION

This documentation refers to version 1.0.44A1GBw of 
BackBone::DigitalEclipse::DesignerDataTool::XML::Writer,
which was released on Sat Apr 10 01:16:11:58 2004.

=head1 SYNOPSIS

  use BackBone::DigitalEclipse::DesignerDataTool::XML::Writer;
  
  my $xml_tree = [
                   'project', [
                     { 
                       'author' => 'DataDocument AuthorName',
                       'title'  => 'Project Name',
                     }, 0, '\n',
                     'constant', [
                       {}, 0, '\n',
                       'global', [
                         {}, 0, '\n',
                       ]
                       'player', [
                         {}, 0, '\n',
                       ]
                       'modifier', [
                         {}, 0, '\n',
                         'strength_amplifier', [
                           {}, 0, '\n',
                         ]
                         'weaken', [
                           {}, 0, '\n',
                         ]
                         'health_pack', [
                           {}, 0, '\n',
                         ]
                       ]
                     ]
                     'character', [
                       {}, 0, '\n',
                       'rikochet', [
                         {}, 0, '\n',
                       ]
                       'buena_girl', [
                         {}, 0, '\n',
                       ]
                       'minotoro', [
                         {}, 0, '\n',
                       ]
                     ]
                   ]
                 ];
  my $xml_file = 'BB-DE-ML-GameData.xml';
  Write( $xml_tree, $xml_file );

=head1 DESCRIPTION

This module just exports a Write() method to create a disk xml file
formatted cleanly.

=head1 2DO

=over 2

=item - preserve comments && processing instructions!!!

=item - mk obj IF

=item - add per proj child classes

=item - format proj-specific data nicely

=item -     What else does Writer need?

=back

=head1 USAGE

=head2 Write( $XML_Parser_Tree_Data_Structure, $XML_Output_FileName )

Write is the only exported function.  It simply formats the tree data
into XML && writes the file.

=head1 CHANGES

Revision history for Perl extension BackBone::DigitalEclipse::DesignerDataTool::XML::Writer:

=over 4

=item - 1.0.44A1GBw  Sat Apr 10 01:16:11:58 2004

* fixed characters to accept '0' zero value

=item - 1.0.43B5Y9E  Thu Mar 11 05:34:09:14 2004.

* original version

=back

=head1 INSTALL

If you're using ActiveState, you probably need to make 'BackBone\
  DigitalEclipse\DesignerDataTool\XML\' in your 'C:\Perl\site\lib\'
  && copy this file there.
  
If you don't understand how to do this, please ask me or support for
  assistance.

=head1 FILES

BackBone::DigitalEclipse::DesignerDataTool::XML::Writer requires:

L<Carp>                to allow errors to croak() from calling sub

L<IO::File>            to provide a filehandle object

L<XML::Writer>         to streamline tag generation

=head1 LICENSE

This code is Copyright (c) Pip Stuart && BackBone Entertainment 2004.
All rights reserved.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>, <PipS@DigitalEclipse.Com>

=cut

package BackBone::DigitalEclipse::DesignerDataTool::XML::Writer;
require Exporter;
use warnings;
use strict;
use base qw( Exporter );
use Carp;
use IO::File;
use XML::Writer;
our $VERSION     = '1.0.44A1GBw'; # major . minor . PipTimeStamp
our $PTVR        = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major and minor
# See http://Ax9.Org/pt?$PTVR and `perldoc Time::PT`
our @EXPORT      = qw( Write );
my $DEBUG_MODE   = 0;
my $writer;

sub Write { # write the xml file
  my $tree = shift || croak '!*EROR*! Write requires a data tree parameter!';
  my $file = shift || 'default.xml';
  my $continue = 'y'; # flag in case file exists && shouldn't be clobbered
  my $output; 
  if(0&& -e $file) {
    print "*WARNING* Output XML File: $file already exists!\nContinuing will overwrite it!...  Continue? (Y/N) ";
    $continue = <STDIN>;
  }
  if($continue =~ /y/i && @{$tree}) {
    $output = IO::File->new( ">$file" );
    $writer = XML::Writer->new( OUTPUT      => $output,
                                UNSAFE      => 'true',
                                DATA_MODE   => 'true',
                                DATA_INDENT => 2 );
      # *NOTE* UNSAFE above is not really unsafe... it just means that some
      #   well-formedness checking won't be done.  The reason I am employing
      #   this option is to allow mixed content to be printed in DATA_MODE.
    $writer->xmlDecl( 'utf-8' );
#  my $xml_tree = [
#                   'project', [
#                     { 
#                       'author' => 'DataDocument AuthorName',
#                       'title'  => 'Project Name',
#                     }, 0, '\n',
#                     'constant', [
#                       {}, 0, '\n',
#                       'global', [
#                         {}, 0, '\n',
#                       ]
#                     ]
#                   ]
#                 ]
    Climb($tree);
    $writer->end();
    $output->close();
    open(FILE, "<$file");
    my $full_data = join('', <FILE>);
    close(FILE);
    open(FILE, ">$file");
    while($full_data =~ /\n\s*?\n/) {
      $full_data =~ s/\n\s*?\n/\n/g; # strip multiple adjacent newlines
    }
    print FILE $full_data;
    close(FILE);
  }
}

sub Climb {
  my $limb = shift; my $i;
  for($i = 0; $i < @{$limb}; $i++) {
    if(ref($limb->[$i]) eq 'HASH') {
      if($DEBUG_MODE) {
        foreach(sort(keys(%{$limb->[$i]}))) {
          print "hashkey found: $_ => $limb->[$i]->{$_}\n";
        }
      }
      $i++;
      print   "hashattz numb? " , $limb->[$i],  "\n" if($DEBUG_MODE && $limb->[$i]);
      $i++;
      print   "hashelem data: '", $limb->[$i], "'\n" if($DEBUG_MODE && $limb->[$i]);
      $writer->characters(        $limb->[$i])       if(defined($limb->[$i]) && length($limb->[$i]) && $limb->[$i] ne "\n");
    } else {
      print "elemelemfound: $limb->[$i]\n" if($DEBUG_MODE);
      if(ref($limb->[($i + 1)]->[0]) eq 'HASH') {
        # sort the attribute hash
        my @attributes = ();
        foreach(sort(keys(%{$limb->[($i + 1)]->[0]}))) {
          push(@attributes, $_, $limb->[($i + 1)]->[0]->{$_});
        }
        $writer->startTag($limb->[$i], @attributes);
      } else {
        $writer->startTag($limb->[$i]);
      }
      Climb($limb->[$i]) if($limb->[++$i]);
      $i++;
      print "elemattz numb? " , $limb->[$i],  "\n" if($DEBUG_MODE && $limb->[$i]);
      $i++;
      print "elemelem data: '", $limb->[$i], "'\n" if($DEBUG_MODE && $limb->[$i]);
#      $writer->characters(      $limb->[$i])       if($limb->[$i]);
      $writer->endTag();
    }
  }
}

127;
