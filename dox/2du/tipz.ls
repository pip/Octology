# ECILIpU5:~/dox/2du/tipz.ls crE8d by PipStuart <Pip@CPAN.Org> to track full-scrn GNU/Linux console login fortune-like tipz worth remembering;$d8VS='K27LBROX';
 ApNd ssh kE2srvr's authkEz wi`ssh-copy-id user@srvradrS`&& GitHub advIsez`eval "$(ssh-agent -s)"`&&`ssh-add -l`2tk nOt of fngrprntz2tSt4m@ch acctSSH kEz;
 Shell curly bracez iter8 comma separ8d list like: `cp /long/path/to/file/name{,.orig}`;
F6IME9nq:For getting precise Google search resultz, you can perform a search query first then under 'Search Tools' drop-down 'All Results' can be changed
 to 'Verbatim', or append '&tbs=li:1' to URL. Also incognito (just log out?) or privacy mode may avoid tailoring based on record of personal past searchez;
FACM1gaH:When Ryu had boot problemz I had to `sudo vim /etc/default/grub` to have GRUB_DEFAULT=saved && GRUB_SAVEDEFAULT=true then `update-grub` then hold
 Shift after BIOS to pick working older version to be saved.
FACM1jHh:For autom8ng a new setup `dpkg --get-selections|grep -v deinstall` lists dependenciez along with explicitly installed packagez,
 /var/lib/apt/extended_states lacks (fig|toi)let which I know I installed manually, Checkout blueprint,
  (zc $(ls -tr /var/log/apt/history.log*.gz);cat /var/log/apt/history.log)|eg '^(Start-Date:|Commandline:)'|eg -v 'aptdaemon|autoremove|upgrade'|eg -B1 '^Commandline:'|eg -v '^--$'
  # study above cmdz. Eventually shud rEprocS output2just hv d8:`ag[ir] pkgz` cmdz with matching acs Dscriptz folo as comNtz && rEmMbr `uname -a` 4krnl version
  Above method is gr8 but on Aku it lacks oldest installs of zsh,vim,most,p47,etc.; aptitude search (-F '%p')? '~i!~M' might work if I eventually agi aptitude.
  Another more recent way might be to ` grep " install " /var/log/dpkg.log     ` for the current  log ,
                                      ` grep " install " /var/log/dpkg.log.1   ` for the previous log ,
                                  and `zgrep " install " /var/log/dpkg.log.2.gz` for archived     logs:
FACM1rwi:Studying grub submenu spec might let me gener8 better filterz for /boot/grub/grub.cfg =~ /^\s*menuentry/ to match which optionz matter;
FACM72HY:Probably gnome-tweak-tool will enable Taki's && Ken's CapsLock to behave as familiar Control keys;
FACMBu0s:To get alpha transparency like Compiz in Unity in Gnome in Ubuntu 11.10 (or maybe 15.04?), but in fallback Gnome Classic, try:
`gconftool-2 --set --type=bool /apps/metacity/general/compositing_manager true && gconftool-2 --set --type=bool /apps/metacity/general/compositor_effects true`
 – ploum Feb 14 '12 at 10:13 from HTTP://SuperUser.Com/questions/388315/make-gnome-terminal-real-transparent/388329#388329 . Doesn't work for me because both
 Ryu && Ken run NVidia with inadequ8 3D acceler8ion for Compiz to keep transparent gnome-terminal backgroundz (even though Ryu had them before && should);
FBCLCLCL:To`pmei Term::ReadKey`onKen as root, had2`touch /usr/lib/x86_64-linux-gnu/perl/5.20/CORE/fakethr.h
                                                   touch /usr/lib/x86_64-linux-gnu/perl/5.20/CORE/perlsfio.h`thN`pmei IO::Tty`&&Expect;
