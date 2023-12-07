ip route del default
ip route add default via 172.16.100.0 dev eth1
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
