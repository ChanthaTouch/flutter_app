import 'package:flutter/foundation.dart';
import '../models/target.dart';
import '../services/api_service.dart';

class TargetsProvider with ChangeNotifier {
  final ApiService _apiService;
  List<Target> _targets = [];
  bool _isLoading = false;
  String? _error;

  TargetsProvider(this._apiService);

  List<Target> get targets => _targets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTargets() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getTargets();
      _targets = response.map((json) => Target.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTarget(Target target) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.createTarget(target.toJson());
      await fetchTargets();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
