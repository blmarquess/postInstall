#!/usr/bin/env bash

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
CORR='\e[1;96m'
SEM_COR='\e[0m'

#USER CREDENTIALS
$USER_NAME=$(whoami)

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
  insomnia
  beekeeper-studio
  wps-office-multilang
  mysql-workbench-community
)

FLATPAK_APPS=(
com.obsproject.Studio
com.sublimetext.three
io.dbeaver.DBeaverCommunity
com.discordapp.Discord
org.videolan.VLC
org.telegram.desktop
org.gnome.Boxes
org.qbittorrent.qBittorrent
org.flameshot.Flameshot
com.jetbrains.PyCharm-Community
com.jetbrains.IntelliJ-IDEA-Community
io.github.shiftey.Desktop
com.uploadedlobster.peek
io.github.webcamoid.Webcamoid
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
com.google.Chrome
net.codeindustry.MasterPDFEditor
us.zoom.Zoom
com.github.wwmm.easyeffects
)

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e ${VERMELHO}
  echo "|:============================[ERROR]=====================================:|"
  echo "|:                                                                        :|"
  echo "|:    Seu computador não tem conexão com a Internet. Verifique a rede.    :|"
  echo "|:                                                                        :|"
  echo "|:============================[ERROR]=====================================:|"
  echo -e ${SEM_COR}

  exit 1
else
  echo -e ${CIANO}
  echo "|:<=================================================================>:|"
  echo "|:|                        Iniciando script                         |:|"
  echo "|:<=================================================================>:|"
  echo -e ${SEM_COR}
fi

echo -e ${ROXO}
echo "|:<=================================================================>:|"
echo "|:|                     Configurando credencias                     |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}
echo -e ${WHITE}
echo "|:<===========================================================================>:|"
echo -"Para configurar o git informe o usuario e e-mail do GitHub conforme solicitados"
echo " "
echo "Digite o seu e-mail do GitHub:"
read GIT_EMAIL
echo " "
echo "Digite o seu usuario do GitHub:"
read GIT_USER

echo -e "${LARANJA}|:<=================================================================>:|${SEM_COR}"
echo -e "Para continuar digite Senha ${VERMELHO}'!DO COMPUDADOR!':${SEM_COR}"
read USER_PSW

echo -e ${WHITE}
echo "|:<=================================================================>:|"
echo "|:|                Removendo travas eventuais do apt                |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

echo -e ${AZUL}
echo "|:<=================================================================>:|"
echo "|:|                Confirmando arquitetura de 32 bits               |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

sudo dpkg --add-architecture i386
sudo apt install  -y &&
sudo apt install -y gnome-sushi folder-color;

echo -e ${LARANJA}
echo "|:<=================================================================>:|"
echo "|:|     Removendo possivels versções antigas do nodeJS e docker     |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

sudo apt purge -y nodejs npm;
sudo apt purge -y nodejs*;
sudo apt purge -y docker;

echo -e ${CIANO}
echo "|:<=================================================================>:|"
echo "|:|           Add Repositorio do NodeJS - Docker - FlatHub          |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update && sudo apt dist-upgrade -y &&

echo -e ${CIANO}
echo "|:<=================================================================>:|"
echo "|:|   Instalando pacotes e programas do repositório deb do Ubuntu   |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

