#!/bin/bash
# Azure startup script - Build and serve the app

# Check if dist folder exists, if not, build it
if [ ! -d "dist" ]; then
  echo "Dist folder not found, building application..."
  npm install
  npm run build
fi

# Start the server
echo "Starting server..."
npm start

