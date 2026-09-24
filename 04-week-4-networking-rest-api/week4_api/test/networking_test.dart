import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week4_api/data/network_errors.dart';
import 'package:week4_api/data/models/post.dart';
import 'package:week4_api/data/models/comment.dart';

void main() {
  test('connection error menghasilkan pesan ramah pengguna', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/posts'),
      type: DioExceptionType.connectionError,
    );

    final message = friendlyErrorMessage(error);

    expect(
      message,
      'Tidak dapat terhubung ke server. Periksa internet Anda.',
    );
  });

  test('timeout menghasilkan pesan ramah pengguna', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/posts'),
      type: DioExceptionType.connectionTimeout,
    );

    final message = friendlyErrorMessage(error);

    expect(
      message,
      'Koneksi lambat atau timeout. Periksa internet Anda lalu coba lagi.',
    );
  });

  test('Post.fromJson menangani field yang hilang', () {
    final post = Post.fromJson({
      'userId': 1,
      'id': 1,
      // title dan body sengaja tidak diberikan
    });

    expect(post.userId, 1);
    expect(post.id, 1);
    expect(post.title, '');
    expect(post.body, '');
  });

  test('Comment.fromJson menangani field yang hilang', () {
    // Sengaja hanya memberikan sebagian field.
    final comment = Comment.fromJson({
      'postId': 1,
      'id': 1,
      // name, email, dan body sengaja tidak diberikan.
    });

    // Field yang tersedia tetap terbaca.
    expect(comment.postId, 1);
    expect(comment.id, 1);

    // Field yang hilang menggunakan nilai default.
    expect(comment.name, '');
    expect(comment.email, '');
    expect(comment.body, '');
  });
}