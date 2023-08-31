import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';

class GetJobsRequestFailure implements Exception {}

class CountriesApiClient {
  const CountriesApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory CountriesApiClient.create() {
    final httpLink = HttpLink('https://countries.trevorblades.com');
    final link = Link.from([httpLink]);

    return CountriesApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<CountryModel>> getCountries() async {
    final result = await _graphQLClient.query(
      QueryOptions(document: gql(queries.getJobs)),
    );

    if (result.hasException) throw GetJobsRequestFailure();
    print("SUCCESS DATA:${result.data.toString()}");
    return (result.data?['countries'] as List?)
            ?.map(
              (dynamic e) => CountryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  Future<CountryModel> getCountryById(String code) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        variables: {'code': code},
        document: gql(r'''
         query GetCountryByCode($code:ID!){
         country(code: $code) {
         name native
         continent{ code }
         capital
         emoji
         currency
         emojiU
         awsRegion
         phones
         languages {
            code
           name
         }
       }
      }
        '''),
      ),
    );
    if (result.hasException) throw GetJobsRequestFailure();
    final data = result.data?['country'] as Map<String, dynamic>;

    print("SINGLE COUNTRY:${result.data?['country']}");
    return CountryModel.fromJson(data);
  }
}
