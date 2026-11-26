import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_notify/features/notes/domain/entities/note.dart';
import 'package:campus_notify/features/notes/presentation/pages/notes_page.dart';
import 'package:campus_notify/features/notes/presentation/providers/notes_providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User can search notes from Notes page', (tester) async {
    final sampleNotes = [
      Note(
        id: 1,
        title: 'Belajar Flutter',
        body: 'Materi Flutter',
        updatedAt: DateTime.now(),
      ),
      Note(
        id: 2,
        title: 'Belajar Dart',
        body: 'Materi Dart',
        updatedAt: DateTime.now(),
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [notesProvider.overrideWith((ref) async => sampleNotes)],
        child: const MaterialApp(home: NotesPage()),
      ),
    );

    // Tunggu halaman Notes selesai dimuat
    await tester.pumpAndSettle();

    // Pastikan kedua catatan ditampilkan
    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Belajar Dart'), findsOneWidget);

    // Cari catatan dengan keyword Flutter
    await tester.enterText(find.byType(TextField), 'Flutter');

    await tester.pumpAndSettle();

    // Pastikan hanya catatan yang sesuai pencarian muncul
    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Belajar Dart'), findsNothing);
  });
}
