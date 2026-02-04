#!/bin/bash

# Script to check if TailwindCSS v4 is installed in the current project

echo "🔍 Checking TailwindCSS installation..."

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "❌ No package.json found in current directory"
    exit 1
fi

# Check for tailwindcss dependency
echo "📦 Checking package.json for TailwindCSS..."
if grep -q "tailwindcss" package.json; then
    echo "✅ TailwindCSS found in package.json"
    
    # Extract version information
    TAILWIND_VERSION=$(npm list tailwindcss --depth=0 2>/dev/null | grep tailwindcss | awk '{print $2}')
    
    if [ -z "$TAILWIND_VERSION" ]; then
        echo "⚠️  Could not determine installed version"
    else
        echo "📌 Installed version: $TAILWIND_VERSION"
        
        # Check if it's v4
        if [[ "$TAILWIND_VERSION" == ^4* ]] || [[ "$TAILWIND_VERSION" == 4* ]]; then
            echo "🎉 TailwindCSS v4 is installed!"
        else
            echo "⚠️  TailwindCSS v3 detected. Consider upgrading to v4"
        fi
    fi
else
    echo "❌ TailwindCSS not found in package.json"
    echo "💡 Install with: npm install -D tailwindcss@^4.0.0"
fi

# Check for common CSS files
echo ""
echo "📁 Checking for CSS files..."
CSS_FILES=("src/routes/layout.css" "app/globals.css" "src/css/global.css" "src/index.css" "src/app.css")

for file in "${CSS_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ Found: $file"
        
        # Check if TailwindCSS is imported
        if grep -q "@import.*tailwindcss" "$file"; then
            echo "🎯 TailwindCSS imported in $file"
        else
            echo "⚠️  TailwindCSS not imported in $file"
        fi
    fi
done

echo ""
echo "🔍 Installation check complete!"
