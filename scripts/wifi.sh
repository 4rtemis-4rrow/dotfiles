#!/bin/sh

notify-send -t 3000 "Getting list of available networks ... "

#get wifi connections
wifi_list=$(nmcli --fields "SECURITY,SSID,IN-USE" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/ //g" | sed "/^--/d" | sed 's/*/ /g')

#get wireguard configurations
wg_list=$(nmcli --fields "TYPE,NAME,ACTIVE" connection | grep wireguard | sed 's/  */ /g' | sed 's/wireguard/󰖂 /g' | sed 's/yes/  /g' | sed 's/no//')

#get wifi power status
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
        toggle="󱚼  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
        toggle="󱚽  Enable Wi-Fi"
fi

#wofi parameters
#dynamic_width
dynamic_width=$(($(echo "$toggle\n$wifi_list\n$wg_list" | head -n 1 | awk '{print length($0); }')*5))

# Use wofi as network selector
chosen_network=$(echo -e "WiFi:\n$toggle\n$wifi_list\nWireguard:\n$wg_list" | uniq -u | wofi -i -d -p "Wi-Fi SSID: ")

# Get name of connection
chosen_id=$(echo "${chosen_network:3}" | sed 's/ //' | xargs)

#get saved connections for comparison
saved_connections=$(nmcli -g NAME connection)

#name of the already saved wifi configuration
match_id=$(echo "$saved_connections" | grep -w "$chosen_id")

if [ "$chosen_network" = "" ]; then
    exit

elif [ "$chosen_network" = "󱚽  Enable Wi-Fi" ]; then
    nmcli radio wifi on
    notify-send -t 5000 "WiFi status" "powered on"

elif [ "$chosen_network" = "󱚼  Disable Wi-Fi" ]; then
    nmcli radio wifi off
    notify-send -t 5000  "WiFi status" "is off now"

elif [ "$(echo $chosen_network | grep -o  )" = "" ]; then
    nmcli connection down "$chosen_id" | grep "successfully" && notify-send -t 5000 "$chosen_id" "Has been disconnected"
    nmcli connection down "$match_id" | grep "successfully" && notify-send -t 5000 "$chosen_id" "Has been disconnected"

elif [ "$(echo $chosen_network | grep -o 󰖂  )" = "󰖂" ]; then
    chosen_id=$(echo $chosen_network | sed 's/^󰖂 //' | sed 's/ //')
    nmcli connection up $chosen_id | grep "successfully" && notify-send -t 5000 "$chosen_id" "Tunnel activated"

else
        # Message to show when connection is activated successfully
        success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."

        if [[ "$match_id" != "" ]]; then
                nmcli connection up id "$match_id" | grep "successfully" && notify-send -t 7000 "Connection Established" "$success_message"
            else
                if [[ "$chosen_network" =~ "" ]]; then
                        wifi_password=$(wofi -d -p "Password: " )
                fi
                nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send -t 7000 "Connection Established" "$success_message"
        fi
fi
