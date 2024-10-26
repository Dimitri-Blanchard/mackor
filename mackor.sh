#!/bin/bash

# Colors
BLUE="\033[1;34m"    # Blue
WHITE="\033[1;37m"   # White
GREEN="\033[1;32m"    # Green
RESET="\033[0m"      # Reset colors

clear

# Print banner
cat << 'EOF'
.-. .-')               _  .-')   
\  ( OO )             ( \( -O )  
,--. ,--.  .-'),-----. ,------.  
|  .'   / ( OO'  .-.  '|   /`. ' 
|      /, /   |  | |  ||  /  | | 
|     ' _)\_) |  |\|  ||  |_.' | 
|  .   \    \ |  | |  ||  .  '.' 
|  |\   \    `'  '-'  '|  |\  \  
`--' '--'      `-----' `--' '--' 

EOF

echo -e "${WHITE}Become a ${GREEN}Ghost${WHITE} while a ${GREEN}Genius${WHITE} is working${RESET}"
echo ""

# Help msg
show_help() {
    echo "Usage: $0 [OPTION]"
    echo
    echo "Options :"
    echo "  -a, --auto <minutes>    Automatically change MAC adress every <minutes>"
    echo "  -i, --interface <name>   Specify the interface of the MAC to change"
    echo "  -h, --help              Show help and exit"
    echo
    echo "Exemples :"
    echo "  $0 -a 30               Change MAC adress every 30 minutes"
    echo "  $0 -i wlo1             Change MAC adress of wol1 interface"
}

# Function to change MAC adress
change_mac() {
    local INTERFACE="$1"
    local NEW_MAC

    # Change MAC
    sudo ip link set "$INTERFACE" down
    NEW_MAC=$(sudo macchanger -r "$INTERFACE" | grep 'New MAC' | awk '{print $3}')
    sudo ip link set "$INTERFACE" up

    echo "[+] Changing MAC to: $NEW_MAC at $(date +'%H:%M')"
}

# Verify options
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

INTERFACE=""
AUTO=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -a|--auto)
            AUTO="$2"
            shift 2
            ;;
        -i|--interface)
            INTERFACE="$2"
            shift 2
            ;;
        *)
            echo "Option inconnue : $1"
            show_help
            exit 1
            ;;
    esac
done

# Check if AUTO is specified
if [[ -n "$AUTO" ]]; then
    if ! [[ "$AUTO" =~ ^[0-9]+$ ]]; then
        echo "Error: Enter a correct number in minutes"
        exit 1
    fi

    INTERVAL=$((AUTO * 60))
    
    # Loop for AUTO
    while true; do
        if [[ -n "$INTERFACE" ]]; then
            change_mac "$INTERFACE"
        else
            INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo | head -n 1)
            change_mac "$INTERFACE"
        fi
        sleep "$INTERVAL"
    done
elif [[ -n "$INTERFACE" ]]; then
    change_mac "$INTERFACE"
else
    echo "Error: No option specified. Use -h or --help to show more informations"
    exit 1
fi
