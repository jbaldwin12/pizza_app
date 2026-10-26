import 'package:flutter/material.dart';

import '../models/order_item.dart';
import '../theme.dart';

/// Lets the user pick one pizza size.
/// Uses SegmentedButton (Material 3 single-choice toggle).
class SizeSelector extends StatelessWidget {
  final PizzaSize selected;
  final ValueChanged<PizzaSize> onChanged;

  const SizeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  String _upchargeText(PizzaSize size) {
    if (size.upcharge == 0) return 'base price';
    final sign = size.upcharge > 0 ? '+' : '−';
    return '$sign\$${size.upcharge.abs().toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<PizzaSize>(
        showSelectedIcon: false,
        segments: [
          for (final size in PizzaSize.values)
            ButtonSegment<PizzaSize>(
              value: size,
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${size.label} ${size.inches}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      _upchargeText(size),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
        ],
        selected: {selected},
        onSelectionChanged: (newSelection) => onChanged(newSelection.first),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.tomato
                : Colors.white,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white
                : AppColors.charcoal,
          ),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.cardBorder),
          ),
        ),
      ),
    );
  }
}