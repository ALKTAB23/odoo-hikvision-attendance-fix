#!/bin/bash

# سكريبت إنشاء مستودع GitHub لإصلاح وحدة هيكفيجن
# GitHub Repository Creation Script for Hikvision Fix

echo "=== إنشاء مستودع GitHub لإصلاح وحدة هيكفيجن ==="
echo "=== GitHub Repository Setup for Hikvision Fix ==="
echo ""

# متغيرات المشروع
PROJECT_NAME="odoo-hikvision-attendance-fix"
PROJECT_DESC="إصلاح خطأ ترقية وحدة الحضور هيكفيجن في أودو 16 مع دعم اللغة العربية"
PROJECT_DESC_EN="Odoo 16 Hikvision Attendance Module Upgrade Fix with Arabic Support"

echo "اسم المشروع | Project Name: $PROJECT_NAME"
echo "الوصف | Description: $PROJECT_DESC"
echo ""

# التحقق من وجود GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI موجود | GitHub CLI found"
    echo ""
    
    # إنشاء المستودع باستخدام GitHub CLI
    echo "🚀 إنشاء المستودع | Creating repository..."
    gh repo create "$PROJECT_NAME" \
        --description "$PROJECT_DESC_EN" \
        --public \
        --clone=false \
        --gitignore="Python" \
        --license="mit"
    
    if [ $? -eq 0 ]; then
        echo "✅ تم إنشاء المستودع بنجاح | Repository created successfully"
        
        # إضافة المستودع البعيد
        echo "🔗 ربط المستودع المحلي | Linking local repository..."
        git remote add origin "https://github.com/$(gh api user --jq .login)/$PROJECT_NAME.git"
        
        # رفع الكود
        echo "📤 رفع الكود | Pushing code..."
        git push -u origin genspark_ai_developer
        
        echo "✅ تم رفع المشروع بنجاح! | Project uploaded successfully!"
        echo "🔗 رابط المستودع | Repository URL: https://github.com/$(gh api user --jq .login)/$PROJECT_NAME"
    else
        echo "❌ فشل في إنشاء المستودع | Failed to create repository"
    fi
    
else
    echo "❌ GitHub CLI غير موجود | GitHub CLI not found"
    echo ""
    echo "خيارات أخرى | Alternative options:"
    echo ""
    
    echo "1️⃣ تثبيت GitHub CLI:"
    echo "   Linux: sudo apt install gh"
    echo "   Mac: brew install gh"
    echo "   Windows: winget install GitHub.cli"
    echo ""
    
    echo "2️⃣ إنشاء المستودع يدوياً:"
    echo "   - اذهب إلى https://github.com/new"
    echo "   - اسم المستودع: $PROJECT_NAME"
    echo "   - الوصف: $PROJECT_DESC_EN"
    echo "   - اجعله Public"
    echo "   - لا تضف README"
    echo ""
    
    echo "3️⃣ ربط المستودع المحلي:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/$PROJECT_NAME.git"
    echo "   git push -u origin genspark_ai_developer"
    echo ""
    
    echo "4️⃣ أو إنشاء أرشيف للرفع اليدوي:"
    echo "   tar -czf $PROJECT_NAME.tar.gz odoo_fix/"
fi

echo ""
echo "📋 معلومات المشروع | Project Information:"
echo "   الاسم | Name: $PROJECT_NAME"
echo "   الوصف | Description: $PROJECT_DESC"
echo "   الفرع | Branch: genspark_ai_developer"
echo "   الملفات | Files: $(find odoo_fix -type f | wc -l) files"
echo ""
echo "🎯 الخطوات التالية | Next Steps:"
echo "1. تحقق من رابط المستودع | Check repository URL"
echo "2. أضف وصف مفصل | Add detailed description"  
echo "3. أضف تاجات | Add topic tags: odoo, hikvision, arabic, fix"
echo "4. أنشئ Issues للمتابعة | Create Issues for tracking"