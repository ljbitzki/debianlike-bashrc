#!/usr/bin/env bash

if [ "${#}" -ne "3" ]; then
        echo -e "Necessário três parâmetros: \e[33m${0}\e[0m \e[35m143.54.1.183 \e[0m \e[93m1550\e[0m \e[94m1350\e[0m"
        echo -e "1: Endereço IPv4 ou IPv6."
        echo -e "2: MTU alto inicial. Sugerido entre \e[35m1550\e[0m e \e[35m1500\e[0m, dependendo do cenário."
        echo -e "3: MTU baixo final. Sugerido entre \e[35m1350\e[0m e \e[35m1400\e[0m, dependendo do cenário."
        exit 1
fi

if [ "$( echo "${1}" | grep -Eco '(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))' )" -eq 1 ]; then
        HOST="${1}"
elif [ "$( echo "${1}" | grep -Eco '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))' )" -eq 1 ]; then
        HOST="${1}"
else
        echo -e "Endereço IP inválido."
        exit 1
fi


MTUI="${2}"
MTUF="${3}"

for i in $( seq ${MTUI} -1 ${MTUF} ); do
        fping -q -M -b ${i} -r 1 -i 50 -t 50 "${HOST}"
        if [ "${?}" -eq 0 ]; then
                echo "O payload máximo suportado é de ${i}, sendo o MTU $(( i + 28)) bytes."
                exit 1
        fi
done
