import 'package:flutter/material.dart';

/// Tema aplikasi dengan Material 3 design system.
/// Menggunakan color scheme berbasis seed color untuk konsistensi visual.
/// Tema ini diterapkan secara global pada aplikasi.
final ThemeData appTheme = ThemeData(
  /// Mengaktifkan Material 3 untuk desain modern.
  useMaterial3: true,

  /// Color scheme menggunakan seed color biru (#4E82C2).
  /// Flutter akan menghasilkan palette warna secara otomatis.
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF4E82C2),
  ),

  /// Tema untuk input field dengan outline border yang konsisten.
  inputDecorationTheme: const InputDecorationTheme(
    /// Border outline untuk semua input field.
    border: OutlineInputBorder(),
    /// Border ketika input dalam keadaan fokus.
    focusedBorder: OutlineInputBorder(),
    /// Border ketika input dalam keadaan error.
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    /// Content padding untuk spacing yang konsisten.
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  /// Tema untuk ListTile dengan padding yang konsisten.
  listTileTheme: const ListTileThemeData(
    /// Padding horizontal untuk semua list tile.
    horizontalTitleGap: 16,
    /// Padding vertikal untuk spacing yang rapi.
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),

  /// Tema untuk AppBar dengan elevation yang minimal.
  appBarTheme: const AppBarTheme(
    /// Elevation kecil untuk shadow yang subtle.
    elevation: 2,
    /// Center title untuk layout yang seimbang.
    centerTitle: true,
  ),
);
