#!/usr/bin/env bash

#CORES
SEM_COR='\e[0m'
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
LARANJA='\e[1;93m'
CIANO='\e[1;94m'
ROXO='\e[1;95m'
AZUL='\e[1;96m'
WHITE='\e[1;97m'

#USER CREDENTIALS
USER_NAME=$(whoami)

echo -e ${ROXO}

echo -e "${LARANJA}|:<=================================================================>:|"
echo -e "|:>==                   Configurando credencias                   >==:|"
echo -e "|:<=================================================================>:|${SEM_COR}"

echo -e "${WHITE}Para configurar o git informe o usuario e e-mail do GitHub conforme solicitados"
echo "Digite o seu e-mail do GitHub:"
read GIT_EMAIL
echo " "
echo "Digite o seu usuario do GitHub:"
read GIT_USER

echo -e "${LARANJA}|:<=================================================================>:|${SEM_COR}"
echo -e "Para continuar digite Senha ${VERMELHO}'!DO COMPUDADOR!':${SEM_COR}"
read USER_PSW


echo "|:<=================================================================>:|"
echo "|:|   ----         Criando chave ssh em ./ssh         ----           :|"
echo "|:<=================================================================>:|"
  if [ ! -f ~/.ssh/id_ed25519.pub ];then
    ssh-keygen -q -t ed25519 -N "$USER_PSW" -C $GIT_EMAIL -f ~/.ssh/id_ed25519 > /dev/null
    ssh-add ~/.ssh/id_ed25519
  fi

  echo -e ${SEM_COR}

