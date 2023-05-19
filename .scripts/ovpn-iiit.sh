#!/usr/bin/env bash
# depends on https://github.com/jonathanio/update-systemd-resolved
# requires the `openvpn` package to be installed

VPN_USERNAME=vishva.saravanan@research.iiit.ac.in

VPN_NAME=VPN@IIIT
VPN_DIR=$HOME/.openvpn
VPN_NAMESERVER=10.4.20.204

AUTH_FILE=$VPN_DIR/$VPN_NAME.auth
CONFIG_FILE=$VPN_DIR/$VPN_NAME.ovpn


# check dependencies
if [[ ! -f /usr/bin/openvpn ]]; then
    echo "openvpn is not installed!"
    echo "Check: https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos"
    exit 1
fi
if [[ ! -f /usr/bin/update-systemd-resolved ]]; then
    echo "update-systemd-resolved is not installed! Installing..."
    PREVWD=$(pwd)
    cd /tmp
    git clone https://github.com/jonathanio/update-systemd-resolved.git
    cd update-systemd-resolved
    sudo make

    # enable systemd-resolved
    sudo systemctl enable --now systemd-resolved.service
    cd $PREVWD
fi


# create vpn directory if it doesn't exist
[ ! -d "$VPN_DIR" ] && mkdir $VPN_DIR


# download config and set up hooks if not present
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -n "(LDAP) password for $VPN_USERNAME: "
    read -s VPN_PASSWORD
    echo

    wget -q https://vpn.iiit.ac.in/secure/linux.ovpn -O $CONFIG_FILE --user=$VPN_USERNAME --password=$VPN_PASSWORD

    # check if config downloaded successfully
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Invalid credentials!"
	exit 1
    fi

    echo "dhcp-option DNS $VPN_NAMESERVER" >> $CONFIG_FILE
    echo "dhcp-option DOMAIN-ROUTE ." >> $CONFIG_FILE
    echo "script-security 2" >> $CONFIG_FILE
    echo "up /usr/bin/update-systemd-resolved" >> $CONFIG_FILE
    echo "down /usr/bin/update-systemd-resolved" >> $CONFIG_FILE
    echo "down-pre" >> $CONFIG_FILE
fi


# make auth file
if [[ ! -f "$AUTH_FILE" ]]; then
    if [[ ! -v VPN_PASSWORD ]]; then
	echo -n "(LDAP) password for $VPN_USERNAME: "
        read -s VPN_PASSWORD
        echo
    fi

    echo $VPN_USERNAME >> $AUTH_FILE
    echo $VPN_PASSWORD >> $AUTH_FILE
fi


case $1 in
    debug)
        sudo openvpn --config $CONFIG_FILE --auth-user-pass $AUTH_FILE

        ;;
    up)
        sudo openvpn --config $CONFIG_FILE --auth-user-pass $AUTH_FILE --daemon

	# wait for interface to come up
	while [ ! -d /sys/class/net/tun0 ]; do sleep 1; done

	# show connection summary
	tput setaf 2
	echo -e "\nConnected!"
	ip a l tun0 | awk '/inet/ {print $2}'
	tput sgr0
        ;;

    down)
        sudo killall -SIGINT openvpn

	tput setaf 1
	echo -e "\nDisconnected!"
	tput sgr0
        ;;
    *)
	echo "usage: ovpn-iiit [up|down|debug]"
	;;
esac
