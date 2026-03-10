import 'package:flutter/material.dart';

class CustomInput {
  // Tách phần trang trí ô nhập liệu
  static InputDecoration decoration({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool? obscured,
    VoidCallback? onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF4A90E2), size: 22),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(obscured! ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBBBBBB)),
        onPressed: onToggle,
      )
          : null,
      hintStyle: const TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      filled: true,
      fillColor: const Color(0xFFF9F9F9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFF0F0F0))),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
    );
  }

  // Tách phần Label có dấu * đỏ
  static Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF444444)),
          children: const [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
        ),
      ),
    );
  }
}