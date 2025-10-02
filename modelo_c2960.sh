! ==========================================
! CONFIGURAÇÃO SWITCH CATALYST 2960 (L2)
! ==========================================
enable
configure terminal

! --- Criação das VLANs ---
vlan 10
 name SERVIDORES
vlan 20
 name SERVICOS
vlan 30
 name TIC
vlan 40
 name CLUSTER
exit

! --- Portas VLAN10 ---
interface range fastEthernet0/2-5
 switchport mode access
 switchport access vlan 10
 no shutdown

! --- Portas VLAN20 ---
interface range fastEthernet0/6-10
 switchport mode access
 switchport access vlan 20
 no shutdown

! --- Portas VLAN30 ---
interface range fastEthernet0/11-15
 switchport mode access
 switchport access vlan 30
 no shutdown

! --- Portas VLAN40 ---
interface range fastEthernet0/16-20
 switchport mode access
 switchport access vlan 40
 no shutdown

! --- Porta Trunk para o Roteador ---
interface fastEthernet0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30,40
 no shutdown

end
write memory

! ==========================================
! CONFIGURAÇÃO ROUTER-ON-A-STICK
! ==========================================
enable
configure terminal

! --- Interface física conectada ao Switch ---
interface GigabitEthernet0/0
 no shutdown

! --- Subinterface VLAN10 ---
interface GigabitEthernet0/0.10
 encapsulation dot1Q 10
 ip address 10.11.10.1 255.255.255.0

! --- Subinterface VLAN20 ---
interface GigabitEthernet0/0.20
 encapsulation dot1Q 20
 ip address 10.11.11.1 255.255.255.0

! --- Subinterface VLAN30 ---
interface GigabitEthernet0/0.30
 encapsulation dot1Q 30
 ip address 10.11.12.1 255.255.255.0

! --- Subinterface VLAN40 ---
interface GigabitEthernet0/0.40
 encapsulation dot1Q 40
 ip address 192.168.100.1 255.255.255.0

! --- Rota padrão para saída de Internet ---
ip route 0.0.0.0 0.0.0.0 192.168.100.57

! ==========================================
! DHCP NO ROTEADOR (OPCIONAL)
! ==========================================
ip dhcp excluded-address 10.11.10.1
ip dhcp excluded-address 10.11.11.1
ip dhcp excluded-address 10.11.12.1
ip dhcp excluded-address 192.168.100.1

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

! Pool VLAN30
ip dhcp pool VLAN30
 network 10.11.12.0 255.255.255.0
 default-router 10.11.12.1
 dns-server 8.8.8.8

! Pool VLAN40
ip dhcp pool VLAN40
 network 192.168.100.0 255.255.255.0
 default-router 192.168.100.1
 dns-server 8.8.8.8

end
write memory

