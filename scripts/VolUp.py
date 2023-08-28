import subprocess
import re
import os

def get_current_volume():
    try:
        pactl_output = subprocess.check_output(["pactl", "list", "sinks"]).decode("utf-8")
        volume_match = re.search(r"Volume:.*?(\d+)%", pactl_output, re.DOTALL)
        if volume_match:
            return str(volume_match.group(1))
    except subprocess.CalledProcessError:
        pass
    return None

os.system("pactl set-sink-volume @DEFAULT_SINK@ +5%")
current_volume = get_current_volume()
if current_volume is not None:
    notification_message = f"Volume increased to {current_volume}%"
    subprocess.run(["notify-send", "Volume Increased", notification_message])
