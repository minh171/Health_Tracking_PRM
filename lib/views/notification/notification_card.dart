import 'package:flutter/material.dart';
import 'notification_detail_page.dart'; // Đảm bảo đường dẫn này đúng với file chi tiết bạn vừa tạo

/// trang tạo ra các card thông báo
class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;
    Color tagColor;
    Color tagTextColor = Colors.white;

    // Thiết lập giao diện dựa trên loại thông báo
    switch (data["type"]) {
      case "Nguy hiểm":
        iconData = Icons.dangerous;
        iconColor = Colors.red;
        tagColor = const Color(0xFFDE3B40);
        break;
      case "Cần chú ý":
        iconData = Icons.warning_amber_rounded;
        iconColor = const Color(0xFFEFB034);
        tagColor = const Color(0xFFEFB034);
        tagTextColor = Colors.black;
        break;
      default: // Ổn định
        iconData = Icons.check_circle;
        iconColor = const Color(0xFF20BD54);
        tagColor = const Color(0xFF20BD54);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, color: iconColor, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data["title"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  data["type"],
                  style: TextStyle(color: tagTextColor, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            data["content"],
            style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data["time"], style: const TextStyle(fontSize: 13, color: Colors.grey)),
              Row(
                children: [
                  Icon(
                    data["isRead"] ? Icons.visibility : Icons.visibility_off,
                    size: 16,
                    color: const Color(0xFF565D6D),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data["isRead"] ? "Đã xem" : "Chưa xem",
                    style: const TextStyle(fontSize: 14, color: Color(0xFF565D6D)),
                  ),
                  const SizedBox(width: 12),
                  // Bọc nút bấm bằng GestureDetector để bắt sự kiện click
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationDetailPage(data: data),
                        ),
                      );
                    },
                    child: _buildDetailButton(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "Xem chi tiết",
        style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}