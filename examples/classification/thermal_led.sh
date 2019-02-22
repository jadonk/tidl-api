#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 
	exit 1
fi
export DISPLAY=:0
export XAUTHORITY=/home/debian/.Xauthority
cpufreq-set -f 1G
echo 0 > /sys/devices/system/cpu/cpu1/online
echo oneshot > /sys/class/leds/beaglebone:green:usr4/trigger
echo 1 > /sys/class/leds/beaglebone:green:usr4/delay_off
while true; do
	echo "(`cat /sys/class/thermal/thermal_zone0/temp`-15000)/75" | bc > /sys/class/leds/beaglebone:green:usr4/delay_on
	echo 1 > /sys/class/leds/beaglebone:green:usr4/shot
	osd_cat /sys/class/thermal/thermal_zone0/temp -p bottom -d 1
done
