import 'package:flutter/material.dart';

/// File này dùng để bọc các nhóm như "Huyết áp", "Đường huyết"
/// bao gồm tiêu đề, nút khôi phục và các ô nhập liệu.
class AlertSectionGroup extends StatelessWidget {
  final String title;
  final String unitLabel;
  final List<Widget> children;

  const AlertSectionGroup({
    super.key,
    required this.title,
    required this.unitLabel,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hàng tiêu đề: Tiêu đề bên trái - Nút khôi phục bên phải
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
              // Nút Khôi phục mặc định (Chỉ hiển thị khi là nhóm Huyết Áp)
              if (title == "Huyết Áp")
                GestureDetector(
                  onTap: () {
                    // Logic khôi phục mặc định của bạn ở đây
                  },
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

        // Đường kẻ xám dưới tiêu đề
        const Padding(
          padding: EdgeInsets.only(bottom: 8, top: 4),
          child: Divider(color: Colors.grey, thickness: 0.8),
        ),

        // Nhãn ngưỡng (ví dụ: Ngưỡng cảnh báo (mmHg))
        Text(
          unitLabel,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        ),

        const SizedBox(height: 10),

        // Các ô nhập liệu (ThresholdInputField)
        ...children,

        const SizedBox(height: 8), // Khoảng cách đệm cuối mỗi nhóm
      ],
    );
  }
}