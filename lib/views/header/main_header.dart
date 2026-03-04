
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget implements PreferredSizeWidget {
  // Loại bỏ phần gán cứng nội dung ở đây
  final String subTitle;

  const MainHeader({
    super.key,
    required this.subTitle, // Chuyển thành required để ép buộc các trang phải truyền vào
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 90,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Image.asset('assets/logo-removebg.png', fit: BoxFit.contain),
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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1A237E),
                child: Text('A', style: TextStyle(color: Colors.white)),
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
            subTitle, // Nội dung này giờ đây hoàn toàn phụ thuộc vào trang gọi nó
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              // Thêm độ đậm cho đẹp
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(106); // Tinh chỉnh lại chiều cao cho chuẩn
}