#!/usr/bin/env node

/**
 * Environment Validation Script for SvelteKit Projects
 * 
 * This script validates that the current environment meets all requirements
 * for SvelteKit ^2.0.0 development with Svelte ^5.0.0
 */

import { readFileSync, existsSync } from 'fs';
import { execSync } from 'child_process';

// Version requirements
const REQUIREMENTS = {
  node: '20.0.0',
  pnpm: '10.0.0',
  svelte: '5.0.0',
  sveltekit: '2.0.0'
};

// Colors for terminal output
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  bold: '\x1b[1m'
};

function colorize(text, color) {
  return `${colors[color]}${text}${colors.reset}`;
}

function checkVersion(current, required) {
  const currentParts = current.replace('v', '').split('.').map(Number);
  const requiredParts = required.split('.').map(Number);
  
  for (let i = 0; i < Math.max(currentParts.length, requiredParts.length); i++) {
    const currentPart = currentParts[i] || 0;
    const requiredPart = requiredParts[i] || 0;
    
    if (currentPart > requiredPart) return true;
    if (currentPart < requiredPart) return false;
  }
  return true;
}

function getPackageVersion(packageName) {
  try {
    if (!existsSync('package.json')) {
      return null;
    }
    
    const packageJson = JSON.parse(readFileSync('package.json', 'utf8'));
    const version = packageJson.dependencies?.[packageName] || 
                   packageJson.devDependencies?.[packageName];
    
    return version;
  } catch (error) {
    return null;
  }
}

function checkNodeVersion() {
  try {
    const version = execSync('node --version', { encoding: 'utf8' }).trim();
    const meetsRequirement = checkVersion(version, REQUIREMENTS.node);
    
    return {
      name: 'Node.js',
      current: version,
      required: `^${REQUIREMENTS.node}`,
      status: meetsRequirement ? '✅' : '❌',
      meetsRequirement
    };
  } catch (error) {
    return {
      name: 'Node.js',
      current: 'Not installed',
      required: `^${REQUIREMENTS.node}`,
      status: '❌',
      meetsRequirement: false,
      error: error.message
    };
  }
}

function checkPnpmVersion() {
  try {
    const version = execSync('pnpm --version', { encoding: 'utf8' }).trim();
    const meetsRequirement = checkVersion(version, REQUIREMENTS.pnpm);
    
    return {
      name: 'pnpm',
      current: version,
      required: `^${REQUIREMENTS.pnpm}`,
      status: meetsRequirement ? '✅' : '❌',
      meetsRequirement
    };
  } catch (error) {
    return {
      name: 'pnpm',
      current: 'Not installed',
      required: `^${REQUIREMENTS.pnpm}`,
      status: '❌',
      meetsRequirement: false,
      error: error.message
    };
  }
}

function checkSvelteVersion() {
  const version = getPackageVersion('svelte');
  
  if (!version) {
    return {
      name: 'Svelte',
      current: 'Not found in package.json',
      required: `^${REQUIREMENTS.svelte}`,
      status: '❌',
      meetsRequirement: false
    };
  }
  
  const cleanVersion = version.replace(/^[\^~]/, '');
  const meetsRequirement = checkVersion(cleanVersion, REQUIREMENTS.svelte);
  
  return {
    name: 'Svelte',
    current: version,
    required: `^${REQUIREMENTS.svelte}`,
    status: meetsRequirement ? '✅' : '❌',
    meetsRequirement
  };
}

function checkSvelteKitVersion() {
  const version = getPackageVersion('@sveltejs/kit');
  
  if (!version) {
    return {
      name: 'SvelteKit',
      current: 'Not found in package.json',
      required: `^${REQUIREMENTS.sveltekit}`,
      status: '❌',
      meetsRequirement: false
    };
  }
  
  const cleanVersion = version.replace(/^[\^~]/, '');
  const meetsRequirement = checkVersion(cleanVersion, REQUIREMENTS.sveltekit);
  
  return {
    name: 'SvelteKit',
    current: version,
    required: `^${REQUIREMENTS.sveltekit}`,
    status: meetsRequirement ? '✅' : '❌',
    meetsRequirement
  };
}

function generateFixSuggestions(checks) {
  const suggestions = [];
  
  checks.forEach(check => {
    if (!check.meetsRequirement) {
      switch (check.name) {
        case 'Node.js':
          suggestions.push(`Upgrade Node.js to version ^${REQUIREMENTS.node} or later`);
          suggestions.push('Download from: https://nodejs.org/');
          break;
        case 'pnpm':
          suggestions.push(`Install or upgrade pnpm to version ^${REQUIREMENTS.pnpm}`);
          suggestions.push('Run: npm install -g pnpm@latest');
          break;
        case 'Svelte':
          suggestions.push(`Update Svelte to version ^${REQUIREMENTS.svelte}`);
          suggestions.push('Run: pnpm add svelte@^5.0.0');
          break;
        case 'SvelteKit':
          suggestions.push(`Update SvelteKit to version ^${REQUIREMENTS.sveltekit}`);
          suggestions.push('Run: pnpm add @sveltejs/kit@^2.0.0');
          break;
      }
    }
  });
  
  return suggestions;
}

function main() {
  console.log(colorize('🔍 Environment Validation for SvelteKit Development', 'bold'));
  console.log(colorize('='.repeat(60), 'blue'));
  console.log();
  
  const checks = [
    checkNodeVersion(),
    checkPnpmVersion(),
    checkSvelteVersion(),
    checkSvelteKitVersion()
  ];
  
  // Display results
  console.log(colorize('Version Check Results:', 'bold'));
  checks.forEach(check => {
    const statusColor = check.meetsRequirement ? 'green' : 'red';
    console.log(`${check.status} ${check.name}: ${colorize(check.current, statusColor)} (required: ${check.required})`);
    
    if (check.error) {
      console.log(`   ${colorize('Error: ' + check.error, 'yellow')}`);
    }
  });
  
  console.log();
  
  // Overall status
  const allMeetRequirements = checks.every(check => check.meetsRequirement);
  
  if (allMeetRequirements) {
    console.log(colorize('🎉 Overall: ✅ Ready for SvelteKit development', 'green'));
    console.log(colorize('Your environment meets all requirements!', 'green'));
  } else {
    console.log(colorize('⚠️  Overall: ❌ Environment needs attention', 'red'));
    console.log();
    
    const suggestions = generateFixSuggestions(checks);
    if (suggestions.length > 0) {
      console.log(colorize('Suggested fixes:', 'bold'));
      suggestions.forEach((suggestion, index) => {
        console.log(`${index + 1}. ${suggestion}`);
      });
    }
  }
  
  console.log();
  console.log(colorize('Compatibility Matrix:', 'bold'));
  console.log(`Node.js ^${REQUIREMENTS.node} + Svelte ^${REQUIREMENTS.svelte} + SvelteKit ^${REQUIREMENTS.sveltekit} = ✅ Compatible`);
  
  // Exit with appropriate code
  process.exit(allMeetRequirements ? 0 : 1);
}

// Run the validation
main();
