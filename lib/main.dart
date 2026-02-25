import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/login_screen.dart';
import 'screens/staff_dashboard_screen.dart';
import 'screens/manager_dashboard_screen.dart';
import 'screens/add_sale_screen.dart';
import 'screens/report_screen.dart';
import 'screens/set_target_screen.dart';
import 'screens/choose_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Sales Management',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              useMaterial3: true,
            ),
            initialRoute: provider.currentUser == null ? '/login' : 
                         (provider.isManager ? '/manager' : '/staff'),
            routes: {
              '/login':          (_) => const LoginScreen(),
              '/staff':          (_) => const StaffDashboardScreen(),
              '/manager':        (_) => const ManagerDashboardScreen(),
              '/add-sale':       (_) => const AddSaleScreen(),
              '/report':         (_) => const ReportScreen(),
              '/set-target':     (_) => const SetTargetScreen(),
              '/choose-product': (_) => const ChooseProductScreen(),
            },
            onGenerateRoute: (settings) {
              // Optional: add more protection here if needed
              return null;
            },
          );
        },
      ),
    );
  }
}