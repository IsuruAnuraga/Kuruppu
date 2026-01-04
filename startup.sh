#!/bin/bash
# Azure startup script - Build and serve the app

# Set PORT if not set
export PORT=${PORT:-8080}

# Check if dist folder exists, if not, build it
if [ ! -d "dist" ]; then
  echo "Dist folder not found, building application..."
  npm install
  npm run build
fi

# Verify dist folder exists
if [ ! -d "dist" ]; then
  echo "ERROR: dist folder still not found after build attempt!"
  exit 1
fi

# Start the server
echo "Starting server on port $PORT..."
npm start

