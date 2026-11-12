
# Flutter Performance Optimization Report

## 1. Project Overview

**Project:** Campus Notify  
**Framework:** Flutter  
**State Management:** Riverpod  
**Jobsheet:** Week 11 - Performance Optimization

Pada jobsheet ini, dilakukan optimasi kode aplikasi Campus Notify untuk meningkatkan efisiensi rebuild widget dan pengelolaan data.

## 2. Optimization Implementations

### A. Chat Widget Optimization

File: `lib/features/chat/pages/chat_page.dart`

- Memisahkan daftar pesan ke dalam widget `_ChatMessageList`.
- Memindahkan pemantauan `chatProvider` ke widget daftar pesan.
- Mempertahankan `ChatInput` agar tidak ikut rebuild ketika daftar pesan berubah.
- Tetap menggunakan `ListView.builder` untuk menampilkan pesan secara lazy.

### B. Notes Search Optimization

File: `lib/features/notes/presentation/providers/notes_providers.dart`

- Menambahkan `filteredNotesProvider`.
- Memindahkan proses penyaringan catatan dari halaman ke provider.
- Menggunakan `notes.whenData()` untuk mempertahankan status loading dan error.

### C. Notes Widget Optimization

File: `lib/features/notes/presentation/pages/notes_page.dart`

- Mengubah `NotesPage` menjadi `StatelessWidget`.
- Memisahkan kolom pencarian ke `_NotesSearchField`.
- Memisahkan daftar catatan ke `_NotesList`.
- Membatasi pemantauan `filteredNotesProvider` pada widget daftar catatan.

## 3. Code Validation

Pengujian dilakukan menggunakan perintah Flutter berikut:

| Validation | Result |
|---|---|
| `flutter analyze` | No issues found |
| `flutter test` | 19 tests passed |

## 4. Performance Profiling

Pengukuran performa menggunakan Flutter DevTools belum dilakukan karena pengujian pada perangkat Android masih menunggu ketersediaan perangkat.

Data yang akan dikumpulkan:

- Frame rendering time
- Jumlah frame jank
- Penggunaan memori
- Perbandingan performa sebelum dan sesudah optimasi

## 5. Conclusion

Optimasi awal telah dilakukan pada halaman Chat dan Notes dengan memisahkan widget serta mengatur pemantauan state menggunakan Riverpod.

Hasil validasi menunjukkan bahwa aplikasi tidak memiliki masalah pada analisis kode dan seluruh 19 unit test berhasil dijalankan.

Pengukuran performa secara langsung masih perlu dilakukan menggunakan Flutter DevTools untuk mengetahui dampak optimasi terhadap rendering dan penggunaan memori.


## 6. Refleksi

### 1. Optimasi mana yang memberikan dampak terbesar dan mengapa?

Pemisahan widget pada halaman Chat dan Notes menjadi optimasi yang paling relevan. Dengan memisahkan bagian yang mengamati state, perubahan data tidak harus membuat seluruh halaman melakukan rebuild. Hal ini membantu mengurangi proses rebuild widget yang tidak diperlukan.

### 2. Bagaimana Anda memverifikasi bahwa optimasi benar-benar bekerja (bukan placebo)?

Saya memverifikasi perubahan dengan menjalankan `flutter analyze` dan `flutter test`. Hasilnya tidak ditemukan masalah pada analisis kode dan seluruh 19 test berhasil dijalankan. Untuk memastikan dampak terhadap performa, masih diperlukan pengujian menggunakan Flutter DevTools dengan membandingkan frame rendering, jumlah jank, dan penggunaan memori sebelum dan sesudah optimasi.

### 3. Trade-off apa yang Anda hadapi (misalnya kompleksitas kode vs performa)?

Trade-off yang dihadapi adalah bertambahnya jumlah widget dan provider sehingga struktur kode menjadi sedikit lebih kompleks. Namun, pemisahan tersebut membuat pengelolaan state lebih terarah dan memudahkan proses pemeliharaan kode.

### 4. Kapan sebaiknya optimasi premature dihindari?

Optimasi premature sebaiknya dihindari ketika belum ditemukan masalah performa yang jelas. Terlalu cepat melakukan optimasi dapat membuat kode menjadi lebih kompleks tanpa memberikan peningkatan yang berarti. Sebaiknya optimasi dilakukan berdasarkan hasil pengamatan dan pengukuran agar perubahan yang dilakukan benar-benar diperlukan.
