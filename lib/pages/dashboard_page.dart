import 'package:flutter/material.dart';
import 'perfume_list_page.dart';
import 'profile_page.dart';

/// Halaman dashboard dengan bottom navigation.
/// Menampilkan dua tab utama: Catalog (daftar parfum) dan Profile (halaman profil pengguna).
/// Username diteruskan dari login page untuk personalisasi.
class DashboardPage extends StatefulWidget {
  /// Username pengguna yang diteruskan dari login page.
  final String username;

  /// Constructor untuk DashboardPage.
  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

/// State class untuk mengelola tab navigation.
class _DashboardPageState extends State<DashboardPage> {
  /// Index tab yang sedang aktif (0 = Catalog, 1 = Profile).
  int _currentIndex = 0;

  /// List widget untuk setiap tab.
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    /// Inisialisasi pages dengan username dari props.
    _pages = [
      const PerfumeListPage(),
      ProfilePage(username: widget.username),
    ];
  }

  /// Method untuk menangani perubahan tab.
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body menampilkan halaman sesuai tab yang aktif.
      body: _pages[_currentIndex],

      /// Bottom navigation dengan Material 3 NavigationBar.
      bottomNavigationBar: NavigationBar(
        /// Index tab yang sedang aktif.
        selectedIndex: _currentIndex,

        /// Handler untuk perubahan tab.
        onDestinationSelected: _onTabTapped,

        /// Destinasi tab dengan icon dan label.
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_florist),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
