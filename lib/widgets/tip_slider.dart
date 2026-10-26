import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/format.dart';

/// Tip picker card.
/// NEW UI ELEMENT (not covered in Module 2): Slider
/// A draggable control from 0% to 25% that snaps to 5% steps (divisions)
/// and shows a value label bubble while dragging.
class TipSlider extends StatelessWidget {
  final double tipPercent;
  final double tipAmount;
  final ValueChanged<double> onChanged;

  const TipSlider({
    super.key,
    required this.tipPercent,
    required this.tipAmount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Tip your driver',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(), // pushes the badge to the right edge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1F3E7B3A), // light basil
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${tipPercent.round()}%  ·  ${money(tipAmount)}',
                  style: const TextStyle(
                    color: AppColors.basil,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: tipPercent,
            min: 0,
            max: 25,
            divisions: 5, // 0, 5, 10, 15, 20, 25
            label: '${tipPercent.round()}%',
            activeColor: AppColors.tomato,
            onChanged: onChanged,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0%', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                Text('25%', style: TextStyle(color: AppColors.muted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}