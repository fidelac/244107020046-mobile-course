import '../entities/note.dart';

class SearchNotes {
  const SearchNotes();

  List<Note> call(List<Note> notes, String keyword) {
    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      return notes;
    }

    return notes.where((note) {
      return note.title.toLowerCase().contains(query);
    }).toList();
  }
}
