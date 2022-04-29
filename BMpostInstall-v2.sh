#!/usr/bin/env bash

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

PROGRAMAS_DEB=(
  snapd
  git
  curl
  build-essential
  gcc
  make
  dkms
  libssl-dev
  winff
  python3
  zsh
  gdebi
  apt-transport-https
  ca-certificates
  flatpak
  gnome-software-plugin-flatpak
  gnome-sushi
  folder-color
  software-properties-common
  docker-ce
  docker-compose
  gh
)

SNAP_APPS=(
  spotify
  node
  g-assist
  insomnia
  beekeeper-studio
  wps-office-multilang
  mysql-workbench-community
)

# SNAP_APP_CLASSIC=(
#   code --classic
# )

FLATPAK_APPS=(
com.obsproject.Studio
com.sublimetext.three
io.dbeaver.DBeaverCommunity
com.discordapp.Discord
org.videolan.VLC
org.telegram.desktop
org.chromium.Chromium
org.gnome.Boxes
org.qbittorrent.qBittorrent
org.flameshot.Flameshot
com.github.coslyk.MoonPlayer
com.vinszent.GnomeTwitch 
com.jetbrains.PyCharm-Community
com.jetbrains.IntelliJ-IDEA-Community
io.github.shiftey.Desktop
com.uploadedlobster.peek
io.github.webcamoid.Webcamoid
com.stremio.Stremio
org.onlyoffice.desktopeditors
md.obsidian.Obsidian
com.github.alainm23.planner
com.microsoft.Teams
org.gimp.GIMP
com.brave.Browser
com.ktechpit.wonderwall
com.microsoft.Edge
flathub com.slack.Slack
io.github.prateekmedia.appimagepool
com.getpostman.Postman
org.gnome.Firmware
com.google.Chrome
net.codeindustry.MasterPDFEditor
us.zoom.Zoom
com.github.wwmm.easyeffects
)

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}||============================[ERROR]=====================================||${SEM_COR}"
  echo -e "${VERMELHO}||                                                                        ||${SEM_COR}"
  echo -e "${VERMELHO}||    Seu computador não tem conexão com a Internet. Verifique a rede.    ||${SEM_COR}"
  echo -e "${VERMELHO}||                                                                        ||${SEM_COR}"
  echo -e "${VERMELHO}||============================[ERROR]=====================================||${SEM_COR}"

  exit 1
else
  echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  echo -e "${VERDE}|:==<                      Iniciando script                       >==:|${SEM_COR}"
  echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
fi

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==              Removendo travas eventuais do apt              >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==              Confirmando arquitetura de 32 bits             >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sudo dpkg --add-architecture i386
sudo apt install  -y &&
sudo apt install -y gnome-sushi folder-color;

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==   Removendo possivels versções antigas do nodeJS e docker   >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sudo apt purge -y nodejs npm;
sudo apt purge -y nodejs*;
sudo apt purge -y docker;

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==         Add Repositorio do NodeJS - Docker - FlatHub        >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update && sudo apt dist-upgrade -y &&

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>== Instalando pacotes e programas do repositório deb do Ubuntu >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_DEB[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then
    sudo apt install "$nome_do_programa" -y
  else
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    echo -e "${VERDE}                 $nome_do_programa instalado.                          ${SEM_COR}"
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  fi
done

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==                    Configurando o docker                    >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sudo usermod -aG docker ${USER}
su - ${USER} -y 

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==            Instalando pacotes snap e flatpak                >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 

for nome_do_programa in ${SNAP_APPS[@]}; do
  if ! snap list | grep -q $nome_do_programa; then
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    echo -e "${VERDE}                          Instalando $nome_do_programa                 ${SEM_COR}"
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    sudo snap install "$nome_do_programa"
  else
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    echo -e "${VERDE}                 $nome_do_programa instalado.                          ${SEM_COR}"
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  fi
done

sudo snap install code --classic

for nome_do_programa in ${FLATPAK_APPS[@]}; do
  if ! flatpak list | grep -q $nome_do_programa; then
  echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  echo -e "${VERDE}                Instalando $nome_do_programa                           ${SEM_COR}"
  echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    sudo flatpak install flathub "$nome_do_programa" -y
  else
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
    echo -e "${VERDE}                 $nome_do_programa instalado.                          ${SEM_COR}"
    echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  fi
done

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==               Criando pastas de trabalho                    >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

mkdir /home/$USER/WORKSPACE
mkdir /home/$USER/WORKSPACE/DEVELOPMENT
mkdir /home/$USER/WORKSPACE/PERSONAL
mkdir /home/$USER/WORKSPACE/TRYBE
mkdir /home/$USER/WORKSPACE/TRYBE/PROJECTS
mkdir /home/$USER/WORKSPACE/TRYBE/EXERCICES
mkdir /home/$USER/WORKSPACE/TRYBE/MSC
mkdir /home/$USER/AppImage


echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==                 Configurando o zsh/ohMyZsh                  >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==               Criando chave ssh em ./ssh                    >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
  if [ ! -f ~/.ssh/id_ed25519.pub ];then
    # -q --> is silent
    # -t rsa --> generate key
    # -N '' --> tells to use empty passphrase
    # -f <file> --> the file with new key
    ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519 > /dev/null
    ssh-add ~/.ssh/id_ed25519
  fi

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==               Essa é a chave ssh desta maquina              >==:|${SEM_COR}"
cat ~/.ssh/id_ed25519
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==               Definindo zsh como shell padrão               >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

chsh -s $(which zsh)

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==          Baixando fontes com simbolus e ligatures           >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

wget -c https://github.com/blmarquess/postInstall/blob/main/fonts.zip?raw=true

mv fonts.zip?raw=true fonts.zip
unzip fonts.zip
mv fonts /home/$USER/.local/share/
rm -rf fonts.zip
fc-cache -f -v

curl -L https://github.com/Diolinux/PhotoGIMP/releases/download/1.0/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip -o ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip && unzip ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip -d ~/Downloads && cp -R ~/Downloads/PhotoGIMP\ by\ Diolinux\ v2020\ for\ Flatpak/.var/app/org.gimp.GIMP/config/GIMP/2.10/ ~/Library/Application\ Support/GIMP/2.10 && rm ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==         Verificando atualizações e limpando cache           >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==                        Finalizado                           >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"

echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
echo -e "${VERDE}|:>==                   Reinicieo o sistema ..!                   >==:|${SEM_COR}"
echo -e "${VERDE}|:<=================================================================>:|${SEM_COR}"
