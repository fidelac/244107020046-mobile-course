import 'package:flutter_test/flutter_test.dart';
import 'package:campus_notify/features/notes/domain/entities/note.dart';
import 'package:campus_notify/features/notes/domain/usecases/search_notes.dart';

void main() {
  const searchNotes = SearchNotes();

  final notes = [
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
    Note(
      id: 3,
      title: 'Database SQLite',
      body: 'Materi Database',
      updatedAt: DateTime(2026, 1, 3),
    ),
  ];

  test('Menampilkan semua catatan jika keyword kosong', () {
    final result = searchNotes(notes, '');

    expect(result.length, 3);
  });

  test('Mencari judul berdasarkan keyword', () {
    final result = searchNotes(notes, 'Flutter');

    expect(result.length, 1);
    expect(result.first.title, 'Belajar Flutter');
  });

  test('Pencarian tidak membedakan huruf besar dan kecil', () {
    final result = searchNotes(notes, 'flutter');

    expect(result.length, 1);
    expect(result.first.title, 'Belajar Flutter');
  });

  test('Mencari berdasarkan sebagian judul', () {
    final result = searchNotes(notes, 'Dart');

    expect(result.length, 1);
    expect(result.first.title, 'Belajar Dart');
  });

  test('Mengembalikan list kosong jika tidak ditemukan', () {
    final result = searchNotes(notes, 'xyz123');

    expect(result, isEmpty);
  });
}
