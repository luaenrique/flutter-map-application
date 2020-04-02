class Place {
  final String id;
  final String longitude;
  final String latitude;
  final String name;

  Place({
    this.id,
    this.name,
    this.longitude,
    this.latitude,
  });


    factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['_id'],
      name: json['name'],
      longitude: json['longitude'],
      latitude: json['latitude']
    );
  }
}