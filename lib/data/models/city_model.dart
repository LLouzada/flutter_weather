class CityModel {
  final String name;
  final String state;
  final String country;

  CityModel({required this.name, required this.state, required this.country});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
