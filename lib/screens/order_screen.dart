import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../models/order_item.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/app_header.dart';
import '../widgets/checkout_bar.dart';
import '../widgets/extras_panel.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/order_summary.dart';
import '../widgets/section_title.dart';
import '../widgets/size_selector.dart';
import '../widgets/tip_slider.dart';

/// The order screen. It owns all of the order STATE and passes
/// values + callbacks down to widgets.
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // ---------- STATE ----------
  final Map<String, int> _quantities = {};
  PizzaSize _size = PizzaSize.medium;
  bool _extraCheese = false;
  bool _wantsSauces = false;
  final Set<String> _selectedSauces = {};
  double _tipPercent = 15;

  // ---------- HELPERS ----------
  int _qty(OrderItem item) => _quantities[item.id] ?? 0;

  double _unitPrice(OrderItem item) => item.price + _size.upcharge;

  int get _itemCount =>
      _quantities.values.fold(0, (sum, qty) => sum + qty);

  // ---------- PRICE CALCULATIONS ----------
  double get _itemsSubtotal {
    double sum = 0;
    for (final item in menuItems) {
      sum += _qty(item) * _unitPrice(item);
    }
    return sum;
  }

  double get _extrasTotal {
    final cheese = _extraCheese ? _itemCount * extraCheesePrice : 0.0;
    final sauces = _wantsSauces ? _selectedSauces.length * saucePrice : 0.0;
    return cheese + sauces;
  }

  double get _subtotal => _itemsSubtotal + _extrasTotal;
  double get _tax => _subtotal * taxRate;
  double get _tip => _subtotal * (_tipPercent / 100);
  double get _total => _subtotal + _tax + _tip;

  List<MapEntry<String, double>> get _summaryLines => [
        for (final item in menuItems)
          if (_qty(item) > 0)
            MapEntry(
              '${_qty(item)} × ${item.name} (${_size.label})',
              _qty(item) * _unitPrice(item),
            ),
      ];

  // ---------- ACTIONS ----------
  void _add(OrderItem item) {
    setState(() {
      _quantities[item.id] = _qty(item) + 1;
    });
  }

  void _remove(OrderItem item) {
    setState(() {
      final next = _qty(item) - 1;
      if (next <= 0) {
        _quantities.remove(item.id);
      } else {
        _quantities[item.id] = next;
      }
    });
  }

  void _toggleSauce(String sauce) {
    setState(() {
      if (_selectedSauces.contains(sauce)) {
        _selectedSauces.remove(sauce);
      } else {
        _selectedSauces.add(sauce);
      }
    });
  }

  void _resetOrder() {
    setState(() {
      _quantities.clear();
      _size = PizzaSize.medium;
      _extraCheese = false;
      _wantsSauces = false;
      _selectedSauces.clear();
      _tipPercent = 15;
    });
  }

  /// Shows the confirmation dialog. If the user confirms,
  /// shows a success message and resets the order.
  Future<void> _confirmOrder() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Confirm your order',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in _summaryLines)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(line.key),
              ),
            if (_extraCheese) const Text('+ Extra cheese'),
            if (_wantsSauces && _selectedSauces.isNotEmpty)
              Text('+ Sauces: ${_selectedSauces.join(', ')}'),
            const SizedBox(height: 12),
            Text(
              'Total: ${money(_total)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.tomato,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep editing'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.tomato),
            child: const Text('Place order'),
          ),
        ],
      ),
    );

    // Stop if they tapped "Keep editing", tapped outside, or the screen is gone
    if (confirmed != true || !mounted) return;

    final placedTotal = _total; // save it before we reset
    _resetOrder();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.basil,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Text(
          '🍕 Order placed! ${money(placedTotal)} — your pizza is in the oven.',
        ),
      ),
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NEW UI ELEMENT (not covered in Module 2): SingleChildScrollView
      // lets the screen scroll, so it works in landscape and on small phones.
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    'Pick your size',
                    subtitle: 'Applies to every pizza in your order',
                  ),
                  SizeSelector(
                    selected: _size,
                    onChanged: (newSize) {
                      setState(() => _size = newSize);
                    },
                  ),
                  SectionTitle(
                    'Menu',
                    subtitle: '$_itemCount in your box',
                  ),
                  for (final item in menuItems)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MenuItemCard(
                        item: item,
                        displayPrice: _unitPrice(item),
                        quantity: _qty(item),
                        onAdd: () => _add(item),
                        onRemove: () => _remove(item),
                      ),
                    ),
                  const SectionTitle('Make it extra'),
                  ExtrasPanel(
                    extraCheese: _extraCheese,
                    onExtraCheeseChanged: (value) {
                      setState(() => _extraCheese = value);
                    },
                    wantsSauces: _wantsSauces,
                    onWantsSaucesChanged: (value) {
                      setState(() {
                        _wantsSauces = value;
                        if (!value) _selectedSauces.clear();
                      });
                    },
                    selectedSauces: _selectedSauces,
                    onSauceToggled: _toggleSauce,
                  ),
                  const SectionTitle('Tip'),
                  TipSlider(
                    tipPercent: _tipPercent,
                    tipAmount: _tip,
                    onChanged: (value) {
                      setState(() => _tipPercent = value);
                    },
                  ),
                  const SectionTitle('Your order'),
                  OrderSummary(
                    lines: _summaryLines,
                    extras: _extrasTotal,
                    tax: _tax,
                    tip: _tip,
                    total: _total,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBar(
        itemCount: _itemCount,
        total: _total,
        // null disables the button when nothing is in the box
        onPlaceOrder: _itemCount == 0 ? null : _confirmOrder,
      ),
    );
  }
}