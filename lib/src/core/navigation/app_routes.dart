import 'package:flutter/material.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/utn_validation_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/upload/upload_page.dart';
import '../presentation/pages/processing/processing_page.dart';
import '../presentation/pages/playback/playback_page.dart';
import '../presentation/pages/settings/settings_page.dart';
import '../data/models/playback_arguments.dart';

enum AppRoute {
  login('/login', LoginPage()),
  utnValidation('/utn-validation', UTNValidationPage()),
  home('/home', HomePage()),
  pdfUpload('/pdf-upload', UploadPage()),
  processing('/processing', ProcessingPage.new),
  playback('/playback', PlaybackPage.new),
  settings('/settings', SettingsPage());

  final String path;
  final dynamic page;
  const AppRoute(this.path, this.page);
}
