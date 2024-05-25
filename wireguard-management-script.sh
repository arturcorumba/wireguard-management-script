#!/usr/bin/env bash
set -euo pipefail

# Definição de cores
Color_Off='\033[0m'
Vermelho='\033[0;31m'
Azul_Claro='\033[1;34m'
Cinza_Escuro='\033[1;90m'
Branco='\033[1;97m'
Cinza_Claro='\033[0;37m'

## Função para centralizar e colorir texto
print_centered() {
    local input="$1"
    local color="$2"
    local term_width=$(tput cols)
    local text_width=${#input}

    # Remover códigos de cores para cálculo da largura
    local stripped_input=$(echo -e "$input" | sed 's/\x1b\[[0-9;]*m//g')
    local stripped_width=${#stripped_input}

    # Calcular preenchimento
    local pad_width=$(( (term_width - stripped_width) / 2 ))
    local padding=$(printf '%*s' "$pad_width")

    # Imprimir com cor e preenchimento
    echo -e "${padding}${color}${input}${Color_Off}"
}

# Banner ASCII
BANNER_ASCII=$(cat << EOF

 __      __.__                 ________                       .___
/  \    /  \__|______   ____  /  _____/ __ _______ _______  __| _/
\   \/\/   /  \_  __ \_/ __ \/   \  ___|  |  \__  \\_  __ \/ __ |
 \        /|  ||  | \/\  ___/\    \_\  \  |  // __ \|  | \/ /_/ |
  \__/\  / |__||__|    \___  >\______  /____/(____  /__|  \____ |
       \/                  \/        \/           \/           \/

GERENCIAMENTO DE SERVIDOR WIREGUARD
WIREGUARD MANAGEMENT SERVER
EOF
)

# Formatar Banner
print_banner() {
    while IFS= read -r line; do
        print_centered "$line" "$Branco"
    done <<< "$BANNER_ASCII"
}

# Funções de idioma em Português
print_menu_pt() {
    clear  # Limpa apenas o conteúdo do menu
    print_banner
    printf "$Branco 💻 O que você precisa fazer?\n"
    echo -e "--------------------------------------"
    echo -e "              PADRÕES                 "
    echo -e "Interface: $interface"
    echo -e "Configuração: $interface_config"
    echo -e "--------------------------------------"
    echo -e "[1] - Exibir peers conectados"
    echo -e "[2] - Procurar um peer"
    echo -e "[3] - Recarregar as configurações"
    echo -e "[4] - Editar o arquivo de configuração"
    echo -e "[5] - Reiniciar WireGuard"
    echo -e "[6] - Definir novo padrão"
    echo -e "[7] - Adicionar novo peer"
    echo -e "[q] - Sair"
    echo -e "--------------------------------------"
}

show_all_connections_pt() {
    clear  # Limpa apenas o conteúdo do menu
    print_banner
    DATE=$(date +%Y-%m-%d\ %H:%M:%S)
    WG_TEMP_FILE="/tmp/wg_peers_temp"
    number=0
    connections=()
    while true; do
        wg | grep -B1 -A4 endpoint > "$WG_TEMP_FILE"
        for connected in $(wg | grep -B1 -A2 endpoint | grep peer | awk '{print $2}'); do
            client=$(grep -B1 "$connected" "$interface_config" | grep -v PublicKey)
            allowed=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep allowed | awk -F':' '{print $2}')
            transfer=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep transfer | awk -F':' '{print $2}')
            client="\033[92m${client}\033[0m"
            allowed="\033[91m${allowed}\033[0m"
            transfer="Tráfego:\033[36m${transfer}\033[0m"
            connections+=("$client | $allowed | $transfer")
            number=$((number + 1))
        done
        clear  # Limpa a tela antes de exibir as conexões
        print_banner

        # Ordenar conexões
        IFS=$'\n' sorted_connections=($(sort <<<"${connections[*]}"))
        unset IFS

        # Exibir conexões ordenadas
        for connection in "${sorted_connections[@]}"; do
            echo -e "$connection"
        done
        echo -e "\n\n\t\t[Informação coletada em: ${DATE}] | [$number CONEXÕES ATIVAS]"
        tput cup $(( $(tput lines) - 1 )) 0  # Move o cursor para a posição específica na tela
        for ((i = 5; i > 0; i--)); do
            echo -n "[Próxima atualização em $i segundos | Pressione 'q' para sair]     "
            sleep 1
            echo -ne "\r\033[2K" # Move o cursor para o início da linha e limpa a linha
        done
        if read -t 1 -n 1 key && [[ $key == "q" ]]; then
            echo "Saindo..."
            return
        fi
        connections=()
        number=0
    done
}

search_client_pt() {
    read -p "Digite o nome do cliente: " search_term
    WG_TEMP_FILE="/tmp/wg_peers_temp"
    wg | grep -B1 -A4 endpoint > "$WG_TEMP_FILE"
    connections=()

    for connected in $(wg | grep -B1 -A2 endpoint | grep peer | awk '{print $2}'); do
        client=$(grep -B1 "$connected" "$interface_config" | grep -v PublicKey)
        allowed=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep allowed | awk -F':' '{print $2}')
        transfer=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep transfer | awk -F':' '{print $2}')

        client="\033[92m${client}\033[0m"
        allowed="\033[91m${allowed}\033[0m"
        transfer="Tráfego:\033[36m${transfer}\033[0m"

        connections+=("$client | $allowed | $transfer")
    done

    IFS=$'\n' sorted_connections=($(sort <<<"${connections[*]}"))
    unset IFS

    search_result=$(printf "%s\n" "${sorted_connections[@]}" | grep -i "$search_term")
    if [ -z "$search_result" ]; then
        echo "Cliente não encontrado."
    else
        echo -e "$search_result"
    fi
    read -n 1 -s -r -p "Pressione qualquer tecla para voltar ao menu..."
}

