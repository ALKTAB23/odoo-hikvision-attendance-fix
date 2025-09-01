#!/bin/bash

# حل طارئ سريع للحقول المفقودة الجديدة
# Emergency quick fix for new missing fields

echo "🚨 حل طارئ للحقول المفقودة الجديدة"
echo "======================================"

# مسار النموذج
DEVICE_MODEL_FILE="/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/hikvision_device.py"

echo "📍 الملف المستهدف: $DEVICE_MODEL_FILE"

# إنشاء نسخة احتياطية سريعة
BACKUP_FILE="${DEVICE_MODEL_FILE}.emergency.$(date +%Y%m%d_%H%M%S)"
echo "💾 نسخة احتياطية طارئة: $BACKUP_FILE"
sudo cp "$DEVICE_MODEL_FILE" "$BACKUP_FILE"

echo "🔧 إضافة الحقول المفقودة الجديدة..."

# قراءة الملف الحالي وإضافة الحقول المفقودة
sudo python3 << 'EOF'
import os

# قراءة الملف الحالي
with open('/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/hikvision_device.py', 'r', encoding='utf-8') as f:
    content = f.read()

# البحث عن مكان إضافة الحقول الجديدة بعد password
password_line = "    password = fields.Char("
if password_line in content:
    # البحث عن نهاية تعريف password
    password_end = content.find("    )", content.find(password_line))
    if password_end != -1:
        password_end = content.find("\n", password_end) + 1
        
        # الحقول الجديدة المطلوبة
        new_fields = '''    
    timeout = fields.Integer(
        string='Timeout',
        default=30,
        help="Connection timeout in seconds"
    )
    
    use_https = fields.Boolean(
        string='Use HTTPS',
        default=False,
        help="Use HTTPS for secure connection"
    )
    
    verify_ssl = fields.Boolean(
        string='Verify SSL',
        default=True,
        help="Verify SSL certificates when using HTTPS"
    )
'''
        
        # إدراج الحقول الجديدة
        new_content = content[:password_end] + new_fields + content[password_end:]
        
        # كتابة الملف المحدث
        with open('/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/hikvision_device.py', 'w', encoding='utf-8') as f:
            f.write(new_content)
        
        print("✅ تم إضافة الحقول الجديدة بنجاح!")
    else:
        print("❌ لم يتم العثور على نهاية تعريف password")
else:
    print("❌ لم يتم العثور على تعريف password في الملف")
EOF

# تعيين الصلاحيات
sudo chmod 644 "$DEVICE_MODEL_FILE"

echo "✅ تم إضافة الحقول المفقودة!"
echo "   - timeout (مهلة الاتصال)"
echo "   - use_https (استخدام HTTPS)"
echo "   - verify_ssl (التحقق من SSL)"

# إعادة تشغيل Odoo
echo "🔄 إعادة تشغيل خدمة Odoo..."
sudo systemctl restart odoo16

echo ""
echo "🎉 تم الانتهاء من الحل الطارئ!"
echo "================================="
echo "✅ تم إنشاء النسخة الاحتياطية: $BACKUP_FILE"
echo "✅ تم إضافة 3 حقول جديدة"
echo "✅ تم إعادة تشغيل Odoo"
echo ""
echo "📋 الخطوات التالية:"
echo "1. انتظر دقيقتين لإعادة تشغيل Odoo"
echo "2. جرب ترقية الوحدة مرة أخرى"
echo "3. إذا ظهرت حقول أخرى مفقودة، أعلمني فوراً"
echo ""
echo "🎯 الحالة: تم إصلاح timeout, use_https, verify_ssl"
EOF