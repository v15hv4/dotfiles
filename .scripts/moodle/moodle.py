#!/usr/bin/env python3

import re
import os
import sys

from json import load
from parsel import Selector
from requests import session
from datetime import datetime
from requests.utils import requote_uri

# initiate session
s = session()

# utils {{{
# course name shortener
def parse_course(raw):
    return raw
    if len(raw) > 15:
        return re.sub(r"[a-z, ]", "", raw)
    return raw


# ANSI color codes
class bcolors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKCYAN = "\033[96m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


# print event
def print_event(date, time, course, title):
    color = bcolors.FAIL if date.lower() in ["today", "tomorrow"] else bcolors.WARNING
    print(f"\n{color}> {date}{time}{bcolors.ENDC}\n[{course}]: {title}")


# }}}

# login to moodle via CAS {{{
def login():
    host = "https://login.iiit.ac.in/cas/login"
    service = "https://courses.iiit.ac.in/login/index.php?authCAS=CAS"

    # get credentials
    try:
        with open(os.path.join(sys.path[0], "secrets.json"), "r") as f:
            secrets = load(f)
            username = secrets.get("username") or input("username: ")
            password = secrets.get("password") or input("password: ")
    except:
        username = input("username: ")
        password = input("password: ")

    page = s.get(host).text

    # get execution attribute
    execution_re = r'<input type="hidden" name="execution" value="([^<]*)"/>'
    execution = re.findall(execution_re, page, re.M)[0]

    # log user in and store cookies in session
    login = s.post(
        requote_uri(f"{host}?service={service}"),
        data={
            "username": username,
            "password": password,
            "execution": execution,
            "_eventId": "submit",
            "geolocation": "",
        },
    )

    # open moodle
    moodle = s.get(service)


# }}}

# get upcoming events {{{
def upcoming():
    url = "https://courses.iiit.ac.in/calendar/view.php?view=upcoming"

    XPATHS = {
        "events": r"//div[contains(@class, 'eventlist')]/div[contains(@class, 'event')]",
        "date": r".//div[@class='row']/div[@class='col-11']/a/text()",
        "time": r".//div[@class='row']/div[@class='col-11']/text()",
        "title": r".//h3/text()",
        "course": r".//div[@class='row mt-1']/div[@class='col-11']/a/text()",
    }

    res = s.get(url)
    events = list(
        map(
            lambda e: {
                "date": e.xpath(XPATHS["date"]).get(),
                "time": e.xpath(XPATHS["time"]).get(),
                "title": e.xpath(XPATHS["title"]).get(),
                "course": parse_course(e.xpath(XPATHS["course"]).get()),
            },
            Selector(text=res.text).xpath(XPATHS["events"]),
        )
    )

    for event in events:
        print_event(event["date"], event["time"], event["course"], event["title"])


# }}}

# main
def main(args):
    if not len(args):
        sys.exit("Usage: moodle <command>")

    # action
    login()
    if args[0] == "upcoming":
        today = datetime.today()
        upcoming()
    else:
        sys.exit(f"'{args[0]}' is not a valid command.")


if __name__ == "__main__":
    main(sys.argv[1:])
