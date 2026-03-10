import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThresholdInputField extends StatelessWidget {
  final String label;
  final String unit;
  final bool isEnabled;
  final TextEditingController? controller;
  final String? errorText; // Thêm tham số nhận thông báo lỗi từ ViewModel

  const ThresholdInputField({
    super.key,
    required this.label,
    required this.unit,
    this.isEnabled = false,
    this.controller,
    this.errorText, // Khởi tạo tham số mới
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
          // Loại bỏ SizedBox có height cố định để nhường chỗ cho errorText hiển thị bên dưới
          TextField(
            enabled: isEnabled,
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // chỉ cho nhập số và dấu chấm
            ],
            style: TextStyle(
              color: isEnabled ? Colors.black : Colors.grey.shade600,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: isEnabled ? Colors.white : Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              // Cấu hình hiển thị lỗi
              errorText: errorText,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 11, height: 0.8),

              // Border mặc định
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              // Border khi có lỗi
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              // Border khi đang nhập mà vẫn có lỗi
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),

              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF379AE6), width: 1.5),
              ),

              suffixIcon: Container(
                padding: const EdgeInsets.only(right: 12),
                alignment: Alignment.centerRight,
                width: 60,
                child: Text(
                  unit,
                  style: TextStyle(
                    color: isEnabled ? const Color(0xFF565D6D) : Colors.grey.shade400,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}