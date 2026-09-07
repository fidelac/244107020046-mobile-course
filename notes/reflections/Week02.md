## Refleksi

#### 1. Apa perbedaan cara berpikir imperative dan declarative saat membangun UI?
- Imperative fokus pada langkah yang harus dilakukan untuk mengubah tampilan UI
- Declarative fokus pada hasil akhir yang ditampilkan dengan kondisi / data tertentu.

#### 2. Kapan Expanded membantu dan kapan penggunaannya justru menghasilkan layout error?
- Ketika membuat widged mengisi ruang yang tersisa didalam row/column. namun, expanded dapat menyebabkan error jika digunakan pada kondisi yang tidak memiliki batar ukuran yang jelas, misal column dengan tinggi yang tidak terbatas, akan menyebabkan error

#### 3. Bagaimana breakpoint dan theme memengaruhi pengalaman pengguna?
- dengan menyesuaikan tampilan ukuran layar, hingga tampilan tetap responsive dan konsisten. sementara itu theme menjaga konsistensi warna, typography dan komponen UI.  

#### 4. Apa yang Anda verifikasi dari rekomendasi AI setelah tugas inti selesai?
- Saya memverifikasi bahwa layout dashboard tetap responsif pada layar sempit (<600 px) dan layar lebar, penggunaan Expanded tidak menyebabkan overflow, serta fitur light/dark mode tetap terbaca. Saya juga memverifikasi aksesibilitas melalui penggunaan Semantics dan memastikan widget yang digunakan tersedia pada Flutter stable. Verifikasi dilakukan menggunakan flutter analyze, flutter test, dan screenshot pada ukuran layar berbed