## WireGuard Management Script

Este script em Bash foi desenvolvido para facilitar o gerenciamento de servidores WireGuard. Ele permite visualizar conexões, pesquisar peers, recarregar configurações, editar arquivos de configuração, reiniciar o serviço WireGuard e definir novos padrões de configuração. O script suporta tanto português quanto inglês.

This Bash script was developed to facilitate the management of WireGuard servers. It allows you to view connections, search for peers, reload configurations, edit configuration files, restart the WireGuard service, and set new configuration defaults. The script supports both Portuguese and English.

## 🚀 O que o script faz? / What the script does?
### [PT-BR] ![Brazil](https://raw.githubusercontent.com/stevenrskelton/flag-icon/master/png/16/country-4x3/br.png "Brazil") 
- **Visualização de peers conectados**: Veja todos os peers conectados atualmente ao seu servidor WireGuard.
- **Pesquisa de peers**: Procure por um peer específico pelo nome.
- **Recarregamento de configurações**: Recarregue as configurações do WireGuard sem reiniciar o serviço.
- **Edição de arquivos de configuração**: Edite os arquivos de configuração diretamente pelo script.
- **Reinicialização do WireGuard**: Reinicie o serviço WireGuard para aplicar novas configurações.
- **Definição de novos padrões**: Alterne entre diferentes interfaces e arquivos de configuração.
- **Suporte bilíngue**: Interface disponível em português e inglês.
### [EN] ![United States](https://raw.githubusercontent.com/stevenrskelton/flag-icon/master/png/16/country-4x3/us.png "United States")
- **Viewing connected peers**: See all peers currently connected to your WireGuard server.
- **Peer search**: Search for a specific peer by name.
- **Configuration reload**: Reload WireGuard settings without restarting the service.
- **Configuration file editing**: Edit configuration files directly through the script.
- **WireGuard restart**: Restart the WireGuard service to apply new settings.
- **Setting new defaults**: Switch between different interfaces and configuration files.
- **Bilingual support**: Interface available in both Portuguese and English.


### 📋 Pré-requisitos / Prerequisites

- **WireGuard**: Certifique-se de ter o WireGuard instalado e configurado no seu servidor.
- **Permissões de Superusuário**: Algumas funções requerem permissões de superusuário.

### 🔧 Instalação / Setup

```
bash
git clone https://github.com/arturcorumba/wireguard-management-script.git
chmod +x wireguard_management.sh
./wireguard_management.sh
```
### 📦 Menu PT-BR
```
Selecione o Idioma / Select Language:
1) PORTUGUES - BRASIL
2) ENGLISH
Escolha o idioma / Choice language: 

💻 O que você precisa fazer?
--------------------------------------
              PADRÕES                 
Interface: wg0
Configuração: /etc/wireguard/wg0.conf
--------------------------------------
[1] - Exibir peers conectados
[2] - Procurar um peer
[3] - Recarregar as configurações
[4] - Editar o arquivo de configuração
[5] - Reiniciar WireGuard
[6] - Definir novo padrão
[7] - Adicionar novo peer
[q] - Sair
--------------------------------------
```
### 📦 Menu EN
```
💻 What do you need to do?
--------------------------------------
              DEFAULTS                 
Interface: wg0
Configuration: /etc/wireguard/wg0.conf
--------------------------------------
[1] - Show connected peers
[2] - Search for a peer
[3] - Reload configurations
[4] - Edit configuration file
[5] - Restart WireGuard
[6] - Set new defaults
[7] - Add new peer
[q] - Exit
--------------------------------------
```
### 🛠️ Construído com / Built with
- ChatGPT
- Cafezinhos
### 📌 Versão / Version
0.5.2024
### 📄 Licença / License
The GNU General Public License v3.0
### 🎁 Agradecimentos
* Mariana ❤️ que move meu mundo e objetivos / Mariana ❤️ who moves my world and objectives.
⌨️ com ❤️ por [Artur Corumba](https://github.com/tckbrz) 😊
