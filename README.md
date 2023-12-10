# NAT ICMP TTL Forgery Attack
By Kusiak， Qingchen Yu <br>

## Description of the attack
NAT (network address translation) is a widely used method to mask and translate internal private
IP addresses into one (or multiple) public IP addresses. As NAT is most commonly implemented
on edge routers, NAT is one of the sole determinants and railroads on which both outbound and
inbound traffic traverses when exiting or entering a network. NAT slipstreaming takes advantage
of stateful connections made during NAT, namely the internet control message protocol (ICMP),
to establish a user-datagram protocol (UDP) tunnel from an external (public) attacker to a private
(internal) victim. This is done by extracting key fields from an ICMP time-to-live exceeded reply
and forwarding it back through NAT with key parameters set to open a full UDP tunnel.


## Target Audience

### Instructors
Suppose you are an instructor teaching cybersecurity concerts. In that case, you can use this example to provide hands-on experience with ICMP attack, demonstrating how to take data structured from some format and
rebuild it into an object. <br>

### Students
If you are a student in cybersecurity class, you can get further practical experience with how ICMP is used to prevent attacks. <br>
## Design and Architecture
This demonstration uses Three Docker containers, one each for attacker, victim, and router. The attacker container's role is to initiate the attack or exploit against the target network or system.
The router container has two network interfaces (eth0 and eth1), which means it's bridging two different network segments, representing an internal (LAN) and external (WAN) network.

## Installation and Usage
The recommended approach to running this set of containers is on CHEESEHub, a web platform for cybersecurity demonstrations. CHEESEHub provides the necessary resources for orchestrating and running containers on demand. In order to set up this application to be run on CHEESEHub, an application specification needs to be created that configures the Docker image to be used, memory and CPU requirements, and, the ports to be exposed for each of the three containers. 

CHEESEHub uses Kubernetes to orchestrate its application containers. You can also run this application on your own Kubernetes installation. For instructions on setting up a minimal Kubernetes cluster on your local machine, refer to Minikube.

Before being able to run on either CHEESEHub or Kubernetes, Docker images need to be built for the three application containers. <br>

### Installation
To Set Up Networks
```
docker network create --subnet=172.16.100.0/24 wan-net
docker network create --subnet=192.168.1.0/24 lan-net
```
To Build The Container
```
docker build -t attacker-image .
docker build -t victim-image .
docker build -t router-image .
```
After images are built, containers have to run in a certain condition
```
docker run -it --name attacker --privileged --network wan-net --ip 172.16.100.200 -v $docker $(pwd)/exploitCode/ attacker
docker run -it --name victim --privileged --network lan-net --ip 192.168.1.50 -v $(pwd)/exploitCode/ victim
```
First connect the router container to the wan net, then connect to the LAN net. 
```
docker run -itd --name router --privileged --network wan-net --ip 172.16.100.10 -v /lib/modules:/lib/modules:ro -v $(pwd)/vyos/config:/opt/vyatta/etc/config your_custom_vyos_image
docker network connect --ip 192.168.1.10 lan-net router
```
To access the containers 
```
docker exec -it router /bin/bash
docker exec -it victim /bin/bash
docker exec -it attacker /bin/bash
```
### Usage
CHEESEHub has the instructions provided by the SEED Project. The user will have to compile the programs available and figure out how to carry out the steps in the instructions. 
