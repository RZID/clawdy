import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/services/camera_service.dart';

class CameraController extends ChangeNotifier {
  File? _capturedImage;

  File? get capturedImage => _capturedImage;

  Future<void> captureDocument() async {
    _capturedImage = await CameraService.pickImageFromCamera();
    notifyListeners();
  }

  void clearImage() {
    _capturedImage = null;
    notifyListeners();
  }
}