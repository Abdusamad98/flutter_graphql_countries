import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/bloc/jobs_bloc.dart';

void main() => runApp(MyApp(jobsApiClient: JobsApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.jobsApiClient});

  final JobsApiClient jobsApiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => JobsBloc(
          jobsApiClient: jobsApiClient,
        )..add(JobsFetchStarted()),
        child: const JobsPage(),
      ),
    );
  }
}

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Center(
        child: BlocBuilder<JobsBloc, JobsState>(
          builder: (context, state) {
            if (state is JobsLoadInProgress) {
              return const CircularProgressIndicator();
            }
            if (state is JobsLoadSuccess) {
              return ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final job = state.jobs[index];
                  return ListTile(
                    key: Key(job.native),
                    leading: const Icon(Icons.location_city),
                    title: Text(job.name),
                    trailing: Text(job.emoji),
                    subtitle: Text(job.capital),
                  );
                },
              );
            }
            return const Text('Oops something went wrong!');
          },
        ),
      ),
    );
  }
}
