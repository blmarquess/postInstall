#!/usr/bin/env bash

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

PROGRAMAS_PARA_INSTALAR=(
  snapd
  git
  curl
  winff
  python3
  wine
  nautilus
  nautilus-dropbox
  docker-ce
  docker-compose
  build-essential
  libssl-dev
  flatpak
  gnome-software-plugin-flatpak
  gnome-sushi
  folder-color
  zsh
  nodejs
  apt-transport-https
  ca-certificates
  software-properties-common
)

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi

## Removendo travas eventuais do apt ##
echo -e "${VERDE}[INFO] - Configurando o sistema${SEM_COR}"
sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

## Adicionando/Confirmando arquitetura de 32 bits ##
echo -e "${VERDE}[INFO] - Confirmando arquitetura de 32 bits ${SEM_COR}"
sudo dpkg --add-architecture i386
sudo apt install  -y &&
sudo apt install -y gnome-sushi folder-color;
echo -e "${VERDE}[INFO] - Prerequisitos para sistema${SEM_COR}"
sudo apt purge -y nodejs npm;
sudo apt purge -y nodejs*;

echo -e "${VERDE}[INFO] - Add Repositorio do NodeJS ${SEM_COR}"
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
echo -e "${VERDE}[INFO] - Add Repositorio do Docker ${SEM_COR}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y

sudo apt update && sudo apt dist-upgrade -y &&

## Instalando pacotes e programas do repositório deb do Ubuntu ##
echo -e "${VERDE}|:<======================================================>:|${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

echo -e "${VERDE}|:<======================================================>:|${SEM_COR}"
echo -e "${VERDE}|:<============ Configurando o docker ===================>:|${SEM_COR}"
sudo usermod -aG docker ${USER} -y 
su - ${USER} -y 

echo -e "${VERDE}|:<======================================================>:|${SEM_COR}"
## Adicionando repositório Flathub ##
echo -e "${VERDE}[INFO] - Adicionando repositório Flathub...${SEM_COR}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y && 

## Instalando Apps do Flathub ##
echo -e "${VERDE}[INFO] - Instalando Apps do Flathub .... ${SEM_COR}"
echo -e "${VERDE}[INFO] -> Instalando OBS_Studio...${SEM_COR}"
sudo flatpak install flathub com.obsproject.Studio -y &&
echo -e "${VERDE}[INFO] -> Instalando editor de cosigos SublimeText...${SEM_COR}"
sudo flatpak install flathub com.sublimetext.three -y &&
echo -e "${VERDE}[INFO] -> Instalando DBeaverCommunity...${SEM_COR}"
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y &&
echo -e "${VERDE}[INFO] -> Instalando Discord ...${SEM_COR}"
sudo flatpak install flathub com.discordapp.Discord -y &&
echo -e "${VERDE}[INFO] -> Instalando VLC Video Player ...${SEM_COR}"
sudo flatpak install flathub org.videolan.VLC -y &&
echo -e "${VERDE}[INFO] -> Instalando Telegram Desktop ...${SEM_COR}"
sudo flatpak install flathub org.telegram.desktop -y &&
echo -e "${VERDE}[INFO] -> Instalando Chromium ...${SEM_COR}"
sudo flatpak install flathub org.chromium.Chromium -y &&
echo -e "${VERDE}[INFO] -> Instalando Gnome Boxes (Gerenciador de Maquinas virtuais) ...${SEM_COR}"
sudo flatpak install flathub org.gnome.Boxes -y &&
echo -e "${VERDE}[INFO] -> Instalando qBittorrent...${SEM_COR}"
sudo flatpak install flathub org.qbittorrent.qBittorrent -y &&
echo -e "${VERDE}[INFO] -> Instalando Flameshot...${SEM_COR}"
sudo flatpak install flathub org.flameshot.Flameshot -y &&
echo -e "${VERDE}[INFO] -> Instalando MoonPlayer ...${SEM_COR}"
sudo flatpak install flathub com.github.coslyk.MoonPlayer -y &&
echo -e "${VERDE}[INFO] -> Instalando App de Player da Twitch.tv...${SEM_COR}"
sudo flatpak install flathub com.vinszent.GnomeTwitch -y &&
echo -e "${VERDE}[INFO] -> Instalando verção free do VSCode sem a telemetria da Microsoft...${SEM_COR}"
sudo flatpak install flathub com.vscodium.codium -y &&
echo -e "${VERDE}[INFO] -> Instalando IDE PyCharm-Community para programar em python...${SEM_COR}"
sudo flatpak install flathub com.jetbrains.PyCharm-Community -y &&
echo -e "${VERDE}[INFO] -> Instalando IDE IntelliJ-IDEA-Community para programar em Java...${SEM_COR}"
sudo flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community -y &&
echo -e "${VERDE}[INFO] -> Instalando App desktop do GitHub...${SEM_COR}"
sudo flatpak install flathub io.github.shiftey.Desktop -y &&
echo -e "${VERDE}[INFO] -> Instalando Peek - para gravar e criar gifs...${SEM_COR}"
sudo flatpak install flathub com.uploadedlobster.peek -y &&
echo -e "${VERDE}[INFO] -> Instalando gerenciador de walpapers...${SEM_COR}"
sudo flatpak install flathub org.gabmus.hydrapaper -y &&
echo -e "${VERDE}[INFO] -> Instalando app de webcam ...${SEM_COR}"
sudo flatpak install flathub io.github.webcamoid.Webcamoid -y &&
echo -e "${VERDE}[INFO] -> Instalando Stremio  ...${SEM_COR}"
sudo flatpak install flathub com.stremio.Stremio -y &&
echo -e "${VERDE}[INFO] -> Instalando ONly-Office ...${SEM_COR}"
sudo flatpak install flathub org.onlyoffice.desktopeditors -y &&
echo -e "${VERDE}[INFO] -> Instalando Obsidian Editor de Markdown...${SEM_COR}"
sudo flatpak install flathub md.obsidian.Obsidian -y &&
echo -e "${VERDE}[INFO] -> Instalando Gerenciador de tarefas Planner...${SEM_COR}"
sudo flatpak install flathub com.github.alainm23.planner -y &&
echo -e "${VERDE}[INFO] -> Instalando Microsoft Teams...${SEM_COR}"
sudo flatpak install flathub com.microsoft.Teams -y &&
echo -e "${VERDE}[INFO] -> Instalando GIMP ++ PhotoGIMP  ...${SEM_COR}"
sudo flatpak install flathub org.gimp.GIMP -y &&
wget -c https://doc-0s-1g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/0v83rmt4mij9897co9ufvor2r1jcj1am/1567965600000/07452089978596344616/*/12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && unzip 12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && cd "PHOTOGIMP V2018 - DIOLINUX" && cd "PATCH" && mkdir -p /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ && cp -R * /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ &&

