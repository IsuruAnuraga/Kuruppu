#!/usr/bin/env node
import { spawn } from 'child_process';
import { platform } from 'os';

const port = process.env.PORT || '8080';

console.log(`Starting server on port ${port}...`);
console.log(`PORT environment variable: ${process.env.PORT || 'not set, using default 8080'}`);

// Use npx serve which works cross-platform (Windows, Linux, macOS)
const serve = spawn('npx', ['serve', '-s', 'dist', '-l', port], {
  stdio: 'inherit',
  shell: platform() === 'win32' // Use shell on Windows
});

serve.on('error', (err) => {
  console.error('Failed to start server:', err);
  console.error('Make sure the serve package is installed: npm install');
  process.exit(1);
});

serve.on('exit', (code, signal) => {
  if (signal) {
    console.error(`Server was killed by signal: ${signal}`);
  } else if (code !== 0) {
    console.error(`Server exited with code: ${code}`);
  }
  process.exit(code || 0);
});

process.on('SIGTERM', () => {
  serve.kill('SIGTERM');
});

process.on('SIGINT', () => {
  serve.kill('SIGINT');
});

