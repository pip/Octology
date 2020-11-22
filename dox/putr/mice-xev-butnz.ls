# ICRLAmic:renamed by PipStuart <Pip@CPAN.Org> from .txt to .ls with this new header for syntax-highlighting;
 "kensington  low -speed USB HID v1.10 Mouse   " # [Kensington Kensington Slimblade Trackball] dark gray base with red trackball
  butnz 1-5:loLeft,upLeft,loRite,ballCCW,ball_CW 8  :upRite
 "hid-generic low -speed USB HID v1.10 Mouse   " # [Kensington Kensington Expert        Mouse] dark gray base&&trackball wi light gray trim&&black scrollwheel
  butnz 1-5:loLeft,upLeft,loRite,ballCCW,ball_CW 8  :upRite
 "hid-generic low -speed USB HID v1.10 Mouse   " # [Kensington USB/PS2    Wheel         Mouse] black  &&  gray ergonomic mouse
  butnz 1-5:  left,wheel ,  rite,wheelUp,wheelDn 8,9:leftShoulderFwd,leftShoulderBak
 "koneplus    full-speed USB HID v1.00 Mouse   " # [ROCCAT     ROCCAT     Kone          XTD  ] black with gray cat && light rails
                                                     leftShoulderBak,+,- butnz dflt send no xev butn EvNtz,but top menu butn does send keyboard Meta key
 "koneplus    full-speed USB HID v1.11 Keyboard" # [ROCCAT     ROCCAT     Kone          XTD  ]
  butnz 1-5:  left,wheel ,  rite,wheelUp,wheelDn   9:leftShoulderFwd
 "hid-generic low -speed USB HID v1.10 Mouse   " # [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] beige with gray wheel && side butnz && red light
  butnz 1-5:  left,wheel ,  rite,wheelUp,wheelDn 8,9:leftShoulder   ,riteShoulder
 "hid-generic low -speed USB HID v1.00 Mouse   " # [HID 1241:1155] Memorex Optical ScrollPro Mouse SE 5-butn+scrollwheel gray with black side butnz
  no butnz or movement detected correctly && optical light doesn't even turn on
 "hid-generic full-speed USB HID v1.11 Mouse   " # [Cirque Corporation 9925 AG Touchpad] black with gray touchpad (Adesso GP-410UB)
  butnz 1-5:loLeft,upLeft,loRite,tchRtUp,tchRtDn 2  :upRite (it seems upLeft&&upRite butnz both dflt map to middle mouse butn instd of 8 or 9 like above)
# All devices when hot-unplugged seem to print dmesg errors from their driver: can't reset device, \d{4}:\d\d:\d+.\d-\d.\d/input\d+, status -71
