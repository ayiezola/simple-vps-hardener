# simple-vps-hardener
Simple hardener script for your vps

# Initial Information
setup-harden.sh - Use this script from your local terminal/host. This script will upload harden-option.sh to your fresh vps. This script will ask you to enter vps ip address, user account and port (default port before change). It will do these 3 things:
- copy ssh key to vps
- scp script harden-option.sh to vps
- ssh connect and make script harden-option.sh executable.
- Once successfully connected using ssh, you can run that script. [harden-option.sh]

harden-option.sh - This script is the actual script to make a simple harden on your vps. Run this script will required you run as sudo.
