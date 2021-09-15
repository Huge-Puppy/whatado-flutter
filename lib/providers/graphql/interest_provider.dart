import 'dart:async';

import 'package:whatado/graphql/mutations_graphql_api.dart';
import 'package:whatado/graphql/queries_graphql_api.dart';
import 'package:whatado/models/interest.dart';
import 'package:whatado/models/query_response.dart';
import 'package:whatado/services/service_provider.dart';

class InterestGqlProvider {
  Future<MyQueryResponse<List<int>>> create(
      {required List<String> interestsText}) async {
    final mutation = CreateInterestMutation(
      variables: CreateInterestArguments(interestsText: interestsText),
    );
    final result = await graphqlClientService.mutate(mutation);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }
    print(result);
    final root = result.data?['createInterest'];
    final data = List<int>.from(root?['nodes'] ?? []);
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<List<int>>(
      data: data,
      ok: ok,
      errors: errors,
    );
  }

  Future<List<Interest>> search(String partial) async {
    final query = SearchInterestsQuery(
        variables: SearchInterestsArguments(partial: partial));
    final result = await graphqlClientService.query(query);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['searchInterests'];
    final data = List<Interest>.from(root?['nodes']
            ?.map((interest) => Interest.fromGqlData(interest))
            .toList() ??
        []);

    return data;
  }

  Future<MyQueryResponse<List<Interest>>> popular() async {
    final query = PopularInterestsQuery();
    final result = await graphqlClientService.query(query);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['popularInterests'];
    final data = List<Interest>.from(root?['nodes']
            ?.map((interest) => Interest.fromGqlData(interest))
            .toList() ??
        []);
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<List<Interest>>(
      data: data,
      ok: ok,
      errors: errors,
    );
  }
}
