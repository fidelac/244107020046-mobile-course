# Week 2 - declarative UI responsive design


### Checklist verifikasi
- [] flutter analyze tidak menghasilkan error.
- [x] flutter test lulus semua widget test responsif.
- [x] Aplikasi dapat dijalankan pada ukuran layar sempit dan lebar.
- [x] Dark mode memiliki kontras dan teks yang terbaca.
- [] Struktur widget dapat dijelaskan saat code review.
- [] Screenshot, folder test/, dan README sudah tersimpan pada folder tugas Week 2.

#
### Praktikum Step 4
![Screenshot](Screenshot/Praktikum.png)

#### Eksperimen warm-up
1. Hapus Expanded pada baris nama, lalu amati peringatan overflow atau perilaku layout-nya; kembalikan setelah itu.

![Screenshot](Screenshot/Hapus_Expanded.png)
##
2. Ganti mainAxisSize: MainAxisSize.min menjadi nilai default dan amati perubahan tinggi kartu.

![Screenshot](Screenshot/MainAxisSize.max.png)
##
3. Tambahkan satu baris data (misal Email) menggunakan pola Row + Expanded yang sama.

![Screenshot](Screenshot/AddEmail.png)

#
### Praktikum Step 5

#### Eksperimen layout
1. Ubah breakpoint dari 700 menjadi nilai lain dan amati perubahan jumlah kolom.
- Mengubah 700 -> 500
![Screenshot](screenshot/BreakPoint500.png)
##
2. Ubah themeMode menjadi ThemeMode.dark, lalu kembalikan ke ThemeMode.system.

#### ThemeMode.dark
![Screenshot](screenshot/ThemeMode.dark.png)
##
3. Uji aplikasi dengan ukuran layar emulator yang berbeda.

![Screenshot](screenshot/smallsize.png)
Pada layar yang lebih kecil dashboard menampilkan satu kolom

![Screenshot](screenshot/Bigsize.png)
sedangkan pada layar yang lebih lebar berubah menjadi dua kolom. Hal ini menunjukkan penggunaan layout responsif dengan LayoutBuilder.

#
4. Tambahkan Semantics atau label yang bermakna pada elemen yang penting bagi screen reader.
- Menambahkan Semantics pada DashboardCard dengan label yang menggabungkan judul dan nilai kartu. Tidak terdapat perubahan visual pada aplikasi karena Semantics digunakan untuk meningkatkan accessibility dan membantu screen reader memahami informasi pada elemen UI.

#
### AI Prompt Challenge


#
### Refactoring challenge

#
#### Reflection
[Week 02 Reflection](../notes/reflections).