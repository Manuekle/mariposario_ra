import 'dart:convert';
import 'dart:io';
import 'butterfly.dart';

/// Carga todas las mariposas leyendo species/*/metadata.json
Future<List<Butterfly>> loadButterflies() async {
  final dir = Directory('species');
  if (!await dir.exists()) return [];
  final speciesDirs = dir.listSync().whereType<Directory>();
  final butterflies = <Butterfly>[];
  for (final speciesDir in speciesDirs) {
    final metaFile = File('${speciesDir.path}/metadata.json');
    if (await metaFile.exists()) {
      final jsonStr = await metaFile.readAsString();
      final data = json.decode(jsonStr);
      butterflies.add(Butterfly(
        name: data['name'] ?? '',
        scientificName: data['scientificName'] ?? '',
        imageAsset: data['imageAsset'] ?? '',
        modelAsset: data['modelAsset'] ?? '',
        ambientSound: data['ambientSound'], // puede ser null
      ));
    }
  }
  return butterflies;
}
