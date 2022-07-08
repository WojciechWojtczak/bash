#!/bin/bash
apt  install ‐y bind9
echo 'options { ' > /etc/bind/named.conf.options
echo 'directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo 'listen‐on port 53 {localhost; 192.168.10.1/24; };' >> /etc/bind/named.conf.options
echo 'allow‐query { localhost; 192.168.10.0/24; };' >> /etc/bind/named.conf.options
echo 'forwarders { 127.0.0.1;9.9.9.9; };' >> /etc/bind/named.conf.options
echo 'recursion yes;' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options
echo 'Podaj nazwę strefy'
read zona
echo 'zone "'$zona'l" IN { ' >  /etc/bind/named.conf.local
echo 'type master; ' >>  /etc/bind/named.conf.local
echo 'file "'$zona'.zone"; ' >>  /etc/bind/named.conf.local
echo '};' >>  /etc/bind/named.conf.local

echo '$TTL 86400 ' > /var/cache/bind/sanlab.local.zone
echo '@ IN SOA sanlab.local root.sanlab.local ( ' >> /var/cache/bind/sanlab.local.zone
echo '2020041801 ' >> /var/cache/bind/sanlab.local.zone
echo '3600 ' >> /var/cache/bind/sanlab.local.zone
echo '900 ' >> /var/cache/bind/sanlab.local.zone
echo '604800 ' >> /var/cache/bind/sanlab.local.zone
echo '86400 ' >> /var/cache/bind/sanlab.local.zone
echo ') ' >> /var/cache/bind/sanlab.local.zone
echo '@ IN NS rtr ' >> /var/cache/bind/sanlab.local.zone
echo 'rtr IN A 192.168.10.1 ' >> /var/cache/bind/sanlab.local.zone
echo 'vm01 IN A 192.168.10.101 ' >> /var/cache/bind/sanlab.local.zone
echo 'vm02 IN A 192.168.10.102 ' >> /var/cache/bind/sanlab.local.zone
echo 'www IN CNAME vm01 ' >> /var/cache/bind/sanlab.local.zone
named‐checkconf
named‐checkzone $zona /var/cache/bind/$zona.zone
ssh 192.168.10.101 "echo 'nameserver 192.168.10.1' >> /etc/resolv.conf"
ssh 192.168.10.102 "echo 'nameserver 192.168.10.1' >> /etc/resolv.conf"
ssh 192.168.10.103 "echo 'nameserver 192.168.10.1' >> /etc/resolv.conf"