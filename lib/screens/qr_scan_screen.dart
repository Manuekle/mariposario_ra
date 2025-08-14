import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/butterfly.dart';
import '../models/butterfly_loader.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  bool _found = false;
  String? _error;

  void _onDetect(BarcodeCapture capture) async {
    if (_found) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null) return;
    setState(() => _found = true);
    final butterflies = await loadButterflies();
    final match = butterflies.firstWhere(
      (b) => b.name.toLowerCase() == code.toLowerCase() ||
             b.name.replaceAll(' ', '').toLowerCase() == code.toLowerCase(),
      orElse: () => butterflies.firstWhere(
        (b) => b.scientificName.toLowerCase() == code.toLowerCase(),
        orElse: () => null,
      ),
    );
    if (match != null) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => AnimatedButterflyView(butterfly: match),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      setState(() {
        _error = 'No se encontró una mariposa para ese QR.';
        _found = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Escanear QR'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _onDetect,
            fit: BoxFit.cover,
          ),
          if (_error != null)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red.withOpacity(0.7),
                  child: Text(_error!, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          if (!_found)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 32),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Enfoca el QR del área para ver la mariposa',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
