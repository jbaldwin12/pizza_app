import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../theme.dart';

/// Extra cheese switch + dipping sauces switch.
/// CONDITIONAL UI: the sauce chips only appear when the sauces switch is ON.
class ExtrasPanel extends StatelessWidget {
  final bool extraCheese;
  final ValueChanged<bool> onExtraCheeseChanged;
  final bool wantsSauces;
  final ValueChanged<bool> onWantsSaucesChanged;
  final Set<String> selectedSauces;
  final ValueChanged<String> onSauceToggled;

  const ExtrasPanel({
    super.key,
    required this.extraCheese,
    required this.onExtraCheeseChanged,
    required this.wantsSauces,
    required this.onWantsSaucesChanged,
    required this.selectedSauces,
    required this.onSauceToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          SwitchListTile(
            value: extraCheese,
            onChanged: onExtraCheeseChanged,
            activeThumbColor: AppColors.basil,
            secondary: const Text('🧀', style: TextStyle(fontSize: 24)),
            title: const Text(
              'Extra cheese',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '+\$${extraCheesePrice.toStringAsFixed(2)} per pizza',
            ),
          ),
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: AppColors.cardBorder,
          ),
          SwitchListTile(
            value: wantsSauces,
            onChanged: onWantsSaucesChanged,
            activeThumbColor: AppColors.basil,
            secondary: const Text('🥣', style: TextStyle(fontSize: 24)),
            title: const Text(
              'Dipping sauces',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text('+\$${saucePrice.toStringAsFixed(2)} each'),
          ),
          if (wantsSauces)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final sauce in dippingSauces)
                      FilterChip(
                        label: Text(sauce),
                        selected: selectedSauces.contains(sauce),
                        onSelected: (_) => onSauceToggled(sauce),
                        selectedColor: const Color(0x263E7B3A), // light basil
                        checkmarkColor: AppColors.basil,
                        backgroundColor: Colors.white,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}