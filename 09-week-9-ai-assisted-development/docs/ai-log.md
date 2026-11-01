
# AI Development Log

## 1. Tujuan Penggunaan AI

AI digunakan sebagai alat bantu dalam pengembangan fitur Search Notes pada aplikasi Campus Notify.

Penggunaan AI bertujuan membantu proses implementasi fitur, pembuatan pengujian, debugging, dan evaluasi kode.

AI tidak digunakan untuk menggantikan proses pemeriksaan kode. Setiap hasil yang diberikan tetap disesuaikan dengan struktur project dan diuji sebelum digunakan.

## 2. Prompt Engineering

Prompt disusun menggunakan lima komponen utama:

1. Role: Menentukan peran AI sebagai Flutter Developer.
2. Context: Menjelaskan konteks aplikasi Campus Notify.
3. Task: Menjelaskan fitur yang ingin dikembangkan.
4. Constraints: Menentukan batasan implementasi.
5. Output: Menentukan hasil yang diharapkan.

### Prompt Implementasi Fitur

```text
Role:
Bertindaklah sebagai Flutter Developer yang memahami
Flutter, Dart, Riverpod, dan clean architecture.

Context:
Saya sedang mengembangkan aplikasi Campus Notify
menggunakan Flutter dan Riverpod.

Aplikasi memiliki fitur catatan yang menggunakan
pemisahan presentation layer, domain layer,
dan data layer.

Task:
Bantu implementasikan fitur pencarian catatan
berdasarkan judul dan empty state ketika hasil
pencarian tidak ditemukan.

Constraints:
- Gunakan Flutter dan Riverpod.
- Pencarian dilakukan berdasarkan judul catatan.
- Pencarian tidak membedakan huruf besar dan kecil.
- Pencarian mendukung sebagian judul.
- Pisahkan logika pencarian dari widget.
- Gunakan domain use case untuk proses pencarian.
- Sesuaikan implementasi dengan struktur project
  yang sudah tersedia.
- Jangan mengubah fitur lain yang tidak berkaitan.

Output:
Berikan kode implementasi, penjelasan perubahan,
serta unit test untuk fitur pencarian.
```

### Prompt Pembuatan Widget Test

```text
Role:
Bertindaklah sebagai Flutter Developer dan Software Tester.

Context:
Saya memiliki halaman NotesPage menggunakan
ConsumerWidget dan Riverpod.

Halaman tersebut menampilkan daftar catatan,
kolom pencarian, serta empty state.

Task:
Bantu buat widget test untuk memastikan pesan
"Catatan tidak ditemukan." muncul ketika pengguna
memasukkan keyword yang tidak cocok dengan judul catatan.

Constraints:
- Gunakan flutter_test.
- Gunakan ProviderScope.
- Sesuaikan import dengan struktur folder project.
- Gunakan provider yang sudah tersedia.
- Jangan mengubah implementasi utama aplikasi.

Output:
Berikan kode widget test yang dapat dijalankan
menggunakan perintah flutter test.
```

## 3. Hasil Awal AI

AI memberikan bantuan dalam beberapa bagian implementasi, yaitu:

- Membuat fungsi pencarian catatan berdasarkan judul.
- Menggunakan state untuk menyimpan kata kunci pencarian.
- Menampilkan hasil pencarian pada NotesPage.
- Menambahkan kondisi empty state.
- Membuat unit test untuk menguji hasil pencarian.
- Membuat widget test untuk menguji tampilan empty state.

Hasil yang diberikan AI kemudian disesuaikan dengan struktur folder dan implementasi yang sudah tersedia pada project.

## 4. Implementasi yang Digunakan

Implementasi fitur pencarian menggunakan beberapa komponen:

- `NotesPage` sebagai halaman tampilan pencarian.
- `notesProvider` sebagai penyedia data catatan.
- `searchQueryProvider` sebagai penyimpan keyword pencarian.
- `searchNotesProvider` sebagai penyedia SearchNotes use case.
- `SearchNotes` sebagai tempat logika pencarian.

Pencarian dilakukan berdasarkan judul catatan dan mendukung pencarian tanpa membedakan huruf besar dan kecil.

## 5. Proses Verifikasi

Hasil implementasi diperiksa menggunakan beberapa metode:

1. Pemeriksaan struktur folder dan import.
2. Pemeriksaan kode secara manual.
3. Unit test pencarian.
4. Widget test empty state.
5. Flutter Analyze.
6. Dart Format.

### Hasil Pengujian

Unit test pencarian:

```text
00:06 +5: All tests passed!
```

Widget test:

```text
00:03 +1: All tests passed!
```

Seluruh pengujian project:

```text
00:04 +19: All tests passed!
```

Code formatting:

```text
Formatted 29 files (20 changed) in 0.12 seconds.
```

Pemeriksaan format:

```text
Formatted 29 files (0 changed) in 0.08 seconds.
```

Flutter Analyze pada pemeriksaan awal:

```text
warning - Duplicate import.
test\note_page_test.dart:8:8 - duplicate_import

1 issue found.
```

Hasil analisis akhir belum dikonfirmasi.

## 6. Perubahan Selama Implementasi

Selama proses implementasi dan debugging, dilakukan beberapa penyesuaian:

- Memperbaiki lokasi import provider yang sebelumnya tidak sesuai.
- Memastikan file provider dan file widget test memiliki tanggung jawab masing-masing.
- Memulihkan isi notes_providers.dart setelah kode widget test sempat ditempatkan pada file tersebut.
- Menyesuaikan widget test dengan FutureProvider yang digunakan aplikasi.
- Menjalankan ulang pengujian setelah perbaikan.

## 7. Kesimpulan

Penggunaan AI membantu mempercepat proses implementasi dan pengujian fitur Search Notes.

Namun, hasil yang diberikan AI tetap perlu diperiksa karena struktur folder, jenis provider, dan implementasi setiap project dapat berbeda.

Proses verifikasi melalui unit test dan widget test membantu memastikan fitur berjalan sesuai kebutuhan.
