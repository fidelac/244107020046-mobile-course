import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../data/token_store.dart';

/// Provider untuk TokenStore.
/// Digunakan untuk menyimpan dan membaca access token
/// serta refresh token secara aman.
final tokenStoreProvider = Provider<TokenStore>((ref) {
  return TokenStore();
});

/// Provider untuk AuthRepository.
/// Digunakan untuk proses login dan refresh token.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Menyimpan status login user.
///
/// true  = user sudah login
/// false = user belum login
final authStateProvider =
    AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);

/// Notifier yang mengatur proses authentication.
class AuthNotifier extends AsyncNotifier<bool> {
  /// Saat provider pertama kali dibuat,
  /// cek apakah access token sudah tersimpan.
  @override
  Future<bool> build() async {
    final token =
        await ref.watch(tokenStoreProvider).readAccess();

    return token != null;
  }

  /// Melakukan proses login.
  Future<void> login(
    String email,
    String password,
  ) async {
    // Tampilkan state loading.
    state = const AsyncLoading();

    // Jalankan proses login dan tangani error
    // menjadi AsyncError secara otomatis.
    state = await AsyncValue.guard(() async {
      final session = await ref
          .read(authRepositoryProvider)
          .login(
            email: email,
            password: password,
          );

      // Simpan access token dan refresh token
      // ke secure storage.
      await ref
          .read(tokenStoreProvider)
          .save(
            access: session.access,
            refresh: session.refresh,
          );

      return true;
    });
  }

  /// Logout dan hapus token.
  Future<void> logout() async {
    await ref.read(tokenStoreProvider).clear();

    // Bangun ulang provider agar status login
    // berubah menjadi false.
    ref.invalidateSelf();
  }
}