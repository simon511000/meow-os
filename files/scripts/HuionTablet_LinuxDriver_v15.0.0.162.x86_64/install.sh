#!/bin/bash

# uninstall Gaomon driver first
# DPKG_INFO_GAOMON_PREINST="gaomontablet.preinst"
# CHECK_SYS_DPKG_INFO_GAOMON_PREINST=`ls -l /var/lib/dpkg/info | grep gaomontablet.preinst`
# if [[ $CHECK_SYS_DPKG_INFO_GAOMON_PREINST =~ $DPKG_INFO_GAOMON_PREINST ]]
# then
#     sudo apt remove -y gaomontablet >/dev/null 2>&1
# else
# 	bash ./huion/huiontablet/uninstallGaomonDriver.sh
# fi

# cd to current path
dirname=`dirname $0`
tmp="${dirname#?}"
if [ "${dirname%$tmp}" != "/" ]; then
	dirname=$PWD/$dirname
fi

echo $dirname
cd "$dirname"

# close driver if it running
AppName=huiontablet
AppDir=huiontablet
pid=`ps -e|grep $AppName`
AppCoreName=huionCore
AppUIName=huiontablet

#Close running driver
#echo "close core"
sudo killall huionCore >/dev/null 2>&1
#echo "close tablet"
sudo killall huiontablet >/dev/null 2>&1

#Uninstall HUION driver first
sudo ./uninstall.sh || true

#Copy rule
sysRuleDir="/usr/lib/udev/rules.d"
sysRuleDir2="/lib/udev/rules.d"
appRuleDir=./huion/huiontablet/res/rule
ruleName="20-huion.rules"

#echo "$appRuleDir/$ruleName"
#echo "$sysRuleDir/$ruleName"
if [ -f $appRuleDir/$ruleName ]; then
	str=`cp $appRuleDir/$ruleName $sysRuleDir/$ruleName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
		str=`cp $appRuleDir/$ruleName $sysRuleDir2/$ruleName`
		if [ "$str" !=  "" ]; then 
			echo "Sstr";
		fi
	fi
else
	echo "Cannot find driver's rules in package"
	exit 1
fi

#install app
sysAppDir="/usr/lib"
appAppDir=./huion/$AppName
exeShell="huionCore.sh"

echo $sysAppDir
echo $appAppDir

if [ -d "$appAppDir" ]; then
	str=`cp -rf $appAppDir $sysAppDir`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's files in package"
	exit 1
fi

#echo "shell path "$AppDir/$exeShell
if [ -f $sysAppDir/$AppDir/$exeShell ]; then
	#str=`chmod +0755 $sysAppDir/$AppName/$exeShell`
	str=`chmod +0777 $sysAppDir/$AppName/$exeShell`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to start script"
		echo "$str";
		exit 1
	fi
else
	echo "can not find start script"
	exit 1
fi

#echo "exe path "$sysAppDir/$AppDir/$AppCoreName
if [ -f $sysAppDir/$AppDir/$AppCoreName ]; then
	#str=`chmod +0755 $sysAppDir/$AppDir/$AppCoreName`
	str=`chmod +0777 $sysAppDir/$AppDir/$AppCoreName`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to app Core"
		echo "$str";
		exit 1
	fi
else
	echo "can not find app Core"
	exit 1
fi

#echo "exe path "$sysAppDir/$AppDir/$AppUIName
if [ -f $sysAppDir/$AppDir/$AppUIName ]; then
	#str=`chmod +0755 $sysAppDir/$AppDir/$AppUIName`
	str=`chmod +0777 $sysAppDir/$AppDir/$AppUIName`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to app UI"
		echo "$str";
		exit 1
	fi
else
	echo "can not find app UI"
	exit 1
fi

if [ -f /home/*/HuionCore.pid ]; then
	str=`rm -f /home/*/HuionCore.pid`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f /home/*/DriverUI.pid ]; then
	str=`rm -f /home/*/DriverUI.pid`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f /home/*/huion.log ]; then
	str=`rm -f /home/*/huion.log`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

#echo "exe path "$sysAppDir/$AppDir/.HuionCore.pid
if [ -f $sysAppDir/$AppDir/.HuionCore.pid ]; then
	#str=`chmod 0766 $sysAppDir/$AppDir/.HuionCore.pid`
	str=`chmod 0777 $sysAppDir/$AppDir/.HuionCore.pid`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to .HuionCore.pid"
		echo "$str";
		exit 1
	fi
else
	echo "can not find .HuionCore.pid"
	exit 1
fi

if [ -f $sysAppDir/$AppDir/.DriverUI.pid ]; then
	#str=`chmod 0766 $sysAppDir/$AppDir/.DriverUI.pid`
	str=`chmod 0777 $sysAppDir/$AppDir/.DriverUI.pid`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to .DriverUI.pid"
		echo "$str";
		exit 1
	fi
else
	echo "can not find .DriverUI.pid"
	exit 1
fi

if [ -f $sysAppDir/$AppDir/log.conf ]; then
	#str=`chmod 766 $sysAppDir/$AppDir/log.conf`
	str=`chmod 777 $sysAppDir/$AppDir/log.conf`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to log.conf"
		echo "$str";
		exit 1
	fi
else
	echo "can not find log.conf"
	exit 1
fi

if [ -f $sysAppDir/$AppDir/.huion.log ]; then
	#str=`chmod 766 $sysAppDir/$AppDir/.huion.log`
	str=`chmod 777 $sysAppDir/$AppDir/.huion.log`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to .huion.log"
		echo "$str";
		exit 1
	fi
else
	echo "can not find .huion.log"
	exit 1
fi

# install shortcut
sysDesktopDir=/usr/share/applications
sysAppIconDir=/usr/share/icons
sysAutoStartDir=/etc/xdg/autostart

appDesktopDir=./huion/xdg/autostart/
appAppIconDir=./huion/icon/
appAutoStartDir=./huion/xdg/autostart/

appDesktopName=$AppName.desktop
appIconName=$AppName.png


if [ -f $appDesktopDir/$appDesktopName ]; then
#	str=`cp $appDesktopDir/$appDesktopName $sysDesktopDir/$appDesktopName`
	str=`cp -a $appDesktopDir/$appDesktopName $sysDesktopDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's shortcut in package"
	exit 1
