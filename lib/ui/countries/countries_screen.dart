import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_jobs/bloc/countries/countries_bloc.dart';
import 'package:flutter_graphql_jobs/bloc/single_country/single_country_bloc.dart';
import 'package:flutter_graphql_jobs/ui/country_detail/country_detail_screen.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Center(
        child: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            if (state is CountriesLoadInProgress) {
              return const CircularProgressIndicator();
            }
            if (state is CountriesLoadSuccess) {
              return ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final country = state.jobs[index];
                  return ListTile(
                    onTap: () {
                      context.read<SingleCountryBloc>().add(SingleCountryFetch(code: country.code));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CountryDetailScreen();
                          },
                        ),
                      );
                    },
                    key: Key(country.native),
                    leading: const Icon(Icons.location_city),
                    title: Text(country.name),
                    trailing: Text(country.emoji),
                    subtitle: Text(country.capital),
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
