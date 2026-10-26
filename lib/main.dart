import 'package:flutter/material.dart';

import 'screens/order_screen.dart';
import 'theme.dart';

void main() => runApp(const PizzaOrderApp());

class PizzaOrderApp extends StatelessWidget {
  const PizzaOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.tomato),
        scaffoldBackgroundColor: AppColors.cream,
      ),
      home: const OrderScreen(),
    );
  }
}