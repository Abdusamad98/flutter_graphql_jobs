import 'package:bloc/bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:meta/meta.dart';

part 'jobs_state.dart';

class JobsBloc extends Cubit<JobsState> {
  JobsBloc({required JobsApiClient jobsApiClient})
      : _jobsApiClient = jobsApiClient,
        super(JobsInitial());


  final JobsApiClient _jobsApiClient;

  Future<void> onJobsFetchStarted(
  ) async {
    emit(JobsLoadInProgress());
    try {
      final jobs = await _jobsApiClient.getJobs();
      emit(JobsLoadSuccess(jobs));
    } catch (_) {
      emit(JobsLoadFailure());
    }
  }
}
