<root@Ryu98CAuJd~>python-updater
 * Starting Python Updater from 2.4 to 2.5 :
 *   Adding to list: =x11-libs/vte-0.17.4-r3
 *   Adding to list: =dev-libs/boost-1.35.0-r2

These are the packages that would be merged, in order:

Calculating dependencies... done!
[ebuild     U ] sys-apps/dmidecode-2.10 [2.9] 51 kB
[ebuild     U ] sys-libs/timezone-data-2009j [2009c] USE="nls" 361 kB
[ebuild     U ] media-sound/alsa-headers-1.0.20 [1.0.18] 2,833 kB
[ebuild     U ] dev-db/sqlite-3.6.14.2 [3.6.12] USE="tcl threadsafe -debug -doc -soundex" 2,829 kB
[ebuild  N    ] virtual/acl-0  0 kB
[ebuild     U ] sys-apps/debianutils-3.1.3 [2.28.5] USE="-static" 130 kB
[ebuild     U ] sys-devel/autoconf-2.63-r1 [2.63] USE="-emacs" 0 kB
[ebuild     U ] dev-libs/libtasn1-2.2 [1.8] USE="-doc" 1,604 kB
[ebuild  NS   ] sys-libs/db-4.6.21_p4 [4.3.29-r2, 4.5.20_p2-r1] USE="tcl -doc -java -nocxx -test" 11,649 kB
[ebuild     U ] dev-libs/libusb-0.1.12-r5 [0.1.12-r1] USE="-debug -doc -nocxx%" 381 kB
[ebuild     U ] x11-libs/xcb-util-0.3.3 [0.2] USE="-debug -test%" 265 kB
[ebuild     U ] dev-libs/libpcre-7.9-r1 [7.8] USE="bzip2 cxx (unicode) zlib -doc -static-libs%" 842 kB
[ebuild     U ] media-libs/libvorbis-1.2.3 [1.2.1_rc1] USE="-doc" 1,440 kB
[ebuild     U ] sys-apps/sed-4.2 [4.1.5-r1] USE="acl%* nls -static" 862 kB
[ebuild     U ] x11-misc/shared-mime-info-0.60 [0.51] 447 kB
[ebuild     U ] app-admin/eselect-1.1.1 [1.0.11-r1] USE="bash-completion -doc (-vim-syntax%*)" 150 kB
[ebuild     U ] app-admin/eselect-ctags-1.10 [1.8] 8 kB
[ebuild     U ] media-libs/libcaca-0.99_beta16 [0.99_beta14] USE="X imlib ncurses opengl ruby slang -doc -mono -nocxx" 944 kB
[ebuild  NS   ] dev-lang/python-2.6.2-r1 [2.4.6, 2.5.4-r2] USE="berkdb examples gdbm ipv6 ncurses readline ssl threads tk xml -build -doc -sqlite -ucs2 -wininst" 10,905 kB
[ebuild     U ] media-libs/alsa-lib-1.0.20-r1 [1.0.18] USE="alisp python -debug -doc (-midi%*)" ALSA_PCM_PLUGINS="adpcm alaw asym copy dmix dshare dsnoop empty extplug file hooks iec958 ioplug ladspa lfloat linear meter mmap_emul mulaw multi null plug rate route share shm softvol" 777 kB
[ebuild     U ] dev-python/numpy-1.3.0 [1.2.1] USE="-lapack -test (-debug%)" 1,950 kB
[ebuild     U ] app-admin/python-updater-0.7 [0.5] 7 kB
[ebuild   R   ] dev-libs/boost-1.35.0-r2  USE="expat -debug -doc -icu -mpi -tools" 0 kB
[ebuild     U ] media-sound/alsa-utils-1.0.20-r4 [1.0.18] USE="nls -doc% -minimal (-midi%*)" 1,021 kB
[ebuild     U ] app-editors/vim-core-7.2.182 [7.2] USE="acl bash-completion nls -livecd" 257 kB
[ebuild     U ] app-editors/vim-7.2.182 [7.2] USE="acl bash-completion cscope gpm nls perl python ruby vim-pager vim-with-x -minimal" 0 kB
[ebuild     U ] sys-libs/glibc-2.9_p20081201-r2 [2.8_p20080602-r1] USE="gd (multilib) nls -debug -glibc-omitfp (-hardened) -profile (-selinux) -vanilla" 16,621 kB
[ebuild     U ] sys-fs/udev-141 [124-r2] USE="(-selinux)" 438 kB
[ebuild  NS   ] sys-kernel/gentoo-sources-2.6.30-r4 [2.6.27-r8] USE="symlink -build" 58,119 kB
[ebuild     U ] app-misc/lirc-0.8.5 [0.8.4] USE="X -debug -doc -hardware-carrier -transmitter" LIRC_DEVICES="-accent -act200l -act220l -adaptec -all -alsa_usb -animax -asusdh -atilibusb -atiusb -audio -audio_alsa -avermedia -avermedia98 -avermedia_vdomate -awlibusb% -bestbuy -bestbuy2 -breakoutbox -bte -bw6130 -caraca -chronos -commandir -cph06x -creative -creative_infracd -devinput -digimatrix -dsp -dvico -ea65 -exaudio -flyvideo -ftdi% -gvbctv5pci -hauppauge -hauppauge_dvb -hercules_smarttv_stereo -i2cuser% -igorplugusb (-iguana) -imon -imon_24g% -imon_knob -imon_lcd -imon_pad -imon_rsc -inputlirc -irdeo -irdeo_remote -irlink -irman -irreal -it87 -ite8709 -knc_one -kworld -leadtek_0007 -leadtek_0010 -leadtek_pvr2000 -livedrive_midi -livedrive_seq -logitech -macmini -mceusb -mceusb2 -mediafocusI -mouseremote -mouseremote_ps2 -mp3anywhere -mplay% -nslu2 -packard_bell -parallel -pcmak -pcmak_usb -pctv -pixelview_bt878 -pixelview_pak -pixelview_pro -provideo -realmagic -remote_wonder_plus -remotemaster -sa1100 -samsung -sasem -sb0540 -serial -serial_igor_cesko -silitek -sir -slinke -streamzap -tekram -tekram_bt829 -tira -ttusbir -tuxbox -tvbox -udp -uirt2 -uirt2_raw -usb_uirt_raw -usbirboy -usbx -userspace -wpc8769l% -xboxusb (-cmdir%) (-imon_pad2keys%)" 700 kB
[ebuild     U ] sys-fs/cryptsetup-1.0.6-r2 [1.0.5-r1] USE="nls -dynamic (-selinux) (-build%)" 397 kB
[blocks b     ] >=sys-fs/udev-126 (">=sys-fs/udev-126" is blocking sys-fs/cryptsetup-1.0.5-r1)
[ebuild     U ] sys-apps/hal-0.5.11-r9 [0.5.11-r8] USE="X acpi apm crypt -debug -dell -disk-partition -doc -laptop (-selinux)" 0 kB
[ebuild     U ] app-misc/hal-info-20090414 [20090309] 135 kB
[ebuild     U ] x11-base/xorg-server-1.5.3-r6 [1.5.3-r5] USE="dmx hal ipv6 nptl sdl xorg (-3dfx) -debug -kdrive -minimal -tslib" VIDEO_CARDS="nv nvidia vesa -apm -ark -ast -chips -cirrus -dummy -epson -fbdev (-geode) -glint -i128 (-i740) (-impact) (-imstt) -intel -mach64 -mga -neomagic (-newport) -r128 -radeon -radeonhd -rendition -s3 -s3virge -savage -siliconmotion -sis -sisusb (-sunbw2) (-suncg14) (-suncg3) (-suncg6) (-sunffb) (-sunleo) (-suntcx) -tdfx -tga -trident -tseng -v4l (-vermilion) -via -virtualbox -vmware -voodoo (-xgi) (-fglrx%)" 60 kB
[ebuild     U ] dev-python/pygobject-2.18.0 [2.16.1] USE="X examples -debug -doc -libffi% -test%" 625 kB
[ebuild     U ] x11-drivers/nvidia-drivers-180.60 [180.29] USE="acpi custom-cflags gtk (multilib)" 20,977 kB
[ebuild     U ] media-video/nvidia-settings-180.60 [177.80] 1,311 kB
[ebuild     U ] sys-auth/pam_ssh-1.97-r1 [1.92] 196 kB
[ebuild     U ] x11-libs/pango-1.24.2 [1.22.4] USE="X -debug -doc" 1,493 kB
[ebuild     U ] dev-python/pygtk-2.14.1-r1 [2.14.1] USE="X examples -doc" 0 kB
[ebuild   R   ] x11-libs/vte-0.17.4-r3  USE="opengl python -debug -doc" 0 kB
[ebuild  N    ] dev-libs/poppler-0.10.7  USE="abiword poppler-data" 1,496 kB
[ebuild  N    ] app-text/poppler-utils-0.10.7  USE="abiword" 0 kB
[ebuild     U ] virtual/poppler-utils-0.10.7 [0.10.5] USE="abiword" 0 kB
[ebuild     U ] net-print/cups-1.3.10-r2 [1.3.10-r1] USE="X acl avahi dbus gnutls jpeg ldap pam perl png ppds python ssl tiff xinetd zeroconf -java -kerberos -php -samba -slp -static" LINGUAS="en -de -es -et -fr -he -id -it -ja -pl -sv -zh_TW" 0 kB
[ebuild     U ] x11-libs/qt-core-4.5.1 [4.4.2-r2] USE="glib iconv qt3support ssl -debug -doc -pch (-custom-cxxflags%)" 111,980 kB
[ebuild     U ] x11-libs/qt-dbus-4.5.1 [4.4.2] USE="-debug -pch (-custom-cxxflags%)" 0 kB
[blocks b     ] <x11-libs/qt-dbus-4.5.1 ("<x11-libs/qt-dbus-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-core-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1)
[ebuild     U ] x11-libs/qt-script-4.5.1 [4.4.2] USE="iconv%* -debug -pch (-custom-cxxflags%)" 0 kB
[blocks b     ] <x11-libs/qt-script-4.5.1 ("<x11-libs/qt-script-4.5.1" is blocking x11-libs/qt-core-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-dbus-4.5.1)
[ebuild     U ] x11-libs/qt-sql-4.5.1 [4.4.2-r1] USE="iconv mysql qt3support sqlite -debug (-firebird) -odbc -pch -postgres (-custom-cxxflags%)" 0 kB
[blocks b     ] <x11-libs/qt-sql-4.5.1 ("<x11-libs/qt-sql-4.5.1" is blocking x11-libs/qt-core-4.5.1, x11-libs/qt-script-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-dbus-4.5.1)
[ebuild     U ] x11-libs/qt-gui-4.5.1 [4.4.2-r3] USE="accessibility cups dbus glib gtkstyle%* mng qt3support tiff xinerama -debug -nas -nis -pch -raster% (-custom-cxxflags%)" 0 kB
[blocks b     ] <x11-libs/qt-gui-4.5.1 ("<x11-libs/qt-gui-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-core-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-qt3support-4.5.1)
[ebuild     U ] x11-libs/qt-qt3support-4.5.1 [4.4.2] USE="accessibility kde%* -debug -pch -phonon% (-custom-cxxflags%)" 0 kB
[blocks b     ] <x11-libs/qt-qt3support-4.5.1 ("<x11-libs/qt-qt3support-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-core-4.5.1, x11-libs/qt-dbus-4.5.1)
[uninstall    ] x11-libs/qt-opengl-4.4.2  USE="debug qt3support -custom-cxxflags -pch" 
[blocks b     ] <x11-libs/qt-opengl-4.5.1 ("<x11-libs/qt-opengl-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[uninstall    ] x11-libs/qt-webkit-4.4.2-r1  USE="debug -custom-cxxflags -pch" 
[blocks b     ] <x11-libs/qt-webkit-4.5.1 ("<x11-libs/qt-webkit-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[uninstall    ] x11-libs/qt-svg-4.4.2  USE="debug -custom-cxxflags -pch" 
[blocks b     ] <x11-libs/qt-svg-4.5.1 ("<x11-libs/qt-svg-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[blocks B     ] app-text/poppler-utils ("app-text/poppler-utils" is blocking app-text/poppler-bindings-0.10.5-r1, app-text/poppler-0.10.5-r1)
[blocks B     ] <x11-libs/qt-xmlpatterns-4.5.1 ("<x11-libs/qt-xmlpatterns-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[blocks B     ] app-text/poppler-bindings ("app-text/poppler-bindings" is blocking dev-libs/poppler-0.10.7, app-text/poppler-utils-0.10.7)
[blocks B     ] <x11-libs/qt-assistant-4.5.1 ("<x11-libs/qt-assistant-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[blocks B     ] app-text/poppler ("app-text/poppler" is blocking dev-libs/poppler-0.10.7, app-text/poppler-utils-0.10.7)
[blocks B     ] <x11-libs/qt-test-4.5.1 ("<x11-libs/qt-test-4.5.1" is blocking x11-libs/qt-script-4.5.1, x11-libs/qt-dbus-4.5.1, x11-libs/qt-gui-4.5.1, x11-libs/qt-qt3support-4.5.1, x11-libs/qt-sql-4.5.1, x11-libs/qt-core-4.5.1)
[blocks B     ] dev-libs/poppler ("dev-libs/poppler" is blocking app-text/poppler-bindings-0.10.5-r1, app-text/poppler-0.10.5-r1)

Total: 51 packages (43 upgrades, 3 new, 3 in new slots, 2 reinstalls, 3 uninstalls), Size of downloads: 254,245 kB
Conflict: 16 blocks (7 unsatisfied)

 * Error: The above package list contains packages which cannot be
 * installed at the same time on the same system.

  ('installed', '/', 'app-text/poppler-bindings-0.10.5-r1', 'nomerge') pulled in by
    app-text/poppler-bindings required by world

  ('ebuild', '/', 'app-text/poppler-utils-0.10.7', 'merge') pulled in by
    ~app-text/poppler-utils-0.10.7[abiword] required by ('ebuild', '/', 'virtual/poppler-utils-0.10.7', 'merge')
    ~app-text/poppler-utils-0.10.7[abiword] required by ('ebuild', '/', 'net-print/cups-1.3.10-r2', 'merge')

  ('ebuild', '/', 'x11-libs/qt-core-4.5.1', 'merge') pulled in by
    x11-libs/qt-core:4 required by ('installed', '/', 'net-dns/avahi-0.6.24-r2', 'nomerge')
    ~x11-libs/qt-core-4.5.1[qt3support,-debug] required by ('ebuild', '/', 'x11-libs/qt-sql-4.5.1', 'merge')
    ~x11-libs/qt-core-4.5.1[glib,qt3support,-debug] required by ('ebuild', '/', 'x11-libs/qt-gui-4.5.1', 'merge')
    (and 3 more)

  ('installed', '/', 'x11-libs/qt-test-4.4.2', 'nomerge') pulled in by
    x11-libs/qt-test required by world

  ('installed', '/', 'app-text/poppler-0.10.5-r1', 'nomerge') pulled in by
    app-text/poppler required by world
