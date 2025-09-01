# دليل المساهمة | Contributing Guide

شكراً لاهتمامك بالمساهمة في مشروع إصلاح وحدة هيكفيجن!
Thank you for your interest in contributing to the Hikvision Fix project!

## كيفية المساهمة | How to Contribute

### 1. الإبلاغ عن المشاكل | Reporting Issues

قبل إنشاء Issue جديد، تأكد من:
Before creating a new issue, make sure to:

- ✅ البحث في Issues الموجودة للتأكد من عدم وجود تقرير مشابه
- ✅ تضمين معلومات مفصلة عن المشكلة
- ✅ ذكر إصدار أودو ونظام التشغيل
- ✅ إرفاق رسائل الخطأ كاملة
- ✅ وصف الخطوات لإعادة إنتاج المشكلة

### 2. اقتراح تحسينات | Suggesting Enhancements

لاقتراح ميزة جديدة:
To suggest a new feature:

- 📋 اشرح المشكلة التي تحلها الميزة المقترحة
- 📋 وصف الحل المقترح بالتفصيل
- 📋 أضف أمثلة على الاستخدام
- 📋 اذكر أي تبعيات أو متطلبات إضافية

### 3. المساهمة في الكود | Code Contributions

#### إعداد بيئة التطوير | Development Environment Setup

```bash
# استنساخ المستودع | Clone repository
git clone https://github.com/YOUR_USERNAME/odoo-hikvision-attendance-fix.git
cd odoo-hikvision-attendance-fix

# إنشاء فرع جديد | Create new branch
git checkout -b feature/your-feature-name
```

#### معايير الكود | Code Standards

- 🐍 **Python**: اتبع PEP 8 style guide
- 📝 **التعليقات**: اكتب تعليقات باللغة العربية والإنجليزية
- 🧪 **الاختبارات**: أضف اختبارات للميزات الجديدة
- 📚 **الوثائق**: حدث الوثائق عند إضافة ميزات جديدة

#### هيكل Commit Messages

استخدم التنسيق التالي:
Use the following format:

```
type(scope): وصف قصير باللغة العربية

وصف مفصل للتغييرات (اختياري)

English short description

Detailed description of changes (optional)
```

**أنواع Commit:**
- `feat`: ميزة جديدة | new feature
- `fix`: إصلاح خطأ | bug fix  
- `docs`: تحديث وثائق | documentation update
- `style`: تنسيق الكود | code formatting
- `refactor`: إعادة هيكلة الكود | code refactoring
- `test`: إضافة اختبارات | adding tests
- `chore`: مهام صيانة | maintenance tasks

**أمثلة:**
```bash
feat(wizard): إضافة مزامنة مجدولة للموظفين

تم إضافة إمكانية جدولة مزامنة الموظفين تلقائياً
مع خيارات توقيت مرنة ومتابعة التقدم

Add scheduled employee synchronization

Added ability to schedule automatic employee sync
with flexible timing options and progress monitoring
```

### 4. عملية Pull Request

#### قبل تقديم PR:
1. ✅ تأكد من تشغيل جميع الاختبارات
2. ✅ تأكد من عدم وجود أخطاء في الكود
3. ✅ حدث الوثائق إذا لزم الأمر
4. ✅ أضف entry في CHANGELOG.md

#### معلومات PR المطلوبة:
- 📋 وصف واضح للتغييرات
- 📋 ذكر Issues المرتبطة
- 📋 لقطات شاشة للتغييرات في الواجهة
- 📋 تأكيد الاختبار في بيئات مختلفة

### 5. مراجعة الكود | Code Review

#### معايير المراجعة:
- 🔍 جودة الكود وقابلية القراءة
- 🔍 الأداء والكفاءة
- 🔍 الأمان ومعالجة الأخطاء
- 🔍 التوافق مع إصدارات أودو مختلفة
- 🔍 دعم اللغة العربية

#### الرد على التعليقات:
- 💬 كن محترماً ومتعاوناً
- 💬 اشرح قراراتك التقنية
- 💬 اطلب التوضيح إذا لم تفهم التعليق
- 💬 أجر التغييرات المطلوبة بسرعة

## إرشادات خاصة | Special Guidelines

### دعم اللغة العربية | Arabic Language Support
- 🇸🇦 جميع النصوص في الواجهة يجب أن تدعم العربية
- 🇸🇦 استخدم `_()` function للترجمة
- 🇸🇦 اكتب التعليقات باللغتين عند الإمكان
- 🇸🇦 تأكد من عرض النصوص العربية بشكل صحيح

### تطوير أودو | Odoo Development
- 🔧 اتبع معايير تطوير أودو الرسمية
- 🔧 استخدم Model inheritance بشكل صحيح
- 🔧 تأكد من التوافق مع إصدارات أودو مختلفة
- 🔧 اختبر في بيئة أودو كاملة

## المساعدة | Getting Help

إذا كنت بحاجة لمساعدة:
If you need help:

- 💬 أنشئ Discussion في GitHub
- 📧 اتصل بصاحب المشروع
- 📚 راجع وثائق أودو الرسمية
- 🔍 ابحث في المجتمع العربي لأودو

## شكر خاص | Special Thanks

نشكر جميع المساهمين في تحسين هذا المشروع!
We thank all contributors for improving this project!

---

**ملاحظة**: هذا المشروع يهدف لخدمة المجتمع العربي لأودو، نقدر كل مساهمة تساعد في تحقيق هذا الهدف.

**Note**: This project aims to serve the Arabic Odoo community, we appreciate every contribution that helps achieve this goal.