
# Debugging and Refactoring

Proses debugging dilakukan untuk menemukan dan memperbaiki kesalahan selama implementasi fitur Search Notes pada aplikasi Campus Notify.

Debugging dilakukan dengan membaca pesan error, memeriksa struktur folder, memperbaiki kode, dan menjalankan kembali pengujian.

## Permasalahan yang Ditemukan

### A. File Widget Test Tidak Ditemukan

Permasalahan:

Saat menjalankan perintah:

```bash
flutter test test/notes_page_test.dart
```

Flutter memberikan pesan:

```text
Does not exist.
```

Penyebab:

Nama file yang tersedia adalah `note_page_test.dart`, bukan `notes_page_test.dart`.

Perbaikan:

Menjalankan perintah menggunakan nama file yang benar:

```bash
flutter test test/note_page_test.dart
```

### B. Import Provider Tidak Ditemukan

Permasalahan:

Flutter tidak dapat menemukan file:

```text
lib/features/notes/providers/notes_providers.dart
```

Penyebab:

Lokasi file provider sebenarnya berada di:

```text
lib/features/notes/presentation/providers/notes_providers.dart
```

Perbaikan:

Menyesuaikan import dengan lokasi file yang sebenarnya.

### C. Provider Tidak Dikenali

Permasalahan:

Flutter memberikan error:

```text
Undefined name 'notesProvider'.
```

Selain itu, `searchQueryProvider` dan `searchNotesProvider` juga tidak dikenali.

Penyebab:

File notes_providers.dart sempat tertimpa oleh kode widget test sehingga deklarasi provider tidak tersedia.

Perbaikan:

Memulihkan file notes_providers.dart dengan deklarasi provider yang sesuai dengan implementasi aplikasi.

File widget test ditempatkan secara terpisah pada:

```text
test/note_page_test.dart
```

Hasil:

Widget test berhasil dijalankan.

```text
00:03 +1: All tests passed!
```

## Refactoring

Logika pencarian ditempatkan pada domain use case `SearchNotes`.

Tujuan pemisahan ini adalah agar proses pencarian tidak perlu ditulis langsung di dalam widget.

Komponen yang terlibat:

- `NotesPage`: Mengelola tampilan dan interaksi pengguna.
- `searchQueryProvider`: Menyimpan kata kunci pencarian.
- `searchNotesProvider`: Menyediakan use case pencarian.
- `SearchNotes`: Melakukan proses pencarian catatan.

Alur implementasi:

```text
User Input
    |
    v
NotesPage
    |
    v
searchQueryProvider
    |
    v
SearchNotes Use Case
    |
    v
Filtered Notes
    |
    v
Search Result / Empty State
```

Dengan pemisahan ini, logika pencarian dapat diuji secara terpisah dari tampilan aplikasi.

## Pengujian Setelah Perbaikan

### Unit Test

File:

```text
test/search_filter_test.dart
```

Hasil:

```text
00:06 +5: All tests passed!
```

### Widget Test

File:

```text
test/note_page_test.dart
```

Hasil:

```text
00:03 +1: All tests passed!
```

### Seluruh Test Project

Perintah:

```bash
flutter test
```

Hasil:

```text
00:04 +19: All tests passed!
```

### Code Formatting

Perintah:

```bash
dart format .
```

Hasil:

```text
Formatted 29 files (20 changed) in 0.12 seconds.
```

Pemeriksaan ulang:

```bash
dart format --set-exit-if-changed .
```

Hasil:

```text
Formatted 29 files (0 changed) in 0.08 seconds.
```

## Kesimpulan

Proses debugging membantu menemukan kesalahan pada nama file, lokasi import, dan penempatan kode.

Setelah dilakukan perbaikan, widget test berhasil dijalankan dan seluruh 19 test pada project berhasil dilewati.

Refactoring juga membantu memisahkan logika pencarian dari tampilan sehingga kode lebih mudah diuji dan dipelihara.
