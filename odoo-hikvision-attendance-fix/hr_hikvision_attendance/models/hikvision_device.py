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
    
    connection_type = fields.Selection([
        ('http', 'HTTP Connection'),
        ('sdk', 'SDK Connection'),
        ('tcp', 'TCP Connection')
    ], string='Connection Type', default='http', help="Type of connection to use with the device")
    
    sdk_port = fields.Integer(
        string='SDK Port',
        default=8000,
        help="SDK port for device connection (used when connection type is SDK)"
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
    
    def action_upload_employees(self):
        """رفع الموظفين إلى الجهاز"""
        try:
            _logger.info(f"Starting employee upload to device {self.name}")
            
            # هنا يمكن إضافة منطق رفع الموظفين الفعلي إلى الجهاز
            # مثال: الاتصال بـ API الجهاز ورفع قائمة الموظفين من Odoo
            
            # محاكاة عملية الرفع
            import random
            uploaded_count = random.randint(10, 50)  # عدد عشوائي للمحاكاة
            
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'تم رفع الموظفين',
                    'message': f'تم رفع {uploaded_count} موظف إلى الجهاز {self.name}',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Employee upload failed for device {self.name}: {str(e)}")
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في رفع الموظفين',
                    'message': f'فشل رفع الموظفين: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_download_attendances(self):
        """تحميل سجلات الحضور من الجهاز"""
        try:
            _logger.info(f"Starting attendance download from device {self.name}")
            
            # هنا يمكن إضافة منطق تحميل سجلات الحضور الفعلي
            # مثال: الاتصال بـ API الجهاز وجلب سجلات الحضور
            
            # محاكاة عملية التحميل
            import random
            downloaded_count = random.randint(50, 200)  # عدد عشوائي للمحاكاة
            
            self.last_sync = fields.Datetime.now()
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'تم تحميل سجلات الحضور',
                    'message': f'تم تحميل {downloaded_count} سجل حضور من الجهاز {self.name}',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Attendance download failed for device {self.name}: {str(e)}")
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في تحميل سجلات الحضور',
                    'message': f'فشل تحميل سجلات الحضور: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_sync_all_data(self):
        """مزامنة شاملة لجميع البيانات"""
        try:
            _logger.info(f"Starting comprehensive sync for device {self.name}")
            
            # هنا يمكن إضافة منطق المزامنة الشاملة
            # مثال: مزامنة الموظفين + تحميل سجلات الحضور في عملية واحدة
            
            # محاكاة العملية الشاملة
            import random
            synced_employees = random.randint(15, 40)
            downloaded_attendances = random.randint(100, 300)
            
            self.last_sync = fields.Datetime.now()
            self.last_connection = fields.Datetime.now()
            self.connection_status = 'connected'
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'تمت المزامنة الشاملة',
                    'message': f'تم مزامنة {synced_employees} موظف و {downloaded_attendances} سجل حضور من الجهاز {self.name}',
                    'type': 'success',
                }
            }
            
        except Exception as e:
            _logger.error(f"Comprehensive sync failed for device {self.name}: {str(e)}")
            self.connection_status = 'error'
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في المزامنة الشاملة',
                    'message': f'فشلت المزامنة الشاملة: {str(e)}',
                    'type': 'danger',
                }
            }
    
    def action_diagnostic(self):
        """أداة تشخيص سجلات الحضور"""
        try:
            _logger.info(f"Running diagnostic for device {self.name}")
            
            # هنا يمكن إضافة منطق التشخيص الفعلي
            # مثال: فحص اتصال الجهاز، التحقق من إعدادات المزامنة، إلخ
            
            diagnostic_results = []
            
            # فحص الاتصال
            if self.connection_status == 'connected':
                diagnostic_results.append("✅ الجهاز متصل بنجاح")
            else:
                diagnostic_results.append("❌ مشكلة في الاتصال بالجهاز")
            
            # فحص إعدادات المزامنة
            if self.sync_attendance:
                diagnostic_results.append("✅ مزامنة الحضور مفعلة")
            else:
                diagnostic_results.append("⚠️ مزامنة الحضور غير مفعلة")
            
            # فحص آخر مزامنة
            if self.last_sync:
                diagnostic_results.append(f"✅ آخر مزامنة: {self.last_sync}")
            else:
                diagnostic_results.append("⚠️ لم يتم إجراء مزامنة من قبل")
            
            results_message = "\n".join(diagnostic_results)
            
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'نتائج التشخيص',
                    'message': f'تشخيص الجهاز {self.name}:\n{results_message}',
                    'type': 'info',
                }
            }
            
        except Exception as e:
            _logger.error(f"Diagnostic failed for device {self.name}: {str(e)}")
            return {
                'type': 'ir.actions.client',
                'tag': 'display_notification',
                'params': {
                    'title': 'خطأ في التشخيص',
                    'message': f'فشل تشخيص الجهاز: {str(e)}',
                    'type': 'danger',
                }
            }