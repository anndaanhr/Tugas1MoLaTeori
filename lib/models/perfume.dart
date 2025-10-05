/// Model class untuk merepresentasikan parfum dalam katalog.
/// Kelas ini bersifat immutable dengan constructor const untuk optimasi.
///
/// Menyimpan informasi lengkap tentang parfum termasuk:
/// - Identitas parfum (nama, brand)
/// - Karakteristik aroma (accords, deskripsi)
/// - Asset visual (gambar lokal)
///
/// Design principles:
/// - Immutable untuk thread safety dan predictability
/// - Const constructor untuk compile-time optimization
/// - Required parameters untuk memastikan data integrity
class Perfume {
  /// Nama parfum - nama produk parfum yang akan ditampilkan kepada pengguna.
  /// Merupakan identifier utama parfum dalam katalog.
  final String name;

  /// Brand parfum - nama perusahaan atau brand yang memproduksi parfum.
  /// Memberikan konteks tentang produsen dan positioning parfum.
  final String brand;

  /// Accords parfum - kategori aroma utama (contoh: "Fresh • Citrus").
  /// Menjelaskan karakteristik utama aroma parfum dalam bentuk tag yang mudah dipahami.
  /// Biasanya berisi 2-3 kata kunci utama yang mendeskripsikan profil aroma.
  final String accords;

  /// Deskripsi parfum - penjelasan detail tentang aroma dan karakter parfum.
  /// Berisi informasi mendalam tentang komposisi, karakter, dan kesan parfum.
  /// Dalam format terstruktur: Top Notes, Middle Notes, Base Notes untuk readability.
  final String description;

  /// Path gambar parfum - path relatif ke asset gambar lokal parfum.
  /// Menggunakan format 'assets/images/nama_file.jpg' untuk akses gambar.
  /// Harus sesuai dengan file gambar yang ada di folder assets/images/.
  final String imagePath;

  /// Constructor untuk membuat objek Perfume dengan semua field required.
  /// Menggunakan const untuk memungkinkan optimasi compile-time dan immutability.
  /// Memastikan semua data parfum lengkap sebelum objek dibuat.
  ///
  /// Parameter: name - Nama parfum (wajib diisi)
  /// Parameter: brand - Brand parfum (wajib diisi)
  /// Parameter: accords - Kategori aroma (wajib diisi)
  /// Parameter: description - Deskripsi lengkap parfum (wajib diisi)
  /// Parameter: imagePath - Path ke gambar parfum (wajib diisi)
  const Perfume({
    required this.name,
    required this.brand,
    required this.accords,
    required this.description,
    required this.imagePath,
  });

  /// Override operator equality untuk membandingkan objek Perfume.
  /// Diperlukan untuk operasi seperti filtering dan pencarian di list.
  /// Dua parfum dianggap sama jika memiliki nama dan brand yang identik.
  ///
  /// Parameter: other - Object yang akan dibandingkan
  /// Return: Boolean true jika objek sama, false jika berbeda
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Perfume && other.name == name && other.brand == brand;
  }

  /// Override hashCode untuk konsistensi dengan operator equality.
  /// Menggunakan nama dan brand sebagai unique identifier parfum.
  /// Penting untuk performa saat menggunakan Perfume dalam Set atau Map.
  ///
  /// Return: Integer hash code unik untuk objek ini
  @override
  int get hashCode => name.hashCode ^ brand.hashCode;

  /// Override toString untuk debugging dan logging yang lebih informatif.
  /// Menampilkan nama dan brand parfum dalam format yang mudah dibaca.
  /// Berguna untuk debugging dan pencatatan log aplikasi.
  ///
  /// Return: String representasi dari objek Perfume
  @override
  String toString() => 'Perfume(name: $name, brand: $brand)';
}
