import 'package:flutter/material.dart';

class HubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mariposario RA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configuración',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/qr'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.qr_code, size: 28),
                  SizedBox(width: 12),
                  Text('Escanear QR', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/species'),
              child: const Text('Explorar RA'),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {},
              child: const Text('Información'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Galería'),
            ),
          ],
        ),
      ),
    );
  }
}
