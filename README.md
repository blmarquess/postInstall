# PostInstall Ubuntu e derivados

## Setup que faço após instalar uma distro linux no meu PC

Este é o script que executo após a instalação do sistema no computador
>OBS: Este script foi feito pensando em uma distro baseada em Debian exemplo: Ubuntu, Lumbutu, kubuntu, xubuntu, linux-mint, PopOS, Deepin Linux, ElementaryOS, PearOS, Zorin OS, JigOS, LXLE, KDE Neon, Alinex, BackBox, PC/OS, Shift Linux, DuZero e etc...
>
>Para distros ArchBase estarei postando brevemente

### Para executar o script

Faça o download do arquivo BMpostInstall.sh
Clique com o botão direito sobre ele selecione propriedades, vá até a aba permissões e marque a caixa de texto que habilita executar o arquivo (nem todas as distribuições tem esta opção habilitada no gerenciador de arquivos)

### Opção via terminal

Copie o código abaixo e cole no terminal

```shell
wget https://github.com/blmarquess/postInstall/releases/download/slim_v0.2/install_v2_1 &&
sudo chmod a+x install_v2_1 && ./install_v2_1
```

De permissão ao seu usuario para usar o docker sem usar "sudo

```shell
sudo usermod -aG docker ${USER}
su - ${USER}
```

Então é só aguardar a execução e ao terminar reinicie a maquina e ja estará tudo instalado com a chave ssh criada pronta para registrar no github.

O Github CLI esta instalado para autenticar seu usuário execute:

```shell
gh auth login
```

Siga os passos para autenticar no github e utilizar o GitHub CLI

### lista de Aplicações instaladas com este script

- git
- python3
- zsh - ohMyZsh
- Flatpak com FlatHub
- Docker-ce
- gh - GitHub CLI
- Spotify
- NodeJs
- Insomnia
- Beekeeper-Studio
- WPS Office
- Mysql Workbench Community
- OBS Studio
- Sublimetext
- DBeaverCommunity
- Discord
- Videolan VLC
- Telegram desktop
- Gnome Boxes
- qBittorrent
- Flameshot
- JetBrains PyCharm-Community
- JetBrains IntelliJ-IDEA-Community
- Webcamoid
- Obsidian - Markdown editor
- Planner
- Microsoft Teams
- GIMP
- Brave Browser
- Wonderwall - 'app de wallpaper'
- Microsoft Edge
- Slack
- AppImage Store
- Postman
- Google Chrome
- MasterPDFEditor
- Zoom Meeting

### Proximas etapas

 - [ ]  Criar uma interface grafica para que possa ser selecionado quais aplicações serão instaladas.

<br />

### Para instalar os drives de video

[Guia de instalação de drives no linux](https://github.com/blmarquess/postInstall/blob/main/install-drives-GPU.md)

### Apoie o desenvolvimento

 - Marque como favorito


 - Se encontrar algum erro abra uma issue ou manda um e-mail


 - E se conseguir me paga um café. 😃

<div align='center'>
		
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/N4N2DC6XA)
		
</div>
