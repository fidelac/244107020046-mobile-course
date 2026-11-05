import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/notes_database.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/repositories/note_repository.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/search_notes.dart';
import '../../domain/entities/note.dart';

// Data layer: database opener disuntikkan
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepositoryImpl(openDb: openNotesDb);
});

// Domain layer: use case untuk mengambil catatan
final getNotesProvider = Provider<GetNotes>((ref) {
  return GetNotes(ref.watch(noteRepositoryProvider));
});

// Domain layer: use case untuk mencari catatan
final searchNotesProvider = Provider<SearchNotes>((ref) {
  return const SearchNotes();
});

// Presentation layer: state untuk daftar catatan
final notesProvider = FutureProvider<List<Note>>((ref) async {
  final result = await ref.watch(getNotesProvider).call();

  if (result.failure != null) {
    throw Exception(result.failure!.message);
  }

  return result.notes;
});

// Presentation layer: state untuk kata kunci pencarian
final searchQueryProvider = StateProvider<String>((ref) => '');
