import 'package:json_annotation/json_annotation.dart';


class CountryModel {
  const CountryModel({
    required this.name,
    required this.capital,
    required this.currency,
    required this.emoji,
    required this.native,
    required this.code,
  });

  final String name;
  final String native;
  final String capital;
  final String code;
  final String emoji;
  final String currency;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json['name'] as String? ?? '',
        native: json['native'] as String? ?? "",
        capital: json['capital'] as String? ?? "",
        emoji: json['emoji'] as String? ?? "",
        code: json['code'] as String? ?? "",
        currency: json['currency'] as String? ?? "",
      );
}
