# Odoo HR Hikvision Attendance Fix

## Problem
The `hr_hikvision_attendance` module was failing during upgrade with the following error:
```
action_sync_employees_only is not a valid action on hikvision.sync.wizard
```

## Root Cause
The XML view `views/simple_wizard_test.xml` was referencing three methods that didn't exist in the `hikvision.sync.wizard` model:
1. `action_sync_employees_only`
2. `action_sync_attendances_only`
3. `action_sync_all_data`

## Solution
Added the missing methods to the `hikvision.sync.wizard` model in `models/hikvision_sync_wizard.py`:

### Methods Added:
- **action_sync_employees_only()**: Syncs only employee data from Hikvision
- **action_sync_attendances_only()**: Syncs only attendance records from Hikvision
- **action_sync_all_data()**: Performs comprehensive sync of both employees and attendances

### Features:
- Proper error handling with try/catch blocks
- Logging for debugging purposes
- User notifications on success/failure
- Configurable sync options via boolean fields

## Files to Update on Your Odoo System:

### 1. Update or Create: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/hikvision_sync_wizard.py`
Copy the content from `odoo_fix/hr_hikvision_attendance/models/hikvision_sync_wizard.py`

### 2. Ensure: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/models/__init__.py`
Should import the wizard: `from . import hikvision_sync_wizard`

### 3. Ensure: `/opt/odoo16/custom.f.alshouf/hr_hikvision_attendance/__init__.py`
Should import models: `from . import models`

## Implementation Notes:
- The methods currently return success notifications
- You need to implement the actual Hikvision integration logic in the private methods:
  - `_sync_employees_from_hikvision()`
  - `_sync_attendances_from_hikvision()`

## Testing:
1. Apply the fix to your Odoo system
2. Restart the Odoo service
3. Try upgrading the module again
4. Test the wizard functionality through the UI

## Arabic UI Text:
- "مزامنة الموظفين فقط" = Sync Employees Only
- "مزامنة سجلات الحضور فقط" = Sync Attendances Only  
- "مزامنة شاملة" = Comprehensive Sync