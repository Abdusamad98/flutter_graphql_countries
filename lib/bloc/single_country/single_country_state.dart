part of 'single_country_bloc.dart';

@immutable
abstract class SingleCountryState {}

class SingleCountryLoading extends SingleCountryState {}

class SingleCountrySuccess extends SingleCountryState {
  SingleCountrySuccess(this.countryModel);

  final CountryModel countryModel;
}

class SingleCountryFailure extends SingleCountryState {}
