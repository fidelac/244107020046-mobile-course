# AI Prompt - StatsPage

## Prompt

Buatkan halaman Flutter bernama `StatsPage` menggunakan
`flutter_riverpod`.

Requirements:
- Gunakan `ConsumerWidget`.
- Gunakan satu `AsyncNotifierProvider` yang mensimulasikan
  pengambilan data statistik.
- Berikan delay selama 2 detik.
- Simulasikan kemungkinan gagal sebesar 30%.
- UI harus menangani tiga kondisi `AsyncValue`, yaitu:
  - Loading dengan `CircularProgressIndicator`.
  - Error dengan pesan error dan tombol retry.
  - Success dengan `ListView` yang menampilkan 3 item statistik.
- Berikan unit test untuk notifier.
- Jelaskan setiap bagian kode menggunakan komentar.

## Hasil dari AI

AI menghasilkan implementasi menggunakan:

- `StatsNotifier` sebagai `AsyncNotifier`.
- `statsProvider` sebagai `AsyncNotifierProvider`.
- `StatsPage` sebagai `ConsumerWidget`.
- `ref.watch(statsProvider)` untuk membaca perubahan state.
- `statsAsync.when()` untuk menangani kondisi loading, error,
  dan data.
- `ref.invalidate(statsProvider)` untuk melakukan retry.
- Unit test menggunakan `ProviderContainer`.

Data statistik yang digunakan:

1. Total Tugas: 8
2. Kehadiran: 92%
3. Nilai Rata-rata: 87

## Perbaikan yang Dilakukan

Setelah mencoba kode dari AI, dilakukan beberapa perbaikan.

### 1. Perbaikan Widget Test

Pada awalnya `StatsPage` diuji hanya menggunakan `ProviderScope`.
Hal tersebut menyebabkan error `No Directionality widget found`.

Kemudian test diperbaiki dengan menambahkan `MaterialApp`:

```dart
ProviderScope(
  child: MaterialApp(
    home: StatsPage(),
  ),
)

