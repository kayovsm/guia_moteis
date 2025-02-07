import 'package:flutter/material.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import '../services/api_service.dart';

class MotelProvider with ChangeNotifier {
  final List<MotelModel> _motels = [];
  bool _isLoading = false;
  String? _errorMessage;
  final ApiService apiService;

  MotelProvider({required this.apiService});

  List<MotelModel> get motels => _motels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _motels.clear();
      _motels.addAll(await apiService.fetchMotels());
      _errorMessage = null;
    } catch (e) {
      _motels.clear();
      _errorMessage = e.toString();

      print('LOG * ERROR PROVIDER: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
