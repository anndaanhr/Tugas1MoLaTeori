# Gambar Parfum

Folder ini berisi gambar parfum untuk aplikasi katalog parfum.

## Struktur File Saat Ini
- `citrus_morning.png` - Gambar untuk Citrus Morning (AromaLab)
- `velvet_bloom.png` - Gambar untuk Velvet Bloom (Maison Fleur)
- `midnight_resin.png` - Gambar untuk Midnight Resin (Nocturne)
- `ocean_linen.png` - Gambar untuk Ocean Linen (Blue Thread)
- `woodland_trail.png` - Gambar untuk Woodland Trail (Terra)
- `vanilla_haze.png` - Gambar untuk Vanilla Haze (Noir Sucre)

## Status Assets
✅ Assets sudah dikonfigurasi dengan benar di `pubspec.yaml`
✅ Path gambar sudah sesuai dengan nama file (.png extension)
✅ Kode sudah tidak ada error atau warning

## Cara Menggunakan Gambar yang Ada

Gambar-gambar ini akan otomatis muncul di:
1. **List Catalog** - sebagai avatar kecil di setiap item parfum
2. **Detail Parfum** - sebagai hero image besar dengan overlay nama parfum

## Jika Ingin Mengganti Gambar

1. **Ganti File**: Replace file .png yang ada dengan gambar baru
2. **Update Kode**: Jika ingin ganti nama file, update di `lib/data/dummy_perfumes.dart`
3. **Format Optimal**:
   - Format: PNG atau JPG
   - Ukuran: 300x300 pixel (1:1 aspect ratio)
   - File size: < 100KB untuk performa optimal

## Testing Assets

Setelah menjalankan `flutter run`, gambar akan muncul di:
- Halaman katalog parfum (sebagai avatar kecil)
- Halaman detail parfum (sebagai gambar besar)

Jika gambar tidak muncul, kemungkinan:
- File tidak ada di folder `assets/images/`
- Extension file tidak sesuai dengan kode
- Perlu `flutter clean` dan `flutter pub get` lagi
