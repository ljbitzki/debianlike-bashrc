# Gerador rápido de senha complexa
alias senha-complexa='cat /dev/urandom | tr -dc "a-zA-Z0-9!@#$%*,./;()<>:?_+" | fold -w 24 | head -n 1'

# Gerador rápido de senha simples
alias senha-simples='cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 24 | head -n 1'

# Extrator de endereços IPv4
function ipv4() {
        grep -Eo '(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))'
}

# fzf com preview
alias fzf-preview='sudo fzf --preview="head -n100 {}" --preview-window=right:70%'

# Criador de diretório temporário
alias tempdir='DT=$(cat /dev/urandom | tr -dc "a-z0-9" | fold -w 16 | head -n 1); mkdir -p /tmp/tmp.${DT}; cd /tmp/tmp.${DT}'

# Extrator de endereços IPv6
function ipv6() {
        grep -Eo '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'
}

# Extrator de URLs
function url_extractor() {
    grep -oE '(https?:\/\/(www\.)?([-a-zA-Z0-9@:%._\+~#=]{2,256})\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))|https?:\/\/(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/\[([0-9\:].*)\]\/)\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)'
}

# Extrator de endereços de e-mail 
function emailregex() {
        grep -Eo '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b'
}

# Conversor de MAC Address: aa:bb:cc:dd:ee:ff -> aabb-ccdd-eeff ou aabb-ccdd-eeff -> aa:bb:cc:dd:ee:ff
function convert-mac() {
TRACO=$( echo ${1} | grep -c '-' )
DPONTO=$( echo ${1} | grep -c ':' )
function TRACO2PONTOS() {
        UM=$( echo ${1} | awk -F':' '{print $1}' )
        DOIS=$( echo ${1} | awk -F':' '{print $2}' )
        TRES=$( echo ${1} | awk -F':' '{print $3}' )
        QUATRO=$( echo ${1} | awk -F':' '{print $4}' )
        CINCO=$( echo ${1} | awk -F':' '{print $5}' )
        SEIS=$( echo ${1} | awk -F':' '{print $NF}' )
        echo -e "\n\e[32m${UM}${DOIS}-${TRES}${QUATRO}-${CINCO}${SEIS}\e[0m\n"
}
function PONTOS2TRACO() {
        UMDOIS=$( echo ${1} | awk -F'-' '{print $1}' | sed -r 's/.{2}/&:/g' )
        TRESQUATRO=$( echo ${1} | awk -F'-' '{print $2}' | sed -r 's/.{2}/&:/g' )
        CINCOSEIS=$( echo ${1} | awk -F'-' '{print $NF}' | sed -r 's/.{2}/&:/g' | sed 's/.$//' )
        echo -e "\n\e[32m${UMDOIS}${TRESQUATRO}${CINCOSEIS}\e[0m\n"
}
if [ ${TRACO} -gt 0 ]; then
        PONTOS2TRACO ${1}
fi
if [ ${DPONTO} -gt 0 ]; then
        TRACO2PONTOS ${1}
fi
}

# Auxiliar "d" para comandos docker
function d() {
        case "${1}" in
                ps)
                        if [[ -z "${2}" ]]; then
                                docker ps -a
                        else
                                docker ps -a | grep --color "${2}"
                        fi
                        ;;
                rm)
                        if [[ -z "${2}" ]] ; then
                                echo "Necessário informar algum termo de busca."
                                echo "Uso: d rm termo_de_busca_container_porta"
                        else
                                while read -r CID IMAGE; do
                                        docker stop "${CID}" > /dev/null 2>&1
                                        echo -e "Parando container ${CID}\t${IMAGE}"
                                        docker rm "${CID}" > /dev/null 2>&1
                                        echo -e "Removendo container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | grep "${2}" | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        fi
                        ;;
                stop)
                        if [[ -z "${2}" ]] ; then
                                echo "Necessário informar algum termo de busca."
                                echo "Uso: d stop termo_de_busca_container_porta/TODOS"
                        elif [[ "${2}" == "TODOS" ]] ; then
                                while read -r CID IMAGE; do
                                        docker stop "${CID}" > /dev/null 2>&1
                                        echo -e "Parando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        else
                                while read -r CID IMAGE; do
                                        docker stop "${CID}" > /dev/null 2>&1
                                        echo -e "Parando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | grep "${2}" | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        fi
                        ;;
                start)
                        if [[ -z "${2}" ]] ; then
                                echo "Necessário informar algum termo de busca."
                                echo "Uso: d start termo_de_busca_container_porta/TODOS"
                        elif [[ "${2}" == "TODOS" ]] ; then
                                while read -r CID IMAGE; do
                                        docker start "${CID}" > /dev/null 2>&1
                                        echo -e "Iniciando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        else
                                while read -r CID IMAGE; do
                                        docker start "${CID}" > /dev/null 2>&1
                                        echo -e "Iniciando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | grep "${2}" | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        fi
                        ;;
                restart)
                        if [[ -z "${2}" ]] ; then
                                echo "Necessário informar algum termo de busca."
                                echo "Uso: d restart termo_de_busca_container_porta/TODOS"
                        elif [[ "${2}" == "TODOS" ]] ; then
                                while read -r CID IMAGE; do
                                        docker restart "${CID}" > /dev/null 2>&1
                                        echo -e "Reiniciando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        else
                                while read -r CID IMAGE; do
                                        docker restart "${CID}" > /dev/null 2>&1
                                        echo -e "Reiniciando container ${CID}\t${IMAGE}"
                                done < <( docker ps -a | grep "${2}" | awk '{print $1" "$2}' | grep -Ew '^([a-f0-9]){12}' )
                        fi
                        ;;
                rmi)
                        docker rmi $(docker images -q)
                        ;;
                orph)
                        docker system prune --volumes -a
                        ;;
                help)
                        echo -e "\e[32mps:\e[0m\t\td ps termo, similar a docker ps -s | grep termo. Sem termo, exibe todos os containers."
                        echo -e "\e[31mrm:\e[0m\t\td rm termo, para e remove todos os containers que contenham o termo informado. Use com cuidado."
                        echo -e "\e[32mstart:\e[0m\t\td start termo, tenta iniciar todos os containers que contenham o termo informado."
                        echo -e "\e[32mstop:\e[0m\t\td stop termo, para todos os containers que contenham o termo informado."
                        echo -e "\e[32mrestart:\e[0m\td restart termo, reinicia todos os containers que contenham o termo informado."
                        echo -e "\e[33mrmi:\e[0m\t\td rmi, remove imagens baixadas."
                        echo -e "\e[33morph:\e[0m\t\td orph, remove artefatos órfãos."
                        ;;
                *)
                        echo -e "Uso: d \e[32mps\e[0m|\e[31mrm\e[0m|\e[32mstart\e[0m|\e[32mstop\e[0m|\e[32mrestart\e[0m|\e[33morph\e[0m|\e[33mrmi\e[0m|\e[36mhelp\e[0m termo"
                ;;
        esac
}
