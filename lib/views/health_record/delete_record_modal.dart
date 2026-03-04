import 'package:flutter/material.dart';

class DeleteRecordModal extends StatelessWidget {
  final String title;

  const DeleteRecordModal({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const Text(
                  'XÁC NHẬN XÓA BẢN GHI',
                  style: TextStyle(
                    color: Color(0xFFDE3B40), // Màu đỏ đặc trưng
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputLabel("Thời điểm đo"),
              _buildInputField(hint: "Chọn lịch", suffixIcon: Icons.calendar_today),

              // Nội dung hiển thị tùy biến dựa trên tiêu đề (title)
              if (title == "Huyết áp") ...[
                _buildInputLabel("Tâm thu (mmHg)"),
                _buildInputField(hint: "Nhập số liệu"),
                _buildInputLabel("Tâm trương (mmHg)"),
                _buildInputField(hint: "Nhập số liệu"),
                _buildInputLabel("Nhịp tim (bpm)"),
                _buildInputField(hint: "Nhập số liệu"),
              ] else if (title == "Đường huyết") ...[
                _buildInputLabel("Đường huyết (mg/dL)"),
                _buildInputField(hint: "Nhập số liệu"),
                _buildInputLabel("Trạng thái"),
                _buildInputField(hint: "Nhập trạng thái"),
              ] else if (title == "Cân nặng") ...[
                _buildInputLabel("Cân nặng (kg)"),
                _buildInputField(hint: "Nhập số liệu"),
              ] else if (title == "SpO2") ...[
                _buildInputLabel("Giá trị (%)"),
                _buildInputField(hint: "Nhập số liệu"),
              ],

              _buildInputLabel("Ghi chú"),
              _buildInputField(hint: "Nhập ghi chú"),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Nút Hủy
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text("Hủy", style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 10),
              // Nút Xóa (Màu đỏ)
              ElevatedButton(
                onPressed: () => Navigator.pop(context), // Xử lý xóa ở đây
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDE3B40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text("Xóa", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF334155), fontSize: 14),
      ),
    );
  }

  Widget _buildInputField({required String hint, IconData? suffixIcon}) {
    return TextField(
      enabled: false, // Để là false nếu chỉ muốn người dùng xem trước khi xóa
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20, color: Colors.grey) : null,
        filled: true,
        fillColor: const Color(0xFFF8FAFC), // Nền hơi xám nhẹ cho ô nhập liệu
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
    );
  }
}