# دليل الإعداد والبدء / Setup Guide

[العربية](#دليل-الإعداد-بالعربية) | [English](#setup-guide-in-english)

---

## دليل الإعداد بالعربية

### إذا كان لديك كود به أخطاء (354 خطأ أو أكثر)

#### الخطوة 1: تشخيص المشكلة
```bash
# قم بتشغيل أداة التشخيص
node diagnose-errors.js
```

هذا الأمر سيفحص مشروعك ويخبرك بالمشاكل المحتملة.

#### الخطوة 2: تطبيق الحلول السريعة

**إذا كانت المشكلة: مكتبات مفقودة**
```bash
npm install
```

**إذا كانت المشكلة: ذاكرة تخزين مؤقتة تالفة**
```bash
# على Windows
rmdir /s /q node_modules
rmdir /s /q package-lock.json
npm install

# على Linux/Mac
rm -rf node_modules
rm -rf package-lock.json
npm install
```

**إذا كانت المشكلة: خادم TypeScript لا يستجيب**
1. في VS Code: اضغط `Ctrl + Shift + P`
2. اكتب: `TypeScript: Restart TS Server`
3. اضغط Enter

#### الخطوة 3: تحديد الأخطاء الفعلية

1. افتح لوحة المشاكل: `Ctrl + Shift + M`
2. انقر على أول خطأ
3. افحص الملف الذي يحتوي على الخطأ
4. في أغلب الأحيان، سيكون هناك خطأ واحد رئيسي يسبب بقية الأخطاء

#### الخطوة 4: إصلاح الأخطاء الشائعة

**أقواس غير متطابقة:**
```javascript
// خطأ
function test() {
  console.log("Hello"
}

// صحيح
function test() {
  console.log("Hello");
}
```

**علامات اقتباس غير متطابقة:**
```javascript
// خطأ
const name = "John';

// صحيح
const name = "John";
// أو
const name = 'John';
```

**فاصلة منقوطة مفقودة (في بعض الحالات):**
```javascript
// قد يسبب مشاكل
const x = 5
const y = 10

// أفضل
const x = 5;
const y = 10;
```

### إذا كنت تبدأ مشروعاً جديداً

#### لمشروع React
```bash
npx create-react-app my-app
cd my-app
npm start
```

#### لمشروع Next.js
```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

#### لمشروع Vue.js
```bash
npm create vue@latest my-app
cd my-app
npm install
npm run dev
```

#### لمشروع Node.js بسيط
```bash
npm init -y
npm install express
```

#### لمشروع TypeScript
```bash
npm init -y
npm install -D typescript @types/node
npx tsc --init
```

### نصائح مهمة

1. **استخدم أسماء إنجليزية للملفات والمجلدات** - تجنب الأحرف العربية في الأسماء
2. **تجنب المسافات في الأسماء** - استخدم `-` أو `_` بدلاً من المسافات
3. **حافظ على تحديث المكتبات** - قم بتحديث المكتبات بانتظام
4. **استخدم Git** - احفظ تغييراتك بانتظام باستخدام Git

### ملفات التكوين المهمة

هذا المشروع يحتوي الآن على:
- ✓ `.vscode/settings.json` - إعدادات VS Code
- ✓ `.editorconfig` - إعدادات المحرر
- ✓ `.gitignore` - ملفات يتم تجاهلها
- ✓ `jsconfig.json` - إعدادات JavaScript
- ✓ `tsconfig.json` - إعدادات TypeScript
- ✓ `diagnose-errors.js` - أداة التشخيص

---

## Setup Guide in English

### If You Have Code with Errors (354 or More Errors)

#### Step 1: Diagnose the Problem
```bash
# Run the diagnostic tool
node diagnose-errors.js
```

This will scan your project and tell you about potential issues.

#### Step 2: Apply Quick Fixes

**If the problem is: Missing libraries**
```bash
npm install
```

**If the problem is: Corrupted cache**
```bash
# On Windows
rmdir /s /q node_modules
rmdir /s /q package-lock.json
npm install

# On Linux/Mac
rm -rf node_modules
rm -rf package-lock.json
npm install
```

**If the problem is: TypeScript server not responding**
1. In VS Code: Press `Ctrl + Shift + P`
2. Type: `TypeScript: Restart TS Server`
3. Press Enter

#### Step 3: Identify Actual Errors

1. Open Problems panel: `Ctrl + Shift + M`
2. Click on the first error
3. Examine the file containing the error
4. Often, there will be one main error causing the rest

#### Step 4: Fix Common Errors

**Mismatched brackets:**
```javascript
// Wrong
function test() {
  console.log("Hello"
}

// Correct
function test() {
  console.log("Hello");
}
```

**Mismatched quotes:**
```javascript
// Wrong
const name = "John';

// Correct
const name = "John";
// or
const name = 'John';
```

**Missing semicolon (in some cases):**
```javascript
// May cause issues
const x = 5
const y = 10

// Better
const x = 5;
const y = 10;
```

### If You're Starting a New Project

#### For React Project
```bash
npx create-react-app my-app
cd my-app
npm start
```

#### For Next.js Project
```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

#### For Vue.js Project
```bash
npm create vue@latest my-app
cd my-app
npm install
npm run dev
```

#### For Simple Node.js Project
```bash
npm init -y
npm install express
```

#### For TypeScript Project
```bash
npm init -y
npm install -D typescript @types/node
npx tsc --init
```

### Important Tips

1. **Use English names for files and folders** - Avoid Arabic characters in names
2. **Avoid spaces in names** - Use `-` or `_` instead of spaces
3. **Keep libraries updated** - Update packages regularly
4. **Use Git** - Save your changes regularly using Git

### Important Configuration Files

This project now includes:
- ✓ `.vscode/settings.json` - VS Code settings
- ✓ `.editorconfig` - Editor settings
- ✓ `.gitignore` - Files to ignore
- ✓ `jsconfig.json` - JavaScript settings
- ✓ `tsconfig.json` - TypeScript settings
- ✓ `diagnose-errors.js` - Diagnostic tool

### Need More Help?

See the detailed troubleshooting guides:
- Arabic: `TROUBLESHOOTING_AR.md`
- English: `TROUBLESHOOTING_EN.md`
