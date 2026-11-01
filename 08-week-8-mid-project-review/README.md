

## Identitas
- Nama: Fidela Clarisa
- NIM: 244107020046
- Mata Kuliah: Pemrograman Mobile

## 1. Tujuan Praktikum
Praktikum ini bertujuan untuk melakukan audit repository Git, memahami pengelolaan branch, menerapkan alur kerja berbasis feature branch, serta menggunakan pesan commit yang jelas dan konsisten.


## 2. Audit Repository

### Pemeriksaan Riwayat Commit

Perintah yang digunakan:

```bash
git log --oneline -15
```

Hasil pemeriksaan menunjukkan beberapa pesan commit sebelumnya masih kurang konsisten, misalnya:
- `feat: complate week 7`
- `feat : Complate Week 6`
- `feat : complated week5`

Pesan commit tersebut memiliki kesalahan ejaan dan format penulisan yang tidak konsisten. Oleh karena itu, diperlukan penggunaan format pesan commit yang lebih jelas dan konsisten agar riwayat perubahan mudah dibaca dan dipahami.

### Pemeriksaan Branch

Perintah yang digunakan:

```bash
git branch -a
```

Pada pemeriksaan awal, repository hanya memiliki branch `main` dan `origin/main`. Branch `develop` belum tersedia sehingga dibuat untuk menjadi branch pengembangan.

Branch `develop` kemudian berhasil dibuat dari branch `main` dan dikirim ke remote repository. Selanjutnya, branch `feat/notes-validation` dibuat dari `develop` untuk mengerjakan fitur validasi judul catatan.

### Pemeriksaan Status Repository

Perintah yang digunakan:

```bash
git status
```

Hasil pemeriksaan menunjukkan working tree bersih dan tidak ada perubahan yang belum di-commit.

Pemeriksaan ini dilakukan untuk memastikan repository berada dalam kondisi bersih sebelum memulai perubahan pada branch fitur.


## 3. Pembuatan Branch

Branch `develop` dibuat dari branch `main`, kemudian dikirim ke remote repository menggunakan perintah:

```bash
git switch -c develop
git push -u origin develop
```

Selanjutnya, branch fitur dibuat dari `develop`:

```bash
git switch -c feat/notes-validation
```

Branch `feat/notes-validation` digunakan untuk mengembangkan validasi judul catatan dan menambahkan unit test tanpa langsung mengubah branch utama.

## 4. Implementasi Perubahan

Perubahan yang dilakukan meliputi:
- Menambahkan validasi agar judul catatan tidak kosong atau hanya berisi spasi pada use case `AddNote`.
- Menambahkan unit test untuk menguji judul kosong, judul yang hanya berisi spasi, dan judul valid.
- Menghapus import `firebase_core` yang tidak digunakan pada `main.dart`.

Pengujian dilakukan menggunakan perintah:

```bash
flutter test test/validate_note_test.dart
flutter test
flutter analyze
```

Hasil pengujian menunjukkan ketiga unit test pada file `validate_note_test.dart` berhasil, seluruh 13 test berhasil, dan `flutter analyze` tidak menemukan masalah.

## 5. Pesan Commit dan Push

Perubahan disimpan menggunakan pesan commit:

```text
feat(notes): validasi judul kosong + test
```

Commit berhasil dibuat dengan hash singkat `0c5521f`, kemudian branch fitur dikirim ke remote repository menggunakan:

```bash
git push -u origin feat/notes-validation
```

Push berhasil dan branch `feat/notes-validation` telah tersedia di remote repository.

## 6. Hasil Praktikum

- [x] Audit riwayat commit dan status repository.
- [x] Membuat branch `develop`.
- [x] Push branch `develop` ke remote.
- [x] Membuat branch `feat/notes-validation`.
- [x] Melakukan perubahan validasi judul catatan.
- [x] Menambahkan unit test.
- [ ] Memilih perubahan menggunakan `git add -p`.
- [x] Membuat commit sesuai format.
- [x] Push branch fitur ke remote.
- [ ] Menyelesaikan Pull Request melalui peer review dan merge.

## 7. Kesimpulan

Praktikum ini memberikan pemahaman mengenai pentingnya pengelolaan branch dan konsistensi pesan commit dalam pengembangan aplikasi. Branch `develop` digunakan sebagai dasar pengembangan, sedangkan branch fitur digunakan agar perubahan dapat dikerjakan secara terpisah dan terstruktur. Validasi judul catatan dan unit test berhasil ditambahkan, kemudian perubahan disimpan dalam commit yang jelas dan dikirim ke remote repository. Selanjutnya, perubahan diajukan melalui Pull Request agar dapat ditinjau sebelum digabungkan ke branch `develop`.

![Screenshot](/244107020046-mobile-course/08-week-8-mid-project-review/screenshots/GitBranch.png)
![Screenshot](/244107020046-mobile-course/08-week-8-mid-project-review/screenshots/FlutterTestAnalyze.png)
![Screenshot](/244107020046-mobile-course/08-week-8-mid-project-review/screenshots/RPGithub.png)
![Screenshot](/244107020046-mobile-course/08-week-8-mid-project-review/screenshots/RPGithub2.png)
![Screenshot](/244107020046-mobile-course/08-week-8-mid-project-review/screenshots/AddComment.png)

