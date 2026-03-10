import 'package:flutter/material.dart';

/// Widget này dùng để hiển thị các dòng thông tin với icon và text.
/// Đã được cập nhật để hỗ trợ tự động xuống dòng khi nội dung quá dài.
class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        // Căn lề đỉnh (start) để khi text xuống dòng, icon và label vẫn nằm ở dòng đầu tiên
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF379AE6), size: 24),
          const SizedBox(width: 15),

          // Giới hạn chiều rộng cố định hoặc linh hoạt cho label
          SizedBox(
            width: 80, // Độ rộng này đảm bảo nhãn không bị co quá nhỏ
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF565D6D),
                  fontWeight: FontWeight.w500
              ),
            ),
          ),

          const SizedBox(width: 10),

          // SỬA ĐỔI CHÍNH: Thay Spacer bằng Expanded
          Expanded(
            child: Text(
              value,
              // Căn lề phải để giữ phong cách cũ, nhưng sẽ xuống dòng nếu quá dài
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF323842)
              ),
              softWrap: true, // Cho phép xuống dòng
            ),
          ),
        ],
      ),
    );
  }
}