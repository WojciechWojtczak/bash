#!/bin/bash

# Install and configure HAProxy
apt install -y haproxy
cat <<EOF >> /etc/haproxy/haproxy.cfg
frontend www_front_servers
	bind *:80
	default_backend www_backend_servers
	# Enable send X-Forwarded-For header
	option forwardfor

backend www_backend_servers
	balance roundrobin
	server vm01 192.168.10.11:80 check
	server vm02 192.168.10.12:80 check
EOF
systemctl restart haproxy
