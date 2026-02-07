#!/bin/bash

# Environment Validation Script for SvelteKit Projects
# Shell version for environments without Node.js or for quick checks

set -e

# Version requirements
NODE_MIN="20.0.0"
PNPM_MIN="10.0.0"
SVELTE_MIN="5.0.0"
KIT_MIN="2.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Version comparison function
version_compare() {
    local current=$1
    local required=$2
    
    # Remove 'v' prefix if present
    current=${current#v}
    
    # Split version numbers
    IFS='.' read -ra CURRENT_PARTS <<< "$current"
    IFS='.' read -ra REQUIRED_PARTS <<< "$required"
    
    # Compare each part
    for i in {0..2}; do
        local current_part=${CURRENT_PARTS[i]:-0}
        local required_part=${REQUIRED_PARTS[i]:-0}
        
        if (( current_part > required_part )); then
            return 0  # Current version is higher
        elif (( current_part < required_part )); then
            return 1  # Current version is lower
        fi
    done
    
    return 0  # Versions are equal
}

# Check Node.js
check_node() {
    if command -v node &> /dev/null; then
        local version=$(node --version 2>/dev/null || echo "unknown")
        if version_compare "$version" "$NODE_MIN"; then
            echo -e "✅ Node.js: ${GREEN}$version${NC} (required: ^$NODE_MIN)"
            return 0
        else
            echo -e "❌ Node.js: ${RED}$version${NC} (required: ^$NODE_MIN)"
            return 1
        fi
    else
        echo -e "❌ Node.js: ${RED}Not installed${NC} (required: ^$NODE_MIN)"
        return 1
    fi
}

# Check pnpm
check_pnpm() {
    if command -v pnpm &> /dev/null; then
        local version=$(pnpm --version 2>/dev/null || echo "unknown")
        if version_compare "$version" "$PNPM_MIN"; then
            echo -e "✅ pnpm: ${GREEN}$version${NC} (required: ^$PNPM_MIN)"
            return 0
        else
            echo -e "❌ pnpm: ${RED}$version${NC} (required: ^$PNPM_MIN)"
            return 1
        fi
    else
        echo -e "❌ pnpm: ${RED}Not installed${NC} (required: ^$PNPM_MIN)"
        return 1
    fi
}

# Check Svelte from package.json
check_svelte() {
    if [ -f "package.json" ]; then
        local version=$(grep -o '"svelte":\s*"[^"]*"' package.json | sed 's/.*"svelte":\s*"\([^"]*\)".*/\1/' || echo "")
        if [ -n "$version" ]; then
            local clean_version=$(echo "$version" | sed 's/^[^0-9]*//' | sed 's/[^0-9.]*$//')
            if version_compare "$clean_version" "$SVELTE_MIN"; then
                echo -e "✅ Svelte: ${GREEN}$version${NC} (required: ^$SVELTE_MIN)"
                return 0
            else
                echo -e "❌ Svelte: ${RED}$version${NC} (required: ^$SVELTE_MIN)"
                return 1
            fi
        else
            echo -e "❌ Svelte: ${RED}Not found in package.json${NC} (required: ^$SVELTE_MIN)"
            return 1
        fi
    else
        echo -e "❌ Svelte: ${RED}package.json not found${NC} (required: ^$SVELTE_MIN)"
        return 1
    fi
}

# Check SvelteKit from package.json
check_sveltekit() {
    if [ -f "package.json" ]; then
        local version=$(grep -o '"@sveltejs/kit":\s*"[^"]*"' package.json | sed 's/.*"@sveltejs\/kit":\s*"\([^"]*\)".*/\1/' || echo "")
        if [ -n "$version" ]; then
            local clean_version=$(echo "$version" | sed 's/^[^0-9]*//' | sed 's/[^0-9.]*$//')
            if version_compare "$clean_version" "$KIT_MIN"; then
                echo -e "✅ SvelteKit: ${GREEN}$version${NC} (required: ^$KIT_MIN)"
                return 0
            else
                echo -e "❌ SvelteKit: ${RED}$version${NC} (required: ^$KIT_MIN)"
                return 1
            fi
        else
            echo -e "❌ SvelteKit: ${RED}Not found in package.json${NC} (required: ^$KIT_MIN)"
            return 1
        fi
    else
        echo -e "❌ SvelteKit: ${RED}package.json not found${NC} (required: ^$KIT_MIN)"
        return 1
    fi
}

# Generate fix suggestions
generate_fixes() {
    echo -e "\n${BOLD}Suggested fixes:${NC}"
    
    if ! check_node >/dev/null 2>&1; then
        echo "1. Upgrade Node.js to version ^$NODE_MIN or later"
        echo "   Download from: https://nodejs.org/"
    fi
    
    if ! check_pnpm >/dev/null 2>&1; then
        echo "2. Install or upgrade pnpm to version ^$PNPM_MIN"
        echo "   Run: npm install -g pnpm@latest"
    fi
    
    if ! check_svelte >/dev/null 2>&1; then
        echo "3. Update Svelte to version ^$SVELTE_MIN"
        echo "   Run: pnpm add svelte@^5.0.0"
    fi
    
    if ! check_sveltekit >/dev/null 2>&1; then
        echo "4. Update SvelteKit to version ^$KIT_MIN"
        echo "   Run: pnpm add @sveltejs/kit@^2.0.0"
    fi
}

# Main validation
main() {
    echo -e "${BOLD}🔍 Environment Validation for SvelteKit Development${NC}"
    echo -e "${BLUE}============================================================${NC}"
    echo
    
    local node_ok=0
    local pnpm_ok=0
    local svelte_ok=0
    local kit_ok=0
    
    # Run checks
    check_node && node_ok=1 || node_ok=0
    check_pnpm && pnpm_ok=1 || pnpm_ok=0
    check_svelte && svelte_ok=1 || svelte_ok=0
    check_sveltekit && kit_ok=1 || kit_ok=0
    
    echo
    
    # Overall status
    if (( node_ok && pnpm_ok && svelte_ok && kit_ok )); then
        echo -e "${GREEN}🎉 Overall: ✅ Ready for SvelteKit development${NC}"
        echo -e "${GREEN}Your environment meets all requirements!${NC}"
        echo
        echo -e "${BOLD}Compatibility Matrix:${NC}"
        echo "Node.js ^$NODE_MIN + Svelte ^$SVELTE_MIN + SvelteKit ^$KIT_MIN = ✅ Compatible"
        exit 0
    else
        echo -e "${RED}⚠️  Overall: ❌ Environment needs attention${NC}"
        generate_fixes
        echo
        echo -e "${BOLD}Compatibility Matrix:${NC}"
        echo "Node.js ^$NODE_MIN + Svelte ^$SVELTE_MIN + SvelteKit ^$KIT_MIN = ✅ Compatible"
        exit 1
    fi
}

# Run main function
main "$@"
