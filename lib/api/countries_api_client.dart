import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/api/models/country_detail_model.dart';
import 'package:flutter_graphql_jobs/api/queries/get_single_country.dart';
import 'package:flutter_graphql_jobs/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';

class GetJobsRequestFailure implements Exception {}

class CountriesApiClient {
  const CountriesApiClient({required this.graphQLClient});

  factory CountriesApiClient.create() {
    final httpLink = HttpLink('https://countries.trevorblades.com');
    final link = Link.from([httpLink]);

    return CountriesApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  final GraphQLClient graphQLClient;

  Future<List<CountryModel>> getCountries() async {
    final result = await graphQLClient.query(
      QueryOptions(document: gql(queries.getJobs)),
    );

    if (result.hasException) throw GetJobsRequestFailure();
    return (result.data?['countries'] as List?)
            ?.map((dynamic e) => CountryModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Future<CountryDetailModel> getCountryById(String code) async {
    final result = await graphQLClient.query(
      QueryOptions(
        document: gql(getSingleCountry),
        variables: {'code': code},
      ),
    );
    final data = await result.data?['country'] as Map<String, dynamic>;
    return CountryDetailModel.fromJson(data);
  }
}
