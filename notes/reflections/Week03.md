## Refleksi

#### 1. Kapan setState masih cukup, dan kapan state harus naik ke Riverpod?
- setState digunakan ketika state hanya digunakan oleh satu widget atau satu halaman dan pengelolaannya masih sederhana. Contohnya adalah perubahan tampilan pada sebuah halaman. 
Riverpod lebih sesuai ketika state perlu digunakan oleh beberapa widget atau halaman, sehingga pengelolaan state menjadi lebih terstruktur dan mudah dipisahkan dari UI. Pada aplikasi ToDo ini, Riverpod digunakan untuk mengelola daftar tugas agar state tetap tersedia ketika pengguna berpindah halaman.

#### 2. Apa perbedaan context.go dan context.push, dan kapan masing-masing tepat digunakan?
- `context.go()` digunakan untuk berpindah ke suatu route dan mengganti lokasi navigasi saat ini. Cocok digunakan untuk berpindah ke halaman utama seperti halaman ToDo atau Statistics.

- `context.push()` menambahkan halaman baru ke navigation stack. Cara ini cocok digunakan ketika ingin membuka halaman detail dan pengguna masih dapat kembali ke halaman sebelumnya menggunakan tombol back.

#### 3. Bagaimana AsyncValue mencegah bug dibanding tiga boolean terpisah?
- AsyncValue menyediakan state yang lebih terstruktur untuk menangani proses asynchronous, yaitu loading, error, dan data/success. Jika menggunakan tiga boolean terpisah seperti isLoading, hasError, dan hasData, ada kemungkinan kombinasi state menjadi tidak konsisten. Misalnya isLoading dan hasError sama-sama bernilai true. Dengan AsyncValue, kondisi tersebut dikelola sebagai satu state sehingga UI dapat menentukan tampilan berdasarkan kondisi loading, error, atau data.

#### 4. Bagian mana dari hasil AI yang Anda perbaiki, dan mengapa?
Saya melakukan beberapa perbaikan terhadap hasil AI, terutama pada bagian widget test dan tampilan UI. Pada widget test, StatsPage perlu dibungkus dengan ProviderScope dan MaterialApp agar Riverpod dan widget Material dapat berjalan dengan benar.

Selain itu, karena StatsNotifier menggunakan delay selama 2 detik, pengujian perlu menunggu proses asynchronous tersebut agar tidak menghasilkan pending timer.

Tampilan StatsPage juga saya sederhanakan dengan menambahkan icon dan membuat setiap statistik ditampilkan dalam bentuk list item agar lebih ra