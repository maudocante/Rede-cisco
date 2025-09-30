!
! Configuração de VLANs e Roteamento Inter-VLAN no switch L3
!
! ==============================
! HABILITAR FEATURES
! ==============================
configure terminal
feature telnet
feature ssh
feature interface-vlan
feature dhcp
!
==============================
! CRIAÇÃO DAS VLANs
! ==============================
vlan 10
 name SERVIDORES
vlan 20
 name SERVICOS
vlan 30
 name TIC
vlan 40
 name CLUSTER
!
! ==============================
! ATRIBUIR PORTAS ÀS VLANs
! ==============================
interface range fa0/2 - 5
 switchport mode access
 switchport access vlan 10
 no shutdown
!
interface range fa0/6 - 10
 switchport mode access
 switchport access vlan 20
 no shutdown
! 
interface range fa0/11 - 15
 switchport mode access
 switchport access vlan 30
 no shutdown
! 
interface range fa0/16 - 20
 switchport mode access
 switchport access vlan 40
 no shutdown
!XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
!
!Outro Mdelo de Switch
interface ethernet 2/2-6
 switchport
 switchport mode access
 switchport access vlan 10
 no shutdown
!
interface ethernet 2/7-11
 switchport
 switchport mode access
 switchport access vlan 20
 no shutdown
!
interface ethernet 2/12-15
 switchport
 switchport mode access
 switchport access vlan 30
 no shutdown
!
interface ethernet 2/16-20
 switchport
 switchport mode access
 switchport access vlan 40
 no shutdown
!
!
!
! ==============================
! CONFIGURAR SVI (INTERFACES VLAN)
! ==============================
interface ethernet 2/1
switchport
switchport mode access
no shutdown
!
interface vlan 1
 ip address 192.168.122.10 255.255.255.0
 no shutdown
!
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
interface vlan 40
 ip address 192.168.100.1 255.255.255.0
 no shutdown
!

! ==============================
! HABILITAR IP ROUTING
! ==============================
ip routing
!

! ==============================
! CONFIGURAÇÃO DHCP
! ==============================
! Reservar alguns endereços (não serão distribuídos)
ip dhcp excluded-address 192.168.100.1
ip dhcp excluded-address 10.11.11.1
ip dhcp excluded-address 10.11.12.1
ip dhcp excluded-address 10.11.10.1
!
! Pool VLAN10
ip dhcp pool VLAN10
 network 10.11.10.0 255.255.255.0
 default-router 10.11.10.1
 dns-server 8.8.8.8

! Pool VLAN20
ip dhcp pool VLAN20
 network 10.11.11.0 255.255.255.0
 default-router 10.11.11.1
 dns-server 8.8.8.8

 !
! Pool VLAN30
ip dhcp pool VLAN30
 network 10.11.12.0 255.255.255.0
 default-router 10.11.12.1
 dns-server 8.8.8.8
 !
! Pool VLAN40
ip dhcp pool VLAN40
 network 192.168.100.0 255.255.255.0
 default-router 192.168.100.1
 dns-server 8.8.8.8
!


! ==============================
! FIM DA CONFIGURAÇÃO
! ==============================
end
write memory

