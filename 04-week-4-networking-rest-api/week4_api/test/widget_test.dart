import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week4_api/data/paged_posts.dart';
import 'package:week4_api/pages/paged_post_page.dart';

void main() {
  testWidgets('PagedPostPage dapat ditampilkan', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pagedPostsProvider.overrideWithBuild(
            (ref, notifier) {
              return const PagedPostsState(
                items: [],
                page: 1,
                hasMore: false,
              );
            },
          ),
        ],
        child: const MaterialApp(
          home: PagedPostPage(),
        ),
      ),
    );

    expect(find.text('Posts Paged'), findsOneWidget);
  });
}