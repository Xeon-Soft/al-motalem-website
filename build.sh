#!/bin/bash

# # Install Flutter (Vercel has limited support, better to use GitHub Actions)
# echo "Building Flutter web..."

# # Get dependencies
# flutter pub get

# # Build for web
# flutter build web --release

# # Copy API functions to build output
# mkdir -p build/web/api
# cp -r api/ build/web/

# echo "✅ Build complete"
git add . && git commit -m "Debug: add verbose to flutter pub get" && git push origin main