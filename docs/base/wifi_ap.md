---
layout: default
title: Installation du point d'acces wifi
parent: Installation logiciel
grand_parent: Fabriquer une base RTK
nav_order: 3
---

Acces Point Installation
========================

## Easy installation
Run the automated version of the **Manual installation** by running the command line script in a terminal, from inside [folder?]:
>```
>bash wifi_ap.sh
>```

The access point will be configured with:
>```
>ssid : basegnss_AP 
>passphrase: basegnss!
>IP address: 192.168.4.1 (basegnss.wlan)
>```

## Manual installation
To manually install the access point on a Raspberry Pi, follow the official Raspberry Pi tutrorial - [Setting up a Routed Wireless Access Point](https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-a-routed-wireless-access-point).

The step *"Enable Routing and IP Masquerading"* is not to be followed as the purpose of the base is not to route any incoming trafic. Inside the section, a note actually informs you about skipping it :

>''If you wish to block wireless clients from accessing the Ethernet network and the internet, skip this section.''

During step *"Configure the DHCP and DNS services for the wireless network"*, you can customize the DNS alias for the Raspberry Pi that can be used in stead of its IP adress. To do so, when filling the file ```/etc/dnsmasq.conf```, change the ```gw``` at the very last line to ```basegnss``` for example :

>```
># Listening interface
>interface=wlan0
># Pool of IP addresses served via DHCP
>dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h
># Local wireless DNS domain
>domain=wlan
># Alias for this router
>address=/basegnss.wlan/192.168.4.1
>```

During step *"Configure the AP Software"*, when filling up the file ```/etc/hostapd/hostapd.conf```, you can customize the ssid and passphrase that will be used to connect to the AP. You could respectively choose ```basegnss_AP``` and ```basegnss!``` :

>```
>country_code=GB
>interface=wlan0
>ssid=basegnss_AP
>hw_mode=g
>channel=7
>macaddr_acl=0
>auth_algs=1
>ignore_broadcast_ssid=0
>wpa=2
>wpa_passphrase=basegnss!	
>wpa_key_mgmt=WPA-PSK
>wpa_pairwise=TKIP
>rsn_pairwise=CCMP
>```

Once done with the tutorial, after rebooting your Raspberry Pi and giving it time to start the AP, the ```basegnss_AP``` should be visible in your WiFi networks list on your computer or smartphone. To connect to it, use the credentials defined during step *"Configure the AP Software"*.

Once connected to it, the Raspberry Pi should be accessible at the adress ```192.168.4.1``` (alias ```basegnss.wlan```).
In your browser, typing the URL ```http://basegnss.wlan``` should now lead you to the base web GUI.