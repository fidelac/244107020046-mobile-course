
import '../../../../core/failures.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class AddNote {
  const AddNote(this.repository);

  final NoteRepository repository;

  Future<({Note? note, Failure? failure})> call({
    required String title,
    String body = '',
  }) async {
    if (title.trim().isEmpty) {
      return (
        note: null,
        failure: const LocalFailure('Judul catatan tidak boleh kosong.'),
      );
    }

    return repository.addNote(
      title: title.trim(),
      body: body,
    );
  }
}
