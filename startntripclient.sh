#!/bin/bash

NTRIPCLIENT_ARGS=""

# arg1 is the option flag
# arg2 is the name of parameter
append_arg () {
  EXTRACTED_VALUE="$(snapctl get $2)"
  if [ -z "$EXTRACTED_VALUE" ]; then
    NTRIPCLIENT_ARGS="$NTRIPCLIENT_ARGS $1 $2"
  else
    echo "No $2 parameter set. Not adding the option."
  fi
}

# URL is the priority
URL="$(snapctl get url)"
if [ -z "$URL" ]; then
  NTRIPCLIENT_ARGS="$URL"
else
  echo "url is not set so we pick options one by one"
  append_arg "-m" "mountpoint"
  append_arg "-s" "server"
  append_arg "-p" "password"
  append_arg "-r" "port"
  append_arg "-u" "user"
  append_arg "-M" "mode"
  append_arg "-n" "nmea"
  append_arg "-b" "bitrate"
  append_arg "-I" "initudp"
  append_arg "-P" "udpport"
  append_arg "-S" "proxy-host"
  append_arg "-R" "proxy-port"
fi

append_arg "-D" "serial-device"
append_arg "-B" "baudrate"
append_arg "-T" "stopbits"
append_arg "-C" "protocol"
append_arg "-Y" "parity"
append_arg "-A" "databits"
append_arg "-l" "serial-logfile"

$SNAP/usr/local/bin/ntripclient $NTRIPCLIENT_ARGS

