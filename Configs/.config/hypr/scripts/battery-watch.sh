
#!/bin/bash

# Set battery threshold
THRESHOLD=80
CHECK_INTERVAL=60   # seconds

while true; do
    # Read battery percentage
    PERC=$(cat /sys/class/power_supply/BAT*/capacity)

    # Read charging status
    STATUS=$(cat /sys/class/power_supply/BAT*/status)

    # Trigger only if NOT charging and below threshold
    if [ "$STATUS" != "Charging" ] && [ $PERC -le $THRESHOLD ]; then
        notify-send -u critical -i "battery-caution" "LOW BATTERY" "Battery at $PERC% — plug in now!"
    fi

    sleep $CHECK_INTERVAL
done
