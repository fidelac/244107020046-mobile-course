import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/prefs.dart';


// ============================================================
// PREFS REPOSITORY PROVIDER
// ============================================================

final prefsRepositoryProvider =
    Provider<PrefsRepository>((ref) {
  return PrefsRepository();
});


// ============================================================
// DARK MODE PROVIDER
// ============================================================

final darkModeProvider =
    AsyncNotifierProvider<DarkModeNotifier, bool>(
  DarkModeNotifier.new,
);


class DarkModeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return ref
        .watch(prefsRepositoryProvider)
        .getDarkMode();
  }

  Future<void> toggle() async {
    final current = state.value ?? false;

    final next = !current;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(prefsRepositoryProvider)
          .setDarkMode(next);

      return next;
    });
  }
}


// ============================================================
// SETTINGS PAGE
// ============================================================

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final darkMode =
        ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),

      body: darkMode.when(
        // ------------------------------------------------------
        // LOADING
        // ------------------------------------------------------

        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // ------------------------------------------------------
        // ERROR
        // ------------------------------------------------------

        error: (error, stackTrace) {
          return Center(
            child: Text(
              'Gagal memuat pengaturan: $error',
            ),
          );
        },

        // ------------------------------------------------------
        // DATA
        // ------------------------------------------------------

        data: (isDarkMode) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text(
                  'Dark Mode',
                ),

                subtitle: const Text(
                  'Gunakan tema gelap pada aplikasi',
                ),

                value: isDarkMode,

                onChanged: (_) {
                  ref
                      .read(
                        darkModeProvider.notifier,
                      )
                      .toggle();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}