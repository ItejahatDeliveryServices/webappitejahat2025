# DEPLOY.md

## المشكلة:
الملفات مقفلة لأن Next.js يعمل في الخلفية.

## الحل السريع:
افتح PowerShell جديد كمسؤول وشغل:

### 1. أوقف جميع عمليات Node
```powershell
taskkill /F /IM node.exe
```

### 2. انتقل للمجلد
```powershell
cd "C:\Users\c9mq\OneDrive\Desktop\AUGMENT SYSTIM\itejahat-webapp"
```

### 3. احذف المجلدات القديمة
```powershell
rmdir /s /q node_modules
rmdir /s /q .next
```

### 4. ثبت من جديد
```powershell
npm install --legacy-peer-deps
```

### 5. شغل التطبيق
```powershell
npm run dev
```

## للنشر على الإنترنت:
### الطريقة الأسهل:

1. اذهب إلى https://vercel.com/new
2. ارفع المجلد أو اربطه بـ GitHub
3. أضف متغيرات البيئة من .env.local
4. اضغط Deploy

**ملف التعليمات الكامل: FIX_AND_DEPLOY.md**