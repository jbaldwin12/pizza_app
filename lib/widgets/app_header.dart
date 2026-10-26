import 'package:flutter/material.dart';

import '../theme.dart';

/// Red banner at the top with the logo, store name, and tagline.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.tomato, AppColors.tomatoDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        children: [
          // Logo: a pizza emoji inside a white circle
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Text('🍕', style: TextStyle(fontSize: 38)),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pizzeria',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Wood-fired pizza · Ready in 25 min',
                  style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}