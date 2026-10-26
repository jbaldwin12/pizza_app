import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/format.dart';

/// Bar pinned to the bottom of the screen with the live total
/// and the Place Order button.
/// CONDITIONAL UI: the button is disabled (grey) while the box is empty.
class CheckoutBar extends StatelessWidget {
  final int itemCount;
  final double total;
  final VoidCallback? onPlaceOrder; // null = button disabled

  const CheckoutBar({
    super.key,
    required this.itemCount,
    required this.total,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      // SafeArea keeps the bar above the phone's home indicator
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemCount == 1 ? '1 item' : '$itemCount items',
                    style: const TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                  Text(
                    money(total),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: onPlaceOrder,
                    icon: const Icon(Icons.local_pizza),
                    label: const Text(
                      'Place Order',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.tomato,
                      disabledBackgroundColor: AppColors.cardBorder,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}