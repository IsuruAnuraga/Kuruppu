#!/bin/bash
# Azure startup script - Serve the built app
# Note: Azure should build the app during deployment, this script just serves it

# Azure sets PORT automatically, but set default if not set
export PORT=${PORT:-8080}

# Verify dist folder exists
if [ ! -d "dist" ]; then
  echo "ERROR: dist folder not found! Make sure the app is built during deployment."
  echo "Building application..."
  npm install
  npm run build
fi

# Verify dist folder exists after build attempt
if [ ! -d "dist" ]; then
  echo "ERROR: dist folder not found after build!"
  exit 1
fi

# Start the server
echo "Starting server on port $PORT..."
exec npm start

