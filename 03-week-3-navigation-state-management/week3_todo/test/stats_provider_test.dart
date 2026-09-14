import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week3_todo/providers/stats_provider.dart';

void main() {
  test('StatsNotifier menghasilkan data statistik', () async {
    final container = ProviderContainer();

    addTearDown(container.dispose);

    final future = container.read(statsProvider.future);

    // Memungkinkan proses async berjalan selama 2 detik.
    await Future.delayed(const Duration(seconds: 2));

    final result = await future;

    expect(result.length, 3);
    expect(result[0], 'Total Tugas: 8');
    expect(result[1], 'Kehadiran: 92%');
    expect(result[2], 'Nilai Rata-rata: 87');
  });
}