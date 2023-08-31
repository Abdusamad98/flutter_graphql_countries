import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_jobs/bloc/single_country/single_country_bloc.dart';

class CountryDetailScreen extends StatelessWidget {
  const CountryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country detail screen')),
      body: Center(
        child: BlocBuilder<SingleCountryBloc, SingleCountryState>(
          builder: (context, state) {
            if (state is SingleCountryLoading) {
              return const CircularProgressIndicator();
            }
            if (state is SingleCountrySuccess) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(state.countryModel.name),
                    Text(state.countryModel.currency),
                    Text(state.countryModel.capital),
                    Text(state.countryModel.emoji),
                    Text(state.countryModel.native),
                  ],
                ),
              );
            }
            return const Text('Oops something went wrong!');
          },
        ),
      ),
    );
  }
}