FCEL8KYI:It seemz /var/log/apt/history.log* is the best source for recent agi actionz but only goes back about a year. =( If I wrap the agi alias, it should
 just keep logging everything to /root/.log/agi.log && maybe if I rebuild Aku before then I can log manually all I need to setup comfortably. Might be good to
 also reconfigure logrot8 to stop removing any oldest /var/log/*.log.*.gz since the disk space is generally only scarce on my /boot partition;
FCFLAthX:According to HTTP://SuperUser.Com/questions/339863/why-doesnt-broadcast-ping-work to enable pingb `sysctl net.ipv4.icmp_echo_ignore_broadcasts=0` or
 append without /^sysctl / to /etc/sysctl.conf;
G5VME0wr:Today I upgraded Ken && Chun to Ubuntu 16.04LTS && d8ok term failed right away so I needed to touch fakethr && perlsfio again for new perl/5.22 then
 pmei l8st 1.34 version of Curses. Then d8ok spit new "Negative repeat count does nothing on line 1261 of Simp.pm" warnings referring to the x oper8or until I
 tested to avoid negatives. I did agi ttf-mscorefonts-installer to give them access to Andale Mono && Courier New like Aku already had. My Ckm8 terms did use
 (Liberation Mono Regular 8), Othr used (Andale Mono Regular 8) or (DejaVu Sans Mono Book 8), && Test used (Courier 10 Pitch Regular 8) or New. Terms on Ken
 with any above font seem to all render at the same pixel sizes they have always had but Chun terms got notably wider && shorter. Only Test with (Courier 10
 Pitch Regular 8) seemed to stay the same size as all her old terms used to be. Liberation && Andale are now shorter than DejaVu, which is shorter than 10
 Pitch. At least wider fonts are more legible. Not sure yet if there's any way to fix them all to have common pixel sizing again. Setting DejaVu to 7.5pt made
 pixel width match 10 Pitch but height remains much shorter. At least default Ckm8 positioning no longer obscures majority of d8ok. It's pretty workable now;
G61M4r58:Since Aku, Ryu, && Ken all only have 228MB sda1 /boot partitions with ext2 filesystems leaving the remainder of the 2TB drives for LVM to manage,
 there's only space for 1 or 2 old kernel versions to fallback on so I want to XtNd. HTTP://AskUbuntu.Com/questions/89710/how-do-i-free-up-more-space-in-boot
 suggests (with my minor edits) `umnt /boot;md /mnt/sda1;mnt /dev/sda1 /mnt/sda1;cp -a /mnt/sda1/* /boot/;umnt /mnt/sda1;v /etc/fstab;grub-install /dev/sda`
 although some posts say LVM installs need a sepR8 /boot so maybe I could test it on Aku's external drive first. Major problem is that not just filesystems but
 partitions also need to be resized at the beginning of sda so maybe just clean-sl8ing a fresh install with manual  sda1 /boot to have at least 1GB of ext2;
G61M86oU:DistUpgraded Ryu&&Aku also. Aku said some 3rdParty NtrEz in sources.list disabled. rENAbl aftr upgrade with software-properties or package manager;
G61MAOOH:It looks like g3 requires pmfi IO::Tty; Maybe `v /etc/apt/sources.list` to s/wily/xenial/g then aguu would let `ag dist-upgrade` work for term log.
 Might be safer to agu, agi update-manager-core, do-release-upgrade instead since dist-upgrade may remove important packages due to dependency issues. The GUI
 DistUpgradeTool writes what I want anyway to /var/log/dist-upgrade/apt-term.log; G61ME026:Also mplayer is no longer installed;
G66MBT2v:`openssl rand -base64 64` from HTTPS://Ask.SlashDot.Org/story/16/06/06/0119217/ask-slashdot-how-do-you-create-a-highly-secure-password#comments for
 gener8ing strong passwords. Also try `pwgen -cny 64` && maybe checkout manager `pass`;
H11LHUG1:Ken:did aguu wiLinuxFirmware&&TTF-MSCoreFonts-installer&&plymouth-theme-ubuntu-text problMz B4 stRtng upgrd2 16.10,had many probz wi Linux4.8 &&
 initramfs-tools on tiny /boot,had2mv i*c /root/.boot/i*z-H11LHUG1/ during agi linux-firmware,not sure why now gNr8ng initrd.imgz 4all oldkrnlz found&&filngup;
H21L9EU9:Had to do alot of `agr linux-image-...` on Aku && Ryu so that only 2 initrd.imgz get crE8d that will fit on my frustr8ingly tiny /boot pRtitionz. On
 Aku 4.8.0-34 was brOkN so had2 dangerously `agr linux-image` virtual pkg thN agi it back. Ryu didn't encounter that issue;
H4JMHSFJ: Ubu17.04 upgrade: Copied ~/lib/perl5/lib/perl5/Math/Base ~/lib/Math/ then moved huge old perl5 aside before fresh pmei CPAN Curses SDL Expect to fix
 d8ok, ckm8, upd8, && g3. Need Color::Similarity && Algorithm::ChooseSubsets for pm2x && pokr. kpc uses many modules but seems2work fine without any new pmei.
 Copied Color && Algorithm into ~/lib/ since they're likely2work4newer perls && it should be more convenient2keep them near my home lib with other essentialz;
H5GMJLPr:`pmei YAML Term::Screen` to study how to best upd8 Simp since my original test.pl was based on it;
H5LMBaZ6:rEmMbr Ubu SysSetingz Keybd Shortctz are how Shift-F11 && F12 do volume down && up. Zoom && Neg8ive mappingz are in CompizConfigSetzMngr instead;
HAVMDEFT:rEmMbr to pmei Path::Tiny for slurp_utf8 (instead of poor File::Slurp) since Octology::p8::psps::gmap uses it && slurping may be faster to use
 elsewhere when multi-line parsing is needed. Try evaling it, && then to fallback on joining all gathered lines whenever it's not installed && available;
HBGL0LVM:Takeaway from pswd article was use `ai scrypt` for key deriv8ion looping slowed HMAC (Hashing Message Authentic8ion Code) described as available for
 file encryption vs lib(digest-bcrypt|crypt-pbkdf2)-perl vs Argon2 maybe PublicDomain since 2015 vs SCRAM(SaltedChallengeResponseAuthentic8ionMechanism)4pswd;
HBHLMWR4:Hal_Porter on /. assembly sign8ure:`echo -e 'global _start\n _start:\n mov eax, 2\n int 80h\n jmp _start' > a.asm; nasm a.asm -f elf; ld a.o -o a`;
HBQL73IP:From CommandLineFu.Com 0)`sudo !!` re-runs last cmnd. 1)`python -m SimpleHTTPServer` startz HTTP://$HOSTNAME:8000/ . 2)`^foo^bar` re-runs last cmnd
 with substitution and just `^z` will blank z's. 3)`Ctrl-x e` should call $EDITOR but does not work in my vim-styled zsh. 4)`Alt-.` should place arg of last
 cmnd on shell but just blanks lines on mine. 5)`reset` is known && handy. 6)`mnt|column -t` gives nice format. 7)`echo "ls -l"|at midnight` altern8 to cron.
 8)`curl ifconfig.me` gets external IP address. 9)`m ascii`might be like my UTF8. A)`dig +short txt <keyword>.wp.dg.cx`queries WikiPedia via consol over DNS.
 B)`dd if=/dev/dsp|ssh -c arcfour -C user@host dd of=/dev/dsp`output mic on remote putr speakr. C)`<Ctrl-u>...<Ctrl-y>`kill cmnd,type nw prefix,yank cmnd bak.
 D)`sshfs name@srvr:/path/to/fldr /path/to/mnt/pt`mount filesys thru SSH. E)`mnt -t tmpfs tmpfs /mnt -o size=1024m`mount tmp RAM pRtition. G)`Ctrl-l`clear.
 F)`wget --random-wait -r -p -e robots=off -U mozilla HTTP://Xmpl.Com`dnld entire site. I)`ssh user@host cat /path/to/remotefile|diff /path/to/localfile -`.
 H)`curl -u user:pass -d status="TweetFromShell" HTTP://Twitter.Com/statuses/update.xml`. J)`time read`Ctrl-d to stopwatch. L)`lS +F logfile`BhAv lIk tail-f.
 K)`ssh -t reachablehost ssh unreachablehost`connect thru SSH host in middle. M)`telnet Towel.BlinkenLights.Nl`Ctrl-] to stop StarWars. N)`disown -a && exit`
  closes shell keeping all subprocesses running. O)`while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &`puts console clock up-right;
HBSLHPDE:Contempl8 altern8ives to Ubu 17.10 default Gnome 3, maybe preserving Unity 7, helping Unity 8?, trying out Mate, XFCE, Cinnamon, FluxBox, WindowMaker,
 KDE, && research any other capable altern8ives, maybe trying all the stable DE releases within VirtualBox (or othr VM) for experiment8ion && fE8ure evalU8ion;
HC6LNDRM:/. article on explaining copyright had comment recommending EPubs with Calibre as DRM-free content format for at least Kindle eBooks && maybe others?;
I2PLEASE:After Akuma reboot && auu getting lots, included linux4.13.0-36 that spewed many warnings "W: Possible missing firmware /lib/firmware/amdgpu/raven_*";
I46MNuts:Might want to try new sS gener8ion for monospace HTML for GitHub MarkDown with {::nomarkdown} <!-- HTML CODE--> {:/} && StackOverflow links whitelist
of tags HTTPS://GitHub.Com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb#L41-L44 includes: h1 h2 h3 h4 h5 h6 h7 h8 br b i strong em
a pre code img tt div ins del sup sub p ol ul table thead tbody tfoot blockquote dl dt dd kbd q samp var hr ruby rt rp li tr td th s strike summary details.
MarkDown supports backslash eScaping of: \ backslash, ` backtick, * asterisk, _ underscore, {} curly braces, [] square brackets, () parentheses, # hash mark,
+ plus sign, - minus sign (hyphen), . dot, && last ! exclam8ion point. SepR8 after blank line && all code blocks indented 4 spaces wrap <pre> around <code>;
I71M0USB:Last night my HHKBLite2USB on Aku 17.10 stopped working repeatedly && sometimes replugging resolved temporarily, only to fail again a little bit l8r.
HTTPS://AskUbuntu.Com/questions/966799/ubuntu-17-10-keyboard-not-working-after-login-following-upgrade-from-17-04-gnom suggests `agr fwupd` may fix problem.
Also ran `aar` to AutoRemove libdfu1 as well. HTTPS://AskUbuntu.Com/questions/997008/keyboard-issue-in-ubuntu-17-10 similar problem description indic8s that
maybe `ag --purge autoremove xserver-xorg-input-all && agi xserver-xorg-input-all` then rebooting may be another avenue for resolving whatever the issue is.
With Ubuntu 18.04LTS, might want to track down obsolete cowsay-off_ensive quote pool && gnome-tweak-tool, to see what happened, whether incorpor8d elsewhere;
I8OMJOTD:Ubuntu 18.04.1 LTS Chun tty3 pip Last login: Sun Nov 12 05:28:25 CST 2017 on tty6 Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-32-generic x86_64)
 * Introducing Minimal Ubuntu for docker and clouds. 30 MB base image and optimised kernels on public clouds. Made for machines and containers.
 * Canonical Livepatch is available for installation.              - https://bit.ly/minimal-ubuntu
   - Reduce system reboots and improve kernel security. Activate at: https://ubuntu.com/livepatch
You have packages from the Hardware Enablement Stack (HWE) installed that are going out of support on 2023-04-30.
There is a graphics stack installed on this system. An upgrade to a configuration supported for the full lifetime of the LTS will become available on
  2020-07-21 and can be installed by running 'update-manager' in the Dash.  *** System restart required ***  [pip@ChunI8OMJb7N~]
Two packages are recommended to perform backups of your clients and servers in ubuntu: 'backuppc' and 'bacula'.
I98MK98I:may need in /etc/gdm3/custom.conf to uncmnt WaylandEnable=false && then try using non-Unity Guy2go2Dfalt Settings>Devices>Displays then save a local
  ~/.config/monitors.xml over2 /var/lib/gdm/.config/ then see if a thorough reboot cycle can bring back up the GnomeDisplayManager login with screens ordered.
Reading about setting up new Tor Browser v8, if ever needing to open mainly .doc or PDF files externally which were downloaded through Tor, they have strongly
  recommended only doing it offline l8r, downloading free HTTPS://VirtualBox.Org && using it with an HTTP://VirtualBoxes.Org VM image with networking disabled
  or by using HTTPS://Tails.Boum.Org instead. Under no circumstances is it safe to use BitTorrent && Tor together, since BT design deanonymizes && slows Tor.
If it l8r seems worthwhile to reduce risk of net traffic inspections revealing Tor usage, try configuring to use a 'bridge relay' rather than directly public.
Try HTTPS://GitHub.Com/TheTorProject/gettorbrowser mirror if Project direct download site blocked or censored, or HTTPS://TorProject.Org/projects/gettor srvc;
I9EMHaZR:Replacing Sony KDS-R50XBR1 XL-5100 used lamp: contains mercury. Disposal maybe regul8d if in UnitedSt8s. For disposal or recycling inform8ion, please
  contact local authorities or Electronics Industries Alliance (HTTP://EIAE.Org).  Don't leave used lamp near flammable materials or within reach of children.
Don't pour water on lamp or put object in lamp. Doing so may cause lamp to burst. HTTPS://ManualsLib.Com/manual/162335/Sony-Kds-R50xbr1.html?page=107#manual ;
I9LMHHKB:It seems that plugging the StarTech USB3 hub into the RoseWill USB3 PCIe cRd accepts my USB1.1 HappyHackingKeyBoard without constant disconnections.
Maybe a major part of the disconnection issue is due to USB cord damage as it comes out of the keyboard, such that reinforcement may help resolve better too;
I9RM9Ses:HTTPS://AddOns.Mozilla.Org/en-US/firefox/addon/tab-session-manager/?src=find-replacement was suggested to supplant legacy extension "Session Manager"
  but it has 216 1-star r8ings, 177 5-star, && almost 100 for the stars in between, which indic8s I should read over reviews before attempting to install it;
IA2MJAM2:Research why Aku's boot start reports "WARNING: Failed to connect to lvmetad. Falling back to device scanning." && hopefully resolve whatever issue.
  Also HDMI output to my left AsusVG248 is glittering glitchy, so probably try to power-down && reconnect plugs before attempting to swap in a better cable;
IA2MNewS:After finishing Ryu's partial 18.04 Dist-Upgrade, gnome-initial-setup recommended applic8ions which may be useful l8r:  Spotify,Wire,RedisDsktpMngr,
 WalPaprDnLdr,FooBar2000,TrenchBroom,MiniZinc,JGalaxian,Vectr,WhaleBird,SmartScreen,CryptoWatch,Kotlin8ive,BitWarden,FromScratch,WaveBox,Kata-Containers,LXD;
IA6MBCal:HTTPS://GitHub.Com/jarun/bcal looks to be an interesting && valuable Byte-CalQl8or for d8a-storage expressions like `du -sb` using unit-conversions;
IA6MBana:HTTPS://OctoBanana.Com/software/crex seems to be a nice Utl to explore, test, && Check Regular EXpressions from standard Unix terminal command-line;
IA6MCalc:HTTPS://GitHub.Com/andmarti1424/sc-im looks like a nice Utl with vim-bindings as NCurses "Spreadsheet CalQl8or IMprovised" maybe to clone as `m8rx`;
IA8MBash:HTTPS://Reddit.Com/r/commandline/comments/9md3pp/a_very_useful_bashrc_file seems pretty str84ward, but may contain some nuggets worth learning from;
IA8MNewU:Quite unsettlingly today for only probably less than 1 minute, my USB keyboard became waveringly unresponsive again for the first time since recnfg;
IAUMDXsu:HTTPS://YouTu.be/3vCpYgaZpiw 'eXploit X:"Give Me Root" - Computerphile' # 11m36s `cd /etc;Xorg -fp "root::16431:0:99999:7:::" -logfile shadow :1;su`
#   SUID exploit explan8ion && demonstr8ion. Mitig8ion recommend8ion (pre-patch) is remove Xorg SetUID bit via `chmod u-s /usr/bin/Xorg`. Aku's already done;
IB3M0TDU:Last login: Tue Oct  2 23:22:26 CDT 2018 from 192.168.8.7 on pts/51    Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-38-generic x86_64)
 * Documentation:  HTTPS://Help.Ubuntu.Com                          * Security certifications for Ubuntu!  We now have FIPS, STIG, CC and a CIS Benchmark.
 * Management   :  HTTPS://LandScape.Canonical.Com                      - HTTPS?://Bit.Ly/Security_Certification
 * Support      :  HTTPS://Ubuntu.Com/advantage                     * Want to make a highly secure kiosk, smart display or touchscreen?
     Here's a step-by-step tutorial for a rainy weekend, or a startup.  - HTTPS://Bit.ly/secure-kiosk     For a lightweight VPN alternative, have a look at:
   ssh + netcat-openbsd for SOCKS proxy support.                    * Canonical Livepatch is available for installation.
   - Reduce system reboots and improve kernel security. Activate at:      HTTPS://Ubuntu.Com/livepatch ;
IB8LDATE:b64 `date --date="Nov 8 08:08:08 CST 2018" +%s` will return the Unix epoch time in integer seconds && could be popUl8d with current d8 valUz easily;
IC8LEARN:HTTPS://ROG.Asus.Com/forum/archive/index.php/t-94543.html down in the thread, good advice posted by: 'Nighter3D' 07-13-2017, 06:41 PM listed tests:
  When I build, buy, or diagnose any system, I always try to run a set of stress tests. See if any component does well enough or if any has a risk being DOA.
  1) Memtest86. Make sure the memory is not defective.  # I would run this particular set of tests in succession:   ## Probably pretty worthwhile protocol!
  2)   Prime95. Stress   CPU, Motherboard, && Memory. (Don't forget to have something capable of reading temps like HW Monitor or AI suite). OCCT works too.
  3) Furmark  . Push the GPU to the thermal limit.      # OCCT alone is not a reliable evalU8ion. Gotta go through a full set of tests for thorough results.
  4) Assorted benchmarks. Think Unigine, 3DMark, AIDA64 && the likes.  # Note: Just because memory is approved, do *NOT* expect it to run it at full speed.
  #  I got a 3200MHz set, but even with AGESA1006 I can run it at 2966MHz tops. Quite a few have made that mistake. May be especially applicable for Ryzen. ;
ICILEMAI:Just sync'd l8st PS@GMail to ThunderBird then disabled insecure POP in GMail settings. Now trying to reconfigure Tbird from POP.GoogleMail.Com:995 to
  IMAP.GMail.Com:993 Incoming (requires SSL) && SMTP.GMail.Com Outgoing (requires SSL:465 && (START)?TLS:587 if available, as well as authentic8ion) somehow;
ICILEFTB:HTTPS://AskUbuntu.Com/questions/91815/how-to-install-software-or-upgrade-from-an-old-unsupported-release seems to have the sed command needed for Ken
  to attempt to catch up from the unsupported Zesty 17.04 to Bionic 18.04.1, by replacing (Archive|Security) with Old-Releases in sources.list URLs before:
  `agu;ag dist-upgrade` to prepare for `agu;agi update-manager-core;do-release-upgrade` which will hopefully get him to 17.10 && allow normal 18.04 upgrade;
ICJL0l01:Trying to login to Unity on Ken at 18.04.1LTS? Bionic keeps crashing, but said: "System program problem detected" after dialog about empty error in
  "configur8ion for monitors" having some error on line 1 because there was no file, it was empty, or it contained whitespace where it expected monitor cfg;
ICJLG4c7:`lshw -numeric -C display` && `lsp -vnn|gi vga` are totally gr8 for Ken to see much card detail, but *-display UNCLAIMED still, need Dell2407WFP8/5!;
ICJLI304:HTTPS://Ubuntu-Mate.Community/t/nvidia-304-driver-install-in-18-04/16787/43 seemed to have all the essential directions with clearly sound patch! ##;
ICPLANvi:Ken getting new kernels needs sources then in /root/.inst/NVIDIA-Linux-x86_64-304.137/ : `./nvidia-installer ; ai --reinstall libvdpau1 ; reboot` ##;
ICPLIVEP:Research Canonical LivePatch (crE8 administr8ion login) && best ways to add Signal && BraveBrowser PGP keys && /etc/apt/ sources to Ryu, Ken,&& Chun;
ICPLKVMs:It seems that Synergy+ lives on over SSL from at least HTTPS://GitHub.Com/debauchee/barrier forked v1.9 of HTTPS://GitHub.Com/Symless/synergy-core ;
ICQLCURL:`curl -s      https://updates.signal.org/desktop/apt/keys.asc    |sudo apt-key add - `; # BraveBrowser is probably similar again && for Barrier #;
 `ec "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main"|sudo tee -a /etc/apt/sources.list.d/signal-xenial.list ;sz;au;ai signal-desktop`;
 `sz    ; cs           https://brave-browser-apt-release.s3.brave.com/brave-core.asc|akad `; # S_B-B.ReadTheDocs.IO/en/latest/installing-brave.html#linux
 `ec "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/  `lsbc` main"|T /etc/apt/sources.list.d/brave-browser-release-`lsbc`.list ;au;ai ...
sz;auu;ai git cmake xorg-dev libcurl4-openssl-dev libssl-dev  libqt4-dev \                               # ... brave-browser brave-keyring`;
          g++  make  libavahi-compat-libdnssd-dev libx11-dev qtbase5-dev;x;cd            ~/dvl/m8/barr/barrier;./clean_build.sh;cd build
sudo           make  install; #ec  '  # installs to: /usr/local/ ;' #it clone git@github.com:debauchee/barrier.git; #en ' # cud proly`g8 c`nstd;'
J18L470X:If Oni gets ASRock TaiChi X470, might require reset BIOS to default before flashing (like X370 FAQ says, since it had no DualBIOS, but X470 fixed?);
J18L4VRM:VRM = VoltageRegul8orModule (or PPM = ProcessorPowerModule) according to HTTPS://En.WikiPedia.Org/wiki/Voltage_regulator_module on AM4 motherboards;
J18LNote:"MicroK8s is Kubernetes in a snap. Made by devs for devs. One quick install on a workstation, VM, or appliance." HTTPS://Bit.ly/microk8s
 * Full K8s GPU support is now available! HTTPS://Blog.Ubuntu.Com/2018/12/10/using-gpgpus-with-kubernetes  # these tips just came up as login MotD on Ryu;
 * Canonical Livepatch is available for installation. Reduce system reboots and improve kernel security. Activate at: HTTPS://Ubuntu.Com/livepatch ;
J55M3Cmp:On Oni, CompizConfigSettingsManager was fiddled with but the Utility > 'Enable Workarounds' to make things like MetaCity originally had defaults of:
  General > (checked) 'OpenOffice.Org Menu Fix', 'Java Window/TaskBar Fix', 'AIGLX Parameter Fix', && 'Force Complete ReDraw on Initial Damage' before I setup
  most of the unused fixes to be used also. I deliber8ly ran CCSM to loc8 the option to show window resize dimension notific8ions (&& haven't found that yet,
  if it's even still available), but I upd8d my 1x1 virtual desktops to 8 preferred in 4x2. Also note yesterday I ran:`sz;auu;ai dfc xclip irssi` + some pmei;
J5IMEDIT:According to HTTPS://AskUbuntu.Com/questions/774394/wheres-the-gnome-terminal-config-file-located I can use `dconf dump /org/gnome/terminal/ > file`
  && `dconf load file` to gener8 other profiles. Also `dconf write /org/gnome/desktop/interface/cursor-blink-timeout 16` used && default was probably 12-secs;
J7IMNOSN:It seems signal-desktop runs via ~/snap so maybe wrap sig alias in ending cp to ~/.snap/signal-desktop or mv so that rd ~/snap can get out of $HOME;
JAQM5kpc:Chun needed `sz;au;ai libreadline-dev;pmei Term::ReadLine::Gnu;pmei Crypt::Rijndael;pmei Sort::Naturally;pmei Term::ShellUI;pmei File::KeePass;
  pmei Clipboard;pmei Capture::Tiny;x;kp` to run my keepass-cli varE8ion; # `ps` commands below showed pip's orphaned pulseaudio to kill && got rid of mpg123;
K23LDead:After trying to run mpg123 on a DubStep.FM MP3 stream which hung && couldn't be killed (even with -9 && sending signals through htop to it), I found:
  `ps -elf|head -1;ps -elf|awk '{if ($5 == 1 && $3 != "root") {print $0}}'|head` HTTPS://RealScripting.BlogSpot.Com/2013/05/killing-orphans-and-zombies.html ;
K23LJACK:Thinking about Cg8FireCuda500GBSSD coming soon, rediscovered `dpkg -l|giv '^ii'|giv linux|cut -s -d' ' -f2-3|g '^ '` as way to grep list of RmvdCfgz
  but `ai appmenu-gtk-module-common apport fuse gpsd gtk3-nocsd jackd1 libc6-amd64:i386 libcxxtools9v5 libdvd-pkg libsensors-config libtirpc-common lirc lsm`
  wanted to Remove way too many clang fuse g++ gcc ladi jack && lib pkgz which seem more important to Oni than few install candid8z, so aborted the oper8ion.
  Trying just `ai appmenu-gtk-module-common apport gpsd gtk3-nocsd libdvd-pkg libsensors-config libtirpc-common lirc lsm` only wantd2 Remove systemd-coredump
  so allowed to proceed, expecting sysd-cordmp can just be agri back over its conflict afterward if it seems necessary or useful enough to try doing so 4 it.
  apport was the conflict but sd-cd provided coredumpctl cdc so I swapped them back && libdvd-pkg's attempt to get src && ag check failed so agr on that too;
K27LBROX:After attempting `~/dvl/c8/trm8/;g8c git://git.code.sf.net/p/roxterm/code roxterm;roxterm/;python ./mscript.py configure;python ./mscript.py build`
  && ai itstool sgml po4a ImageMagick python-lockfile && whatever other needed packages following Install directions on HTTP://ROXTerm.SF.Net I realized that
  recent Ubu pkgz are being built on an untrusted PPA so `sz;add-apt-repository ppa:h-realh/roxterm;au;ai roxterm` should work fine even if src won't build;
K28LBGDM:HTTP://Forums.Debian.Net/viewtopic.php?f=6&t=122320 has `sz;/var/lib/gdm3/.config/;cp ~/.config/monitors.xml .;cho gdm:gdm monitors.xml` 2OriNtGDM;
K47MM7MM:`agr linux-headers-5.3.0-40 linux-headers-5.3.0-40-generic linux-image-5.3.0-40-generic linux-modules-5.3.0-40-generic lin*-extra-5.3.0-40-generic`
  was going to run just now, but decided to leave these 5.3.0-40-generic packages installed (even though *-42-generic already agar'd with 45 && 46 current);
L8MMMUni:[pip@OniL8MMMacs~]acs unity g unity  # try to figure out all Unity packages Oni has which probably Ryu && Aku are also going to need for their D.E.;
gir1.2-unity-5.0                              ii  7.1.4+19.04.20190319-0ubuntu3    amd64   GObject introspection data for      the Unity     library
libunity-dev                                  ii  7.1.4+19.04.20190319-0ubuntu3    amd64   binding to get places into the launcher - development files
libunity-protocol-private0                    ii  7.1.4+19.04.20190319-0ubuntu3    amd64   binding to get places into the launcher - private library
libunity-scopes-json-def-desktop              ii  7.1.4+19.04.20190319-0ubuntu3    all     binding to get places into the launcher - desktop def file
libunity9                                     ii  7.1.4+19.04.20190319-0ubuntu3    amd64   binding to get places into the launcher - shared  library
yaru-theme-gnome-shell                        ii  20.04.11.1                       all     Yaru GNOME Shell desktop theme from the Ubuntu Community
yaru-theme-gtk                                ii  20.04.11.1                       all     Yaru GTK                 theme from the Ubuntu Community
yaru-theme-icon                               ii  20.04.11.1                       all     Yaru icon                theme from the Ubuntu Community
yaru-theme-sound                              ii  20.04.11.1                       all     Yaru sound               theme from the Ubuntu Community
libunity-api-dev                              ii  8.7+17.04.20170404-0ubuntu4      amd64   Header files  for Unity API
libunity-api-doc                                                                           Documentation for Unity API
libunity-api0                                 ii  8.7+17.04.20170404-0ubuntu4      amd64   API for Unity shell integration
libunity-control-center-dev                   ii  15.04.0+19.10.20190921-0ubuntu3  amd64   utilities to configure the GNOME desktop
libunity-control-center1                      ii  15.04.0+19.10.20190921-0ubuntu3  amd64   utilities to configure the GNOME desktop
libunity-core-6.0-9                           ii  7.5.0+20.04.20200312-0ubuntu1    amd64   core library for the Unity interface
libunity-core-6.0-dev                         ii  7.5.0+20.04.20200312-0ubuntu1    amd64   Core library for the Unity interface - development files
libunity-gtk-parser-dev-common                ii  0.0.0+18.04.20171202-0ubuntu2    all     Common files for GtkMenuShell to GMenuModel parser
libunity-gtk2-parser-dev                      ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell to GMenuModel parser
libunity-gtk2-parser0                         ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell to GMenuModel parser
libunity-gtk3-parser-dev                      ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell to GMenuModel parser
libunity-gtk3-parser0                         ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell to GMenuModel parser
libunity-misc-dev                             ii  4.0.5+14.04.20140115-0ubuntu3    amd64   Miscellaneous functions for Unity - development files
libunity-misc-doc                                                                          Miscellaneous functions for Unity - documentation
libunity-misc4                                ii  4.0.5+14.04.20140115-0ubuntu3    amd64   Miscellaneous functions for Unity - shared library
libunity-scopes-json-def-phone                                                             binding to get scopes into the launcher - phone def file
libunity-settings-daemon-dev                  ii  15.04.1+20.04.20200325-0ubuntu1  amd64   Helper library for accessing settings (development files)
libunity-settings-daemon1                     ii  15.04.1+20.04.20200325-0ubuntu1  amd64   Helper library for accessing settings
libunity-tools                                                                             binding to get places into the launcher - debugging tools
surf                                          un  <none>                           <none>  Simple web browser by suckless community
tldr-py                                                                                    Python client for tldr: simplified and community-driven man pages
ubuntu-unity-desktop                          ii  0.2                              amd64   The Ubuntu Unity desktop system
unity                                         ii  7.5.0+20.04.20200312-0ubuntu1    amd64   Interface designed for efficiency of space and interaction.
unity-accessibility-profiles                  ii  0.1.11-0ubuntu4                  all     Accessibility Profile Manager - Unity profile data
unity-asset-pool                              ii  0.8.24+17.10.20170507-0ubuntu1   all     Unity Assets Pool
unity-autopilot                                                                            Autopiloted tests for Unity
unity-china-video-scope                                                                    China video scope for Unity
unity-control-center                          ii  15.04.0+19.10.20190921-0ubuntu3  amd64   utilities to configure the GNOME desktop
unity-control-center-dev                      ii  15.04.0+19.10.20190921-0ubuntu3  all     utilities to configure the GNOME desktop
unity-greeter                                 ii  18.04.0+20.04.20200312-0ubuntu2  amd64   Unity Greeter
unity-greeter-badges                                                                       Additional badges for Unity Greeter
unity-gtk-module-autopilot                                                                 GtkMenuShell D-Bus Autopilot tests
unity-gtk-module-common                       ii  0.0.0+18.04.20171202-0ubuntu2    all     Common files for GtkMenuShell D-Bus exporter
unity-gtk2-module                             ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell D-Bus exporter
unity-gtk3-module                             ii  0.0.0+18.04.20171202-0ubuntu2    amd64   GtkMenuShell D-Bus exporter
unity-lens-applications                       ii  7.1.0+16.10.20160927-0ubuntu5    amd64   Application     lens for unity
unity-lens-files                              ii  7.1.0+17.10.20170605-0ubuntu2    amd64   File            lens for unity
unity-lens-music                              un  <none>                           <none>  Music           lens for unity
unity-lens-photos                                                                          Photos          lens for Unity
unity-lens-video                              un  <none>                           <none>  Unity Video     lens
unity-mail                                                                                 Mail notifications and count for Unity/MATE/Xfce/LXDE/etc.
unity-schemas                                 ii  7.5.0+20.04.20200312-0ubuntu1    all     Interface designed for efficiency of space and interaction.
unity-scope-calculator                        un  <none>                           <none>  Calculator     scope for Unity
unity-scope-devhelp                                                                        devhelp        scope for Unity
unity-scope-gnote                                                                          Gnote          scope for Unity
unity-scope-home                              ii  6.8.2+19.04.20190412-0ubuntu2    amd64   Home scope that aggregates results from multiple scopes
unity-scope-launchpad                         un  <none>                           <none>  Launchpad      scope for Unity
unity-scope-manpages                          un  <none>                           <none>  Manual pages   scope for Unity
unity-scope-soundcloud                        un  <none>                           <none>  SoundCloud     scope for Unity
unity-scope-tomboy                                                                         Tomboy         scope for Unity
unity-scope-video-remote                                                                   Remote videos engine
unity-scope-virtualbox                        ii  0.1+13.10.20130723-0ubuntu2      all     VirtualBox     scope for Unity
unity-scope-yahoostock                        un  <none>                           <none>  Yahoo! Finance scope for Unity
unity-scope-zotero                                                                         Zotero         scope for Unity
unity-scopes-master-default                   ii  6.8.2+19.04.20190412-0ubuntu2    all     Home scope that aggregates results from multiple scopes
unity-scopes-runner                           ii  7.1.4+19.04.20190319-0ubuntu3    all     desktop runner for misceallenous scopes
unity-services                                ii  7.5.0+20.04.20200312-0ubuntu1    amd64   Services for the Unity interface
unity-session                                 ii  3.36.0-2ubuntu1                  all     Unity session, previous ubuntu default experience.
unity-settings-daemon                         ii  15.04.1+20.04.20200325-0ubuntu1  amd64   daemon handling the Unity session settings
unity-settings-daemon-dev                     ii  15.04.1+20.04.20200325-0ubuntu1  amd64   Headers for building applic8ns communic8ng wi unity-settings-daemon
unity-settings-daemon-schemas                 ii  15.04.1+20.04.20200325-0ubuntu1  all     Shared schemas for gnome-settings-daemon
unity-tweak-tool                              ii  0.0.7+-0ubuntu6                  all     configuration tool for the Unity desktop environment
xubuntu-community-wallpapers                                                               Xubuntu community wallpapers
xubuntu-community-wallpapers-bionic                                                        Xubuntu community wallpapers (Bionic)
xubuntu-community-wallpapers-focal                                                         Xubuntu community wallpapers (Focal )
xubuntu-community-wallpapers-trusty                                                        Xubuntu community wallpapers (Trusty)
xubuntu-community-wallpapers-xenial                                                        Xubuntu community wallpapers (Xenial)
yaru-theme-unity                                                                           Yaru Unity theme from the Ubuntu Community ; # shud be most needed;
