#!/bin/bash

# Quick Fix Script for VS Code Errors
# This script applies common fixes for VS Code error issues

echo "=================================================="
echo "VS Code Error Quick Fix Script"
echo "=================================================="
echo ""

# Function to print colored output
print_status() {
    echo "▶ $1"
}

print_success() {
    echo "✓ $1"
}

print_error() {
    echo "✗ $1"
}

print_warning() {
    echo "⚠ $1"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed!"
    echo "Please install Node.js from: https://nodejs.org/"
    exit 1
fi

print_success "Node.js is installed: $(node --version)"

# Ask user which fix to apply
echo ""
echo "Select a fix option:"
echo "1) Reinstall node_modules (recommended)"
echo "2) Clear VS Code cache"
echo "3) Run diagnostic tool only"
echo "4) Full reset (reinstall + cache clear)"
echo "5) Exit"
echo ""
read -p "Enter option (1-5): " option

case $option in
    1)
        print_status "Removing node_modules..."
        rm -rf node_modules package-lock.json yarn.lock pnpm-lock.yaml
        print_success "Removed node_modules and lock files"
        
        if [ -f "package.json" ]; then
            print_status "Installing dependencies..."
            npm install
            print_success "Dependencies installed"
        else
            print_warning "No package.json found. Skipping npm install."
        fi
        ;;
    2)
        print_status "Clearing VS Code cache..."
        
        # Linux/Mac
        if [ -d "$HOME/.config/Code" ]; then
            rm -rf "$HOME/.config/Code/Cache"
            rm -rf "$HOME/.config/Code/CachedData"
            rm -rf "$HOME/.config/Code/CachedExtensions"
            print_success "VS Code cache cleared (Linux/Mac)"
        fi
        
        # Mac alternative location
        if [ -d "$HOME/Library/Application Support/Code" ]; then
            rm -rf "$HOME/Library/Application Support/Code/Cache"
            rm -rf "$HOME/Library/Application Support/Code/CachedData"
            rm -rf "$HOME/Library/Application Support/Code/CachedExtensions"
            print_success "VS Code cache cleared (Mac)"
        fi
        
        print_status "Please restart VS Code"
        ;;
    3)
        print_status "Running diagnostic tool..."
        node diagnose-errors.js
        ;;
    4)
        print_status "Performing full reset..."
        
        # Remove node_modules
        print_status "Removing node_modules..."
        rm -rf node_modules package-lock.json yarn.lock pnpm-lock.yaml
        
        # Clear cache
        print_status "Clearing VS Code cache..."
        if [ -d "$HOME/.config/Code" ]; then
            rm -rf "$HOME/.config/Code/Cache"
            rm -rf "$HOME/.config/Code/CachedData"
        fi
        if [ -d "$HOME/Library/Application Support/Code" ]; then
            rm -rf "$HOME/Library/Application Support/Code/Cache"
            rm -rf "$HOME/Library/Application Support/Code/CachedData"
        fi
        
        # Reinstall
        if [ -f "package.json" ]; then
            print_status "Installing dependencies..."
            npm install
        fi
        
        print_success "Full reset complete!"
        print_status "Please restart VS Code"
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        print_error "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "=================================================="
echo "Fix applied! Next steps:"
echo "=================================================="
echo ""
echo "1. Restart VS Code"
echo "2. In VS Code, press Ctrl+Shift+P"
echo "3. Type: 'TypeScript: Restart TS Server'"
echo "4. Check the Problems panel (Ctrl+Shift+M)"
echo ""
echo "If issues persist, see:"
echo "- TROUBLESHOOTING_AR.md (Arabic)"
echo "- TROUBLESHOOTING_EN.md (English)"
echo ""
