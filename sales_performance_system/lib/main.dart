import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/sales_provider.dart';
import 'providers/targets_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, SalesProvider>(
          create: (context) => SalesProvider(
            context.read<AuthProvider>().apiService,
          ),
          update: (context, auth, previous) => SalesProvider(auth.apiService),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TargetsProvider>(
          create: (context) => TargetsProvider(
            context.read<AuthProvider>().apiService,
          ),
          update: (context, auth, previous) => TargetsProvider(auth.apiService),
        ),
      ],
      child: MaterialApp(
        title: 'Sales Performance System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
