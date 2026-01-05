#!/usr/bin/env node
import { spawn } from 'child_process';

const port = process.env.PORT || '8080';
const serve = spawn('serve', ['-s', 'dist', '-l', port], {
  stdio: 'inherit',
  shell: true
});

serve.on('error', (err) => {
  console.error('Failed to start server:', err);
  process.exit(1);
});

serve.on('exit', (code) => {
  process.exit(code || 0);
});

