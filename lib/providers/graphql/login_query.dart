import 'dart:async';

import 'package:whatado/graphql/mutations_graphql_api.dart';
import 'package:whatado/models/query_response.dart';
import 'package:whatado/models/user.dart';
import 'package:whatado/services/service_provider.dart';

class LoginGqlQuery {
  Future<MyQueryResponse<User?>> login(
      {required String email, required String password}) async {
    final mutation = LoginMutation(
      variables: LoginArguments(
        userInput: UserInput(password: password, email: email),
      ),
    );
    final result = await graphqlClientService.mutate(mutation);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['login'];
    final data = User.fromGqlData(root?['nodes']);
    final accessToken = root?['jwt']?['accessToken'];
    final refreshToken = root?['jwt']?['refreshToken'];
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<User?>(
      ok: ok,
      accessToken: accessToken,
      refreshToken: refreshToken,
      data: data,
      errors: errors,
    );
  }
}