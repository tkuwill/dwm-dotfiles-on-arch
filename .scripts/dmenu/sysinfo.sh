#!/bin/sh
# ram.png is from <a href="https://www.flaticon.com/free-icons/ram" title="ram icons">Ram icons created by Freepik - Flaticon</a>.
# music.png is from <a href="https://www.flaticon.com/free-icons/google-play-music" title="google play music icons">Google play music icons created by Mayor Icons - Flaticon</a>
# battery.png is from <a href="https://www.flaticon.com/free-icons/full-battery" title="full battery icons">Full battery icons created by Pixel perfect - Flaticon</a>.
# cpu.png is from <a href="https://www.flaticon.com/free-icons/thermometer" title="thermometer icons">Thermometer icons created by Smashicons - Flaticon</a>.
# wifi.png is from <a href="https://www.flaticon.com/free-icons/wifi" title="wifi icons">Wifi icons created by Gregor Cresnar - Flaticon</a>.
# You have to install lm_sensors, acpi, libnotify and a notification package (like dunst) in order to use this script.

function mem {
    free -h | grep 'Mem' | cut -c 28-32
}

function allmem {
    free -h | grep 'Mem' | cut -c 16-20
}

function battime {
    acpi | grep -Eo '[0-9][0-9]:[0-9][0-9]'
}


function cpu_temp {
    sensors | grep 'Core 1' | cut -c 15-23
}

function wifi {
    nmcli device | grep 'wlan0          wifi' | cut -c 40-55
}

function bat_temp {
    acpi --thermal | cut -c 15-19
}

function sysinfo {
    options="Cancel\nMemory\nBAT-remaining\ninternet\ncpu_temp\nBAT_temp"
    selected=$(echo -e $options | dmenu -i -p "System info")
    if [[ $selected = "Memory" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/ram.png -t 8000 "Mem is used : $(mem)  /  $(allmem)." 
    elif [[ $selected = "BAT-remaining" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/battery.png -t 8000 "BAT-time : $(battime) - remaining."  
    elif [[ $selected = "internet" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/wifi.png -t 8000 "$(wifi) connected."  
    elif [[ $selected = "cpu_temp" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/cpu.png -t 5000 "CPU temp: $(cpu_temp) ."
    elif [[ $selected = "BAT_temp" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/battery.png -t 8000 "BAT temp : $(bat_temp) °C."  
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi

}

sysinfo
