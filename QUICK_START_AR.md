# 🚀 دليل البدء السريع - نظام إتجاهات

## ما تم إنجازه؟

تم بنجاح تطبيق **Clean Architecture** على نظام إتجاهات مع تنفيذ كامل لمنطق الأعمال الخاص بشركة الحلول اللوجستية.

---

## 📁 الملفات الجديدة

### 1. الكيانات والمنطق التجاري (Domain)
```
lib/domain/entities/
├── Employee.ts                  ← كيان الموظف
├── Vehicle.ts                   ← كيان المركبة
├── DailyOperation.ts            ← العمليات اليومية
├── MonthlyRevenue.ts            ← حساب الإيرادات من نون
├── PayrollCalculator.ts         ← حساب الرواتب والخصومات
└── ProfitLossCalculator.ts     ← حساب الأرباح والخسائر
```

### 2. حالات الاستخدام (Application)
```
lib/application/
├── usecases/
│   ├── GetEmployeesUseCase.ts
│   └── CalculateMonthlyFinancialsUseCase.ts
└── services/
    └── DashboardService.ts
```

### 3. البنية التحتية (Infrastructure)
```
lib/infrastructure/
└── repositories/
    └── SupabaseEmployeeRepository.ts
```

### 4. التوثيق
```
📄 BUSINESS_MODEL.md              ← نموذج العمل الكامل
📄 CLEAN_ARCHITECTURE.md          ← شرح البنية المعمارية
📄 IMPLEMENTATION_SUMMARY.md      ← ملخص التنفيذ
📄 CHECKLIST.md                   ← قائمة التحقق
```

---

## 💡 المنطق التجاري المُنفذ

### ✅ قواعد نون
```
✓ 260 درهم لكل سيارة يومياً
✓ حد أقصى 30 يوم للفوترة (حتى لو الشهر 31 يوم)
✓ 4 أيام إجازة مدفوعة شهرياً
✓ الغياب بعذر: أول 4 أيام مدفوعة
✓ الغياب بدون عذر: يُخصم من الفوترة
```

### ✅ حساب الرواتب
```
✓ الراتب الأساسي: 2,500 - 2,700 درهم
✓ الخصومات:
  - المخالفات المرورية (على السائق)
  - رسوم سالك (على السائق)
  - السلف (على السائق)
✓ الراتب الصافي = الأساسي - الخصومات
```

### ✅ الأرباح والخسائر
```
✓ الإيرادات = أيام العمل × 260 درهم
✓ المصروفات = راتب + وقود + صيانة
✓ الربح الإجمالي = الإيرادات - المصروفات
✓ الربح الصافي = الإجمالي - (مخالفات + سالك)
```

---

## 🎯 أمثلة الاستخدام

### مثال 1: حساب الإيرادات الشهرية

```typescript
import { MonthlyRevenueCalculator } from '@/lib/domain/entities/MonthlyRevenue';

// سائق عمل 26 يوم، غاب يومين بعذر، غاب يوم بدون عذر
const breakdown = MonthlyRevenueCalculator.getMonthlyRevenueBreakdown(
  26,  // أيام العمل
  2,   // غياب بعذر
  1,   // غياب بدون عذر
  30   // أيام الشهر
);

console.log(breakdown);
// النتيجة:
// {
//   billableDays: 25,           ← الأيام القابلة للفوترة
//   dailyRate: 260,             ← السعر اليومي
//   totalRevenue: 6500,         ← إجمالي الإيرادات
//   maxPossibleRevenue: 7800,   ← الحد الأقصى (30 × 260)
//   lostRevenue: 1300,          ← الإيرادات المفقودة
//   paidLeaveDaysUsed: 2,       ← أيام الإجازة المدفوعة المستخدمة
//   unpaidLeaveDays: 0,         ← أيام الإجازة غير المدفوعة
//   unexcusedAbsences: 1        ← الغياب بدون عذر
// }
```

### مثال 2: حساب الراتب مع الخصومات

