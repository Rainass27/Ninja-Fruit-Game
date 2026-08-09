const { app, BrowserWindow, screen } = require('electron');
const path = require('path');
const { execSync } = require('child_process');

// Force close any stray cloudflared.exe zombie processes on startup to prevent port collisions / file locks
try {
  execSync('taskkill /F /IM cloudflared.exe', { stdio: 'ignore' });
} catch (e) {
  // Ignored (fails if no processes were running)
}

// Start the local Express/Socket.io server
require('./server.js');

function createWindow() {
  const primaryDisplay = screen.getPrimaryDisplay();
  const { width, height } = primaryDisplay.workAreaSize;

  const mainWindow = new BrowserWindow({
    width: width,
    height: height,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
    // Start with menu bar hidden
    autoHideMenuBar: true,
    title: "Neon Ninja"
  });

  // Load the lobby page from local express server once the port is established
  if (global.serverPort) {
    mainWindow.loadURL(`http://localhost:${global.serverPort}`);
  } else {
    global.onServerListening = (port) => {
      mainWindow.loadURL(`http://localhost:${port}`);
    };
  }

  // Maximize the main window
  mainWindow.maximize();
}

// When a new window is created (like clicking 'Open Game Screen')
app.on('browser-window-created', (event, window) => {
  // Maximize all new windows automatically
  window.maximize();
  // Hide menu bar for all windows
  window.setMenuBarVisibility(false);
  window.setAutoHideMenuBar(true);
});

app.whenReady().then(() => {
  createWindow();

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

// Quit the application and terminate the server when all windows are closed
app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit();
});

// Clean up background processes on application close
app.on('will-quit', () => {
  if (global.tunnelProcess) {
    console.log('Terminating cloudflared process...');
    try {
      global.tunnelProcess.kill('SIGINT');
    } catch (e) {
      console.error('Failed to kill tunnel process:', e);
    }
  }
});
