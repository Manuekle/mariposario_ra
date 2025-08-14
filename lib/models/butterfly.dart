class Butterfly {
  final String name;
  final String scientificName;
  final String imageAsset;
  final String modelAsset;
  final String? ambientSound;

  Butterfly({
    required this.name,
    required this.scientificName,
    required this.imageAsset,
    required this.modelAsset,
    this.ambientSound,
  });
}
