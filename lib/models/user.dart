enum UserRole { staff, manager }

class AppUser {
  final String name;
  final String email;
  final UserRole role;

  AppUser({
    required this.name,
    required this.email,
    required this.role,
  });
}