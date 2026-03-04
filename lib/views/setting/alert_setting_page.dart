import 'package:flutter/material.dart';
import 'package:health_tracking/views/setting/settings_page.dart';
import 'package:health_tracking/views/setting/threshold_input_field.dart';
import '../chart/chart_page.dart';
import '../footer/main_footer.dart';
import '../header/main_header.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import 'advanced_settings_modal.dart';
import 'alert_section_group.dart';
import 'basic_info_card.dart';


/// trang cài đặt cảnh báo
class AlertSettingPage extends StatelessWidget {
  const AlertSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainHeader(subTitle: 'Cài đặt cảnh báo'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nút quay về thủ công
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: Color(0xFF379AE6), size: 18),
                  const Text(
                    "Quay lại",
                    style: TextStyle(color: Color(0xFF379AE6), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const BasicInfoCard(),
            const SizedBox(height: 24),

            // 2. Nhóm Huyết Áp
            const AlertSectionGroup(
              title: "Huyết Áp",
              unitLabel: "Ngưỡng cảnh báo (mmHg)",
              children: [
                ThresholdInputField(label: "Tâm thu tối thiểu", unit: "mmHg"),
                ThresholdInputField(label: "Tâm thu tối đa", unit: "mmHg"),
                ThresholdInputField(
                  label: "Tâm trương tối thiểu",
                  unit: "mmHg",
                ),
                ThresholdInputField(label: "Tâm trương tối đa", unit: "mmHg"),
              ],
            ),

            // 3. Nhóm Đường huyết
            const AlertSectionGroup(
              title: "Đường huyết",
              unitLabel: "Ngưỡng cảnh báo (mg/dL)",
              children: [
                ThresholdInputField(label: "Giá trị tối thiểu", unit: "mg/dL"),
                ThresholdInputField(label: "Giá trị tối đa", unit: "mg/dL"),
              ],
            ),

            // 4. Nhóm Cân nặng
            const AlertSectionGroup(
              title: "Cân nặng",
              unitLabel: "Ngưỡng cảnh báo (kg)",
              children: [
                ThresholdInputField(label: "Giá trị tối thiểu", unit: "kg"),
                ThresholdInputField(label: "Giá trị tối đa", unit: "kg"),
              ],
            ),

            // 5. Nhóm SpO2
            const AlertSectionGroup(
              title: "SpO2",
              unitLabel: "Ngưỡng cảnh báo (%)",
              children: [
                ThresholdInputField(label: "Giá trị tối thiểu", unit: "%"),
                ThresholdInputField(label: "Giá trị tối đa", unit: "%"),
              ],
            ),

            const SizedBox(height: 30),

            // 6. Nút bấm cuối trang
            _buildBottomButtons(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 4, // Fix cứng là 4 để icon Cài đặt luôn sáng ở trang này
        onTap: (index) {
          if (index == 4)
            return; // Nếu đang ở trang cài đặt mà bấm lại thì thôi

          // Chuyển trang đơn giản bằng Navigator
          Widget nextPage;
          switch (index) {
            case 0: nextPage = const HomePage(); break;
            case 1:
              nextPage = const HealthRecordPage();
              break;
            case 2: nextPage = const ChartPage(); break;
            case 3: nextPage = const NotificationPage(); break;
            case 4:
              nextPage = const SettingsPage();
              break;
            default:
              nextPage = const HomePage();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const AdvancedSettingsModal(),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF1F8FD),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Cài đặt nâng cao",
            style: TextStyle(color: Color(0xFF379AE6)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF379AE6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Lưu cấu hình",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
