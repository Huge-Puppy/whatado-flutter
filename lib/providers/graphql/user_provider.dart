import 'package:whatado/graphql/mutations_graphql_api.dart';
import 'package:whatado/graphql/queries_graphql_api.dart';
import 'package:whatado/models/event_user.dart';
import 'package:whatado/models/interest.dart';
import 'package:whatado/models/query_response.dart';
import 'package:whatado/models/user.dart';
import 'package:whatado/services/service_provider.dart';

class UserGqlProvider {
  Future<MyQueryResponse<User>> me() async {
    final query = MeQuery();
    final result = await graphqlClientService.query(query);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['me'];
    final data = root != null && root['nodes'] != null
        ? User.fromGqlData(root['nodes'])
        : null;
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<User>(
      ok: ok,
      data: data,
      errors: errors,
    );
  }

  Future<MyQueryResponse<User>> user(int id) async {
    final query = UserQuery(variables: UserArguments(id: id));
    final result = await graphqlClientService.query(query);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['user'];
    final data = root != null && root['nodes'] != null
        ? User.fromGqlData(root['nodes'])
        : null;
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<User>(
      ok: ok,
      data: data,
      errors: errors,
    );
  }

  Future<MyQueryResponse<List<EventUser>>> eventUserPreview(
      List<int> ids) async {
    final query = EventUserPreviewQuery(
        variables: EventUserPreviewArguments(userIds: ids));
    final result = await graphqlClientService.query(query);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['usersById'];
    final data = root != null && root['nodes'] != null
        ? (root['nodes'] as List)
            .map((val) => EventUser.fromGqlData(val))
            .toList()
        : null;
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<List<EventUser>>(
      ok: ok,
      data: data,
      errors: errors,
    );
  }

  Future<MyQueryResponse<bool>> addInterests(List<String> interestsText) async {
    final mutation = AddInterestsMutation(
        variables: AddInterestsArguments(interestsText: interestsText));
    final result = await graphqlClientService.mutate(mutation);
    if (result.hasException) {
      print('client error ${result.exception?.linkException}');
      result.exception?.graphqlErrors.forEach((element) {
        print(element.message);
      });
    }

    final root = result.data?['addInterests'];
    final data = root?['ok'] ?? false;
    final ok = root?['ok'] ?? false;
    final errors = root?['errors'];

    return MyQueryResponse<bool>(
      ok: ok,
      data: data,
      errors: errors,
    );
  }
}
