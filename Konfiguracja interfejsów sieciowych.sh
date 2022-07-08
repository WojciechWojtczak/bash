#!/bin/bash
echo '# This file describes the network interfaces available on your system' > /etc/network/interfaces
echo '# and how to activate them. For more information, see interfaces(5).' >> /etc/network/interfaces
echo ' ' >> /etc/network/interfaces
echo 'source /etc/network/interfaces.d/*' >> /etc/network/interfaces
echo '# The loopback network interface ' >> /etc/network/interfaces
echo ' ' >> /etc/network/interfaces
echo 'auto lo ' >> /etc/network/interfaces
echo 'Podaj ile interfejsów eth ma maszyna:'
read ile
if [ $ile==1 ]; then
	echo 'Podaj adress dla eth0'
	read ip
	echo 'Podaj maske eth0'
	read mask
	echo 'Podaj gateway eth0'
	read $gate
	echo 'auto eth0 ' >> /etc/network/interfaces
	echo ' ' >> /etc/network/interfaces
	echo 'iface lo inet loopback ' >> /etc/network/interfaces
	echo ' ' >> /etc/network/interfaces
	echo '# The primary network interface ' >> /etc/network/interfaces
	echo 'allow‐hotplug eth0 ' >> /etc/network/interfaces
	echo 'iface eth0 inet static ' >> /etc/network/interfaces
	echo '        address '$ip1 >> /etc/network/interfaces
	echo '        netmask '$mask1 >> /etc/network/interfaces
	echo '        gateway '$gate >> /etc/network/interfaces
elif [ $ile==2 ]; then
	echo 'Podaj adress dla eth0'
	read ip1
	echo 'Podaj maske eth0'
	read mask1
	echo 'Podaj adress dla eth1'
	read ip2
	echo 'Podaj maske eth1'
	read mask2
	echo 'Podaj gateway eth1'
	read $gate
	echo 'auto eth0 ' >> /etc/network/interfaces
	echo 'auto eth1 ' >> /etc/network/interfaces
	echo ' ' >> /etc/network/interfaces
	echo 'iface lo inet loopback ' >> /etc/network/interfaces
	echo ' ' >> /etc/network/interfaces
	echo '# The primary network interface ' >> /etc/network/interfaces
	echo 'allow‐hotplug eth0 ' >> /etc/network/interfaces
	echo 'iface eth0 inet static ' >> /etc/network/interfaces
	echo '        address '$ip1 >> /etc/network/interfaces
	echo '        netmask '$mask1 >> /etc/network/interfaces
	echo ' ' >> /etc/network/interfaces
	echo 'iface eth1 inet static ' >> /etc/network/interfaces
	echo '        address '$ip2 >> /etc/network/interfaces
	echo '        netmask '$mask2 >> /etc/network/interfaces
	echo '        gateway '$gate >> /etc/network/interfaces
else
	echo 'na tyle to nie umiem :P tak wiem mogę zrobić pętlę ale mi się nie chcę :P'
fi
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo 'Podaj nazwe Hosta'
read host
echo $host > /etc/hostname

service networking restart
ip addr