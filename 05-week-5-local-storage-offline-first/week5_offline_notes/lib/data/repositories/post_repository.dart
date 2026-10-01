import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db.dart';
import '../models/post.dart';

class PostRepository {
  PostRepository({
    Dio? dio,
    Future<Database> Function()? openDb,
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://jsonplaceholder.typicode.com',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            ),
        _openDb = openDb ?? openNotesDb;

  final Dio _dio;
  final Future<Database> Function() _openDb;

  Future<List<Post>> fetchPosts() async {
    final response = await _dio.get<List>('/posts');

    final data = response.data ?? [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(Post.fromJson)
        .toList();
  }

  Future<List<Post>> readCachedPosts() async {
    final db = await _openDb();

    final rows = await db.query(
      'cached_posts',
      orderBy: 'cached_at DESC',
    );

    if (rows.isEmpty) {
      return [];
    }

    final posts = <Post>[];

    for (final row in rows) {
      final payload = row['payload'] as String?;

      if (payload == null) {
        continue;
      }

      final json = jsonDecode(payload);

      if (json is Map<String, dynamic>) {
        posts.add(Post.fromJson(json));
      }
    }

    return posts;
  }

  Future<void> saveCachedPosts(List<Post> posts) async {
    final db = await _openDb();

    await db.transaction((txn) async {
      await txn.delete('cached_posts');

      final now = DateTime.now().toIso8601String();

      for (final post in posts) {
        await txn.insert(
          'cached_posts',
          {
            'id': post.id,
            'payload': jsonEncode(post.toJson()),
            'cached_at': now,
          },
        );
      }
    });
  }
  Future<List<Post>> fetchPostsPage({
  required int page,
  int limit = 10,
}) async {
  final response = await _dio.get<List>(
    '/posts',
    queryParameters: {
      '_page': page,
      '_limit': limit,
    },
  );

  final data = response.data ?? [];

  return data
      .whereType<Map<String, dynamic>>()
      .map(Post.fromJson)
      .toList();
}
}