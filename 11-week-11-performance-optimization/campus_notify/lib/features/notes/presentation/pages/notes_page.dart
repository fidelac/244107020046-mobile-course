import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/notes_providers.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _NotesSearchField(),
        Expanded(
          child: _NotesList(),
        ),
      ],
    );
  }
}

class _NotesSearchField extends ConsumerWidget {
  const _NotesSearchField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: 'Cari catatan berdasarkan judul...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _NotesList extends ConsumerWidget {
  const _NotesList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredNotesProvider);

    return state.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Gagal memuat catatan: $error'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => ref.invalidate(notesProvider),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
      data: (filteredNotes) {
        if (filteredNotes.isEmpty) {
          return const Center(
            child: Text('Catatan tidak ditemukan.'),
          );
        }

        return ListView.builder(
          itemCount: filteredNotes.length,
          itemBuilder: (context, index) {
            final note = filteredNotes[index];

            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.body),
            );
          },
        );
      },
    );
  }
}