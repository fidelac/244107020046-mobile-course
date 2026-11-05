
# Week 10 - AI Feature Integration

## 1. Deskripsi Project

Campus Notify AI Assistant merupakan fitur asisten virtual berbasis Artificial Intelligence (AI) yang dikembangkan pada aplikasi Campus Notify.

Fitur ini dirancang untuk membantu pengguna memperoleh informasi dan panduan terkait penggunaan aplikasi serta aktivitas kampus melalui interaksi percakapan.

## 2. Tujuan Pengembangan

- Mengintegrasikan teknologi AI ke dalam aplikasi Flutter.
- Mengimplementasikan fitur percakapan antara pengguna dan AI.
- Menerapkan system prompt agar respons AI sesuai dengan tujuan aplikasi.
- Memahami penggunaan API dalam pengembangan aplikasi mobile.

## 3. Fitur yang Dikembangkan

1. **AI Chat Room**
   Menyediakan halaman percakapan antara pengguna dan AI Assistant.
2. **Chat Bubble**
   Menampilkan pesan pengguna dan balasan AI dengan tampilan berbeda.
3. **Chat Input**
   Menyediakan kolom untuk memasukkan dan mengirim pesan.
4. **Clear Chat**
   Memungkinkan pengguna menghapus riwayat percakapan.
5. **AI Response**
   AI memberikan jawaban berdasarkan pesan pengguna dan instruksi yang telah ditentukan.

## 4. Teknologi yang Digunakan

- Flutter
- Dart
- Riverpod
- Gemini API
- HTTP

## 5. System Prompt

System prompt digunakan untuk mengatur peran, bahasa, dan perilaku AI Assistant.

AI berperan sebagai asisten virtual Campus Notify yang memberikan jawaban menggunakan Bahasa Indonesia, ramah, singkat, jelas, dan relevan.

AI juga diarahkan untuk tidak meminta atau mengungkapkan data pribadi serta tidak mengarang informasi resmi kampus.

## 6. Pengujian

### Flutter Analyze
Perintah:
```bash
flutter analyze
```

Hasil pengujian awal:
- No issues found!

### Flutter Test
Perintah:
```bash
flutter test
```

Hasil pengujian awal:
- All tests passed.
- 19 tests passed.

Catatan: hasil di atas merupakan pengujian awal sebelum integrasi AI. Pengujian ulang dilakukan setelah implementasi selesai.

## 7. Risiko dan Mitigasi

| Risiko | Mitigasi |
|---|---|
| Data pribadi pengguna terkirim ke layanan AI | Tidak meminta atau mengirimkan informasi pribadi yang tidak diperlukan. |
| API Key terekspos | Tidak menyimpan API Key secara langsung di repository. |
| Biaya penggunaan API meningkat | Membatasi jumlah permintaan dan panjang pesan. |
| AI gagal memberikan respons | Menampilkan pesan error dan menyediakan opsi untuk mencoba kembali. |
| Jawaban AI tidak akurat | Memberikan batasan melalui system prompt dan mengingatkan pengguna untuk memverifikasi informasi resmi. |

## 8. Dokumentasi

Dokumentasi pengembangan AI dicatat dalam:
`docs/ai-log.md`

Screenshot hasil implementasi disimpan dalam:
`screenshots/`

## 9. Refleksi

Melalui pengembangan fitur Campus Notify AI Assistant, saya mempelajari proses integrasi layanan AI ke dalam aplikasi Flutter.

Fitur ini dipilih karena dapat membantu pengguna memperoleh informasi melalui percakapan yang lebih interaktif.

Dalam pengembangan fitur AI, privasi pengguna perlu diperhatikan dengan membatasi informasi yang dikirimkan ke layanan eksternal.

Apabila layanan AI mengalami gangguan, aplikasi perlu memberikan pesan kesalahan yang jelas dan menyediakan opsi untuk mencoba kembali.

Salah satu pembelajaran UX yang diperoleh adalah pentingnya tampilan percakapan yang sederhana, mudah dipahami, dan memberikan informasi mengenai status respons AI.
