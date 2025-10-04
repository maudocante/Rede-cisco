 !
configure terminal
!
hostname SwitchB-Access
!
! ========== VLANs ==========
vlan 10
 name CLIENTES
vlan 20
 name SERVICOS
vlan 30
 name ADMIN
!
! ========== Porta Trunk para Switch A ==========
interface gi1/0/48
 description Trunk_para_SwitchA
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 switchport trunk native vlan 10
 no shutdown
!
! ========== Portas de Acesso para Clientes VLAN 10 ==========
interface range gi1/0/1-20
 description Clientes_VLAN10
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 spanning-tree bpduguard enable
 no shutdown
!
! ========== DHCP SNOOPING ==========
ip dhcp snooping
ip dhcp snooping vlan 10,20,30
!
! Porta confiável (para o trunk até o servidor DHCP)
interface gi1/0/48
 ip dhcp snooping trust
!
! Opcional: garantir persistência dos bindings
ip dhcp snooping database flash:dhcp_snoop.db
ip dhcp snooping database write-delay 60
!
end
write memory
