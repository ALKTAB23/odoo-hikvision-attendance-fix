# إصلاح وحدة الحضور هيكفيجن في أودو

## المشكلة
وحدة `hr_hikvision_attendance` كانت تفشل أثناء التحديث مع الخطأ التالي:
```
action_sync_employees_only is not a valid action on hikvision.sync.wizard
```

## السبب الجذري
ملف XML في `views/simple_wizard_test.xml` كان يحاول استدعاء ثلاث دوال غير موجودة في نموذج `hikvision.sync.wizard`:
1. `action_sync_employees_only` - مزامنة الموظفين فقط
2. `action_sync_attendances_only` - مزامنة سجلات الحضور فقط
3. `action_sync_all_data` - مزامنة شاملة

## الحل
تمت إضافة الدوال المفقودة إلى نموذج `hikvision.sync.wizard` في `models/hikvision_sync_wizard.py`

### الدوال المضافة:
- **action_sync_employees_only()**: تزامن بيانات الموظفين فقط من هيكفيجن
- **action_sync_attendances_only()**: تزامن سجلات الحضور فقط من هيكفيجن  
- **action_sync_all_data()**: تنفذ مزامنة شاملة للموظفين وسجلات الحضور

### المميزات:
- معالجة صحيحة للأخطاء باستخدام try/catch
- تسجيل العمليات للتشخيص
- إشعارات المستخدم عند النجاح/الفشل
- خيارات مزامنة قابلة للتكوين

## الملفات التي يجب تحديثها في نظام أودو:

### 1. تحديث أو إنشاء: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/hikvision_sync_wizard.py`
نسخ المحتوى من `odoo_fix/hr_hikvision_attendance/models/hikvision_sync_wizard.py`

### 2. التأكد من: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py`
يجب أن يحتوي على: `from . import hikvision_sync_wizard`

### 3. التأكد من: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/__init__.py`
يجب أن يحتوي على: `from . import models`

## ملاحظات التنفيذ:
- الدوال حالياً ترجع إشعارات نجاح
- تحتاج لتنفيذ منطق التكامل الفعلي مع هيكفيجن في الدوال الخاصة:
  - `_sync_employees_from_hikvision()`
  - `_sync_attendances_from_hikvision()`

## الاختبار:
1. تطبيق الإصلاح على نظام أودو
2. إعادة تشغيل خدمة أودو
3. محاولة ترقية الوحدة مرة أخرى
4. اختبار وظائف المعالج من خلال واجهة المستخدم

## النصوص العربية في الواجهة:
- "مزامنة الموظفين فقط" - زر مزامنة الموظفين
- "مزامنة سجلات الحضور فقط" - زر مزامنة الحضور
- "مزامنة شاملة" - زر المزامنة الشاملة