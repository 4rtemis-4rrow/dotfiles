#!/usr/bin/env python3

import sys
import os
import subprocess

# === CONFIGURATION ===

EXTENSION_COMMAND_MAP = {
    # Audio / Music
    ".mp3": "ffplay",
    ".wav": "ffplay",
    ".flac": "ffplay",
    ".aac": "ffplay",
    ".ogg": "ffplay",
    ".m4a": "ffplay",
    ".wma": "ffplay",
    ".alac": "ffplay",
    ".opus": "ffplay",

    # Video
    ".mp4": "ffplay",
    ".mkv": "ffplay",
    ".avi": "ffplay",
    ".mov": "ffplay",
    ".flv": "ffplay",
    ".wmv": "ffplay",
    ".webm": "ffplay",
    ".mpeg": "ffplay",
    ".mpg": "ffplay",

    # Images
    ".jpg": "imv",
    ".jpeg": "imv",
    ".png": "imv",
    ".gif": "imv",
    ".bmp": "imv",
    ".tiff": "imv",
    ".tif": "imv",
    ".svg": "inkscape",
    ".webp": "imv",
    ".ico": "imv",
    ".heic": "imv",

    # Documents
    ".pdf": "zathura",
    ".doc": "libreoffice",
    ".docx": "libreoffice",
    ".xls": "libreoffice",
    ".xlsx": "libreoffice",
    ".ppt": "libreoffice",
    ".pptx": "libreoffice",
    ".odt": "libreoffice",
    ".ods": "libreoffice",
    ".odp": "libreoffice",
    ".rtf": "libreoffice",
    ".epub": "zathura",
    ".djvu": "evince",

    # Archives / Compressed
    ".zip": "xarchiver",
    ".tar": "xarchiver",
    ".tar.gz": "xarchiver",
    ".tgz": "xarchiver",
    ".tar.bz2": "xarchiver",
    ".tbz2": "xarchiver",
    ".tar.xz": "xarchiver",
    ".txz": "xarchiver",
    ".rar": "xarchiver",
    ".7z": "xarchiver",
    ".gz": "xarchiver",
    ".bz2": "xarchiver",
    ".xz": "xarchiver",

    # Fonts
    ".ttf": "font-manager",
    ".otf": "font-manager",
    ".woff": "font-manager",
    ".woff2": "font-manager",

    # Web files
    ".html": "zen-browser",
    ".htm": "zen-browser",

    # Email / Messaging
    ".eml": "thunderbird",
    ".msg": "thunderbird",

    # Virtual machines / Disk Images
    ".iso": "furiusisomount",
    ".vmdk": "virtualbox",
    ".vdi": "virtualbox",
    ".qcow2": "virt-manager",
    ".img": "furiusisomount",

    # Android / Mobile
    ".apk": "apktool",
    ".ipa": "ideviceinstaller",

    # Databases
    ".db": "sqlitebrowser",
    ".sqlite": "sqlitebrowser",
    ".mdb": "mdbtools",

    # 3D models / CAD
    ".stl": "meshlab",
    ".obj": "meshlab",
    ".fbx": "blender",
    ".dae": "blender",

    # Misc
    ".torrent": "transmission-gtk",
    ".ics": "thunderbird",
    ".csv": "libreoffice",

    # Binary / Executables
    ".exe": "wine",
    ".bin": "bash",  # maybe direct run in bash shell
    ".run": "bash",

    # Notebook files
    ".ipynb": "jupyter-notebook",
}

DEFAULT_TEXT_EDITOR = "nvim"  # for all text/* MIME types without override
FALLBACK_COMMAND = "xdg-open"  # fallback for unknown types

# === FUNCTIONALITY ===

def get_file_extension(filename):
    return os.path.splitext(filename)[1].lower()

def get_mime_type(filepath):
    try:
        result = subprocess.run(['xdg-mime', 'query', 'filetype', filepath],
                                capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None

def open_file(filepath):
    if not os.path.isfile(filepath):
        print(f"File not found: {filepath}")
        return

    ext = get_file_extension(filepath)
    mime = get_mime_type(filepath)

    # Check extension-based override
    if ext in EXTENSION_COMMAND_MAP:
        command = EXTENSION_COMMAND_MAP[ext]
    # If MIME is text/*, use default text editor
    elif mime and mime.startswith("text/"):
        command = DEFAULT_TEXT_EDITOR
    else:
        command = FALLBACK_COMMAND

    try:
        print(f"Opening '{filepath}' with: {command}")
        subprocess.run([command, filepath])
    except Exception as e:
        print(f"Error launching command: {e}")

# === ENTRY POINT ===

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: fileopener.py <filename>")
        sys.exit(1)

    filepath = sys.argv[1]
    open_file(filepath)
