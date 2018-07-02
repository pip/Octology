# ECILIpU5:~/dox/2du/tipz.ls crE8d by PipStuart <Pip@CPAN.Org> to track full-scrn GNU/Linux console login fortune-like tipz worth remembering;$d8VS='I47M04sS';
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
