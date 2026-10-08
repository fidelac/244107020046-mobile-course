import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengumuman $id'),
      ),
      body: Center(
        child: Text(
          'Detail pengumuman dengan ID: $id',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}