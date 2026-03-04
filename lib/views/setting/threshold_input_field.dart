import 'package:flutter/material.dart';

/// File này dùng để tạo ra từng ô nhập liệu nhỏ (ví dụ: "Tâm thu tối thiểu").
class ThresholdInputField extends StatelessWidget {
  final String label;
  final String unit;

  const ThresholdInputField({
    super.key,
    required this.label,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black, fontSize: 13)),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: Container(
                  padding: const EdgeInsets.only(right: 12),
                  alignment: Alignment.centerRight,
                  width: 60,
                  child: Text(unit, style: const TextStyle(color: Color(0xFF565D6D), fontSize: 13)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}