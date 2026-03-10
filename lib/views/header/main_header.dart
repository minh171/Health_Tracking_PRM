import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_vm.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class MainHeader extends StatelessWidget implements PreferredSizeWidget {
  final String subTitle;

  const MainHeader({
    super.key,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    final firstLetter = homeVM.userName.isNotEmpty ? homeVM.userName[0].toUpperCase() : 'U';

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 90,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset('assets/logo-removebg.png', fit: BoxFit.contain),
            ),
          ),
          title: const Text(
            'Health Tracker',
            style: TextStyle(
              color: Color(0xFF379AE6),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                // --- THAY THẾ CIRCLEAVATAR ĐỂ PHÓNG TO VÀ XÓA NỀN ---
                child: Container(
                  width: 45, // Tăng kích thước từ 36 lên 45
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent, // Đảm bảo nền trong suốt
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.5),
                    child: Image.asset(
                      'assets/avatar_default.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Trường hợp lỗi ảnh thì mới hiện nền màu và chữ cái
                        return Container(
                          color: const Color(0xFF379AE6),
                          alignment: Alignment.center,
                          child: Text(
                            firstLetter,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // ------------------------------------------------
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: const Color(0xFF379AE6),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            subTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(106);
}