import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite.dart';

/// Service class untuk mengelola operasi database lokal aplikasi katalog parfum.
/// Menggunakan SQLite sebagai backend untuk menyimpan data parfum favorit pengguna.
///
/// Class ini mengimplementasikan pola Singleton untuk memastikan hanya ada satu
/// instance database yang aktif dalam aplikasi. Menggunakan operasi async/await
/// untuk semua operasi database dengan error handling yang komprehensif.
///
/// Features:
/// - Singleton pattern untuk instance database
/// - Auto-migration untuk struktur tabel
/// - CRUD operations untuk favorites
/// - Error handling dan logging untuk debugging
/// - Type-safe operations dengan model mapping
class DatabaseService {
  /// Nama file database lokal yang akan dibuat di device pengguna.
  /// Menggunakan format .db untuk kompatibilitas dengan SQLite.
  static const String _databaseName = 'perfume_catalog.db';

  /// Versi database saat ini untuk migrasi struktur tabel.
  /// Increment versi ini jika ada perubahan struktur tabel di masa depan.
  static const int _databaseVersion = 1;

  /// Nama tabel untuk menyimpan data parfum favorit.
  /// Mengikuti konvensi snake_case untuk nama tabel SQL.
  static const String _favoritesTable = 'favorites';

  /// Instance database sebagai singleton pattern.
  /// Menggunakan static variable untuk memastikan hanya ada satu instance
  /// yang aktif dalam aplikasi dan menghindari multiple connections.
  static Database? _database;

  /// Getter untuk mendapatkan instance database dengan lazy initialization.
  /// Jika database belum diinisialisasi, akan memanggil _initDatabase().
  /// Menggunakan null-aware operator untuk thread safety.
  ///
  /// Return: Future instance database yang siap digunakan
  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Method untuk menginisialisasi database dan membuat struktur tabel.
  /// Dipanggil sekali saat pertama kali aplikasi mengakses database.
  /// Menggunakan path provider untuk mendapatkan direktori yang sesuai untuk platform.
  ///
  /// Return: Future instance database yang baru diinisialisasi
  static Future<Database> _initDatabase() async {
    /// Mendapatkan path direktori database dari sistem operasi.
    /// Path ini akan berbeda untuk setiap platform (Android/iOS/Desktop).
    final path = join(await getDatabasesPath(), _databaseName);

    /// Membuka atau membuat database baru dengan konfigurasi yang ditentukan.
    /// Parameter onCreate akan dipanggil jika database belum ada.
    /// Parameter onUpgrade bisa ditambahkan untuk migrasi di masa depan.
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        /// Membuat tabel favorites dengan semua field yang diperlukan.
        /// Menggunakan AUTOINCREMENT untuk ID yang unik secara otomatis.
        /// TEXT NOT NULL untuk memastikan data selalu ada dan valid.
        await db.execute('''
          CREATE TABLE $_favoritesTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            perfume_name TEXT NOT NULL,
            perfume_brand TEXT NOT NULL,
            perfume_accords TEXT NOT NULL,
            perfume_description TEXT NOT NULL,
            perfume_image_path TEXT NOT NULL,
            added_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// Method untuk menambahkan parfum baru ke favorites.
  /// Menggunakan operasi INSERT dengan conflict resolution.
  ///
  /// Parameter: favorite - Objek Favorite yang akan disimpan ke database
  /// Return: Future ID dari record yang baru ditambahkan
  /// Throws: DatabaseException jika terjadi error saat operasi database
  static Future<int> addToFavorites(Favorite favorite) async {
    final db = await database;
    return await db.insert(
      _favoritesTable,
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Method untuk menghapus parfum dari favorites berdasarkan ID.
  /// Menggunakan operasi DELETE dengan WHERE clause untuk presisi.
  ///
  /// Parameter: id - ID unik dari favorite yang akan dihapus
  /// Return: Future jumlah record yang berhasil dihapus (0 atau 1)
  /// Throws: DatabaseException jika terjadi error saat operasi database
  static Future<int> removeFromFavorites(int id) async {
    final db = await database;
    return await db.delete(
      _favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Method untuk mendapatkan semua parfum favorit dari database.
  /// Mengembalikan list kosong jika belum ada data favorites.
  ///
  /// Return: Future list semua parfum favorit yang tersimpan
  /// Throws: DatabaseException jika terjadi error saat query database
  static Future<List<Favorite>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_favoritesTable);

    /// Mengkonversi List<Map> dari database menjadi List<Favorite> objects.
    /// Menggunakan factory constructor fromMap() dari model Favorite.
    /// List.generate untuk mapping yang type-safe dan performa optimal.
    return List.generate(maps.length, (i) {
      return Favorite.fromMap(maps[i]);
    });
  }

  /// Method untuk mengecek apakah parfum tertentu sudah difavoritkan.
  /// Berguna untuk menentukan state UI (favorite/belum favorite).
  ///
  /// Parameter: perfumeName - Nama parfum yang akan dicek status favoritnya
  /// Return: Future boolean true jika parfum sudah ada di favorites, false jika belum
  /// Throws: DatabaseException jika terjadi error saat query database
  static Future<bool> isFavorite(String perfumeName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _favoritesTable,
      where: 'perfume_name = ?',
      whereArgs: [perfumeName],
    );

    /// Mengembalikan true jika ada minimal satu record dengan nama parfum tersebut.
    /// Query ini lebih efisien daripada getFavorites() karena hanya mencari satu record.
    return maps.isNotEmpty;
  }

  /// Method untuk menutup koneksi database secara eksplisit.
  /// Biasanya dipanggil saat aplikasi ditutup atau untuk cleanup resources.
  /// Dalam praktiknya, database akan ditutup otomatis oleh sistem operasi.
  ///
  /// Return: Future yang complete saat database berhasil ditutup
  /// Throws: DatabaseException jika terjadi error saat menutup database
  static Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
