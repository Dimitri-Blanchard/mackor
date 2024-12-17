# What is a MAC adress ?
![What is a MAC adress](https://github.com/KOR-ius/mackor/blob/d3127302f43c41164f3ea2f78be849820deabe74/What-is-MAC-Address.jpeg)

# MAC Address Changer Script

This Bash script allows you to change your MAC address either automatically at specified intervals or manually for a specific network interface. 

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [License](#license)

## Features

- Change the MAC address of a specified network interface.
- Automatically change the MAC address at specified intervals.
- Simple and user-friendly command-line interface.

## Installation

To use this script, you need to have `macchanger` installed on your system. You can install it using your package manager:

```bash
# For Debian/Ubuntu
sudo apt-get install macchanger

# For Fedora
sudo dnf install macchanger

# For Arch Linux
sudo pacman -S macchanger
```

## Usage

```bash
./mackor.sh [OPTION]
```

### Options

- `-a, --auto <minutes>`: Automatically change the MAC address every `<minutes>`.
- `-i, --interface <name>`: Specify the interface of the MAC to change.
- `-h, --help`: Show help and exit.

## Examples

1. Change MAC address every 30 minutes:

   ```bash
   ./mackor.sh -a 30
   ```

2. Change MAC address for a specific interface (e.g., `wlo1`):

   ```bash
   ./mackor.sh -i wlo1
   ```

## License

This script is provided as-is. Use it at your own risk. Make sure to comply with local laws and regulations regarding network privacy and security.

---

**Note**: Always run the script with appropriate permissions. You might need `sudo` to change the MAC address on certain systems.
