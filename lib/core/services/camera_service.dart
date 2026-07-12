import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo == null) return null;
      return File(photo.path);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }
}

/*
MANUAL SETUP REQUIRED — add to avoid runtime crash:

--- Android (android/app/src/main/AndroidManifest.xml) ---
Add inside <manifest> (before <application>):
  <uses-permission android:name="android.permission.CAMERA" />
Add inside <application>:
  <provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.flutter.image_picker"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
      android:name="android.support.FILE_PROVIDER_PATHS"
      android:resource="@xml/file_paths" />
  </provider>
Create android/app/src/main/res/xml/file_paths.xml:
  <?xml version="1.0" encoding="utf-8"?>
  <paths>
    <files-path name="flutter_image_picker" path="flutter_image_picker/"/>
  </paths>

--- iOS (ios/Runner/Info.plist) ---
Add inside <dict>:
  <key>NSCameraUsageDescription</key>
  <string>This app needs camera access to capture research document photos.</string>
*/