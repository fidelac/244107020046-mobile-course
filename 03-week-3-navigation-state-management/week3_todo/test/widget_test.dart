import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week3_todo/pages/stats_page.dart';

void main() {
  testWidgets('StatsPage dapat ditampilkan', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StatsPage(),
        ),
      ),
    );

    // Menyelesaikan proses loading 2 detik.
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Statistics'), findsOneWidget);
  });
}