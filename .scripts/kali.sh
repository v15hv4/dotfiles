#!/usr/bin/env bash

container="kali"

init_desktop () {
    if [[ $1 = "window" ]]; then
        nohup Xephyr -ac -br -noreset -screen 1920x1080 -resizeable :1 &> /dev/null & 
        sleep 1
    else
        if [ ! -f /tmp/.X1-lock ]; then
            nohup xinit  -- :1 vt9 &> /dev/null &
            sleep 4
        fi
    fi
}
stop_desktop () {
        nohup kill $(pgrep xinit) &> /dev/null
        nohup kill $(pgrep Xephyr) &> /dev/null
}
case "$1" in
    "start")
        echo "Starting..."
        init_desktop $2
        nohup docker start $container &> /dev/null
        docker exec -it -d --privileged kali x-session-manager
        ;;
    "run")
        echo "Running $2..."
        xhost + &> /dev/null
        docker run -ti --rm --privileged --device /dev/snd -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/v15hv4/share/docker:/share -p 8080:8080 --net=host kali $2
	;;
    "shell")
        nohup docker start $container &> /dev/null
        docker exec -it --privileged kali bash
	;;
    "stop")
        echo "Stopping..."
        nohup docker stop $container &> /dev/null
        stop_desktop
        ;;
    "restart")
        echo "Restarting..."
        nohup docker restart $container &> /dev/null
        docker exec -it -d --privileged kali x-session-manager
        ;;
    "pause")
        echo "Pausing..."
        nohup docker pause $container &> /dev/null
        stop_desktop
        ;;
    "resume" | "unpause")
        echo "Resuming..."
        init_desktop $2
        nohup docker unpause $container &> /dev/null
        ;;
    *)       
        ;;
esac
