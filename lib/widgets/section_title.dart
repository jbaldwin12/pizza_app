import 'package:flutter/material.dart';

import '../theme.dart';

/// Heading used above each section of the order screen.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle; // optional

  const SectionTitle(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ],
        ],
      ),
    );
  }
}