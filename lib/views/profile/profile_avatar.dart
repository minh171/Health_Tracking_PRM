import 'package:flutter/material.dart';

/// Widget hiển thị ảnh đại diện từ Assets và thông tin người dùng
class ProfileAvatar extends StatelessWidget {
  final String name;
  final String id;
  final String imageUrl;

  const ProfileAvatar({
    super.key,
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            // CẬP NHẬT TẠI ĐÂY: Chuyển từ Image.network sang Image.asset
            child: Image.asset(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              // Xử lý lỗi nếu không tìm thấy file ảnh trong assets
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 80, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF323842)
          ),
        ),
        const SizedBox(height: 4),
        Text(
          id, // id đã được format "ID: ..." từ ProfilePage truyền sang
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}