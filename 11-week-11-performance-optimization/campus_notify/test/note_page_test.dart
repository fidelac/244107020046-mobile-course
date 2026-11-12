import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_notify/features/notes/presentation/pages/notes_page.dart';
import 'package:campus_notify/features/notes/presentation/providers/notes_providers.dart';
import 'package:campus_notify/features/notes/domain/entities/note.dart';

void main() {
  testWidgets('Menampilkan empty state ketika pencarian tidak ditemukan', (
    tester,
  ) async {
    final testNotes = [
      Note(
        id: 1,
        title: 'Belajar Flutter',
        body: 'Materi Flutter',
        updatedAt: DateTime(2026, 1, 1),
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [notesProvider.overrideWith((ref) async => testNotes)],
        child: const MaterialApp(home: Scaffold(body: NotesPage())),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'xyz123');

    await tester.pumpAndSettle();

    expect(find.text('Catatan tidak ditemukan.'), findsOneWidget);
  });
}
