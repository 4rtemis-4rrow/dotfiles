import subprocess
import time

def send_notification(message):
    subprocess.run(["notify-send", "Battery Monitor", message])

def monitor_battery():
    while True:
        battery_info = subprocess.check_output(["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]).decode("utf-8")
        lines = battery_info.strip().split("\n")

        percentage = None
        for line in lines:
            if "percentage" in line:
                percentage = int(line.split()[1][:-1])
                break
        
        if percentage is not None:
            if percentage <= 10:
                send_notification(f"Battery level is at {percentage}%. Please connect the charger.")
            elif percentage == 100:
                send_notification("Battery is fully charged. You can disconnect the charger.")
        
        time.sleep(300)  # Check every 5 minutes

if __name__ == "__main__":
    monitor_battery()
