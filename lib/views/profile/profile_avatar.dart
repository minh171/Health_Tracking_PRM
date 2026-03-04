import 'package:flutter/material.dart';

/// Widget này chứa logic hiển thị ảnh đại diện và tên/ID bên dưới.
class ProfileAvatar extends StatelessWidget {
  final String name;
  final String id;
  final String imageUrl;

  const ProfileAvatar({
    super.key,
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF323842)
          ),
        ),
        Text(
          "ID: $id",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}