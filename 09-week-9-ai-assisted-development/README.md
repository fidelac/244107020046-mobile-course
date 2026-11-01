
# Week 9 - AI-Assisted Development

Pada minggu ke-9, dilakukan pengembangan aplikasi Campus Notify dengan menerapkan pendekatan AI-Assisted Development.

Pengembangan berfokus pada implementasi fitur pencarian catatan (Search Notes) berdasarkan judul, penanganan kondisi ketika hasil pencarian tidak ditemukan (Empty State), serta pengujian dan evaluasi kode dengan bantuan AI.

AI digunakan sebagai alat bantu dalam proses pengembangan, sedangkan hasil implementasinya tetap diperiksa dan diuji untuk memastikan kesesuaian dengan kebutuhan aplikasi.

## Fitur yang Dikembangkan
### Search Notes
Fitur pencarian digunakan untuk membantu pengguna menemukan catatan berdasarkan judul.

Fitur ini memiliki beberapa kondisi:

- Menampilkan seluruh catatan ketika kolom pencarian kosong.
- Menampilkan catatan yang judulnya sesuai dengan kata kunci.
- Pencarian tidak membedakan huruf besar dan kecil.
- Mendukung pencarian berdasarkan sebagian judul.
- Menampilkan pesan "Catatan tidak ditemukan." ketika tidak terdapat hasil yang sesuai.
- Menampilkan pesan "Belum ada catatan." ketika daftar catatan kosong.

### Empty State

Empty state digunakan untuk memberikan informasi kepada pengguna ketika tidak terdapat catatan atau hasil pencarian yang sesuai.

Terdapat dua kondisi empty state:

1. Belum ada catatan: ditampilkan ketika daftar catatan kosong.
2. Catatan tidak ditemukan: ditampilkan ketika kata kunci pencarian tidak cocok dengan judul catatan.

## Arsitektur Implementasi

Implementasi fitur pencarian menggunakan pemisahan tanggung jawab antara presentation layer dan domain layer.

Komponen yang digunakan:

- `NotesPage`: Menampilkan antarmuka pencarian dan daftar catatan.
- `notesProvider`: Mengambil data catatan menggunakan FutureProvider.
- `searchQueryProvider`: Menyimpan kata kunci pencarian menggunakan StateProvider.
- `searchNotesProvider`: Menyediakan SearchNotes use case.
- `SearchNotes`: Menangani proses pencarian catatan berdasarkan judul.

Alur implementasi:

1. Pengguna memasukkan kata kunci melalui TextField.
2. Kata kunci disimpan melalui searchQueryProvider.
3. NotesPage mengambil daftar catatan melalui notesProvider.
4. SearchNotes melakukan penyaringan berdasarkan judul.
5. Hasil pencarian ditampilkan pada NotesPage.
6. Jika tidak ditemukan hasil yang sesuai, aplikasi menampilkan empty state.

## AI-Assisted Development

AI digunakan sebagai alat bantu selama proses pengembangan, antara lain untuk:

- Membantu menyusun implementasi fitur pencarian.
- Membantu membuat unit test.
- Membantu membuat widget test.
- Memberikan saran perbaikan kode.
- Membantu proses debugging.
- Membantu memahami pemisahan tanggung jawab antar-layer.

Setiap hasil yang diberikan AI diperiksa kembali dan disesuaikan dengan struktur project yang sebenarnya.

Dokumentasi penggunaan AI:

- [AI Development Log](docs/ai-log.md)
- [AI Challenge](docs/ai-challenge.md)
- [Debugging and Refactoring](docs/debugging.md)
- [Reflection](docs/reflection.md)

## pengujian

### Unit Test Pencarian

Terdapat lima pengujian pada `search_filter_test.dart`:

1. Menampilkan semua catatan jika keyword kosong.
2. Mencari judul berdasarkan keyword.
3. Pencarian tidak membedakan huruf besar dan kecil.
4. Mencari berdasarkan sebagian judul.
5. Mengembalikan list kosong jika tidak ditemukan.

Hasil: 5 test berhasil.

### Widget Test

Widget test dilakukan pada `note_page_test.dart` untuk memastikan aplikasi menampilkan pesan "Catatan tidak ditemukan." ketika pengguna memasukkan kata kunci yang tidak sesuai dengan judul catatan.

Hasil: 1 test berhasil.

### Hasil Pengujian Keseluruhan

Perintah:

```bash
flutter test
```

Hasil:

```text
00:04 +19: All tests passed!
```

Seluruh 19 test pada project berhasil dijalankan.

## Code Formatting

Perintah yang digunakan:

```bash
dart format .
```

Hasil:

```text
Formatted 29 files (20 changed) in 0.12 seconds.
```

Selanjutnya dilakukan pemeriksaan konsistensi format:

```bash
dart format --set-exit-if-changed .
```

Hasil:

```text
Formatted 29 files (0 changed) in 0.08 seconds.
```

Artinya, seluruh 29 file telah memiliki format yang konsisten dan tidak memerlukan perubahan tambahan.

## Flutter Analyze

Perintah:

```bash
flutter analyze
```

Hasil pemeriksaan awal:

```text
warning - Duplicate import.
test\note_page_test.dart:8:8 - duplicate_import

1 issue found.
```

Ditemukan satu warning duplicate import pada file `test/note_page_test.dart`.

Pemeriksaan ulang setelah perbaikan masih perlu dilakukan untuk memastikan tidak ada warning yang tersisa.

## Cara Menjalankan Project

Ambil dependency:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

Jalankan seluruh pengujian:

```bash
flutter test
```

Lakukan analisis kode:

```bash
flutter analyze
```

Periksa konsistensi format kode:

```bash
dart format --set-exit-if-changed .
```

## Dokumentasi Screenshot


## Kesimpulan

Pengembangan fitur Search Notes pada aplikasi Campus Notify dilakukan dengan memanfaatkan AI sebagai alat bantu dalam proses implementasi, pengujian, dan debugging.

Fitur pencarian telah memiliki unit test dan widget test. Berdasarkan pengujian terakhir, seluruh 19 test pada project berhasil dijalankan.

Proses formatting juga berhasil diverifikasi dengan hasil 29 file diperiksa dan tidak terdapat perubahan format tambahan.

Melalui kegiatan ini, dapat dipahami bahwa penggunaan AI dalam pengembangan aplikasi tetap membutuhkan pemeriksaan kode, pengujian, dan evaluasi secara mandiri agar hasil implementasi sesuai dengan kebutuhan dan arsitektur project.
