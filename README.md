# Rede-cisco
Vamos agora completar o cenário incluindo DHCP no Switch A (Core) e fazendo com que os clientes no Switch B (Access) recebam IP automaticamente a partir do DHCP do A.

🧩 📡 Cenário Atualizado
Função	Equipamento	IP	Descrição
Switch A (Core L3)	Catalyst 9200L-24P	-	DHCP + Roteamento Inter-VLAN
Switch B (Access L2)	Catalyst 9200L-48P	-	Clientes VLAN10
VLAN10	10.11.10.0/24	Clientes
VLAN20	10.11.11.0/24	Serviços
VLAN30	10.11.12.0/24	Administração
Trunk entre A↔B	Gi1/0/24 ↔ Gi1/0/48	VLANs 10,20,30
Gateway Internet	192.168.100.57 via VLAN30 (Admin)

⚙️ 1️⃣ SWITCH A (Core) – DHCP + Roteamento + Trunk

⚙️ 2️⃣ SWITCH B (Access) – Trunk + VLANs + Clientes

🧩 3️⃣ Funcionamento
💡 Fluxo de DHCP

O cliente em uma porta de acesso VLAN10 (Switch B) envia DHCP Discover.

O Switch B permite o tráfego até o trunk confiável (Gi1/0/48).

O Switch A (DHCP Server) responde com IP → 10.11.10.x.

Cliente recebe IP, gateway (10.11.10.1) e DNS (8.8.8.8).

🧩 4️⃣ Verificações
🔍 No Switch B:
bash
Copiar código
show ip dhcp snooping binding
Mostra a lista de clientes DHCP registrados.

🔍 No Switch A:
bash
Copiar código
show ip dhcp binding
Mostra os IPs distribuídos pelo servidor DHCP.

🔍 No Cliente:
bash
Copiar código
ipconfig /all
Deve mostrar IP da faixa 10.11.10.x e gateway 10.11.10.1.

✅ Resumo Final
Função	Switch A (Core)	Switch B (Access)
DHCP Server	✔️ ativo	❌ não
VLANs	10,20,30	10,20,30
Trunk	Gi1/0/24	Gi1/0/48
VLAN Nativa	10	10
DHCP Snooping	❌	✔️ ativo
Porta confiável	—	Gi1/0/48
Portas de cliente	—	Gi1/0/1–20

Deseja que eu adicione a VLAN 30 com acesso à Internet (NAT) via Switch A, para que os clientes das VLANs também saiam à Internet?







