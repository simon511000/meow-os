PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
  pre)
    # Disable all wakeup devices except for the power button
    find /sys/devices -path '*/power/wakeup' \
                    ! -path '*/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/*' |
      while read wakeup; do echo disabled > $wakeup; done
    exit 0
    ;;
  post)
    exit 0
    ;;
  *)
    exit 1
    ;;
esac
