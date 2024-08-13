#!/bin/bash

# Some devices do not function after hibernate, this script can solve that problem.
# It disables kernel module(s) pre-hibernate and enables kernel module(s) post-hibernate.
# You can add "hybrid-sleep" in the script too, if you use that.
#
#
# Module name(s): see output of 'lspci -knn'. Change below value to match your system.
# Add more modules if needed (and in the script below too).
WiFiModule=mt7921e

case "$1 $2" in
  "pre hibernate" | "pre suspend-then-hibernate")
    modprobe -r $WiFiModule
    ;;
  "post hibernate" | "post suspend-then-hibernate")
    modprobe $WiFiModule
    ;;
  *)
    :
    ;;
esac