import 'package:flutter/material.dart';
import 'package:flutter_graphql_jobs/api/models/country_detail_model.dart';
import 'package:flutter_graphql_jobs/api/queries/get_single_country.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryDetailScreen extends StatelessWidget {
  const CountryDetailScreen({super.key, required this.countryCode});

  final String countryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country detail screen')),
      body: Center(
        child: Query(
          options: QueryOptions(
            document: gql(getSingleCountry),
            variables: {'code': countryCode},
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Text('Loading');
            }
            final countryDetail = CountryDetailModel.fromJson(
                result.data?['country'] as Map<String, dynamic>);
            if (countryDetail == null) {
              return const Text('No repositories');
            }
            return Text(countryDetail.name);
          },
        ),
      ),
    );
  }
}
