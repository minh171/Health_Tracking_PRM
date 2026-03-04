import 'package:flutter/material.dart';
import 'package:health_tracking/views/profile/profile_avatar.dart';
import 'package:health_tracking/views/profile/profile_info_tile.dart';
import '../chart/chart_page.dart';
import '../header/main_header.dart';
import '../footer/main_footer.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import '../setting/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const MainHeader(subTitle: 'Hồ sơ cá nhân'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBackButton(context),
            const SizedBox(height: 10),

            // Sử dụng ProfileAvatar đã tách
            const ProfileAvatar(
              name: "Nguyễn Văn A",
              id: "HT-99210",
              imageUrl: 'https://ui-avatars.com/api/?name=Van+A&background=379AE6&color=fff&size=120',
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    const ProfileInfoTile(icon: Icons.person_outline, label: "Họ và tên", value: "Nguyễn Văn A"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.email_outlined, label: "Gmail", value: "nguyenvana@gmail.com"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.cake_outlined, label: "Ngày sinh", value: "20/10/1995"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.transgender_outlined, label: "Giới tính", value: "Nam"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.height_outlined, label: "Chiều cao", value: "175 cm"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.monitor_weight_outlined, label: "Cân nặng", value: "70 kg"),
                    _buildDivider(),
                    const ProfileInfoTile(icon: Icons.medical_services_outlined, label: "Tình trạng", value: "Tiểu đường Type 2"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
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
      ),    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF379AE6)),
            SizedBox(width: 5),
            Text("Quay về trang cài đặt", style: TextStyle(color: Color(0xFF379AE6), fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 60, endIndent: 20, color: Colors.grey.shade100);
  }
}