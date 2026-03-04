import 'package:flutter/material.dart';
import '../chart/chart_page.dart';
import '../header/main_header.dart';
import '../footer/main_footer.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../setting/settings_page.dart';
import 'notification_page.dart';


/// trang xem chi tiết thông báo
class NotificationDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const MainHeader(subTitle: 'Thông cáo kết quả'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nút Quay về trang trước
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: Color(0xFF379AE6), size: 14),
                  const SizedBox(width: 4),
                  const Text(
                    "Quay về trang trước",
                    style: TextStyle(color: Color(0xFF379AE6), fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Ô Card căn giữa màn hình
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Để card co theo nội dung
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tiêu đề, Icon và Tag
                      Row(
                        children: [
                          const Icon(Icons.dangerous, color: Colors.red, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            "Huyết áp cao",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDE3B40),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Nguy hiểm",
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Thời gian thẳng hàng tiêu đề
                      Text(
                        data["time"] ?? "22:32 30/01/2026",
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),

                      const SizedBox(height: 24),

                      // Chữ Mô tả chi tiết căn giữa
                      const Center(
                        child: Text(
                          "Mô tả chi tiết",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF379AE6)
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Nội dung chi tiết
                      const Text(
                        "Hệ thống phát hiện huyết áp tâm thu của bệnh nhân Duy tăng lên 160 mmHg, vượt ngưỡng an toàn là 140 mmHg. Huyết áp tâm trương cũng đạt 95 mmHg, vượt ngưỡng 90 mmHg. Tình trạng này có thể báo hiệu nguy cơ tăng huyết áp cấp tính hoặc phản ứng bất lợi với thuốc. Cần theo dõi sát sao và can thiệp y tế ngay lập tức.",
                        style: TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      // Nút Xác nhận đã xem
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF379AE6),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Xác nhận đã xem",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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