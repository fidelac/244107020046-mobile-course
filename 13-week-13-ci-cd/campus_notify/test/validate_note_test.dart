import 'package:flutter_test/flutter_test.dart';

import 'package:campus_notify/core/failures.dart';
import 'package:campus_notify/features/notes/domain/entities/note.dart';
import 'package:campus_notify/features/notes/domain/repositories/note_repository.dart';
import 'package:campus_notify/features/notes/domain/usecases/add_note.dart';

class FakeNoteRepository implements NoteRepository {
  bool addNoteCalled = false;
  String? savedTitle;
  bool fail = false;

  @override
  Future<({Note? note, Failure? failure})> addNote({
    required String title,
    String body = '',
  }) async {
    addNoteCalled = true;
    savedTitle = title;

    if (fail) {
      return (note: null, failure: const LocalFailure('db locked (simulasi)'));
    }

    return (
      note: Note(
        id: 1,
        title: title,
        body: body,
        updatedAt: DateTime(2026, 10, 29),
      ),
      failure: null,
    );
  }

  @override
  Future<({List<Note> notes, Failure? failure})> fetchNotes() async {
    return (notes: <Note>[], failure: null);
  }
}

void main() {
  test('Judul kosong ditolak', () async {
    final repository = FakeNoteRepository();
    final result = await AddNote(repository).call(title: '');

    expect(result.note, isNull);
    expect(result.failure, isA<LocalFailure>());
    expect(result.failure?.message, 'Judul catatan tidak boleh kosong.');
    expect(repository.addNoteCalled, isFalse);
  });

  test('Judul yang hanya berisi spasi ditolak', () async {
    final repository = FakeNoteRepository();
    final result = await AddNote(repository).call(title: '   ');

    expect(result.note, isNull);
    expect(result.failure, isA<LocalFailure>());
    expect(repository.addNoteCalled, isFalse);
  });

  test('Judul valid diteruskan ke repository setelah trim', () async {
    final repository = FakeNoteRepository();
    final result = await AddNote(repository)
        .call(title: '  Tugas Mobile  ', body: 'Catatan praktikum');

    expect(result.failure, isNull);
    expect(result.note?.title, 'Tugas Mobile');
    expect(repository.addNoteCalled, isTrue);
    expect(repository.savedTitle, 'Tugas Mobile');
  });
  test('Failure repository diteruskan ketika menyimpan catatan', () async {
    final repository = FakeNoteRepository()..fail = true;

    final result = await AddNote(repository)
        .call(title: 'Tugas Mobile', body: 'Catatan praktikum');

    expect(result.note, isNull);
    expect(result.failure, isA<LocalFailure>());
    expect(result.failure?.message, 'db locked (simulasi)');
    expect(repository.addNoteCalled, isTrue);
  });
}