fi

if [ -f $appAppIconDir/$appIconName ]; then
	str=`cp $appAppIconDir/$appIconName $sysAppIconDir/$appIconName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
	#echo $sysAppIconDir/$appIconName
	#stricon=`chmod 0766 $sysAppIconDir/$appIconName`
	stricon=`chmod 0777 $sysAppIconDir/$appIconName`
	if [ "$stricon" !=  "" ]; then 
		echo "Cannot add permission to app icon"
		echo "$str";
		exit 1
	fi
else
	echo "Cannot find driver's icon in package"
	exit 1
fi

if [ -f $appAutoStartDir/$appDesktopName ]; then
#	str=`cp $appAutoStartDir/$appDesktopName $sysAutoStartDir/$appDesktopName`
	str=`cp -a $appAutoStartDir/$appDesktopName $sysAutoStartDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
	
else
	echo "Cannot find set auto start"
	exit 1
fi

#Copy config files
#echo $sysAppDir/$AppDir/res
#strres=`chmod -R +0766 /usr/lib/huiontablet`
strres=`chmod -R +0777 /usr/lib/huiontablet`
if [ "$strres" !=  "" ]; then 
	echo "Cannot add permission to res"
	echo "$strres";
	exit 1
fi

strdevuinput=`chmod 0666 /dev/uinput`
if [ "$strdevuinput" !=  "" ]; then 
	echo "Cannot add permission 0666 to /dev/uinput"
	echo "$strdevuinput";
	exit 1
fi

CUSTOM_CONF_RES_PATH="./huion/huiontablet/custom.conf"
MINT_STR="Mint" #""  Type=x11
DEEPIN_STR="Deepin" #""  Type=x11
MANJARO_STR="Manjaro" #"/etc/gdm/custom.conf"
CENTOS_STR="CentOS" #"/etc/gdm/custom.conf"
UBUNTU_STR="Ubuntu" #"/etc/gdm3/custom.conf"
FEDORA_STR="Fedora" #"/etc/gdm/custom.conf"
CUSTOM_CONF_FILE="/etc/gdm/custom.conf"
check_os_release_result=`ls -li /etc/os-release | grep '^NAME' /etc/os-release`

