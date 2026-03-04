import 'package:flutter/material.dart';

/// Widget này dùng để hiển thị các dòng thông tin với icon và text.
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
        children: [
          Icon(icon, color: const Color(0xFF379AE6), size: 24),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF565D6D),
                fontWeight: FontWeight.w500
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323842)
            ),
          ),
        ],
      ),
    );
  }
}