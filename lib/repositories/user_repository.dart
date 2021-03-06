import 'package:dartz/dartz.dart';
import 'package:runn_wear/models/user.dart';
import 'package:runn_wear/models/user_stats.dart';
import 'package:runn_wear/models/user_stats_by_marathon.dart';
import 'package:runn_wear/providers/user_provider.dart';

class UserRepository {
  final UserProvider userProvider;
  User user;
  UserStats userStats;

  UserRepository({UserProvider userProvider})
      : this.userProvider = userProvider ?? UserProvider();

  Future<Either<Exception, User>> fetchUserDetails(String email,
      {Map filter}) async {
    Either<Exception, Map> either = await userProvider.fetchUserDetails(email);
    return either.map((r) {
      user = User.fromJson(r);
      return user;
    });
  }

  Future<Either<Exception, UserStats>> fetchUserStats(String email,
      {Map filter}) async {
    Either<Exception, Map> either = await userProvider.fetchUserStats(email);
    return either.map((r) => UserStats.fromJson(r));
  }

  Future<Either<Exception, UserStatsByMarathon>> sendUserStatsByMarathon(
      String marathonId, String email, double lat, double long,
      {Map filter}) async {
    Either<Exception, Map> either = await userProvider.sendUserStatsByMarathon(
        marathonId, email, lat, long);
    return either.map((r) => UserStatsByMarathon.fromJson(r));
  }

  Future<Either<Exception, List<UserStatsByMarathon>>> fetchUserStatsByMarathon(
      String marathonId, String email,
      {Map filter}) async {
    Either<Exception, List<Map>> either = await userProvider
        .fetchUserStatsByMarathon(marathonId, email, filter: filter);
    return either
        .map((r) => r.map((e) => UserStatsByMarathon.fromJson(e)).toList());
  }
}
