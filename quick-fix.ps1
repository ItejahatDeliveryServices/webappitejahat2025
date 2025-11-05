# Quick Fix Script for VS Code Errors (PowerShell)
# This script applies common fixes for VS Code error issues

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "VS Code Error Quick Fix Script (PowerShell)" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

# Ask user which fix to apply
Write-Host ""
Write-Host "Select a fix option:"
Write-Host "1) Reinstall node_modules (recommended)"
Write-Host "2) Clear VS Code cache"
Write-Host "3) Run diagnostic tool only"
Write-Host "4) Full reset (reinstall + cache clear)"
Write-Host "5) Exit"
Write-Host ""

$option = Read-Host "Enter option (1-5)"

switch ($option) {
    "1" {
        Write-Host "▶ Removing node_modules..." -ForegroundColor Yellow
        
        if (Test-Path "node_modules") { Remove-Item -Recurse -Force "node_modules" }
        if (Test-Path "package-lock.json") { Remove-Item -Force "package-lock.json" }
        if (Test-Path "yarn.lock") { Remove-Item -Force "yarn.lock" }
        if (Test-Path "pnpm-lock.yaml") { Remove-Item -Force "pnpm-lock.yaml" }
        
        Write-Host "✓ Removed node_modules and lock files" -ForegroundColor Green
        
        if (Test-Path "package.json") {
            Write-Host "▶ Installing dependencies..." -ForegroundColor Yellow
            npm install
            Write-Host "✓ Dependencies installed" -ForegroundColor Green
        } else {
            Write-Host "⚠ No package.json found. Skipping npm install." -ForegroundColor Yellow
        }
    }
    "2" {
        Write-Host "▶ Clearing VS Code cache..." -ForegroundColor Yellow
        
        $cachePaths = @(
            "$env:APPDATA\Code\Cache",
            "$env:APPDATA\Code\CachedData",
            "$env:APPDATA\Code\CachedExtensions"
        )
        
        foreach ($path in $cachePaths) {
            if (Test-Path $path) {
                Remove-Item -Recurse -Force $path
                Write-Host "✓ Cleared: $path" -ForegroundColor Green
            }
        }
        
        Write-Host "✓ VS Code cache cleared" -ForegroundColor Green
        Write-Host "▶ Please restart VS Code" -ForegroundColor Yellow
    }
    "3" {
        Write-Host "▶ Running diagnostic tool..." -ForegroundColor Yellow
        if (Test-Path "diagnose-errors.js") {
            node diagnose-errors.js
        } else {
            Write-Host "✗ diagnose-errors.js not found in current directory" -ForegroundColor Red
            exit 1
        }
    }
    "4" {
        Write-Host "▶ Performing full reset..." -ForegroundColor Yellow
        
        # Remove node_modules
        Write-Host "▶ Removing node_modules..." -ForegroundColor Yellow
        if (Test-Path "node_modules") { Remove-Item -Recurse -Force "node_modules" }
        if (Test-Path "package-lock.json") { Remove-Item -Force "package-lock.json" }
        if (Test-Path "yarn.lock") { Remove-Item -Force "yarn.lock" }
        if (Test-Path "pnpm-lock.yaml") { Remove-Item -Force "pnpm-lock.yaml" }
        
        # Clear cache
        Write-Host "▶ Clearing VS Code cache..." -ForegroundColor Yellow
        $cachePaths = @(
            "$env:APPDATA\Code\Cache",
            "$env:APPDATA\Code\CachedData",
            "$env:APPDATA\Code\CachedExtensions"
        )
        
        foreach ($path in $cachePaths) {
            if (Test-Path $path) {
                Remove-Item -Recurse -Force $path
            }
        }
        
        # Reinstall
        if (Test-Path "package.json") {
            Write-Host "▶ Installing dependencies..." -ForegroundColor Yellow
            npm install
        }
        
        Write-Host "✓ Full reset complete!" -ForegroundColor Green
        Write-Host "▶ Please restart VS Code" -ForegroundColor Yellow
    }
    "5" {
        Write-Host "Exiting..." -ForegroundColor Cyan
        exit 0
    }
    default {
        Write-Host "✗ Invalid option" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Fix applied! Next steps:" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Restart VS Code"
Write-Host "2. In VS Code, press Ctrl+Shift+P"
Write-Host "3. Type: 'TypeScript: Restart TS Server'"
Write-Host "4. Check the Problems panel (Ctrl+Shift+M)"
Write-Host ""
Write-Host "If issues persist, see:"
Write-Host "- TROUBLESHOOTING_AR.md (Arabic)"
Write-Host "- TROUBLESHOOTING_EN.md (English)"
Write-Host ""
