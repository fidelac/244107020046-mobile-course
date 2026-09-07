import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const DashboardApp());

class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  bool isDark = false;
  @override  

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.indigo),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: DashboardPage( isDark: isDark, onDarkChanged: (value) { setState(() { isDark = value;}); 
        },
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({required this.isDark, required this.onDarkChanged, super.key}); 

  final bool isDark;
  final Function(bool) onDarkChanged;

 @override 
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar, Menampilkan AppBar dengan judul dan tombol untuk mengubah tema
      appBar: AppBar(
        title: const Text('Academic Overview'), //AppBar Academic Overview
        actions: [ // Menambahkan tombol untuk mengubah tema
          Row(
            children: [
              Icon(isDark ? Icons.dark_mode : Icons.light_mode), const SizedBox(width: 4),
              CupertinoSwitch( value: isDark, onChanged: onDarkChanged),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),

      //body, Menampilkan konten utama
      body: LayoutBuilder( // Menggunakan LayoutBuilder untuk membuat layout responsif
        builder: (context, constraints) { 
          final columns = constraints.maxWidth >= 700 ? 2 : 1;

          return ListView( // Menggunakan ListView untuk menampilkan konten
            padding: const EdgeInsets.all(16),
            children: [
              Container( // Menampilkan informasi profil mahasiswa
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer,borderRadius: BorderRadius.circular(16)),
                child: Row( 
                  children: [
                    const CircleAvatar(radius: 32, child: Icon(Icons.person),),
                    const SizedBox(width: 16),
                    Expanded( // Menampilkan informasi nama, NIM, dan program studi mahasiswa
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: const [
                          Text('Fidela Clarisa', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, ),),
                          SizedBox(height: 4),
                          Text('NIM: 244107020046'),
                          Text('TI-3I • D-IV Teknik Informatika'),
                          Text('Email: 244107020046.student.polinema.ac.id'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              GridView.count( // Menampilkan informasi akademik mahasiswa dalam bentuk grid
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.6,
                children: const [ 
                  InfoCard(title: 'Assignments', value: '8'),
                  InfoCard(title: 'Attendance', value: '92%'),
                  InfoCard(title: 'Portfolio', value: 'Ready'),
                  InfoCard(title: 'Current week', value: '02'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
              ),
            ],
          ),
        ),
      );
  }
}