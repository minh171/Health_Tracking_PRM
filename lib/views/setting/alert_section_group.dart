import 'package:flutter/material.dart';

class AlertSectionGroup extends StatelessWidget {
  final String title;
  final String unitLabel;
  final List<Widget> children;
  final VoidCallback? onReset; // Thêm callback này

  const AlertSectionGroup({
    super.key,
    required this.title,
    required this.unitLabel,
    required this.children,
    this.onReset, // Truyền qua constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF379AE6),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Hiển thị nút khôi phục nếu có truyền hàm xử lý
              if (onReset != null)
                GestureDetector(
                  onTap: onReset, // Gọi hàm show dialog ở trang cha
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF379AE6), width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Khôi phục mặc định",
                      style: TextStyle(
                        color: Color(0xFF379AE6),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.only(bottom: 8, top: 4),
          child: Divider(color: Colors.grey, thickness: 0.8),
        ),

        Text(
          unitLabel,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 10),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }
}