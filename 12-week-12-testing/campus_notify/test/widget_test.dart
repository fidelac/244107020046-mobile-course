import 'package:flutter_test/flutter_test.dart';
import 'package:campus_notify/messaging/route_parser.dart';

void main() {
  group('Route Parser Test', () {
    test('Route kosong mengarah ke halaman home', () {
      expect(routeFromMessage({}), '/');
    });

    test('Route tanpa slash ditambahkan slash', () {
      expect(
        routeFromMessage({'route': 'pengumuman/3'}),
        '/pengumuman/3',
      );
    });

    test('Route dengan slash tetap sama', () {
      expect(
        routeFromMessage({'route': '/pengumuman/3'}),
        '/pengumuman/3',
      );
    });

    test('Route pengumuman memiliki ID yang benar', () {
      const data = {
        'route': '/pengumuman/3',
        'id': '3',
      };

      expect(data['id'], '3');
      expect(routeFromMessage(data), '/pengumuman/3');
    });
  });
}