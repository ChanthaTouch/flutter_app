import 'package:flutter/foundation.dart';
import '../models/sale.dart';
import '../services/api_service.dart';

class SalesProvider with ChangeNotifier {
  final ApiService _apiService;
  List<Sale> _sales = [];
  bool _isLoading = false;
  String? _error;

  SalesProvider(this._apiService);

  List<Sale> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSales() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getSales();
      _sales = response.map((json) => Sale.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createSale(Sale sale) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.createSale(sale.toJson());
      await fetchSales();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
