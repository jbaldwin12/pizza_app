import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/format.dart';

/// One "label/amount" line in the receipt. Reused for every row.
class SummaryRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool emphasize; // true for the Total row

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: emphasize ? 18 : 14,
                fontWeight: emphasize ? FontWeight.w800 : FontWeight.w500,
                color: emphasize ? AppColors.charcoal : AppColors.muted,
              ),
            ),
          ),
          Text(
            money(amount),
            style: TextStyle(
              fontSize: emphasize ? 18 : 14,
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
              color: emphasize ? AppColors.tomato : AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

/// Receipt card.
/// CONDITIONAL UI: shows an "empty box" message until an item is added,
/// then shows the full price breakdown.
class OrderSummary extends StatelessWidget {
  final List<MapEntry<String, double>> lines; // e.g. "2 × Margherita" -> 23.98
  final double extras;
  final double tax;
  final double tip;
  final double total;

  const OrderSummary({
    super.key,
    required this.lines,
    required this.extras,
    required this.tax,
    required this.tip,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.cardBorder),
    );

    if (lines.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: decoration,
        child: const Column(
          children: [
            Text('📦', style: TextStyle(fontSize: 36)),
            SizedBox(height: 8),
            Text(
              'Your box is empty',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4),
            Text(
              'Add a pizza above to get started.',
              style: TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: decoration,
      child: Column(
        children: [
          for (final line in lines)
            SummaryRow(label: line.key, amount: line.value),
          if (extras > 0) SummaryRow(label: 'Extras', amount: extras),
          // NEW UI ELEMENT (not covered in Module 2): Divider
          const Divider(height: 20, color: AppColors.cardBorder),
          SummaryRow(label: 'Tax (8%)', amount: tax),
          SummaryRow(label: 'Tip', amount: tip),
          const SizedBox(height: 6),
          SummaryRow(label: 'Total', amount: total, emphasize: true),
        ],
      ),
    );
  }
}