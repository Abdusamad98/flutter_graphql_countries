

class CountryDetailModel {
  const CountryDetailModel({
    required this.name,
    required this.capital,
    required this.currency,
    required this.emoji,
    required this.native,
  });

  final String name;
  final String native;
  final String capital;
  final String emoji;
  final String currency;

  factory CountryDetailModel.fromJson(Map<String, dynamic> json) => CountryDetailModel(
        name: json['name'] as String? ?? "",
        native: json['native'] as String? ?? "",
        capital: json['capital'] as String? ?? "",
        emoji: json['emoji'] as String? ?? "",
        currency: json['currency'] as String? ?? "",
      );
}
