const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');

console.log(path.join(__dirname, 'preloader.js'));
function createWindow() {
  const win = new BrowserWindow({
    width: 700,
    height: 850,
    webPreferences: {
      nodeIntegration: true,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  win.loadURL('http://localhost:3000');
  // mainWindow.loadFile(path.join(__dirname, './build/index.html'));
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

ipcMain.on('save', (event, ctx) => {
  console.log(ctx);
})