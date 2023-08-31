import 'package:bloc/bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:meta/meta.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc({required CountriesApiClient jobsApiClient})
      : _jobsApiClient = jobsApiClient,
        super(CountriesLoadInProgress()) {
    on<CountriesFetchStarted>(_onCountriesFetchStarted);
  }

  final CountriesApiClient _jobsApiClient;

  Future<void> _onCountriesFetchStarted(
    CountriesFetchStarted event,
    Emitter<CountriesState> emit,
  ) async {
    emit(CountriesLoadInProgress());
    try {
      final countries = await _jobsApiClient.getCountries();
      final singleCountry = await _jobsApiClient.getCountryById("UZ");
      print("COUNTRY NAME:${singleCountry.name}");
      emit(CountriesLoadSuccess(countries));
    } catch (error) {
      print("ERRROR:$error");
      emit(CountriesLoadFailure());
    }
  }
}
