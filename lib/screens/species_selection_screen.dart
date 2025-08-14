import 'package:flutter/material.dart';

import '../models/butterfly_example.dart';
import '../widgets/butterfly_card.dart';

class SpeciesSelectionScreen extends StatefulWidget {
  @override
  State<SpeciesSelectionScreen> createState() => _SpeciesSelectionScreenState();
}

class _SpeciesSelectionScreenState extends State<SpeciesSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona una especie')),
      body: FadeTransition(
        opacity: _fade,
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: butterflies.length,
          separatorBuilder: (_, __) => Divider(height: 32, color: Theme.of(context).dividerColor),
          itemBuilder: (context, i) {
            final butterfly = butterflies[i];
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 80));
                Navigator.pushNamed(
                  context,
                  '/preparation',
                  arguments: butterfly,
                );
              },
              splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              highlightColor: Colors.transparent,
              child: ButterflyCard(
                name: butterfly.name,
                scientificName: butterfly.scientificName,
                imageAsset: butterfly.imageAsset,
              ),
            );
          },
        ),
      ),
    );
  }
}
