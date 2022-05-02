window.addEventListener('DOMContentLoaded', () => {
  console.log('Carregou!!!');
  const replaceText = document.getElementById('el-send');
  if (replaceText) {
    return replaceText.innerText = 'Preloader OK';
  } return console.log('replaceText não encontrou o alvo!');
})

const { ipcRenderer, contextBridge } = require('electron');

contextBridge.exposeInMainWorld('electron', {
  notificationApi: {
    sendNotification(message) {
      ipcRenderer.send('test', message);
    }
  }
})