!
configure terminal
!
hostname SwitchA-Core
!
ip routing
!
! ========== VLANs ==========
vlan 10
 name CLIENTES
vlan 20
 name SERVICOS
vlan 30
 name ADMIN
!
! ========== SVIs ==========
interface vlan 10
 ip address 10.11.10.1 255.255.255.0
 no shutdown
!
interface vlan 20
 ip address 10.11.11.1 255.255.255.0
 no shutdown
!
interface vlan 30
 ip address 10.11.12.1 255.255.255.0
 no shutdown
!
! ========== Porta Trunk para o Switch B ==========
interface gi1/0/24
 description Trunk_para_SwitchB
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 switchport trunk native vlan 10
 no shutdown
!
! ========== Rota para Internet ==========
ip route 0.0.0.0 0.0.0.0 192.168.100.57
!
! ========== DHCP SERVER ==========
ip dhcp excluded-address 10.11.10.1
ip dhcp excluded-address 10.11.11.1
ip dhcp excluded-address 10.11.12.1
!
ip dhcp pool VLAN10
 network 10.11.10.0 255.255.255.0
 default-router 10.11.10.1
 dns-server 8.8.8.8
!
ip dhcp pool VLAN20
 network 10.11.11.0 255.255.255.0
 default-router 10.11.11.1
 dns-server 8.8.8.8
!
ip dhcp pool VLAN30
 network 10.11.12.0 255.255.255.0
 default-router 10.11.12.1
 dns-server 8.8.8.8
!
end
write memory

