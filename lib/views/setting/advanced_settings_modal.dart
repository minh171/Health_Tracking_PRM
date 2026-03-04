import 'package:flutter/material.dart';

/// cài đặt nâng cao
class AdvancedSettingsModal extends StatelessWidget {
  const AdvancedSettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Cài đặt nâng cao',
              style: TextStyle(color: Color(0xFF379AE6), fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.grey),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chọn bệnh sẽ tự động điều chỉnh các chỉ số theo chuẩn bệnh lý.',
            style: TextStyle(color: Color(0xFF565D6D), fontSize: 13),
          ),
          const SizedBox(height: 16),
          const Text('Chọn bệnh', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildDropdown(),
        ],
      ),
      actions: [_buildActions(context)],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Colors.white,
          hint: const Text("Chọn bệnh", style: TextStyle(fontSize: 14)),
          items: ['Tiểu đường', 'Cao huyết áp', 'Tim mạch'].map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey, width: 0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: const Text('Hủy', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF379AE6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 0,
          ),
          child: const Text('Lưu', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}