import subprocess
import re
import os

def get_current_volume():
    return subprocess.check_output(['pamixer', '--get-volume']).decode('utf-8').strip()

os.system("pactl set-sink-volume @DEFAULT_SINK@ -5%")
current_volume = get_current_volume()
if current_volume is not None:
    notification_message = f"Volume decreased to {current_volume}%"
    subprocess.run(["notify-send", "Volume Decreased", notification_message])