for nome_do_programa in ${PROGRAMAS_DEB[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then
    echo -e ${LARANJA}
    echo "|:<=================================================================>:|"
    echo "                Instalando $nome_do_programa                          "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
    sudo apt install "$nome_do_programa" -y
  else
    echo -e ${WHITE}
    echo "|:<=================================================================>:|"
    echo "                 $nome_do_programa já esta instalado.                  "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
  fi
done

echo -e ${CIANO}
echo "|:<=================================================================>:|"
echo "|:>==            Instalando pacotes snap e flatpak                >==:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 

for nome_do_programa in ${SNAP_APPS[@]}; do
  if ! snap list | grep -q $nome_do_programa; then
    echo -e ${AZUL}
    echo "|:<=================================================================>:|"
    echo "               Instalando $nome_do_programa                          "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
    sudo snap install "$nome_do_programa"
  else
    echo -e ${WHITE}
    echo "|:<=================================================================>:|"
    echo  "                 $nome_do_programa já esta instalado.                 "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
  fi
done

## Instalando Snap Apps que utilizam confinamento classico
sudo snap install code --classic
sudo snap install node --classic

for nome_do_programa in ${FLATPAK_APPS[@]}; do
  if ! flatpak list | grep -q $nome_do_programa; then
    echo -e ${AZUL}
    echo "|:<=================================================================>:|"
    echo "                Instalando $nome_do_programa                           "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
    sudo flatpak install flathub "$nome_do_programa" -y
  else
    echo -e ${WHITE}
    echo "|:<=================================================================>:|"
    echo "                 $nome_do_programa já esta instalado.                  "
    echo "|:<=================================================================>:|"
    echo -e ${SEM_COR}
  fi
done

echo -e ${WHITE}
echo "|:<=================================================================>:|"
echo "|:|                  Criando pastas de trabalho                     |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

mkdir /home/$USER/WORKSPACE
mkdir /home/$USER/WORKSPACE/DEVELOPMENT
mkdir /home/$USER/WORKSPACE/PERSONAL
mkdir /home/$USER/WORKSPACE/TRYBE
mkdir /home/$USER/WORKSPACE/TRYBE/PROJECTS
mkdir /home/$USER/WORKSPACE/TRYBE/EXERCICES
mkdir /home/$USER/WORKSPACE/TRYBE/MSC
mkdir /home/$USER/AppImage

echo -e ${ROXO}
echo "|:<=================================================================>:|"
echo "|:>==                 Configurando o zsh/ohMyZsh                  >==:|"
echo "|:<=================================================================>:|"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "|:<=================================================================>:|"
echo "|:|        ----     Definindo zsh como shell padrão    ----         |:|"
echo "|:<=================================================================>:|"

chsh -s $(which zsh)
echo -e ${SEM_COR}

echo -e ${LARANJA}
echo "|:<=================================================================>:|"
echo "|:|    ---    Baixando fontes com simbolus e ligatures      ---     |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

wget -c https://github.com/blmarquess/postInstall/blob/main/fonts.zip?raw=true

mv fonts.zip?raw=true fonts.zip
unzip fonts.zip
mv fonts /home/$USER/.local/share/
rm -rf fonts.zip
fc-cache -f -v

curl -L https://github.com/Diolinux/PhotoGIMP/releases/download/1.0/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip -o ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip && unzip ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip -d ~/Downloads && cp -R ~/Downloads/PhotoGIMP\ by\ Diolinux\ v2020\ for\ Flatpak/.var/app/org.gimp.GIMP/config/GIMP/2.10/ ~/Library/Application\ Support/GIMP/2.10 && rm ~/Downloads/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip

echo -e ${ROXO}
echo "|:<=================================================================>:|"
echo "|:|  ----  Configurando Git e Criando chave ssh em ./ssh    ----     :|"
echo "|:<=================================================================>:|"

git config --global user.name "$USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor "code --wait"

  if [ ! -f ~/.ssh/id_ed25519.pub ];then
    ssh-keygen -q -t ed25519 -N "$USER_PSW" -C $GIT_EMAIL -f ~/.ssh/id_ed25519 > /dev/null
    ssh-add ~/.ssh/id_ed25519
  fi

  echo -e ${SEM_COR}

echo -e ${CIANO}
echo "|:<=================================================================>:|"
echo "|:|                      Configurando o docker                      |:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

sudo usermod -aG docker ${USER}
su - ${USER}

echo -e ${VERDE}
echo "|:<=================================================================>:|"
echo "|:>==         Verificando atualizações e limpando cache           >==:|"
echo "|:<=================================================================>:|"

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

echo "|:<=================================================================>:|"
echo "|:>==                        Finalizado                           >==:|"
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

echo -e ${LARANJA}
echo "|:<=================================================================>:|"
echo "|:|                  Essa é a chave ssh desta maquina               |:|"
echo " "
cat ~/.ssh/id_ed25519.pub
echo "|:      so copiar e cole em sua lista do  GitHub de keys ssh        |:|"
echo " "
echo "|:<=================================================================>:|"
echo -e ${SEM_COR}

echo -e ${AZUL}
echo -e "${AZUL}|:<=================================================================>:|${SEM_COR}"
echo -e "${WHITE}|:|                   Reinicieo o sistema ..!                       |:|${SEM_COR}"
echo -e "${AZUL}|:<=================================================================>:|${SEM_COR}"
