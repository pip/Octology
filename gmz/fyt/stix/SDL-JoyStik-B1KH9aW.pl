#!/usr/bin/perl
use SDL;
use SDLx::App;
use SDL::Event;
use SDL::Events;
use SDL::Joystick;
SDL::init_sub_system(SDL_INIT_JOYSTICK);
my $sapp = SDLx::App->new(
  title        => 'JS tst',
  width        => 320,
  height       => 200,
  depth        =>  32,
  resizeable   =>   1,
  exit_on_quit =>   1,
);
die('no joystick found') unless(SDL::Joystick::num_joysticks());
my $jstk = SDL::Joystick->new(0);
my $jnam = SDL::Joystick::name(0);
my $nbtz = SDL::Joystick::num_buttons($jstk);
my %bstt;my @bnmz =(qw(Triangle Circle X Square L1 R1 L2 R2 Select Start L3 R3 Up Right Down Left));
if($jstk){
  printf("0: name   :%s\n",                           $jnam );
  printf("NumAxes   :%d\n",SDL::Joystick::num_axes(   $jstk));
  printf("NumButtons:%d\n",                           $nbtz );
  printf("NumBalls  :%d\n",SDL::Joystick::num_balls(  $jstk));
  printf("NumHats   :%d\n",SDL::Joystick::num_hats(   $jstk));
}else{
  printf("Couldn't open Joystick 0\n");
}
my $evnt = SDL::Event->new; # create a new event
#SDL::Events::pump_events();
#while(SDL::Events::poll_event($evnt)){
#  my $etyp = $evnt->type(); # get event type
#  print "type:$etyp\n";
#  exit if $etyp == SDL_QUIT;
#}
$sapp->add_event_handler(sub{ my $etyp = $_[0]->type();
  if(      $etyp !=         SDL_MOUSEMOTION     ){ # 4
    printf('etyp:%2d ',$etyp);
    if    ($etyp ==         SDL_ACTIVEEVENT     ){
      printf('type:%-20s ','SDL_ACTIVEEVENT'    );
    }elsif($etyp ==         SDL_KEYDOWN         ){
      printf('type:%-20s ','SDL_KEYDOWN'        );
    }elsif($etyp ==         SDL_KEYUP           ){
      printf('type:%-20s ','SDL_KEYUP'          );
    }elsif($etyp ==         SDL_MOUSEMOTION     ){
      printf('type:%-20s ','SDL_MOUSEMOTION'    );
    }elsif($etyp ==         SDL_MOUSEBUTTONDOWN ){
      printf('type:%-20s ','SDL_MOUSEBUTTONDOWN');
    }elsif($etyp ==         SDL_MOUSEBUTTONUP   ){
      printf('type:%-20s ','SDL_MOUSEBUTTONUP'  );
    }elsif($etyp ==         SDL_JOYAXISMOTION   ){
      printf('type:%-20s ','SDL_JOYAXISMOTION'  );
    }elsif($etyp ==         SDL_JOYBALLMOTION   ){
      printf('type:%-20s ','SDL_JOYBALLMOTION'  );
    }elsif($etyp ==         SDL_JOYHATMOTION    ){
      printf('type:%-20s ','SDL_JOYHATMOTION'   );
    }elsif($etyp ==         SDL_JOYBUTTONDOWN   ){
      printf('type:%-20s ','SDL_JOYBUTTONDOWN'  );
    }elsif($etyp ==         SDL_JOYBUTTONUP     ){
      printf('type:%-20s ','SDL_JOYBUTTONUP'    );
    }elsif($etyp ==         SDL_QUIT            ){
      printf('type:%-20s ','SDL_QUIT'           ); exit;
    }elsif($etyp ==         SDL_SYSWMEVENT      ){
      printf('type:%-20s ','SDL_SYSWMEVENT'     );
    }elsif($etyp ==         SDL_VIDEORESIZE     ){
      printf('type:%-20s ','SDL_VIDEORESIZE'    );
    }elsif($etyp ==         SDL_VIDEOEXPOSE     ){
      printf('type:%-20s ','SDL_VIDEOEXPOSE'    );
    }elsif($etyp ==         SDL_USEREVENT       ){
      printf('type:%-20s ','SDL_USEREVENT'      );
    }elsif($etyp ==         SDL_NUMEVENTS       ){
      printf('type:%-20s ','SDL_NUMEVENTS'      );
    }
    if($jnam eq 'ZEROPLUS PS(R) Gamepad Adaptor'){
      my $satx = $sapp->ticks();
#     SDL::Joystick::update(); # This makes the coupled prefix hatmotion event see the immediately following axis (reported as button) state;
      for my $bndx (0..($nbtz-1)){
        if(SDL::Joystick::get_button($jstk,$bndx)){
          printf('%7d:%2d:%8s dn ',$satx,$bndx,$bnmz[$bndx]);       $bstt{$bnmz[$bndx]}=1;
        }elsif(exists($bstt{$bnmz[$bndx]})){
          printf('%7d:%2d:%8s up ',$satx,$bndx,$bnmz[$bndx]);delete($bstt{$bnmz[$bndx]});
        }
      }
      print "\n";
    }
  }
  return 1});
$sapp->add_show_handler( sub{ $sapp->update() });
$sapp->add_move_handler( sub{ }); #calc your physics here
$sapp->run();
#SDL::Joystick::close($jstk) if SDL::Joystick::opened(0);
