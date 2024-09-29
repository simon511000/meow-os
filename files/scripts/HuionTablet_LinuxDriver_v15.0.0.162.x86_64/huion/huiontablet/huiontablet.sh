#!/bin/bash
appname=`basename $0 | sed s,\.sh$,,`
dirname=`dirname $0`
tmp="${dirname#?}"
if [ "${dirname%$tmp}" != "/" ]; then
dirname=$PWD/$dirname
fi

echo $dirname

LD_LIBRARY_PATH=$dirname/libs
export LD_LIBRARY_PATH

echo $LD_LIBRARY_PATH


QT_QPA_PLATFORM_PLUGIN_PATH=$dirname/plugins
export QT_QPA_PLATFORM_PLUGIN_PATH
echo $QT_QPA_PLATFORM_PLUGIN_PATH

QML2_IMPORT_PATH=$dirname/qml
export QML2_IMPORT_PATH
echo $QML2_IMPORT_PATH

echo "$@"

echo $dirname/$appname

pidCore=`ps -e|grep huionCore`
if [ -n "$pidCore" ]
then
	echo "huionCore is running"
	echo "kill huionCore before restart"
	killall huionCore >/dev/null 2>&1
else
	echo "huionCore is not running"
fi

#$dirname/huionCore -d &

pidtablet=`ps -e|grep huiontablet`
if [ -n "$pidtablet" ]
then
	echo "huiontablet is running"
	echo "kill huiontablet before restart"
	killall huiontablet >/dev/null 2>&1
else
	echo "huiontablet is not running"
fi

sleep 3

$dirname/huionCore -d &
$dirname/$appname "$@" -d
