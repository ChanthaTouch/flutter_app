import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/sale.dart';

class AppProvider extends ChangeNotifier {
  AppUser? _currentUser;
  final List<Sale> _sales = [];

  // ===============================================
  //  ROLE MAP - Add new users here easily
  // ===============================================
  static final Map<String, UserRole> _roleMap = {
    // === MANAGERS ===
    'punleu@company.com':           UserRole.manager,
    'punleu.manager@company.com':   UserRole.manager,
    'manager@email.com':            UserRole.manager,
    'admin@company.com':            UserRole.manager,
    'sokha@company.com':            UserRole.manager,

    // === STAFF ===
    'staff@company.com':            UserRole.staff,
    'lina@email.com':               UserRole.staff,
    'dara@email.com':               UserRole.staff,
    'chantha@company.com':          UserRole.staff,
    'vannak@company.com':           UserRole.staff,
  };

  static const UserRole _defaultRole = UserRole.staff;

  AppUser? get currentUser => _currentUser;
  List<Sale> get sales => List.unmodifiable(_sales);

  double get todayTotal => _sales.fold(0.0, (sum, sale) => sum + sale.totalPrice);

  double get performancePercent {
    const double dailyTarget = 2000;
    if (dailyTarget == 0) return 0;
    return (todayTotal / dailyTarget) * 100;
  }

  bool get isManager => _currentUser?.role == UserRole.manager;
  bool get isStaff   => _currentUser?.role == UserRole.staff;

  void login(String email) {
    final lowerEmail = email.trim().toLowerCase();

    final role = _roleMap[lowerEmail] ?? _defaultRole;

    _currentUser = AppUser(
      name: _generateDisplayName(lowerEmail, role),
      email: email,
      role: role,
    );

    notifyListeners();
  }

  String _generateDisplayName(String email, UserRole role) {
    final namePart = email.split('@')[0];
    final capitalized = namePart
        .split('.')
        .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join(' ');

    return role == UserRole.manager
        ? 'Manager $capitalized'
        : 'Staff $capitalized';
  }

  void addSale(Sale sale) {
    _sales.add(sale);
    notifyListeners();
  }

  void clearSales() {
    _sales.clear();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _sales.clear();
    notifyListeners();
  }
}