import 'package:flutter/material.dart';

class AlertSectionGroup extends StatelessWidget {
  final String title;
  final String unitLabel;
  final List<Widget> children;
  final VoidCallback? onReset;
  final bool isEnabled; // Thêm biến kiểm soát trạng thái active

  const AlertSectionGroup({
    super.key,
    required this.title,
    required this.unitLabel,
    required this.children,
    this.onReset,
    this.isEnabled = true, // Mặc định là true
  });

  @override
  Widget build(BuildContext context) {
    // Màu sắc chủ đạo dựa trên trạng thái enable
    final Color activeColor = const Color(0xFF379AE6);
    final Color disabledColor = Colors.grey.shade400;
    final Color currentColor = isEnabled ? activeColor : disabledColor;
    final Color titleColor = const Color(0xFF379AE6);

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
                style: TextStyle(
                  color: titleColor, // Đổi màu tiêu đề theo trạng thái
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Hiển thị nút khôi phục
              if (onReset != null)
                GestureDetector(
                  // Chỉ cho phép gọi hàm reset khi isEnabled = true
                  onTap: isEnabled ? onReset : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: currentColor, width: 1),
                      borderRadius: BorderRadius.circular(4),
                      color: isEnabled ? Colors.transparent : Colors.grey.shade50,
                    ),
                    child: Text(
                      "Khôi phục mặc định",
                      style: TextStyle(
                        color: currentColor,
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