```typescript
import { PayrollCalculator } from '@/lib/domain/entities/PayrollCalculator';

const payroll = PayrollCalculator.calculate({
  employeeId: 'emp-001',
  employeeName: 'محمود',
  month: 'October',
  year: 2024,
  basicSalary: 2500,
  workingDays: 26,
  excusedAbsences: 2,
  unexcusedAbsences: 1,
  trafficViolations: 500,    // مخالفات
  salikFees: 150,            // سالك
  advances: 200,             // سلف
  otherDeductions: 0
});

console.log(payroll);
// النتيجة:
// {
//   basicSalary: 2500,
//   grossSalary: 2500,
//   totalDeductions: 850,
//   netSalary: 1650,          ← الراتب الصافي
//   deductionsBreakdown: {
//     trafficViolations: 500,
//     salikFees: 150,
//     advances: 200,
//     otherDeductions: 0
//   }
// }
```

### مثال 3: حساب ربح السيارة الشهري

```typescript
import { ProfitLossCalculator } from '@/lib/domain/entities/ProfitLossCalculator';

const profit = ProfitLossCalculator.calculateVehicleMonthlyProfitLoss(
  6500,   // الإيرادات (25 يوم × 260)
  2500,   // راتب السائق
  1200,   // تكلفة الوقود
  300,    // تكلفة الصيانة
  500,    // المخالفات
  150     // سالك
);

console.log(profit);
// النتيجة:
// {
//   totalRevenue: 6500,
//   totalExpenses: 4000,       ← راتب + وقود + صيانة
//   grossProfit: 2500,         ← الربح الإجمالي
//   netProfit: 1850,           ← الربح الصافي (بعد المخالفات وسالك)
//   profitMargin: 28.46        ← هامش الربح %
// }
```

### مثال 4: التقرير المالي الشهري الكامل

```typescript
import { CalculateMonthlyFinancialsUseCase } from '@/lib/application/usecases/CalculateMonthlyFinancialsUseCase';

const useCase = new CalculateMonthlyFinancialsUseCase();
const financials = await useCase.execute('October', 2024);

// financials = مصفوفة من التقارير المالية لكل سيارة
financials.forEach(vehicle => {
  console.log(`
    السيارة: ${vehicle.vehiclePlate}
    السائق: ${vehicle.employeeName}
    أيام العمل: ${vehicle.workingDays}
    الإيرادات: ${vehicle.totalRevenue} درهم
    المصروفات: ${vehicle.totalExpenses} درهم
    الربح الصافي: ${vehicle.netProfit} درهم
    هامش الربح: ${vehicle.profitMargin.toFixed(2)}%
  `);
});
```

---

## 📊 السيناريوهات العملية

### سيناريو 1: سائق ملتزم
```
أيام العمل: 26 يوم
إجازة قانونية: 4 أيام
الفوترة: 30 يوم × 260 = 7,800 درهم ✅
الراتب: 2,500 درهم
المخالفات: 0 درهم
الراتب الصافي: 2,500 درهم
ربح الشركة: 7,800 - 2,500 - 1,500 (وقود+صيانة) = 3,800 درهم
```

### سيناريو 2: سائق لديه مخالفات
```
أيام العمل: 25 يوم
غياب بدون عذر: 1 يوم
الفوترة: 29 يوم × 260 = 7,540 درهم ❌
الراتب: 2,500 درهم
المخالفات: 800 درهم
الراتب الصافي: 2,500 - 800 = 1,700 درهم
ربح الشركة: 7,540 - 2,500 - 1,500 = 3,540 درهم
```

### سيناريو 3: شهر 31 يوم
```
أيام العمل: 31 يوم (عمل كل الأيام)
الفوترة: 30 يوم × 260 = 7,800 درهم (نون لا تحسب اليوم 31)
الراتب: 2,500 درهم
ربح الشركة: 7,800 - 2,500 - 1,500 = 3,800 درهم
```

---

