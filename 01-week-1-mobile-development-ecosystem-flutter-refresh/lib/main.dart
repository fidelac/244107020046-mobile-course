import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
        appBar: AppBar(title: const Text('Profil Mahasiswa ')),
        body: const Center(
          child: Column(mainAxisSize: MainAxisSize.min, children:[
            Icon(Icons.school, size: 72),
            SizedBox(height: 16),  
            Text('Fidela Clarisa ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('244107020046', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('D4 Teknik Informatika', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Pemograman Mobile - Minggu 1', style: TextStyle(fontSize: 16)),
          ]),
        ),
      ),
    );
  }
}