echo -e "${VERDE}|:<======================================================>:|${SEM_COR}"

echo -e "${VERDE}[INFO] - Instalando pacotes snap --> ${SEM_COR}"
## Instalando pacotes Snap ##
echo -e "${VERDE}[INFO] -> Instalando Slack ...${SEM_COR}"
sudo snap install slack --classic &&
echo -e "${VERDE}[INFO] -> Instalando VisualStudio Code ...${SEM_COR}"
sudo snap install code --classic &&  
echo -e "${VERDE}[INFO] -> Instalando Insomnia ...${SEM_COR}"
sudo snap install insomnia && 
echo -e "${VERDE}[INFO] -> Instalando Spotify ...${SEM_COR}"
sudo snap install spotify && 
echo -e "${VERDE}[INFO] -> Instalando BeeKeeper-Studio ...${SEM_COR}"
sudo snap install beekeeper-studio &&
echo -e "${VERDE}[INFO] -> Instalando WPS-Office ...${SEM_COR}"
sudo snap install wps-office-multilang && 
echo -e "${VERDE}[INFO] -> Instalando Zoom ...${SEM_COR}"
sudo snap install zoom-client && 
echo -e "${VERDE}[INFO] -> Instalando Postman ...${SEM_COR}"
sudo snap install postman && 
echo -e "${VERDE}[INFO] -> Instalando Mysql Workbench Community ...${SEM_COR}"
sudo snap install mysql-workbench-community &&


## Softwares que precisam de download externo ##
mkdir /TEMP_install && cd /TEMP_install && wget -c $URL_GOOGLE_CHROME && sudo dpkg -i *.deb && sudo apt install -f -y &&

## Microsoft Edge ##
echo -e "${VERDE}[INFO] - Instalando Microsoft Edge${SEM_COR}"
sudo apt install apt-transport-https ca-certificates curl software-properties-common wget -y

sudo wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list

echo -e "${VERDE}[INFO] - Criando pastas de trabalho${SEM_COR}"

#Cria pastas de trabalho e atalhos do nautilus

mkdir /home/$USER/WORKSPACE
mkdir /home/$USER/WORKSPACE/DEVELOPMENT
mkdir /home/$USER/WORKSPACE/PERSONAL
mkdir /home/$USER/WORKSPACE/TRYBE
mkdir /home/$USER/WORKSPACE/TRYBE/PROJECTS
mkdir /home/$USER/WORKSPACE/TRYBE/EXERCICES
mkdir /home/$USER/WORKSPACE/TRYBE/MSC
mkdir /home/$USER/AppImage

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/WORKSPACE" >> $FILE
echo "file:///home/$USER/WORKSPACE/TRYBE 🔵 TRYBE" >> $FILE
echo "file:///home/$USER/WORKSPACE/PERSONAL 🔴 PERSONAL" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

#Fim do Script ##

echo "Finalizado"

## Falta oh my zsh ##

