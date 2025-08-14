import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:vector_math/vector_math_64.dart';

import '../widgets/ar_controls.dart';
import '../models/butterfly_example.dart';
import 'package:audioplayers/audioplayers.dart';

class ARExperienceScreen extends StatefulWidget {
  final Butterfly butterfly;
  final VoidCallback? onSwitchToStatic;
  const ARExperienceScreen({Key? key, required this.butterfly, this.onSwitchToStatic}) : super(key: key);
  @override
  State<ARExperienceScreen> createState() => _ARExperienceScreenState();
}

class _ARExperienceScreenState extends State<ARExperienceScreen> with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _controlsFade;

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? butterflyNode;

  late final Butterfly selectedButterfly;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controlsFade = CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeIn));
    Timer(const Duration(milliseconds: 80), () => _controller.forward());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recibe el modelo de mariposa seleccionada por argumentos (Navigator.pushNamed(context, '/ar', arguments: butterfly))
    // Ahora recibimos la mariposa directamente por widget.butterfly
    selectedButterfly = widget.butterfly;
    _playAmbientSound();
  }

  Future<void> _playAmbientSound() async {
    if (selectedButterfly.ambientSound != null && selectedButterfly.ambientSound!.isNotEmpty) {
      _audioPlayer ??= AudioPlayer();
      await _audioPlayer!.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer!.play(AssetSource(selectedButterfly.ambientSound!));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    arObjectManager?.dispose();
    _audioPlayer?.stop();
    _audioPlayer?.dispose();
    super.dispose();
  }

  Future<void> onARViewCreated(ARSessionManager sessionManager, ARObjectManager objectManager, ARAnchorManager anchorManager, ARLocationManager locationManager) async {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    await arSessionManager?.initialize();
    await arObjectManager?.initialize();
    // Carga el modelo de la mariposa seleccionada
    if (selectedButterfly.modelAsset != null && selectedButterfly.modelAsset!.isNotEmpty) {
      butterflyNode = ARNode(
        type: NodeType.localGLTF2,
        uri: selectedButterfly.modelAsset!,
        scale: Vector3(0.5, 0.5, 0.5),
        position: Vector3(0.0, 0.0, -1.0),
        rotation: Vector3.zero(),
      );
      await arObjectManager?.addNode(butterflyNode!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiencia RA - ${selectedButterfly.name}'),
        centerTitle: true,
        actions: [
          if (widget.onSwitchToStatic != null)
            IconButton(
              icon: const Icon(Icons.image_outlined),
              tooltip: 'Ver fondo temático',
              onPressed: widget.onSwitchToStatic,
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // ARView integrado
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontal,
            ),
            // Overlay de instrucciones y animaciones
            Center(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 80, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 24),
                      Text(
                        'Apunta la cámara a una superficie plana para ver la mariposa en RA.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _controlsFade,
                child: Center(
                  child: ARControls(
                    onInfo: () {},
                    onGrab: () {},
                    onMenu: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
