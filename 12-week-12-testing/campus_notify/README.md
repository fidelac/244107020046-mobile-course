
# Week 12 - Testing

## Tujuan
Pada minggu ini, saya mempelajari pengujian aplikasi Flutter menggunakan Unit Test, Widget Test, dan Integration Test. Testing dilakukan untuk memastikan fungsi aplikasi berjalan sesuai harapan dan dapat menangani kondisi yang berbeda, termasuk error.

## Testing yang Dilakukan

### 1. Unit Test
Unit Test digunakan untuk menguji fungsi atau logic secara terpisah tanpa melibatkan tampilan aplikasi.

Pengujian dilakukan pada:
- Validasi judul catatan agar tidak kosong.
- Memastikan judul yang memiliki spasi di awal dan akhir di-trim.
- Proses pengambilan data catatan.
- Proses pencarian catatan berdasarkan judul.
- Penanganan error dari repository menggunakan Fake Repository.

### 2. Widget Test
Widget Test digunakan untuk menguji tampilan dan interaksi widget Flutter.

Pengujian pada halaman Notes meliputi:
- Loading state saat data sedang dimuat.
- Menampilkan daftar catatan ketika data berhasil dimuat.
- Menampilkan pesan error ketika proses pengambilan data gagal.
- Menampilkan pesan ketika hasil pencarian tidak ditemukan.

### 3. Integration Test
Integration Test dibuat untuk menguji alur pencarian catatan pada halaman Notes, mulai dari menampilkan data hingga memasukkan keyword dan memeriksa hasil pencarian.

Integration Test belum berhasil dijalankan karena keterbatasan environment:
- Windows membutuhkan Visual Studio C++ toolchain.
- Flutter Web belum mendukung integration test melalui device Chrome.
- Android device/emulator belum tersedia.

## Test Scenarios

| No | Scenario | Expected Result | Status |
|----|----------|----------------|--------|
| 1 | Menambahkan catatan dengan judul kosong | Validasi menolak catatan dan menampilkan failure | Passed |
| 2 | Menambahkan catatan dengan judul yang memiliki spasi | Judul di-trim dan catatan dapat disimpan | Passed |
| 3 | Mengambil data catatan dari repository | Data catatan berhasil dikembalikan | Passed |
| 4 | Repository mengalami error saat mengambil data | Failure dapat ditangani oleh use case | Passed |
| 5 | Menampilkan halaman Notes saat data loading | CircularProgressIndicator ditampilkan | Passed |
| 6 | Data catatan berhasil dimuat | Daftar catatan ditampilkan | Passed |
| 7 | Data catatan gagal dimuat | Pesan error dan tombol coba lagi ditampilkan | Passed |
| 8 | Mencari catatan yang tidak tersedia | Pesan catatan tidak ditemukan ditampilkan | Passed |
| 9 | Mencari catatan menggunakan keyword Flutter | Catatan yang cocok ditampilkan dan catatan lain difilter | Test dibuat, belum berhasil dijalankan |

## Test Results

- Unit Test & Widget Test: 23 tests passed.
- Flutter Analyze: No issues found.
- Test Coverage:
  - Total lines: 109
  - Covered lines: 59
  - Coverage: 54.13%
- Integration Test: Test code sudah dibuat, tetapi belum dapat dijalankan karena keterbatasan device dan platform.

## Reflection

Dari testing yang dilakukan, saya memahami bahwa Unit Test dapat digunakan untuk memeriksa logic secara terpisah, sedangkan Widget Test digunakan untuk memastikan tampilan dan interaksi widget berjalan sesuai harapan.

Fake Repository membantu pengujian tanpa harus menggunakan database asli sehingga pengujian lebih mudah dilakukan dan kondisi error dapat disimulasikan.

Hasil coverage sebesar 54.13% menunjukkan bahwa lebih dari setengah baris kode yang dihitung sudah dijalankan selama testing. Masih terdapat kode yang belum ter-cover sehingga pengujian dapat dikembangkan lagi.

Kendala yang saya temui adalah menjalankan Integration Test karena membutuhkan platform atau device yang sesuai. Meskipun belum berhasil dijalankan, saya sudah membuat skenario Integration Test untuk alur pencarian catatan.