if [[ $check_os_release_result =~ $UBUNTU_STR ]]
then
    CUSTOM_CONF_FILE="/etc/gdm3/custom.conf"
	if [ ! -d "/etc/gdm3/" ];then
		mkdir /etc/gdm3
	fi
else
	CUSTOM_CONF_FILE="/etc/gdm/custom.conf"
	if [ ! -d "/etc/gdm/" ];then
		mkdir /etc/gdm
	fi
fi

# changeWaylandToX11
if [ ! -f "$CUSTOM_CONF_FILE" ];then
    # custom.conf文件不存在，复制一个到系统目录下
	cp -a $CUSTOM_CONF_RES_PATH $CUSTOM_CONF_FILE
else
    WAYLAND_DISABLE_STR="#WaylandEnable=false"
	WAYLAND_ENABLE_STR="WaylandEnable=false"
    DEFAULTSESSION_IS_X11="DefaultSession=x11"
	DISABLE_DEFAULTSESSION_IS_X11="#DefaultSession=x11"
	SHARP_DAEMON_STR="#\\[daemon\\]"
	DAEMON_STR="\\[daemon\\]"
	if [[ `grep -c "$SHARP_DAEMON_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
        sharp_daemon_line_num=`cat -n $CUSTOM_CONF_FILE |grep $SHARP_DAEMON_STR| awk '{print $1}'`
        sed -i "${sharp_daemon_line_num}d" $CUSTOM_CONF_FILE
        sed -i "${sharp_daemon_line_num}i ${DAEMON_STR}" $CUSTOM_CONF_FILE
	fi

    if [[ `grep -c "$WAYLAND_DISABLE_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
        if [[ `grep -c "$DEFAULTSESSION_IS_X11" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
			insert_wayland_enable_str="WaylandEnable=false"
			line_wayland_enable_num=`cat -n $CUSTOM_CONF_FILE |grep WaylandEnable| awk '{print $1}'`
            sed -i "${line_wayland_enable_num}d" $CUSTOM_CONF_FILE
            sed -i "${line_wayland_enable_num}i ${insert_wayland_enable_str}" $CUSTOM_CONF_FILE
        else
            insert_str="WaylandEnable=false\nDefaultSession=x11"
			if [[ `grep -c "$DAEMON_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
				insert_str="WaylandEnable=false\nDefaultSession=x11"
			else
				insert_str="$DAEMON_STR\nWaylandEnable=false\nDefaultSession=x11"
			fi
			line_num=`cat -n $CUSTOM_CONF_FILE |grep WaylandEnable| awk '{print $1}'`
            sed -i "${line_num}d" $CUSTOM_CONF_FILE
            sed -i "${line_num}i ${insert_str}" $CUSTOM_CONF_FILE
        fi
    else
		if [[ `grep -c "$WAYLAND_ENABLE_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
			if [[ `grep -c "$DEFAULTSESSION_IS_X11" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
				line_wayland_enable_default_session_num=`cat -n $CUSTOM_CONF_FILE |grep $DEFAULTSESSION_IS_X11| awk '{print $1}'`
            	sed -i "${line_wayland_enable_default_session_num}d" $CUSTOM_CONF_FILE
           		sed -i "${line_wayland_enable_default_session_num}i ${DEFAULTSESSION_IS_X11}" $CUSTOM_CONF_FILE
			else
				line_wayland_enable_default_session_num=`cat -n $CUSTOM_CONF_FILE |grep WaylandEnable| awk '{print $1}'`
				line_wayland_enable_default_session_num=`expr $line_wayland_enable_default_session_num + 1`
            	sed -i "${line_wayland_enable_default_session_num}i ${DEFAULTSESSION_IS_X11}" $CUSTOM_CONF_FILE
			fi
		else
			if [[ `grep -c "$DEFAULTSESSION_IS_X11" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
				line_wayland_enable_default_session_num=`cat -n $CUSTOM_CONF_FILE |grep $DEFAULTSESSION_IS_X11| awk '{print $1}'`
            	sed -i "${line_wayland_enable_default_session_num}d" $CUSTOM_CONF_FILE
           		sed -i "${line_wayland_enable_default_session_num}i ${DEFAULTSESSION_IS_X11}" $CUSTOM_CONF_FILE
				#line_wayland_enable_default_session_num=`expr $line_wayland_enable_default_session_num - 1`
            	sed -i "${line_wayland_enable_default_session_num}i ${WAYLAND_ENABLE_STR}" $CUSTOM_CONF_FILE
			else
				if [[ `grep -c "$DAEMON_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
					insert_str="WaylandEnable=false\nDefaultSession=x11"
					line_num=`cat -n $CUSTOM_CONF_FILE |grep $DAEMON_STR| awk '{print $1}'`
					line_num=`expr $line_num + 1`
            		sed -i "${line_num}i ${insert_str}" $CUSTOM_CONF_FILE
				else
					insert_str="$DAEMON_STR\nWaylandEnable=false\nDefaultSession=x11"
					sed -i "2i ${insert_str}" $CUSTOM_CONF_FILE
				fi
			fi
		fi
    fi
fi

if [[ `grep -c "$DAEMON_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
	echo "$DAEMON_STR"
else
	if [[ `grep -c "$WAYLAND_ENABLE_STR" "$CUSTOM_CONF_FILE"` -ne '0' ]];then
		line_num=`cat -n $CUSTOM_CONF_FILE |grep $WAYLAND_ENABLE_STR| awk '{print $1}'`
		#line_num=`expr $line_num - 1`
        sed -i "${line_num}i ${DAEMON_STR}" $CUSTOM_CONF_FILE
	fi
fi

XDOTOOL_SYS_BIN_FILE_PATH="/bin/xdotool"
XDOTOOL_RES_BIN_FILE_PATH="./huion/huiontablet/xdotool/xdotool"
if [ ! -f "$XDOTOOL_SYS_BIN_FILE_PATH" ];then
	cp -a $XDOTOOL_RES_BIN_FILE_PATH $XDOTOOL_SYS_BIN_FILE_PATH
fi

LIBXDO_SYS_LIB_FILE_PATH_UBUNTU="/lib/x86_64-linux-gnu/libxdo.so.3"
LIBXDO_SYS_LIB_FILE_PATH_CENTOS="/usr/lib64/libxdo.so.3"
LIBXDO_SYS_LIB_FILE_PATH_MANJARO="/usr/lib/libxdo.so.3"
LIBXDO_SYS_LIB_FILE_PATH_COMMON="/usr/lib/libxdo.so.3"
LIBXDO_RES_LIB_FILE_PATH="./huion/huiontablet/xdotool/libxdo.so.3"

if [ ! -f "$LIBXDO_SYS_LIB_FILE_PATH_COMMON" ];then
	cp -a $LIBXDO_RES_LIB_FILE_PATH $LIBXDO_SYS_LIB_FILE_PATH_COMMON
fi

if [[ $check_os_release_result =~ $UBUNTU_STR ]]
then
	if [ ! -f "$LIBXDO_SYS_LIB_FILE_PATH_UBUNTU" ];then
		cp -a $LIBXDO_RES_LIB_FILE_PATH $LIBXDO_SYS_LIB_FILE_PATH_UBUNTU
	fi
fi

if [[ $check_os_release_result =~ $CENTOS_STR ]]
then
	if [ ! -f "$LIBXDO_SYS_LIB_FILE_PATH_CENTOS" ];then
		cp -a $LIBXDO_RES_LIB_FILE_PATH $LIBXDO_SYS_LIB_FILE_PATH_CENTOS
	fi
fi

if [ -f "/etc/bluetooth/input.conf" ]; then
    sed -i 's/#UserspaceHID=true/UserspaceHID=true/' /etc/bluetooth/input.conf
fi

echo "安装完成!!"
echo "Installation Succeeded !"

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

echo "请确认是否现在立即重新启动系统 !"
echo "The installation script will reboot your system so that the driver will work well !"

if [[ "no" == $(ask_yes_or_no "Are you sure reboot your system right now?") ]]
then
    echo "警告：驱动安装成功后，第一次使用驱动前, 请您重新启动系统，否则驱动无法正常工作!"
    echo "Warning: You should reboot your system after installed this driver, or the driver will not be useful!"
else
    echo "Rebooting ..."
    reboot
fi

exit 0
