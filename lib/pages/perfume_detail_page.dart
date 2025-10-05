import 'package:flutter/material.dart';
import '../models/perfume.dart';
import '../models/favorite.dart';
import '../services/database_service.dart';

/// Halaman detail parfum yang menampilkan informasi lengkap dengan gambar.
/// Menampilkan gambar parfum sebagai hero image, informasi detail, dan fitur favorites.
/// Menggunakan database lokal untuk menyimpan parfum favorit pengguna.
///
/// Features:
/// - Hero image dengan overlay nama parfum
/// - Informasi brand, accords, dan deskripsi lengkap
/// - Tombol favorites dengan state management dan database persistence
/// - Error handling untuk operasi database
/// - Loading states untuk feedback visual
class PerfumeDetailPage extends StatefulWidget {
  /// Objek parfum yang akan ditampilkan detailnya.
  /// Harus berisi informasi lengkap termasuk path gambar.
  final Perfume perfume;

  /// Constructor untuk PerfumeDetailPage dengan parameter required.
  const PerfumeDetailPage({super.key, required this.perfume});

  @override
  State<PerfumeDetailPage> createState() => _PerfumeDetailPageState();
}

/// State class untuk mengelola interaksi dengan database dan state lokal.
/// Menangani operasi favorites dengan loading states dan error handling.
class _PerfumeDetailPageState extends State<PerfumeDetailPage> {
  /// Status loading untuk operasi database.
  /// Mencegah multiple simultaneous operations dan memberikan feedback visual.
  bool _isLoading = false;

  /// Status apakah parfum saat ini sudah difavoritkan oleh pengguna.
  /// Diupdate secara real-time berdasarkan operasi database.
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    /// Inisialisasi: cek status favorite parfum saat halaman pertama kali dimuat.
    _checkFavoriteStatus();
  }

  /// Method untuk mengecek apakah parfum sudah ada di favorites.
  /// Mengambil data dari database lokal dan update state _isFavorite.
  /// Menggunakan try-catch untuk menangani error database yang mungkin terjadi.
  Future<void> _checkFavoriteStatus() async {
    setState(() => _isLoading = true);

    try {
      /// Query database untuk mengecek apakah parfum sudah difavoritkan.
      final isFav = await DatabaseService.isFavorite(widget.perfume.name);
      setState(() => _isFavorite = isFav);
    } catch (e) {
      /// Error handling untuk masalah koneksi database atau query.
      /// Menampilkan snackbar dengan informasi error kepada pengguna.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking favorite status: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      /// Pastikan loading state dimatikan setelah operasi selesai.
      /// Baik berhasil maupun gagal, loading harus dihentikan.
      setState(() => _isLoading = false);
    }
  }

  /// Method untuk toggle status favorite parfum.
  /// Menambah atau menghapus parfum dari favorites berdasarkan state saat ini.
  /// Menggunakan operasi database dengan error handling yang komprehensif.
  Future<void> _toggleFavorite() async {
    setState(() => _isLoading = true);

    try {
      if (_isFavorite) {
        /// Mode: Hapus dari favorites.
        /// Ambil semua favorites, cari yang sesuai dengan parfum ini, lalu hapus.
        final favorites = await DatabaseService.getFavorites();
        final favorite = favorites.firstWhere(
          (fav) => fav.perfume.name == widget.perfume.name,
        );
        await DatabaseService.removeFromFavorites(favorite.id!);
        setState(() => _isFavorite = false);

        /// Feedback visual untuk operasi berhasil.
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dihapus dari favorites')),
          );
        }
      } else {
        /// Mode: Tambah ke favorites.
        /// Buat objek Favorite baru dengan timestamp saat ini.
        final favorite = Favorite(
          perfume: widget.perfume,
          addedAt: DateTime.now(),
        );
        await DatabaseService.addToFavorites(favorite);
        setState(() => _isFavorite = true);

        /// Feedback visual untuk operasi berhasil.
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ditambahkan ke favorites')),
          );
        }
      }
    } catch (e) {
      /// Error handling untuk masalah database atau operasi yang gagal.
      /// Menampilkan informasi error yang spesifik kepada pengguna.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating favorites: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      /// Pastikan loading state dimatikan setelah operasi selesai.
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar dengan judul nama parfum untuk konteks yang jelas.
      appBar: AppBar(
        title: Text(widget.perfume.name),
      ),

      /// Body dengan informasi detail parfum dalam layout yang menarik.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Hero image section dengan gambar parfum sebagai background.
            /// Menggunakan Container dengan DecorationImage untuk efek visual yang menarik.
            /// Overlay dengan gradient dan nama parfum untuk readability.
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primaryContainer,
                image: DecorationImage(
                  image: AssetImage(widget.perfume.imagePath),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    /// Error handling untuk gambar yang tidak ditemukan.
                    /// Dalam implementasi nyata, bisa ditambahkan logging atau analytics.
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.perfume.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Brand information dengan styling yang menonjol.
            /// Memberikan kredit kepada produsen parfum.
            Text(
              widget.perfume.brand,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            /// Card untuk informasi accords.
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_florist,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Accords',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.perfume.accords,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Card untuk deskripsi parfum.
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.perfume.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            /// Tombol favorites dengan state management dan loading indicator.
            /// Menggunakan FilledButton untuk aksi utama dan visual feedback.
            /// Disabled state saat loading untuk mencegah multiple taps.
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isLoading ? null : _toggleFavorite,
                    icon: _isLoading
                        /// Loading indicator saat operasi database sedang berlangsung.
                        /// Memberikan feedback visual bahwa sistem sedang memproses request.
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        /// Icon dinamis berdasarkan status favorite saat ini.
                        /// Favorite filled jika sudah difavoritkan, border jika belum.
                        : Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                    label: Text(
                      /// Label dinamis berdasarkan status favorite.
                      /// Memberikan konteks yang jelas tentang aksi yang akan dilakukan.
                      _isFavorite ? 'Hapus dari Favorites' : 'Tambah ke Favorites',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
