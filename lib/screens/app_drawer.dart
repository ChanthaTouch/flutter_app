import 'package:flutter/material.dart';
import 'staff_dashboard_screen.dart';
import 'manager_dashboard_screen.dart';
import 'set_target_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF438E46)),
            accountName: Text("Punleu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            accountEmail: Text("punleu.manager@company.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 45, color: Color(0xFF438E46)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Staff Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StaffDashboardScreen()));
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
            child: Text("MANAGER PANEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings_outlined, color: Color(0xFF4A89DC)),
            title: const Text('Manager Overview'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ManagerDashboardScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.track_changes_outlined, color: Color(0xFF4A89DC)),
            title: const Text('Set Staff Targets'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SetTargetScreen()));
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}