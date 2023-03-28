#!/bin/bash

# Clean the interfaces file
echo -n > /etc/network/interfaces

echo '# This file describes the network interfaces available on your system' >> /etc/network/interfaces
echo '# and how to activate them. For more information, see interfaces(5).' >> /etc/network/interfaces
echo '' >> /etc/network/interfaces
echo 'source /etc/network/interfaces.d/*' >> /etc/network/interfaces
echo '' >> /etc/network/interfaces
echo '# The loopback network interface ' >> /etc/network/interfaces
echo '' >> /etc/network/interfaces
echo 'auto lo' >> /etc/network/interfaces
echo 'iface lo inet loopback' >> /etc/network/interfaces
echo '' >> /etc/network/interfaces

# Prompt for the number of eth interfaces and configure them
echo 'How many eth interfaces does the machine have?'
read ile

if [ $ile == 1 ]; then
  echo 'Enter the IP address for eth0:'
  read ip
  echo 'Enter the netmask for eth0:'
  read mask
  echo 'Enter the gateway for eth0:'
  read gate

  echo '' >> /etc/network/interfaces
  echo '# The primary network interface ' >> /etc/network/interfaces
  echo 'allow-hotplug eth0' >> /etc/network/interfaces
  echo 'iface eth0 inet static' >> /etc/network/interfaces
  echo "    address $ip" >> /etc/network/interfaces
  echo "    netmask $mask" >> /etc/network/interfaces
  echo "    gateway $gate" >> /etc/network/interfaces

elif [ $ile == 2 ]; then
  echo 'Enter the IP address for eth0:'
  read ip1
  echo 'Enter the netmask for eth0:'
  read mask1
  echo 'Enter the IP address for eth1:'
  read ip2
  echo 'Enter the netmask for eth1:'
  read mask2
  echo 'Enter the gateway for eth1:'
  read gate

  echo '' >> /etc/network/interfaces
  echo '# The primary network interface ' >> /etc/network/interfaces
  echo 'allow-hotplug eth0' >> /etc/network/interfaces
  echo 'iface eth0 inet static' >> /etc/network/interfaces
  echo "    address $ip1" >> /etc/network/interfaces
  echo "    netmask $mask1" >> /etc/network/interfaces
  echo '' >> /etc/network/interfaces
  echo 'allow-hotplug eth1' >> /etc/network/interfaces
  echo 'iface eth1 inet static' >> /etc/network/interfaces
  echo "    address $ip2" >> /etc/network/interfaces
  echo "    netmask $mask2" >> /etc/network/interfaces
  echo "    gateway $gate" >> /etc/network/interfaces

else
  echo 'Sorry, I only know how to configure 1 or 2 eth interfaces'
fi

# Add DNS resolver and hostname
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
echo 'Enter the hostname:'
read host
echo $host > /etc/hostname

# Restart the networking service and show the IP addresses
systemctl restart networking.service
ip addr
