ip route del default
ip route add default via 172.16.100.0 dev eth0
iptables --table nat --append POSTROUTING --out-interface eth1 -j MASQUERADE
