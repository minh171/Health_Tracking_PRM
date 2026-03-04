
import 'package:flutter/material.dart';

class MainFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFF379AE6),
      unselectedItemColor: const Color(0xFF565D6D),
      currentIndex: currentIndex, // Đây là cái giúp icon được sáng lên (highlight)
      onTap: onTap, // Gọi hàm chuyển trang được truyền vào
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Chỉ số'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Biểu đồ'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Thông báo'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Cài đặt'),
      ],
    );
  }
}