import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import ViewModels
import '../../viewmodels/login_vm.dart';
import '../../viewmodels/profile_vm.dart';

import 'package:health_tracking/views/profile/profile_page.dart';
import '../chart/chart_page.dart';
import '../footer/main_footer.dart';
import '../header/main_header.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../notification/notification_page.dart';
import 'alert_setting_page.dart';
import 'medical_sources_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Đảm bảo dữ liệu profile được nạp khi vào trang settings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginVM = context.read<LoginViewModel>();
      if (loginVM.currentAccount?.id != null) {
        context.read<ProfileViewModel>().fetchProfile(loginVM.currentAccount!.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lắng nghe dữ liệu từ các ViewModel
    final loginVM = context.watch<LoginViewModel>();
    final profileVM = context.watch<ProfileViewModel>();
    final profile = profileVM.userProfile;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainHeader(subTitle: 'Cài đặt'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Thông tin người dùng (Data thật)
            _buildUserHeader(
              name: profileVM.getDisplayValue(profile?.fullName),
              email: loginVM.currentAccount?.email ?? "Chưa có email",
              avatarAsset: 'assets/avatar_default.png',
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            // 2. Danh sách Menu
            _buildMenuItem(
              icon: Icons.person_outline,
              text: 'Hồ sơ cá nhân',
              color: Colors.black,
              onTap: () => _navigateTo(const ProfilePage()),
            ),

            _buildMenuItem(
              icon: Icons.settings_outlined,
              text: 'Cài đặt cảnh báo',
              color: Colors.black,
              onTap: () => _navigateTo(const AlertSettingPage()),
            ),

            _buildMenuItem(
              icon: Icons.menu_book_outlined,
              text: 'Nguồn tài liệu y khoa',
              color: Colors.black,
              onTap: () => _navigateTo(const MedicalSourcesPage()),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            // 3. Nút Đăng xuất
            _buildMenuItem(
              icon: Icons.logout,
              text: 'Đăng xuất',
              color: const Color(0xFFDE3B40),
              onTap: () {
                // Hiển thị hộp thoại xác nhận trước khi thoát (Tùy chọn nhưng nên có)
                _showLogoutDialog(context);
              },
            ),

            const SizedBox(height: 20),

            // 4. Hình ảnh minh họa
            _buildIllustration(),

            const SizedBox(height: 20),

            // 5. Bản quyền
            const Text(
              '© 2026 Health Tracker. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 4,
        onTap: (index) => _onFooterTap(index),
      ),
    );
  }

  // Cập nhật User Header với data thật và Avatar mới
  Widget _buildUserHeader({required String name, required String email, required String avatarAsset}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Avatar phóng to, không nền, dùng asset chung
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.5),
              child: Image.asset(
                avatarAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF379AE6),
                  child: const Icon(Icons.person, color: Colors.white, size: 35),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))
                ),
                const SizedBox(height: 4),
                Text(
                    email,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/health-tracking-setting.webp',
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _onFooterTap(int index) {
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Màu nền body là màu trắng
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Để dialog ôm vừa nội dung
            children: [
              // --- TIÊU ĐỀ: Nền xanh dương, chữ trắng ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFF379AE6), // Màu xanh dương thương hiệu của bạn
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  'Xác nhận đăng xuất',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Chữ tiêu đề màu trắng
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // --- BODY: Chữ đen ---
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  'Bạn có chắc chắn muốn thoát khỏi tài khoản này không?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Chữ body màu đen
                    fontSize: 16,
                  ),
                ),
              ),

              // --- ACTIONS: Nút bấm ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    // Nút Hủy: Nền xám nhẹ, chữ đen/xám
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200, // Nền xám nhẹ
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Hủy',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Nút Đăng xuất: Nền đỏ, chữ trắng
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDE3B40), // Màu đỏ
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(color: Colors.white), // Chữ trắng
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}