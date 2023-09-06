class MapModel {
  final bool visibleMap;

  const MapModel({
    this.visibleMap = false,
  });

  MapModel copyWith({
    bool? visibleMap,
  }) =>
      MapModel(
        visibleMap: visibleMap ?? this.visibleMap,
      );
}
