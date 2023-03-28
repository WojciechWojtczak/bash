#!/bin/bash

# Install bind9 package
if ! apt install -y bind9; then
    echo "Błąd: nie udało się zainstalować bind9."
    exit 1
fi
# Configure named.conf.options
cat << EOF > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    listen-on port 53 { localhost; 192.168.10.1/24; };
    allow-query { localhost; 192.168.10.0/24; };
    forwarders { 127.0.0.1; 9.9.9.9; };
    recursion yes;
};
EOF

# Prompt for zone name
read -p "Podaj nazwę strefy: " zona

# Configure named.conf.local
cat << EOF > /etc/bind/named.conf.local
zone "$zona" IN {
    type master;
    file "$zona.zone";
};
EOF

# Configure zone file
cat << EOF > /var/cache/bind/$zona.zone
\$TTL 86400
@ IN SOA $zona. root.$zona. (
    $(date +%Y%m%d)01
    3600
    900
    604800
    86400
)
@ IN NS rtr.$zona.
rtr IN A 192.168.10.1
vm01 IN A 192.168.10.101
vm02 IN A 192.168.10.102
www IN CNAME vm01
EOF

# Check named configuration and zone file syntax
if ! named-checkconf; then
    echo "Błąd: named-checkconf zwrócił błąd."
    exit 1
fi
named-checkzone $zona /var/cache/bind/$zona.zone

# Update resolv.conf on client machines
for ip in 101 102 103; do
    ssh 192.168.10.$ip "echo 'nameserver 192.168.10.1' >> /etc/resolv.conf"
done
