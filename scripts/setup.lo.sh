#!/usr/bin/sudo bash

# Kill Bluetooth on startup
if [[ $# -eq 1 ]] && [[ $1 -eq 1 ]]; then
	echo 'Turning Bluetooth off!'
	rfkill block bluetooth
fi

# Reset values
echo performance | tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference &> /dev/null
echo auto | tee /sys/class/drm/card*/device/power_dpm_force_performance_level &> /dev/null
echo balanced | tee /sys/class/drm/card*/device/power_dpm_state &> /dev/null
sleep 1.0

# CPU
echo power | tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference

# GPU
echo low | tee /sys/class/drm/card*/device/power_dpm_force_performance_level
echo battery | tee /sys/class/drm/card*/device/power_dpm_state

# CPU & GPU
echo 3 | tee /sys/class/thermal/thermal_zone0/cdev*/cur_state

# Limit max charge level
echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
