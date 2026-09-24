## Refleksi

#### 1. Mengapa UI dilarang memanggil Dio langsung? Apa yang rusak jika aturan ini dilanggar?
- UI dilarang memanggil Dio secara lansgung agar kode lebih terstruktur dan mudah dipelihara. pengambilan data dipisahkan ke repository, sedangkan UI hanya berinteraksi dengan Riverpod
Alurnya menjadi:

UI → Riverpod → Repository → Dio → REST API

Jika UI memanggil Dio langsung, kode menjadi lebih sulit diuji dan dipelihara karena logika API bercampur dengan kode tampilan.

#### 2. Kapan pagination client-side cukup, dan kapan harus mengandalkan pagination server (_page/_limit)?
- `Pagination client-side` Jika jumlah data yang diterima tidak terlalu banyak dan seluruh data masih aman untuk dimuat sekaligus
- `Pagination server-side` jika datanya sangat banyak, Server hanya mengirim sebagian data sesuai halaman yang diminta sehingga penggunaan bandwidht dan memori lebih efisien

#### 3. Bagaimana exception repository berubah menjadi AsyncError tanpa try/catch di setiap widget? Kapan try/catch eksplisit tetap dibutuhkan?
- Pada `AsyncNotifier`, jika proses build() / pengambilan data menghasilkan exception, Riverpod akan menangkapnya dan mengubah state menjadi AsyncError. Ui kemudian menangani state tersebut menggunakan .when()
- `try/catch` diperlukan jika ingim melakukan penanganan khusus, contoh mengubah pesan error, melakukan fallback data, logging, / menjalankan aksi tertentu setelah terjadi error

#### 4. Bagian mana dari hasil AI yang Anda perbaiki, dan mengapa?
Beberapa bagian hasil AI diperbaiki agar lebih sesuai dengan kebutuhan project, yaitu:
- Membuat Post.fromJson() lebih aman terhadap field yang hilang atau null.
- Memindahkan friendlyErrorMessage() ke file network_errors.dart agar kode lebih terorganisir.
- Membuat widget PostTile agar kode tampilan list dapat digunakan kembali.
- Menambahkan fake repository pada testing sehingga provider dapat diuji tanpa benar-benar memanggil API.