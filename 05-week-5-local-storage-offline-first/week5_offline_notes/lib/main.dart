import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'data/models/post.dart';
import 'data/prefs.dart';
import 'pages/cached_post_page.dart';
import 'pages/note_detail_page.dart';
import 'pages/notes_page.dart';
import 'pages/paged_post_page.dart';
import 'pages/post_detail_page.dart';
import 'pages/settings_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // ==========================================================
    // HOME / NOTES
    // ==========================================================

    GoRoute(
      path: '/',
      builder: (context, state) => const NotesPage(),
    ),

    // ==========================================================
    // NOTE DETAIL
    // ==========================================================

    GoRoute(
      path: '/note/:id',
      builder: (context, state) {
        final id = int.tryParse(
          state.pathParameters['id'] ?? '',
        );

        if (id == null) {
          return const Scaffold(
            body: Center(
              child: Text('ID catatan tidak valid.'),
            ),
          );
        }

        return NoteDetailPage(
          noteId: id,
        );
      },
    ),

    // ==========================================================
    // CACHE-FIRST POSTS
    // ==========================================================

    GoRoute(
      path: '/posts-cache',
      builder: (context, state) {
        return const CachedPostsPage();
      },
    ),

    // ==========================================================
    // SETTINGS
    // ==========================================================

    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),

    // ==========================================================
    // PAGINATION POSTS
    // ==========================================================

    GoRoute(
      path: '/posts',
      builder: (context, state) {
        return const PagedPostPage();
      },
    ),

    // ==========================================================
    // POST DETAIL
    // ==========================================================

    GoRoute(
      path: '/post/:id',
      builder: (context, state) {
        final extra = state.extra;

        // Post dikirim melalui extra dari halaman sebelumnya.
        if (extra is! Post) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Data post tidak tersedia.',
              ),
            ),
          );
        }

        return PostDetailPage(
          post: extra,
        );
      },
    ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Menyimpan waktu terakhir aplikasi dibuka.
  await PrefsRepository().markOpenedNow();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final isDark =
        ref.watch(darkModeProvider).value ?? false;

    return MaterialApp.router(
      title: 'Week 5 - Offline Notes',

      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      themeMode:
          isDark ? ThemeMode.dark : ThemeMode.light,

      routerConfig: appRouter,
    );
  }
}