# مرجع سريع / Quick Reference

## 🚀 حل سريع للأخطاء / Quick Fix for Errors

### طريقة سريعة (3 دقائق) / Quick Method (3 minutes)

```bash
# تشغيل أداة الإصلاح السريع / Run quick fix tool
# ويندوز / Windows:
.\quick-fix.ps1

# لينكس/ماك / Linux/Mac:
./quick-fix.sh
```

### طريقة يدوية / Manual Method

```bash
# 1. تشخيص المشكلة / Diagnose the problem
node diagnose-errors.js

# 2. إعادة تثبيت المكتبات / Reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# 3. في VS Code: اضغط / In VS Code: Press
# Ctrl+Shift+P
# ثم اكتب / Then type: TypeScript: Restart TS Server
```

## 🔍 أين الأخطاء؟ / Where are the errors?

### في VS Code:
1. اضغط **Ctrl + Shift + M** لفتح لوحة المشاكل
2. انقر على أول خطأ
3. غالباً يكون خطأ واحد يسبب البقية

### In VS Code:
1. Press **Ctrl + Shift + M** to open Problems panel
2. Click on the first error
3. Often one error causes the rest

## 🛠️ أدوات متاحة / Available Tools

| الأداة / Tool | الأمر / Command | الوصف / Description |
|--------------|----------------|-------------------|
| التشخيص / Diagnostic | `node diagnose-errors.js` | يفحص المشروع / Scans project |
| إصلاح سريع / Quick Fix | `./quick-fix.sh` أو `.\quick-fix.ps1` | إصلاحات تلقائية / Auto fixes |
| npm تشخيص / npm diagnose | `npm run diagnose` | نفس أداة التشخيص / Same as diagnostic |

## 📝 الأخطاء الشائعة / Common Errors

### 1. أقواس غير متطابقة / Mismatched Brackets
```javascript
// ❌ خطأ / Wrong
function test() {
  console.log("Hello"
}

// ✅ صحيح / Correct
function test() {
  console.log("Hello");
}
```

### 2. علامات اقتباس / Quotes
```javascript
// ❌ خطأ / Wrong
const name = "Ahmed';

// ✅ صحيح / Correct
const name = "Ahmed";
```

### 3. فاصلة منقوطة / Semicolon
```javascript
// ⚠️ قد يسبب مشاكل / May cause issues
const x = 5
const y = 10

// ✅ أفضل / Better
const x = 5;
const y = 10;
```

### 4. استيراد خاطئ / Wrong Import
```javascript
// ❌ خطأ / Wrong
import { Button } from './Button'  // ملف غير موجود / File doesn't exist

// ✅ صحيح / Correct
import { Button } from './Button.jsx'  // الملف موجود / File exists
```

## 🔧 إعدادات VS Code / VS Code Settings

### إعادة تشغيل خادم TypeScript / Restart TypeScript Server
1. **Ctrl + Shift + P**
2. اكتب / Type: `TypeScript: Restart TS Server`
3. **Enter**

### تعطيل الإضافات / Disable Extensions
1. **Ctrl + Shift + X**
2. عطّل جميع الإضافات / Disable all extensions
3. أعد تشغيل VS Code / Restart VS Code
4. فعّل واحدة تلو الأخرى / Enable one by one

### مسح الذاكرة المؤقتة / Clear Cache
```bash
# ويندوز / Windows (PowerShell)
Remove-Item -Recurse -Force "$env:APPDATA\Code\Cache"

# لينكس/ماك / Linux/Mac
rm -rf ~/.config/Code/Cache
```

## 📚 الوثائق الكاملة / Full Documentation

| الملف / File | المحتوى / Content |
|-------------|------------------|
| [TROUBLESHOOTING_AR.md](./TROUBLESHOOTING_AR.md) | دليل شامل بالعربية / Complete guide in Arabic |
| [TROUBLESHOOTING_EN.md](./TROUBLESHOOTING_EN.md) | Complete guide in English |
| [SETUP_GUIDE.md](./SETUP_GUIDE.md) | دليل الإعداد / Setup guide (bilingual) |
| [README.md](./README.md) | نظرة عامة / Overview |

## 💡 نصائح / Tips

✅ **افعل / Do:**
- استخدم أسماء إنجليزية للملفات / Use English file names
- احفظ بانتظام / Save regularly  
- استخدم Git / Use Git
- تحقق من الأقواس / Check brackets

❌ **لا تفعل / Don't:**
- أسماء عربية للملفات / Arabic file names
- مسافات في الأسماء / Spaces in names
- تجاهل التحذيرات / Ignore warnings
- حذف ملفات التكوين / Delete config files

## 🆘 لا تزال المشكلة؟ / Still Having Issues?

1. 📸 خذ صورة شاشة للأخطاء / Take error screenshot
2. 📋 انسخ أول 5 أخطاء / Copy first 5 errors
3. 🔍 افحص الملف الأول / Check first file
4. 📖 اقرأ الدليل الكامل / Read full guide

---

## 🎯 خطوات سريعة لمشروع جديد / Quick Steps for New Project

### React
```bash
npx create-react-app my-app
cd my-app
npm start
```

### Next.js
```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

### Vue.js
```bash
npm create vue@latest my-app
cd my-app
npm install
npm run dev
```

### Node.js
```bash
npm init -y
npm install express
```

---

**تم إنشاؤه بواسطة / Created by:** GitHub Copilot  
**للمساعدة / For Help:** راجع الملفات أعلاه / See files above
