
import 'package:flutter/material.dart';
import '../chart/chart_page.dart';
import '../header/main_header.dart';
import '../footer/main_footer.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../setting/settings_page.dart';
import 'filter_item.dart';
import 'notification_card.dart';


/// trang chính của thông báo kết quả
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Trạng thái lọc hiện tại
  String selectedFilter = "Tất cả";

  // Dữ liệu Fake (Bạn có thể tách nốt cái này ra file constants.dart nếu muốn)
  final List<Map<String, dynamic>> fakeData = [
    {
      "title": "Huyết áp cao",
      "content": "Huyết áp tâm thu của bạn đã vượt ngưỡng: 141/74 mmHg. Vui lòng theo dõi và tham khảo ý kiến bác sĩ nếu tình trạng kéo dài.",
      "type": "Nguy hiểm",
      "time": "22:32 30/01/2026",
      "isRead": true,
    },
    {
      "title": "Nhịp tim bất thường",
      "content": "Phát hiện nhịp tim đập nhanh liên tục trong 5 phút qua. Hãy ngồi nghỉ ngơi và hít thở sâu.",
      "type": "Nguy hiểm",
      "time": "20:15 30/01/2026",
      "isRead": true,
    },
    {
      "title": "Huyết áp thấp",
      "content": "Nồng độ oxy trong máu của bạn thấp hơn bình thường: 85%. Vui lòng liên hệ bác sĩ ngay nếu bạn cảm thấy khó thở hoặc mệt mỏi.",
      "type": "Cần chú ý",
      "time": "22:32 30/01/2026",
      "isRead": true,
    },
    {
      "title": "Đường huyết biến động",
      "content": "Chỉ số đường huyết sáng nay của bạn hơi cao so với mục tiêu. Hãy kiểm tra lại chế độ ăn uống.",
      "type": "Cần chú ý",
      "time": "07:30 30/01/2026",
      "isRead": true,
    },
    {
      "title": "Huyết áp ổn định",
      "content": "Huyết áp của bạn ổn định. Chỉ số hiện tại: 120/80 mmHg.",
      "type": "Ổn định",
      "time": "22:32 30/01/2026",
      "isRead": false,
    },
    {
      "title": "SpO2 tuyệt vời",
      "content": "Nồng độ Oxy trong máu của bạn đạt 99%. Đây là chỉ số rất tốt.",
      "type": "Ổn định",
      "time": "15:00 30/01/2026",
      "isRead": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Logic lọc dữ liệu
    final displayData = selectedFilter == "Tất cả"
        ? fakeData
        : fakeData.where((item) => item["type"] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const MainHeader(subTitle: 'Thông cáo kết quả'),
      body: Column(
        children: [
          // --- 1. Nhóm Filter (Dùng Widget đã tách) ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Tất cả", "Ổn định", "Cần chú ý", "Nguy hiểm"]
                  .map((label) => FilterItem(
                label: label,
                isSelected: selectedFilter == label,
                onTap: () => setState(() => selectedFilter = label),
              ))
                  .toList(),
            ),
          ),

          // --- 2. Danh sách thông báo (Dùng Widget đã tách) ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: displayData.length,
              itemBuilder: (context, index) {
                return NotificationCard(data: displayData[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          // Chuyển trang đơn giản bằng Navigator
          Widget nextPage;
          switch (index) {
            case 0: nextPage = const HomePage(); break;
            case 1: nextPage = const HealthRecordPage(); break;
            case 2: nextPage = const ChartPage(); break;
            case 3: nextPage = const NotificationPage(); break;
            case 4: nextPage = const SettingsPage(); break;
            default: nextPage = const HomePage();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
      ),
    );
  }

}