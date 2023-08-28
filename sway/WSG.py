#!/usr/bin/env python

import os
from sys import argv

CONFIG_FILE = "WSG.txt"

def SetWorkspace(number):
    os.system(f"swaymsg workspace number {number}")

def save_config(value):
    with open(CONFIG_FILE, "w") as file:
        file.write(str(value))

def load_config():
    try:
        with open(CONFIG_FILE, "r") as file:
            return int(file.read().strip())
    except FileNotFoundError:
        return 0

if len(argv) < 3:
    print("Usage: script.py <option> <num>")
    exit(1)

option = argv[1]
num = argv[2]

if option == "WS":
    wsg = load_config()
    wsn = (10 * (wsg)) + int(num)
    SetWorkspace(wsn)

    save_config(wsg)

elif option == "WSG":
    save_config(int(num))
