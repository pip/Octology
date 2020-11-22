  allow_bold             = true                    <gconf       dconf>   allow-bold                      true
! alternate_screen_scroll= true                                     # "!" precedes all keyz that don't match the altern8 configur8ion
                                                                       ! audible-bell                    true
  background_color       = #000000000000                                 background-color                '#000000'
! background_darkness    = 0.93693697452545166                           
! background_image       =                                               
                                                                       ! background-transparency-percent 50
! background_type        = transparent                                   
  backspace_binding      = ascii-del                                     backspace-binding               'ascii-delete'
  bold_color             = #000000000000                                 bold-color                      '#000000'
  bold_color_same_as_fg  = true                                          bold-color-same-as-fg           true
                                                                       ! cjk-utf8-ambiguous-width        'narrow'
  cursor_blink_mode      = system                                        cursor-blink-mode               'system'
  cursor_shape           = block                                         cursor-shape                    'block'
  custom_command         = /bin/zsh                                      custom-command                  ''
  default_show_menubar   = true                                          default-show-menubar            true
  default_size_columns   = 160                                           default-size-columns            80
  default_size_rows      = 50                                            default-size-rows               24
  delete_binding         = escape-sequence                               delete-binding                  'delete-sequence'
                                                                       ! encoding                        'UTF-8'
  exit_action            = close                                         exit-action                     'close'
  font                   = Liberation Mono 8                             font                            'Monospace 12'
  foreground_color       = #0000FFFF0000                                 foreground-color                '#00FF00'
  login_shell            = true                                          login-shell                     false
  palette   = #000000000000:#AAAA00000000:#0000AAAA0000:#FF8FBE3548C1:   palette  ['#2E2E34343636','#CCCC00000000','#4E4E9A9A0606','#C4C4A0A00000',
              #34346565A4A4:#AAAA0000AAAA:#0000AAAAAAAA:#323232323232:             '#34346565A4A4','#757550507B7B','#060698209A9A','#D3D3D7D7CFCF',
              #AAAAAAAAAAAA:#F4AE24172417:#5555FFFF5555:#FFFFFFFF5555:             '#555557575353','#EFEF29292929','#8A8AE2E23434','#FCFCE9E94F4F',
              #72729F9FCFCF:#BB056102D47A:#5555FFFFFFFF:#FFFFFFFFFFFF              '#72729F9FCFCF','#ADAD7F7FA8A8','#3434E2E2E2E2','#EEEEEEEEECEC']
                                                                       ! rewrap-on-resize                true
! scroll_background      = true                                          
  scrollback_lines       = 512                                           scrollback-lines                8192
  scrollback_unlimited   = true                                          scrollback-unlimited            false
                                                                       ! scrollbar-policy                'always'
! scrollbar_position     = right                                         
  scroll_on_keystroke    = true                                          scroll-on-keystroke             true
  scroll_on_output       = false                                         scroll-on-output                false
! silent_bell            = false                                         
! title_mode             = replace                                       
! title                  = PipsCkm8GnomTerm                              
  update_records         = true                                          update-records                  true
  use_custom_command     = false                                         use-custom-command              false
! use_custom_default_size= true                                          
  use_system_font        = false                                         use-system-font                 true
  use_theme_colors       = false                                         use-theme-colors                true
                                                                       ! use-theme-transparency          true
                                                                       ! use-transparent-background      false
  visible_name           = PipsCkm8GnomTerm-NiceFont-DC9LDaPt            visible-name                    'PipsCkm8GnomTerm-NiceFont-DC9LDaPt'
! word_chars             = -A-Za-z0-9,./?%&#:_=+@~                       
                                                                       ! word-char-exceptions            @ms nothing
# commandz:`gconftool-2 -a "/apps/gnome-terminal/profiles/Profile4"|s8`
#          `gsettings list-recursively org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:23dd35a3-f6d0-4ba6-a073-26e08db2e30a/|s8`
#     where gsettings output all stRt "org.gnome.Terminal.Legacy.Profile " which I removed from right columnz above
#     aftr `gsettings list-recursively org.gnome.Terminal.ProfilesList` to learn UUIDz of already crE8d prOfIlz && which is Dflt
#          `gconftool-2 --set /apps/gnome-terminal/profiles/Profile4/login_shell --type=boolean true` can be used to upd8 from CLI if I learn all typez for
#            above valuez. Need schemaz. Presumably (boolean|integer|float|string) && also (color|list)? Also need to learn how to crE8 new UUIDz in dconf
#            to gener8 && popul8 profilez from gconf, or just manually crE8 the right number of profilez then gener8 just directly to gsettings from shared
#            && custom d8a in the code, which matchez ProfilesList to included definitionz in order (clobbering visible-name). Sheesh. There's only 5 profilez
#            with about 50 optionz each && many keep defaultz so I'm just going to manually bring a laptop over && synchronize configur8ion. Note that I setup
#            Taki to default 8192 scrollback limit except for PipsTestGnomTerm-DiffFont-* while Aku invertz these && only limitz my TestTerm. There are also
#            distinctionz between using transparency from system theme && available fontz;
