#!/bin/sh

IP="${vpn_ip}" # IP do firewall em BFA
IP2="10.17.0.10" # IP do firewall na AWS Core
PSK="${vpn_psk}"
PSK2="${vpn_psk2}"
SUBNET="${vpn_subnet}"
VPC_ID='@vpc-${m4u_team_id}'

# Enable IP packet forwarding
sed -i -r 's/(net\.ipv4\.ip_forward = )0/\11/' /etc/sysctl.conf;

# Disable redirects
for vpn in /proc/sys/net/ipv4/conf/*;
        do echo 0 > $vpn/accept_redirects;
        echo 0 > $vpn/send_redirects;
done
echo '
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.send_redirects = 0
' >> /etc/sysctl.conf;

# Reload sysctl
sysctl -p;

# Installing openswan
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sed -i 's/PEERDNS=yes/PEERDNS=no/g' /etc/sysconfig/network-scripts/ifcfg-eth0
yum -y update;
yum -y install openswan nmap telnet tcpdump;
# OpenSwan ja esta instalado na AMI - Já não mais - Alan

# Enable ipsec.d includes
sed -i -r 's/#(include\s\/etc\/ipsec.d\/\*\.conf)/\1/' /etc/ipsec.conf;

# M4U IPSec connection description
IPSEC_M4U_CONF=/etc/ipsec.d/m4u.conf;
test -e $IPSEC_M4U_CONF || echo 'config setup
        nat_traversal=yes
        nhelpers=0
        oe=off
        protostack=netkey
conn bfa
        type=tunnel
        authby=secret
        pfs=yes
        forceencaps=yes
        ike=aes128-sha1;modp1024
        phase2=esp
        phase2alg=aes128-sha1;modp1024
        keylife=3600s
        ikelifetime=86400s
        auto=start
        right=%defaultroute
        rightsubnet='$SUBNET'
        left=186.228.60.130
        leftsubnet=10.10.0.0/15
conn aws
        type=tunnel
        authby=secret
        pfs=yes
        forceencaps=yes
        ike=aes128-sha1;modp1024
        phase2=esp
        phase2alg=aes128-sha1;modp1024
        keylife=3600s
        ikelifetime=86400s
        auto=start
        right=%defaultroute
        rightsubnet='$SUBNET'
        left=10.17.0.10
        leftsubnet=0.0.0.0/0
' > $IPSEC_M4U_CONF;
chmod 600 $IPSEC_M4U_CONF;

# M4U IPSec connection secrets
IPSEC_M4U_SECRETS=/etc/ipsec.d/m4u.secrets;
test -e $IPSEC_M4U_SECRETS || echo $IP' 0.0.0.0: PSK "'$PSK'"' > $IPSEC_M4U_SECRETS;
echo $IP2' 0.0.0.0: PSK "'$PSK2'"' >> $IPSEC_M4U_SECRETS;
chmod 600 $IPSEC_M4U_SECRETS;

# Start the tunnel
service ipsec start;
chkconfig ipsec on;
service sshd start;
