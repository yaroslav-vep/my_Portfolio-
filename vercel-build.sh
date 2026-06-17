#!/bin/bash
# Clone Flutter stable branch with depth 1 for faster download
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
else
  echo "Flutter SDK already exists. Updating..."
  cd flutter && git pull && cd ..
fi

# Add Flutter to the PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Run doctor to verify environment
flutter doctor

# Enable Web support
flutter config --enable-web

# Run Flutter Clean
flutter clean

# Get dependencies
flutter pub get

# Build the web application
flutter build web --release
