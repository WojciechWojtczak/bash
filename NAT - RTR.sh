#!/bin/bash

#wlaczenie forwardowania
echo 1 > /proc/sys/net/ipv4/ip_forward

#czyszczenie starych regul
iptables -F
iptables -X
iptables -t nat -X
iptables -t nat -F
iptables -t mangle -F
iptables -t mangle -X

#ustawienia domyslne polityki
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

#utrzymanie polaczen nawiazanych
iptables -A INPUT -j ACCEPT -m state --state ESTABLISHED,RELATED
iptables -A INPUT -j FORWARD -m state --state ESTABLISHED,RELATED
iptables -A INPUT -j OUTPUT -m state --state ESTABLISHED,RELATED

#udosteninanie internetu w sieci lokalnej
iptables -t nat -A POSTROUTING -s 192.168.228.0/24 -j SNAT
iptables -A FORWARD -s 192.168.228.0/24 -j ACCEPT

#DNAT
iptables -t nat -A PREROUTING -p tcp -d 192.168.76.223 --dport 1001 -j DNAT --to-destination 192.168.10.101
iptables -t nat -A PREROUTING -p tcp -d 192.168.76.223 --dport 1002 -j DNAT --to-destination 192.168.10.102
iptables -t nat -A PREROUTING -p tcp -d 192.168.76.223 --dport 1003 -j DNAT --to-destination 192.168.10.103

#Dodatkowe zabezpieczenia 
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -j DROP

#Zapisanie ustwień
iptables-save > /etc/iptables/rules.v4

#Restart usługi
systemctl restart netfilter-persistent