## 🔧 التكامل مع المشروع الحالي

### الخطوة 1: تحديث Dashboard

```typescript
// الملف: app/page.tsx

'use client';

import { useEffect, useState } from 'react';
import { DIContainer } from '@/lib/infrastructure/di/Container';

export default function HomePage() {
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadStats();
  }, []);

  async function loadStats() {
    try {
      const container = DIContainer.getInstance();
      const service = container.getDashboardService();
      const data = await service.getDashboardStats();
      setStats(data);
    } catch (error) {
      console.error('Error:', error);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div>جاري التحميل...</div>;

  return (
    <div>
      <h1>لوحة التحكم</h1>
      <div>عدد الموظفين: {stats.totalEmployees}</div>
      <div>عدد المركبات: {stats.totalVehicles}</div>
      {/* ... باقي الإحصائيات */}
    </div>
  );
}
```

### الخطوة 2: إنشاء صفحة التقارير المالية

```typescript
// الملف: app/financial/monthly-report/page.tsx

'use client';

import { useState } from 'react';
import { CalculateMonthlyFinancialsUseCase } from '@/lib/application/usecases/CalculateMonthlyFinancialsUseCase';
import { ProfitLossCalculator } from '@/lib/domain/entities/ProfitLossCalculator';

export default function MonthlyReportPage() {
  const [month, setMonth] = useState('October');
  const [year, setYear] = useState(2024);
  const [report, setReport] = useState(null);

  async function generateReport() {
    const useCase = new CalculateMonthlyFinancialsUseCase();
    const financials = await useCase.execute(month, year);
    const summary = ProfitLossCalculator.calculateCompanyMonthlyProfitLoss(financials);
    
    setReport({ financials, summary });
  }

  return (
    <div>
      <h1>التقرير المالي الشهري</h1>
      
      <select value={month} onChange={(e) => setMonth(e.target.value)}>
        <option>January</option>
        <option>February</option>
        {/* ... باقي الأشهر */}
      </select>
      
      <button onClick={generateReport}>إنشاء التقرير</button>
      
      {report && (
        <div>
          <h2>الملخص</h2>
          <p>إجمالي الإيرادات: {report.summary.totalRevenue} درهم</p>
          <p>إجمالي المصروفات: {report.summary.totalExpenses} درهم</p>
          <p>الربح الصافي: {report.summary.netProfit} درهم</p>
          <p>هامش الربح: {report.summary.profitMargin.toFixed(2)}%</p>
          
          <h2>تفاصيل المركبات</h2>
          {report.financials.map(v => (
            <div key={v.vehicleId}>
              <h3>{v.vehiclePlate} - {v.employeeName}</h3>
              <p>الإيرادات: {v.totalRevenue} درهم</p>
              <p>الربح: {v.netProfit} درهم</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
```

---

## 📚 المراجع السريعة

### الملفات المهمة
1. **BUSINESS_MODEL.md** - اقرأ هذا أولاً لفهم نموذج العمل
2. **CLEAN_ARCHITECTURE.md** - لفهم البنية المعمارية
3. **IMPLEMENTATION_SUMMARY.md** - ملخص شامل لما تم إنجازه
4. **CHECKLIST.md** - قائمة المهام المكتملة والمتبقية

### الثوابت المهمة
```typescript
DAILY_VEHICLE_RATE = 260        // درهم لكل سيارة يومياً
MAX_MONTHLY_DAYS = 30           // الحد الأقصى للفوترة
PAID_LEAVE_DAYS = 4             // أيام الإجازة المدفوعة
```

---

## ✅ الخلاصة

تم بنجاح:
1. ✅ تطبيق Clean Architecture الكامل
2. ✅ تنفيذ جميع قواعد نون
3. ✅ إنشاء محركات الحساب
4. ✅ توثيق شامل

**النظام جاهز للاستخدام!**

---

**للأسئلة**: راجع الملفات التوثيقية أو الكود المصدري
**آخر تحديث**: يناير 2025
