### Install AP and Management Software
echo "### Install AP and Management Software"
# Install and set up hostapd package
echo "# Install and set up hostapd service"
sudo apt update	&&
sudo apt install hostapd &&
sudo systemctl unmask hostapd &&
sudo systemctl enable hostapd &&
# Install dnsmasq package
echo "# Install dnsmasq package"
sudo apt install dnsmasq &&
# Install netfilter and iptables (firewall) pacakges
echo "# Install netfilter and iptables (firewall) pacakges"
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent &&

### Set up the Network Router
echo "### Set up the Network Router"
# Define the Wireless Interface IP Configuration
echo "# Define the Wireless Interface IP Configuration"
echo "Writing:"
sudo echo "
interface wlan0
static ip_address=192.168.4.1/24
nohook wpa_supplicant
" | sudo tee -a /etc/dhcpcd.conf &&
echo "to /etc/dhcpcd.conf... Done."
# Skipping "Enable routing and IP Masquerading" step
echo "# Skipping 'Enable routing and IP Masquerading' step"
# Configure the DHCP and DNS services for the wireless network
echo "# Configure the DHCP and DNS services for the wireless network"
sudo mv /ect/dnsmasq.conf /etc/dnsmasq.conf.orig &&
echo "Writing:"
sudo echo "
# Listening interface
interface=wlan0
# Pool of IP addresses served via DHCP
dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h
# Local wireless DNS domain
domain=wlan     
# Alias for this router
address=/basegnss.wlan/192.168.4.1
"| sudo tee /etc/dnsmasq.conf &&
echo "to /etc/dnsmasq.conf... Done."

### Ensure Wireless Operation
echo "### Ensure Wireless Operation"
#sudo rfkill unblock wlan

### Configure the AP Software
echo "### Configure the AP Software"
echo "Writing:"
sudo echo "
country_code=GB
interface=wlan0
ssid=basegnss_AP
hw_mode=g
channel=7
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=basegnss!
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
" | sudo tee /etc/hostapd/hostapd.conf &&
echo "to /etc/hostapd/hostapd.conf"