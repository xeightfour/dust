#!/usr/bin/sudo bash

modprobe acpi_call

echo power | tee /sys/devices/system/cpu/cpufreq/poli*/energy_performance_preference
echo auto | tee /sys/class/drm/card*/device/power_dpm_force_performance_level
echo battery | tee /sys/class/drm/card*/device/power_dpm_state

echo 3 | tee /sys/class/thermal/thermal_zone0/cdev*/cur_state

echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
