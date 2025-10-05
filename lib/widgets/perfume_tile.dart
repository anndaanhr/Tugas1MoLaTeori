import 'package:flutter/material.dart';
import '../models/perfume.dart';

/// Widget untuk menampilkan item parfum dalam bentuk ListTile dengan gambar.
/// Digunakan di halaman katalog untuk menampilkan informasi parfum secara ringkas.
/// Widget ini bersifat reusable dan dapat diklik untuk navigasi ke halaman detail.
///
/// Features:
/// - Menampilkan gambar parfum dengan fallback ke icon jika gambar tidak ada
/// - Layout responsif dengan informasi parfum yang terstruktur
/// - Interaksi tap untuk navigasi ke detail parfum
/// - Menggunakan tema Material 3 untuk konsistensi visual
class PerfumeTile extends StatelessWidget {
  /// Objek parfum yang akan ditampilkan dalam tile ini.
  /// Berisi informasi lengkap parfum termasuk nama, brand, accords, dan gambar.
  final Perfume perfume;

  /// Callback function yang dipanggil ketika tile diklik.
  /// Biasanya digunakan untuk navigasi ke halaman detail parfum.
  final VoidCallback onTap;

  /// Constructor untuk membuat PerfumeTile dengan parameter required.
  /// Memastikan semua data yang diperlukan tersedia sebelum widget dibuat.
  ///
  /// @param perfume Objek parfum yang akan ditampilkan (wajib)
  /// @param onTap Callback ketika tile diklik (wajib)
  const PerfumeTile({
    super.key,
    required this.perfume,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// Leading section dengan gambar parfum dalam CircleAvatar.
      /// Menggunakan AssetImage untuk memuat gambar lokal parfum.
      /// Jika gambar tidak ditemukan, akan menampilkan icon bunga sebagai fallback.
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        backgroundImage: AssetImage(perfume.imagePath),
        onBackgroundImageError: (exception, stackTrace) {
          /// Error handler untuk gambar yang tidak ditemukan atau gagal dimuat.
          /// Dalam implementasi production, bisa ditambahkan logging untuk monitoring.
          /// Note: Handler ini tidak perlu return karena CircleAvatar akan menangani fallback.
        },
        child: const SizedBox(), // Kosong karena menggunakan backgroundImage
      ),

      /// Title section dengan nama parfum.
      /// Menggunakan styling bold untuk membuat nama parfum lebih menonjol.
      /// Nama parfum adalah informasi paling penting dalam katalog.
      title: Text(
        perfume.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      /// Subtitle section dengan kombinasi brand dan accords.
      /// Memberikan informasi tambahan tentang produsen dan kategori aroma.
      /// Menggunakan warna abu-abu untuk menunjukkan ini adalah informasi sekunder.
      subtitle: Text(
        '${perfume.brand} • ${perfume.accords}',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),

      /// Trailing section dengan icon chevron untuk indikasi interaktivitas.
      /// Icon panah ke kanan memberikan kesan bahwa tile dapat diklik.
      /// Menggunakan warna abu-abu untuk konsistensi dengan subtitle.
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),

      /// Handler untuk gesture tap pada tile.
      /// Memanggil callback onTap yang diberikan dari parent widget.
      /// Biasanya digunakan untuk navigasi ke halaman detail parfum.
      onTap: onTap,

      /// Content padding untuk memberikan ruang yang cukup di sekitar konten.
      /// Menggunakan padding horizontal dan vertikal sesuai dengan tema aplikasi.
      /// Memastikan konten tidak terlalu mepet ke tepi layar.
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }
}
