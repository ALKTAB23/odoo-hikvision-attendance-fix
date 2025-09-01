#!/bin/bash

# URGENT SYNTAX FIX for Odoo Hikvision Attendance Module
# Fixes the concatenated import statement error in models/__init__.py

echo "🚨 URGENT SYNTAX FIX - Hikvision Attendance Module"
echo "=================================================="

# Define the target file path
INIT_FILE="/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py"

# Check if file exists
if [ ! -f "$INIT_FILE" ]; then
    echo "❌ Error: File not found: $INIT_FILE"
    exit 1
fi

echo "📍 Found file: $INIT_FILE"

# Create backup
BACKUP_FILE="${INIT_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
echo "💾 Creating backup: $BACKUP_FILE"
cp "$INIT_FILE" "$BACKUP_FILE"

# Show current problematic content
echo "🔍 Current file content:"
echo "------------------------"
cat -n "$INIT_FILE"
echo "------------------------"

# Fix the syntax error - replace the concatenated import with proper imports
echo "🔧 Applying syntax fix..."

cat > "$INIT_FILE" << 'EOF'
# -*- coding: utf-8 -*-

from . import attendance_diagnostic
from . import hikvision_sync_wizard
EOF

# Show fixed content
echo "✅ Fixed file content:"
echo "----------------------"
cat -n "$INIT_FILE"
echo "----------------------"

# Set proper permissions
chmod 644 "$INIT_FILE"

echo ""
echo "✅ SYNTAX FIX COMPLETED SUCCESSFULLY!"
echo "📋 Summary:"
echo "   - Fixed concatenated import statements"
echo "   - Separated 'attendance_diagnostic' and 'hikvision_sync_wizard' imports"
echo "   - Created backup: $BACKUP_FILE"
echo "   - File permissions set to 644"
echo ""
echo "🔄 Next steps:"
echo "   1. Restart Odoo service: sudo systemctl restart odoo16"
echo "   2. Or reload the module from Odoo interface"
echo "   3. Test the Hikvision sync wizard functionality"
echo ""
echo "📞 If you encounter any issues, restore backup with:"
echo "   cp $BACKUP_FILE $INIT_FILE"