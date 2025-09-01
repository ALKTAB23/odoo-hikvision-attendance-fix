#!/bin/bash

# سكريبت نشر إصلاح وحدة الحضور هيكفيجن في أودو
# شغل هذا السكريبت كمستخدم أودو أو بالصلاحيات المناسبة

ODOO_PATH="/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance"
BACKUP_DIR="/tmp/hikvision_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== نشر إصلاح وحدة الحضور هيكفيجن في أودو ==="
echo "مجلد النسخ الاحتياطي: $BACKUP_DIR"
echo "مسار وحدة أودو: $ODOO_PATH"

# إنشاء نسخة احتياطية
echo "إنشاء نسخة احتياطية..."
mkdir -p "$BACKUP_DIR"
if [ -d "$ODOO_PATH" ]; then
    cp -r "$ODOO_PATH" "$BACKUP_DIR/"
    echo "تم إنشاء النسخة الاحتياطية بنجاح"
else
    echo "تحذير: مسار الوحدة غير موجود، سيتم إنشاء هيكل جديد"
fi

# التأكد من وجود هيكل المجلدات
mkdir -p "$ODOO_PATH/models"
mkdir -p "$ODOO_PATH/views"

# نشر ملفات الإصلاح
echo "نشر ملفات الإصلاح..."

# نسخ نموذج المعالج
cp "./hr_hikvision_attendance/models/hikvision_sync_wizard.py" "$ODOO_PATH/models/"

# التأكد من وجود ملفات __init__.py
if [ ! -f "$ODOO_PATH/models/__init__.py" ]; then
    cp "./hr_hikvision_attendance/models/__init__.py" "$ODOO_PATH/models/"
else
    # التحقق من وجود الاستيراد
    if ! grep -q "hikvision_sync_wizard" "$ODOO_PATH/models/__init__.py"; then
        echo "from . import hikvision_sync_wizard" >> "$ODOO_PATH/models/__init__.py"
    fi
fi

if [ ! -f "$ODOO_PATH/__init__.py" ]; then
    cp "./hr_hikvision_attendance/__init__.py" "$ODOO_PATH/"
else
    # التحقق من وجود استيراد النماذج
    if ! grep -q "from . import models" "$ODOO_PATH/__init__.py"; then
        echo "from . import models" >> "$ODOO_PATH/__init__.py"
    fi
fi

echo "تم نشر الإصلاح بنجاح!"
echo ""
echo "الخطوات التالية:"
echo "1. إعادة تشغيل خدمة أودو: sudo systemctl restart odoo16"
echo "2. تسجيل الدخول إلى أودو ومحاولة ترقية وحدة hr_hikvision_attendance"
echo "3. اختبار وظائف المعالج"
echo ""
echo "في حالة الحاجة للتراجع:"
echo "cp -r \"$BACKUP_DIR/hr_hikvision_attendance\" \"$(dirname $ODOO_PATH)/\""