import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/sale.dart';

class AppProvider extends ChangeNotifier {
  AppUser? _currentUser;
  final List<Sale> _sales = [
    Sale(customerName: 'Customer A', totalPrice: 30, date: DateTime.now()),
    Sale(customerName: 'Customer B', totalPrice: 30, date: DateTime.now()),
  ];

  AppUser? get currentUser => _currentUser;
  List<Sale> get sales => _sales;

  double get todayTotal => _sales.fold(0.0, (sum, sale) => sum + sale.totalPrice);

  double get performancePercent {
    const double dailyTarget = 2000;
    return (todayTotal / dailyTarget) * 100;
  }

  void login(String email) {
    final isManager = email.toLowerCase().contains('manager');
    _currentUser = AppUser(
      name: isManager ? 'Punleu Manager' : 'Punleu',
      email: email,
      role: isManager ? UserRole.manager : UserRole.staff,
    );
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void addSale(Sale sale) {
    _sales.add(sale);
    notifyListeners();
  }
}