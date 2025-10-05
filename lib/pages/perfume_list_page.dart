import 'package:flutter/material.dart';
import '../data/dummy_perfumes.dart';
import '../pages/perfume_detail_page.dart';
import '../widgets/perfume_tile.dart';

/// Halaman katalog parfum yang menampilkan daftar parfum.
/// Menggunakan ListView.separated untuk menampilkan item dengan divider.
class PerfumeListPage extends StatefulWidget {
  /// Constructor untuk PerfumeListPage.
  const PerfumeListPage({super.key});

  @override
  State<PerfumeListPage> createState() => _PerfumeListPageState();
}

/// State class untuk mengelola state dan pencarian parfum.
class _PerfumeListPageState extends State<PerfumeListPage> {
  /// Controller untuk search field.
  final TextEditingController _searchController = TextEditingController();

  /// List parfum yang difilter berdasarkan pencarian.
  List _filteredPerfumes = dummyPerfumes;

  /// Method untuk memfilter parfum berdasarkan query pencarian.
  void _filterPerfumes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPerfumes = dummyPerfumes;
      } else {
        _filteredPerfumes = dummyPerfumes.where((perfume) {
          final name = perfume.name.toLowerCase();
          final brand = perfume.brand.toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || brand.contains(searchQuery);
        }).toList();
      }
    });
  }

  /// Method untuk menangani tap pada item parfum.
  void _onPerfumeTap(int index) {
    final perfume = _filteredPerfumes[index];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PerfumeDetailPage(perfume: perfume),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar dengan title dan search field.
      appBar: AppBar(
        title: const Text('Perfume Catalog'),
      ),

      /// Body dengan search bar dan list parfum.
      body: Column(
        children: [
          /// Search bar untuk filter parfum.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Cari nama/brand...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterPerfumes,
            ),
          ),

          /// Expanded untuk mengisi ruang yang tersisa.
          Expanded(
            child: _filteredPerfumes.isEmpty
                ? _buildEmptyState() // Menampilkan empty state jika tidak ada hasil
                : ListView.separated(
                    /// Item count berdasarkan hasil filter.
                    itemCount: _filteredPerfumes.length,

                    /// Separator dengan divider tipis.
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 0.5,
                    ),

                    /// Item builder menggunakan PerfumeTile widget.
                    itemBuilder: (context, index) {
                      final perfume = _filteredPerfumes[index];
                      return PerfumeTile(
                        perfume: perfume,
                        onTap: () => _onPerfumeTap(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk empty state ketika pencarian tidak menemukan hasil.
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada parfum ditemukan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba cari dengan kata kunci lain',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    /// Membersihkan controller untuk mencegah memory leak.
    _searchController.dispose();
    super.dispose();
  }
}
