# 🚨 DIRECT SYNTAX FIX COMMAND

## Problem
The error shows concatenated import statements in `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py`:
```
from . import attendance_diagnosticfrom . import hikvision_sync_wizard
```

## IMMEDIATE SOLUTION - Copy & Paste This Command:

```bash
# Create backup and fix the syntax error
sudo cp /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py.backup.$(date +%Y%m%d_%H%M%S) && sudo tee /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py > /dev/null << 'EOF'
# -*- coding: utf-8 -*-

from . import attendance_diagnostic
from . import hikvision_sync_wizard
EOF
```

## Alternative Method (Step by Step):

### Step 1: Create Backup
```bash
sudo cp /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py.backup
```

### Step 2: Fix the File
```bash
sudo nano /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py
```

### Step 3: Replace Content With:
```python
# -*- coding: utf-8 -*-

from . import attendance_diagnostic
from . import hikvision_sync_wizard
```

### Step 4: Restart Odoo
```bash
sudo systemctl restart odoo16
```

## What This Fix Does:
- ✅ Separates the concatenated import statements with proper newlines
- ✅ Maintains the correct Python module import syntax
- ✅ Preserves both required imports (attendance_diagnostic and hikvision_sync_wizard)
- ✅ Follows Odoo coding standards

## After the Fix:
1. Restart Odoo service: `sudo systemctl restart odoo16`
2. Try upgrading the module again
3. The missing action methods error should now be resolved as the wizard model will load properly

## Verification:
Check that the file looks correct:
```bash
cat /opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py
```

Should show:
```python
# -*- coding: utf-8 -*-

from . import attendance_diagnostic
from . import hikvision_sync_wizard
```