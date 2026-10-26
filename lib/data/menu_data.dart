import '../models/order_item.dart';

/// Pizza items
const List<OrderItem> menuItems = [
  OrderItem(
    id: 'margherita',
    name: 'Margherita',
    description: 'tomato, mozzarella, basil',
    price: 11.99,
    emoji: '🍅',
  ),
  OrderItem(
    id: 'pepperoni',
    name: 'Classic Pepperoni',
    description: 'pepperoni, mozzarella',
    price: 13.49,
    emoji: '🍕',
  ),
  OrderItem(
    id: 'bbq',
    name: 'BBQ Chicken',
    description: 'BBQ sauce, chicken, red onion, cilantro',
    price: 14.99,
    emoji: '🍗',
  ),
  OrderItem(
    id: 'veggie',
    name: 'Veggie',
    description: 'Peppers, mushrooms, olives, spinach',
    price: 12.99,
    emoji: '🫑',
  ),
];

/// Dipping sauces
const List<String> dippingSauces = ['Ranch', 'Garlic Butter', 'Marinara', 'Buffalo'];

const double extraCheesePrice = 1.50; // per pizza
const double saucePrice = 0.75; // per sauce cup
const double taxRate = 0.08; // 8% sales tax