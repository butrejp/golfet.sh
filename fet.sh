eq()case $1 in $2);;*)return 1;esac
wm=${XDG_CURRENT_DESKTOP:-$DESKTOP_SESSION}
for o in /etc/os-release /usr/lib/os-release;do [ -f $o ]&&. $o&&break;done
if [ -e /proc/$$/comm ];then
until [ "$term" ];do
while read -r l;do eq "$l" 'PPid*'&&p=${l##*:?}&&break;done<"/proc/${p:-$PPID}/status"
[ "$P" = "$p" ]&&break;P=$p;read -r n<"/proc/$p/comm"
case $n in *sh|"${0##*/}");;*login*|*init|*systemd*)break;;*)term=$n;esac
done
[ "$wm" ]||for i in /proc/*/comm;do read -r c<"$i";case $c in *bar*|*rc);;awesome|xmonad*|qtile|sway|i3|[bfo]*box|*wm*)wm=${c%%-*};break;esac;done
while read -r a m _;do eq "$a" 'MemTotal*'&&break;done</proc/meminfo;mem="$((m/1000))MB"
while read -r l;do case $l in vendor_id*)v="${l##*: } ";;model*name*)cpu=${l##*: };break;esac;done</proc/cpuinfo
IFS=. read -r u _ </proc/uptime;d=$((u/86400));up=$(printf %02d:%02d $((u/3600%24)) $((u/60%60)))
[ "$d" -gt 0 ]&&up="${d}d $up"
read -r _ _ k _ </proc/version;kernel=${k%%-*};eq "$k" '*Microsoft*'&&ID="fake $ID"
read -r m</sys/devices/virtual/dmi/id/product_name
case $m in 'System '*|'Default '*|'To Be Filled'*)read -r m</sys/devices/virtual/dmi/id/board_name;esac
for i in '/var/db/kiss/installed/*' '/var/lib/pacman/local/[0-9a-z]*' '/var/lib/dpkg/info/*.list' '/var/db/xbps/.*' '/var/db/pkg/*/*';do set -- $i;[ $# -gt 1 ]&&pkgs=$#&&break;done
read -r h</proc/sys/kernel/hostname;elif [ -f /var/run/dmesg.boot ];then
read -r b</var/run/dmesg.boot;case $b in Open*)while read -r l;do case $l in 'real mem'*)mem=${l##*\(};mem=${mem%\)*};;cpu0*)cpu=${l#cpu0: };cpu=${cpu%%,*};v=${cpu%% *};break;;*)[ "$ID" ]||{ set -- $l;ID="$1 $2"; };esac;done</var/run/dmesg.boot;[ -d /var/db/pkg ]&&set -- /var/db/pkg/*&&pkgs=$#;read -r h</etc/myname;h=${h%.*};;*) . /etc/rc.conf;h=$hostname;while read -r l;do case $l in FreeBSD*)[ "$ID" ]&&continue;ID=${l%%-R*};;CPU:*)cpu=${l%\(*};;*Origin=*)v=${l#*Origin=\"};v="${v%%\"*} ";;'real memory'*)mem=${l##*\(};mem=${mem%\)*};break;esac;done</var/run/dmesg.boot;esac;elif v=/System/Library/CoreServices/SystemVersion.plist;[ -f "$v" ];then
while read -r l;do case $l in *ProductVersion*)t=.;;*)[ "$t" ]||continue;ID=${l#*>};ID="MacOS ${ID%<*}";break;esac;done<"$v"
fi
eq "$0" '*fetish'&&printf 'Step on me daddy\n'&&exit
eq "$wm" '*[Gg][Nn][Oo][Mm][Ee]*'&&wm='foot DE'
while read -r l;do eq "$l" 'gtk-theme*'&&gtk=${l##*=}&&break;done<"${XDG_CONFIG_HOME:=$HOME/.config}/gtk-3.0/settings.ini"
v=${v##*Authentic};v=${v##*Genuine};cpu=${cpu##*) };cpu=${cpu%% @*};cpu=${cpu%% CPU};cpu=${cpu##CPU };cpu=${cpu##*AMD };cpu=${cpu%% with*};cpu=${cpu% *-Core*}
col()(printf '  ';for i in 1 2 3 4 5 6;do printf '\033[9%sm%s' "$i" "${colourblocks:-▅▅}";done;printf '\033[0m\n')
p()([ "$2" ]&&printf '\033[9%sm%6s\033[0m%b%s\n' "${accent:-4}" $1 "${separator:- ~ }" "$2")
for i in ${info:-n user os sh wm up gtk cpu mem host kern pkgs term col n};do case $i in n)echo;;os)p os "$ID";;sh)p sh "${SHELL##*/}";;wm)p wm "${wm##*/}";;up)p up "$up";;gtk)p gtk "${gtk# }";;cpu)p cpu "$v$cpu";;mem)p mem "$mem";;host)p host "$m";;kern)p kern "$kernel";;pkgs)p pkgs "$pkgs";;term)p term "$term";;user)printf '%7s@%s\n' "$USER" "$h";;col)col;esac;done
