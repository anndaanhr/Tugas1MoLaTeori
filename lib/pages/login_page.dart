import 'package:flutter/material.dart';
import '../pages/dashboard_page.dart';

/// Halaman login dengan simulasi autentikasi.
/// Pengguna diminta memasukkan username dan langsung masuk ke dashboard.
/// Username akan diteruskan ke profile page untuk personalisasi.
class LoginPage extends StatefulWidget {
  /// Constructor untuk LoginPage.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// State class untuk mengelola input dan navigasi login.
class _LoginPageState extends State<LoginPage> {
  /// Controller untuk mengelola input username.
  final TextEditingController _usernameController = TextEditingController();

  /// Key untuk form validation.
  final _formKey = GlobalKey<FormState>();

  /// Method untuk menangani proses login (simulasi).
  /// Navigasi ke dashboard dengan username yang diinput.
  void _handleLogin() {
    // Validasi form sebelum navigasi
    if (_formKey.currentState?.validate() ?? false) {
      // Navigasi ke dashboard dengan pushReplacement
      // (menghapus login page dari stack navigasi)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            username: _usernameController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body dengan center alignment untuk layout yang seimbang.
      body: Center(
        child: SingleChildScrollView(
          /// Padding untuk memberikan ruang dari tepi layar.
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Icon aplikasi dengan tema parfum.
                const Icon(
                  Icons.spa,
                  size: 80,
                  color: Color(0xFF4E82C2),
                ),

                const SizedBox(height: 32),

                /// Judul aplikasi.
                const Text(
                  'Perfume Catalog',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                /// Subtitle aplikasi.
                Text(
                  'Temukan parfum favorit Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 48),

                /// Card untuk form login.
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        /// Input field untuk username.
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'Masukkan nama Anda',
                            prefixIcon: Icon(Icons.person),
                          ),
                          /// Validasi sederhana untuk memastikan input tidak kosong.
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        /// Tombol login dengan full width.
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _handleLogin,
                            child: const Text('Masuk'),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// Catatan tentang simulasi login.
                        Text(
                          'Login simulasi - langsung masuk tanpa autentikasi',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /// Membersihkan controller untuk mencegah memory leak.
    _usernameController.dispose();
    super.dispose();
  }
}
