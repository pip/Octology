Duckduckgo, w3m, and mpv (Score:2) by TheOuterLinux ( 4778741 ) Alter Relationship on Saturday December 23, 2017 @04:06PM (#55798715)
The Linux way: I use DuckDuckGo in a text web browser (w3m) or something quick like Dillo. DDG doesn't show me a bunch of useless, click-bait info like
Google does. Then, if I want to watch YouTube videos (use HTTPS://TOnVid.Com [tonvid.com] as frontend) or any other website with youtube-dl supported
embeds (HTTPS://RG3.GitHub.IO/youtube-dl/supportedsites.html), I can set w3m's external browser setting to "mpv -ytdl --vo=opengl,drm,caca --
ao=pulse,alsa. Using the commas sets a priority order just in case one is not supported. Then, I set w3m's user-agent to mobile Safari. This forces most
video and radio sites to switch to mobile friendly, Adobe-free, format like MP4, m3u, etc. If you do open a page and get a JS error, ignore it and press
Shift+M to launch mpv anyway; youtube-dl will parse the URL for you. Using mpv as my player, I can stream videos to my computer in both GUI and TTY as
long as I'm runlevel 3 or 5 and have keyboard controls, which vlc-nox does not in TTY. It's basically an easier to use fork of mplayer. Made a tutorial
here: HTTPS://BitChute.Com/video/iuVQrGO3yeRz [bitchute.com]. No ads, no JS tracking, and lightning speed. And yes, that also means getting your p0rÃ± fix
without lea in the command-line. ;)
