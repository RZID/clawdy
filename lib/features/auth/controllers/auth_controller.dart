import 'package:flutter/material.dart';
import '../../../core/controllers/app_controller.dart';

class AuthController extends ChangeNotifier {
  final AppController _appController;

  AuthController(this._appController);

  Future<bool> login(String email, String password) async {
    final result = await _appController.login(email, password);
    return result.isValid;
  }

  Future<void> logout() async {
    await _appController.logout();
  }

  String get userEmail => _appController.userEmail;
  bool get isLoggedIn => _appController.isLoggedIn;
}