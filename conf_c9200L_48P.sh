!
! ==============================
! CONFIGURAÇÃO DE VLANs
! ==============================
configure terminal

vlan 10
 name SERVIDORES
vlan 20
 name SERVICOS
vlan 30
 name TIC
vlan 40
 name CLUSTER
exit
!
! ==============================
! ATRIBUIR PORTAS ÀS VLANs
! ==============================
interface range GigabitEthernet1/0/2-5
 switchport mode access
 switchport access vlan 10
 no shutdown
!
interface range GigabitEthernet1/0/6-10
 switchport mode access
 switchport access vlan 20
 no shutdown
!
interface range GigabitEthernet1/0/11-15
 switchport mode access
 switchport access vlan 30
 no shutdown
!
interface range GigabitEthernet1/0/16-20
 switchport mode access
 switchport access vlan 40
 no shutdown
!
! ==============================
! CONFIGURAR SVI (INTERFACES VLAN)
! ==============================
interface Vlan1
 ip address 192.168.122.10 255.255.255.0
 no shutdown
!
interface Vlan10
 ip address 10.11.10.1 255.255.255.0
 no shutdown
!
interface Vlan20
 ip address 10.11.11.1 255.255.255.0
 no shutdown
!
interface Vlan30
 ip address 10.11.12.1 255.255.255.0
 no shutdown
!
interface Vlan40
 ip address 192.168.100.1 255.255.255.0
 no shutdown
!
! ==============================
! HABILITAR MODP TRUNK
! ==============================
! Habilitar modo trunk na porta que liga um ao outro switch 
interface fa0/24
 switchport trunk encapsulation dot1q   ! (alguns switches não precisam deste comando)
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30,40
!
! Switch port deve ser definida no 2 switchs
! ==============================
! HABILITAR ROTEAMENTO ENTRE VLANs
! ==============================
ip routing
!
! ==============================
! ROTA PADRÃO PARA INTERNET
! ==============================
ip route 0.0.0.0 0.0.0.0 192.168.100.57
!
! ==============================
! CONFIGURAÇÃO DHCP
! ==============================
ip dhcp excluded-address 192.168.100.1
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
ip dhcp pool VLAN40
 network 192.168.100.0 255.255.255.0
 default-router 192.168.100.1
 dns-server 8.8.8.8
!
end
write memory

