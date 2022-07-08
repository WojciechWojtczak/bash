#!/bin/bash
apt install HAProxy
echo 'frontend www_front_servers' >>/etc/haproxy/haproxy.cfg
echo '	bind *:80' >>/etc/haproxy/haproxy.cfg
echo '	default_backend www_backend_servers' >>/etc/haproxy/haproxy.cfg
echo '	# Enable send X-Forwarded-For header' >>/etc/haproxy/haproxy.cfg
echo '	option	forwardfor' >>/etc/haproxy/haproxy.cfg
echo ' ' >>/etc/haproxy/haproxy.cfg
echo 'backend www_backend_servers' >>/etc/haproxy/haproxy.cfg
echo '	balance roundrobin' >>/etc/haproxy/haproxy.cfg
echo '	server vm01 192.168.10.11:80 check' >>/etc/haproxy/haproxy.cfg
echo '	server vm02 192.168.10.12:80 check' >>/etc/haproxy/haproxy.cfg
systemctl restart haproxy