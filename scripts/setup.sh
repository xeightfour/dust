#!/usr/bin/sudo bash

# Kill Bluetooth on startup
if [[ $# -eq 1 ]] && [[ $1 -eq 1 ]]; then
	echo 'Turning Bluetooth off!'
	rfkill block bluetooth
fi

# CPU <:
echo power | tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference

# Slowdown GPU
echo low | tee /sys/class/drm/card*/device/power_dpm_force_performance_level
echo battery | tee /sys/class/drm/card*/device/power_dpm_state

# Fuck GPU
echo 3 | tee /sys/class/thermal/thermal_zone0/cdev*/cur_state

# Limit maximum charge level
echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
