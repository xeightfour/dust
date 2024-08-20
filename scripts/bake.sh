#!/usr/bin/sudo bash

cwd='/sys/class/thermal'
for i in {0..16}; do
    tzn="$cwd/thermal_zone$i"
    if [[ -d "$tzn" ]]; then
        for j in {0..32}; do
            dev="$tzn/cdev$j"
            if [[ -d "$dev" ]]; then
                cat "$dev/max_state" | tee "$dev/cur_state"
            fi
        done
    fi
done

echo power | tee /sys/devices/system/cpu/cpufreq/*/energy_performance_preference
echo low | tee /sys/class/drm/card*/device/power_dpm_force_performance_level
echo battery | tee /sys/class/drm/card*/device/power_dpm_state
