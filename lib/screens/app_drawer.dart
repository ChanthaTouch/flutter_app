import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../screens/staff_dashboard_screen.dart';
import '../screens/manager_dashboard_screen.dart';
import '../screens/set_target_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final user = provider.currentUser;

    if (user == null) return const SizedBox.shrink();

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF438E46)),
            accountName: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(user.email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 45, color: Color(0xFF438E46)),
            ),
          ),

          // Common items (if any)

          if (provider.isStaff) ...[
            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text('My Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/staff');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Add Sale'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add-sale');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('Daily Report'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/report');
              },
            ),
          ],

          if (provider.isManager) ...[
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "MANAGER TOOLS",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Color(0xFF4A89DC)),
              title: const Text('Manager Overview'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/manager');
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes, color: Color(0xFF4A89DC)),
              title: const Text('Set Staff Targets'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/set-target');
              },
            ),
          ],

          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              provider.logout();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}