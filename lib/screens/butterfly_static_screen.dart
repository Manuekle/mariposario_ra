import 'package:flutter/material.dart';
import '../models/butterfly.dart';

class ButterflyStaticScreen extends StatelessWidget {
  final Butterfly butterfly;
  final VoidCallback? onSwitchToAR;
  final bool canSwitchToAR;

  const ButterflyStaticScreen({
    Key? key,
    required this.butterfly,
    this.onSwitchToAR,
    this.canSwitchToAR = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          if (canSwitchToAR && onSwitchToAR != null)
            IconButton(
              icon: const Icon(Icons.camera_outdoor),
              tooltip: 'Ver en RA',
              onPressed: onSwitchToAR,
            ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo temático
          Image.asset(
            'assets/images/fondo_butterfly.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.25),
            colorBlendMode: BlendMode.darken,
          ),
          // Contenido de la mariposa
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      butterfly.imageAsset,
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  butterfly.name,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  butterfly.scientificName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black38)],
                  ),
                ),
                const SizedBox(height: 16),
                if (butterfly.ambientSound != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.music_note, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        'Sonido de ambiente disponible',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
