#!/bin/bash

# 🚀 أوامر سريعة لرفع المشروع إلى مستودع ALKTAB23
# Quick commands to upload project to ALKTAB23 repository

echo "🎉 رفع مشروع إصلاح هيكفيجن إلى مستودعك"
echo "🎉 Uploading Hikvision fix project to your repository"
echo ""

# معلومات المستودع
REPO_URL="https://github.com/ALKTAB23/odoo-hikvision-attendance-fix.git"
REPO_NAME="odoo-hikvision-attendance-fix"

echo "📍 معلومات المستودع | Repository Info:"
echo "   🔗 URL: $REPO_URL"
echo "   📁 Name: $REPO_NAME"
echo "   👤 Owner: ALKTAB23"
echo ""

# التحقق من وجود git
if ! command -v git &> /dev/null; then
    echo "❌ Git غير مثبت | Git not installed"
    echo "   قم بتثبيت Git أولاً | Install Git first"
    exit 1
fi

echo "✅ Git موجود | Git found"

# إنشاء مجلد مؤقت للعمل
WORK_DIR="/tmp/odoo-hikvision-upload-$(date +%s)"
echo "📁 إنشاء مجلد عمل | Creating work directory: $WORK_DIR"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo ""
echo "🔄 الخطوات التالية | Next Steps:"
echo ""

echo "1️⃣ استنساخ المستودع | Clone repository:"
echo "   git clone $REPO_URL"
echo ""

echo "2️⃣ الدخول إلى المجلد | Enter directory:"
echo "   cd $REPO_NAME"
echo ""

echo "3️⃣ نسخ الملفات | Copy files:"
echo "   # نسخ الملفات من المشروع الجاهز"
echo "   cp -r /home/user/webapp/odoo-hikvision-attendance-fix/* ./"
echo "   # أو استخراج الملف المضغوط"
echo "   # tar -xzf /home/user/webapp/ALKTAB23-odoo-hikvision-fix-READY.tar.gz --strip-components=1"
echo ""

echo "4️⃣ إعداد Git (أدخل بياناتك) | Setup Git (enter your details):"
echo "   git config user.name \"ALKTAB23\""
echo "   git config user.email \"your-email@example.com\""
echo ""

echo "5️⃣ رفع الملفات | Upload files:"
echo "   git add ."
echo "   git commit -m \"feat: Initial release - Complete Hikvision attendance fix with Arabic support\""
echo "   git push origin main"
echo ""

echo "🎯 أو استخدم الأوامر التلقائية | Or use automatic commands:"
echo ""

# إنشاء سكريبت تلقائي
cat > auto_upload.sh << 'EOF'
#!/bin/bash

# التحقق من المتطلبات
if [ ! -d "/home/user/webapp/odoo-hikvision-attendance-fix" ]; then
    echo "❌ المشروع غير موجود في /home/user/webapp/odoo-hikvision-attendance-fix"
    exit 1
fi

# إعداد المتغيرات
REPO_URL="https://github.com/ALKTAB23/odoo-hikvision-attendance-fix.git"
WORK_DIR="/tmp/upload-$(date +%s)"

echo "🚀 بدء الرفع التلقائي..."

# إنشاء مجلد العمل
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# استنساخ المستودع
echo "📥 استنساخ المستودع..."
git clone "$REPO_URL"
cd odoo-hikvision-attendance-fix

# نسخ الملفات
echo "📂 نسخ الملفات..."
cp -r /home/user/webapp/odoo-hikvision-attendance-fix/* ./

# إعداد Git (سيحتاج المستخدم لإدخال بياناته)
echo "⚙️ إعداد Git..."
echo "أدخل اسمك:"
read -p "Name: " GIT_NAME
echo "أدخل بريدك الإلكتروني:"  
read -p "Email: " GIT_EMAIL

git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# رفع الملفات
echo "📤 رفع الملفات..."
git add .
git status

echo "سيتم رفع الملفات الآن. هل تريد المتابعة؟ (y/n)"
read -p "Continue? " CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    git commit -m "feat: Initial release - Complete Hikvision attendance fix with Arabic support

✅ Fixed missing action methods in hikvision.sync.wizard model  
✅ Added comprehensive Arabic language support in UI and docs
✅ Included automated deployment scripts with backup functionality
✅ Complete documentation in Arabic and English languages
✅ Professional project structure following GitHub standards
✅ MIT license with Arabic translation included
✅ Ready for production deployment and testing

Resolves: ParseError during module upgrade
Adds: action_sync_employees_only, action_sync_attendances_only, action_sync_all_data methods
Improves: Error handling, logging, user notifications
Supports: Arabic-speaking Odoo developer community"

    git push origin main
    
    if [ $? -eq 0 ]; then
        echo "🎉 تم الرفع بنجاح!"
        echo "🔗 المستودع: https://github.com/ALKTAB23/odoo-hikvision-attendance-fix"
        echo ""
        echo "الخطوات التالية:"
        echo "1. أضف Topics: odoo, hikvision, attendance, arabic, python, xml, fix"
        echo "2. أنشئ Release الأول (v1.0.0)" 
        echo "3. فعل Issues والمناقشات"
        echo "4. شارك المشروع مع المجتمع"
    else
        echo "❌ فشل الرفع. تحقق من صلاحياتك أو اتصال الإنترنت"
    fi
else
    echo "تم إلغاء الرفع"
fi

# تنظيف
cd /
rm -rf "$WORK_DIR"
EOF

chmod +x auto_upload.sh

echo "📜 تم إنشاء سكريبت تلقائي: auto_upload.sh"
echo "   لتشغيله: ./auto_upload.sh"
echo ""

echo "📦 الملفات المتاحة للرفع:"
echo "   📁 /home/user/webapp/odoo-hikvision-attendance-fix/ (مجلد كامل)"
echo "   📄 /home/user/webapp/ALKTAB23-odoo-hikvision-fix-READY.tar.gz (ملف مضغوط)"
echo ""

echo "🎯 اختر الطريقة المناسبة لك:"
echo "   🔧 للمطورين: استخدم الأوامر اليدوية أعلاه"
echo "   🚀 للسرعة: شغل ./auto_upload.sh"
echo "   🌐 للمبتدئين: ارفع الملف المضغوط عبر GitHub Web"
echo ""

echo "✨ مستودعك سيكون جاهزاً خلال دقائق! ✨"