## 8. Verifikasi Temuan AI

Berikut beberapa hal yang perlu diperiksa untuk memverifikasi hasil review AI terhadap implementasi aplikasi.

### Temuan 1 — Validasi Belum Terhubung ke UI

**Status:** Perlu verifikasi

Kode `NotesPage` yang sebelumnya diperiksa hanya menampilkan daftar catatan. Perlu dipastikan apakah terdapat form tambah catatan di halaman lain yang sudah menggunakan `AddNote`.

**Bukti yang perlu diperiksa:**
- Cari pemanggilan `AddNote` pada seluruh kode aplikasi.
- Periksa apakah hasil validasi dari `AddNote` ditampilkan kepada pengguna.
- Pastikan pengguna mendapatkan pesan error ketika memasukkan judul kosong.

### Temuan 2 — Cakupan Test

**Status:** Perlu verifikasi

Test yang sudah dibuat mencakup kondisi judul kosong, judul yang hanya berisi spasi, dan judul valid. Namun, perlu diperiksa apakah kebutuhan pengujian juga mencakup kegagalan repository atau tampilan pesan error pada UI.

**Bukti yang perlu diperiksa:**
- Periksa file `test/validate_note_test.dart`.
- Pastikan skenario pengujian sudah sesuai dengan kebutuhan fitur.
- Periksa apakah terdapat pengujian untuk kondisi repository gagal dan penanganan error pada UI jika memang diwajibkan.

### Calon Temuan yang Ditolak — Import Repository Interface

**Status:** Ditolak jika AI menyatakan import tersebut melanggar Clean Architecture.

Jika AI menyatakan bahwa `AddNote` melanggar Clean Architecture hanya karena mengimpor `NoteRepository`, pernyataan tersebut tidak tepat apabila `NoteRepository` merupakan interface yang berada di lapisan domain.

Use case memang seharusnya bergantung pada abstraksi repository, bukan langsung pada implementasi repository dari lapisan data, seperti SQLite.

**Bukti yang perlu diperiksa:**
- Periksa lokasi file `note_repository.dart`.
- Pastikan `NoteRepository` merupakan interface pada lapisan domain.
- Pastikan `AddNote` tidak mengimpor implementasi repository dari lapisan data.

**Alasan penolakan:**

Import `NoteRepository` dari lapisan domain merupakan penerapan Dependency Inversion Principle. Dengan demikian, use case tetap bergantung pada abstraksi dan tidak terikat langsung dengan implementasi database.

## Refleksi

### 1. Apa beda LGTM buta dengan approve yang bertanggung jawab? Apa risikonya bagi tim?

LGTM (*Looks Good To Me*) buta adalah memberikan persetujuan terhadap Pull Request tanpa memeriksa kode dan memahami perubahan yang dilakukan. Sementara itu, approve yang bertanggung jawab dilakukan setelah reviewer memeriksa kebenaran kode, kesesuaian arsitektur, penanganan error, dan hasil pengujian.

Risiko LGTM buta bagi tim adalah bug dapat masuk ke branch utama, kesalahan arsitektur tidak terdeteksi, dan kualitas aplikasi menurun. Selain itu, tim dapat mengalami kesulitan ketika melakukan pengembangan atau pemeliharaan kode di kemudian hari.

### 2. Kapan komentar wajib berstatus *Request Changes*, dan kapan cukup saran?

Status *Request Changes* diberikan ketika ditemukan masalah penting yang harus diperbaiki sebelum Pull Request dapat diterima. Contohnya adalah kesalahan logika, validasi yang tidak berjalan, potensi crash, atau pelanggaran aturan arsitektur yang berdampak pada aplikasi.

Sementara itu, saran cukup diberikan untuk hal-hal yang tidak menghambat fungsi utama aplikasi, seperti penyederhanaan kode, penamaan variabel, atau peningkatan keterbacaan kode.

### 3. Bagian mana dari review AI yang Anda tolak atau sederhanakan, dan mengapa?

Salah satu calon temuan AI yang dapat ditolak adalah anggapan bahwa `AddNote` melanggar Clean Architecture karena mengimpor `NoteRepository`.

Temuan tersebut tidak tepat apabila `NoteRepository` merupakan interface yang berada di lapisan domain. Use case memang seharusnya bergantung pada abstraksi repository, bukan langsung pada implementasi dari lapisan data.

Dengan demikian, penggunaan interface tersebut tidak perlu diubah karena sudah sesuai dengan prinsip Dependency Inversion.

### 4. Satu hal konkret yang Anda perbaiki setelah review sejawat — apa dampaknya?

Satu perbaikan konkret yang dilakukan adalah menambahkan validasi pada use case `AddNote` agar judul catatan tidak boleh kosong atau hanya berisi spasi.

Validasi dilakukan menggunakan `trim()` sebelum data diteruskan ke repository. Selain itu, dibuat unit test untuk memastikan judul kosong dan judul yang hanya berisi spasi ditolak, sedangkan judul valid dapat diproses.

Dampaknya, data catatan tanpa judul dapat dicegah sebelum disimpan ke database sehingga kualitas dan konsistensi data menjadi lebih baik.