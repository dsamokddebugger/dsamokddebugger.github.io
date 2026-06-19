# Build the Flutter Web project
Write-Host "Building Flutter Web application..." -ForegroundColor Cyan
Push-Location src
flutter build web --release --base-href "/"
Pop-Location

Write-Host "Copying build output to the repository root..." -ForegroundColor Cyan

# Copy built files and directories recursively
Copy-Item -Path "src/build/web/assets" -Destination "." -Recurse -Force
Copy-Item -Path "src/build/web/canvaskit" -Destination "." -Recurse -Force
Copy-Item -Path "src/build/web/icons" -Destination "." -Recurse -Force
Copy-Item -Path "src/build/web/favicon.png" -Destination "." -Force
Copy-Item -Path "src/build/web/flutter.js" -Destination "." -Force
Copy-Item -Path "src/build/web/flutter_bootstrap.js" -Destination "." -Force
Copy-Item -Path "src/build/web/flutter_service_worker.js" -Destination "." -Force
Copy-Item -Path "src/build/web/index.html" -Destination "." -Force
Copy-Item -Path "src/build/web/main.dart.js" -Destination "." -Force
Copy-Item -Path "src/build/web/manifest.json" -Destination "." -Force
Copy-Item -Path "src/build/web/version.json" -Destination "." -Force

Write-Host "Creating routing wrapper files..." -ForegroundColor Cyan

# Copy index.html to serve as wrappers for direct URL landing pages
Copy-Item -Path "src/build/web/index.html" -Destination "nu.html" -Force
Copy-Item -Path "src/build/web/index.html" -Destination "flux.html" -Force
Copy-Item -Path "src/build/web/index.html" -Destination "amber.html" -Force
Copy-Item -Path "src/build/web/index.html" -Destination "omni.html" -Force
Copy-Item -Path "src/build/web/index.html" -Destination "chess-academy.html" -Force

Write-Host "Cleaning up old CSS files..." -ForegroundColor Cyan

# Remove original unused CSS files
Remove-Item -Path "index.css" -ErrorAction SilentlyContinue
Remove-Item -Path "nu.css" -ErrorAction SilentlyContinue
Remove-Item -Path "flux.css" -ErrorAction SilentlyContinue

Write-Host "Build and deployment copy completed successfully!" -ForegroundColor Green
