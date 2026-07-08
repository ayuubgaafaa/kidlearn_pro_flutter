import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String userName;
  final String userRole;
  final int starCount;

  const WelcomeCard({
    super.key,
    required this.userName,
    required this.userRole,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 2))],
        border: Border(left: BorderSide(color: const Color(0xFF4CAF50), width: 4)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5D5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(child: Icon(Icons.person, color: Color(0xFF46A302), size: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $userName! 👋',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2B2B2B)),
                ),
                const SizedBox(height: 2),
                Text(
                  userRole,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5D5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text('⭐', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  '$starCount',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF46A302)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
