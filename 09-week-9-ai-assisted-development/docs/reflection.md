
# Week 9 Reflection

## 1. Apa kesalahan atau hallucination AI yang ditemukan? Bagaimana cara membuktikannya?

Selama proses pengembangan, ditemukan ketidaksesuaian pada contoh kode yang diberikan AI, terutama terkait lokasi import file provider.

Contoh import awal tidak sesuai dengan struktur folder project yang sebenarnya.

Hal tersebut dibuktikan dengan memeriksa direktori project menggunakan PowerShell dan menemukan bahwa file `notes_providers.dart` berada di folder `presentation/providers`.

Selain itu, proses debugging juga menemukan bahwa file provider sempat berisi kode widget test. Kondisi tersebut menyebabkan deklarasi provider tidak dapat dikenali oleh aplikasi.

Perbaikan dilakukan dengan mengembalikan kode provider ke file yang benar dan menempatkan widget test pada file terpisah.

## 2. Prompt seperti apa yang paling membantu? Apakah ada perubahan setelah hasil awal AI?

Prompt yang paling membantu adalah prompt yang menjelaskan peran AI, konteks project, tugas, batasan implementasi, dan output yang diharapkan.

Dengan memberikan konteks bahwa aplikasi menggunakan Flutter dan Riverpod serta memiliki pemisahan presentation layer dan domain layer, hasil AI menjadi lebih mudah disesuaikan dengan project.

Setelah mendapatkan hasil awal, beberapa penyesuaian tetap dilakukan, terutama pada lokasi import, jenis provider, dan struktur file pengujian.

## 3. Refactoring apa yang dilakukan?

Refactoring dilakukan dengan menempatkan logika pencarian pada domain use case `SearchNotes`.

Sebelumnya, proses pencarian perlu diperhatikan agar tidak seluruhnya dilakukan langsung di dalam widget.

Dengan menggunakan use case, tanggung jawab widget menjadi lebih berfokus pada tampilan dan interaksi pengguna, sedangkan proses pencarian berada pada domain layer.

## 4. Apa keputusan AI Challenge yang paling sulit?

Salah satu tantangan adalah menentukan apakah saran AI sudah sesuai dengan struktur project yang sebenarnya.

Contohnya adalah lokasi import provider. Walaupun contoh kode terlihat benar secara penulisan, lokasi file yang digunakan tidak sesuai dengan direktori project.

Karena itu, keputusan harus didasarkan pada pemeriksaan struktur folder dan pesan error yang muncul.

## 5. Apa pembelajaran yang diperoleh?

Melalui kegiatan ini, saya memahami bahwa AI dapat membantu mempercepat proses pengembangan aplikasi, khususnya dalam implementasi fitur, pembuatan test, dan debugging.

Namun, hasil AI tidak selalu langsung sesuai dengan kondisi project. Oleh karena itu, diperlukan pemahaman terhadap kode, pemeriksaan manual, dan pengujian untuk memastikan hasil implementasi benar-benar berjalan sesuai kebutuhan.
