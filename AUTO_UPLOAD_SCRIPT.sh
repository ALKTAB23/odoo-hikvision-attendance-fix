#!/bin/bash

# 🚀 سكريبت رفع تلقائي لمستودع ALKTAB23
# Auto-upload script for ALKTAB23 repository

echo "🎯 سكريبت الرفع التلقائي لمستودع odoo-hikvision-attendance-fix"
echo "🎯 Auto-upload script for odoo-hikvision-attendance-fix repository"
echo ""

# معلومات المستودع
REPO_URL="https://github.com/ALKTAB23/odoo-hikvision-attendance-fix.git"
REPO_NAME="odoo-hikvision-attendance-fix"
SOURCE_DIR="/home/user/webapp/odoo-hikvision-attendance-fix"
WORK_DIR="/tmp/upload-$(date +%s)"

# التحقق من المتطلبات
echo "🔍 التحقق من المتطلبات..."

# التحقق من وجود Git
if ! command -v git &> /dev/null; then
    echo "❌ Git غير مثبت. قم بتثبيته أولاً:"
    echo "   sudo apt update && sudo apt install git -y"
    exit 1
fi

# التحقق من وجود المشروع
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ المشروع غير موجود في: $SOURCE_DIR"
    echo "   تأكد من وجود المجلد أولاً"
    exit 1
fi

echo "✅ Git موجود"
echo "✅ المشروع موجود"
echo ""

# إعداد بيانات Git
echo "⚙️ إعداد بيانات Git..."
echo "أدخل اسمك (أو اتركه فارغاً لاستخدام ALKTAB23):"
read -p "الاسم / Name: " GIT_NAME
GIT_NAME=${GIT_NAME:-ALKTAB23}

echo "أدخل بريدك الإلكتروني:"
read -p "البريد / Email: " GIT_EMAIL

if [ -z "$GIT_EMAIL" ]; then
    echo "❌ البريد الإلكتروني مطلوب"
    exit 1
fi

echo ""

# إنشاء مجلد العمل
echo "📁 إنشاء مجلد العمل..."
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# استنساخ المستودع
echo "📥 استنساخ المستودع..."
if ! git clone "$REPO_URL"; then
    echo "❌ فشل في استنساخ المستودع. تحقق من:"
    echo "   1. الاتصال بالإنترنت"
    echo "   2. صحة رابط المستودع"
    echo "   3. صلاحياتك في المستودع"
    exit 1
fi

cd "$REPO_NAME"

# إعداد Git
echo "⚙️ إعداد Git المحلي..."
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# نسخ الملفات
echo "📂 نسخ الملفات من المشروع..."
cp -r "$SOURCE_DIR"/* ./

# التحقق من وجود الملفات
if [ ! -f "README.md" ]; then
    echo "❌ لم يتم نسخ الملفات بشكل صحيح"
    exit 1
fi

echo "✅ تم نسخ الملفات بنجاح"

# عرض الملفات المضافة
echo ""
echo "📋 الملفات التي سيتم رفعها:"
find . -type f -not -path "./.git/*" | head -20
echo ""

# تأكيد الرفع
echo "هل تريد رفع هذه الملفات إلى GitHub؟ (y/n)"
read -p "تأكيد / Confirm: " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "تم إلغاء العملية"
    cd /
    rm -rf "$WORK_DIR"
    exit 0
fi

# إضافة الملفات
echo "📤 إضافة الملفات..."
git add .

# عرض حالة Git
echo ""
echo "📊 حالة المستودع:"
git status --short
echo ""

# إنشاء Commit
echo "💾 إنشاء Commit..."
git commit -m "feat: Initial release - Complete Hikvision attendance fix with Arabic support

✅ Fixed missing action methods in hikvision.sync.wizard model
✅ Added comprehensive Arabic language support in UI and documentation  
✅ Included automated deployment scripts with backup functionality
✅ Complete bilingual documentation (Arabic/English)
✅ Professional project structure following GitHub standards
✅ MIT license with Arabic translation included
✅ Ready for production deployment and community use

🔧 Technical Fixes:
- Resolves: action_sync_employees_only is not a valid action error
- Adds: action_sync_employees_only(), action_sync_attendances_only(), action_sync_all_data()
- Improves: Error handling, logging system, user notifications
- Supports: Arabic UI with cultural context awareness

🇸🇦 Arabic Community Features:
- Native Arabic interface for Middle East users
- Comprehensive Arabic documentation and guides  
- Arabic deployment scripts and error messages
- First-class Arabic language support in Odoo Hikvision integration

📚 Documentation Included:
- Professional README with badges and clear instructions
- Arabic README for Arabic-speaking developers
- Step-by-step installation and deployment guides
- Contributing guidelines and project roadmap
- Automated deployment scripts with safety features

This release serves the Arabic-speaking Odoo developer community and provides
a complete, production-ready solution for Hikvision attendance integration issues."

if [ $? -ne 0 ]; then
    echo "❌ فشل في إنشاء Commit"
    exit 1
fi

# رفع الملفات
echo "🚀 رفع الملفات إلى GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉🎉🎉 تم الرفع بنجاح! 🎉🎉🎉"
    echo ""
    echo "✅ تم رفع المشروع إلى: https://github.com/ALKTAB23/odoo-hikvision-attendance-fix"
    echo ""
    echo "🎯 الخطوات التالية:"
    echo "1. 🏷️ أضف Topics: odoo, hikvision, attendance, arabic, python, xml, fix"
    echo "2. 📝 أضف وصف في About section"
    echo "3. 🔖 أنشئ Release الأول (v1.0.0)"
    echo "4. ✅ فعل Issues والمناقشات"
    echo "5. 🌟 شارك المشروع مع المجتمع"
    echo ""
    echo "📊 إحصائيات المشروع:"
    echo "   📁 عدد الملفات: $(find . -type f -not -path "./.git/*" | wc -l)"
    echo "   📝 سطور الكود: $(find . -name "*.py" -not -path "./.git/*" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')"
    echo "   📚 ملفات الوثائق: $(find . -name "*.md" -not -path "./.git/*" | wc -l)"
    echo ""
    echo "🌟 مبروك! مستودعك سيساعد المجتمع العربي لأودو! 🌟"
    
else
    echo ""
    echo "❌ فشل في الرفع. الأخطاء المحتملة:"
    echo "1. 🔐 مشكلة في المصادقة - تأكد من صلاحياتك"
    echo "2. 🌐 مشكلة في الاتصال بالإنترنت"
    echo "3. 🚫 المستودع محمي أو مقيد"
    echo ""
    echo "💡 الحلول المقترحة:"
    echo "1. تأكد من تسجيل دخولك إلى GitHub"
    echo "2. تحقق من صلاحياتك في المستودع"
    echo "3. جرب الرفع اليدوي عبر واجهة GitHub"
    echo "4. تأكد من اتصال الإنترنت"
    echo ""
    echo "🔗 رابط المستودع: https://github.com/ALKTAB23/odoo-hikvision-attendance-fix"
fi

# تنظيف
echo ""
echo "🧹 تنظيف الملفات المؤقتة..."
cd /
rm -rf "$WORK_DIR"

echo "✅ انتهت العملية"