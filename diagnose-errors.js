#!/usr/bin/env node
/**
 * VS Code Error Diagnostic Tool
 * This script helps identify common issues causing errors in VS Code
 */

const fs = require('fs');
const path = require('path');

console.log('='.repeat(60));
console.log('VS Code Error Diagnostic Tool');
console.log('='.repeat(60));
console.log();

const checks = [];

// Check 1: Node.js version
try {
  const nodeVersion = process.version;
  console.log(`✓ Node.js version: ${nodeVersion}`);
  checks.push({ name: 'Node.js', status: 'ok', message: nodeVersion });
} catch (error) {
  console.log('✗ Node.js check failed');
  checks.push({ name: 'Node.js', status: 'error', message: error.message });
}

// Check 2: package.json exists
try {
  if (fs.existsSync('package.json')) {
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    console.log(`✓ package.json found: ${pkg.name || 'unnamed project'}`);
    checks.push({ name: 'package.json', status: 'ok', message: 'Valid' });
  } else {
    console.log('⚠ No package.json found - create one if this is a Node.js project');
    checks.push({ name: 'package.json', status: 'warning', message: 'Not found' });
  }
} catch (error) {
  console.log(`✗ package.json is invalid: ${error.message}`);
  checks.push({ name: 'package.json', status: 'error', message: error.message });
}

// Check 3: node_modules exists
if (fs.existsSync('node_modules')) {
  console.log('✓ node_modules directory exists');
  checks.push({ name: 'node_modules', status: 'ok', message: 'Installed' });
} else {
  console.log('⚠ node_modules not found - run "npm install" to install dependencies');
  checks.push({ name: 'node_modules', status: 'warning', message: 'Run npm install' });
}

// Check 4: TypeScript/JavaScript config
const hasJsConfig = fs.existsSync('jsconfig.json');
const hasTsConfig = fs.existsSync('tsconfig.json');

if (hasJsConfig || hasTsConfig) {
  const configFile = hasTsConfig ? 'tsconfig.json' : 'jsconfig.json';
  try {
    JSON.parse(fs.readFileSync(configFile, 'utf8'));
    console.log(`✓ ${configFile} is valid`);
    checks.push({ name: configFile, status: 'ok', message: 'Valid' });
  } catch (error) {
    console.log(`✗ ${configFile} is invalid: ${error.message}`);
    checks.push({ name: configFile, status: 'error', message: error.message });
  }
} else {
  console.log('⚠ No jsconfig.json or tsconfig.json found');
  checks.push({ name: 'JS/TS Config', status: 'warning', message: 'Not found' });
}

// Check 5: Look for common syntax errors in JS/TS files
console.log('\n' + '-'.repeat(60));
console.log('Checking for common syntax issues...');
console.log('-'.repeat(60));

function checkDirectory(dir, depth = 0) {
  if (depth > 3) return; // Limit depth
  if (dir.includes('node_modules') || dir.includes('.git')) return;

  try {
    const files = fs.readdirSync(dir);
    for (const file of files) {
      const fullPath = path.join(dir, file);
      const stat = fs.statSync(fullPath);

      if (stat.isDirectory()) {
        checkDirectory(fullPath, depth + 1);
      } else if (/\.(js|jsx|ts|tsx)$/.test(file)) {
        try {
          const content = fs.readFileSync(fullPath, 'utf8');
          
          // Check for common issues
          const issues = [];
          
          // Check for mismatched brackets
          const openBraces = (content.match(/\{/g) || []).length;
          const closeBraces = (content.match(/\}/g) || []).length;
          if (openBraces !== closeBraces) {
            issues.push(`Mismatched curly braces: ${openBraces} open, ${closeBraces} close`);
          }

          const openParens = (content.match(/\(/g) || []).length;
          const closeParens = (content.match(/\)/g) || []).length;
          if (openParens !== closeParens) {
            issues.push(`Mismatched parentheses: ${openParens} open, ${closeParens} close`);
          }

          const openBrackets = (content.match(/\[/g) || []).length;
          const closeBrackets = (content.match(/\]/g) || []).length;
          if (openBrackets !== closeBrackets) {
            issues.push(`Mismatched square brackets: ${openBrackets} open, ${closeBrackets} close`);
          }

          if (issues.length > 0) {
            console.log(`\n⚠ Issues in ${fullPath}:`);
            issues.forEach(issue => console.log(`  - ${issue}`));
          }
        } catch (error) {
          console.log(`✗ Error reading ${fullPath}: ${error.message}`);
        }
      }
    }
  } catch (error) {
    // Ignore permission errors
  }
}

if (fs.existsSync('src')) {
  checkDirectory('src');
} else {
  checkDirectory('.');
}

// Summary
console.log('\n' + '='.repeat(60));
console.log('Summary:');
console.log('='.repeat(60));

const errors = checks.filter(c => c.status === 'error');
const warnings = checks.filter(c => c.status === 'warning');
const ok = checks.filter(c => c.status === 'ok');

console.log(`✓ Passed: ${ok.length}`);
console.log(`⚠ Warnings: ${warnings.length}`);
console.log(`✗ Errors: ${errors.length}`);

console.log('\n' + '='.repeat(60));
console.log('Recommendations:');
console.log('='.repeat(60));

if (errors.length > 0) {
  console.log('\n❗ Fix these errors first:');
  errors.forEach(e => console.log(`  - ${e.name}: ${e.message}`));
}

if (warnings.length > 0) {
  console.log('\n⚠ Address these warnings:');
  warnings.forEach(w => console.log(`  - ${w.name}: ${w.message}`));
}

if (errors.length === 0 && warnings.length === 0) {
  console.log('\n✓ All checks passed!');
  console.log('\nIf you still see errors in VS Code:');
  console.log('1. Restart VS Code');
  console.log('2. Run: Ctrl+Shift+P > "TypeScript: Restart TS Server"');
  console.log('3. Check the Problems panel (Ctrl+Shift+M) for specific errors');
  console.log('4. Try disabling VS Code extensions one by one');
}

console.log('\n' + '='.repeat(60));
console.log('For more help, see TROUBLESHOOTING_AR.md or TROUBLESHOOTING_EN.md');
console.log('='.repeat(60));
