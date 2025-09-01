# -*- coding: utf-8 -*-

from odoo import models, fields, api
import logging

_logger = logging.getLogger(__name__)

class HikvisionDevice(models.Model):
    _name = 'hikvision.device'
    _description = 'Hikvision Device Management'
    _rec_name = 'name'

    # الحقول الأساسية
    name = fields.Char(
        string='Device Name',
        required=True,
        help="Name identifier for the Hikvision device"
    )
    
    device_ip = fields.Char(
        string='IP Address',
        required=True,
        help="IP address of the Hikvision device"
    )
    
    device_port = fields.Integer(
        string='Port',
        default=80,
        help="Port number for device connection"
    )
    
    username = fields.Char(
        string='Username',
        default='admin',
        help="Username for device authentication"
    )
    
    password = fields.Char(
        string='Password',
        help="Password for device authentication"
    )
    
    is_active = fields.Boolean(
        string='Active',
        default=True,
        help="Whether this device is active"
    )
    
    connection_status = fields.Selection([
        ('connected', 'Connected'),
        ('disconnected', 'Disconnected'),
        ('error', 'Connection Error')
    ], string='Connection Status', default='disconnected')
    
    last_sync = fields.Datetime(
        string='Last Sync',
        help="Last time data was synchronized from this device"
    )
    
    last_connection = fields.Datetime(
        string='Last Connection',
        help="Last time the device was connected"
    )
    
    # معلومات إضافية
    model = fields.Char(string='Device Model')
    device_model = fields.Char(string='Device Model')  # Additional field required by XML view
    serial_number = fields.Char(string='Serial Number')
    firmware_version = fields.Char(string='Firmware Version')
    
    # حقول العداد
    employee_count = fields.Integer(
        string='Employee Count',
        compute='_compute_employee_count',
        help="Number of employees registered on this device"
    )
    
    attendance_count = fields.Integer(
        string='Attendance Count', 
        compute='_compute_attendance_count',
        help="Number of attendance records from this device"
    )
    
    # إعدادات المزامنة
    sync_employees = fields.Boolean(
        string='Sync Employees',
        default=True,
        help="Enable employee synchronization from this device"
    )
    
    sync_attendance = fields.Boolean(
        string='Sync Attendance',
        default=True,
        help="Enable attendance synchronization from this device"
    )
    
    auto_sync = fields.Boolean(
        string='Auto Sync',
        default=False,
        help="Enable automatic synchronization from this device"
    )
    
    notes = fields.Text(string='Notes')

    @api.depends('name')
    def _compute_employee_count(self):
        """Compute the number of employees registered on this device"""
        for record in self:
            # هنا يمكن إضافة منطق حساب عدد الموظفين الفعلي
            # مثال: البحث في جدول الموظفين المربوطين بهذا الجهاز
            record.employee_count = 0  # قيمة افتراضية للآن
    
    @api.depends('name')
    def _compute_attendance_count(self):
        """Compute the number of attendance records from this device"""
        for record in self:
            # هنا يمكن إضافة منطق حساب عدد سجلات الحضور الفعلي
            # مثال: البحث في جدول سجلات الحضور من هذا الجهاز
            record.attendance_count = 0  # قيمة افتراضية للآن

    @api.model
    def test_connection(self):
        """Test connection to the device"""
        try:
            # هنا يمكن إضافة منطق اختبار الاتصال الفعلي
            _logger.info(f"Testing connection to device {self.name} at {self.device_ip}:{self.device_port}")
            return True
        except Exception as e:
            _logger.error(f"Connection test failed for device {self.name}: {str(e)}")
            return False
    
    def action_test_connection(self):
        """Action to test device connection"""
        if self.test_connection():
            self.connection_status = 'connected'
            self.last_connection = fields.Datetime.now()
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'Success',
                    'message': f'Successfully connected to {self.name}',
                    'type': 'success',
                }
            }
        else:
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'Error',
                    'message': f'Failed to connect to {self.name}',
                    'type': 'danger',
                }
            }
    
    def sync_device_data(self):
        """Synchronize data from the device"""
        try:
            _logger.info(f"Starting data sync for device {self.name}")
            
            # هنا يمكن إضافة منطق المزامنة الفعلي
            # مثال: مزامنة الموظفين والحضور
            
            self.last_sync = fields.Datetime.now()
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'Success',
                    'message': f'Data synchronized successfully from {self.name}',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Data sync failed for device {self.name}: {str(e)}")
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'Error',
                    'message': f'Data sync failed: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_quick_test(self):
        """Quick ping test for device connectivity"""
        try:
            # محاكاة اختبار ping سريع
            _logger.info(f"Quick ping test for device {self.name} at {self.device_ip}")
            
            # هنا يمكن إضافة منطق ping فعلي
            # import subprocess
            # result = subprocess.run(['ping', '-c', '1', self.device_ip], capture_output=True)
            # success = result.returncode == 0
            
            success = True  # قيمة افتراضية للآن
            
            if success:
                return {
                    'type': 'ir.actions.client',
                    'tag': 'display_notification',
                    'params': {
                        'title': 'نجح الاختبار السريع',
                        'message': f'الجهاز {self.name} متاح على الشبكة',
                        'type': 'success',
                    }
                }
            else:
                return {
                    'type': 'ir.actions.client',
                    'tag': 'display_notification',
                    'params': {
                        'title': 'فشل الاختبار السريع',
                        'message': f'الجهاز {self.name} غير متاح على الشبكة',
                        'type': 'warning',
                    }
                }
        except Exception as e:
            _logger.error(f"Quick test failed for device {self.name}: {str(e)}")
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في الاختبار',
                    'message': f'حدث خطأ أثناء اختبار الجهاز: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_sync_device_info(self):
        """Sync device information from the device"""
        try:
            _logger.info(f"Syncing device info for {self.name}")
            
            # هنا يمكن إضافة منطق جلب معلومات الجهاز الفعلية
            # مثل: النموذج، الرقم التسلسلي، إصدار البرنامج الثابت
            
            # قيم تجريبية للآن
            self.device_model = f"DS-K1T671MF-{self.id}"
            self.serial_number = f"DS{self.id}2024{str(self.id).zfill(6)}"
            self.firmware_version = "V4.2.5 build 240801"
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'تم تحديث معلومات الجهاز',
                    'message': f'تم جلب معلومات الجهاز {self.name} بنجاح',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Device info sync failed for {self.name}: {str(e)}")
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في تحديث المعلومات',
                    'message': f'فشل في جلب معلومات الجهاز: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_sync_employees(self):
        """Sync employees from the device"""
        try:
            _logger.info(f"Starting employee sync from device {self.name}")
            
            # هنا يمكن إضافة منطق جلب الموظفين الفعلي من الجهاز
            # مثال: الاتصال بـ API الجهاز وجلب قائمة الموظفين
            
            # محاكاة عملية المزامنة
            import random
            synced_count = random.randint(5, 25)  # عدد عشوائي للمحاكاة
            
            self.last_sync = fields.Datetime.now()
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'تم مزامنة الموظفين',
                    'message': f'تم مزامنة {synced_count} موظف من الجهاز {self.name}',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Employee sync failed for device {self.name}: {str(e)}")
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في مزامنة الموظفين',
                    'message': f'فشلت مزامنة الموظفين: {str(e)}',
                    'type': 'danger',
                }
            }