# Funções de idioma em Inglês
print_menu_en() {
    clear  # Limpa apenas o conteúdo do menu
    print_banner
    printf "$Branco 💻 What do you need to do?\n"
    echo -e "--------------------------------------"
    echo -e "              DEFAULTS                "
    echo -e "Interface: $interface"
    echo -e "Configuration: $interface_config"
    echo -e "--------------------------------------"
    echo -e "[1] - Show connected peers"
    echo -e "[2] - Search for a peer"
    echo -e "[3] - Reload configurations"
    echo -e "[4] - Edit configuration file"
    echo -e "[5] - Restart WireGuard"
    echo -e "[6] - Set new defaults"
    echo -e "[7] - Add new peer"
    echo -e "[q] - Exit"
    echo -e "--------------------------------------"
}

show_all_connections_en() {
    clear  # Limpa apenas o conteúdo do menu
    print_banner
    DATE=$(date +%Y-%m-%d\ %H:%M:%S)
    WG_TEMP_FILE="/tmp/wg_peers_temp"
    number=0
    connections=()
    while true; do
        wg | grep -B1 -A4 endpoint > "$WG_TEMP_FILE"
        for connected in $(wg | grep -B1 -A2 endpoint | grep peer | awk '{print $2}'); do
            client=$(grep -B1 "$connected" "$interface_config" | grep -v PublicKey)
            allowed=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep allowed | awk -F':' '{print $2}')
            transfer=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep transfer | awk -F':' '{print $2}')
            client="\033[92m${client}\033[0m"
            allowed="\033[91m${allowed}\033[0m"
            transfer="Traffic:\033[36m${transfer}\033[0m"
            connections+=("$client | $allowed | $transfer")
            number=$((number + 1))
        done
        clear  # Limpa a tela antes de exibir as conexões
        print_banner

        # Ordenar conexões
        IFS=$'\n' sorted_connections=($(sort <<<"${connections[*]}"))
        unset IFS

        # Exibir conexões ordenadas
        for connection in "${sorted_connections[@]}"; do
            echo -e "$connection"
        done
        echo -e "\n\n\t\t[Information collected at: ${DATE}] | [$number ACTIVE CONNECTIONS]"
        tput cup $(( $(tput lines) - 1 )) 0  # Move o cursor para a posição específica na tela
        for ((i = 5; i > 0; i--)); do
            echo -n "[Next update in $i seconds | Press 'q' to exit]     "
            sleep 1
            echo -ne "\r\033[2K" # Move o cursor para o início da linha e limpa a linha
        done
        if read -t 1 -n 1 key && [[ $key == "q" ]]; then
            echo "Exiting..."
            return
        fi
        connections=()
        number=0
    done
}

