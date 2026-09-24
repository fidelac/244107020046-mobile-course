import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/comment.dart';
import 'repositories/comment.dart';

// Provider untuk membuat Dio client.
//
// Dio akan digunakan oleh repository untuk melakukan HTTP request.
final commentDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',

      // Timeout ketika mencoba terhubung ke server.
      connectTimeout: const Duration(seconds: 10),

      // Timeout ketika menerima response dari server.
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

// Provider untuk CommentRepository.
//
// Repository mendapatkan Dio dari commentDioProvider.
final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepository(
    ref.watch(commentDioProvider),
  );
});

// AsyncNotifier digunakan untuk mengambil data comment
// secara asynchronous.
class CommentNotifier extends AsyncNotifier<List<Comment>> {
  @override
  Future<List<Comment>> build() async {
    // postId yang digunakan untuk contoh.
    //
    // Misalnya mengambil comment untuk post dengan ID 1.
    const postId = 1;

    final repository = ref.watch(commentRepositoryProvider);

    // Jika request berhasil, data dikembalikan sebagai AsyncData.
    //
    // Jika terjadi exception, Riverpod otomatis mengubah
    // state menjadi AsyncError.
    return repository.fetchComments(postId);
  }
}

// Provider untuk mengakses CommentNotifier.
final commentProvider =
    AsyncNotifierProvider<CommentNotifier, List<Comment>>(
  CommentNotifier.new,
);

String friendlyCommentErrorMessage(Object error) {
  // Memeriksa apakah error berasal dari Dio.
  if (error is DioException) {
    switch (error.type) {
      // Request terlalu lama ketika melakukan koneksi.
      case DioExceptionType.connectionTimeout:
        return 'Koneksi terlalu lama. Periksa internet Anda lalu coba lagi.';

      // Request terlalu lama ketika mengirim data.
      case DioExceptionType.sendTimeout:
        return 'Pengiriman data terlalu lama. Coba lagi.';

      // Server terlalu lama mengirim response.
      case DioExceptionType.receiveTimeout:
        return 'Server terlalu lama merespons. Coba lagi nanti.';

      // Tidak dapat terhubung ke server.
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server. Periksa internet Anda.';

      // Server memberikan HTTP error.
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 404) {
          return 'Data comment tidak ditemukan (404).';
        }

        if (statusCode == 500) {
          return 'Server sedang bermasalah (500). Coba lagi nanti.';
        }

        return 'Server mengalami masalah ($statusCode).';

      default:
        return 'Terjadi kesalahan jaringan. Coba lagi.';
    }
  }

  // Untuk error selain DioException.
  return 'Terjadi kesalahan tak terduga. Coba lagi.';
}