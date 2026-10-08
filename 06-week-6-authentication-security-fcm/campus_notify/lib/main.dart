import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/announcement_page.dart';
import 'providers/auth_provider.dart';
import 'messaging/push_service.dart';

// Container Riverpod yang digunakan oleh router.
final container = ProviderContainer();

// Router aplikasi.
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  redirect: (context, state) {
    final loggedIn =
        container.read(authStateProvider).value ?? false;

    final goingLogin = state.matchedLocation == '/login';

    if (!loggedIn && !goingLogin) {
      return '/login';
    }

    if (loggedIn && goingLogin) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/pengumuman/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return AnnouncementPage(id: id);
      },
    ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase.
  await Firebase.initializeApp();

  // Mendaftarkan handler pesan background.
  registerBackgroundHandler();

  // Menyiapkan notifikasi lokal.
  await initLocalNotifications();

  // Meminta izin notifikasi.
  await requestNotificationPermission();

  // Berlangganan topic pengumuman kampus.
  await subscribeAnnouncementTopic();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Menerima pesan dan menangani klik notifikasi.
    listenForeground((route) {
      appRouter.go(route);
    });

    // Memeriksa apakah aplikasi dibuka melalui notifikasi.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleTerminated((route) {
        appRouter.go(route);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Campus Notify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}