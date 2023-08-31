import 'package:bloc/bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/api/models/country_detail_model.dart';
import 'package:meta/meta.dart';

part 'signle_country_event.dart';

part 'single_country_state.dart';

class SingleCountryBloc extends Bloc<SingleCountryEvent, SingleCountryState> {
  SingleCountryBloc({required CountriesApiClient jobsApiClient})
      : _jobsApiClient = jobsApiClient,
        super(SingleCountryLoading()) {
    on<SingleCountryFetch>(_onSingleCountryFetch);
  }

  final CountriesApiClient _jobsApiClient;

  Future<void> _onSingleCountryFetch(
    SingleCountryFetch event,
    Emitter<SingleCountryState> emit,
  ) async {
    emit(SingleCountryLoading());
    try {
      final singleCountry = await _jobsApiClient.getCountryById(event.code);
      emit(SingleCountrySuccess(singleCountry));
    } catch (error) {
      emit(SingleCountryFailure());
    }
  }
}
