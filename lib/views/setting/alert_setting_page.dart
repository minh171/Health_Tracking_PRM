import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/alert_setting_vm.dart';
import '../../viewmodels/login_vm.dart';
import '../../viewmodels/profile_vm.dart';
import '../../views/setting/threshold_input_field.dart';
import '../footer/main_footer.dart';
import '../header/main_header.dart';
import '../home/home_page.dart';
import '../health_record/health_record_page.dart';
import '../chart/chart_page.dart';
import '../notification/notification_page.dart';
import '../setting/settings_page.dart';
import 'alert_section_group.dart';
import 'basic_info_card.dart';

class AlertSettingPage extends StatefulWidget {
  const AlertSettingPage({super.key});

  @override
  State<AlertSettingPage> createState() => _AlertSettingPageState();
}

class _AlertSettingPageState extends State<AlertSettingPage> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    final accountId = context.read<LoginViewModel>().currentAccount?.id;
    if (accountId != null) {
      context.read<AlertSettingViewModel>().loadSettings(accountId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final alertVM = context.watch<AlertSettingViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainHeader(subTitle: 'Cài đặt cảnh báo'),
      body: alertVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            const SizedBox(height: 16),
            const BasicInfoCard(),
            const SizedBox(height: 16),

            // 1. NHÓM HUYẾT ÁP
            AlertSectionGroup(
              title: "Huyết Áp",
              unitLabel: "Ngưỡng cảnh báo (mmHg)",
              onReset: () => _showConfirmResetDialog(),
              children: [
                _buildField(alertVM, "Tâm thu tối thiểu", "mmHg", "sys_min"),
                _buildField(alertVM, "Tâm thu tối đa", "mmHg", "sys_max"),
                _buildField(alertVM, "Tâm trương tối thiểu", "mmHg", "dia_min"),
                _buildField(alertVM, "Tâm trương tối đa", "mmHg", "dia_max"),
              ],
            ),

            // 2. NHÓM ĐƯỜNG HUYẾT
            AlertSectionGroup(
              title: "Đường huyết",
              unitLabel: "Ngưỡng cảnh báo (mg/dL)",
              children: [
                _buildField(alertVM, "Giá trị tối thiểu", "mg/dL", "glu_min"),
                _buildField(alertVM, "Giá trị tối đa", "mg/dL", "glu_max"),
              ],
            ),

            // 3. NHÓM CÂN NẶNG
            AlertSectionGroup(
              title: "Cân nặng",
              unitLabel: "Ngưỡng cảnh báo (kg)",
              children: [
                _buildField(alertVM, "Giá trị tối thiểu", "kg", "weight_min"),
                _buildField(alertVM, "Giá trị tối đa", "kg", "weight_max"),
              ],
            ),

            // 4. NHÓM SPO2
            AlertSectionGroup(
              title: "SpO2",
              unitLabel: "Ngưỡng cảnh báo (%)",
              children: [
                _buildField(alertVM, "Giá trị tối thiểu", "%", "spo2_min"),
                _buildField(alertVM, "Giá trị tối đa", "%", "spo2_max"),
              ],
            ),

            const SizedBox(height: 30),
            _buildBottomButtons(context, alertVM),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 4,
        onTap: (index) => _navigateTo(index),
      ),
    );
  }

  // Helper function để code gọn hơn
  Widget _buildField(AlertSettingViewModel vm, String label, String unit, String key) {
    return ThresholdInputField(
      label: label,
      unit: unit,
      isEnabled: isEditing,
      controller: vm.controllers[key],
      errorText: vm.errors[key], // Hiển thị lỗi đỏ từ VM
    );
  }

  // --- UI WIDGETS ---

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Row(
        children: [
          Icon(Icons.arrow_back_ios, color: Color(0xFF379AE6), size: 18),
          Text("Quay lại", style: TextStyle(color: Color(0xFF379AE6), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _showConfirmResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF379AE6),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: const Center(
            child: Text(
              "Xác nhận khôi phục",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: const Text(
          "Toàn bộ ngưỡng cảnh báo sẽ được tính toán lại dựa trên hồ sơ sức khỏe của bạn. Các thay đổi hiện tại sẽ bị ghi đè.",
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBDBDBD),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Hủy"),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleResetAction();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Khôi phục"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- LOGIC FUNCTIONS ---

  Future<void> _handleResetAction() async {
    final profileVM = context.read<ProfileViewModel>();
    final alertVM = context.read<AlertSettingViewModel>();
    final loginVM = context.read<LoginViewModel>();

    final accountId = loginVM.currentAccount?.id;
    final profile = profileVM.userProfile;

    final Map<String, int> diseaseMap = {
      'Tăng huyết áp': 1,
      'Tiểu đường': 2,
      'Bệnh tim mạch': 3,
      'Bệnh hô hấp': 4,
    };

    final List<int> diseaseIds = profileVM.diseases
        .where((name) => diseaseMap.containsKey(name))
        .map((name) => diseaseMap[name]!)
        .toList();

    if (accountId != null && profile != null) {
      bool success = await alertVM.resetToDefault(accountId, profile, diseaseIds);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã khôi phục ngưỡng mặc định"), backgroundColor: Colors.green),
        );
      }
    }
  }

  Widget _buildBottomButtons(BuildContext context, AlertSettingViewModel alertVM) {
    final accountId = context.read<LoginViewModel>().currentAccount?.id;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isEditing = !isEditing;
              if (!isEditing) alertVM.clearErrors(); // Xóa lỗi khi hủy chỉnh sửa
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isEditing ? Colors.grey[200] : const Color(0xFFF1F8FD),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            isEditing ? "Hủy chỉnh sửa" : "Chỉnh sửa cài đặt",
            style: TextStyle(color: isEditing ? Colors.black54 : const Color(0xFF379AE6)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: (isEditing && accountId != null)
              ? () async {
            // Chạy Validate trước khi lưu
            if (alertVM.validateSettings()) {
              bool success = await alertVM.saveAllSettings(accountId);
              if (success && mounted) {
                setState(() => isEditing = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lưu cấu hình thành công"), backgroundColor: Colors.green),
                );
              }
            } else {
              // Nếu có lỗi, thông báo nhẹ để người dùng chú ý các ô đỏ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Vui lòng kiểm tra các ô báo lỗi"), backgroundColor: Colors.redAccent),
              );
            }
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF379AE6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("Lưu cấu hình", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _navigateTo(int index) {
    if (index == 4) return;
    Widget nextPage;
    switch (index) {
      case 0: nextPage = const HomePage(); break;
      case 1: nextPage = const HealthRecordPage(); break;
      case 2: nextPage = const ChartPage(); break;
      case 3: nextPage = const NotificationPage(); break;
      default: nextPage = const HomePage();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextPage));
  }
}