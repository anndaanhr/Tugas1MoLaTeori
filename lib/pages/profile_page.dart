import 'package:flutter/material.dart';

/// Halaman profil pengguna yang menampilkan sapaan dengan username.
/// Halaman statis tanpa interaksi tambahan.
class ProfilePage extends StatelessWidget {
  /// Username pengguna yang diteruskan dari dashboard.
  final String username;

  /// Constructor untuk ProfilePage.
  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar dengan judul profil.
      appBar: AppBar(
        title: const Text('Profil'),
      ),

      /// Body dengan konten profil.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Sapaan dengan username.
            Text(
              'Halo, $username!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// Deskripsi singkat tentang aplikasi.
            Text(
              'Selamat datang di katalog parfum kami. Temukan aroma favorit Anda dari koleksi terbaik.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 32),

            /// Card informasi aplikasi.
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Judul informasi aplikasi.
                    Text(
                      'Tentang Aplikasi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Deskripsi aplikasi.
                    Text(
                      'Aplikasi katalog parfum sederhana untuk membantu Anda menemukan parfum yang sesuai dengan preferensi aroma Anda.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 16),

                    /// Informasi kontak (dummy).
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'perfume.catalog@example.com',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
