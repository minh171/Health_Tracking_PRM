import 'package:flutter/material.dart';
import '../chart/chart_page.dart';
import '../footer/main_footer.dart';
import '../header/main_header.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import 'alert_setting_page.dart';

/// trang cài đặt
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainHeader(subTitle: 'Cài đặt'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Phần Thông tin người dùng (Avatar + Name + Email)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF1A237E),
                    child: Text(
                      'A',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Admin User',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'admin@healthtracker.com',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Đường kẻ ngang kéo dài hết màn hình
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            // 2. Danh sách Menu
            _buildMenuItem(
              icon: Icons.person_outline,
              text: 'Hồ sơ cá nhân',
              color: Colors.black,
              onTap: () {
                // Chuyển sang trang profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),

            _buildMenuItem(
              icon: Icons.settings_outlined,
              text: 'Cài đặt cảnh báo',
              color: Colors.black,
              onTap: () {
                // Chuyển sang trang AlertSettingPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlertSettingPage()),
                );
              },
            ),

            // Đường kẻ ngang trước phần Sign Out
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            // 3. Nút Sign Out
            _buildMenuItem(
              icon: Icons.logout,
              text: 'Đăng xuất',
              color: const Color(0xFFDE3B40),
              onTap: () {
                // đăng xuất
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),

            const SizedBox(height: 20),

            // 4. Hình ảnh minh họa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/health-tracking-setting.webp',
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Bản quyền App
            const Text(
              '© 2026 Health Tracker. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),


      bottomNavigationBar: MainFooter(
        currentIndex: 4, // Fix cứng là 4 để icon Cài đặt luôn sáng ở trang này
        onTap: (index) {
          if (index == 4) return; // Nếu đang ở trang cài đặt mà bấm lại thì thôi

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

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap, // Thêm tham số này
  }) {
    return InkWell(
      onTap: onTap, // Gán hành động vào đây
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}