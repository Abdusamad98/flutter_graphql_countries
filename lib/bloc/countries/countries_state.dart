part of 'countries_bloc.dart';

@immutable
abstract class CountriesState {}

class CountriesLoadInProgress extends CountriesState {}

class CountriesLoadSuccess extends CountriesState {
  CountriesLoadSuccess(this.jobs);

  final List<CountryModel> jobs;
}

class CountriesLoadFailure extends CountriesState {}
