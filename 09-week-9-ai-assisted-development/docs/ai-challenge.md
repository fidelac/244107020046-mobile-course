
# AI Challenge - Code Review

## 1. Tujuan

AI Challenge dilakukan untuk mengevaluasi saran dan hasil kode yang diberikan AI selama pengembangan fitur Search Notes.

Evaluasi dilakukan dengan memeriksa kesesuaian kode terhadap struktur project, kebutuhan fitur, arsitektur aplikasi, dan hasil pengujian.

## 2. Hasil Evaluasi

| No. | Temuan atau Saran | Keputusan | Alasan |
|---|---|---|---|
| 1 | Menggunakan unit test untuk menguji pencarian judul | Diterima | Unit test membantu memastikan logika pencarian berjalan sesuai kebutuhan. |
| 2 | Menambahkan widget test untuk kondisi hasil pencarian kosong | Diterima | Widget test memastikan empty state ditampilkan dengan benar. |
| 3 | Menggunakan lokasi import provider yang tidak sesuai dengan struktur folder project | Ditolak dan diperbaiki | Lokasi provider sebenarnya berada di presentation/providers. |
| 4 | Menggunakan overrideWith pada FutureProvider untuk menyediakan data pengujian | Diterima | Sesuai dengan jenis provider yang digunakan pada project. |

## 3. Temuan yang Diterima

### Penambahan Widget Test

Temuan:

Pengujian tidak cukup hanya dilakukan pada fungsi pencarian. Tampilan empty state juga perlu diperiksa.

Keputusan:

Diterima.

Alasan teknis:

Unit test hanya memeriksa hasil fungsi pencarian, sedangkan widget test dapat memastikan hasil tersebut ditampilkan dengan benar pada antarmuka aplikasi.

Tindakan:

Membuat widget test pada file:

```text
test/note_page_test.dart
```

Pengujian dilakukan dengan memasukkan keyword `xyz123` ketika tersedia catatan berjudul `Belajar Flutter`.

Hasil yang diharapkan:

```text
Catatan tidak ditemukan.
```

Hasil aktual:

```text
00:03 +1: All tests passed!
```

## 4. Temuan yang Ditolak

### Lokasi Import Provider

Temuan:

Import provider yang digunakan pada contoh awal tidak sesuai dengan struktur folder project.

Lokasi yang tidak sesuai:

```text
lib/features/notes/providers/notes_providers.dart
```

Lokasi sebenarnya:

```text
lib/features/notes/presentation/providers/notes_providers.dart
```

Keputusan:

Saran lokasi import tersebut ditolak dan disesuaikan.

Alasan teknis:

Flutter hanya dapat menemukan file apabila lokasi import sesuai dengan struktur direktori project.

Tindakan:

Menggunakan import:

```dart
import 'package:campus_notify/features/notes/presentation/providers/notes_providers.dart';
```

## 5. Bukti Verifikasi

Verifikasi dilakukan melalui pemeriksaan struktur direktori dan pengujian.

Hasil widget test:

```text
00:03 +1: All tests passed!
```

Hasil seluruh test:

```text
00:04 +19: All tests passed!
```

## 6. Kesimpulan

AI dapat memberikan bantuan dalam proses pengembangan, tetapi setiap saran perlu dievaluasi sebelum diterapkan.

Saran yang sesuai dengan kebutuhan dan arsitektur project dapat diterima, sedangkan saran yang tidak sesuai perlu ditolak atau disesuaikan.

Keputusan tersebut harus didasarkan pada bukti teknis, bukan hanya asumsi.
