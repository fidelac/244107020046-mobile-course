import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/notes_providers.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notesProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchNotes = ref.watch(searchNotesProvider);

    return Column(
      children: [
        Padding(
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
        ),
        Expanded(
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
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
            data: (notes) {
              if (notes.isEmpty) {
                return const Center(child: Text('Belum ada catatan.'));
              }

              final filteredNotes = searchNotes(notes, searchQuery);

              if (filteredNotes.isEmpty) {
                return const Center(child: Text('Catatan tidak ditemukan.'));
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
          ),
        ),
      ],
    );
  }
}
