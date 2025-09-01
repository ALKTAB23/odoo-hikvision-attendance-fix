# -*- coding: utf-8 -*-
{
    'name': 'HR Hikvision Attendance',
    'version': '16.0.1.0.0',
    'category': 'Human Resources',
    'summary': 'Integration with Hikvision attendance devices',
    'description': """
HR Hikvision Attendance Integration
===================================
This module provides integration with Hikvision attendance devices.

Features:
- Device management
- Employee synchronization
- Attendance data import
- Sync wizard with Arabic support
    """,
    'author': 'Your Company',
    'depends': ['hr', 'hr_attendance'],
    'data': [
        'security/ir.model.access.csv',
        'views/hikvision_device_views.xml',
        'views/simple_wizard_test.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': False,
}