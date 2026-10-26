import 'package:flutter/material.dart';

import '../theme.dart';

/// Shows an "Add" button when quantity is 0, otherwise  −  qty  +.
/// CONDITIONAL UI: what is shown depends on the quantity.
class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return FilledButton(
        onPressed: onAdd,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.tomato,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w700)),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0x14C8371E), // light tomato tint
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.remove, size: 18),
            color: AppColors.tomato,
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(
            width: 24,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
            color: AppColors.tomato,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}