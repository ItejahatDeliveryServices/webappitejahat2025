@echo off
echo 🚀 بدء إصلاح مشكلة EBUSY: resource busy or locked...

echo.
echo 💡 إيقاف جميع عمليات Node.js...
taskkill /F /IM node.exe 2>nul
if %errorlevel% equ 0 (
    echo ✅ تم إيقاف عمليات Node.js بنجاح
) else (
    echo ℹ️ لا توجد عمليات Node.js قيد التشغيل
)

echo.
echo 🧹 حذف الملفات والمجلدات المؤقتة...
if exist ".next" (
    rmdir /s /q ".next"
    echo ✅ تم حذف مجلد .next
)

if exist "node_modules" (
    rmdir /s /q "node_modules"
    echo ✅ تم حذف مجلد node_modules
)

echo.
echo 🗑️ تنظيف ذاكرة التخزين المؤقت لـ npm...
npm cache clean --force
echo ✅ تم تنظيف ذاكرة npm

echo.
echo 📦 إعادة تثبيت الحزم...
npm install --legacy-peer-deps
if %errorlevel% equ 0 (
    echo ✅ تم تثبيت الحزم بنجاح
) else (
    echo ❌ فشل في تثبيت الحزم
    pause
    exit /b 1
)

echo.
echo 🚀 بدء تشغيل الخادم...
npm run dev