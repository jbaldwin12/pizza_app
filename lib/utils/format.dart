/// Formats a number as dollars.  Example: 12.5  ->  "$12.50"
String money(double value) => '\$${value.toStringAsFixed(2)}';