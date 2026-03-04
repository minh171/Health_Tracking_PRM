
import 'package:flutter/material.dart';
import '../header/main_header.dart';
import '../footer/main_footer.dart';
import '../chart/chart_page.dart';
import '../health_record/health_record_page.dart';
import '../notification/notification_page.dart';
import '../setting/settings_page.dart';
import 'health_tip_card.dart';
import 'menu_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Hàm xử lý chuyển trang chung
  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const MainHeader(subTitle: 'Chào buổi sáng, User!'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bạn muốn kiểm tra gì hôm nay?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF565D6D)),
            ),
            const SizedBox(height: 25),

            // Lưới Menu (Đã dùng Widget tách riêng)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: [
                MenuCard(
                  title: "Chỉ số sức khỏe",
                  icon: Icons.favorite_rounded,
                  color: const Color(0xFFFFE8E8),
                  iconColor: Colors.redAccent,
                  onTap: () => _navigateTo(const HealthRecordPage()),
                ),
                MenuCard(
                  title: "Biểu đồ thống kê",
                  icon: Icons.bar_chart_rounded,
                  color: const Color(0xFFE3F2FD),
                  iconColor: const Color(0xFF379AE6),
                  onTap: () => _navigateTo(const ChartPage()),
                ),
                MenuCard(
                  title: "Thông báo",
                  icon: Icons.notifications_active_rounded,
                  color: const Color(0xFFFFF3E0),
                  iconColor: Colors.orangeAccent,
                  onTap: () => _navigateTo(const NotificationPage()),
                ),
                MenuCard(
                  title: "Cài đặt",
                  icon: Icons.settings_suggest_rounded,
                  color: const Color(0xFFE8F5E9),
                  iconColor: Colors.greenAccent.shade700,
                  onTap: () => _navigateTo(const SettingsPage()),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text("Lời khuyên cho bạn", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // Các mẹo sức khỏe (Đã dùng Widget tách riêng)
            const HealthTipCard(
              content: "Uống đủ 2L nước mỗi ngày giúp làn da khỏe mạnh hơn!",
              gradientColors: [Color(0xFF379AE6), Color(0xFF2028BD)],
            ),
            const SizedBox(height: 15),
            const HealthTipCard(
              content: "Ngủ đủ 7-8 tiếng giúp tăng cường hệ miễn dịch và trí nhớ.",
              gradientColors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          List<Widget> pages = [
            const HomePage(),
            const HealthRecordPage(),
            const ChartPage(),
            const NotificationPage(),
            const SettingsPage()
          ];
          _navigateTo(pages[index]);
        },
      ),
    );
  }
}