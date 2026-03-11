import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://backendsalemanagment-o28vv.sevalla.app';
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  String? getToken() => _token;

  void clearToken() {
    _token = null;
  }

  Map<String, String> _getHeaders({bool includeAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (includeAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Auth endpoints
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: _getHeaders(includeAuth: false),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          setToken(data['token']);
        }
        return data;
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<void> logout() async {
    try {
      await http.post(
        Uri.parse('$baseUrl/api/logout'),
        headers: _getHeaders(),
      );
      clearToken();
    } catch (e) {
      debugPrint('Logout error: $e');
      clearToken();
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/user'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get user error: $e');
    }
  }

  // Sales endpoints
  Future<List<dynamic>> getSales() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/sales'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get sales: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get sales error: $e');
    }
  }

  Future<Map<String, dynamic>> createSale(Map<String, dynamic> saleData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/sales'),
        headers: _getHeaders(),
        body: jsonEncode(saleData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create sale: ${response.body}');
      }
    } catch (e) {
      throw Exception('Create sale error: $e');
    }
  }

  // Targets endpoints
  Future<List<dynamic>> getTargets() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/targets'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get targets: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get targets error: $e');
    }
  }

  Future<Map<String, dynamic>> createTarget(Map<String, dynamic> targetData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/targets'),
        headers: _getHeaders(),
        body: jsonEncode(targetData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create target: ${response.body}');
      }
    } catch (e) {
      throw Exception('Create target error: $e');
    }
  }
}
