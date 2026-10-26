import 'package:flutter/material.dart';

import '../models/order_item.dart';
import '../theme.dart';
import 'quantity_control.dart';

/// One menu item shown as a card. Reused for every item in the menu.
class MenuItemCard extends StatelessWidget {
  final OrderItem item;
  final double displayPrice;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.displayPrice,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final selected = quantity > 0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        // CONDITIONAL STYLE: red border when the item is in the order
        border: Border.all(
          color: selected ? AppColors.tomato : AppColors.cardBorder,
          width: selected ? 1.6 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(item.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${displayPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.tomato,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QuantityControl(
            quantity: quantity,
            onAdd: onAdd,
            onRemove: onRemove,
          ),
        ],
      ),
    );
  }
}