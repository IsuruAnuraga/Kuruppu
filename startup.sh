#!/bin/bash
# Azure startup script - Serve the built app
# Azure builds the app during deployment (SCM_DO_BUILD_DURING_DEPLOYMENT = true)

# Azure sets PORT automatically
export PORT=${PORT:-8080}

# Verify dist folder exists (should exist if build during deployment is enabled)
if [ ! -d "dist" ]; then
  echo "ERROR: dist folder not found!"
  echo "Make sure SCM_DO_BUILD_DURING_DEPLOYMENT is set to 'true' in app settings"
  exit 1
fi

# Verify health.json exists in dist
if [ ! -f "dist/health.json" ]; then
  echo "WARNING: health.json not found in dist folder"
  # Copy health.json from public if it exists
  if [ -f "public/health.json" ]; then
    cp public/health.json dist/health.json
    echo "Copied health.json from public to dist"
  fi
fi

# Start the server
# serve defaults to 0.0.0.0, so just specify the port
echo "Starting server on port $PORT..."
echo "Health check endpoint: http://localhost:$PORT/health.json"
exec npx serve -s dist -l $PORT

