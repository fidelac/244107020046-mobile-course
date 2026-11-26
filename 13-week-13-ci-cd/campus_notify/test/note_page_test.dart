import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_notify/features/notes/presentation/pages/notes_page.dart';
import 'package:campus_notify/features/notes/presentation/providers/notes_providers.dart';
import 'package:campus_notify/features/notes/domain/entities/note.dart';

void main() {
  testWidgets('Menampilkan loading ketika notes sedang dimuat', (tester) async {
    final completer = Completer<List<Note>>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [notesProvider.overrideWith((ref) => completer.future)],
        child: const MaterialApp(home: Scaffold(body: NotesPage())),
      ),
    );

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete([]);
  });

  testWidgets('Menampilkan daftar catatan ketika data berhasil dimuat', (
    tester,
  ) async {
    final testNotes = [
      Note(
        id: 1,
        title: 'Belajar Flutter',
        body: 'Materi Flutter',
        updatedAt: DateTime(2026, 1, 1),
      ),
      Note(
        id: 2,
        title: 'Belajar Dart',
        body: 'Materi Dart',
        updatedAt: DateTime(2026, 1, 2),
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [notesProvider.overrideWith((ref) async => testNotes)],
        child: const MaterialApp(home: Scaffold(body: NotesPage())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Materi Flutter'), findsOneWidget);
    expect(find.text('Belajar Dart'), findsOneWidget);
  });

  testWidgets('Menampilkan error dan tombol coba lagi ketika gagal memuat', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notesProvider.overrideWith(
            (ref) async => throw Exception('simulasi error'),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: NotesPage())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('simulasi error'), findsOneWidget);
    expect(find.text('Coba Lagi'), findsOneWidget);
  });

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
