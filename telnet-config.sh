enable
configure terminal
!
interface vlan 1
 ip address 192.168.1.10 255.255.255.0
 no shutdown
 exit
!
line vty 0 15
 transport input telnet
 password <sua_senha_telnet>
 login
 exit
!
enable secret <senha_privilegiada>
!
end
copy running-config startup-config
