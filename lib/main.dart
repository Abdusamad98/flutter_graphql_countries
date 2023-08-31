import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/bloc/countries/countries_bloc.dart';
import 'package:flutter_graphql_jobs/bloc/single_country/single_country_bloc.dart';
import 'package:flutter_graphql_jobs/ui/countries/countries_screen.dart';

void main() => runApp(MyApp(jobsApiClient: CountriesApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.jobsApiClient});

  final CountriesApiClient jobsApiClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CountriesBloc(
            jobsApiClient: jobsApiClient,
          )..add(CountriesFetchStarted()),
        ),
        BlocProvider(
          create: (_) => SingleCountryBloc(jobsApiClient: jobsApiClient),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CountriesBloc(
                jobsApiClient: jobsApiClient,
              )..add(CountriesFetchStarted()),
            ),
            BlocProvider(
              create: (_) => SingleCountryBloc(jobsApiClient: jobsApiClient),
            ),
          ],
          child: const CountriesScreen(),
        ),
      ),
    );
  }
}


