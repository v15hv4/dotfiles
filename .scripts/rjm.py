#!/usr/bin/env python3

"""
Local Dependencies:
    - python-qtconsole (`pip install qtconsole` or https://archlinux.org/packages/community/any/python-qtconsole/)
    - pyqt5-tools (if qtconsole is installed via pip)
    - jupyter-client==6.1.12 (if qtconsole is installed via pip)

Remote Dependencies:
    - jupyter

Usage:
- ssh into the remote machine
- install dependencies and start jupyter kernel using: `jupyter kernel`
- copy kernel id
- run this script giving ssh user, remote host and the target kernel id
"""

import os
import sys
import json
import subprocess

if len(sys.argv) < 2:
    print("Usage: ./rjm.py <user>@<host> <start|qtconsole|stop> <kernel-json>")
    sys.exit(0)

# get remote host as command line argument
REMOTE_HOST = sys.argv[1]

# get action
ACTION = sys.argv[2]

if ACTION == "start":
    # start new kernel on remote
    subprocess.Popen(
        f"ssh {REMOTE_HOST} jupyter kernel".split(), stdin=None, stdout=None, stderr=None
    )

else:
    # get kernel json as command line argument
    KERNEL_JSON = sys.argv[3]

    # remote path to copy kernel json from
    REMOTE_KERNEL_DIR = "~/.local/share/jupyter/runtime/"

    # local path to copy kernel jsons to
    LOCAL_KERNEL_DIR = f"{os.path.expanduser('~')}/.local/share/jupyter/runtime"

    if ACTION == "qtconsole":
        # copy kernel json to local host
        subprocess.run(
            f"scp {REMOTE_HOST}:{REMOTE_KERNEL_DIR}/{KERNEL_JSON} {LOCAL_KERNEL_DIR}".split()
        )

        # SSH tunneling
        kernel = json.load(open(f"{LOCAL_KERNEL_DIR}/{KERNEL_JSON}", "r"))
        tunnel = lambda port: f"ssh {REMOTE_HOST} -f -N -L {port}:127.0.0.1:{port}"

        for port in ["shell_port", "iopub_port", "stdin_port", "control_port", "hb_port"]:
            subprocess.run(tunnel(kernel[port]).split(), capture_output=True)

        # launch qtconsole and connect it to the target kernel
        subprocess.run(
            f"jupyter-qtconsole --existing={LOCAL_KERNEL_DIR}/{KERNEL_JSON} --ssh={REMOTE_HOST}".split()
        )

    elif ACTION == "stop":
        # remove kernel from remote
        os.system(f"ssh {REMOTE_HOST} rm {REMOTE_KERNEL_DIR}/{KERNEL_JSON}")
