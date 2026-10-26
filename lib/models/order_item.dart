/// Describes one thing on the menu.
class OrderItem {
  final String id;
  final String name;
  final String description;
  final double price; // base price = Medium
  final String emoji;

  const OrderItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
  });
}

/// The three pizza sizes. Each one adds/subtracts from the base price.
enum PizzaSize {
  small('Small', '10"', -2.00),
  medium('Medium', '12"', 0.00),
  large('Large', '14"', 3.00);

  const PizzaSize(this.label, this.inches, this.upcharge);

  final String label;
  final String inches;
  final double upcharge;
}