import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_client.dart';
import 'local/note.dart';
import 'models/post.dart';
import 'repositories/note_repository.dart';
import 'repositories/post_repository.dart';


// ============================================================
// DIO PROVIDER
// ============================================================

final dioProvider = Provider<Dio>((ref) {
  return createDio();
});


// ============================================================
// POST REPOSITORY
// ============================================================

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository(
    dio: ref.watch(dioProvider),
  );
});


// ============================================================
// POST LIST PROVIDER
// Digunakan untuk mengambil data /posts dari API.
// ============================================================

class PostListNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    final repository = ref.watch(postRepositoryProvider);

    // Jika repository mengalami exception,
    // Riverpod otomatis mengubah state menjadi AsyncError.
    return repository.fetchPosts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(postRepositoryProvider);

      final posts = await repository.fetchPosts();

      state = AsyncData(posts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final postListProvider =
    AsyncNotifierProvider<PostListNotifier, List<Post>>(
  PostListNotifier.new,

  // Nonaktifkan retry otomatis Riverpod.
  // Ini membuat error lebih mudah diuji.
  retry: (retryCount, error) => null,
);


// ============================================================
// CACHE-FIRST PROVIDER
// ============================================================

/// Provider untuk simulasi kondisi offline.
///
/// false = aplikasi dianggap online.
/// true  = aplikasi dipaksa menggunakan cache lokal.
class ForceOfflineNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

final forceOfflineProvider =
    NotifierProvider<ForceOfflineNotifier, bool>(
  ForceOfflineNotifier.new,
);

class PostsCacheFirstNotifier
    extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    final repository = ref.watch(postRepositoryProvider);
    final offline = ref.watch(forceOfflineProvider);

    // Langkah pertama selalu membaca cache lokal.
    final cached = await repository.readCachedPosts();

    // ----------------------------------------------------------
    // MODE OFFLINE
    // ----------------------------------------------------------

    if (offline) {
      return cached;
    }

    // ----------------------------------------------------------
    // CACHE TERSEDIA
    // ----------------------------------------------------------

    if (cached.isNotEmpty) {
      // Tampilkan cache terlebih dahulu.
      //
      // Setelah itu lakukan update data dari API
      // secara background.
      _refreshInBackground(repository);

      return cached;
    }

    // ----------------------------------------------------------
    // CACHE KOSONG
    // ----------------------------------------------------------

    // Jika belum ada cache, ambil data langsung dari API.
    final posts = await repository.fetchPosts();

    // Simpan data API ke cache lokal.
    await repository.saveCachedPosts(posts);

    return posts;
  }

  /// Mengambil data terbaru dari API secara background.
  ///
  /// Jika gagal, data cache yang sudah tampil
  /// tetap dipertahankan.
  Future<void> _refreshInBackground(
    PostRepository repository,
  ) async {
    try {
      final posts = await repository.fetchPosts();

      await repository.saveCachedPosts(posts);

      // Update UI dengan data terbaru.
      state = AsyncData(posts);
    } catch (_) {
      // Jangan mengubah state menjadi error.
      //
      // Cache masih valid untuk ditampilkan ketika
      // background refresh gagal.
    }
  }

  /// Refresh manual.
  ///
  /// Digunakan ketika user melakukan pull-to-refresh
  /// pada CachedPostsPage.
  Future<void> refresh() async {
    final repository = ref.read(postRepositoryProvider);
    final offline = ref.read(forceOfflineProvider);

    // ----------------------------------------------------------
    // OFFLINE
    // ----------------------------------------------------------

    if (offline) {
      final cached = await repository.readCachedPosts();

      state = AsyncData(cached);

      return;
    }

    // ----------------------------------------------------------
    // ONLINE
    // ----------------------------------------------------------

    state = const AsyncLoading();

    try {
      final posts = await repository.fetchPosts();

      // Simpan data terbaru.
      await repository.saveCachedPosts(posts);

      // Tampilkan data terbaru.
      state = AsyncData(posts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


// Provider utama untuk halaman Cache-First.
final postsCacheFirstProvider =
    AsyncNotifierProvider<PostsCacheFirstNotifier, List<Post>>(
  PostsCacheFirstNotifier.new,
);


// ============================================================
// NOTE REPOSITORY
// ============================================================

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository();
});


// ============================================================
// NOTES PROVIDER
// Digunakan untuk daftar catatan.
// ============================================================

class NotesNotifier extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    final repository = ref.watch(noteRepositoryProvider);

    return repository.fetchNotes();
  }

  /// Menambahkan catatan baru.
  Future<void> addNote({
    required String title,
    String body = '',
  }) async {
    final repository = ref.read(noteRepositoryProvider);

    await repository.addNote(
      title: title,
      body: body,
    );

    // Muat ulang daftar catatan.
    ref.invalidateSelf();
  }

  /// Menghapus catatan berdasarkan ID.
  Future<void> deleteNote(int id) async {
    final repository = ref.read(noteRepositoryProvider);

    await repository.deleteNote(id);

    // Refresh daftar catatan.
    ref.invalidateSelf();

    // Refresh provider detail catatan tersebut.
    ref.invalidate(noteByIdProvider(id));
  }

  /// Refresh daftar catatan secara manual.
  Future<void> refresh() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(noteRepositoryProvider);

      final notes = await repository.fetchNotes();

      state = AsyncData(notes);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


final notesProvider =
    AsyncNotifierProvider<NotesNotifier, List<Note>>(
  NotesNotifier.new,
);


// ============================================================
// NOTE BY ID PROVIDER
// Digunakan oleh NoteDetailPage.
// ============================================================

final noteByIdProvider =
    FutureProvider.family<Note?, int>((ref, id) async {
  final repository = ref.watch(noteRepositoryProvider);

  return repository.fetchNoteById(id);
});


// ============================================================
// TESTING HELPER
// ============================================================

/// Membaca hasil pertama postListProvider
/// yang bukan loading.
///
/// Helper ini digunakan untuk unit test/widget test
/// tanpa harus menunggu retry otomatis Riverpod.
Future<List<Post>> readPostsOnce(
  ProviderContainer container,
) {
  final completer = Completer<List<Post>>();

  final sub = container.listen<AsyncValue<List<Post>>>(
    postListProvider,
    (previous, next) {
      // Abaikan state loading.
      if (next.isLoading || completer.isCompleted) {
        return;
      }

      // Jika berhasil mendapatkan data.
      next.whenData(completer.complete);

      // Jika terjadi error.
      if (next.hasError) {
        completer.completeError(
          next.error ?? StateError('unknown error'),
          next.stackTrace ?? StackTrace.empty,
        );
      }
    },
    fireImmediately: true,
  );

  return completer.future.whenComplete(sub.close);
}


/// Membaca error pertama dari postListProvider.
///
/// Digunakan untuk test error repository/network.
Future<Object?> readPostsErrorOnce(
  ProviderContainer container,
) {
  final completer = Completer<Object?>();

  final sub = container.listen<AsyncValue<List<Post>>>(
    postListProvider,
    (previous, next) {
      if (next.isLoading || completer.isCompleted) {
        return;
      }

      completer.complete(next.error);
    },
    fireImmediately: true,
  );

  return completer.future.whenComplete(sub.close);
}