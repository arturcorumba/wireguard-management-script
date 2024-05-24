# WireGuard Management Script

Este script em Bash foi desenvolvido para facilitar o gerenciamento de servidores WireGuard. Ele permite visualizar conexões, pesquisar peers, recarregar configurações, editar arquivos de configuração, reiniciar o serviço WireGuard e definir novos padrões de configuração. O script suporta tanto português quanto inglês.

## Características

- **Visualização de peers conectados**: Veja todos os peers conectados atualmente ao seu servidor WireGuard.
- **Pesquisa de peers**: Procure por um peer específico pelo nome.
- **Recarregamento de configurações**: Recarregue as configurações do WireGuard sem reiniciar o serviço.
- **Edição de arquivos de configuração**: Edite os arquivos de configuração diretamente pelo script.
- **Reinicialização do WireGuard**: Reinicie o serviço WireGuard para aplicar novas configurações.
- **Definição de novos padrões**: Alterne entre diferentes interfaces e arquivos de configuração.
- **Suporte bilíngue**: Interface disponível em português e inglês.

## Pré-requisitos

- **WireGuard**: Certifique-se de ter o WireGuard instalado e configurado no seu servidor.
- **Permissões de Superusuário**: Algumas funções requerem permissões de superusuário.

## Instalação

Clone este repositório:

```bash
git clone https://github.com/tckbrz/wireguard-management-script.git
chmod +x wireguard_management.sh
./wireguard_management.sh
