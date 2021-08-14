#!/usr/bin/env bash

vpn=$(nmcli con show --active | grep -i vpn | cut -d" " -f1)
if [[ $vpn ]]; then
    echo "$vpn"
else
    echo ""
fi
