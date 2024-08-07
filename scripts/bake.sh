#!/usr/bin/sudo bash

echo 'power' | tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference

echo 'low' | tee /sys/class/drm/card0/device/power_dpm_force_performance_level
echo 'battery' | tee /sys/class/drm/card0/device/power_dpm_state

echo '3' | tee /sys/class/thermal/thermal_zone0/cdev*/cur_state
