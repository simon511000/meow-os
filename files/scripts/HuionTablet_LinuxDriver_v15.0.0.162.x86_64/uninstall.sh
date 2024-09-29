#!/bin/bash

AppName=huiontablet
AppDir=huiontablet

echo "close core"
sudo killall huionCore >/dev/null 2>&1
echo "close tablet"
sudo killall huiontablet >/dev/null 2>&1

pid=`ps -e|grep $AppName`

# Remove huion deb type driver first
DPKG_INFO_HUION_PREINST="huiontablet.preinst"
CHECK_SYS_DPKG_INFO_HUION_PREINST=`ls -l /var/lib/dpkg/info | grep huiontablet.preinst`
if [[ $CHECK_SYS_DPKG_INFO_HUION_PREINST =~ $DPKG_INFO_HUION_PREINST ]]
then
    sudo apt remove -y huiontablet >/dev/null 2>&1
fi

#uninstall app
sysAppDir=/usr/lib/$AppName
if [ -d "$sysAppDir" ]; then
	str=`rm -rf $sysAppDir`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi


#uninstall shortcut
sysDesktopDir=/usr/share/applications
sysAppIconDir=/usr/share/icons
sysAutoStartDir=/etc/xdg/autostart

appDesktopName=$AppName.desktop
appIconName=$AppName.png
if [ -f "$sysDesktopDir/$appDesktopName" ]; then
	str=`rm $sysDesktopDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f $sysAppIconDir/$appIconName ]; then
	str=`rm $sysAppIconDir/$appIconName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f $sysAutoStartDir/$appDesktopName ]; then
	str=`rm $sysAutoStartDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f /home/*/.HuionCore.pid ]; then
	str=`rm -f /home/*/.HuionCore.pid`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f /home/*/.DriverUI.pid ]; then
	str=`rm -f /home/*/.DriverUI.pid`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f /home/*/.huion.log ]; then
	str=`rm -f /home/*/.huion.log`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

echo "Uninstallation Succeeded ！"
echo "驱动卸载成功 !"

exit 0