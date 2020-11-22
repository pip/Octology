# 7AJAwe6 - SuperCopyResources2Turbo.pm created by Pip Stuart <Pip@TrilogyStudios.Com> as an adaptation && upgrade of both
#   Z:/Tools/Scripts/THERE/superCopyResources.vbs &&
#   Z:/Tools/Scripts/THERE/THERE_parseSyncResults.pl since they can be handled more consistently together within a single Perl module (&& wrapper script).
#   Following are the old notes from THERE_parseSyncResults.pl:
# 7AC8qe2 - Z:/Tools/Scripts/THERE/THERE_parseSyncResults.pl being digested by Pip Stuart <Pip@CPAN.Org> as traced from:
#           Z:/Tools/Scripts/THERE/superCopyResources.vbs which takes DragNDrop filename params && writes C:/THERE_CopyTheseFiles.txt before calling:
#          `%comspec% /K title Super Copy Resources |  perl Z:\Tools\Scripts\THERE\THERE_parseSyncResults.pl THERE_CopyTheseFiles.txt`
# Description:  Reads the c:\syncResults.txt file and extracts changes.  The changes can then be sent to other programs.  In this case, they are sent to
#   /c/clients/dqd/src/Tool/Resources/MakeOneResource.pl, to auto copy new src/Assets to bld/Resources.
# Notes: $COMSPEC is case-sensitive in CygWin so even though it won't matter for a VisualBasicScript (.vbs),beware %comspec% does not always equal %ComSpec%...
#  + using strict is good, so we should
#  + fileparse() should probably be used in place of (dir|base)name() for consistent behavior (see `perldoc File::Basename` for more info)
#  + if you're going to 'use File::Copy', then you should probably employ copy() or cp() within the code instead of system("cp ...")
#  + using system("DEL ...") is bad form when Perl has a built-in cross-platform unlink()
#  - XML::Tidy objects would be better than XML::Simple if data files will ever become more than just the most basic single hash data-structure
#  + Data::Dumper was not being used (so I've removed it from the "use" modules)
#  - File::Path is being used for one lone mkpath() call which may be unnecessary (but I've left it in since it might remain needed)
# Plan:
# 7AGJ3Q5 - Robin's notes:
#   XML Settings File:
#     Investigate exclusion vs. inclusion of file formats.  Note: if not sending all formats thru copyresources.pl, we need finite list of what needs to be
#       converted (currently called convert files in the XML).  Off the top of my head: /\.(jpg|wav|animation)/ are converts.  The rest are quick-copies.
#         + I think we should make inclusive regexes for each group (including the probably largest group that just gets quick-copies), tested in
#           approximately decending order of the group's size relative to other groups.
#     Better feedback for Syncs: clear review of what was sync'd (can be simple for this revision, full report feature to come later)
#         + Filtering the syncResults.txt output
#     Console-based progress bar?
#         + Probably initially it should just be a percent-complete or something bare-bones && then later be promoted to screen-handling or GUI.
#     Perl-ize the sync scripts for better consistency and more control
#     Exporting to a SCR.BAT sucks
#     Change process so that final step isn't batch file, but rather a perl script which loops thru filelist and executes copyresources.pl when needed.
#     Maintaining bld/ and src/ sanity (new)
#     Copyresources.bat  (called from a big perlscript called configure) tries to keep bld/ tidy - it looks over src/ and actually removes files from the build
#        folder that are not present.  This is a great idea in theory because it would prevent our bld/ from overtime becoming bloated with old assets.
#        But currently it's inconsistent, slow, and therefore unreliable.
#   How would you go about adding this sort of "cleanup" functionality to SCR?
#     i.  Could it run a cleanup function after every nth file you copy? ...or after every file - cleaning up only the directory you copy into?
#     ii. Would there be a separate mode that would run only when people sync?
#   75% this week:  in TS_There code (mel)
#   For Wednesday, the SCR interface needs to be cleaned up / optimized for the updated SCR script you're creating.
#   It would be great if you could also fix the auto-texture-copyover bug, and cleanup how Maya reports the output of SCR when it interfaces with it
#     i.  Whenever a .scene is exported, it calls SCR
#     ii. Whenever a .model is exported, it calls SCR, and optionally copies related textures along with the .model (this is where the bug is: when you try to
#           export more than one .model, only textures for one .model get pushed to SCR)
#   General thoughts:
#     -   SCR should still work across any branch that you call it within
#       o   Dqd    dqlf
#       o   What happens when you call it when not in a branch?  Could it ask you where to cp files into? That could be very powerful - to be able to copy
#             assets from ANYWHERE into your build folder.
#     -   The "30 file limit":
#       o   Apps access more than 30 files all the time. I have a feeling we'll need a simple windows executable scr wrapper in order to bypass this limitation
#         from: HTTP://ASPN.ActiveState.Com/ASPN/Mail/Message/perl-win32-users/2597094
#           >  Users want an icon on their desktops, and they want to drag the text file onto this icon, in order to process the file.
#           You can add a DropHandler to the registry manually, or just run this perl program:
#             use Win32::TieRegistry; $Registry->Delimiter("/"); $perlKey = $Registry->{"HKEY_CLASSES_ROOT/Perl/"}; # After running this code, any .pl icon
#             $perlKey->{"shellex/"} = { "DropHandler/" =>  { "/"=> "{86C86720-42A0-1069-A2E8-08002B30309D}" }};    #   should get dragged filenames in @ARGV.
#         from: HTTP://Mail.Python.Org/pipermail/python-list/2002-December/175749.html
#           I don't know about the command line size limitation, but you can create new menus in explorer rather easily. Just open the regedit, go to the key
#           HKEY_CLASSES_ROOT, and look for the extesion of the file type that you want to associate a menu with (you can use Directory for folders or
#           AllFileSystemObjects for folders and all files).  Then create the following keys:
#             shell/<command name>/command
#           And change the value (Default) to the path of your script. Use %1 to indicate the filename of the file that was right-clicked in explorer:
#             C:\Bin\myscript.py %1
# 2do: #   start TSyn.pl spec all of these are in:        Z:\Tools\T_Sync\
# _UPDATE_T_SYNC.bat          set p4charset=;  p4 sync    Z:\Tools\T_Sync\...
#                                              p4 sync    Z:\Tools\Scripts\...
# Sync_Daybreakers.bat                         call       Z:\Tools\T_Sync\scripts\Sync_Game_script.bat
# Sync_Daybreakers_Art.bat                                Z:\Tools\T_Sync\scripts\Sync_Game_Artists_script.bat
#   All 4: Kill_ACDsee8.vbs,then               p4 sync    Z:\(Art\(Front_Row_Center|Shrek|MTV_PMR)|PMR)\...
#  cd C:\clients\dq(d|lf)\bld;set p4charset=utf8; call(t4 update (-n|1> C:\SyncResults.txt|_finish_THERE_Sync.bat)
# Sync_FRC_dqd.bat            set p4charset=;     call    Z:\Tools\T_Sync\scripts\Sync_FRC_dqd_script.bat
# Sync_PMR_dqlf.bat           set p4charset=;     call    Z:\Tools\T_Sync\scripts\Sync_PMR_dqlf_script.bat
# Sync_PMRvBAR_dqd.bat        set p4charset=;     call    Z:\Tools\T_Sync\scripts\Sync_PMRvBAR_dqd_script.bat
# Sync_Shrek_dqd.bat          set p4charset=;     call    Z:\Tools\T_Sync\scripts\Sync_Shrek_dqd_script.bat
# Sync_Proto_script.bat                        cscript   "Z:\Tools\Scripts\ArtDB\Kill_ACDsee8.vbs"; echo making sure ACDSee is closed...
#                                              p4 sync    Z:\(Tools|proto|Production|Design)\...
#                                              del        Z:\Proto\Engine\Shaders\D3DShaderCache
# _finish_THERE_Sync.bat                       perl       Z:\Tools\Scripts\THERE\THERE_parseSyncResults.pl C:\syncResults.txt; start C:\syncResults.txt
# syncTools.bat                                p4 sync    Z:\Tools\(3DSmax|AssetTracking|helperApps|Maya|NvidiaTools|ObjLists|T(_(Levels|Sync)|oolsSetup))\...
#                                                              !~ /(ACDseeDB|Scripts|There|UnrealMerge)/
# updateMayaToolset.bat                        copy /Y    Z:\Tools\ToolsSetup\(Maya.env|userSetup.mel) "C:\%HOMEPATH%\My Documents\maya\7.0\"
#                                              copy /Y    Z:\Tools\ToolsSetup\glut32.dll "%windir%\system32\"
#                                             xcopy /YRH "Z:\Tools\Maya\Trilogy_dev\TS_BatchScripts\Hypershade\new\hyperShadePanel.mel"                       \
#                                                        "C:\Program Files\Alias\Maya7.0\scripts\others"
#                                              p4 sync    Z:\Art\_TrilogyDefaultProject\...
# updateTHEREToolset.bat                       copy /Y    Z:\Tools\Scripts\THERE\superCopyResources.vbs.lnk "c:\%HOMEPATH%\SendTo\superCopyResources.vbs.lnk"
# FORCE_Sync_THERE_script.bat                  cscript   "Z:\Tools\Scripts\ArtDB\Kill_ACDsee8.vbs"; echo making sure ACDSee is closed...
#                                              call       Z:\Tools\T_Sync\scripts\(syncTools|updateTHEREToolset).bat
#                                              p4 sync    Z:\THERE\t(hinst|s_tools_there)\...
#                                              p4 sync -f Z:\THERE\clients\Makena\src\Assets\... 1> c:\syncResults.txt
#                                              p4 sync    Z:\((Art\MTV_)?PMR|Production)\...
#                                              call       Z:\Tools\T_Sync\scripts\updateMayaToolset.bat
#                                              perl       Z:\Tools\Scripts\THERE\THERE_parseSyncResults.pl
#     audit `t4 update` which calls `p4 sync` wrapped with Helpers::SystemOrDie() && resolve(),the first of which wraps System() && Die(),which?
#     sub System { my($cmd,$quiet) = @_; PrintActionMessage(cwd() . ": $cmd") if not $quiet; my $error = system($cmd); return $error; } # Helpers::System
#     sub Die ($;$) { my($message,$noTrace) = @_; local $| = 1; my $newMessage = "\n$message\n";                                        # Helpers::Die
#       if(!$noTrace){ my $bt = BackTrace(1); $newMessage .= "$bt\n";
#         $newMessage .= "\n\nAn error occurred. Read the above message to determine its cause.\n";
#       } die $newMessage; }
#     sub SystemOrDie { my($cmd,$quiet) = @_; my $exit = System($cmd,$quiet);                                                           # Helpers::SystemOrDie
#       if($exit){ my $code = $exit >> 8; Die("system $cmd failed: $code ($!)"); } 1; }
#     sub t4::resolve() # has about 4 options determining how resolution progresses before requiring manual editing
#   needs to fail gracefully if `p4 set` doesn't have %ENV entries for P4(PORT|USER) etc.
#   incorporate AddPerlDropHandler.pl into this script so that it can be run manually once to setup DropHandler going forward
#     add ck for DropHandler && prompt to create if not there: from: HTTP://ASPN.ActiveState.Com/ASPN/Mail/Message/perl-win32-users/2597094
#       use Win32::TieRegistry; $Registry->Delimiter("/"); my $PerlKey = $Registry->{"HKEY_CLASSES_ROOT/Perl/"}; # After running this code, any .pl icon
#       $PerlKey->{"shellex/"} = {"DropHandler/" => {"/" => "{86C86720-42A0-1069-A2E8-08002B30309D}" }        }; #   should get dragged filenames in @ARGV.
#   add entry to rt-clik Explorer menu thru reg too
#   fix both of abov to ck reg to see if already done before attempting to (re)?do
#   fix THERE_parseSyncResults.pl compatibility when not wrapped by superCopyResources.vbs (enabling DropHandler && rt-clik)
#   interfacing SCR2Trbo w/ .mel IF, sync .bat IF, explorer .vbs IF, CLI
#   add POD
#  maybe:
#   also work on refactoring Z:/Tools/Maya/Trilogy_dev/TS_There/library/TS_There_Lib.mel (particularly the maybe 3 funcs that IF w/ TCR (or SCR for now))
#   add IF niceties for drag-handling a number of dirz or rt-clikng to filter just scenes,models,textures,etc. in some reasonable way (like rt-drag-hndlr?)
#   progress bar for syncs, progress colored && scrolling off top,audit both wrapper && generated .bat files as candidates for .pl ports,
#     Tk::ProgressBar should work fine for basic GUI stuff but need further research on Curses,SLang,etc. to updt cursor pos
package Trilogy::SuperCopyResources2Turbo;
require     Exporter;
use base qw(Exporter);
use lib  qw(Z:/Tools/Scripts/Perl/site/lib C:/clients/dqd/src/Tool);
use strict; use warnings; use File::Basename; use File::Path; use File::Copy qw(cp); use XML::Simple; use Branch; use Helpers; use Resources::Handlers;
our @EXPORT  = qw(SCR2Trbo); our $VERSION = '0.1.7B2CLi9'; our $PTVR = $VERSION; $PTVR =~ s/^\d+\.\d+\.//;#Please see `perldoc Time::PT` for $PTVR explanation.
my  $DBUG    = 1; my $titl = 'SCR2Trbo'; my $auth = '"Pip Stuart" <Pip@TrilogyStudios.Com>'; # DeBUG text flag,tool TITLe,&& AUTHor info(hacker,JAPH,etc. ;) )
my ($name,$path,$extn)=(qw(SuperCopyResources2Turbo Z:/Tools/Scripts/Perl/site/lib/Trilogy/ .pm));# fileparse($0,qr/\.[^.]*$/);#(FileName,FilePath,FileExtensn)
my  $xcfn    = "$path$name-conf.xml"; warn("Missing config file: $xcfn\n") unless(-e $xcfn); # load XmlConfigFileName (XCFN) && confirm exists
my  $xchr    = XMLin($xcfn); my @srfd = ();                                # reads XML file into my XmlConfigHashRef  (XCHR)     ...&&SyncRsltzFileData
sub SCR2Trbo { my $rslt='';my $p4ip=1;my $mflg=0;select((select(STDOUT),$|=1)[0]);#ReSuLTs text,Per4orceInPut(flag),Man(FLaG),mk STDOUT hot handle (unbuffered)
  if(scalar(@_) == 1 && length($_[0]) > 80 && $_[0] =~ /\n[^\n]+\n/){ @srfd = split(/\n/,$_[0]); } else { @srfd = @_; }
  for my $tocp (@srfd){ my $torm = ''; $tocp =~ s/\//\\/g; # TOCoPy is looping filename, TOReMove is file assigned based on P4 deleted key
    if(defined($tocp) && length($tocp)){
      if($p4ip){ # ck for bld/resources/ dir below... since we should never be trying to cp a file from "resources" to itself, but it did happen! =(
        if     ($tocp =~  /[\\\/]bld[\\\/]resources[\\\/]/i){ $rslt .= "Skipping invalid file found in .../bld/resources/... directory\n$tocp\n"; $tocp = '';
        } elsif($tocp =~ s/^.*$xchr->{'p4dm'}//i){ ($torm,$tocp)=($tocp,''); # ck for deleted key strs first since they occur first && are most prevalent
          if(length($torm) && -e $torm && chmod(0666,$torm) && unlink($torm)){ $rslt .=           "Deleted"; } # rm file... was `DEL /F $torm` 2 force +w (-R)
          else                                                               { $rslt .= "Unable to delete" ; } $rslt .= " file: $torm\n";
        } elsif($tocp =~ s/^.*$xchr->{'p4nm'}//i){                           # ck for added,updating,refreshing,etc. key strs, && regex alone isolates filename
        } else                                   {        $tocp =       ''; }# empty out the filename which was to be copied if p4 log line matched no modez
      }
      if($tocp && $tocp =~ /[\\\/]src[\\\/]Assets[\\\/]/i){ my $tocb = $tocp; $tocb =~ s/    [\\\/]src[\\\/]Assets[\\\/]/\\bld\\resources\\/ix;
        ($name,$path,$extn)= fileparse($tocp,qr/\.[^.]*$/); my $fpth = $path; $fpth =~ s/^.*?[\\\/]src[\\\/]Assets[\\\/](.*)$/$1$name$extn/i; my $ftyp = $extn;
        ($name,$path,$extn)= fileparse($tocb,qr/\.[^.]*$/); my $bldr = $path; $bldr =~ s/\//\\/g; $bldr =~ s/                   resources[\\\/].*$//ix;
        unless(-e $path){ mkpath($path); $rslt .= "Created new directory: $path\n"; }
        if($ftyp =~ /$xchr->{'cnft'}/i){
          if(  -e $tocp  &&   -d $bldr){ $rslt .= "Mk1Resrc($fpth,$bldr)\n"; Mk1Resrc($fpth,$bldr);        }
          else                         { $rslt .= "Skipping invalid asset file (does not exist): $tocp\n"; }
        } # if the cp below requires -f to force copying over ReadOnly files,chmod them first or may need MSDOS::Attrib to `attrib -r $tocb` w/ PerlModule
        if($ftyp =~ /$xchr->{'cpft'}/i){ if(-e $tocb){ chmod(0666,$tocb); unlink($tocb); } cp(   $tocp ,  $tocb);
          unless($mflg){ $rslt .= $xchr->{'mncm'} . "\n"; $mflg = 1; } $rslt .= "ManualCopyMode: $tocp to $tocb\n";
        } # `cp --help` => '-f, force, if an existing destination file cannot be opened, remove it and try again'
      }
    }
  } $rslt .= "No Sync results need CopyResourcing!\n" if($p4ip && !$rslt); return($rslt);
}
sub Mk1Resrc { # this subroutine is derived from /c/clients/dqd/src/Tool/Resources/MakeOneResource.pl to avoid myriad separate shells && interpreters per file
  warn("CopyOneResource <asset>\n\nThe named asset will be built in the same way as CopyResources builds assets.\n") unless(@_ == 2);
  my $srdr = "C:/clients/dqd/src";        # SouRce       DiRectory
  my $shas = shift(@_); my $aset = undef; # SHort  ASset              # ASsET
  my $bldr = shift(@_); my $asdr = undef; #        BuiLd DiRectory    # ASset DiRectory
  for my $prfx (Branch::GetSourceDirectory($srdr,'ASSETS'),$bldr,$srdr){ if(-f "$prfx/$shas"){ ($aset,$asdr)=("$prfx/$shas",$prfx); last; } }
  unless(defined($aset)) { warn("Could not find $shas. Enter a path relative to src/Assets, bld or src.\n\nFor example:
  CopyOneResource        dog/dog.aconf\n  CopyOneResource Assets/dog/dog.aconf\n  CopyOneResource ../src/dog/dog.aconf\n"); return(); } $aset =~ s/\\/\//g;
  for my $hndl (Handlers::Handlers()){ my $mstr = $hndl->[0];                                    # Match  STRing
    if($aset =~ /$mstr/i){             my $renf = $hndl->[1]; $shas = $aset;                     # REName Function      # start setting up...
                                       my $bldf = $hndl->[2]; $shas =~ s/.*\/src\/.*Assets\///i; # BuiLD  Function      #   ...SHort  ASset
                                       my $shrf = lc(&$renf($shas,      $srdr,$bldr,$asdr));     # SHort  Resource File (where s/"\L$shrf"/lc($shrf)/;)
                                       my $resf =    "$bldr/resources/$shrf"; unlink($resf);     #        RESource File
                                                     &$bldf($aset,$resf,$srdr,$bldr,$asdr); return();
    }
  } warn("Could not find rule to build file: $aset!\n");
}
127;
# all this old ARGV stuf below is from RtClik or DropHandling... && should be incorporated before beta release
# <syrs>C:/tmp/P4SyncResults.txt</syrs>                                                                                        <!-- SYncReSultz           -->
# <cpfz>C:/tmp/ThereFiles2Cp.txt</cpfz>                                                                                        <!-- CoPyFileZ             -->
#if(open(CPFZ,'>',$xchr->{'cpfz'})){ print CPFZ join("\n",@ARGV),"\n"; close(CPFZ); print(join("\n",@ARGV),"\n"); }
#else                                   { warn('Could not open ' . $xchr->{'cpfz'} .     " file for writing!\n"); }
#my $p4ip = 1;                #($name,$path,$extn)= fileparse($xchr->{'cpfz'},qr/\.[^.]*$/); # Per4orceINput (flag) && parsed-out filename fields of CoPyFileZ
# orig seems to be comparing whether this was called as `$0 THERE_CopyTheseFiles.txt` which designates manual nstd of dflt auto
#   but this needs to ch since mine doesn't have a .vbs creating cpfz to then system on a separate .pl which is given cpfz as its only param
#if($ARGV[0] eq "$name$extn"){ $xchr->{'syrs'} = $xchr->{'cpfz'}; $xchr->{'sycm'} = $xchr->{'mncm'}; $p4ip ^= 1; } # below open $xchr->{'syrs'} for reading
#if($#ARGV){ $xchr->{'syrs'} = $xchr->{'cpfz'}; $xchr->{'sycm'} = $xchr->{'mncm'}; $p4ip ^= 1; } # below open $xchr->{'syrs'} for reading
#if(open(SYRS,'<',$xchr->{'syrs'})){ chomp(@srfd = <SYRS>); close(SYRS); } else { warn('Could not find ' . $xchr->{'syrs'} . " file!\n"); }
#print $xchr->{'titl'} . "\n>>> " . $xchr->{'sycm'} . "\n\n"; # output mode type
