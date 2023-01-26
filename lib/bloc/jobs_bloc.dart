import 'package:bloc/bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:meta/meta.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc({required JobsApiClient jobsApiClient})
      : _jobsApiClient = jobsApiClient,
        super(JobsLoadInProgress()) {
    on<JobsFetchStarted>(_onJobsFetchStarted);
  }

  final JobsApiClient _jobsApiClient;

  Future<void> _onJobsFetchStarted(
    JobsFetchStarted event,
    Emitter<JobsState> emit,
  ) async {
    emit(JobsLoadInProgress());
    try {
      final countries = await _jobsApiClient.getCountries();
      final singleCountry = await _jobsApiClient.getCountryById("UZ");
      print("COUNTRY NAME:${singleCountry.name}");
      emit(JobsLoadSuccess(countries));
    } catch (error) {
      print("ERRROR:$error");
      emit(JobsLoadFailure());
    }
  }
}
