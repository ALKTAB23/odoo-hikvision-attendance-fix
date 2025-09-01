#!/bin/bash

# Odoo HR Hikvision Attendance Fix Deployment Script
# Run this script as the odoo user or with appropriate permissions

ODOO_PATH="/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance"
BACKUP_DIR="/tmp/hikvision_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== Odoo HR Hikvision Attendance Fix Deployment ==="
echo "Backup directory: $BACKUP_DIR"
echo "Odoo module path: $ODOO_PATH"

# Create backup
echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
if [ -d "$ODOO_PATH" ]; then
    cp -r "$ODOO_PATH" "$BACKUP_DIR/"
    echo "Backup created successfully"
else
    echo "Warning: Module path does not exist, creating new structure"
fi

# Ensure directory structure exists
mkdir -p "$ODOO_PATH/models"
mkdir -p "$ODOO_PATH/views"

# Deploy the fix
echo "Deploying fix files..."

# Copy the wizard model
cp "./hr_hikvision_attendance/models/hikvision_sync_wizard.py" "$ODOO_PATH/models/"

# Ensure __init__.py files exist
if [ ! -f "$ODOO_PATH/models/__init__.py" ]; then
    cp "./hr_hikvision_attendance/models/__init__.py" "$ODOO_PATH/models/"
else
    # Check if the import exists
    if ! grep -q "hikvision_sync_wizard" "$ODOO_PATH/models/__init__.py"; then
        echo "from . import hikvision_sync_wizard" >> "$ODOO_PATH/models/__init__.py"
    fi
fi

if [ ! -f "$ODOO_PATH/__init__.py" ]; then
    cp "./hr_hikvision_attendance/__init__.py" "$ODOO_PATH/"
else
    # Check if models import exists
    if ! grep -q "from . import models" "$ODOO_PATH/__init__.py"; then
        echo "from . import models" >> "$ODOO_PATH/__init__.py"
    fi
fi

echo "Fix deployed successfully!"
echo ""
echo "Next steps:"
echo "1. Restart Odoo service: sudo systemctl restart odoo16"
echo "2. Login to Odoo and try upgrading the hr_hikvision_attendance module"
echo "3. Test the wizard functionality"
echo ""
echo "If you need to rollback:"
echo "cp -r \"$BACKUP_DIR/hr_hikvision_attendance\" \"$(dirname $ODOO_PATH)/\""