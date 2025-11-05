Write-Host "🚀 بدء إصلاح مشكلة EBUSY: resource busy or locked..." -ForegroundColor Green

Write-Host "`n💡 إيقاف جميع عمليات Node.js..." -ForegroundColor Yellow
try {
    Get-Process -Name "node" -ErrorAction Stop | Stop-Process -Force
    Write-Host "✅ تم إيقاف عمليات Node.js بنجاح" -ForegroundColor Green
} catch {
    Write-Host "ℹ️ لا توجد عمليات Node.js قيد التشغيل" -ForegroundColor Cyan
}

Write-Host "`n🧹 حذف الملفات والمجلدات المؤقتة..." -ForegroundColor Yellow
if (Test-Path ".next") {
    Remove-Item -Recurse -Force ".next"
    Write-Host "✅ تم حذف مجلد .next" -ForegroundColor Green
}

if (Test-Path "node_modules") {
    Remove-Item -Recurse -Force "node_modules"
    Write-Host "✅ تم حذف مجلد node_modules" -ForegroundColor Green
}

Write-Host "`n🗑️ تنظيف ذاكرة التخزين المؤقت لـ npm..." -ForegroundColor Yellow
npm cache clean --force
Write-Host "✅ تم تنظيف ذاكرة npm" -ForegroundColor Green

Write-Host "`n📦 إعادة تثبيت الحزم..." -ForegroundColor Yellow
npm install --legacy-peer-deps
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ تم تثبيت الحزم بنجاح" -ForegroundColor Green
} else {
    Write-Host "❌ فشل في تثبيت الحزم" -ForegroundColor Red
    Read-Host "اضغط Enter للمتابعة"
    exit 1
}

Write-Host "`n🚀 بدء تشغيل الخادم..." -ForegroundColor Green
npm run dev