search_client_en() {
    read -p "Enter the client name: " search_term
    WG_TEMP_FILE="/tmp/wg_peers_temp"
    wg | grep -B1 -A4 endpoint > "$WG_TEMP_FILE"
    connections=()

    for connected in $(wg | grep -B1 -A2 endpoint | grep peer | awk '{print $2}'); do
        client=$(grep -B1 "$connected" "$interface_config" | grep -v PublicKey)
        allowed=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep allowed | awk -F':' '{print $2}')
        transfer=$(grep -A4 "$connected" "$WG_TEMP_FILE" | grep transfer | awk -F':' '{print $2}')

        client="\033[92m${client}\033[0m"
        allowed="\033[91m${allowed}\033[0m"
        transfer="Traffic:\033[36m${transfer}\033[0m"

        connections+=("$client | $allowed | $transfer")
    done

    IFS=$'\n' sorted_connections=($(sort <<<"${connections[*]}"))
    unset IFS

    search_result=$(printf "%s\n" "${sorted_connections[@]}" | grep -i "$search_term")
    if [ -z "$search_result" ]; then
        echo "Client not found."
    else
        echo -e "$search_result"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

# Menu de seleção de idioma
select_language() {
    echo "Select Language / Selecione o Idioma:"
    echo "1) PORTUGUES - BRASIL"
    echo "2) ENGLISH"
    read -p "Escolha o idioma / Choice language: " language_choice
    case $language_choice in
        1)
            LANGUAGE="PT"
            ;;
        2)
            LANGUAGE="EN"
            ;;
        *)
            echo "Escolha inválida / Invalid choice"
            exit 1
            ;;
    esac
}

# Variáveis de configuração padrão
interface="wg0"
interface_config="/etc/wireguard/wg0.conf"

# Menu principal
main_menu() {
    while true; do
        if [ "$LANGUAGE" == "EN" ]; then
            print_menu_en
            read -p "Choose an option: " choice
            case $choice in
                1)
                    show_all_connections_en
                    ;;
                2)
                    search_client_en
                    ;;
                3)
                    sudo systemctl reload wg-quick@$interface
                    ;;
                4)
                    sudo nano $interface_config
                    ;;
                5)
                    sudo systemctl restart wg-quick@$interface
                    ;;
                6)
                    read -p "Enter new interface: " new_interface
                    read -p "Enter new configuration file path: " new_interface_config
                    interface=$new_interface
                    interface_config=$new_interface_config
                    ;;
                7)
                    sudo nano $interface_config
                    ;;
                q)
                    echo "Exiting..."
                    exit 0
                    ;;
                *)
                    echo "Invalid option"
                    ;;
            esac
        elif [ "$LANGUAGE" == "PT" ]; then
            print_menu_pt
            read -p "Escolha uma opção: " choice
            case $choice in
                1)
                    show_all_connections_pt
                    ;;
                2)
                    search_client_pt
                    ;;
                3)
                    sudo systemctl reload wg-quick@$interface
                    ;;
                4)
                    sudo nano $interface_config
                    ;;
                5)
                    sudo systemctl restart wg-quick@$interface
                    ;;
                6)
                    read -p "Digite a nova interface: " new_interface
                    read -p "Digite o novo caminho do arquivo de configuração: " new_interface_config
                    interface=$new_interface
                    interface_config=$new_interface_config
                    ;;
                7)
                    sudo nano $interface_config
                    ;;
                q)
                    echo "Saindo..."
                    exit 0
                    ;;
                *)
                    echo "Opção inválida"
                    ;;
            esac
        fi
    done
}

# Iniciar o script
select_language
main_menu
