import 'package:flutter/material.dart';
import '../../../core/services/research_service.dart' as research_service;
import '../../../core/models/research_model.dart';

class LibraryController extends ChangeNotifier {
  List<ResearchModel> _researchItems = [];
  bool _isLoading = false;
  String? _error;

  List<ResearchModel> get researchItems => _researchItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRecentResearch({String query = 'artificial intelligence', int rows = 10}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _researchItems = await research_service.fetchRecentResearch(query: query, rows: rows);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}