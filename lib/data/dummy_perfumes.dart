import '../models/perfume.dart';

/// Data dummy untuk parfum katalog.
/// Berisi koleksi parfum contoh dengan informasi lengkap.
/// Data ini bersifat statis dan tidak berubah selama runtime.
///
/// Setiap parfum memiliki:
/// - Nama unik dan deskriptif
/// - Brand yang berbeda-beda
/// - Kategori aroma (accords) yang spesifik
/// - Deskripsi detail dengan format Top/Middle/Base Notes
/// - Path gambar lokal untuk UI visual
///
/// Total ada 6 parfum dengan variasi aroma yang berbeda untuk memberikan
/// pengalaman katalog yang beragam bagi pengguna.
const List<Perfume> dummyPerfumes = [
  /// Parfum dengan aroma citrus segar seperti pagi hari.
  /// Cocok untuk aktivitas sehari-hari dengan kesan energik.
  Perfume(
    name: 'Citrus Morning',
    brand: 'AromaLab',
    accords: 'Fresh • Citrus',
    description: 'Parfum dengan aroma jeruk segar yang menyegarkan seperti pagi hari. '
        'Cocok untuk aktivitas sehari-hari dengan nuansa citrus yang ringan dan energik.\n\n'
        'Top Notes: Lemon, Orange, Bergamot\n'
        'Middle Notes: Jasmine, Neroli\n'
        'Base Notes: Musk, Sandalwood',
    imagePath: 'assets/images/citrus_morning.png',
  ),

  /// Parfum floral dengan sentuhan amber yang elegan.
  /// Memberikan kesan feminin dan tahan lama.
  Perfume(
    name: 'Velvet Bloom',
    brand: 'Maison Fleur',
    accords: 'Floral • Amber',
    description: 'Kombinasi bunga-bungaan lembut dengan sentuhan amber yang hangat. '
        'Parfum ini memberikan kesan elegan dan feminin dengan aroma yang tahan lama.\n\n'
        'Top Notes: Rose, Lily of the Valley\n'
        'Middle Notes: Iris, Violet\n'
        'Base Notes: Amber, Vanilla, Patchouli',
    imagePath: 'assets/images/velvet_bloom.png',
  ),

  /// Parfum dengan aroma oud yang misterius dan kuat.
  /// Sempurna untuk acara malam dengan karakter maskulin.
  Perfume(
    name: 'Midnight Resin',
    brand: 'Nocturne',
    accords: 'Oud • Resinous',
    description: 'Aroma oud yang dalam dan misterius dengan nuansa resin yang kuat. '
        'Parfum ini sempurna untuk acara malam hari dengan karakter yang kuat dan maskulin.\n\n'
        'Top Notes: Saffron, Cardamom\n'
        'Middle Notes: Rose, Geranium\n'
        'Base Notes: Oud, Sandalwood, Amber',
    imagePath: 'assets/images/midnight_resin.png',
  ),

  /// Parfum dengan nuansa laut yang segar dan bersih.
  /// Memberikan kesan tenang seperti angin laut.
  Perfume(
    name: 'Ocean Linen',
    brand: 'Blue Thread',
    accords: 'Aquatic • Powdery',
    description: 'Nuansa laut yang segar dengan sentuhan powdery yang lembut. '
        'Seperti angin laut yang membelai kain linen, memberikan kesan bersih dan tenang.\n\n'
        'Top Notes: Sea Salt, Lemon\n'
        'Middle Notes: Jasmine, Water Lily\n'
        'Base Notes: Musk, Sandalwood, Iris',
    imagePath: 'assets/images/ocean_linen.png',
  ),

  /// Parfum dengan aroma hutan yang natural dan earthy.
  /// Membawa nuansa alam bebas dengan karakter kuat.
  Perfume(
    name: 'Woodland Trail',
    brand: 'Terra',
    accords: 'Woody • Green',
    description: 'Aroma hutan dengan kombinasi kayu dan daun hijau. '
        'Parfum ini membawa nuansa alam bebas dengan karakter earthy yang kuat dan natural.\n\n'
        'Top Notes: Pine, Eucalyptus\n'
        'Middle Notes: Cedar, Vetiver\n'
        'Base Notes: Patchouli, Oakmoss, Amber',
    imagePath: 'assets/images/woodland_trail.png',
  ),

  /// Parfum vanilla yang hangat dengan sentuhan powdery.
  /// Memberikan kesan cozy dan comforting seperti kabut manis.
  Perfume(
    name: 'Vanilla Haze',
    brand: 'Noir Sucre',
    accords: 'Vanilla • Powdery',
    description: 'Vanila hangat dengan sentuhan powdery yang lembut. '
        'Seperti kabut manis yang menyelimuti, memberikan kesan cozy dan comforting.\n\n'
        'Top Notes: Vanilla Bean, Tonka Bean\n'
        'Middle Notes: Heliotrope, Iris\n'
        'Base Notes: Sandalwood, Musk, Benzoin',
    imagePath: 'assets/images/vanilla_haze.png',
  ),
];
