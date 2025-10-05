import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/login_page.dart';

/// Entry point utama aplikasi Flutter.
/// Menginisialisasi aplikasi dengan tema Material 3 dan halaman login sebagai root.
void main() {
  runApp(const PerfumeCatalogApp());
}

/// Widget root aplikasi katalog parfum.
/// Mengkonfigurasi tema global dan route utama aplikasi.
class PerfumeCatalogApp extends StatelessWidget {
  /// Constructor untuk PerfumeCatalogApp.
  const PerfumeCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Judul aplikasi.
      title: 'Perfume Catalog',

      /// Tema aplikasi menggunakan konfigurasi dari theme.dart.
      theme: appTheme,

      /// Halaman awal aplikasi adalah LoginPage.
      home: const LoginPage(),

      /// Menonaktifkan debug banner untuk production-like experience.
      debugShowCheckedModeBanner: false,
    );
  }
}
