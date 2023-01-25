import 'package:flutter_graphql_jobs/api/api.dart';
import 'package:flutter_graphql_jobs/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';

class GetJobsRequestFailure implements Exception {}

class JobsApiClient {
  const JobsApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory JobsApiClient.create() {
    final httpLink = HttpLink('https://countries.trevorblades.com');
    final link = Link.from([httpLink]);
    return JobsApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }


  final GraphQLClient _graphQLClient;

  Future<List<CountryModel>> getJobs() async {
    final result = await _graphQLClient.query(
      QueryOptions(document: gql(queries.getJobs)),
    );
    if (result.hasException) throw GetJobsRequestFailure();
    final data = result.data?['countries'] as List;
    print("SUCCESS DATA:${result.data.toString()}");
    return data
        .map((dynamic e) => CountryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
