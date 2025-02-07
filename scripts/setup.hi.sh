#!/usr/bin/sudo bash

# Kill Bluetooth on startup
if [[ $# -eq 1 ]] && [[ $1 -eq 1 ]]; then
	echo 'Turning Bluetooth off!'
	rfkill block bluetooth
fi

# CPU
echo balance_performance | tee /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference
echo 400000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq
echo 2500000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
echo 1 | tee /sys/devices/system/cpu/cpufreq/boost

# GPU
echo low | tee /sys/class/drm/card*/device/power_dpm_force_performance_level
echo battery | tee /sys/class/drm/card*/device/power_dpm_state

# CPU & GPU
echo 3 | tee /sys/class/thermal/thermal_zone0/cdev*/cur_state

# Limit max charge level
echo 80 | tee /sys/class/power_supply/BAT0/charge_control_end_threshold
