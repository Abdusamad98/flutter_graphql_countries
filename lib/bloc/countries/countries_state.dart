part of 'countries_bloc.dart';

@immutable
abstract class CountriesState {}

class CountriesLoadInProgress extends CountriesState {}

class CountriesLoadSuccess extends CountriesState {
  CountriesLoadSuccess(this.countries);

  final List<CountryModel> countries;
}

class CountriesLoadFailure extends CountriesState {}
