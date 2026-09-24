import 'package:dio/dio.dart';

import '../models/comment.dart';

class CommentRepository {
  // Repository menerima Dio dari luar.
  // Dengan begitu repository tidak membuat Dio sendiri.
  CommentRepository(this._dio);

  final Dio _dio;

  // Mengambil daftar comment berdasarkan postId.
  Future<List<Comment>> fetchComments(int postId) async {
    // Memanggil endpoint:
    // GET /comments?postId={id}
    final response = await _dio.get<List>(
      '/comments',
      queryParameters: {
        'postId': postId,
      },
      options: Options(
        // Timeout maksimal untuk request ini adalah 10 detik.
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Jika response tidak mempunyai data,
    // gunakan list kosong agar tidak terjadi null error.
    final data = response.data ?? [];

    // Mengubah setiap JSON menjadi object Comment.
    return data
        .whereType<Map<String, dynamic>>()
        .map(Comment.fromJson)
        .toList();
  }
}