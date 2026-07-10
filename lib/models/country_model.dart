class CountryModel {
  final String name;
  final String capital;
  final String flagUrl;

  CountryModel({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] ?? 'Unknown',
      capital: json['capital'] ?? 'Tidak ada ibu kota',
      flagUrl: json['emoji'] ?? '',
    );
  }
}
