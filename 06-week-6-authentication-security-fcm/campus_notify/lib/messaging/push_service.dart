import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Plugin untuk menampilkan notifikasi lokal.
final FlutterLocalNotificationsPlugin _local =
    FlutterLocalNotificationsPlugin();

// Menyimpan rute dari notifikasi lokal yang diklik.
String? pendingDeepLink;

// Callback navigasi yang didaftarkan oleh aplikasi.
void Function(String route)? _onNotificationTap;

/// Handler pesan background harus berupa fungsi top-level.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();

  // Mencatat ID pesan untuk keperluan debugging.
  // Tidak melakukan navigasi di background handler.
  // ignore: avoid_print
  print('Background message ID: ${message.messageId}');
}

/// Mendaftarkan handler background FCM.
void registerBackgroundHandler() {
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
}

/// Meminta izin notifikasi.
Future<bool> requestNotificationPermission() async {
  final settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  return settings.authorizationStatus ==
          AuthorizationStatus.authorized ||
      settings.authorizationStatus ==
          AuthorizationStatus.provisional;
}

/// Menginisialisasi notifikasi lokal.
Future<void> initLocalNotifications({
  void Function(String route)? onNotificationTap,
}) async {
  // Simpan callback navigasi agar bisa dipakai ketika notifikasi diklik.
  _onNotificationTap = onNotificationTap;

  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  // Inisialisasi plugin notifikasi lokal.
  await _local.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      final route = response.payload;

      if (route != null && route.isNotEmpty) {
        if (_onNotificationTap != null) {
          _onNotificationTap!(route);
        } else {
          pendingDeepLink = route;
        }
      }
    },
  );

  // Membuat channel notifikasi Android.
  const channel = AndroidNotificationChannel(
    'pengumuman',
    'Pengumuman Kampus',
    description: 'Notifikasi pengumuman kampus',
    importance: Importance.high,
  );

  await _local
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

/// Mendengarkan pesan FCM dan klik notifikasi.
void listenForeground(
  void Function(String route) go,
) {
  // Simpan callback navigasi untuk notifikasi lokal.
  _onNotificationTap = go;

  // Pesan diterima saat aplikasi sedang terbuka.
  FirebaseMessaging.onMessage.listen((message) async {
    final route = message.data['route'] as String? ?? '/';

    const androidDetails = AndroidNotificationDetails(
      'pengumuman',
      'Pengumuman Kampus',
      channelDescription: 'Notifikasi pengumuman kampus',
      importance: Importance.high,
      priority: Priority.high,
    );

    // Tampilkan notifikasi lokal saat foreground.
    await _local.show(
      id: message.hashCode,
      title: message.notification?.title ?? 'Pengumuman',
      body: message.notification?.body ?? '',
      notificationDetails: const NotificationDetails(
        android: androidDetails,
      ),
      payload: route,
    );
  });

  // Pengguna mengeklik notifikasi FCM saat aplikasi di background.
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    final route = message.data['route'] as String? ?? '/';
    go(route);
  });
}

/// Menangani aplikasi yang dibuka melalui notifikasi.
Future<void> handleTerminated(
  void Function(String route) go,
) async {
  // Periksa apakah aplikasi dibuka melalui notifikasi FCM.
  final initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    final route =
        initialMessage.data['route'] as String? ?? '/';

    go(route);
    return;
  }

  // Periksa apakah aplikasi dibuka melalui notifikasi lokal.
  final localDetails =
      await _local.getNotificationAppLaunchDetails();

  if (localDetails?.didNotificationLaunchApp ?? false) {
    final payload =
        localDetails?.notificationResponse?.payload;

    if (payload != null && payload.isNotEmpty) {
      go(payload);
      return;
    }
  }

  // Periksa rute yang masih tersimpan.
  if (pendingDeepLink != null) {
    final route = pendingDeepLink!;
    pendingDeepLink = null;
    go(route);
  }
}

/// Berlangganan topic pengumuman kampus.
Future<void> subscribeAnnouncementTopic() async {
  await FirebaseMessaging.instance
      .subscribeToTopic('pengumuman-kampus');
}

/// Berhenti berlangganan topic pengumuman kampus.
Future<void> unsubscribeAnnouncementTopic() async {
  await FirebaseMessaging.instance
      .unsubscribeFromTopic('pengumuman-kampus');
}