import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/login_screen.dart';
import 'screens/staff_dashboard_screen.dart';
import 'screens/manager_dashboard_screen.dart';
import 'screens/report_screen.dart';
import 'screens/add_sale_screen.dart';
import 'screens/set_target_screen.dart';
import 'screens/choose_product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sale Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/staff': (_) => const StaffDashboardScreen(),
        '/manager': (_) => const ManagerDashboardScreen(),
        '/report': (_) => const ReportScreen(),
        '/add-sale': (_) => const AddSaleScreen(),
        '/set-target': (_) => const SetTargetScreen(),
        '/choose-product': (_) => const ChooseProductScreen(),
      },
    );
  }
}