swayidle -w \
    before-sleep '/usr/bin/swaylock -fF' \
    lock '/usr/bin/swaylock -fF' \
    timeout 300 '/usr/bin/hyprctl dispatch dpms off' \
    timeout 310 '/usr/bin/loginctl lock-session'
