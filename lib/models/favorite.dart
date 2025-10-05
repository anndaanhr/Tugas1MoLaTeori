import 'perfume.dart';

/// Model class untuk merepresentasikan parfum favorit pengguna dalam sistem.
/// Menyimpan informasi parfum yang disukai beserta metadata kapan ditambahkan.
///
/// Model ini berperan sebagai bridge antara UI dan database lokal.
/// Menyediakan method untuk konversi antara objek Dart dan Map database.
///
/// Design principles:
/// - Immutable dengan final fields untuk thread safety
/// - Factory constructor untuk pembuatan dari database
/// - Method toMap() untuk penyimpanan ke database
/// - Proper equality override untuk collection operations
class Favorite {
  /// ID unik untuk setiap entry favorite dalam database.
  /// Bisa null untuk objek yang baru dibuat sebelum disimpan ke database.
  /// Diisi otomatis oleh database dengan AUTOINCREMENT.
  final int? id;

  /// Objek parfum yang difavoritkan oleh pengguna.
  /// Berisi informasi lengkap parfum termasuk nama, brand, accords, deskripsi, dan gambar.
  final Perfume perfume;

  /// Timestamp kapan parfum pertama kali ditambahkan ke favorites.
  /// Menggunakan DateTime untuk presisi waktu dan kemudahan query.
  /// Disimpan sebagai ISO 8601 string di database untuk kompatibilitas.
  final DateTime addedAt;

  /// Constructor untuk membuat objek Favorite dengan parameter required.
  /// ID bisa null untuk objek baru yang belum disimpan ke database.
  /// Menggunakan const untuk optimasi compile-time ketika memungkinkan.
  ///
  /// Parameter: id - ID unik dari database (opsional)
  /// Parameter: perfume - Objek parfum yang difavoritkan (wajib)
  /// Parameter: addedAt - Timestamp kapan ditambahkan (wajib)
  const Favorite({
    this.id,
    required this.perfume,
    required this.addedAt,
  });

  /// Factory constructor untuk membuat objek Favorite dari Map database.
  /// Digunakan ketika mengambil data dari SQLite dan mengkonversinya ke objek Dart.
  /// Memastikan semua field yang diperlukan ada dan valid sebelum objek dibuat.
  ///
  /// Parameter: map - Map dari hasil query database
  /// Return: Objek Favorite yang baru dibuat dari data database
  /// Throws: FormatException jika ada field yang missing atau format tidak valid
  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] as int?,
      perfume: Perfume(
        name: map['perfume_name'] as String,
        brand: map['perfume_brand'] as String,
        accords: map['perfume_accords'] as String,
        description: map['perfume_description'] as String,
        imagePath: map['perfume_image_path'] as String,
      ),
      addedAt: DateTime.parse(map['added_at'] as String),
    );
  }

  /// Method untuk mengkonversi objek Favorite ke Map untuk penyimpanan database.
  /// Map yang dihasilkan sesuai dengan struktur tabel favorites di SQLite.
  /// Field id tidak diikutsertakan karena akan diisi otomatis oleh database.
  ///
  /// Return: Map representasi Favorite dalam format database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perfume_name': perfume.name,
      'perfume_brand': perfume.brand,
      'perfume_accords': perfume.accords,
      'perfume_description': perfume.description,
      'perfume_image_path': perfume.imagePath,
      'added_at': addedAt.toIso8601String(),
    };
  }

  /// Override operator equality untuk membandingkan objek Favorite.
  /// Dua Favorite dianggap sama jika memiliki parfum dan timestamp yang sama.
  /// Diperlukan untuk operasi seperti filtering dan pencarian di collections.
  ///
  /// @param other Object yang akan dibandingkan
  /// @return bool True jika objek sama, false jika berbeda
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Favorite &&
        other.perfume == perfume &&
        other.addedAt == addedAt;
  }

  /// Override hashCode untuk konsistensi dengan operator equality.
  /// Menggunakan perfume dan addedAt sebagai komponen hash.
  /// Penting untuk performa saat menggunakan Favorite dalam Set atau Map.
  ///
  /// @return int Hash code unik untuk objek ini
  @override
  int get hashCode => perfume.hashCode ^ addedAt.hashCode;

  /// Override toString untuk debugging dan logging yang lebih informatif.
  /// Menampilkan informasi penting Favorite dalam format yang mudah dibaca.
  /// Berguna untuk debugging dan pencatatan log aplikasi.
  ///
  /// @return String Representasi string dari objek Favorite
  @override
  String toString() => 'Favorite(perfume: ${perfume.name}, addedAt: $addedAt)';
}
