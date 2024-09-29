#!/bin/bash

AppNameGaomon=gaomontablet
AppDirGaomon=gaomontablet

#echo "close core"
sudo killall huionCore >/dev/null 2>&1
#echo "close tablet"
sudo killall gaomontablet >/dev/null 2>&1

pid=`ps -e|grep $AppNameGaomon`

#uninstall app
sysAppDirGaomon=/usr/lib/$AppNameGaomon
if [ -d "$sysAppDirGaomon" ]; then
	str=`rm -rf $sysAppDirGaomon`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi


#uninstall shortcut
sysDesktopDirGaomon=/usr/share/applications
sysAppIconDirGaomon=/usr/share/icons
sysAutoStartDirGaomon=/etc/xdg/autostart

appDesktopNameGaomon=$AppNameGaomon.desktop
appIconNameGaomon=$AppNameGaomon.png
if [ -f "$sysDesktopDirGaomon/$appDesktopNameGaomon" ]; then
	str=`rm $sysDesktopDirGaomon/$appDesktopNameGaomon`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f $sysAppIconDirGaomon/$appIconNameGaomon ]; then
	str=`rm $sysAppIconDirGaomon/$appIconNameGaomon`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
fi

if [ -f $sysAutoStartDirGaomon/$appDesktopNameGaomon ]; then
	str=`rm $sysAutoStartDirGaomon/$appDesktopNameGaomon`
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

sudo apt remove -y gaomontablet >/dev/null 2>&1

exit 0
