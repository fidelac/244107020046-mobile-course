import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers.dart';
import '../data/local/note.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Notes'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
          IconButton(
            tooltip: 'Posts Cache-First',
            icon: const Icon(Icons.cloud),
            onPressed: () {
              context.push('/posts-cache');
            },
          ),
        ],
      ),
      body: notesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat catatan:\n$error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(notesProvider);
                  },
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Belum ada catatan.\nTekan tombol + untuk menambahkan catatan.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return _NoteItem(
                note: note,
                onTap: () {
                  if (note.id != null) {
                    context.push('/note/${note.id}');
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddNoteDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Catatan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
                    hintText: 'Masukkan judul catatan',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: bodyController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Isi',
                    hintText: 'Masukkan isi catatan',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final body = bodyController.text.trim();

                if (title.isEmpty) {
                  return;
                }

                await ref.read(notesProvider.notifier).addNote(
                      title: title,
                      body: body,
                    );

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    titleController.dispose();
    bodyController.dispose();
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({
    required this.note,
    required this.onTap,
  });

  final Note note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          note.dirty ? Icons.cloud_off : Icons.note,
        ),
      ),
      title: Text(
        note.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        note.body.isEmpty ? 'Tidak ada isi' : note.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: note.dirty
          ? const Icon(
              Icons.sync_problem,
              size: 20,
            )
          : null,
      onTap: onTap,
    );
  }
}