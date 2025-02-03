import 'package:flutter/material.dart';

class FollowUsBottomSheet extends StatelessWidget {
  const FollowUsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildOption(
            iconPath: 'assets/youtube_icon.png',
            iconColor: Colors.red,
            title: "@mirwaizfoundation",
            subtitle: "Follow us on Youtube",
          ),
          _buildOption(
            iconPath: 'assets/insta_icon.png',
            iconColor: Colors.black,
            title: "@mirwaizfoundation",
            subtitle: "Follow us on Instagram",
          ),
          _buildOption(
            iconPath: 'assets/person_raised_hand.png',
            iconColor: Colors.black54,
            title: "Ask the Aalim",
            subtitle: "",
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Follow Us",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildOption({
    required String iconPath,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            iconPath,
            scale: 2,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: const TextStyle(color: Colors.black54))
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      ),
    );
  }
}
