#!/bin/sh
# /etc/init.d/startroute
# Quick script to start routing all ip traffic arriving on eth0 (LAN) to the
# wireless addapter (wlan0).

case "$1" in
 start)
  echo "Starting routing.."
  sudo sysctl -w net.ipv4.ip_forward=1
  sudo ifconfig eth0 192.168.1.1
  sudo ifplugd eth0 --kill
  sudo ifplugd eth0 --check-running
  sudo iptables -t nat -A POSTROUTING -o wlan0 -s 192.168.1.0/24 -j MASQUERADE
  ;;
 stop)
  sudo "Stopping routing.."
  sudo ifconfig eth0 down
  sudo ifplugd eth0 --kill
  ;;
 *)
  echo "Usage: /etc/init.d/startroute {start}"
  exit 1
  ;;
esac

exit 0
