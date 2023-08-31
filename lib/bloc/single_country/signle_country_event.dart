part of 'single_country_bloc.dart';

@immutable
abstract class SingleCountryEvent {}

class SingleCountryFetch extends SingleCountryEvent {
  SingleCountryFetch({required this.code});

  final String code;
}
