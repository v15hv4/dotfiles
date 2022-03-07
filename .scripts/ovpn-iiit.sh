#!/usr/bin/env bash
# depends on https://github.com/jonathanio/update-systemd-resolved

VPN_USERNAME=vishva.saravanan@research.iiit.ac.in
VPN_NAMESERVER=10.4.20.204

AUTH_FILE=/root/openvpn/VPN@IIIT.auth
CONFIG_FILE=/home/v15hv4/Documents/VPN@IIIT.ovpn

# download config and set up hooks if not present
if [[ ! -f "$CONFIG_FILE" ]]; then
    wget https://vpn.iiit.ac.in/secure/linux.ovpn --user=$USER --ask-password

    echo "dhcp-option DNS $VPN_NAMESERVER" >> $CONFIG_FILE
    echo "dhcp-option DOMAIN-ROUTE ." >> $CONFIG_FILE
    echo "script-security 2" >> $CONFIG_FILE
    echo "up /etc/openvpn/scripts/update-systemd-resolved" >> $CONFIG_FILE
    echo "down /etc/openvpn/scripts/update-systemd-resolved" >> $CONFIG_FILE
    echo "down-pre" >> $CONFIG_FILE
fi

case $1 in
    up)
        sudo openvpn --config $CONFIG_FILE --auth-user-pass $AUTH_FILE --daemon
        ;;

    down)
        sudo killall -SIGINT openvpn
        ;;
esac
